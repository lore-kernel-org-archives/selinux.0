Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA09236
	for <selinux@tycho.nsa.gov>; Mon, 13 May 2002 11:59:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA22347
	for <selinux@tycho.nsa.gov>; Mon, 13 May 2002 15:57:57 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA22343 for <selinux@tycho.nsa.gov>; Mon, 13 May 2002 15:57:53 GMT
Date: Mon, 13 May 2002 11:58:23 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: .journal
In-Reply-To: <3CDFD7DC.158E4D41@dr-baldeweg.de>
Message-ID: <Pine.GSO.4.33.0205131151170.21547-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 13 May 2002, Carsten Grohmann wrote:

> Since a few days I use the ext3 filesystem. And now I am looking the
> correct rights for the journaling files (.journal). At this time I
> labeled as file_t. What is your opinion? Should it use an own type or is
> the file_t better?

You should define a new type for the .journal files, and limit access to
only a few domains.  The only reason that we haven't done so is that our
journal files aren't visible (created via mke2fs -j with a clean
filesystem rather than on an existing filesystem).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
