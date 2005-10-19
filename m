Message-ID: <43564E03.70500@tresys.com>
Date: Wed, 19 Oct 2005 09:45:39 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Loading things into policy
References: <43559474.1080905@cornell.edu>
In-Reply-To: <43559474.1080905@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> So, I have a question regarding customizations to policy.
> 
> I plan to support those functions in all databases:
> add() - add a new thing, or fail if it exists
>           (maybe add a configurable parameter saying whether we should 
> fail, or only warn if it exists)
> modify() - add a new thing, or modify it if it exists
> 
> In addition, I'm thinking of adding:
> set() - modify a thing, but don't add it if it doesn't exist (for 
> booleans).
> 

these seem sufficient, I'm not sure if they are all totally necessary, 
this seems like a huge amount of complexity for a relatively simple 
problem (adding and removing fields from a flat text file)

> 
> Which of those functions should be used to load things into policy?  
> Should the load function be configurable per database? That way we can 
> specify whether each database allows overrides of the in-policy 
> defaults, or adding new things..etc.
> 
IMO the files should just be written at commit time, whatever is in the 
database at that time is what gets put into the files and thus what gets 
added to the file during linking/expanded.

> For example, for ports only additive changes make sense to me, so we 
> could make add() as the default load function. For booleans we want 
> set() to be the default function...etc.. Maybe for users we want to 
> allow overrides as well?
> 
What if you want to change a port that is already in your local.ports 
file? How do you prioritize ports in the base policy and in local.ports? 
How do you handle port ranges?

BTW, this is why I don't think the policydb databases are helpful. You 
shouldn't be modifying anything inside a module (including the base 
module) The only reason they are helpful is for querying and I'm not 
sure why you'd want to query the base policy, if you want to change a 
port context you want to change it regardless of what the base policy 
has. Querying for what the base policy has in order to decide whether to 
change it via ports.local isn't ideal because a subsequent base module 
upgrade could change the port definition.

> Should I even support all of them at the sepol layer? It might be 
> simpler to just support the one that gets used for loading in sepol, 
> since policy modifications will be done by rebuilding the policy anyway, 
> so a single load function will be used for modifications. Then 
> libsemanage could support the others on the flat file (but the 
> modification gets applied to policy by rebuilding, and calling the 
> default load function). Thoughts?
> 

I have no idea what the above paragraph says. Any local modifications 
(booleans, users.local, ports.local) are applied on rebuild at probably 
expand time. I'm not sure what the others are you are refering to.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
