Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB634kRb009202
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 22:04:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB634jRV023371
	for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 03:04:45 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id hB634gta023362 for <selinux@tycho.nsa.gov>; Sat, 6 Dec 2003 03:04:43 GMT
Date: Tue, 2 Dec 2003 20:59:15 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policy under version control
Message-ID: <20031202095915.GA28563@snoopy.apana.org.au>
References: <20031129132619.GE26960@lukas.schuldei.com> <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil> <20031201202813.I16359@lemuria.org> <200312021430.51186.russell@coker.com.au> <20031202080830.E17580@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031202080830.E17580@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 08:08:34AM +0100, Tom wrote:
> That's exactly where a more modern replacement of 20-year-old CVS would
> help. From what I read about arch, it would be well possible to define,
> say:

s/arch/tla/

arch is obsolete now, and replaced with tla.

tla is the only revision system that I know of (besides Bitkeeper) that
supports distributed repositories, which I think could be rather
important for selinux policy.

So I could maintain my own private repository, keep it up to date with
changes to selinux, while still maintaing a revision history of my
changes.

Sure, you can do this with CVS vendor branches, but this can get clumsy,
and CVS wasn't designed for this purpose.

The only question mark I have with tla, is that I have never seen a
conflict, and I don't know how easy it is to resolve conflicts.

There also are a few issues that take a bit of getting use to,
especially if you are use to CVS. For instance, you don't commit
individual files like in CVS, you commit a number of files in one go,
and the revision of the entire project gets incremented (eg.  similar so
a changeset in Bitkeeper or a commit operation in Subversion).

(then again, I haven't migrated from using arch to tla yet for my
projects either, but I will save that for another thread).
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
