Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB7BbpRb012697
	for <selinux@tycho.nsa.gov>; Sun, 7 Dec 2003 06:37:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB7Bb9lU026880
	for <selinux@tycho.nsa.gov>; Sun, 7 Dec 2003 11:37:09 GMT
Received: from unicorn.lemuria.org (d003196.adsl.hansenet.de [80.171.3.196])
	by jazzswing.ncsc.mil  with ESMTP id hB7Bb8SX026877
	for <selinux@tycho.nsa.gov>; Sun, 7 Dec 2003 11:37:08 GMT
Date: Sun, 7 Dec 2003 12:30:47 +0100
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policy under version control
Message-ID: <20031207123046.D22784@lemuria.org>
References: <20031129132619.GE26960@lukas.schuldei.com> <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil> <20031201202813.I16359@lemuria.org> <200312021430.51186.russell@coker.com.au> <20031202080830.E17580@lemuria.org> <20031202095915.GA28563@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031202095915.GA28563@snoopy.apana.org.au>; from bam@snoopy.apana.org.au on Tue, Dec 02, 2003 at 08:59:15PM +1100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 08:59:15PM +1100, Brian May wrote:
> arch is obsolete now, and replaced with tla.

True.


> So I could maintain my own private repository, keep it up to date with
> changes to selinux, while still maintaing a revision history of my
> changes.

Exactly. I am, for example, still missing my subversion policy from the
default thing. Instead of buggering people to include it, I could
simply set it up in my own repository and be done.


> There also are a few issues that take a bit of getting use to,
> especially if you are use to CVS. For instance, you don't commit
> individual files like in CVS, you commit a number of files in one go,
> and the revision of the entire project gets incremented (eg.  similar so
> a changeset in Bitkeeper or a commit operation in Subversion).

I've been using Subversion for well over a year now with a small team
of developers, and those changes are really easy getting used to.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
