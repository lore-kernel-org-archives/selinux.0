Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0I2ehqs010256
	for <selinux@tycho.nsa.gov>; Sun, 17 Jan 2010 21:40:43 -0500
Received: from bay0-omc3-s3.bay0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0I2dLfD007355
	for <selinux@tycho.nsa.gov>; Mon, 18 Jan 2010 02:39:21 GMT
Message-ID: <BAY111-W27B5C0DF57292CB495990DAB660@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_65195296-6e24-4e49-9474-c2577bb070ef_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Bootup problem with refpolicy-2.20091117
Date: Mon, 18 Jan 2010 02:40:42 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_65195296-6e24-4e49-9474-c2577bb070ef_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi SELinux experts,

This is my very first time to try out the latest refpolicy-2.20091117 and I am unable to boot SELinux up normally, in the very end the console will hang with messages like:
INIT: Id "0" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel
INIT: Id "0" respawning too fast: disabled for 5 minutes

Aside from this, there are some strange error messages like "Starting udev: MAKEDEV: mkdir: File exists" and some AVC denied messages (detailed log is appended at the last).

However, I could boot up SELinux with refpolicy-2.20081210 successfully, what I do is to first boot Linux kernel into a shell and load SELinux policy image then label the whole filesystem, second boot into /sbin/init as normal. The SELinux userspace tools I am using are:
libsepol-2.0.36
libselinux-2.0.79
libsemanage-2.0.31
policycoreutils-2.0.62
checkpolicy-2.0.19
sepolgen-1.0.16

The kernel I am using is 2.6.27, Stephen kindly pointed out a SELinux kernel bug six months ago when I had a problem to boot up refpolicy-2.20081210, which should be fixed by the commit of "SELinux: check open perms in dentry_open not inode_permission", or bypassed by diabling the open_perms in policy_capabilities. 

The same set of kernel and rootfs work well for refpolicy-2.20081210 but do not for refpolicy-2.20091117, I wonder what changes could make a difference? What should I have done in order to use the latest refpolicy-2.20091117? Any extra SELinux kernel commits I should port back to 2.6.27, or do I need to update SELinux userspace tools to the latest as well?

Any comment is greatly appreciated! Thank you very much for your help!

Best regards,
Harry

-----------
...
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 296k freed
type=1404 audit(1263731960.249:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
type=1403 audit(1263731961.676:3): policy loaded auid=4294967295 ses=4294967295
INIT: version 2.86 booting
type=1400 audit(1263731962.260:4): avc:  denied  { read } for  pid=960 comm="modprobe" name="console" dev=sda1 ino=244841 scontext=system_u:system_r:insmod_t:s0-s15:c0.c255 tcontext=system_u:object_r:console_device_t:s0 tclass=chr_file
type=1400 audit(1263731962.307:5): avc:  denied  { read } for  pid=960 comm="modprobe" path="/dev/console" dev=sda1 ino=244841 scontext=system_u:system_r:insmod_t:s0-s15:c0.c255 tcontext=system_u:object_r:console_device_t:s0 tclass=chr_file
Starting udev: MAKEDEV: mkdir: File exists
[  OK  ]
Setting hostname cp3020:  [  OK  ]
DM multipath kernel driver not loaded
No devices found
Checking filesystems
Checking all file systems.
[  OK  ]
can't create lock file /var/lock/mtab~2002: Permission denied (use -n flag to override)
Mounting local filesystems:  mount: sysfs already mounted or /sys busy
mount: devpts already mounted or /dev/pts busy
can't create lock file /var/lock/mtab~2007: Permission denied (use -n flag to override)
[FAILED]
Enabling local filesystem quotas:  [  OK  ]

*** Warning -- SELinux wr-strict policy relabel is required.
*** Relabeling could take a very long time, depending on file
*** system size and speed of hard drives.
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting enterprise event logger: [  OK  ]
Starting remote event logger: [  OK  ]
Starting syslog-ng: [FAILED]
Starting ipmi drivers: [  OK  ]
iscsid is stopped
iSCSI daemon not running.
Starting portmap: [  OK  ]
Mounting other filesystems:  mount: sysfs already mounted or /sys busy
mount: devpts already mounted or /dev/pts busy
can't create lock file /var/lock/mtab~2158: Permission denied (use -n flag to override)
[FAILED]
Starting sshd: [  OK  ]
Starting xinetd: [  OK  ]
Starting iSCSI daemon: [  OK  ]
[  OK  ]
Starting enterprise event log notification: [  OK  ]
Starting sendmail: [  OK  ]
Starting sm-client: /etc/rc3.d/S80sendmail: line 71: /sbin/restorecon: No such file or directory
[  OK  ]
Starting boa: [  OK  ]
Starting crond: [  OK  ]
Starting notification action daemon: [  OK  ]
Starting atd: [FAILED]
INIT: Id "0" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel
INIT: Id "0" respawning too fast: disabled for 5 minutes
INIT: Id "0" respawning too fast: disabled for 5 minutes
INIT: Id "0" respawning too fast: disabled for 5 minutes
... 		 	   		  
_________________________________________________________________
MSN十周年庆典，查看MSN注册时间，赢取神秘大奖
http://10.msn.com.cn
--_65195296-6e24-4e49-9474-c2577bb070ef_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Verdana
}
--></style>
</head>
<body class='hmmessage'>
Hi SELinux experts,<br><br>This is my very first time to try out the latest refpolicy-2.20091117 and I am unable to boot SELinux up normally, in the very end the console will hang with messages like:<br>INIT: Id "0" respawning too fast: disabled for 5 minutes<br>INIT: no more processes left in this runlevel<br>INIT: Id "0" respawning too fast: disabled for 5 minutes<br><br>Aside from this, there are some strange error messages like "Starting udev: MAKEDEV: mkdir: File exists" and some AVC denied messages (detailed log is appended at the last).<br><br>However, I could boot up SELinux with refpolicy-2.20081210 successfully, what I do is to first boot Linux kernel into a shell and load SELinux policy image then label the whole filesystem, second boot into /sbin/init as normal. The SELinux userspace tools I am using are:<br>libsepol-2.0.36<br>libselinux-2.0.79<br>libsemanage-2.0.31<br>policycoreutils-2.0.62<br>checkpolicy-2.0.19<br>sepolgen-1.0.16<br><br>The kernel I am using is!
  2.6.27, Stephen kindly pointed out a SELinux kernel bug six months ago when I had a problem to boot up refpolicy-2.20081210, which should be fixed by the commit of "SELinux: check open perms in dentry_open not inode_permission", or bypassed by diabling the open_perms in policy_capabilities. <br><br>The same set of kernel and rootfs work well for refpolicy-2.20081210 but do not for refpolicy-2.20091117, I wonder what changes could make a difference? What should I have done in order to use the latest refpolicy-2.20091117? Any extra SELinux kernel commits I should port back to 2.6.27, or do I need to update SELinux userspace tools to the latest as well?<br><br>Any comment is greatly appreciated! Thank you very much for your help!<br><br>Best regards,<br>Harry<br><br>-----------<br>...<br>VFS: Mounted root (ext2 filesystem).<br>Freeing unused kernel memory: 296k freed<br>type=1404 audit(1263731960.249:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295<br>type=1403 !
 audit(1263731961.676:3): policy loaded auid=4294967295 ses=4294967295<
br>INIT: version 2.86 booting<br>type=1400 audit(1263731962.260:4): avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=960 comm="modprobe" name="console" dev=sda1 ino=244841 scontext=system_u:system_r:insmod_t:s0-s15:c0.c255 tcontext=system_u:object_r:console_device_t:s0 tclass=chr_file<br>type=1400 audit(1263731962.307:5): avc:&nbsp; denied&nbsp; { read } for&nbsp; pid=960 comm="modprobe" path="/dev/console" dev=sda1 ino=244841 scontext=system_u:system_r:insmod_t:s0-s15:c0.c255 tcontext=system_u:object_r:console_device_t:s0 tclass=chr_file<br>Starting udev: MAKEDEV: mkdir: File exists<br>[&nbsp; OK&nbsp; ]<br>Setting hostname cp3020:&nbsp; [&nbsp; OK&nbsp; ]<br>DM multipath kernel driver not loaded<br>No devices found<br>Checking filesystems<br>Checking all file systems.<br>[&nbsp; OK&nbsp; ]<br>can't create lock file /var/lock/mtab~2002: Permission denied (use -n flag to override)<br>Mounting local filesystems:&nbsp; mount: sysfs already mounted or /sys busy<br>mount: devpts a!
 lready mounted or /dev/pts busy<br>can't create lock file /var/lock/mtab~2007: Permission denied (use -n flag to override)<br>[FAILED]<br>Enabling local filesystem quotas:&nbsp; [&nbsp; OK&nbsp; ]<br><br>*** Warning -- SELinux wr-strict policy relabel is required.<br>*** Relabeling could take a very long time, depending on file<br>*** system size and speed of hard drives.<br>Enabling /etc/fstab swaps:&nbsp; [&nbsp; OK&nbsp; ]<br>INIT: Entering runlevel: 3<br>Entering non-interactive startup<br>Starting enterprise event logger: [&nbsp; OK&nbsp; ]<br>Starting remote event logger: [&nbsp; OK&nbsp; ]<br>Starting syslog-ng: [FAILED]<br>Starting ipmi drivers: [&nbsp; OK&nbsp; ]<br>iscsid is stopped<br>iSCSI daemon not running.<br>Starting portmap: [&nbsp; OK&nbsp; ]<br>Mounting other filesystems:&nbsp; mount: sysfs already mounted or /sys busy<br>mount: devpts already mounted or /dev/pts busy<br>can't create lock file /var/lock/mtab~2158: Permission denied (use -n flag to overrid!
 e)<br>[FAILED]<br>Starting sshd: [&nbsp; OK&nbsp; ]<br>Starting xinetd
: [&nbsp; OK&nbsp; ]<br>Starting iSCSI daemon: [&nbsp; OK&nbsp; ]<br>[&nbsp; OK&nbsp; ]<br>Starting enterprise event log notification: [&nbsp; OK&nbsp; ]<br>Starting sendmail: [&nbsp; OK&nbsp; ]<br>Starting sm-client: /etc/rc3.d/S80sendmail: line 71: /sbin/restorecon: No such file or directory<br>[&nbsp; OK&nbsp; ]<br>Starting boa: [&nbsp; OK&nbsp; ]<br>Starting crond: [&nbsp; OK&nbsp; ]<br>Starting notification action daemon: [&nbsp; OK&nbsp; ]<br>Starting atd: [FAILED]<br>INIT: Id "0" respawning too fast: disabled for 5 minutes<br>INIT: no more processes left in this runlevel<br>INIT: Id "0" respawning too fast: disabled for 5 minutes<br>INIT: Id "0" respawning too fast: disabled for 5 minutes<br>INIT: Id "0" respawning too fast: disabled for 5 minutes<br>... 		 	   		  <br /><hr />使用Messenger保护盾2.0，支持多账号登录！ <a href='http://www.windowslive.cn/safe/' target='_new'>现在就下载！</a></body>
</html>
--_65195296-6e24-4e49-9474-c2577bb070ef_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
