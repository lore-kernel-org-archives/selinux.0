Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1RHcQRb029616
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 12:38:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1RHanlK022430
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 17:36:49 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i1RHamOX022427
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 17:36:49 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id i1RHcOb11377
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 12:38:24 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i1RHcO825401
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 12:38:24 -0500
Received: from sisko.scot.redhat.com (sct.cipe.redhat.com [10.0.1.44])
	by devserv.devel.redhat.com (8.12.10/8.12.10) with ESMTP id i1RHcJeF025382
	for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2004 12:38:20 -0500
Subject: SELinux and NFS --- a bit of a fight!
From: "Stephen C. Tweedie" <sct@redhat.com>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: James Morris <jmorris@redhat.com>, Stephen Tweedie <sct@redhat.com>
Content-Type: text/plain
Message-Id: <1077903498.30334.12.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Date: 27 Feb 2004 17:38:19 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

Looks like there is a rather nasty surprise lurking in the NFS code when
using SELinux.  I've been running with NFS-mounted homedirs, and an odd
thing happens if you try to access those from sysadm_r and normal user
contexts at the same time.  

Basically, it looks as if the kernel's own internal NFS network sockets,
used by the NFS client layer, are having SELinux controls applied to
them.  You end up with udp sockets created by one NFS process being
unavailable to another process mounting the same filesystem, even if
it's actually kernel-mode access to the socket which is being
prohibited.  AVC errors such as

        Feb 27 12:39:35 localhost kernel: avc:  denied  { write } for 
        pid=2365 exe=/bin/bash lport=800 scontext=sct:staff_r:staff_t
        tcontext=root:system_r:sshd_t tclass=udp_socket

and

        Feb 25 17:57:36 localhost kernel: avc:  denied  { write } for 
        pid=1817 exe=/bin/login lport=800
        scontext=system_u:system_r:local_login_t
        tcontext=user_u:user_r:user_t tclass=udp_socket

result.

This seems to be fixed by a fairly simple addition to sock_has_perm:

--- linux-2.6.3/security/selinux/hooks.c.=K0000=.orig
+++ linux-2.6.3/security/selinux/hooks.c
@@ -2719,6 +2719,13 @@ static int socket_has_perm(struct task_s
 	struct avc_audit_data ad;
 	int err;
 
+	/* Special case: sunrpc and similar kernel users, sending kernel
+	 * data over a socket, don't want to get clobbered here when
+	 * trying to send over something like a kernel-internal NFS
+	 * socket. */
+	if (segment_eq(get_fs(), KERNEL_DS))
+		return 0;
+	
 	tsec = task->security;
 	isec = SOCK_INODE(sock)->i_security;
 

which simply skips the AVC test entirely if we've got get_ds() ==
KERNEL_DS (which is kernel-speak for "the data we're passing in here is
coming directly from kernel space, not user space.)

I'm not convinced that this is the absolute best solution, but I can't
see any cleaner methods off-hand.

--Stephen


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
