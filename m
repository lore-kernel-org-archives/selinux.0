Message-ID: <43285B07.2070402@cornell.edu>
Date: Wed, 14 Sep 2005 13:16:55 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu>	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>	 <432799F0.7060706@cornell.edu>	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	 <432823F0.3030803@tresys.com>	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	 <43283772.7070603@tresys.com>	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	 <432842D4.3070905@tresys.com>	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>	 <43284A6B.8080507@tresys.com> <1126715064.12299.126.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126715064.12299.126.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>BTW, I just noticed - aren't the calls to sepol_debug() by
>sepol_enable/disable_debug() broken?  If you just set the function
>pointer, you don't want to clobber it using the old interface.
>
>  
>
The old interface is supposed to go away, but until it does, the new 
interface must provide the same functionality, which is why it maintains 
printing to stdout using the old system. By the way, this is *yet 
another* debug system - __sepol_debug_printf...

I'll respond to the rest of the discussion later tonight...







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
