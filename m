Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i07Fh6Rb015677
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 10:43:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i07Fg3xr010493
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 15:42:03 GMT
Received: from web15202.mail.bjs.yahoo.com (web15202.mail.cnb.yahoo.com [202.43.216.132])
	by jazzswing.ncsc.mil  with SMTP id i07FfvYc010484
	for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2004 15:42:01 GMT
Message-ID: <20040107154244.96866.qmail@web15202.mail.bjs.yahoo.com>
Date: Wed, 7 Jan 2004 23:42:44 +0800 (CST)
From: =?gb2312?q?Park=20Lee?= <parklee_2004@yahoo.com.cn>
Subject: Questions about install SELinux
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2086161914-1073490164=:96653"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-2086161914-1073490164=:96653
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello:
 I'm a beginner of SELinux.
 I'm very interested in SELinux.
 But now I have some questions about SELinux.
 I have installed RedHat 9.0(the Linux kernel version is 2.4.20-8) on my computer and downloaded the 2.4.23 kernel with SELinux patch applied (i.e. linux-2.4-2003120509.tgz) and the SELinux Full Userland Archive (i.e. selinux-usr-2003120509.tgz) from NSA's web site (http://www.nsa.gov/selinux).
 I can unpacked the 2.4.23 kernel with SELinux patch applied and would configure and install it successfully. 
 Then I unpacked the SELinux Full Userland Archive .But when I take actions according to the README file,there are always several packages cann't be installed rightly.
{
/* it is in the 2nd step of the BUILDING AND INSTALLING section.as follows: */
After installing the new SELinux packages (particularly libselinux),you can build and install the SELinux-patched packages as follows:
 cd SRPMS
 rpmbuild --rebuild *.src.rpm
 rpm -Uvh --force /usr/src/redhat/RPMS/*/*.rpm
Note:  To rebuild these SRPMS, we had to install the following additional packages from Fedora:
 libcroco-devel (required to build gdm)
 sharutils (required to build openssh)
 elfutils-devel (required to build prelink)
 autoconf213 (required to build star)
}
 I fell very confused about it.
 I want to install SELinux successfully and I want to study SELinux very much! 
 Would you tell me what's wrong? Thank you very much!
 And would you tell me where can I find and download the 2.4.20 kernel with SELinux patch applied and the it's SELinux Full Userland Archive correspondingly? If I unpack, configure and install them on RedHat9.0 ,Can I 
success?
 Thanks again!

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2086161914-1073490164=:96653
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Hello:<BR>&nbsp;I'm a beginner of SELinux.<BR>&nbsp;I'm very interested in SELinux.<BR>&nbsp;But now I have some questions about SELinux.<BR>&nbsp;I have installed RedHat 9.0(the Linux kernel version is 2.4.20-8) on my computer and downloaded the 2.4.23 kernel with SELinux patch applied (i.e. linux-2.4-2003120509.tgz) and the SELinux Full Userland Archive (i.e. selinux-usr-2003120509.tgz) from NSA's web site (<A href="http://www.nsa.gov/selinux">http://www.nsa.gov/selinux</A>).<BR>&nbsp;I can unpacked the 2.4.23 kernel with SELinux patch applied and would configure and install it successfully. <BR>&nbsp;Then I unpacked the SELinux Full Userland Archive .But when I take actions according to the README file,there are always several packages cann't be installed rightly.</DIV>
<DIV>{<BR>/* it is in the 2nd step of the BUILDING AND INSTALLING section.as follows: */</DIV>
<DIV>After installing the new SELinux packages (particularly libselinux),you can build and install the SELinux-patched packages as follows:<BR>&nbsp;cd SRPMS<BR>&nbsp;rpmbuild --rebuild *.src.rpm<BR>&nbsp;rpm -Uvh --force /usr/src/redhat/RPMS/*/*.rpm<BR>Note:&nbsp; To rebuild these SRPMS, we had to install the following additional packages from Fedora:<BR>&nbsp;libcroco-devel (required to build gdm)<BR>&nbsp;sharutils (required to build openssh)<BR>&nbsp;elfutils-devel (required to build prelink)<BR>&nbsp;autoconf213 (required to build star)<BR>}</DIV>
<DIV>&nbsp;I fell very confused about it.<BR>&nbsp;I want to install SELinux successfully and I want to study SELinux very much! <BR>&nbsp;Would you tell me what's wrong? Thank you very much!<BR>&nbsp;And would you tell me where can I find and download the 2.4.20 kernel with SELinux patch applied and the it's SELinux Full Userland Archive correspondingly? If I unpack, configure and install them on RedHat9.0 ,Can I </DIV>
<DIV>success?<BR>&nbsp;Thanks again!</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-2086161914-1073490164=:96653--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
