Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA16873
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 11:45:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0KGjOI17641
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 16:45:24 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0KGjNf17637 for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 16:45:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: PHP and other CGI stuff
Date: Mon, 20 Jan 2003 17:45:13 +0100
Cc: selinux@tycho.nsa.gov
References: <20030120141112.B29104@lemuria.org> <200301201505.47688.russell@coker.com.au> <20030120162504.D30542@lemuria.org>
In-Reply-To: <20030120162504.D30542@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301201745.13703.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 20 Jan 2003 16:25, Tom wrote:
> > Due to this I was unable to determine a better solution than to have a
> > seperate instance of Apache for every separate PHP domain.  This consumes
> > extra resources, but generally you don't have that many PHP customers...
>
> Well, we have about 1000. So running seperate Apaches is definitely not
> an option.

True.

> Ok, then I'm starting one now. After some experimentation I think I've
> found a way. But what is the performance impacts of domains and rules?

They take up non-pagable kernel memory, which reduces the performance of the 
machine.

> I would create 10 domains/types and about 700 rules per hosted site
> (this is after macro expansion, of course).
> What would the memory and performance impact of 10000 new types and 700000
> rules be? If it just means another 512 MB of memory for the machine, that's
> not a problem.

It sounds like you are multiplying the size of the policy-db by a factor of 
30.  If you have 30 times the RAM of the smaller SE Linux machines (given 
your comment about 512M it sounds like you do) then it should be OK.

There's no reason to expect this to give any problems apart from RAM usage and 
load time (both of which should scale linearly to the size of the policy).

Try it, if it fails then file some appropriate bug reports.

> > I think that the entire way that Apache operates should be reviewed in
> > light of the way things are currently working in SE Linux policy and the
> > usage of typical systems.  Many things have changed since the Apache
> > policy was written, it's a bit of a dinosaur.
>
> I posted an updated one in october, though it retains much of the old
> stuff, it should be much newer. See my other posting earlier today.

Which posting?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
