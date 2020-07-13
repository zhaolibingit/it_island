# centos7 系统初始化

```text
# 配置hostname
hostnamectl  set-hostname  master


# 配置ip
cat > /etc/sysconfig/network-scripts/ifcfg-eno16777736 << EOF
TYPE="Ethernet"
BOOTPROTO="static"
NAME="eno16777736"
DEVICE="eno16777736"
ONBOOT="yes"
IPADDR="10.0.11.205"
GATEWAY="10.0.11.2"
NETMASK="255.255.255.0"
EOF
systemctl restart network

# 配置dns
echo "nameserver 223.6.6.6" > /etc/resolv.conf

# 配置yum源为aliyun
cd /etc/yum.repos.d
mv * /tmp
rpm -ivh http://source.zhaolibin.com/scripts/wget-1.14-10.el7_0.1.x86_64.rpm
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum clean all
yum makecache

# 防火墙
systemctl status iptables
systemctl status firewalld
systemctl stop firewalld
systemctl disable firewalld
systemctl status firewalld
yum -y install iptables-services
systemctl  start iptables
systemctl  enable iptables
iptables -F
service iptables save

# selinux 关闭
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
setenforce 0

# 打开文件数
sed -i '/# End of file/i\*\t\t-\tnofile\t\t65535' /etc/security/limits.conf
cat /etc/security/limits.conf
ulimit -HSn 65535
ulimit -n

# 内核参数调整
echo 'net.ipv4.ip_forward = 1' > /etc/sysctl.conf
echo 'net.ipv4.tcp_timestamps = 1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_tw_recycle = 1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_fin_timeout = 30' >> /etc/sysctl.conf
sysctl -p

# 修改时区同步时间
rm -rf /etc/localtime
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
yum install ntpdate -y
echo "*/5 * * * * /usr/sbin/ntpdate -u 0.asia.pool.ntp.org"  >> /var/spool/cron/root


# 关闭不需要的服务
systemctl stop postfix
systemctl disable postfix

# 安装基本工具包
yum update
yum install -y bash-completion  #system自动补全包
yum install -y vim wget lrzsz lsof net-tools
yum install -y conntrack ntp ipvsadm ipset jq iptables curl sysstat libseccomp git

```

