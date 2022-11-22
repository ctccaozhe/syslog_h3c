import re
import IPy

# transfer ip to int
# ip2long 和long2ip如果加了flask缓存，会导致转换速度变得很慢，所以去掉缓存
# @cache.memoize()
def ip2long(ip):
    return IPy.IP(ip).int()


# transfer int to ip
# @cache.memoize()
def long2ip(long):
    return str(IPy.IPint(long))

def isIP(str):
    p = re.compile('^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$')
    if p.match(str):
        return True
    else:
        return False

def getNonRepeatList(data):
    """
    数组去重
    """
    return list(set(data))

def get_list_content(nums):
    """
    统计数组中出现的重复数
    """
    a = {}
    for i in nums:
        a[i] = nums.count(i)
    return a

# @cache.memoize()
def more_time(time_array):
    """
    :param time_array 输入时间数组，获取最晚的时间
    """
    return_time = None
    for time in time_array:
        if return_time == None:
            return_time = time
        if return_time < time:
            return_time = time
    return return_time


# 数组转字符串
def arr_to_str(arr, arr_type):
    """
    :param arr 数组
    :param arr_type 转成字符串每个数组中的隔符
    :return 数组转成字符串的内容
    """
    return arr_type.join(str(i) for i in arr)


# 拆分数组
def list_split(items, n):
    return [items[i:i + n] for i in range(0, len(items), n)]
