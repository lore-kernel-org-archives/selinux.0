Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00248
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 10:52:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA14414
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 15:51:19 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA14410
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 15:51:19 GMT
Date: Wed, 10 Jan 2001 10:51:48 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Johnathon Day <jcday@mail.thesportsregister.com>
cc: William Sloan <wsloan@occamnetworks.com>, selinux@tycho.nsa.gov
Subject: Re: Embedded SE Linux
In-Reply-To: <Pine.LNX.4.21.0101100941190.5905-100000@mail.thesportsregister.com>
Message-ID: <Pine.SOL.3.95.1010110104507.16290L-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Wed, 10 Jan 2001, Johnathon Day wrote:

> Logically, there can't be. I'm guessing that what was meant is that
> SELinux isn't going to have any specific patches which are for an
> embedded environment.
>
> However, since no such patches are required (except maybe the real-time &
> PPS patches), there is no distinction in the Linux world between an
> embedded and a non-embedded kernel. That's simply where you happen to be
> running it.

My mistake.  As you said, I meant that SELinux isn't going to have
any specific patches for an embedded environment.  I'm glad to hear
that is not an obstacle to using it for that purpose.  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
