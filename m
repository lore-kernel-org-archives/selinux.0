Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h41ClDI4009671
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 08:47:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h41Cl3Vf009864
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 12:47:03 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h41Cl34D009861
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 12:47:03 GMT
Subject: Re: ssh/login
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Brian May <bam@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030501022414.GA13019@snoopy.apana.org.au>
References: <20030501022414.GA13019@snoopy.apana.org.au>
Content-Type: text/plain
Message-Id: <1051793224.1377.64.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 May 2003 08:47:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-30 at 22:24, Brian May wrote:
> If I boot a computer with SE-Linux but without the SE-Linux policy
> installed (in permissive mode obviously[1]), neither the SE-Linux
> patched ssh or login will let me login. It means that the only option I
> have is to reboot is single user mode, and downgrade these packages to
> non-SE-Linux versions.
> 
> This is because there are no valid security contexts available for me to
> log in with.

This can also occur even if the policy has been loaded if the login or
sshd executables have the wrong type, e.g. you updated them to new
versions and forgot to relabel them to the proper entrypoint types.  In
that case, the login or sshd process will run in the wrong domain, so
security_get_user_sids will report that there are no reachable user
contexts from its domain.  In the login case, you can prompt the user
for a context in this case, but the sshd patch doesn't presently allow
for such a user interaction for obtaining a context.

> Is there anyway I can get ssh or login to completely disable SE-Linux
> support if SE-Linux is loaded but no policy is?

At present, is_flask_enabled() tests for the presence of SELinux using
getsecsid, so the below patch would cause it to return 0 if the policy
has not been loaded even though SELinux is present.

Index: lsm-2.4/security/selinux/syscalls.c
===================================================================
RCS file: /home/pal/CVS/lsm-2.4/security/selinux/syscalls.c,v
retrieving revision 1.14
diff -u -r1.14 syscalls.c
--- lsm-2.4/security/selinux/syscalls.c	21 Mar 2003 16:07:05 -0000	1.14
+++ lsm-2.4/security/selinux/syscalls.c	1 May 2003 12:36:15 -0000
@@ -41,6 +41,10 @@
 long sys_getsecsid(void) 
 {
 	struct task_security_struct *tsec;
+	extern int ss_initialized;
+
+	if (!ss_initialized)
+		return -ENOSYS;
 
 	tsec = current->security;
 	return tsec->sid;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
