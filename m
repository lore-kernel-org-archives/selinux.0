Message-ID: <43279AED.7040605@cornell.edu>
Date: Tue, 13 Sep 2005 23:37:17 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu> <1126652637.30915.18.camel@twoface.columbia.tresys.com> <432799F0.7060706@cornell.edu>
In-Reply-To: <432799F0.7060706@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 > The core of the problem is library-wide debugging without 
caller-supplied state object.
 
By the way, the same thing applies to all those functions that use a 
library-wide policydb.
I think that's a mistake, and they should take the policydb as an 
argument. Global variables
are evil and not thread-friendly.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
