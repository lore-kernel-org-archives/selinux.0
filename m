Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7UMeMCE008253
	for <selinux@tycho.nsa.gov>; Wed, 30 Aug 2006 18:40:22 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7UMe2DP010542
	for <selinux@tycho.nsa.gov>; Wed, 30 Aug 2006 22:40:02 GMT
Date: Wed, 30 Aug 2006 17:39:37 -0500
From: Klaus Weidner <klaus@atsec.com>
To: selinux@tycho.nsa.gov
Cc: Stephan Mueller <smueller@atsec.com>
Subject: type transitioning script race condition?
Message-ID: <20060830223937.GB12307@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

in the current refpolicy, quite a few script files have a *_exec_t type
and do a type transition. My understanding is that the transition happens
in the kernel in the execve() call, and then after transitioning the
kernel launches the interpreter (from fs/binfmt_script.c) and passes the
script name to the interpreter.

This sounds as if it suffers from the well known race condition that
makes setuid shell scripts a bad idea - is there any protection in place
to prevent users from exploiting the race condition to run code of their
own choice in the new domain?

The thread "labeling of compilers etc" on this mailing list (Feb this
year) touched on the subject but I didn't see a definite answer how this
is handled.

I've experimented a bit, running /usr/bin/yum as a normal user and using
Ctrl-Z to suspend it, and according to "ps axZ" output the python
process has the staff_u:staff_r:staff_t:SystemLow-SystemHigh context, and
doesn't seem to be transitioning. 

When run as root/sysadm_r, running "yum" appears to try to transition
(which incidentally produces an error and audit records, but that's a
different issue):

 # yum
 bash: /usr/bin/yum: /usr/bin/python: bad interpreter: Permission denied

 type=SELINUX_ERR msg=audit(1156698927.439:529): security_compute_sid: invalid context staff_u:system_r:rpm_t:s0-s15:c0.c255 for scontext=staff_u:sysadm_r:sysadm_t:s0-s15:c0.c255 tcontext=system_u:object_r:rpm_exec_t:s0 tclass=process
 type=SYSCALL msg=audit(1156698927.439:529): arch=40000003 syscall=11 success=no exit=-13 a0=83a6020 a1=83a9990 a2=83aabd8 a3=83a9a10 items=0 ppid=1754 pid=2080 auid=500 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 comm="bash" exe="/bin/bash" subj=staff_u:sysadm_r:sysadm_t:s0-s15:c0.c255 key=(null)

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
