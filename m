Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5R2hhgA020986
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 22:43:44 -0400 (EDT)
Received: from web31601.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5R2hGFZ022902
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 02:43:16 GMT
Message-ID: <20050627024312.86723.qmail@web31601.mail.mud.yahoo.com>
Date: Sun, 26 Jun 2005 19:43:12 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200506271225.00771.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Russell Coker <russell@coker.com.au> wrote:


> So the issue that you are raising is that the number
> of combinations of MLS 
> clearance is potentially 2^(number of categories) *
> (number of levels) which 
> is much greater than 2^(number of roles in strict
> policy), and that the 
> number of such combinations which is desired in MLS
> may be significantly 
> greater than the number of role combinations which
> are desired with a strict 
> policy.

I don't intend to raise number-of-policy issues.
I said that I wouldn't do that.
I am curious how MLS is going to interact with the
rest of the policy rules.
 
> This will make management a little more complex, but
> I don't imagine that the 
> situation of having the number of SE Linux
> identities approaching the number 
> of Unix accounts will be common.

That's handy.

> I expect that in
> most real systems they 
> usually choose a category of access to grant each
> user as assigning access 
> individually to each user is more effort.

I'm not sure I understand your meaning.

> For the case where each Unix user has a discrete set
> of access rights the 
> administrator would just do exactly what they do
> today.

Well, they need to add the MLS charactoristics.

> Their security 
> policy merely prevents them from taking advantage of
> the new feature which we 
> are designing.  

This I don't understand 'tall.

> It's not a problem of the feature,
> just a fact that it won't 
> be useful for everyone.

> Although there is something to be said for using GID
> numbers.  

Agreed in practice if not principle.



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
