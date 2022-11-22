# coding: utf-8
import sqlalchemy as sa
from sqlalchemy import Integer, ForeignKey, String, Text
from sqlalchemy import VARCHAR, Column, text
from sqlalchemy import orm
from sqlalchemy.dialects.mssql import TINYINT
from sqlalchemy.dialects.mysql import BIGINT, TEXT
from sqlalchemy.dialects.mysql import INTEGER
from sqlalchemy.dialects.mysql import LONGTEXT, TIMESTAMP
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()
metadata = Base.metadata
engine = sa.create_engine('mysql+pymysql://syslog:XXxxxXX@192.168.20.19:3306/syslog')
session = orm.scoped_session(orm.sessionmaker())(bind=engine)

class LogBase(Base):
    __tablename__ = 'log_base'

    sid = Column(INTEGER, primary_key=True, comment='序号')
    client_ip = Column(INTEGER, nullable=False, index=True, comment='客户端IP')
    pri = Column(Integer, comment='日志等级int')
    levinfo = Column(VARCHAR(255), index=True, comment='日志等级')
    msg = Column(LONGTEXT, comment='日志信息')
    input_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"), comment='入库时间')


class OfficeAcMail(Base):
    __tablename__ = 'office_ac_mail'

    sid = Column(INTEGER, primary_key=True, comment='序号')
    user_name = Column(VARCHAR(255), comment='用户名')
    ugname = Column(VARCHAR(255), comment='用户分组')
    term_platform = Column(VARCHAR(255), comment='系统平台')
    term_device = Column(VARCHAR(255), comment='设备类型')
    pid = Column(Integer, comment='pid')
    src_mac = Column(VARCHAR(255), comment='访问源mac')
    src_ip = Column(INTEGER, comment='访问源ip')
    dst_ip = Column(INTEGER, comment='访问到ip')
    dst_port = Column(Integer, comment='访问到端口')
    app_name = Column(VARCHAR(255), comment='程序名')
    app_cat_name = Column(VARCHAR(255), comment='程序类型')
    handle_action = Column(Integer, comment='句柄')
    account = Column(VARCHAR(255))
    action_name = Column(VARCHAR(255), comment='接收、发送')
    send_addr = Column(String(255), comment='发件地址')
    receive_addr = Column(String(255), comment='接收地址')
    subject = Column(Text, comment='邮件内容')
    content = Column(String(255))
    file_name = Column(TEXT, comment='文件名')
    file_size = Column(Integer)
    msg = Column(TEXT, comment='信息')
    input_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"), comment='入库时间')
    log_base_ook = Column(INTEGER, comment='对应原始日志id')


class OfficeIpMacUser(Base):
    __tablename__ = 'office_ip_mac_user'
    __table_args__ = {'comment': '办公网ip对应mac地址以及用户名数据库'}

    sid = Column(INTEGER, primary_key=True, comment='序号')
    ugname = Column(String(255), index=True, comment='用户分组')
    name = Column(VARCHAR(255), index=True, server_default=text("'匿名'"), comment='名称')
    user_name = Column(String(255), index=True, comment='用户名')
    ip = Column(INTEGER, index=True, comment='IP')
    mac = Column(String(255), index=True, comment='mac')
    input_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"), comment='开始活跃时间')
    update_time = Column(TIMESTAMP, index=True, server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"), comment='最近活跃时间')


class UserInfo(Base):
    __tablename__ = 'user_info'
    __table_args__ = {'comment': '用户注册信息'}

    id = Column(INTEGER, primary_key=True, comment='用户id')
    username = Column(VARCHAR(25), nullable=False, comment='用户名')
    password_hash = Column(VARCHAR(128), nullable=False, comment='密码')
    email = Column(VARCHAR(100), nullable=False, comment='邮箱号')
    role = Column(TINYINT, server_default=text("'1'"), comment='用户角色，1管理员，2普通用户，3其他')
    registration_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"), comment='注册时间')
    is_valid = Column(TINYINT, server_default=text("'1'"), comment='数据是否有效，0无效，1有效')


class OfficeAcFileTransferLog(Base):
    __tablename__ = 'office_ac_file_transfer_log'
    __table_args__ = {'comment': '办公网wifi_ac文件流量表'}

    sid = Column(INTEGER, primary_key=True, index=True, comment='序号')
    user_name = Column(VARCHAR(255), index=True, comment='用户名')
    ugname = Column(VARCHAR(255), index=True, comment='用户分组')
    term_platform = Column(VARCHAR(255), index=True, comment='系统平台')
    term_device = Column(String(255), index=True, comment='设备类型')
    pid = Column(Integer, comment='pid')
    src_mac = Column(String(255), index=True, comment='访问源mac')
    src_ip = Column(INTEGER, index=True, comment='访问源ip')
    dst_ip = Column(INTEGER, index=True, comment='访问到ip')
    dst_port = Column(Integer, comment='访问到端口')
    app_name = Column(VARCHAR(255), index=True, comment='程序名')
    app_cat_name = Column(VARCHAR(255), index=True, comment='程序类型')
    handle_action = Column(Integer, comment='句柄')
    account = Column(VARCHAR(255))
    action_name = Column(String(255), index=True, comment='接收、发送')
    file_name = Column(Text, index=True, comment='文件名')
    msg = Column(Text, comment='信息')
    input_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"), comment='入库时间')
    log_base_ook = Column(ForeignKey('log_base.sid', ondelete='SET NULL'), index=True, comment='对应原始日志id')

    log_base = relationship('LogBase')


class OfficeAcOtherApp(Base):
    __tablename__ = 'office_ac_other_app'
    __table_args__ = {'comment': '其它app日志表'}

    sid = Column(INTEGER, primary_key=True, index=True, comment='序号')
    user_name = Column(VARCHAR(255), index=True, comment='用户名')
    ugname = Column(VARCHAR(255), index=True, comment='用户分组')
    term_platform = Column(VARCHAR(255), index=True, comment='系统平台')
    term_device = Column(VARCHAR(255), index=True, comment='设备类型')
    pid = Column(Integer, comment='pid')
    src_mac = Column(VARCHAR(255), index=True, comment='访问源mac')
    src_ip = Column(INTEGER, comment='访问源ip')
    dst_ip = Column(INTEGER, comment='访问到ip')
    dst_port = Column(Integer, comment='访问到端口')
    app_name = Column(VARCHAR(255), index=True, comment='程序名')
    app_cat_name = Column(VARCHAR(255), index=True, comment='程序类型')
    handle_action = Column(Integer, comment='句柄')
    account = Column(VARCHAR(255))
    action_name = Column(VARCHAR(255), comment='接收、发送')
    content = Column(String(255), index=True)
    msg = Column(TEXT, comment='信息')
    input_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"), comment='入库时间')
    log_base_ook = Column(ForeignKey('log_base.sid', ondelete='SET NULL', onupdate='RESTRICT'), index=True, comment='对应原始日志id')

    log_base = relationship('LogBase')


class OfficeAcStatisticTrafficLog(Base):
    __tablename__ = 'office_ac_statistic_traffic_log'
    __table_args__ = {'comment': '办公网wifi_ac流量日志表'}

    sid = Column(INTEGER, primary_key=True, index=True, comment='序号')
    user_name = Column(VARCHAR(255), index=True, comment='用户名')
    ugname = Column(VARCHAR(255), index=True, comment='用户分组')
    umac = Column(VARCHAR(255), index=True, comment='用户mac')
    uip = Column(INTEGER, index=True, comment='用户IP')
    appname = Column(VARCHAR(255), index=True, comment='协议类型')
    appgname = Column(VARCHAR(255), index=True, comment='访问类型')
    up = Column(INTEGER, comment='上传流量')
    down = Column(INTEGER, comment='下载流量')
    create_time = Column(Integer, comment='上传时间戳')
    end_time = Column(Integer, comment='下载时间戳')
    input_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"), comment='入库时间')
    log_base_ook = Column(ForeignKey('log_base.sid', ondelete='SET NULL'), index=True, comment='对应原始日志id')

    log_base = relationship('LogBase')


class OfficeAcWebAccessLog(Base):
    __tablename__ = 'office_ac_web_access_log'
    __table_args__ = {'comment': '办公网wifi_ac，web访问日志表'}

    sid = Column(INTEGER, primary_key=True, index=True, comment='序号')
    user_name = Column(VARCHAR(255), index=True, comment='用户名')
    ugname = Column(VARCHAR(255), index=True, comment='用户分组')
    term_platform = Column(VARCHAR(255), index=True, comment='系统平台')
    term_device = Column(String(255), index=True, comment='设备类型')
    src_ip = Column(INTEGER, index=True, comment='访问源ip')
    dst_ip = Column(INTEGER, index=True, comment='访问到ip')
    url_domain = Column(String(255), index=True, comment='访问域名')
    url = Column(String(255), index=True, comment='访问url')
    url_cate_name = Column(String(255), index=True, comment='url类型')
    handle_action = Column(Integer, comment='句柄')
    msg = Column(Text, comment='信息')
    input_time = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"), comment='入库时间')
    log_base_ook = Column(ForeignKey('log_base.sid', ondelete='SET NULL'), index=True, comment='对应原始日志id')

    log_base = relationship('LogBase')
