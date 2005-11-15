Message-ID: <4379548D.3010801@cornell.edu>
Date: Mon, 14 Nov 2005 22:22:53 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux-dev@tresys.com,
   Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] move genhomedircon call out of transaction
References: <BF9E9FD2.8085%csellers@tresys.com>
In-Reply-To: <BF9E9FD2.8085%csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> Attached is a patch that moves the genhomedircon patch out of the libsemanage
>>> transaction.  This is necessary since genhomedircon now uses libsemanage, and
>>> enters a transaction itself.
>>>   
>>>       
>> I don't think genhomedircon enters a transaction... nor should it - it's
>> a read-only operation with respect to the objects that we manage
>> (currently). I could be wrong, but I can't find where it enters a
>> transaction in the patch.
>>     
> Yep it does.  It calls semanage_user_list(), which calls dbase_list(), which
> calls enter_ro(), which gets the lock.
>   
I see the problem now - you confused me, because that's the active lock, 
not the transaction lock. It is not entering a transaction - it's 
guarding against a concurrent commit, but you *are* doing a concurrent 
commit, and calling genhomedircon as part of it.
>> Also, even if it did enter transaction, exiting and re-entering
>> "immediatly" would create a race condition.
>>     
> Could you expand on this race condition?  genhomedircon is only reading from
> libsemanage to generate file_contexts.homedir.  What race condition are you
> worried about?
>   
Well... any time you're releasing a lock, and you want to re-acquire it 
before changes are made - that's a potential race condition. I guess in 
this case you don't care if changes are made in the meantime, so there 
is no race condition.

On the other hand, genhomedir called outside libsemanage has a race in 
itself, because changes can be introduced between the time you call 
user_list, and seuser_list. It seems you're moving the place it's called 
to the end of install_sandbox (hard to tell without -p flag), so if it's 
called within libsemanage, that won't be a problem (active lock 
released, transaction lock still held, concurrent commit not possible).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
