Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28648
	for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 09:37:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA22395
	for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 13:35:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA22391 for <selinux@tycho.nsa.gov>; Thu, 5 Sep 2002 13:35:36 GMT
Date: Thu, 5 Sep 2002 09:36:38 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>, <linux-security-module@wirex.com>
Subject: Re: bug in SE Linux / LSM
In-Reply-To: <200209051047.55917.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209050912260.13061-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 5 Sep 2002, Russell Coker wrote:

> In my tutorial yesterday a Robert Dorn <selinux@rddorn.net>
> discovered a bug in the way SE Linux/LSM operates.
>
> If you login to a virtual console as an unpriviledged user you can use
> "loadkeys" to change the keyboard mapping for everything apart from the SAK
> sequence.
>
> But it would be better if we could just catch such remappings in SE policy, in
> 99% of all machines there is no cause for the user to remap the keyboard.

This issue is mentioned in the BUGS section of the loadkeys(1) man page,
although it doesn't appear to be entirely accurate.  If I understand
correctly, the relevant kernel code is the handling of the KDSKBENT ioctl
in drivers/char/vt.c.  The base kernel code appears to permit the use of
this ioctl as long as the process is the owner of the tty or the process
has CAP_SYS_TTY_CONFIG (2.5) or the process is root (2.4, legacy
superuser check).  The base kernel code further limits the ability to
remap the SAK by requiring CAP_SYS_ADMIN.

LSM hooks capable() and SELinux performs a parallel check for each
capability check, but that doesn't affect the code path when no capability
is checked (any non-SAK remapping by the owner or root in 2.4, any non-SAK
remapping by the owner of the tty in 2.5).  LSM does provide a hook in
sys_ioctl could be used to control this operation based on the file and
command (but not the argument, as it is a userspace pointer in this case).
At present, SELinux only implements specific permission checks for a small
set of ioctls that are generic operations or ext[23]-specific.  All other
ioctls merely cause a check of the generic 'ioctl' permission to the file.

We could implement an additional check for this particular ioctl in the
SELinux ioctl hook function, either using an existing capability or
defining a new permission for this purpose.  More generally, you would
really want to perform an audit of all ioctls relevant to your kernel
configuration.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
