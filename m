Message-ID: <43BC1C1A.1010203@cornell.edu>
Date: Wed, 04 Jan 2006 14:03:54 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com> <43BAB2D6.4030103@cornell.edu> <43BBF8C6.1070109@cornell.edu> <43BBFA8A.2040601@cornell.edu> <43BC1ECA.1070806@redhat.com> <43BC0681.2090403@cornell.edu> <43BC248C.7050102@redhat.com> <43BC24D3.7060504@tresys.com> <43BC0D99.10200@cornell.edu> <43BC2C0F.6050208@tresys.com>
In-Reply-To: <43BC2C0F.6050208@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>
>> Speaking of overriding things, is it currently possible to override 
>> the entire ethereal security module, for example?
>> Is there a modules.local? It's always been my opinion that modules 
>> should be just another record type, and the fs directory should be 
>> just another backend to the database...
>>
>>
> I really don't want to get into this again. Generalizing module store 
> for the sake of doing so would be a tremendous waste of time. The 
> policy server will allow transfering of the binary modules to machines 
> over the network (with access control) so why would they ever need to 
> be stored in some other medium.
Maybe so... I don't think it'd be that difficult, and I think there 
would be benefits in terms of shared code and uniform interface.
Anyway, my point was uniform interface is a good thing - modules should 
be less special and more like the other things.

My first question still stands, whether or not the store is generalized 
- it seems potentially useful to have a modules.local folder. It 
actually seems like a namespace conflict not to have one - what if I 
write a module, put it in the modules folder, and then it gets 
overwritten by policy when somebody makes another one with the same 
name. What if I want a more restrictive version of mozilla? Or a more 
relaxed one? Or I want to make a program that has a policy interoperate 
with my secret 3rd party extension that I can't upstream.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
