Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB51IMRb001961
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 20:18:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB51IMRV010020
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 01:18:22 GMT
Received: from hawaii.efficax.net (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
        by jazzband.ncsc.mil  with ESMTP id hB51ILta010017 for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 01:18:21 GMT
Received: from hawaii.efficax.net (localhost [127.0.0.1])
	by hawaii.efficax.net (8.12.8/8.12.8) with ESMTP id hB51IMX0028518
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 19:18:22 -0600
Received: (from nick@localhost)
	by hawaii.efficax.net (8.12.8/8.12.8/Submit) id hB51IMvx028516
	for selinux@tycho.nsa.gov; Thu, 4 Dec 2003 19:18:22 -0600
Subject: 
From: Nick <nagray@austin.rr.com>
Reply-To: nagray@austin.rr.com
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1070587102.27071.159.camel@hawaii.efficax.net>
Mime-Version: 1.0
Date: Thu, 04 Dec 2003 19:18:22 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I rebooted the system and logged into the console

newrole -r sysadm_r

dmesg | grep ssh

avc:  denied  { signal } for  pid=1002 exe=/usr/sbin/sshd
scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t
tclass=process

I dont think I get this one at all, unless the process which is starting
sshd is what is not able to send a signal or is it sshd can't send a
signal out?

now I walk over to a terminal and ssh in.

newrole -r sysadm_r

dmesg | grep ssh

avc:  denied  { signal } for  pid=1002 exe=/usr/sbin/sshd
scontext=system_u:system_r:sshd_t tcontext=system_u:system_r:sshd_t
tclass=process

avc:  denied  { getattr } for  pid=1055 exe=/usr/sbin/sshd name=xauth
dev=03:02 ino=2261013 scontext=system_u:system_r:sshd_t
tcontext=system_u:object_r:bin_t tclass=file

avc:  denied  { name_bind } for  pid=1055 exe=/usr/sbin/sshd port=6010
scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:port_t
tclass=tcp_socket

The first one is the message that is still there from the startup. I'm
not sure I understand the next two though.

The daemon wants getattr access to xauth (Why) and it wants to bind to
6010. (Why)

More importantly the question is if these are normal why aren't the
covered by the policy already in place? I certainly didn't go out of my
way to change the behavior of SSH.

A google search of "SSH" and 6010 indicates that this is normal behavior
when the daemon is started with port forwarding turned on. So the
question again is since this is "Normal" for Redhat, what is up with the
policy??

Nix

-- 
Never give a cow a typewriter - Click, Clack, Moo

Nick (Nix) Gray
Senior Systems Engineer
Bruzenak Inc.
(512) 331-7998

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
