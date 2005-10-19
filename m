Message-ID: <435674F9.5070401@cornell.edu>
Date: Wed, 19 Oct 2005 12:31:53 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Loading things into policy
References: <43559474.1080905@cornell.edu> <43564E03.70500@tresys.com>
In-Reply-To: <43564E03.70500@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> So, I have a question regarding customizations to policy.
>>
>> I plan to support those functions in all databases:
>> add() - add a new thing, or fail if it exists
>>           (maybe add a configurable parameter saying whether we 
>> should fail, or only warn if it exists)
>> modify() - add a new thing, or modify it if it exists
>>
>> In addition, I'm thinking of adding:
>> set() - modify a thing, but don't add it if it doesn't exist (for 
>> booleans).
>>
>
> these seem sufficient, I'm not sure if they are all totally necessary, 
> this seems like a huge amount of complexity for a relatively simple 
> problem (adding and removing fields from a flat text file)
They're not entirely necessary, since one can usually be implemented in 
terms of the others... However, I think it's better if they're all 
implemented, since they can usually be implemented better when you know 
how the backend works. There is absolutely no "huge amount of 
complexity" added, and there's no guarantee that you'll be working with 
a flat text file in the future.

>> Which of those functions should be used to load things into policy?  
>> Should the load function be configurable per database? That way we 
>> can specify whether each database allows overrides of the in-policy 
>> defaults, or adding new things..etc.
>>
> IMO the files should just be written at commit time, whatever is in 
> the database at that time is what gets put into the files and thus 
> what gets added to the file during linking/expanded.
There's two databases, which have to be synchronized. One is a file, the 
other is a policy object, constructed from modules.
The question is whether things in the file should be overriding things 
in the policy.
>> For example, for ports only additive changes make sense to me, so we 
>> could make add() as the default load function. For booleans we want 
>> set() to be the default function...etc.. Maybe for users we want to 
>> allow overrides as well?
>>
> What if you want to change a port that is already in your local.ports 
> file? 
That won't be a problem - overriding things in the FILE is allowed 
(that's why I have all those functions above).
> How do you prioritize ports in the base policy and in local.ports?
That was the question I was asking - should we disallow conflicting 
changes in local.ports that modify base?
> How do you handle port ranges?
Port ranges will be a problem - I currently match any port within the 
range with the range. That's fine for queries, but probably not what you 
want for modifications - I'd have to think about that a bit more.

> BTW, this is why I don't think the policydb databases are helpful. You 
> shouldn't be modifying anything inside a module (including the base 
> module)
I need at least one function to be called internally on commit to do 
loading... Also, we might decide to allow modifications to a module 
outside commit at some point - I'd have to think about usage scenarios.

> The only reason they are helpful is for querying and I'm not sure why 
> you'd want to query the base policy, if you want to change a port 
> context you want to change it regardless of what the base policy has.
The policy is stored in a binary format, which is not particularly 
user-friendly. An admin might want to look and see what is it, exactly, 
that policy is doing. An analysis program might want to get information 
about the policy. imho, it's very useful to have policy query functions.

>> Should I even support all of them at the sepol layer? It might be 
>> simpler to just support the one that gets used for loading in sepol, 
>> since policy modifications will be done by rebuilding the policy 
>> anyway, so a single load function will be used for modifications. 
>> Then libsemanage could support the others on the flat file (but the 
>> modification gets applied to policy by rebuilding, and calling the 
>> default load function). Thoughts?
>>
>
> I have no idea what the above paragraph says. Any local modifications 
> (booleans, users.local, ports.local) are applied on rebuild at 
> probably expand time. I'm not sure what the others are you are 
> refering to.
I am saying... should I have a single function in sepol to load objects 
into policy...or multiple ones. Having a single function seems like the 
way to go, especially since, at the moment we'll only be using one 
function (since changes rebuild policy).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
