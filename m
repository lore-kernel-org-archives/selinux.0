Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9AHs8Wt005040
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 13:54:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9AHs7Ub018789
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 17:54:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9AHs6hX018785 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 17:54:06 GMT
Subject: Re: 2.6.0-test6 login/avc denied
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3F86EC8E.9090005@ipen.br>
References: <3F86EC8E.9090005@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1065808438.8181.497.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Oct 2003 13:53:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-10 at 13:29, Carlos Anísio Monteiro wrote:
> 1) Always that login at system, it request the role and the type.

This just indicates that /bin/login hasn't been labeled yet, so the
login process is not running the correct domain and it cannot
automatically determine a default domain for the user (since no user
domains are reachable from the domain in which it is running).  I have
an experimental patch to provide a failsafe context so that login, sshd,
and gdm will fall back to a failsafe context (typically
sysadm_r:sysadm_t, but configurable) if security_compute_user returns an
empty list.  

> 2) Messages: AVC: denied "make relabel" command was running. But, messages 
> continue.

These messages are ok; they just reflect the fact that the kernel would
deny the access if it was in enforcing mode (but you are presumably in
permissive mode at this point, since you haven't labeled the filesystem
yet).  See the discussion of the Development Support option and
permissive mode in the README.

> How do I resolve this ?

You need to let the relabeling finish, and then reboot the SELinux
kernel again, as per the README.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
