Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43264DAD.5090903@cornell.edu>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 11:51:02 -0400
Message-Id: <1126713062.12299.101.camel@moss-spartans.epoch.ncsc.mil>
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

Thanks, merged upstream.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
