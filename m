Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA06374
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 17:00:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0HM06I27751
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 22:00:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h0HM06f27747 for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 22:00:06 GMT
Message-Id: <200301172207.RAA00770@moss-shockers.ncsc.mil>
Date: Fri, 17 Jan 2003 17:07:34 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Problems compiling selinux release (2003011510) for 2.4.20 kernel
To: selinux@tycho.nsa.gov, azeredo@qmc.ufsc.br
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Nest_of_Mice_835_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Nest_of_Mice_835_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: J5bsSgD1Ow5FT5RChM8Jlg==


>    I was trying to compile the updated release (2003011510) for 2.4.20 and
> 2.5.58 kernels on  RedHat 8.0 and using  the same config got the following 
error
> for 2.4.20 kernel despite the fact that   it went fine for 2.5.58 kernel. 
>   Has anyone run into the same problem?
<snip>
> kernel/kernel.o: In function `sys_acct':
> kernel/kernel.o(.text+0xa3b9): undefined reference to `security_acct'
> make: ** [vmlinux] Erro 1

Sorry, the attached patch (also committed to the sourceforge CVS tree) should
fix this problem.  Save it to ~/acct.patch, cd lsm-2.4, patch -p1 < 
~/acct.patch, rebuild your kernel.  Make sure that you've enabled the
new CONFIG_SECURITY option (Enable different security models) in your
kernel configuration.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Nest_of_Mice_835_000
Content-Type: TEXT/plain; name="acct.patch"; charset=us-ascii; x-unix-mode=0644
Content-Description: acct.patch
Content-MD5: HhR9mms6WuP6kmiHS//e8Q==

Index: lsm-2.4/kernel/acct.c
===================================================================
RCS file: /cvsroot/selinux/nsa/lsm-2.4/kernel/acct.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 acct.c
--- lsm-2.4/kernel/acct.c	16 Jan 2003 13:37:58 -0000	1.1.1.3
+++ lsm-2.4/kernel/acct.c	17 Jan 2003 21:56:59 -0000
@@ -54,7 +54,7 @@
 #include <linux/smp_lock.h>
 #include <linux/file.h>
 #include <linux/tty.h>
-
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 /*

--Nest_of_Mice_835_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
