Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43287BDC.1090004@cornell.edu>
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
	 <43284A6B.8080507@tresys.com>  <43287BDC.1090004@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 15:50:13 -0400
Message-Id: <1126727413.12299.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 15:37 -0400, Ivan Gyurdiev wrote:
> So, I'm not clear on the exact migration steps that need to be taken here.
> I've just changed a lot of printfs to DEBUG calls. I'm not entirely sure 
> whether
> they qualify as error reporting or debugging (probably the former).

Yes, that does seem to be the common case.

>  In 
> fact,
> the distinction is still a bit lost to me - it seems as if all current 
> uses of DEBUG
> are for error handling, and none are for debugging. Perhaps you could 
> give an
> example to clarify the situation...

Offhand, I don't know of an actual debugging user of DEBUG() yet,
although it seems that the if (state->verbose) printf statements in the
Tresys code would qualify as potential debugging users.  There are also
"informational" cases, like the printfs in policydb_index_others.
syslog(3) does have distinct notions of debug, info, warning, error,
critical, alert, and emergency as its priority values.

> Next, what to do we do with all those printf calls that remain, and the ones
> that are now DEBUG calls.... if they are in fact error-reporting statements,
> then I understand you want them written in an error buffer. Where does
> the buffer come from, given the current API?

What particular interfaces are an issue here?  Interfaces that are only
exported by the static library can be modified with minimal impact.
sepol_genusers/genbools are going to be obsoleted by the shift to
regenerating the kernel binary policy file on each update to booleans or
users.  

In the interim, write_error can allow for the buffer to be NULL, in
which case it will only invoke the callback (if it is set) with the
other arguments as inputs.  If the buffer is non-NULL _and_ the
priority/level is >= the error level, then it will write the formatted
error message to the buffer and then invoke the callback (if it is set)
with the other arguments as inputs.  Hence, sepol_genusers/genbools can
continue to emit errors via the callback for now.

> I am in favor of moving all messaging systems into one .c and .h file,
> and making things more consistent.  I also like the idea of output
> levels for debugging and error-messaging, although I'm not entirely sure
> where I would use which.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
