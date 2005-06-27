Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5R3iXgA021226
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 23:44:33 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5R3i4FZ023755
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 03:44:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach
Date: Mon, 27 Jun 2005 13:43:57 +1000
Cc: selinux@tycho.nsa.gov
References: <20050627024312.86723.qmail@web31601.mail.mud.yahoo.com>
In-Reply-To: <20050627024312.86723.qmail@web31601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506271344.01368.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 27 June 2005 12:43, Casey Schaufler <casey@schaufler-ca.com> wrote:
> --- Russell Coker <russell@coker.com.au> wrote:
> > So the issue that you are raising is that the number
> > of combinations of MLS
> > clearance is potentially 2^(number of categories) *
> > (number of levels) which
> > is much greater than 2^(number of roles in strict
> > policy), and that the
> > number of such combinations which is desired in MLS
> > may be significantly
> > greater than the number of role combinations which
> > are desired with a strict
> > policy.
>
> I don't intend to raise number-of-policy issues.

It's not the number of policies, but the number of MLS category combinations 
that may be used.  We have 10 sensitivity levels in the default MLS policy at 
the moment and 128 categories.  Therefore there are 10*2^128 possible MLS 
combinations that may be assigned to a user identity.  Naturally a single 
policy won't contain a small fraction of them, but it's still likely to 
contain a much larger number of combinations than with the strict policy 
which only has membership of three roles (of which only five combinations are 
sensible).

> I said that I wouldn't do that.
> I am curious how MLS is going to interact with the
> rest of the policy rules.

But surely that has nothing to do with the issue of mapping Unix account names 
to SE Linux access which is the topic of this thread.

> > This will make management a little more complex, but
> > I don't imagine that the
> > situation of having the number of SE Linux
> > identities approaching the number
> > of Unix accounts will be common.
>
> That's handy.
>
> > I expect that in
> > most real systems they
> > usually choose a category of access to grant each
> > user as assigning access
> > individually to each user is more effort.
>
> I'm not sure I understand your meaning.

In a company you will have an administrator, department heads, and within each 
department you will have access granted to middle managers and non-managers.  
The access granted to non-management employees will be the same for large 
numbers of employees.  If each middle manager is given a different category 
for them and their staff then the number of different sets of access rights 
will be 2*(number of middle managers)+(number of senior managers).  In such a 
scheme all managers would need separate entries in the users file and all 
non-managers would be mapped into a group depending on who they report to.

> > For the case where each Unix user has a discrete set
> > of access rights the
> > administrator would just do exactly what they do
> > today.
>
> Well, they need to add the MLS charactoristics.

Yes, but let's not get hung up on that.  We are talking about what has to be 
done to manage users.

At the moment with the strict policy you have to add a line to the users file 
and recompile and load the policy.  With MLS the operation is essentially the 
same, you just need some extra data in the line added to the users file.

> > Their security
> > policy merely prevents them from taking advantage of
> > the new feature which we
> > are designing.
>
> This I don't understand 'tall.

If the organization policy requires that each Unix user has a separate set of 
SE Linux access rights then every time a Unix user is added a change will 
have to be made to the SE Linux policy database on every machine.  The new 
feature is designed to dramatically reduce the number of changes to the 
policy database, but it won't be useful for everyone.  It should be a no-cost 
option though so anyone who doesn't want it can just not use it.

> > It's not a problem of the feature,
> > just a fact that it won't
> > be useful for everyone.
> >
> > Although there is something to be said for using GID
> > numbers.
>
> Agreed in practice if not principle.

Absolutely.  Using GID numbers sucks badly, and I am not seriously pushing for 
using it.  Just noting the fact that group names have some potential issues.  
But I guess we can just say "don't do that".  The groupadd program refuses to 
create such groups, so you have to use vigr to add them and then the groupdel 
program won't remove any of the groups in question if the GID is the primary 
GID for some user.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
