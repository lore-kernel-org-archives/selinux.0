Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0BNlDXf002264
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 18:47:13 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0BNlBca029509
	for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2006 23:47:11 GMT
Subject: Re: Latest policy diffs, very large
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43C58596.90900@redhat.com>
References: <43BAD603.5060209@redhat.com> <1136829416.29815.97.camel@sgc>
	 <43C58596.90900@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 18:47:52 -0500
Message-Id: <1137023272.29815.172.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I already have mered a large portion of the previous iteration, can you
rebase this patch, excluding alsa and locate (I have copies of them
now)?

On Wed, 2006-01-11 at 17:24 -0500, Daniel J Walsh wrote:
> Whats up with prelink?

Sorry, have been clearing up some backlog.  This is committed; I moved
it to admin, since its not really a service.

> What's up with locate?

I'm merging it with the version one of the guys here did while I was
away during the holidays (as I was also doing with prelink),

> Added alsa policy

same with this, now.

I made sure the status page on sourceforge is up to date, please make
sure to check this, so we don't duplicate effort, and let me know when
you start working on one of the modules so I can mark it on that page
too.

> We need a semodule policy...

Yes.  Does that mean you volunteer?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
