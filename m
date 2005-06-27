Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5RMXWgA028839
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 18:33:33 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5RMWKMC016023
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 22:32:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach
Date: Tue, 28 Jun 2005 08:32:42 +1000
Cc: selinux@tycho.nsa.gov
References: <20050627153200.88746.qmail@web31609.mail.mud.yahoo.com>
In-Reply-To: <20050627153200.88746.qmail@web31609.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506280832.46267.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 28 June 2005 01:32, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > MLS category combinations
> > that may be used.  We have 10 sensitivity levels in
> > the default MLS policy at
> > the moment and 128 categories.  Therefore there are
> > 10*2^128 possible MLS
> > combinations that may be assigned to a user
> > identity.
>
> In the 15 years I've been dealing with MLS systems I
> have never seen anyone encounter the problems of
> category permutations. A given user will be in a
> single
> category, and usually a single level. In truth, a site
> will usually use levels or catagories, but almost
> never
> both. Further, a given site will usually use
> system-high,
> system-low, and two or three others.

That will make things easier for us.

> > senior managers).  In such a
> > scheme all managers would need separate entries in
> > the users file and all
> > non-managers would be mapped into a group depending
> > on who they report to.
>
> Yes, I can see how that might result in issues.
> I'll refer back to the marketplace experience, which
> indicates that it is not likely you will see MLS taken
> advantage of to this granularity.

That's interesting to know.

> > > Well, they need to add the MLS charactoristics.
> >
> > Yes, but let's not get hung up on that.  We are
> > talking about what has to be
> > done to manage users.
>
> Of course. Users with a degenerate clearance (one MLS
> level+category-set) are strait forward. Users with
> large
> or discontiguous clearance (six levels and multiple
> categories, with combinations) may require more
> attention, especially regrading home directories and
> mailboxes.

Yes, home directory labeling for users with multiple clearance levels will be 
an issue.

> > > This I don't understand 'tall.
> >
> > If the organization policy requires that each Unix
> > user has a separate set of
> > SE Linux access rights then every time a Unix user
> > is added a change will
> > have to be made to the SE Linux policy database on
> > every machine.  The new
> > feature is designed to dramatically reduce the
> > number of changes to the
> > policy database, but it won't be useful for
> > everyone.  It should be a no-cost
> > option though so anyone who doesn't want it can just
> > not use it.
>
> Where the feature is MLS, right?

In the context of this discussion when I say "the new feature" I mean the 
ability to have arbitrary mappings between Unix user-names and SE Linux 
identities.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
