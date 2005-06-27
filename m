Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5R2PVgA020898
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 22:25:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5R2ORqP005366
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 02:24:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach
Date: Mon, 27 Jun 2005 12:24:58 +1000
Cc: selinux@tycho.nsa.gov
References: <20050626174616.48163.qmail@web31608.mail.mud.yahoo.com>
In-Reply-To: <20050626174616.48163.qmail@web31608.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506271225.00771.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 27 June 2005 03:46, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > How does all this work with MLS ranges?
> >
> > How does it cause problems with MLS?
>
> Maybe it doesn't. On the other hand, can you
> explain how it might work if you have a user
> (I'll call him Barney today) who is cleared
> to Secret in compartment A17 and B43? Do we
> have to have a seperate role for Secret,A17
> and Secret,B32 or do we need SELinux users
>
>    Barney,Unclassified
>    Barney,Secret
>    Barney,Secret,A17
>    Barnet,Secret,B43
>    Barney,Secret,A17,B43

So the issue that you are raising is that the number of combinations of MLS 
clearance is potentially 2^(number of categories) * (number of levels) which 
is much greater than 2^(number of roles in strict policy), and that the 
number of such combinations which is desired in MLS may be significantly 
greater than the number of role combinations which are desired with a strict 
policy.

This will make management a little more complex, but I don't imagine that the 
situation of having the number of SE Linux identities approaching the number 
of Unix accounts will be common.  I expect that in most real systems they 
usually choose a category of access to grant each user as assigning access 
individually to each user is more effort.

For the case where each Unix user has a discrete set of access rights the 
administrator would just do exactly what they do today.  Their security 
policy merely prevents them from taking advantage of the new feature which we 
are designing.  It's not a problem of the feature, just a fact that it won't 
be useful for everyone.

> > Unix account names not UIDs. I think a mapping file
> > is the only way.
>
> Names not numbers, definitly.

Although there is something to be said for using GID numbers.  If you have 
number 500 in your GID field in /etc/passwd and there are two entries for 500 
in /etc/group then things can be ambiguous if using the group name.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
