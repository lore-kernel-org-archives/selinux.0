Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n748vPtL020747
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 04:57:25 -0400
Received: from col0-omc4-s8.col0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n748wNRZ007170
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 08:58:23 GMT
Message-ID: <COL109-W18E97D02CEB8D36B68539AB0C0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_ae862701-54ed-40c4-8804-982a71acb773_"
From: TaurusHarry <harrytaurus2002@hotmail.com>
To: <remmolt@zwartsenberg.eu>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: RE: A question about selinux userspace tools
Date: Tue, 4 Aug 2009 08:57:23 +0000
In-Reply-To: <A0FAB46BC43C4D8ABE2581D6EF3E2713@CIMSLAB.NL>
References: <COL109-W24536BCBD1CB8DA1812599AB0C0@phx.gbl>
 <A0FAB46BC43C4D8ABE2581D6EF3E2713@CIMSLAB.NL>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_ae862701-54ed-40c4-8804-982a71acb773_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Remmolt,

Many thanks for your reply!

I guess you may think I am running Ubuntu 8.10 by vmware on top of Windows OS, but this is not the case, I have booted into Ubuntu directly without any virtualization tool, there is no PAGEFILE.SYS nor INDEXF.SYS on linux, they seem to be very Windows-like.

Yeah, I know I could install a bootable selinux kit simply by "sudo apt-get install selinux" and everything will be installed and set up correctly, however, I would like to follow all the necessary steps by hand to get a better understanding of how to deploy selinux on Ubuntu, so I started from scratch by installing the latest selinux userspace tools and loading refpolicy package.

I just wondering why the latest stable libsemanage may cause this "libsepol.sepol_module_package_read: out of memory" problem but the version of 2.0.27 won't.

Best regards,

Harry


From: remmolt@zwartsenberg.eu
To: harrytaurus2002@hotmail.com
CC: selinux@tycho.nsa.gov
Subject: RE: A question about selinux userspace tools
Date: Tue, 4 Aug 2009 10:38:46 +0200



















Hello Harry,

 

You are getting a traceback error because
your build is trying to reference RAM memory on your laptop that either does
not exist or is addressed thru a virtualization tool ( like say Vmware,
Softtricity or CITRIX)

Further, your PAGEFILE.SYS may be too
small. Mind you the referencing of the INDEXF.SYS (HD memory) from ‘userspace’ is
handled thru a windows i/o handler.

 

What you could try (you seem to be young
and have plenty of time) is create a bootable Selinux kit and before you reboot
your laptop change the boot sequence in the BIOS (Basic Input Output System) to
the device on your laptop you stored the kit on.

We did this successfully on Knoppix (cr
Klaus Knoppers). 

 

Viel spass,

 

~remmolt     

 

www.bundesnachrichtendienst.de


 









From:
owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of TaurusHarry

Sent: dinsdag 4 augustus 2009 5:11

To: selinux-mailing-list

Subject: A question about selinux
userspace tools



 

Hi all,



I am a newcomer to SELinux and have a question about the latest SELinux
userspace tools.



Before I try to install the latest refpolicy-20090730 from tresys website on
Ubuntu 8.10 on Dell 6101 laptop(x86_32), I have installed the below latest
SELinux userspace tools on the laptop:



libsepol-2.0.37

libselinux-2.0.85

libsemanage-2.0.33

policycoreutils-2.0.69

checkpolicy-2.0.19

sepolgen-1.0.17



If I specify MONOLITHIC=n in build.conf and compile refpolicy-20090730 by the
latest SELinux userspace tools and then do "make load", I would run
into following error message in the end:



libsepol.sepol_module_package_read: out of memory

libsemanage.semanage_load_module: Error while reading from module file
/etc/selinux/refpolicy-20090730/modules/tmp/base.pp.

/usr/sbin/semodule:  Failed!

make: *** [load] Error 1



The same error would crop up when I try out following second-to-the-latest
SELinux userspace tools(also ! from tresys website):



libsepol-2.0.36

libselinux-2.0.79

libsemanage-2.0.31

policycoreutils-2.0.62

checkpolicy-2.0.19

sepolgen-1.0.16



Only if I degrade libsemanage from 2.0.31 to 2.0.27, and policycoreutils from
2.0.62 to 2.0.55, would the "make load" finish uneventfully, then I
could do "semanage login/user -l" and "semodule -l"
successfully.



So far I have very shallow experience on SELinux userspace tools implementation
and couldn't find out the reason  why the latest stable version would have
above error message on my laptop, has anyone run into the same problem before?
Any suggestions are greatly appreciated!



Thanks!



Harry







聊天+搜索+邮箱 想要轻松出游,手机MSN帮你搞定! 立刻下载！


_________________________________________________________________
您可以借助 Windows Live 整理、编辑和共享您的照片。
http://www.microsoft.com/china/windows/windowslive/products/photo-gallery-edit.aspx
--_ae862701-54ed-40c4-8804-982a71acb773_
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
Hi Remmolt,<br><br>Many thanks for your reply!<br><br>I guess you may think I am running Ubuntu 8.10 by vmware on top of Windows OS, but this is not the case, I have booted into Ubuntu directly without any virtualization tool, there is no PAGEFILE.SYS nor INDEXF.SYS on linux, they seem to be very Windows-like.<br><br>Yeah, I know I could install a bootable selinux kit simply by "sudo apt-get install selinux" and everything will be installed and set up correctly, however, I would like to follow all the necessary steps by hand to get a better understanding of how to deploy selinux on Ubuntu, so I started from scratch by installing the latest selinux userspace tools and loading refpolicy package.<br><br>I just wondering why the latest stable libsemanage may cause this "<font style="font-size: 10pt;" size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;">libsepol.sepol_module_package_read: out of memory</span></font>" problem but the version of 2.0.27 won't!
 .<br><br>Best regards,<br><br>Harry<br><br><br><hr id="stopSpelling">From: remmolt@zwartsenberg.eu<br>To: harrytaurus2002@hotmail.com<br>CC: selinux@tycho.nsa.gov<br>Subject: RE: A question about selinux userspace tools<br>Date: Tue, 4 Aug 2009 10:38:46 +0200<br><br>







<style>
.ExternalClass .EC_shape
{;}
</style>

<style>
.ExternalClass p.EC_MsoNormal, .ExternalClass li.EC_MsoNormal, .ExternalClass div.EC_MsoNormal
{margin-bottom:.0001pt;font-size:12.0pt;font-family:SimSun;}
.ExternalClass a:link, .ExternalClass span.EC_MsoHyperlink
{color:blue;text-decoration:underline;}
.ExternalClass a:visited, .ExternalClass span.EC_MsoHyperlinkFollowed
{color:blue;text-decoration:underline;}
.ExternalClass p
{margin-right:0cm;margin-left:0cm;font-size:12.0pt;font-family:SimSun;}
.ExternalClass span.EC_EmailStyle18
{font-family:Arial;color:navy;}
@page Section1
{size:612.0pt 792.0pt;}
.ExternalClass div.EC_Section1
{page:Section1;}
</style>





<div class="EC_Section1">

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">Hello Harry,</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">You are getting a traceback error because
your build is trying to reference RAM memory on your laptop that either does
not exist or is addressed thru a virtualization tool ( like say Vmware,
Softtricity or CITRIX)</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">Further, your PAGEFILE.SYS may be too
small. Mind you the referencing of the INDEXF.SYS (HD memory) from ‘userspace’ is
handled thru a windows i/o handler.</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">What you could try (you seem to be young
and have plenty of time) is create a bootable Selinux kit and before you reboot
your laptop change the boot sequence in the BIOS (Basic Input Output System) to
the device on your laptop you stored the kit on.</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">We did this successfully on Knoppix (cr
Klaus Knoppers). </span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">Viel spass,</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">~remmolt &nbsp;&nbsp;&nbsp;&nbsp;</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;"><a href="http://www.bundesnachrichtendienst.de/">www.bundesnachrichtendienst.de</a>
</span></font></p>

<p class="EC_MsoNormal"><font size="2" color="navy" face="Arial"><span style="font-size: 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<div>

<div class="EC_MsoNormal" style="text-align: center;" align="center"><font size="3" face="SimSun"><span style="font-size: 12pt;">

<hr size="2" width="100%" align="center">

</span></font></div>

<p class="EC_MsoNormal"><b><font size="2" face="Tahoma"><span style="font-size: 10pt; font-family: Tahoma; font-weight: bold;">From:</span></font></b><font size="2" face="Tahoma"><span style="font-size: 10pt; font-family: Tahoma;">
owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] <b><span style="font-weight: bold;">On Behalf Of </span></b>TaurusHarry<br>
<b><span style="font-weight: bold;">Sent:</span></b> dinsdag 4 augustus 2009 5:11<br>
<b><span style="font-weight: bold;">To:</span></b> selinux-mailing-list<br>
<b><span style="font-weight: bold;">Subject:</span></b> A question about selinux
userspace tools</span></font></p>

</div>

<p class="EC_MsoNormal"><font size="3" face="SimSun"><span style="font-size: 12pt;">&nbsp;</span></font></p>

<p class="EC_MsoNormal"><font size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;">Hi all,<br>
<br>
I am a newcomer to SELinux and have a question about the latest SELinux
userspace tools.<br>
<br>
Before I try to install the latest refpolicy-20090730 from tresys website on
Ubuntu 8.10 on Dell 6101 laptop(x86_32), I have installed the below latest
SELinux userspace tools on the laptop:<br>
<br>
libsepol-2.0.37<br>
libselinux-2.0.85<br>
libsemanage-2.0.33<br>
policycoreutils-2.0.69<br>
checkpolicy-2.0.19<br>
sepolgen-1.0.17<br>
<br>
If I specify MONOLITHIC=n in build.conf and compile refpolicy-20090730 by the
latest SELinux userspace tools and then do "make load", I would run
into following error message in the end:<br>
<br>
libsepol.sepol_module_package_read: out of memory<br>
libsemanage.semanage_load_module: Error while reading from module file
/etc/selinux/refpolicy-20090730/modules/tmp/base.pp.<br>
/usr/sbin/semodule:&nbsp; Failed!<br>
make: *** [load] Error 1<br>
<br>
The same error would crop up when I try out following second-to-the-latest
SELinux userspace tools(also ! from tresys website):<br>
<br>
libsepol-2.0.36<br>
libselinux-2.0.79<br>
libsemanage-2.0.31<br>
policycoreutils-2.0.62<br>
checkpolicy-2.0.19<br>
sepolgen-1.0.16<br>
<br>
Only if I degrade libsemanage from 2.0.31 to 2.0.27, and policycoreutils from
2.0.62 to 2.0.55, would the "make load" finish uneventfully, then I
could do "semanage login/user -l" and "semodule -l"
successfully.<br>
<br>
So far I have very shallow experience on SELinux userspace tools implementation
and couldn't find out the reason&nbsp; why the latest stable version would have
above error message on my laptop, has anyone run into the same problem before?
Any suggestions are greatly appreciated!<br>
<br>
Thanks!<br>
<br>
Harry</span></font></p>

<div class="EC_MsoNormal" style="text-align: center;" align="center"><font size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;">

<hr size="2" width="100%" align="center">

</span></font></div>

<p class="EC_MsoNormal"><font size="2" face="SimSun"><span style="font-size: 10pt;" lang="ZH-CN">聊天</span></font><font size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;">+</span></font><font size="2"><span style="font-size: 10pt;" lang="ZH-CN">搜索</span></font><font size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;">+</span></font><font size="2"><span style="font-size: 10pt;" lang="ZH-CN">邮箱</span></font><font size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;" lang="ZH-CN"> </span></font><font size="2"><span style="font-size: 10pt;" lang="ZH-CN">想要轻松出游</span></font><font size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;">,</span></font><font size="2"><span style="font-size: 10pt;" lang="ZH-CN">手机</span></font><font size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;">MSN</span></font><font size="2"><span style="font-size: 10pt;" lang="Z!
 H-CN">帮你搞定</span></font><font size="2" face="Verdana"><span style="font-size: 10pt; font-family: Verdana;">! <a href="http://mobile.msn.com.cn/"><font face="SimSun"><span style="font-family: SimSun;" lang="ZH-CN">立刻下载！</span></font></a></span></font></p>

</div><br /><hr />您可以借助 Windows Live 整理、编辑和 <a href='http://www.microsoft.com/china/windows/windowslive/products/photo-gallery-edit.aspx' target='_new'>共享您的照片。</a></body>
</html>
--_ae862701-54ed-40c4-8804-982a71acb773_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
