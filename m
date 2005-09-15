Message-ID: <43299B5D.7070000@cornell.edu>
Date: Thu, 15 Sep 2005 12:03:41 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu>	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>	 <432799F0.7060706@cornell.edu>	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	 <432823F0.3030803@tresys.com>	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	 <43283772.7070603@tresys.com>	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	 <432842D4.3070905@tresys.com>	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>	 <43284A6B.8080507@tresys.com>  <43287BDC.1090004@cornell.edu> <1126797429.10727.95.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126797429.10727.95.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Ok, suggestion:
>- Leave write_error() and DEBUG() separate,
>- Move write_error() to a unified interface and shared implementation,
>and have it internally call DEBUG() as well as saving the message in the
>buffer,
>- Convert remaining printf/fprintf occurrences to DEBUG(),
>- Convert direct snprintf calls into error buffers to use the shared
>write_error() interface.
>  
>
Do you see DEBUG as being off by default or on by default?
I'm trying to understand what the role of DEBUG is here... currently it 
handles
important printfs that will disappear if turned off.

Also, should write_error be paying attention to security_debug() ?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
