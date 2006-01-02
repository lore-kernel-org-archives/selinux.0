Message-ID: <43B96EF5.4080906@cornell.edu>
Date: Mon, 02 Jan 2006 13:20:37 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Reorganize sandbox_expand
References: <43B7C440.3060205@cornell.edu> <43B981DE.6080403@tresys.com>
In-Reply-To: <43B981DE.6080403@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> It looks like the tmp store is going to be written back to active even 
> if nothing is written, is this intentional? (it looks like that is 
> also the case with the optional rebuild patch, as it only makes a 
> policydb rebuild optional). In that case the commit number is probably 
> going to be incremented.
That's because policy_components.c is a misnomer, and those functions 
contain things that aren't really policy components, like active 
booleans, file_contexts, and seusers. Specifically, file_contexts and 
seusers get written to disk (in 
policy_components.c:semanage_commit_components()), so yes, an install is 
needed that will increment the commit number.

I probably need to move things around and re-organize them to allow 
future optimizations.
> direct_api is a user of the store. everything in libsemanage does not 
> necessarilly use the store, when we add policy server api it will not 
> use the store at all. 
That's what concerns me with *database.c* depending on semanage_store.c. 
The other thread was talking about *database_file.c*, which is something 
different. The way I see the server working is as another backend of 
database.c, so it still goes through that code. Database.c is supposed 
to be backend-independent, generic entrypoint for dbase calls.

...but, it uses store locking, and store commit numbers, and relies on 
those functions, which will probably need to change for the server. The 
server api wouldn't need locking (because locking should be done done 
server-side, not client-side). It would need commit numbers, but we'd 
have to get those in some other kind of way, not by calling the store - 
will need to probably put the function that gets commit numbers in a 
table and initialize it differently for pserver vs direct.

> direct_api necessarilly depends on the store (all of its data is 
> stored there), this is not wrong.
Yes, but I didn't understand what's the criterion for splitting things 
stylistically between direct_api and semanage_store. I'd put 
expand_sandbox and things like that into direct_api.c

> What name system are you refering to?
The thing with semanage_path() and the prefixes...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
