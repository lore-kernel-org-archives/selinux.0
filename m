Message-ID: <43568C6E.5040106@cornell.edu>
Date: Wed, 19 Oct 2005 14:11:58 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Loading things into policy
References: <43559474.1080905@cornell.edu> <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> I plan to support those functions in all databases:
>> add() - add a new thing, or fail if it exists
>>            (maybe add a configurable parameter saying whether we should 
>> fail, or only warn if it exists)
>> modify() - add a new thing, or modify it if it exists
>>
>> In addition, I'm thinking of adding:
>> set() - modify a thing, but don't add it if it doesn't exist (for booleans).
>>     
>
> add() and set() as described above seem to be fundamental primitives;
> modify() seems optional as it can be constructed by the caller from the
> other two, i.e. if (add() < 0 && errno == EEXIST) { set(); }.
>   
Now, make add() take O(n) time, make set take O(n) time, and you're most 
likely taking twice as much time in modify() as you should be. Yes, I 
agree it's optional, but it's still useful to have... just like 
iterate() and list() can be implemented on top of each other (though 
iterate() over list() is a much worse idea than list() over iterate()).
> I'm not clear on why you wouldn't support overrides for ports,
> particularly as the base policy maps everything else left unspecified in
> the reserved port range to reserved_port_t. 
Hmm.. okay you might be right...
>  You might argue that should
> be moved out of the base module and into the local file, but I expect
> some people will need to override the base module port contexts for
> specific needs no matter how much we prune it.  User overrides also can
> make sense, e.g. some people may want to strip root of sysadm_r
>   
Yes, I realize overrides are useful in some cases - I was wondering 
whether they're useful in all cases.
Hmm... it sounds like we want modify() in all cases, and set() for 
booleans...to be the default function
to call on commit.
>> Should I even support all of them at the sepol layer? It might be 
>> simpler to just support the one that gets used for loading in sepol, 
>> since policy modifications will be done by rebuilding the policy anyway, 
>> so a single load function will be used for modifications. Then 
>> libsemanage could support the others on the flat file (but the 
>> modification gets applied to policy by rebuilding, and calling the 
>> default load function). Thoughts?
>>     
>
> libsemanage links and expands the modules yielding a policydb, and then
> libsemanage mutates the policydb via libsepol for local customizations,
> and then libsemanage writes out the final binary policy image via
> sepol_policydb_write.  So you still have to have the appropriate
> modifiers available via libsepol to manipulate the in-memory policydb.
>   
Well.... we need to choose one modifier to be the default for loading 
that entire file, because I don't keep track of which modifier you want 
per record - I don't keep track of deltas, I keep track of the contents 
of the file. So, there's usually a single modifier you'll be using on 
commit to load that entire file in policy.

In other words, you still have control of which modifier to use when 
working with the file, but I was only planning to support one modifier 
to load that file into policy, when commit() is called.

======
Now, you could say you want add(), modify(), and set() to work as I've 
described above with respect to policy, and not the local file... but 
that's not the way I've been thinking about it so far. That's a 
different kind of design - it would need to do an exists() test in both 
local files, and policy, before it took any action.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
