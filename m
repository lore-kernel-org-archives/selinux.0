Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA24258
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 11:05:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA14907
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 15:03:59 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA14903 for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 15:03:59 GMT
Date: Fri, 12 Jul 2002 11:04:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: chattr
In-Reply-To: <20020712143618.5BF33CAD@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207121057000.28541-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Jul 2002, Russell Coker wrote:

> It seems that chattr depends on the "write" permission and that lsattr
> depends on the "read" permission.  I think that they should depend on
> "setattr" and "getattr" permissions respectively.
>
> jmorris@blackbird.intercode.com.au pointed out that it is possible to chattr
> /tmp on my SE play machine, "chattr +i /tmp /var/tmp /var/tmp/*" would be
> rather annoying...

I'm not sure I understand.  At least for ext2 and ext3, chattr calls
ioctl with a EXT[23]_IOC_SETFLAGS command, and SELinux performs a setattr
permission check in its selinux_file_ioctl hook for this command.  The
ext2 and ext3 filesystem code also performs capability checks for setting
flags on files that are not owned by the process (the fowner
capability permission) and for changing the immutable or append-only flags
(the linux_immutable capability permission).  chattr +i /tmp fails for
user_t on my systems.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
