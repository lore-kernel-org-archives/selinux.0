Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SCZ7rT009330
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 08:35:07 -0400 (EDT)
Received: from oe-im2.bizmailsrvcs.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6SCYaAN004268
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 12:34:37 GMT
Message-ID: <41079D11.40600@tresys.com>
Date: Wed, 28 Jul 2004 08:33:21 -0400
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Valdis.Kletnieks@vt.edu, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts.
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil> <20040727160605.GG3392@lkcl.net> <200407271940.i6RJebSp032388@turing-police.cc.vt.edu> <20040727212836.GA21236@lkcl.net>
In-Reply-To: <20040727212836.GA21236@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:
>  
>  yes, sort-of: more that i only wish to limit what programs a user
>  can run (and what programs _those_ programs can run).
> 

That seems pretty straightforward using transition rules.

>  in particular, i want to stop people from being able to use the
>  "Run" capability of Konqueror, etc.  STOP, not have the popup coming
>  up with "are you sure you want to run this program?".
> 

You may not have to worry about that if you've defined, via policy, what 
the user (i.e., the domain they are in when running Konqueror, etc.) is 
allowed to run.

> 
>  setting up a kdeusers group, chgrp'ing the allowed programs
>  to that group, and setting permissions to 0660 is what i really
>  need...
> 

0660 is -rw-rw----, I think you meant 0550, -r-xr-x---, right?

>  ... but i wondered if there was a way to do that same thing in
>  SE/Linux...
> 
>  ... _without_ writing a whole stack of policies, one per program.
> 

That's your real issue.  You can accomplish the equivalent (of your 
chgrp scenario) by defining a domain for all the allowed user programs 
and causing a domain transition whenever a user (in your limited user 
domain) executes an allowed program.  Then you only have to write a 
policy that covers the needs of the set of allowed user applications. 
That gets you the equivalent (actually it's possibly a _little_ better 
because you limited the permissions to only what the group needs and you 
removed excess permissions that the user may have had when they enter 
the new domain).

What you really _need_ is a whole stack of policies so that each program 
is limited to only what it needs.  It's up to you to determine if your 
intended environment requires the effort to do that. With some analysis 
you may also find that you can define policies for subgroups of programs 
instead of having individual policies for every program.

>  a macro i could write that would let me do this:
>  
>  allow_user_kde_access(konqueror_exec_t)
>  allow_user_kde_access(k3b_exec_t)
> 
>  with all that that implies.
> 
>  or, to simply set all the allowed kde executables into
>  kde_user_exec_t type, and set this on /usr/bin/konqueror,
>  /usr/bin/k3b, /usr/bin/koffice etc.
> 

You just need to be very careful that you don't end up granting so much 
permission to a generic kde domain that you've accomplished nothing. 
I'd recommend the judicious use of neverallows to ensure that you've not 
accidentally allowed something you meant to deny.  I'd also recommend 
the use of our analysis tool, apol (www.tresys.com/selinux ).

David


-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
