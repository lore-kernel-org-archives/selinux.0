Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j738aVgA003675
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2005 04:36:31 -0400 (EDT)
Received: from mail.perevotech.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j738SpEY006156
	for <selinux@tycho.nsa.gov>; Wed, 3 Aug 2005 08:28:52 GMT
Subject: BackupPC and Selinux
From: Daniela Gradim <daniela.gradim@fortevisiomedica.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Aug 2005 10:29:20 +0200
Message-Id: <1123057760.5701.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi !!!

I reinstall my BackupPC server but now I have one problem when I try to
connect that server Error: Unable to connect to BackupPC server. I have
installed FC4 and selinux-policy-targeted-1.25.3-6. When I check my
audit log I have many kinds of AVC. What shall I do to make this
working.

type=AVC_PATH msg=audit(1123052401.490:14046033):  path="/dev/console"
type=CWD msg=audit(1123052401.490:14046033):  cwd="/home/users/backuppc"
type=PATH msg=audit(1123052401.490:14046033): item=0 name="/bin/ping"
flags=101 inode=59080709 dev=09:01 mode=0104755 ouid=0 ogid=0 rdev=00:00
type=PATH msg=audit(1123052401.490:14046033): item=1 flags=101
inode=23531242 dev=09:01 mode=0100755 ouid=0 ogid=0 rdev=00:00
type=AVC msg=audit(1123052403.947:14059893): avc:  denied  { use } for
pid=17525 comm="ping" name="console" dev=tmpfs ino=2614
scontext=system_u:system_r:ping_t tcontext=system_u:system_r:init_t
tclass=fd

type=AVC msg=audit(1123055904.817:14334333): avc:  denied  { ioctl } for
pid=20401 comm="httpd" name="Lib.pm" dev=md1 ino=70811835
scontext=system_u:system_r:httpd_t
tcontext=root:object_r:httpd_sys_script_exec_t tclass=file
type=SYSCALL msg=audit(1123055904.817:14334333): arch=40000003
syscall=54 success=no exit=-13 a0=1 a1=5401 a2=bfd1bbc8 a3=bfd1bc08
items=0 pid=20401 auid=4294967295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm="httpd" exe="/usr/sbin/httpd"
type=AVC_PATH msg=audit(1123055904.817:14334333):
path="/home/httpd/html/BackupPC/lib/BackupPC/Lib.pm"
type=AVC msg=audit(1123055904.899:14334889): avc:  denied  { ioctl } for
pid=2\0401 comm="httpd" name="Lib.pm" dev=md1 ino=70811823
scontext=system_u:system_r\:httpd_t
tcontext=root:object_r:httpd_sys_script_exec_t tclass=file
type=SYSCALL msg=audit(1123055904.899:14334889): arch=40000003
syscall=54 succe\ss=no exit=-13 a0=1 a1=5401 a2=bfd1bbc8 a3=bfd1bc08
items=0 pid=20401 auid=4294\967295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm\="httpd" exe="/usr/sbin/httpd"
type=AVC_PATH msg=audit(1123055904.899:14334889):
path="/home/httpd/html/Backu\pPC/lib/BackupPC/CGI/Lib.pm"
type=AVC msg=audit(1123055904.961:14334904): avc:  denied  { ioctl } for
pid=2\0401 comm="httpd" name="config.pl" dev=md1 ino=70812030
scontext=system_u:syste\m_r:httpd_t
tcontext=root:object_r:httpd_sys_script_exec_t tclass=file
type=SYSCALL msg=audit(1123055904.961:14334904): arch=40000003
syscall=54 succe\ss=no exit=-13 a0=1 a1=5401 a2=bfd1c0f8 a3=bfd1c138
items=0 pid=20401 auid=4294\967295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm\="httpd" exe="/usr/sbin/httpd"
type=AVC_PATH msg=audit(1123055904.961:14334904):
path="/home/httpd/html/Backu\pPC/data/conf/config.pl"
type=AVC msg=audit(1123055904.968:14334926): avc:  denied  { ioctl } for
pid=2\0401 comm="httpd" name="en.pm" dev=md1 ino=70811804
scontext=system_u:system_r:\httpd_t
tcontext=root:object_r:httpd_sys_script_exec_t tclass=file
type=SYSCALL msg=audit(1123055904.968:14334926): arch=40000003
syscall=54 succe\ss=no exit=-13 a0=1 a1=5401 a2=bfd1c0f8 a3=bfd1c138
items=0 pid=20401 auid=4294\967295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm\="httpd" exe="/usr/sbin/httpd"
type=AVC_PATH msg=audit(1123055904.968:14334926):
path="/home/httpd/html/Backu\pPC/lib/BackupPC/Lang/en.pm"
type=AVC msg=audit(1123055904.980:14334955): avc:  denied  { ioctl } for
pid=2\0401 comm="httpd" name="hosts" dev=md1 ino=70812028
scontext=system_u:system_r:\httpd_t
tcontext=root:object_r:httpd_sys_script_exec_t tclass=file
type=SYSCALL msg=audit(1123055904.980:14334955): arch=40000003
syscall=54 succe\ss=no exit=-13 a0=1 a1=5401 a2=bfd1c148 a3=bfd1c188
items=0 pid=20401 auid=4294\967295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm\="httpd" exe="/usr/sbin/httpd"
type=AVC_PATH msg=audit(1123055904.980:14334955):
path="/home/httpd/html/Backu\pPC/data/conf/hosts"
type=AVC msg=audit(1123055904.982:14334964): avc:  denied  { ioctl } for
pid=20401 comm="httpd" name="GeneralInfo.pm" dev=md1 ino=70811807
scontext=system_u:\system_r:httpd_t
tcontext=root:object_r:httpd_sys_script_exec_t tclass=file
type=SYSCALL msg=audit(1123055904.982:14334964): arch=40000003
syscall=54 succe\ss=no exit=-13 a0=1 a1=5401 a2=bfd1c0f8 a3=bfd1c138
items=0 pid=20401 auid=4294\967295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm\="httpd" exe="/usr/sbin/httpd"
type=AVC_PATH msg=audit(1123055904.982:14334964):
path="/home/httpd/html/Backu\pPC/lib/BackupPC/type=AVC msg=audit
(1123057381.490:15261737): avc:  denied  { lock } for  pid=20\404
comm="httpd" name="LOCK" dev=md1 ino=70811933
scontext=system_u:system_r:ht\tpd_t
tcontext=system_u:object_r:httpd_sys_script_exec_t tclass=file
type=SYSCALL msg=audit(1123057381.490:15261737): arch=40000003
syscall=143 succ\ess=no exit=-13 a0=0 a1=2 a2=10ebbc0 a3=9ad4700 items=0
pid=20404 auid=42949672\95 uid=501 gid=48 euid=501 suid=501 fsuid=501
egid=48 sgid=48 fsgid=48 comm="ht\tpd" exe="/usr/sbin/httpd"
type=AVC_PATH msg=audit(1123057381.490:15261737):
path="/home/httpd/html/Backu\pPC/data/pc/7r04b0j/LOCK"
type=AVC msg=audit(1123057387.694:15262203): avc:  denied  { write } for
pid=2\0404 comm="httpd" name="BackupPC.sock" dev=md1 ino=70811920
scontext=system_u:s\ystem_r:httpd_t
tcontext=system_u:object_r:httpd_sys_script_exec_t tclass=sock_\file
type=SYSCALL msg=audit(1123057387.694:15262203): arch=40000003
syscall=102 succ\ess=no exit=-13 a0=3 a1=bfd1c490 a2=10ebbc0 a3=6e
items=1 pid=20404 auid=429496\7295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm="\httpd" exe="/usr/sbin/httpd"
type=SOCKADDR msg=audit(1123057387.694:15262203):
saddr=01002F686F6D652F6874747
\0642F68746D6C2F4261636B757050432F646174612F6C6F672F4261636B757050432E736F636B00\0000000000000000000000000000000000000000000000000000000000000000000000000000000\000000000000000000000000000000000000000
type=SOCKETCALL msg=audit(1123057387.694:15262203): nargs=3 a0=1
a1=9e9c5c8 a2=\6e
type=PATH msg=audit(1123057387.694:15262203): item=0 flags=1
inode=70811920 de\v=09:01 mode=0140750 ouid=501 ogid=3 rdev=00:00
CGI/GeneralInfo.pm"
type=AVC msg=audit(1123055904.988:14334976): avc:  denied  { write } for
pid=2\0401 comm="httpd" name="BackupPC.sock" dev=md1 ino=70811920
scontext=system_u:s\ystem_r:httpd_t
tcontext=system_u:object_r:httpd_sys_script_exec_t tclass=sock_\file
type=SYSCALL msg=audit(1123055904.988:14334976): arch=40000003
syscall=102 succ\ess=no exit=-13 a0=3 a1=bfd1c490 a2=10ebbc0 a3=6e
items=1 pid=20401 auid=429496\7295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm="\httpd" exe="/usr/sbin/httpd"
type=SOCKADDR msg=audit(1123055904.988:14334976):
saddr=01002F686F6D652F6874747
\0642F68746D6C2F4261636B757050432F646174612F6C6F672F4261636B757050432E736F636B00\0000000000000000000000000000000000000000000000000000000000000000000000000000000\000000000000000000000000000000000000000
type=SOCKETCALL msg=audit(1123055904.988:14334976): nargs=3 a0=1
a1=9e67f28 a2=\6e
type=PATH msg=audit(1123055904.988:14334976): item=0 flags=1
inode=70811920 de\v=09:01 mode=0140750 ouid=501 ogid=3 rdev=00:00
type=AVC msg=audit(1123055907.166:14335286): avc:  denied  { write } for
pid=2\0401 comm="httpd" name="BackupPC.sock" dev=md1 ino=70811920
scontext=system_u:s\ystem_r:httpd_t
tcontext=system_u:object_r:httpd_sys_script_exec_t tclass=sock_\file
type=SYSCALL msg=audit(1123055907.166:14335286): arch=40000003
syscall=102 succ\ess=no exit=-13 a0=3 a1=bfd1c490 a2=10ebbc0 a3=6e
items=1 pid=20401 auid=429496\7295 uid=501 gid=48 euid=501 suid=501
fsuid=501 egid=48 sgid=48 fsgid=48 comm="\httpd" exe="/usr/sbin/httpd"
type=SOCKADDR msg=audit(1123055907.166:14335286):
saddr=01002F686F6D652F6874747
\0642F68746D6C2F4261636B757050432F646174612F6C6F672F4261636B757050432E736F636B00\0000000000000000000000000000000000000000000000000000000000000000000000000000000\000000000000000000000000000000000000000
type=SOCKETCALL msg=audit(1123055907.166:14335286): nargs=3 a0=d
a1=9e7ea88 a2=\6e
type=PATH msg=audit(1123055907.166:14335286): item=0 flags=1
inode=70811920 de\v=09:01 mode=0140750 ouid=501 ogid=3 rdev=00:00

-- 
--  
Daniela Gradim 
B.Sc.

daniela.gradim@fortevisiomedica.com 
Mobile phone: +46-(0)765-48 99 95

---------------------------------------------------------------------  
Forte Visio Medica AB 
Hammarby Fabriksväg 23 
S-120 33 Stockholm 
Sweden

Phone: +46-(0)8-440 03 00 
Fax: +46-(0)765-310 100 
--------------------------------------------------------------------- 
THIS COMMUNICATION IS ONLY INTENDED FOR THE USE OF THE INDIVIDUAL, OR 
ENTITY, TO WHICH IT IS DIRECTED AND MAY CONTAIN INFORMATION THAT IS 
PRIVILIGED, CONFIDENTIAL AND EXEMPT FROM DISCLOSURE UNDER APPLICABLE 
LAW. IF RECEIVED IN ERROR: PLEASE NOTIFY US IMMEDIATELY THROUGH 
info@fortevisiomedica.com. 
---------------------------------------------------------------------


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
