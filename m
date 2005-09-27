Message-ID: <4339B036.5090900@cornell.edu>
Date: Tue, 27 Sep 2005 16:48:54 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: Re: [PATCH] semanage-functionality 4/17
References: <200509271246.j8RCkcYs026042@gotham.columbia.tresys.com>	 <43397960.5070905@cornell.edu> <1127851738.21671.147.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127851738.21671.147.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>A consistency nitpick:  we have decidedly mixed usage of typedefs in
>libsemanage and libsepol, with some typedefs being pointers to structs
>and others being aliases for structs.  
>
Most likely my fault - I introduced the pointer ones for records - that 
can be changed if necessary. The nice thing about pointer typedefs is 
that the pointer is hidden within the data type, which makes it possible 
to eliminate, if necessary - type can be replaced with a primitive 
without changing any of the functions to get rid of the star.... not 
that we're ever going to use primitive types for any of those things.

>Possibly we just need to
>aggressively prune typedefs throughout.  They seem to offer little real
>benefit for the struct types, and are more likely to just cause
>confusion in maintaining the code.
>  
>
Then we'll have to type struct everywhere...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
