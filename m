Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA21943
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 14:18:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA04251
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 19:16:48 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA04247
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 19:16:48 GMT
Date: Tue, 29 Oct 2002 14:17:55 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: font paths
In-Reply-To: <200210281457.20996.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210291417080.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 28 Oct 2002, Russell Coker wrote:

> http://lists.debian.org/debian-kde/2002/debian-kde-200210/msg00605.html
>
> Please read the above discussion about font paths used by KDE.  I imagine that
> GNOME is likely to do the same (if they don't already).
>
> Would it make sense to have a user_home_xfont_t for the fonts so the X server
> can read them but not the rest of the user's files?

Does the same issue arise for other user-configurable data that X needs to
read?  If so, you might want a more general type for this purpose.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
