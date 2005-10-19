Message-ID: <43559474.1080905@cornell.edu>
Date: Tue, 18 Oct 2005 20:33:56 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Loading things into policy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So, I have a question regarding customizations to policy.

I plan to support those functions in all databases:
add() - add a new thing, or fail if it exists
           (maybe add a configurable parameter saying whether we should 
fail, or only warn if it exists)
modify() - add a new thing, or modify it if it exists

In addition, I'm thinking of adding:
set() - modify a thing, but don't add it if it doesn't exist (for booleans).

=====================

Which of those functions should be used to load things into policy?  
Should the load function be configurable per database? That way we can 
specify whether each database allows overrides of the in-policy 
defaults, or adding new things..etc.

For example, for ports only additive changes make sense to me, so we 
could make add() as the default load function. For booleans we want 
set() to be the default function...etc.. Maybe for users we want to 
allow overrides as well?

Should I even support all of them at the sepol layer? It might be 
simpler to just support the one that gets used for loading in sepol, 
since policy modifications will be done by rebuilding the policy anyway, 
so a single load function will be used for modifications. Then 
libsemanage could support the others on the flat file (but the 
modification gets applied to policy by rebuilding, and calling the 
default load function). Thoughts?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
