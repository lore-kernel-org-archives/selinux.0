Message-ID: <432880A2.3090300@cornell.edu>
Date: Wed, 14 Sep 2005 15:57:22 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	<43264DAD.5090903@cornell.edu>	<1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	<4327521D.5020605@cornell.edu>	<1126652637.30915.18.camel@twoface.columbia.tresys.com>	<432799F0.7060706@cornell.edu>	<1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	<432823F0.3030803@tresys.com> <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil> <43283772.7070603@tresys.com>
In-Reply-To: <43283772.7070603@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> What I mean is, if there are multiple calls to DEBUG prior to 
> returning to the originating function then there are multiple error 
> messages of varying specificity sitting around somewhere, assuming we 
> even store them all and not just the last one. This isn't ideal for 
> error reporting, but it is for debugging. 

This isn't as clear-cut as it appears. It was never my intent to print 
the call stack for the purposes of debugging. That's why I say DEBUG is 
a misnomer. The reason I print the call stack at every level is exactly 
because you have different levels of specifity, which provide different 
kinds of information, and not always redundancy. The lowest level often 
doesn't make any sense at all, because it is too low-level. The levels 
above it provide context information as to what's going on. The callee 
by itself has no clue of the caller's intent. The caller has doesn't 
understand what the exact error was - they work together. This will 
become more clear with the record engine, which relies on polymorphism - 
the engine would not have a lot of information about what's going on 
with the particular record types. An individual handler working on a 
record would not know what the overall task/query was... a parsing 
helper would know exactly where the invalid input was, but wouldn't know 
what it represents, or why it's important.

That said, I agree that the end result isn't particularly user-friendly. 
It looks similar to what ALSA lib does
when it crashes in mplayer. I'm not entirely sure what should be done to 
fix it.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
