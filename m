Message-ID: <4384C873.20904@cornell.edu>
Date: Wed, 23 Nov 2005 14:52:19 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEPOL] Remove defrole from sepol
References: <437EBD3A.7090606@cornell.edu> <43848B72.1010603@cornell.edu> <43849B20.3090500@tresys.com>
In-Reply-To: <43849B20.3090500@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> I'm starting to question the need for this interface at all... it's 
>> an interface for a very narrow user base - genhomedircon... which is 
>> probably a mistake. I would prefer genhomedircon to find its way into 
>> libsemanage, which is its only user (does it have another one?). 
> the semanage tool Dan is writing could use it, to determine if a level 
> should be set, or it could just rely on getting an error back if you 
> try to set a level and it is a non mls system.
I'm confused... it needs genhomedircon, and not the library?
>> there would be no reason for an external interface for default roles 
>> and hacks to move genhomedircon before one lock is released, and 
>> after the other is released, and things like that would not be 
>> necessary. 
> genhomedircon is a reader, it is using resources outside of the module 
> store and is not confined to the sandbox. I don't know that it should 
> be inside the transaction.
Readers should be inside the transaction to guard against race 
condition. You mentioned commit numbers, and I pointed out I don't use 
them yet - and I don't see how they're a win over using a transaction.
>> Genhomedircon encapsulates an implementation detail of user/seuser 
>> updates. Is there another reason for it being outside libsemanage, 
>> other than python being easy to work with?
>>
> Mainly that its already done and works. We really do have higher 
> priority things than reimplementing genhomedircon in C to put in 
> libsemanage.
Maybe... unless it results in libsemanage APIs that are going to be 
removed later.  What's your opinion of what this API should look like - 
opaque object that can be expanded for other data (aux_info), or prefix 
only? How would system vs local work - see other questions in the thread.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
