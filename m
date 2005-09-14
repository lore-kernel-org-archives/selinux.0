Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <432799F0.7060706@cornell.edu>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>
	 <432799F0.7060706@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 09:00:11 -0400
Message-Id: <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 23:33 -0400, Ivan Gyurdiev wrote:
> Yes, I agree here - the DEBUG system is really doing error handling...
> it detects an error condition, and informs the caller of what went wrong 
> at every level of
> the function stack (at least that's how I use it in the user and port 
> functions). It has no effect
> if there is no error condition. Perhaps it's a misnomer.

To be precise, DEBUG() is providing supplemental information when an
error occurs to help in debugging the underlying cause.  The error
handling itself consists of just returning an error code up the call
chain (although they aren't as informative as one might like).
write_error() is likewise providing supplemental information when an
error occurs, but is focused on just reporting informative error
messages to the user rather than helping with debugging the underlying
cause or the precise point of failure.

write_error() is also limited to a single error message, whereas DEBUG()
can emit any number of messages during a single operation.  This shows
up particularly in the assertion checking code where we'd like (at least
for checkpolicy) to report all assertion violations in one pass.
Similarly, it would be nice if the hieararchy checking code could report
all violations in one pass (and if it provided more detail about the
actual cause of the violation).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
