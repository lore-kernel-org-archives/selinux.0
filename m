Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16712
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 08:27:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA05427
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 13:26:52 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA05421
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2001 13:26:52 GMT
Date: Mon, 26 Nov 2001 08:26:44 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: jeff burson <olmy@thistledown.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: selinux, openssh, ipv6
In-Reply-To: <Pine.LNX.4.33.0111232052040.26754-100000@smacky.thistledown.org>
Message-ID: <Pine.GSO.4.33.0111260813100.9982-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 23 Nov 2001, jeff burson wrote:

> A problem I've run into is regarding IPv6. At lsm kernel compile
> time, I compiled for IPv6 support and having it successfully
> running. The interface is listening on an assigned IPv6
> address and is pingable from another IPv6 device. However,
> the selinux install of OpenSSH does not appear to be listening
> on the IPv6 address (it is listening on the IPv4 address).
>
> I have not run into this problem with manual builds (or rpms)
> of regular openssh recently, so am trying to figure out what's
> wrong.

The SELinux modifications to sshd shouldn't affect the use of IPv6.  Does
the pure openssh-2.9p2 SRPM for RH7.1 work for you?  Did you get any log
messages in /var/log/messages when sshd started?

As a side note, LSM doesn't yet provide any hooks in the IPv6 code, just
in the IPv4 code, so some of the SELinux network access controls won't be
enforced if you are using IPv6.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
