Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <4327521D.5020605@cornell.edu>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 08:35:39 -0400
Message-Id: <1126701339.12299.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 18:26 -0400, Ivan Gyurdiev wrote:
> Yes, we don't make that distiction currently. My patch treats all output 
> as debugging. On the other hand, however, it leaves debugging as 
> on-by-default for compatibility. I think we might not want any error 
> reporting output in library code - libraries should use status codes to 
> report the problem

Status codes aren't sufficiently informative.  

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

Yes, the printfs are just a legacy of its origins from checkpolicy (and
in fact, from its origins as shared code with the kernel security
server, where printf was remapped to printk(KERN_WARNING...)).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
