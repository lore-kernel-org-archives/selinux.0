Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA08707
	for <selinux@tycho.nsa.gov>; Sat, 6 Jan 2001 23:46:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id EAA27905
	for <selinux@tycho.nsa.gov>; Sun, 7 Jan 2001 04:45:24 GMT
Received: from ausmac.net (ausmac.net [203.12.68.15])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id EAA27900
	for <selinux@tycho.nsa.gov>; Sun, 7 Jan 2001 04:45:22 GMT
Date: Sun, 7 Jan 2001 15:46:24 +1100 (EST)
From: Grant Bayley <gbayley@ausmac.net>
To: Sara Spencer <dirty_dazy@yahoo.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Embedded SE Linux
In-Reply-To: <20010107031708.29621.qmail@web4204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.30.0101071510010.5312-100000@ausmac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

> Are there any plans to create an embedded se linux
> kernel ?
>
> With Web TV 2 comming out worldwide soon and wireless
> boxes and home firewalls/router boxes a secure
> embedded kernel would be interesting. For many
> aplications such as embedded server and others the
> kernel could be embedded emcrypted with light elyptic
> curve crypto and be possibly more safe if the gear is
> compromised .

I wasn't aware that Security Enhanced Linux added any cryptographic
features to the Linux kernel - as far as I was aware it makes an attempt
to remove the need for a single, omnipotent "root" user by assigning
administration capabilities to other users.

Why would one need a server in an otherwise download-only device?

I applaud the desire for security in such devices but question whether
this need isn't better provided for by other "overall" security-enhanced
operating systems and kernels (read: OpenBSD perhaps?).

(A question for the SE Linux team while I'm here, if that's okay...
Although it's been somewhat irrationally debated on Slashdot (nuff said),
was there any particular technical reason for selecting Linux over
OpenBSD or contributing to TrustedBSD (which is a set of patches for
FreeBSD)?  Even putting the issue of security and crypto enhancements
in OpenBSD aside, I'd have thought the "whole system" approach would make
it easier to supply a kernel and userland patch that users could apply to
/usr/src (as opposed to the "packager" model that alot of Linux distros
tend to follow).)

Grant


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
