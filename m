Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13059
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 16:12:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA11706
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 20:10:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA11702
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 20:10:22 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy "bloat" ?
Date: Fri, 19 Apr 2002 22:11:53 +0200
References: <20020419185507.B11916@lemuria.org>
In-Reply-To: <20020419185507.B11916@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020419201154.4F75844F1A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Apr 2002 18:55, Tom wrote:
> One question for understanding: There are tons of files and rules in
> the example policy that are unnecessary for my install. So I've started
> to remove them, mostly in order to reduce the complexity and make
> everything easier to understand.

Good plan.  Take what you need from the sample policy and dump the rest.

> Is there any risk or noticeable performance impact from having
> unnecessary rules, e.g. dhcp stuff on a system that has neither client
> nor server installed?

Potentially a mistake in the policy could open a security hole in your 
system.  Therefore the smaller policy the safer you will be.  Also if you 
have a small policy then you can read through it all to make sure it does 
things you desire.

One issue is at the moment we have a single file_contexts file which has 
contexts for all files in the system, if you remove a file from the sample 
policy you will need to make a matching change to file_contexts.  But that 
will be solved in the next major release.

> If so, would it make sense to include a 2nd, "minimal" example policy?

It does not make sense to have another policy which is the same thing but 
with a few files removed.

It does make sense to have another policy with another approach to securing a 
system.  When I get the main sample policy working to my satisfaction I plan 
to produce some other sample policies.  One I plan to produce is for the same 
sort of chroot environments as GR Security, another for LOMAC type security.


PS  Today I released a new version of my Debian packages.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
