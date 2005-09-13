Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Joshua Brindle <jbrindle@tresys.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <4327521D.5020605@cornell.edu>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 19:03:57 -0400
Message-Id: <1126652637.30915.18.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 18:26 -0400, Ivan Gyurdiev wrote:
> >We likely want to distinguish between debugging output (that should be
> >off by default) and error reporting output (that should always be
> >enabled).  
> >
> Yes, we don't make that distiction currently. My patch treats all output 
> as debugging. On the other hand, however, it leaves debugging as 
> on-by-default for compatibility. I think we might not want any error 
> reporting output in library code - libraries should use status codes to 
> report the problem
> 
> >Tresys had some concerns with the DEBUG() interface for
> >multi-threaded servers iirc.
> >
> >I've noted some concerns with their
> >write_error() interface in regards to have a uniform interface and
> >shared implementation and with the level of detail presently provided
> >via write_error().
> >  
> >
> I think there needs to be consistency across the library, whether it's 
> DEBUG or write_error. The problem is that write_error requires 
> significant modifications to APIs (user needs to pass error buffer to 
> the library), whereas DEBUG does not, since it maintains the 
> library-wide debugging. This is going to be a problem for the new 
> semanage code I plan to put in as well...which currently uses DEBUG, 
> which does not exist in semanage. If error buffers are required, I 
> should alter the API to new functionality to support those. In any case, 
> I think printfs are the wrong thing to do, and should be eliminated from 
> sepol.
> 

Yes, libraries should not be outputting error conditions to the stdout
or stderr. They should pass error strings and values to the frontend
apps. 

The write_error is to pass an _error condition_ to the front end, this
has nothing to do with debugging. Personally, I don't know what the
value of a specialized debugging system in the library is when gdb and
integrated debuggers are so good, but clearly handling errors and
passing descriptive error messages to the frontend are necessary.

If you have debug on-by-default it seems like you are really doing error
handling. If this is the case we may need to consolidate these systems
but error handling and debugging are hardly the same things.

iirc, as Steve mentioned, there are some thread safety issues with DEBUG
and since both the userspace security server and the policy management
server are threaded this could be problematic. 

DEBUG also passes the function name, which may be useful for debugging,
but is hardly useful for error reporting. 

The error system should be about passing descriptive messages to the
caller and this needs to be done by passing a buffer to the functions
that may return an error, not be setting a function pointer to an
arbitrary function in the frontend to handle error conditions.

Joshua


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
