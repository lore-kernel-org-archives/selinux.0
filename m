Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n743BJXC020064
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 23:11:19 -0400
Received: from col0-omc3-s17.col0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n743CGNl017730
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 03:12:17 GMT
Message-ID: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_600ca25f-ebd4-47c6-8d56-93953dd07e41_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: A question about selinux userspace tools
Date: Tue, 4 Aug 2009 03:11:18 +0000
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_600ca25f-ebd4-47c6-8d56-93953dd07e41_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi all,

I am a newcomer to SELinux and have a question about the latest SELinux userspace tools.

Before I try to install the latest refpolicy-20090730 from tresys website on Ubuntu 8.10 on Dell 6101 laptop(x86_32), I have installed the below latest SELinux userspace tools on the laptop:

libsepol-2.0.37
libselinux-2.0.85
libsemanage-2.0.33
policycoreutils-2.0.69
checkpolicy-2.0.19
sepolgen-1.0.17

If I specify MONOLITHIC=n in build.conf and compile refpolicy-20090730 by the latest SELinux userspace tools and then do "make load", I would run into following error message in the end:

libsepol.sepol_module_package_read: out of memory
libsemanage.semanage_load_module: Error while reading from module file /etc/selinux/refpolicy-20090730/modules/tmp/base.pp.
/usr/sbin/semodule:  Failed!
make: *** [load] Error 1

The same error would crop up when I try out following second-to-the-latest SELinux userspace tools(also from tresys website):

libsepol-2.0.36
libselinux-2.0.79
libsemanage-2.0.31
policycoreutils-2.0.62
checkpolicy-2.0.19
sepolgen-1.0.16

Only if I degrade libsemanage from 2.0.31 to 2.0.27, and policycoreutils from 2.0.62 to 2.0.55, would the "make load" finish uneventfully, then I could do "semanage login/user -l" and "semodule -l" successfully.

So far I have very shallow experience on SELinux userspace tools implementation and couldn't find out the reason  why the latest stable version would have above error message on my laptop, has anyone run into the same problem before? Any suggestions are greatly appreciated!

Thanks!

Harry
_________________________________________________________________
张三挖到了元宝,小美又掉进陷阱了,快来MClub与好友齐乐乐！立刻访问！
http://club.msn.cn/?from=3
--_600ca25f-ebd4-47c6-8d56-93953dd07e41_
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
Hi all,<br><br>I am a newcomer to SELinux and have a question about the latest SELinux userspace tools.<br><br>Before I try to install the latest refpolicy-20090730 from tresys website on Ubuntu 8.10 on Dell 6101 laptop(x86_32), I have installed the below latest SELinux userspace tools on the laptop:<br><br>libsepol-2.0.37<br>libselinux-2.0.85<br>libsemanage-2.0.33<br>policycoreutils-2.0.69<br>checkpolicy-2.0.19<br>sepolgen-1.0.17<br><br>If I specify MONOLITHIC=n in build.conf and compile refpolicy-20090730 by the latest SELinux userspace tools and then do "make load", I would run into following error message in the end:<br><br>libsepol.sepol_module_package_read: out of memory<br>libsemanage.semanage_load_module: Error while reading from module file /etc/selinux/refpolicy-20090730/modules/tmp/base.pp.<br>/usr/sbin/semodule:&nbsp; Failed!<br>make: *** [load] Error 1<br><br>The same error would crop up when I try out following second-to-the-latest SELinux userspace tools(also !
 from tresys website):<br><br>libsepol-2.0.36<br>libselinux-2.0.79<br>libsemanage-2.0.31<br>policycoreutils-2.0.62<br>checkpolicy-2.0.19<br>sepolgen-1.0.16<br><br>Only if I degrade libsemanage from 2.0.31 to 2.0.27, and policycoreutils from 2.0.62 to 2.0.55, would the "make load" finish uneventfully, then I could do "semanage login/user -l" and "semodule -l" successfully.<br><br>So far I have very shallow experience on SELinux userspace tools implementation and couldn't find out the reason&nbsp; why the latest stable version would have above error message on my laptop, has anyone run into the same problem before? Any suggestions are greatly appreciated!<br><br>Thanks!<br><br>Harry<br /><hr />聊天+搜索+邮箱 想要轻松出游,手机MSN帮你搞定! <a href='http://mobile.msn.com.cn/' target='_new'>立刻下载！</a></body>
</html>
--_600ca25f-ebd4-47c6-8d56-93953dd07e41_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
