Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0SFwlRb005627
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 10:58:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0SFumCa021200
	for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 15:56:48 GMT
Received: from web15207.mail.bjs.yahoo.com (web15207.mail.cnb.yahoo.com [202.43.216.137])
        by jazzband.ncsc.mil  with SMTP id i0SFtsVC020921 for <selinux@tycho.nsa.gov>; Wed, 28 Jan 2004 15:55:55 GMT
Message-ID: <20040128155450.12205.qmail@web15207.mail.bjs.yahoo.com>
Date: Wed, 28 Jan 2004 23:54:50 +0800 (CST)
From: =?gb2312?q?Park=20Lee?= <parklee_2004@yahoo.com.cn>
Subject: Must SELinux have a initrd image and RAM disk when it boots up? and...
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1248241536-1075305290=:10241"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1248241536-1075305290=:10241
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Dear sir:
 I have install Fedora core 1 (the file date is 2003-11-04,I download it only several days ago) on my computer. and download 2.6.0-test11 kernel with SELinux patch applied and SELinux Full Userland Archive from NSA's SELinux web site. I took actions according to selinux-usr/selinux-
doc/README. After that I reboot the system.and choose the Fedora Core (2.6.0-test11-selinux1) option in GRUB, But some thing happened like this:
 
 ... ...
 RAMDISK: compressed image found at block 0
 RAMDISK: incomplete write (-1!=32768) 4194304
 VFS:     cannot open root device "LABEL=/" or unknown-block(0,0)
 please append a correct "root= " boot option
 Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)
 
And I can't boot the system at all.
 
When I configured the kernel,I have chosen the following options in the Block Devices :
 <*> RAM disk support
 (4096) Default RAM disk size
 [*] Initial RAM disk (initrd) support
 
And the lines in /boot/grub/grub.conf are like this:
 ... ...
 title Fedora Core (2.6.0-test11-selinux1)
 root(hd0,6)
 kernel /vmlinuz-2.6.0-test11-selinux1 ro root=LABEL=/ rhgh
 initrd /initrd-2.6.0-test-selinux1.img
 ... ...
 
I wonder why did the Kernel panic described above happened? and Must SELinux have a two boot-up 
phase using a initrd RAM disk?
 
Another question is:
In the step of Build and Install the SELinux-patched daemons and utilities:
 
 cd SRPMS
 rpmbuild --rebuild *.sel.src.rpm

All the *.sel.src.rpm can be done successfully except prelink-0.3.0-16.sel.src.rpm. 
The messages show on the screen when doing the command( rpmbuild --rebuild prelink-0.3.0-16.sel.src.rpm ) 
looks like this:
 
 Installing prelink-0.3.0-16.sel.src.rpm
 Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.84617
 drwxr-xr-x root/root         0 2003-10-29 04:02:35 prelink/
 ... ...
 ... ...
 `/usr/src/redhat/BUILD/prelink'
 ====================TESTING=========================
 make:  Entering directory `/usr/src/redhat/BUILD/prelink/testsuite'
 make[1]: Entering directory  `/usr/src/redhat/BUILD/prelink/testsuite'
 make  check-TESTS
 make[2]: Entering directory  `/usr/src/redhat/BUILD/prelink/testsuite'
 PASS: reloc1.sh
 PASS: reloc2.sh
 PASS: reloc3.sh
 PASS: reloc4.sh
 ... ...
 PASS: tls3.sh
 PASS: tls4.sh
 PASS: cxx1.sh
 PASS: quick1.sh
 PASS: cycle1.sh
 PASS: cycle2.sh
 FAIL: undosyslibs.sh
 ====================
 1 of 29 tests failed
 ====================
 make[2]: Leaving directory `/usr/src/redhat/BUILD/prelink/testsuite'
 make[1]: Leaving directory `/usr/src/redhat/BUILD/prelink/testsuite'
 make: Leaving directory `/usr/src/redhat/BUILD/prelink/testsuite'
 RPM build errors:
 ... ...
Thus, prelink-0.3.0-16.sel.src.rpm can't be done.
Why? Is there some errors in it or in the Fedora core 1 system?
 
I sincerely hope that you will be able to help me in these matters. 
Thanks.
     Respectfully Yours,
      Park Lee
       2004-1-28 



---------------------------------
Do You Yahoo!?
繁华世界里，让我看清你
--0-1248241536-1075305290=:10241
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Dear sir:<BR>&nbsp;I have install Fedora core 1 (the file date is 2003-11-04,I download it only several days ago) on my computer. and download 2.6.0-test11 kernel with SELinux patch applied and SELinux Full Userland Archive from NSA's SELinux web site. I took actions according to selinux-usr/selinux-</DIV>
<DIV>doc/README. After that I reboot the system.and choose the Fedora Core (2.6.0-test11-selinux1) option in GRUB, But some thing happened like this:<BR>&nbsp;<BR>&nbsp;... ...<BR>&nbsp;RAMDISK: compressed image found at block 0<BR>&nbsp;RAMDISK: incomplete write (-1!=32768) 4194304<BR>&nbsp;VFS:&nbsp;&nbsp;&nbsp;&nbsp; cannot open root device "LABEL=/" or unknown-block(0,0)<BR>&nbsp;please append a correct "root= " boot option<BR>&nbsp;Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)<BR>&nbsp;<BR>And I can't boot the system at all.</DIV>
<DIV>&nbsp;</DIV>
<DIV>When I configured the kernel,I have chosen the following options in the Block Devices :<BR>&nbsp;&lt;*&gt; RAM disk support<BR>&nbsp;(4096) Default RAM disk size<BR>&nbsp;[*] Initial RAM disk (initrd) support</DIV>
<DIV>&nbsp;</DIV>
<DIV>And the lines in /boot/grub/grub.conf are like this:<BR>&nbsp;... ...<BR>&nbsp;title Fedora Core (2.6.0-test11-selinux1)<BR>&nbsp;root(hd0,6)<BR>&nbsp;kernel /vmlinuz-2.6.0-test11-selinux1 ro root=LABEL=/ rhgh<BR>&nbsp;initrd /initrd-2.6.0-test-selinux1.img<BR>&nbsp;... ...</DIV>
<DIV>&nbsp;</DIV>
<DIV>I wonder why did the Kernel panic described above happened? and Must SELinux have a two boot-up </DIV>
<DIV>phase using a initrd RAM disk?<BR>&nbsp;</DIV>
<DIV>Another question is:<BR>In the step of Build and Install the SELinux-patched daemons and utilities:<BR>&nbsp;<BR>&nbsp;cd SRPMS<BR>&nbsp;rpmbuild --rebuild *.sel.src.rpm</DIV>
<DIV><BR>All the *.sel.src.rpm can be done successfully except prelink-0.3.0-16.sel.src.rpm. </DIV>
<DIV>The messages show on the screen when doing the command( rpmbuild --rebuild prelink-0.3.0-16.sel.src.rpm ) <BR>looks like this:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;Installing prelink-0.3.0-16.sel.src.rpm<BR>&nbsp;Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.84617<BR>&nbsp;drwxr-xr-x root/root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 2003-10-29 04:02:35 prelink/<BR>&nbsp;... ...<BR>&nbsp;... ...</DIV>
<DIV>&nbsp;`/usr/src/redhat/BUILD/prelink'<BR>&nbsp;====================TESTING=========================<BR>&nbsp;make: &nbsp;Entering directory `/usr/src/redhat/BUILD/prelink/testsuite'<BR>&nbsp;make[1]: Entering directory &nbsp;`/usr/src/redhat/BUILD/prelink/testsuite'<BR>&nbsp;make&nbsp; check-TESTS<BR>&nbsp;make[2]: Entering directory &nbsp;`/usr/src/redhat/BUILD/prelink/testsuite'<BR>&nbsp;PASS: reloc1.sh<BR>&nbsp;PASS: reloc2.sh<BR>&nbsp;PASS: reloc3.sh<BR>&nbsp;PASS: reloc4.sh<BR>&nbsp;... ...<BR>&nbsp;PASS: tls3.sh<BR>&nbsp;PASS: tls4.sh<BR>&nbsp;PASS: cxx1.sh<BR>&nbsp;PASS: quick1.sh<BR>&nbsp;PASS: cycle1.sh<BR>&nbsp;PASS: cycle2.sh<BR>&nbsp;FAIL: undosyslibs.sh<BR>&nbsp;====================<BR>&nbsp;1 of 29 tests failed<BR>&nbsp;====================<BR>&nbsp;make[2]: Leaving directory `/usr/src/redhat/BUILD/prelink/testsuite'<BR>&nbsp;make[1]: Leaving directory `/usr/src/redhat/BUILD/prelink/testsuite'<BR>&nbsp;make: Leaving directory
 `/usr/src/redhat/BUILD/prelink/testsuite'<BR>&nbsp;RPM build errors:<BR>&nbsp;... ...</DIV>
<DIV>Thus, prelink-0.3.0-16.sel.src.rpm can't be done.<BR>Why? Is there some errors in it or in the Fedora core 1 system?<BR>&nbsp;</DIV>
<DIV>I sincerely hope that you will be able to help me in these matters. <BR>Thanks.</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Respectfully Yours,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Park Lee<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2004-1-28&nbsp;</DIV><p><br><hr size=1><b>Do You Yahoo!?</b><br>
<a href="http://cn.rd.yahoo.com/mail_cn/tag/?http://cn.surveys.yahoo.com/cn_user_profile_study_dec2003" target=blank>繁华世界里，让我看清你</a>
--0-1248241536-1075305290=:10241--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
