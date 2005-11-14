Message-ID: <437918BA.7050701@cornell.edu>
Date: Mon, 14 Nov 2005 18:07:38 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Chad Sellers <csellers@tresys.com>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   selinux-dev@tresys.com, Stephen Smalley <sds@tycho.nsa.gov>,
   selinux@tycho.nsa.gov
Subject: Re: [PATCH] move genhomedircon call out of transaction
References: <200511141709.43445.csellers@tresys.com> <4379179A.3090501@cornell.edu>
In-Reply-To: <4379179A.3090501@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> Attached is a patch that moves the genhomedircon patch out of the 
>> libsemanage transaction.  This is necessary since genhomedircon now 
>> uses libsemanage, and enters a transaction itself.
>>   
> I don't think genhomedircon enters a transaction... nor should it - 
> it's a read-only operation with respect to the objects that we manage 
> (currently). I could be wrong, but I can't find where it enters a 
> transaction in the patch.
Note: calling multiple semanage query functions outside a transaction is 
a bad idea, because a policy is object is created and destroyed per call 
(while it is cached when in-transaction). However, here only the list() 
function is called (once?), so that seems fine. The active lock guards 
against modification during list().


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
