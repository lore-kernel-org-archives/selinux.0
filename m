Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7430UEr019311
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 23:00:30 -0400
Received: from col0-omc3-s10.col0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7431RNl016398
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 03:01:28 GMT
Message-ID: <COL109-W23743BA1B690A08216533AB0C0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_da139269-0262-489e-827a-380b2b8d4d73_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: <selinux@tycho.nsa.gov>
Subject: A question about installing refpolicy-2.10081210
Date: Tue, 4 Aug 2009 03:00:28 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_da139269-0262-489e-827a-380b2b8d4d73_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi all,

I have a question about the error messages when installing refpolicy-2.20081210 from the tresys website on dell 610(x86_32) laptop. I have installed and compiled refpolicy-2.20081210 by the following selinux user space tools:

libsepol-2.0.36
libselinux-2.0.79
libsemanage-2.0.27
policycoreutils-2.0.55
checkpolicy-2.0.19
sepolgen-1.0.16

Then I use kernel cmdline of "root=/dev/sda1 rw init=/bin/bash selinux=1" to boot into a shell with selinux enabled so that I could setup proper security contexts for the whole file system in the shell before the next time I would let kernel boot into normal /sbin/init program and start everything with correct security context. Then I do the following commands:

mount -t proc none /proc
mount -t sysfs none /sys
mount -t selinuxfs none /selinux
SELINUXTYPE=refpolicy-20081210
/usr/sbin/load_policy -q /etc/selinux/$SELINUXTYPE/policy/policy.24
sed -i "s/^SELINUXTYPE=.*/SELINUXTYPE=$SELINUXTYPE/" /etc/selinux/config
/usr/sbin/restorecon -v -R /

The "load_policy -q" would pop up a message of:
type=1403 audit(1255195933.120:2): policy loaded auid=4294967295 ses=4294967295

so I guess the policy.24 has been loaded successfully, and the "restorecon" could run successfully. However, when I change the kernel cmdline with "init=/sbin/init" I could see hundreds of error messages about udev and mingetty such as:

udevd-event[1252]: selinux_setfscreatecon: matchpathcon(/dev/.tmp-8-0) failed
udevd-event[1215]: selinux_setfilecon: matchpathcon(/dev/ram12) failed

and 

type=1400 audit(1248303983.579:5559): avc:  denied  { open } for  pid=3283 comm="mingetty" name="var" dev=sda1 ino=103169 scontext=system_u:system_r:getty_t:s0-s15:c0.c255 tcontext=system_u:object_r:var_t:s0 tclass=dir
type=1400 audit(1248303983.598:5560): avc:  denied  { open } for  pid=3282 comm="mingetty" name="var" dev=sda1 ino=103169 scontext=system_u:system_r:getty_t:s0-s15:c0.c255 tcontext=system_u:object_r:var_t:s0 tclass=dir

with "INIT: no more processes left in this runlevel" in the end when I try to login through serial console.

I guess above error messages may have resulted in the file system having not been labeled correctly, does anyone know what I may have missed out when trying to relabeling the file system when first time booting into the shell?

Thanks a lot!!

Harry


_________________________________________________________________
张三挖到了元宝,小美又掉进陷阱了,快来MClub与好友齐乐乐！立刻访问！
http://club.msn.cn/?from=3
--_da139269-0262-489e-827a-380b2b8d4d73_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
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
</style>
</head>
<body class='hmmessage'>
Hi all,<br><br>I have a question about the error messages when installing refpolicy-2.20081210 from the tresys website on dell 610(x86_32) laptop. I have installed and compiled refpolicy-2.20081210 by the following selinux user space tools:<br><br>libsepol-2.0.36<br>libselinux-2.0.79<br>libsemanage-2.0.27<br>policycoreutils-2.0.55<br>checkpolicy-2.0.19<br>sepolgen-1.0.16<br><br>Then I use kernel cmdline of "root=/dev/sda1 rw init=/bin/bash selinux=1" to boot into a shell with selinux enabled so that I could setup proper security contexts for the whole file system in the shell before the next time I would let kernel boot into normal /sbin/init program and start everything with correct security context. Then I do the following commands:<br><br>mount -t proc none /proc<br>mount -t sysfs none /sys<br>mount -t selinuxfs none /selinux<br>SELINUXTYPE=refpolicy-20081210<br>/usr/sbin/load_policy -q /etc/selinux/$SELINUXTYPE/policy/policy.24<br>sed -i "s/^SELINUXTYPE=.*/SELINUXTYPE=$S!
 ELINUXTYPE/" /etc/selinux/config<br>/usr/sbin/restorecon -v -R /<br><br>The "load_policy -q" would pop up a message of:<br>type=1403 audit(1255195933.120:2): policy loaded auid=4294967295 ses=4294967295<br><br>so I guess the policy.24 has been loaded successfully, and the "restorecon" could run successfully. However, when I change the kernel cmdline with "init=/sbin/init" I could see hundreds of error messages about udev and mingetty such as:<br><br>udevd-event[1252]: selinux_setfscreatecon: matchpathcon(/dev/.tmp-8-0) failed<br>udevd-event[1215]: selinux_setfilecon: matchpathcon(/dev/ram12) failed<br><br>and <br><br>type=1400 audit(1248303983.579:5559): avc:&nbsp; denied&nbsp; { open } for&nbsp; pid=3283 comm="mingetty" name="var" dev=sda1 ino=103169 scontext=system_u:system_r:getty_t:s0-s15:c0.c255 tcontext=system_u:object_r:var_t:s0 tclass=dir<br>type=1400 audit(1248303983.598:5560): avc:&nbsp; denied&nbsp; { open } for&nbsp; pid=3282 comm="mingetty" name="var" dev=sda1 !
 ino=103169 scontext=system_u:system_r:getty_t:s0-s15:c0.c255 tcontext=
system_u:object_r:var_t:s0 tclass=dir<br><br>with "INIT: no more processes left in this runlevel" in the end when I try to login through serial console.<br><br>I guess above error messages may have resulted in the file system having not been labeled correctly, does anyone know what I may have missed out when trying to relabeling the file system when first time booting into the shell?<br><br>Thanks a lot!!<br><br>Harry<br><br><br /><hr />聊天+搜索+邮箱 想要轻松出游,手机MSN帮你搞定! <a href='http://mobile.msn.com.cn/' target='_new'>立刻下载！</a></body>
</html>
--_da139269-0262-489e-827a-380b2b8d4d73_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
