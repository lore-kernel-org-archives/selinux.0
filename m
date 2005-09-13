Message-ID: <4327521D.5020605@cornell.edu>
Date: Tue, 13 Sep 2005 18:26:37 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu> <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>We likely want to distinguish between debugging output (that should be
>off by default) and error reporting output (that should always be
>enabled).  
>
Yes, we don't make that distiction currently. My patch treats all output 
as debugging. On the other hand, however, it leaves debugging as 
on-by-default for compatibility. I think we might not want any error 
reporting output in library code - libraries should use status codes to 
report the problem

>Tresys had some concerns with the DEBUG() interface for
>multi-threaded servers iirc.
>
>I've noted some concerns with their
>write_error() interface in regards to have a uniform interface and
>shared implementation and with the level of detail presently provided
>via write_error().
>  
>
I think there needs to be consistency across the library, whether it's 
DEBUG or write_error. The problem is that write_error requires 
significant modifications to APIs (user needs to pass error buffer to 
the library), whereas DEBUG does not, since it maintains the 
library-wide debugging. This is going to be a problem for the new 
semanage code I plan to put in as well...which currently uses DEBUG, 
which does not exist in semanage. If error buffers are required, I 
should alter the API to new functionality to support those. In any case, 
I think printfs are the wrong thing to do, and should be eliminated from 
sepol.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
