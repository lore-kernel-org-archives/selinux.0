Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j495gSgA029909
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2005 01:42:29 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j495e8IZ017814
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2005 05:40:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: petre rodan <kaiowas@gentoo.org>
Subject: Re: gentoo diffs
Date: Mon, 9 May 2005 15:40:11 +1000
Cc: SELinux <selinux@tycho.nsa.gov>
References: <427CBAD8.6060901@gentoo.org> <200505090349.22645.russell@coker.com.au> <427E6159.4090804@gentoo.org>
In-Reply-To: <427E6159.4090804@gentoo.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+evfC7LaQV4BIBr"
Message-Id: <200505091540.14984.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_+evfC7LaQV4BIBr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 09 May 2005 04:58, petre rodan <kaiowas@gentoo.org> wrote:
> > Also I'm quite certain that you are not using all four combinations
> > of /usr/lib(exec)?(64)?/postfix/.
>
> http://bugs.gentoo.org/show_bug.cgi?id=89321
>
> we have /usr/lib/postfix and /usr/lib64/postfix depending on the profile
> under which it was compiled. having it like lib(exec)?(64)? means that it's
> very easy to maintain, but if that's not possible, no problem.

Why do you want /usr/lib64/postfix?

The point of /usr/lib64 is for files where you have both 32bit and 64bit 
versions installed at the same time.  This is when you have shared objects 
which could be used by either 32bit or 64bit programs.

/usr/libexec/postfix on Red Hat systems contains no shared objects, only 
executables, on ia32_64 the same locations are used.  I can't work out any 
reason for having both 32bit and 64bit versions of those executables (there 
is no good support for having Postfix call 32bit programs for some operations 
and 64bit for others so any attempt to make use of functionality that this 
would provide would be painful).

Debian uses /usr/lib/postfix for the same files but also has some shared 
object in the same directory.  However those shared objects are only for the 
use of Postfix so they have not bothered using /usr/lib64/postfix for the 
amd64 packages.

In summary, /usr/lib64/postfix causes needless differences between 32bit and 
64bit systems for no benefit.  Incidentally this will prevent a main.cf file 
from Debian working on Gentoo AMD64.  Not sure whether main.cf files can be 
shared between 32bit and 64bit Gentoo machines, this is something you 
probably want to investigate.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_+evfC7LaQV4BIBr
Content-Type: text/x-diff;
  charset="utf-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- ./file_contexts/program/postfix.fc.orig	2005-05-09 15:13:40.000000000 +1000
+++ ./file_contexts/program/postfix.fc	2005-05-09 15:15:27.000000000 +1000
@@ -2,20 +2,32 @@
 /etc/postfix(/.*)?		system_u:object_r:postfix_etc_t
 ifdef(`distro_redhat', `
 /etc/postfix/aliases.*		system_u:object_r:etc_aliases_t
+/usr/libexec/postfix/.*	--	system_u:object_r:postfix_exec_t
+/usr/libexec/postfix/cleanup --	system_u:object_r:postfix_cleanup_exec_t
+/usr/libexec/postfix/local	--	system_u:object_r:postfix_local_exec_t
+/usr/libexec/postfix/master	--	system_u:object_r:postfix_master_exec_t
+/usr/libexec/postfix/pickup	--	system_u:object_r:postfix_pickup_exec_t
+/usr/libexec/postfix/(n)?qmgr --	system_u:object_r:postfix_qmgr_exec_t
+/usr/libexec/postfix/showq	--	system_u:object_r:postfix_showq_exec_t
+/usr/libexec/postfix/smtp	--	system_u:object_r:postfix_smtp_exec_t
+/usr/libexec/postfix/smtpd	--	system_u:object_r:postfix_smtpd_exec_t
+/usr/libexec/postfix/bounce	--	system_u:object_r:postfix_bounce_exec_t
+/usr/libexec/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
+', `
+/usr/lib/postfix/.*	--	system_u:object_r:postfix_exec_t
+/usr/lib/postfix/cleanup --	system_u:object_r:postfix_cleanup_exec_t
+/usr/lib/postfix/local	--	system_u:object_r:postfix_local_exec_t
+/usr/lib/postfix/master	--	system_u:object_r:postfix_master_exec_t
+/usr/lib/postfix/pickup	--	system_u:object_r:postfix_pickup_exec_t
+/usr/lib/postfix/(n)?qmgr --	system_u:object_r:postfix_qmgr_exec_t
+/usr/lib/postfix/showq	--	system_u:object_r:postfix_showq_exec_t
+/usr/lib/postfix/smtp	--	system_u:object_r:postfix_smtp_exec_t
+/usr/lib/postfix/smtpd	--	system_u:object_r:postfix_smtpd_exec_t
+/usr/lib/postfix/bounce	--	system_u:object_r:postfix_bounce_exec_t
+/usr/lib/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
 ')
 /etc/postfix/postfix-script.* -- system_u:object_r:postfix_exec_t
 /etc/postfix/prng_exch	--	system_u:object_r:postfix_prng_t
-/usr/lib(exec)?/postfix/.*	--	system_u:object_r:postfix_exec_t
-/usr/lib(exec)?/postfix/cleanup --	system_u:object_r:postfix_cleanup_exec_t
-/usr/lib(exec)?/postfix/local	--	system_u:object_r:postfix_local_exec_t
-/usr/lib(exec)?/postfix/master	--	system_u:object_r:postfix_master_exec_t
-/usr/lib(exec)?/postfix/pickup	--	system_u:object_r:postfix_pickup_exec_t
-/usr/lib(exec)?/postfix/(n)?qmgr --	system_u:object_r:postfix_qmgr_exec_t
-/usr/lib(exec)?/postfix/showq	--	system_u:object_r:postfix_showq_exec_t
-/usr/lib(exec)?/postfix/smtp	--	system_u:object_r:postfix_smtp_exec_t
-/usr/lib(exec)?/postfix/smtpd	--	system_u:object_r:postfix_smtpd_exec_t
-/usr/lib(exec)?/postfix/bounce	--	system_u:object_r:postfix_bounce_exec_t
-/usr/lib(exec)?/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
 /usr/sbin/postalias	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postcat	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postdrop	--	system_u:object_r:postfix_postdrop_exec_t

--Boundary-00=_+evfC7LaQV4BIBr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
