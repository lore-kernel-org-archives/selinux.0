Message-ID: <43B981DE.6080403@tresys.com>
Date: Mon, 02 Jan 2006 14:41:18 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Reorganize sandbox_expand
References: <43B7C440.3060205@cornell.edu>
In-Reply-To: <43B7C440.3060205@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Happy New Year to everybody...
> My new year's resolution is to spent less time writing patches, and more 
> time having fun..
> Like all such resolutions, it's probably wishful thinking.
> 
shocker :)

> ==========
> This patch splits semanage_sandbox_install into 3 functions - one that 
> expands, one that merges local stuff, and one that writes.
> 
> This is more flexible, because I can skip the parts I don't like. For 
> example I can skip link/expand/write if modules_modified=0, and I just 
> want to validate a seuser change (needs a few more changes to do that). 
> I can keep the policydb around for a while if I want to - maybe for some 
> kind of caching scheme w/ commit numbers. I can choose to grab a 
> different policydb - maybe we have it cached, or maybe no modules were 
> changed, and we can reuse an existing expanded policy. The point is - do 
> one thing per function. The policydb is valuable and should not be 
> discarded so easily.
> 
I think this is fine. Personally I don't split things out until I need 
to, else the code becomes much harder to debug, but this seems like a 
good reason to do so.

It looks like the tmp store is going to be written back to active even 
if nothing is written, is this intentional? (it looks like that is also 
the case with the optional rebuild patch, as it only makes a policydb 
rebuild optional). In that case the commit number is probably going to 
be incremented.

> By the way, I don't understand the separation between semanage_store.c 
> and direct_api.c anymore.
> Expanding things, applying local changes, and writing the policy don't 
> seem related to the store IMHO - they work on things stored in the 
> store... but so does all the rest of libsemanage. On the other hand, the 
> name system (which I still don't use, because it's not flexible enough), 
> and locking seem more related to the store.
direct_api is a user of the store. everything in libsemanage does not 
necessarilly use the store, when we add policy server api it will not 
use the store at all. direct_api necessarilly depends on the store (all 
of its data is stored there), this is not wrong.

What name system are you refering to?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
