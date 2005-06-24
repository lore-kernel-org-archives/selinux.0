Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OGb6gA007827
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 12:37:06 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OGaxUD021446
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 16:37:04 GMT
Message-Id: <200506241636.j5OGauqc016824@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Casey Schaufler'" <casey@schaufler-ca.com>, <selinux@tycho.nsa.gov>
Subject: RE: file contexts and modularity
Date: Fri, 24 Jun 2005 12:36:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20050624155123.43926.qmail@web31601.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Casey Schaufler
> Sent: Friday, June 24, 2005 11:51 AM
> To: selinux@tycho.nsa.gov
> Subject: RE: file contexts and modularity
> 
> 
> 
> --- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > This is something that I think merits further
> > discussion.  I think that
> > the real problem is that the avtab size has grown
> > far beyond what we
> > originally anticipated and this is hurting us both
> > in time (to
> > manipulate policies, to load policies, and even to
> > search the avtab) and
> > in space (kernel memory consumption by the avtab is
> > huge).  We certainly
> > didn't expect the avtab to reach 484,677 distinct
> > entries (FC4 strict
> > policy) and even the targeted policy in FC4 is now
> > up to 215886 entries.
> 
> With close to half a million (Ack!) rules you
> end up with a memory burden that would be
> excessive even if you could represent a rule in
> a single byte. Oh sure, you could swap out rule
> pages on a LRU scheme, or hash them to death,
> but the basic problem is not the representation
> of hundreds of thousands of rules, it's a matter
> of having hundreds of thousands of rules. Good
> heavens, the policy file is starting to look
> like the IRS tax code.
> 

Let's try to separate out the problems correctly. There are 2 issues:

1) The current kernel avtab makes an inappropriate space / time tradeoff.
2) The current policies are not sufficiently designed and may have too many
rules.

1 can be fixed even if 2 is true, which it might be. We are trying to address
that with refpolicy. I would encourage you to make concrete suggestions for the
reference policy - one of its aims is to add the design component to SELinux
policies that you are suggesting. Otherwise, your opinions on SELinux policies
are clear at this point - is it doing any good to restate them in threads that
are only tangentially related?

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> Casey Schaufler
> casey@schaufler-ca.com
> 
> 
> 
> ____________________________________________________
> Yahoo! Sports
> Rekindle the Rivalries. Sign up for Fantasy Football
> http://football.fantasysports.yahoo.com
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
