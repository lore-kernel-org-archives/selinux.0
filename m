Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <432823F0.3030803@tresys.com>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>
	 <432799F0.7060706@cornell.edu>
	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>
	 <432823F0.3030803@tresys.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 09:51:08 -0400
Message-Id: <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 09:21 -0400, Joshua Brindle wrote:
> Fair enough, for things like assertion and hierarchy checking we can 
> pass a function pointer in and use the same basic system without the 
> global DEBUG function pointer and still get what we want there. If we 
> tried to use DEBUG for error reporting (as I think Ivan is suggesting) 
> the calling function wouldn't get an error code, and thus check it's own 
> error state until the first call in the chain and could potentially lose 
> information. Having the specific error from the lowest point of failure 
> seems much more useful than getting a less and less specific error from 
> each funtion while propagating error codes.

I'm not sure I follow.  As currently used, I think a call to DEBUG() is
always followed by returning an error code (although there might
possibly be multiple calls to DEBUG() prior to returning, e.g. if we use
it in the assertion checking code in place of the fprintf), although
those error codes need to be more specific as well.

> I know modifying every function in sepol to use a write_error like 
> system is undesirable but libsemanage already has write_error used 
> exclusively so going to DEBUG with it also seems undesirable. 
> libsemanage already passes a handle which contains an error buffer which 
> gives us thread safety and the ability to easily return errors in a way 
> the client app can use them (semodule will probably just print them out, 
> whereas the policy server will have to do more).
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
