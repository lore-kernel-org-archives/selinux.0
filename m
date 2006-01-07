Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k071JWXf008649
	for <selinux@tycho.nsa.gov>; Fri, 6 Jan 2006 20:19:32 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k071JTfk004193
	for <selinux@tycho.nsa.gov>; Sat, 7 Jan 2006 01:19:30 GMT
Subject: Re: setfiles and restorecon performance patch
From: Stephen Tweedie <sct@redhat.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200601031959.34132.russell@coker.com.au>
References: <200601031959.34132.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 20:19:22 -0500
Message-Id: <1136596762.4478.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Tue, 2006-01-03 at 19:59 +1100, Russell Coker wrote:

> Stephen, please let me know what your instinct is regarding cache sizes for 
> this.

8192 sounds a bit large; 1024 sounds better.  In fact, to be honest, a
lookahead of a dozen or so would probably be fine in this particular
scenario --- the child process doing the stat()s is still going to be
fully serialised on its IO, so there's no opportunity to reorder IOs and
so no opportunity to schedule disk IO better by giving the kernel a
larger pool of IOs to work on.

But you're unlikely to exhaust the cache and so evict things during this
scan; at least not at 1000 entries.  dcache sizes are often in the tens
if not hundreds of thousands.

Cheers,
 Stephen



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
