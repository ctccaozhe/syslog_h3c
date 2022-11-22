import datetime
import socket
import time
from datetime import date
from models import *
from function import *
import IPy

udp = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
udp.bind(('0.0.0.0', 513))
serverity = ["Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Info", "Debug"]  # 日志等级对应英文


def get_office_network(msg, log_base_sid):
    msgs = msg.split(": ")
    traffic_information = {}
    my_msgs = ""
    for index, i in enumerate(msgs):
        if index != 0:
            if index == 1:
                my_msgs = my_msgs + i
            else:
                my_msgs = my_msgs + ": " + i
    for i in my_msgs.split(";"):
        key_value = i.split("=")
        traffic_information[key_value[0]] = key_value[1]

    IPv6_type = False
    # 暂时不处理ipv6
    if "src_ip" in traffic_information and "dst_ip" in traffic_information:
        if IPy.IP(traffic_information["src_ip"]).version() == 6 or IPy.IP(traffic_information["dst_ip"]).version() == 6:
            IPv6_type = True
    elif "uip" in traffic_information:
        if IPy.IP(traffic_information["uip"]).version() == 6:
            IPv6_type = True
    if IPv6_type:
        return

    if "statistic_traffic" in msgs[0]:
        if IPy.IP(traffic_information["uip"]).version() == 6:
            pass
        office_ac_statistic_traffic_log = OfficeAcStatisticTrafficLog(
            user_name=traffic_information["user_name"],
            ugname=traffic_information["ugname"],
            umac=traffic_information["umac"],
            uip=ip2long(traffic_information["uip"]),
            appname=traffic_information["appname"],
            appgname=traffic_information["appgname"],
            up=traffic_information["up"],
            down=traffic_information["down"],
            create_time=traffic_information["create_time"],
            end_time=traffic_information["end_time"],
            log_base_ook=log_base_sid
        )
        session.add(office_ac_statistic_traffic_log)
        # 记录用户表
        office_ip_mac_users = session.query(OfficeIpMacUser).filter(
            OfficeIpMacUser.user_name == traffic_information["user_name"]).all()
        if "@" in traffic_information["user_name"]:
            name = traffic_information["user_name"].split("@")[0]
        else:
            name = "匿名"
        if not office_ip_mac_users:
            office_ip_mac_user = OfficeIpMacUser(
                user_name=traffic_information["user_name"],
                name=name,
                ip=ip2long(traffic_information["uip"]),
                mac=traffic_information["umac"],
                ugname=traffic_information["ugname"],
            )
            session.add(office_ip_mac_user)
        else:
            is_now_eq = True
            for office_ip_mac_user in office_ip_mac_users:
                if traffic_information["umac"] == office_ip_mac_user.mac or ip2long(
                        traffic_information["uip"]) == office_ip_mac_user.ip:
                    is_now_eq = False
                    office_ip_mac_user.update_time = datetime.datetime.now()
                    session.commit()
                    break  # 存在数据库里，更新一下时间直接过，不用再匹配了
            if is_now_eq:
                office_ip_mac_user = OfficeIpMacUser(
                    user_name=traffic_information["user_name"],
                    ip=ip2long(traffic_information["uip"]),
                    name=name,
                    mac=traffic_information["umac"],
                    ugname=traffic_information["ugname"],
                )
                session.add(office_ip_mac_user)
    elif "web_access" in msgs[0]:
        office_ac_web_access_log = OfficeAcWebAccessLog(
            user_name=traffic_information["user_name"],
            ugname=traffic_information["user_group_name"],
            term_platform=traffic_information["term_platform"],
            term_device=traffic_information["term_device"],
            src_ip=ip2long(traffic_information["src_ip"]),
            dst_ip=ip2long(traffic_information["dst_ip"]),
            url_domain=traffic_information["url_domain"],
            url=traffic_information["url"],
            url_cate_name=traffic_information["url_cate_name"],
            handle_action=int(traffic_information["handle_action"]),
            msg=traffic_information["msg"],
            log_base_ook=log_base_sid
        )
        session.add(office_ac_web_access_log)
    elif "file_transfer" in msgs[0]:
        # print("file_transfer", traffic_information)
        office_ac_other_app_log = OfficeAcFileTransferLog(
            user_name=traffic_information["user_name"],
            ugname=traffic_information["user_group_name"],
            term_platform=traffic_information["term_platform"],
            term_device=traffic_information["term_device"],
            pid=int(traffic_information["pid"]),
            src_mac=traffic_information["src_mac"],
            src_ip=ip2long(traffic_information["src_ip"]),
            dst_ip=ip2long(traffic_information["dst_ip"]),
            dst_port=int(traffic_information["dst_port"]),
            app_name=traffic_information["app_name"],
            app_cat_name=traffic_information["app_cat_name"],
            handle_action=int(traffic_information["handle_action"]),
            account=traffic_information["account"],
            action_name=traffic_information["action_name"],
            file_name=traffic_information["file_name"],
            msg=traffic_information["msg"],
            log_base_ook=log_base_sid
        )
        session.add(office_ac_other_app_log)
    elif "device_traffic" in msgs[0]:
        # print("device_traffic", traffic_information)
        pass
    elif "device_health" in msgs[0]:
        # print("device_health", traffic_information)
        pass
    elif "other_app" in msgs[0] or "social_log" in msgs[0] or "search_engine" in msgs[0]:
        office_ac_file_transfer_log = OfficeAcOtherApp(
            user_name=traffic_information["user_name"],
            ugname=traffic_information["user_group_name"],
            term_platform=traffic_information["term_platform"],
            term_device=traffic_information["term_device"],
            pid=int(traffic_information["pid"]),
            src_mac=traffic_information["src_mac"],
            src_ip=ip2long(traffic_information["src_ip"]),
            dst_ip=ip2long(traffic_information["dst_ip"]),
            dst_port=int(traffic_information["dst_port"]),
            app_name=traffic_information["app_name"],
            app_cat_name=traffic_information["app_cat_name"],
            handle_action=int(traffic_information["handle_action"]),
            account=traffic_information["account"],
            action_name=traffic_information["action_name"],
            content=traffic_information["content"],
            msg=traffic_information["msg"],
            log_base_ook=log_base_sid
        )
        session.add(office_ac_file_transfer_log)
        pass
    elif "mail" in msgs[0]:
        print("device_health", traffic_information)
        office_ac_mail = OfficeAcMail(
            user_name=traffic_information["user_name"],
            ugname=traffic_information["user_group_name"],
            term_platform=traffic_information["term_platform"],
            term_device=traffic_information["term_device"],
            pid=int(traffic_information["pid"]),
            src_mac=traffic_information["src_mac"],
            src_ip=ip2long(traffic_information["src_ip"]),
            dst_ip=ip2long(traffic_information["dst_ip"]),
            dst_port=int(traffic_information["dst_port"]),
            app_name=traffic_information["app_name"],
            app_cat_name=traffic_information["app_cat_name"],
            handle_action=int(traffic_information["handle_action"]),
            account=traffic_information["account"],
            action_name=traffic_information["action_name"],
            send_addr=traffic_information["send_addr"],
            receive_addr=traffic_information["receive_addr"],
            subject=traffic_information["subject"],
            file_name=traffic_information["file_name"],
            file_size=traffic_information["file_size"],
            content=traffic_information["content"],
            msg=traffic_information["msg"],
            log_base_ook=log_base_sid
        )
        session.add(office_ac_mail)
    else:
        print("未知", msg)
    session.commit()


def run():
    while True:
        session.commit()
        rec_msg, addr = udp.recvfrom(2048)
        client_ip, client_port = addr  # 客户端ip与端口
        rec_msg_str = rec_msg.rstrip(b'\x00').decode('utf-8', 'ignore')  # 日志原始内容
        pri = int(rec_msg_str.split(">")[0][1:100])  # 日志等级
        # 对应等级
        try:
            pri_info = serverity[pri]
        except IndexError:
            pri_info = None

        # 保存到数据库
        log_base = LogBase(
            client_ip=ip2long(client_ip),
            pri=pri,
            levinfo=pri_info,
            msg=rec_msg_str
        )
        session.add(log_base)
        session.commit()

        # 触发syslog日志分析
        if pri == 6 and "H3C" in rec_msg_str.split(": ")[0]:  # 开始分析H3C，ac的syslog日志
            get_office_network(rec_msg_str, log_base.sid)

        # 保存到文件
        msg = client_ip + " " + rec_msg_str
        # print('msg from client:', msg)
        filename = client_ip + '_' + str(date.today()) + ".log"
        with open(filename, 'a+', encoding="utf-8") as f:
            f.write(msg + "\n")


if __name__ == '__main__':
    run()
