Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA16538
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 10:25:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0KFP8I14463
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 15:25:08 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id h0KFP6f14459 for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 15:25:06 GMT
Date: Mon, 20 Jan 2003 16:25:04 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: PHP and other CGI stuff
Message-ID: <20030120162504.D30542@lemuria.org>
References: <20030120141112.B29104@lemuria.org> <200301201505.47688.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301201505.47688.russell@coker.com.au>; from russell@coker.com.au on Mon, Jan 20, 2003 at 03:05:47PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 20, 2003 at 03:05:47PM +0100, Russell Coker wrote:
> I looked into that some time ago but discovered that PHP didn't work the same 
> when invoked as an external process.  When run by the php-cgi method it would 
> not correctly support IMP (the only PHP software I really care about).

Hm, that's something I will have to investigate. But if it doesn't act
the same, I'd consider that a bug and report it to the PHP people.


> Due to this I was unable to determine a better solution than to have a 
> seperate instance of Apache for every separate PHP domain.  This consumes 
> extra resources, but generally you don't have that many PHP customers...

Well, we have about 1000. So running seperate Apaches is definitely not
an option.



> second_user is designed for someone who can login via ssh, read mail with 
> mutt, etc.  For a different domain for web processes we need something a bit 
> different.  Some of the various options have been discussed here over the 
> last 18 months, but nothing has been done because the Apache policy basically 
> works, and is complex enough that no-one really wants to do a serious 
> re-write.

Ok, then I'm starting one now. After some experimentation I think I've
found a way. But what is the performance impacts of domains and rules?

I would create 10 domains/types and about 700 rules per hosted site
(this is after macro expansion, of course).
What would the memory and performance impact of 10000 new types and 700000 
rules be? If it just means another 512 MB of memory for the machine, that's
not a problem.



> I think that the entire way that Apache operates should be reviewed in light 
> of the way things are currently working in SE Linux policy and the usage of 
> typical systems.  Many things have changed since the Apache policy was 
> written, it's a bit of a dinosaur.

I posted an updated one in october, though it retains much of the old
stuff, it should be much newer. See my other posting earlier today.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
