Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o241LQQA024662
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2010 20:21:26 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o241LnR1002021
	for <selinux@tycho.nsa.gov>; Thu, 4 Mar 2010 01:21:49 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BDAA5180C0
	for <selinux@tycho.nsa.gov>; Thu,  4 Mar 2010 12:21:22 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: lnk_file:write
Date: Thu, 4 Mar 2010 12:21:21 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201003041221.21671.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[   12.814762] type=1400 audit(1267664699.904:8): avc:  denied  { write } for  
pid=726 comm="udevd" name="4:66" dev=tmpfs ino=1767 
scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 
tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
[   12.814802] type=1300 audit(1267664699.904:8): arch=c000003e syscall=280 
success=no exit=-13 a0=ffffffffffffff9c a1=1e69110 a2=0 a3=100 items=0 
ppid=689 pid=726 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 
sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="udevd" exe="/sbin/udevd" 
subj=system_u:system_r:udev_t:s0-s0:c0.c1023 key=(null)

I'm seeing messages like the above in my kernel message log when running the 
latest Debian/Testing (2.6.32 kernel and udev 151-2).

        { 4,    TD|TF,  sys_utimensat,          "utimensat"     }, /* 280 */

According to the above from the strace source it seems that on AMD64 syscall 
280 is utimensat().

Should we update manage_lnk_file_perms to include write access?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
