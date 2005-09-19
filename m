Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <432EC5BD.2090203@cornell.edu>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>
	 <432799F0.7060706@cornell.edu>
	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>
	 <432823F0.3030803@tresys.com>
	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>
	 <43283772.7070603@tresys.com>
	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>
	 <432842D4.3070905@tresys.com>
	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>
	 <432CDC23.4010907@cornell.edu>  <432CE470.1020400@cornell.edu>
	 <1127134177.29404.31.camel@moss-spartans.epoch.ncsc.mil>
	 <432EC5BD.2090203@cornell.edu>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 10:45:28 -0400
Message-Id: <1127141128.29404.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-19 at 10:05 -0400, Ivan Gyurdiev wrote:
> I was saying that I'm not convinced you can consider the lowest-level 
> message of type ERROR, and the ones above it in the call chain of type 
> DEBUG. A different classification system might work, however... the 
> level argument could be useful.

True.

> We could easily move the level argument into the function name (support 
> WARN(), ERROR()), etc.

Yes.  The larger issue is introducing the state object arguments to the
interfaces and propagating them down to all DEBUG() calls.

> However, I think
> that's not necessary, because if we implement callbacks, and add a state 
> object to pass to
> the callbacks, the user of libsepol/libsemanage can design any error 
> system they feel like,
> which is more flexible than making that choice in the library.
> 
> Regarding the differing levels of detail - the callback can make that 
> decision if we provide it
> with the level of  message (error/debug..etc).

Yes, if we can usefully make such distinctions (due to the need to
provide higher level context to understand the lowest level errors).
What do you expect from the callbacks?  They can certainly do simple
things like drop the entire message based on level, drop the function
name information, etc, but constructing an overall error message that is
presentable to the client/user from the entire set of DEBUG() calls
seems difficult.
> 
> >I expected to use DEBUG() pervasively as the default mechanism, and only
> >selectively insert write_error calls (and extend interfaces to take the
> >buffers) as needed to support the specific needs of the policy
> >management daemon.  Policy management daemon would then disable the
> >DEBUG output or redirect it to a log file and only feed the buffered
> >error messages back to the client.
> >  
> >
> If we design the debug system properly, we can handle any usage pattern, 
> including this one.

True, but if this is the only usage pattern (in addition to the default
one of writing all DEBUG output to the user and not using the error
buffers at all for single-threaded users), then it seems overkill.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
