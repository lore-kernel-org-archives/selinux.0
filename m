Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA29641
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 08:41:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA19305
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 13:40:32 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA19301 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 13:40:32 GMT
Date: Wed, 6 Mar 2002 08:41:04 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: automatic type transitions for pts in devfs
In-Reply-To: <20020306124550.782B719F80@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203060828430.24985-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Wed, 6 Mar 2002, Russell Coker wrote:

> It seems that the automatic type transitions for /dev/pts don't work on
> devfs.  When the sshd (in sshd_t domain) opens /dev/pts/1 it does not get
> changed to sshd_devpts_t domain.

Right.  The initial labeling of pty nodes based on the allocating process
domain is only implemented for the devpts filesystem at present, not the
devfs filesystem.  The SELinux kernel module performs special processing
for the devpts filesystem type to ensure that new nodes are initially
labeled with the type specified by a type transition rule between the
domain that initially allocated the pty and the base devpts_t type.  When
sshd or rlogind allocate a pty in a devpts filesystem, it is initially
labeled by the kernel with a sshd_devpts_t or rlogind_devpts_t type and is
subsequently relabeled by sshd or login to the appropriate user_devpts_t or
sysadm_devpts_t type.  When a user runs X, his ptys are initially
allocated from the user_t or sysadm_t domain, so they are immediately
labeled with user_devpts_t or sysadm_devpts_t by the kernel.

At present, we don't use devfs on our systems, so it hasn't (yet) been a
priority to provide identical functionality in devfs.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
