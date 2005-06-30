Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5UCsjgA021751
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 08:54:45 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5UCr6Bs017449
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 12:53:07 GMT
Message-ID: <42C3EB52.4000208@tresys.com>
Date: Thu, 30 Jun 2005 08:53:38 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: wish-list item for selinux policy analyss
References: <20050629021349.GA10219@lkcl.net>
In-Reply-To: <20050629021349.GA10219@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>dear selinux people,
>
>on my wish-list for selinux is a means to tell, at runtime,
>which avc messages have been utilised.  not when - if.
>
>the equivalent of code coverage analysis tools.
>
>i envisage this to be implemented - hand-waving - by a single
>bit which is marked in the in-kernel-memory store of selinux avc
>policy, for reasons of minimising impact on run-time performance
>(i believe that tying something into the avc audit logging
>system, would be too slow).
>
>the reason for this is to be able to fire up a system, run
>it for a while (live) say oh a few months, and then determine
>which bits of the selinux policy.conf have never ever actually
>been used.
>
>track them down, and remove them from the selinux source policy.
>
>... via analysis of the policy.conf, back to the macros from
>whence they came.
>
>l
>  
>
Not that I think this is a good idea; many rules are only there for 
corner case situations or errors but if you really want to do it you 
don't even need a new tool, the existing ones will do just fine.

First add an auditallow * * for all object classes and permissions, then 
reload that policy
wait until you have the data you want (6 months should yield a few tb of 
logs)
grep granted /wherever/log | sed -e s/granted/denied/ | audit2allow > 
somefile
then sediff /etc/selinux/strict/policy/policy.18 somefile

you'll want to diff against the binary since the audit messages will be 
the equivalent of an expanded policy
Have fun, you'll probably get 100,000's of rules

you could use apol at this point to track down the rules in the 
policy.conf.. tracing back to the macro call that made it will be very 
challenging though

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
