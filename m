Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23464
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 09:05:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA27785
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 13:03:07 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id NAA27781
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2001 13:03:07 GMT
Date: Thu, 25 Oct 2001 09:04:30 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Dave Nielsen <dave@technogeeks.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problems with install
In-Reply-To: <Pine.LNX.4.33.0110242157360.1787-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.33.0110250849250.11191-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Oct 2001, Dave Nielsen wrote:

> What about breaking the instructions into two files and have the README
> point the user to the file that goes with the build that he is wanting.

The problem with this approach is that most of the INSTALLING instructions
are identical for the two cases, so there would be a lot of duplication.
I suppose you could just split the BUILDING instructions and leave the
INSTALLING instructions alone, but then you have multiple files that have
to be read to do a build and install.

Anyway, this is a lot of trouble for an option that we don't really
support (using SELinux as a separately loaded module rather than building
it into the kernel), so we could just drop these instructions entirely.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
