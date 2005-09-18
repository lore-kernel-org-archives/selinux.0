Message-ID: <432CDB91.8050201@cornell.edu>
Date: Sat, 17 Sep 2005 23:14:25 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu>	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>	 <432799F0.7060706@cornell.edu>	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	 <432823F0.3030803@tresys.com>	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	 <43283772.7070603@tresys.com>	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	 <432842D4.3070905@tresys.com>	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>	 <43284A6B.8080507@tresys.com>  <43287BDC.1090004@cornell.edu>	 <1126797429.10727.95.camel@moss-spartans.epoch.ncsc.mil>	 <43299B5D.7070000@cornell.edu> <1126873195.25919.11.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126873195.25919.11.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>No, I think write_error should always write the formatted message to the
>error buffer, regardless of debug settings.  Then it calls DEBUG(),
>which does its thing.  Hence, all error messages find their way to DEBUG
>eventually (which may then discard them based on its setting), whereas
>write_error is called more selectively and only when the calling
>interface has error buffer arguments available.
>  
>
That sounds like a good plan to convert DEBUG into a debugging interface,
and write_error into an error reporting interface that relays the errors 
into the DEBUG channel too.

However, the messages currently being sent to DEBUG should be considered 
error reporting IMHO...
"couldn't open file X.Y.Z"
"boolean N is no longer valid"
"policy is the wrong version"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
