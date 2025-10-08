#!/usr/bin/env python3
# -*- coding: utf-8 -*-

total = 0
ratio = 0.
sp = 0


def calculate_percentage(rolling_hash, bf_best, bf_worst):
    """
    计算rolling-hash-based在bf-best和bf-worst之间的百分比位置

    返回值：
    - 如果bf-best和bf-worst相等（包括都为0），返回None表示跳过
    - 否则返回百分比值 (rolling_hash - bf_worst) / (bf_best - bf_worst) * 100
    """
    if bf_worst < 1 and bf_best < 1:
        return None

    global sp

    # 计算百分比
    percentage = 0
    if bf_worst == bf_best:
        percentage = 100.0
        sp += 1
    else:
        percentage = rolling_hash / bf_best * 100
    if percentage < 5:
        print(f'{rolling_hash} {bf_worst} {bf_best}, {percentage}')
    global total
    total += 1
    global ratio
    ratio += rolling_hash
    return percentage


def process_file(filename):
    """处理文件并统计区间分布"""
    percentages = []
    skipped_count = 0
    total_count = 0

    with open(filename, 'r') as f:
        # 跳过第一行（header）
        next(f)

        for line in f:
            total_count += 1
            parts = line.strip().split()

            if len(parts) != 3:
                print(f"警告: 跳过格式不正确的行: {line.strip()}")
                skipped_count += 1
                continue

            try:
                rolling_hash = float(parts[0])
                bf_best = float(parts[1])
                bf_worst = float(parts[2])
            except ValueError:
                print(f"警告: 跳过无法解析的行: {line.strip()}")
                skipped_count += 1
                continue

            # 跳过bf-best和bf-worst都为0或相等的情况
            if bf_best == bf_worst:
                skipped_count += 1
                continue

            percentage = calculate_percentage(rolling_hash, bf_best, bf_worst)
            if percentage is not None:
                percentages.append(percentage)

    return percentages, skipped_count, total_count


def calculate_distribution(percentages, num_groups=100):
    """计算0-100%区间的分布，分为指定数量的组"""
    # 初始化组
    groups = [0] * num_groups
    group_size = 100.0 / num_groups  # 每组的大小

    for p in percentages:
        # 确定属于哪个组
        # 处理边界情况
        if p < 0:
            group_index = 0  # 小于0的归入第一组
        elif p >= 100:
            group_index = num_groups - 1  # 大于等于100的归入最后一组
        else:
            # 修复：使用浮点数除法，然后转换为整数
            group_index = min(int(p / group_size), num_groups - 1)

        groups[group_index] += 1

    # 检查哪些组有数据
    non_empty_groups = [(i, count) for i, count in enumerate(groups) if count > 0]
    print(f"非空组数量: {len(non_empty_groups)}")
    if non_empty_groups:
        print(
            f"最小非空组索引: {non_empty_groups[0][0]} (范围: {non_empty_groups[0][0] * group_size:.2f}%-{(non_empty_groups[0][0] + 1) * group_size:.2f}%)")
        print(
            f"最大非空组索引: {non_empty_groups[-1][0]} (范围: {non_empty_groups[-1][0] * group_size:.2f}%-{(non_empty_groups[-1][0] + 1) * group_size:.2f}%)")

    return groups


def print_results(groups, total_valid, num_groups=100):
    """打印结果"""
    group_size = 100.0 / num_groups

    print("\n" + "=" * 65)
    print("区间分布统计结果")
    print("=" * 65)
    print(f"有效数据总数: {total_valid}")
    print(f"分组数量: {num_groups} (每组 {group_size:.2f}%)")
    print("-" * 65)
    print(f"{'区间范围':<25} {'数量':<10} {'百分比':<10}")
    print("-" * 65)

    for i, count in enumerate(groups):
        start = i * group_size
        end = (i + 1) * group_size
        percentage = (count / total_valid * 100) if total_valid > 0 else 0

        # 根据分组大小调整格式
        if group_size >= 1:
            print(f"{start:>6.2f}% - {end:>6.2f}%{'':<8} {count:<10} {percentage:>6.3f}%")
        else:
            print(f"{start:>7.3f}% - {end:>7.3f}%{'':<6} {count:<10} {percentage:>6.3f}%")

    total = 0
    for i, count in enumerate(groups):
        start = i * group_size
        end = (i + 1) * group_size
        percentage = (count / total_valid * 100) if total_valid > 0 else 0
        total += percentage

        # 根据分组大小调整格式
        if start >= 80:
            if group_size >= 1:
                print(f"{percentage:>6.3f},")
            else:
                print(f"{percentage:>6.3f},")

    print("=" * 65)


def main():
    import sys
    global total
    global ratio
    global sp

    filename = "docker_cmp_log.csv"
    NUM_GROUPS = 100

    try:
        # 处理文件
        percentages, skipped_count, total_count = process_file(filename)

        # 计算分布
        groups = calculate_distribution(percentages, NUM_GROUPS)

        # 打印结果
        print(f"\n总行数（不含header）: {total_count}")
        print(f"跳过的行数: {skipped_count}")
        print(f"有效数据行数: {len(percentages)}")

        if len(percentages) > 0:
            print_results(groups, len(percentages), NUM_GROUPS)

            # 计算小于80%的占比
            below_80_count = sum(1 for p in percentages if p < 80)
            below_80_percentage = (below_80_count / len(percentages)) * 100

            print(f"\n小于80%的数据:")
            print(f"数量: {below_80_count}")
            print(f"占比: {below_80_percentage:.2f}%")

            # 可选：打印一些统计信息
            print(f"\n统计摘要:")
            print(f"最小值: {min(percentages):.2f}%")
            print(f"最大值: {max(percentages):.2f}%")
            print(f"平均值: {sum(percentages) / len(percentages):.2f}%")
            print(f"平均值(ratio): {ratio / total:.2f}")
            print(f"特殊情况: {sp}, 占比: {sp / total:.2f}")
        else:
            print("\n没有有效数据可以统计！")



    except FileNotFoundError:
        print(f"错误: 找不到文件 '{filename}'")
    except Exception as e:
        print(f"错误: {e}")


if __name__ == "__main__":
    main()
