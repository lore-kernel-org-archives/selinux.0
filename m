Message-ID: <4342A537.7030300@cornell.edu>
Date: Tue, 04 Oct 2005 11:52:23 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>
Subject: Synchronization/Caching
References: <433DA069.3090208@cornell.edu> <1128437587.26285.397.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128437587.26285.397.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> The other problem is the connection object - module_conn_t. I put that 
>> in modules.h, because it said "module", but it doesn't look like it 
>> belongs there. Karl, where should I move this? Should it go into 
>> direct_api.h ? I see the semanage_store makes use of that... is the 
>> semanage_store specific to the direct API?
>>
>> On a related note, where can I put policydb pointers - I need two of 
>> them for starters - ACTIVE, and LOCAL_MOD... the actual policydb objects 
>> will be created on demand (say when the user decides to query 
>> something), or when commit decides to re-create the active policy from 
>> scratch, but I need the pointers to them in a data structure linked into 
>> the handle (that's specific to direct api?) Should this go into 
>> conn.module (renaming that to conn.direct ?)
>>     
>
> Merged.  Karl, did you have any opinions on the above questions?
>   
I am still interested in the answer to the first question (where should 
conn be placed?).

The second question.... is a bit more complicated than I originally 
thought, because having a policydb in memory (or a linked list in memory 
for the contents of a file) is kind of a problem - it requires 
synchronization. It brings up the issue of whether queries will be done 
outside of transaction, on the active sandbox (and if so, what kind of 
cache procedures will be implemented (none - drop the cache on function 
exit?)), or inside of transaction, on the tmp sandbox, with the 
transaction lock held. Also, I'm not sure when and where the read lock 
is to be used.

Also, I don't particularly like the way the current direct_databse takes 
a pointer to a policydb elsewhere - that's kind of a hack, that's 
intended to get multiple dbase views to share the same in-memory 
policydb object, but I doubt it's going to work, so I think I'll get rid 
of it for now, and figure out how to implement this properly - will we 
even have a persistent cache of policy/files across functions outside of 
transaction mode?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
