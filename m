Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <432CE470.1020400@cornell.edu>
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
Content-Type: text/plain
Date: Mon, 19 Sep 2005 08:49:37 -0400
Message-Id: <1127134177.29404.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-09-17 at 23:52 -0400, Ivan Gyurdiev wrote:
> I'm not sure we need both a filtering mechanism, and two systems - one 
> for debugging and one for error reporting.  That looks like redundancy 
> to me. I think we need to choose one debug system, add a filtering 
> mechanism to it, and convert everything to use it. The filtering 
> mechanism would then determine what's done with the different types of 
> messages (which are not too clear at the moment).

I viewed it more as:
- drop the notion of level/priority since you explained how you can't
truly classify the different DEBUG messages into those categorizations,
- don't clutter a single interface trying to support both variants, just
keep them as separate interfaces,
- recognize that both DEBUG and write_error are doing error reporting,
but with differing feedback mechanisms (global callback vs. per-call
error buffering) and with differing levels of detail.

I expected to use DEBUG() pervasively as the default mechanism, and only
selectively insert write_error calls (and extend interfaces to take the
buffers) as needed to support the specific needs of the policy
management daemon.  Policy management daemon would then disable the
DEBUG output or redirect it to a log file and only feed the buffered
error messages back to the client.

But if you really want to go down this road...

> There's the issue of global vs per-function-state. I think the second 
> one wins here, and we'll just have to adjust the shared APIs. We could 
> create something similar to the semanage handle, which encompasses a 
> policydb, as well as error handling. I think libsepol should be the 
> library that manages the policydb object.

The second one is more general, although I'm not entirely convinced it
is needed.  I agree that having libsepol properly encapsulate the
policydb would be good.

> There's the issue of multiple errors - I think any error system needs to 
> support multiple error messages.

Agreed.

> Then there's the issue of buffer vs callback. I think callback wins 
> here. Provided function-local state, there's no reason not to have a 
> callback. If you want buffering services, you can arrange for that in 
> the callback. We should add a void* argument to the callback, and keep 
> that in the state object, passing it at every invocation.

I agree with this as well; the current error buffers are clearly
unsatisfactory for assertion and hierarchy checking.

> The function name.... is irrelevant if we go with the callback system - 
> callback can drop the name. I think it's useful, and it should stay.

Yes.

> Callback should look something like this, maybe ?
> We can write macros to reduce arguments...
> 
> int (*DEBUG_v2) (
>     void* arg,               /* Caller supplied argument */
>     int level,                 /* WARN, ERROR, DEBUG ...kind of like MLS 
> level - notion of rank */
>     int channel,            /* Wine has this...not sure we need it... 
> similar to MLS category - area of debugging */
>     const char* fname,  /* Function name */
>     const char* fmt,      /* Format string */
>     ...)                         /* Format arguments */

If we use parallels to the existing syslog(3) levels (priorities), then
the callback can easily map the level/priority values and forward them
along to syslog(3) if desired.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
