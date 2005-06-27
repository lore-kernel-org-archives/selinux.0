Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5RFWWgA024959
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 11:32:33 -0400 (EDT)
Received: from web31609.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5RFW0jQ019085
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 15:32:00 GMT
Message-ID: <20050627153200.88746.qmail@web31609.mail.mud.yahoo.com>
Date: Mon, 27 Jun 2005 08:32:00 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200506271344.01368.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Russell Coker <russell@coker.com.au> wrote:

 > It's not the number of policies, but the number of
> MLS category combinations 
> that may be used.  We have 10 sensitivity levels in
> the default MLS policy at 
> the moment and 128 categories.  Therefore there are
> 10*2^128 possible MLS 
> combinations that may be assigned to a user
> identity.

In the 15 years I've been dealing with MLS systems I
have never seen anyone encounter the problems of
category permutations. A given user will be in a
single
category, and usually a single level. In truth, a site
will usually use levels or catagories, but almost
never
both. Further, a given site will usually use
system-high,
system-low, and two or three others.

>  Naturally a single 
> policy won't contain a small fraction of them, but
> it's still likely to 
> contain a much larger number of combinations than
> with the strict policy 
> which only has membership of three roles (of which
> only five combinations are 
> sensible).
> 
> > I said that I wouldn't do that.
> > I am curious how MLS is going to interact with the
> > rest of the policy rules.
> 
> But surely that has nothing to do with the issue of
> mapping Unix account names 
> to SE Linux access which is the topic of this
> thread.

Okay, if you say so, I'll believe you. I really can't
say  that I understand the intended implementation
well enough to come to that conclusion. That's
why I asked.


> > I'm not sure I understand your meaning.
> 
> In a company you will have an administrator,
> department heads, and within each 
> department you will have access granted to middle
> managers and non-managers.  
> The access granted to non-management employees will
> be the same for large 
> numbers of employees.  If each middle manager is
> given a different category 
> for them and their staff then the number of
> different sets of access rights 
> will be 2*(number of middle managers)+(number of
> senior managers).  In such a 
> scheme all managers would need separate entries in
> the users file and all 
> non-managers would be mapped into a group depending
> on who they report to.

Yes, I can see how that might result in issues.
I'll refer back to the marketplace experience, which
indicates that it is not likely you will see MLS taken
advantage of to this granularity.
 
> > Well, they need to add the MLS charactoristics.
> 
> Yes, but let's not get hung up on that.  We are
> talking about what has to be 
> done to manage users.

Of course. Users with a degenerate clearance (one MLS
level+category-set) are strait forward. Users with
large
or discontiguous clearance (six levels and multiple
categories, with combinations) may require more
attention, especially regrading home directories and
mailboxes.

> At the moment with the strict policy you have to add
> a line to the users file 
> and recompile and load the policy.  With MLS the
> operation is essentially the 
> same, you just need some extra data in the line
> added to the users file.

That's reassuring.

> > This I don't understand 'tall.
> 
> If the organization policy requires that each Unix
> user has a separate set of 
> SE Linux access rights then every time a Unix user
> is added a change will 
> have to be made to the SE Linux policy database on
> every machine.  The new 
> feature is designed to dramatically reduce the
> number of changes to the 
> policy database, but it won't be useful for
> everyone.  It should be a no-cost 
> option though so anyone who doesn't want it can just
> not use it.

Where the feature is MLS, right?

> > Agreed in practice if not principle.
> 
> Absolutely.  Using GID numbers sucks badly, and I am
> not seriously pushing for 
> using it.  Just noting the fact that group names
> have some potential issues.  
> But I guess we can just say "don't do that".  The
> groupadd program refuses to 
> create such groups, so you have to use vigr to add
> them and then the groupdel 
> program won't remove any of the groups in question
> if the GID is the primary 
> GID for some user.

Anyhow, thanks for the clarifications. I'm still
trying to
wrap my brittle old whits around the SELinux MLS
implementation.




Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
