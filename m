Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43264DAD.5090903@cornell.edu>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 15:59:28 -0400
Message-Id: <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-12 at 23:55 -0400, Ivan Gyurdiev wrote:
> The attached patch changes printf/fprintf usage in policydb.c, and
> avtab.c to the new debug system. This allows the user to set the print 
> function.
> It also writes to stderr by default, as opposed to stdout (which is 
> wrong, imho).
> As a side effect, this will append a more verbose prefix everywhere
> that gives the exact function name, rather than "security : mls" or 
> whatever.
> 
> This also removes the __sepol_debug_printf debug system from
> gen*, and changes genbools and genusers to use the newer system.
> 
> I haven't really tested this, but it's fairly straightforward, and I don't
> see what can break - it compiles without warnings.
> 
> ============
> We need to reduce the number of debug systems in the selinux libraries.
> printf's should be eradicated. There's also the alternative system that 
> semanage
> uses, based on buffering the errors - I'm not clear how that will
> be made to work in concert with sepol debugging.

We likely want to distinguish between debugging output (that should be
off by default) and error reporting output (that should always be
enabled).  Tresys had some concerns with the DEBUG() interface for
multi-threaded servers iirc; I've noted some concerns with their
write_error() interface in regards to have a uniform interface and
shared implementation and with the level of detail presently provided
via write_error().
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
