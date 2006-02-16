Message-ID: <43F4E9F4.7030106@tresys.com>
Date: Thu, 16 Feb 2006 16:09:08 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] semodule policy
References: <1140118126.13925.211.camel@sgc.columbia.tresys.com> <1140123490.12655.183.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1140123490.12655.183.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-02-16 at 14:28 -0500, Christopher J. PeBenito wrote:
>> I agree with Joshua, my current idea would be a .fc like (abbreviated):
>>
>> modules				-d	selinux_config_t
>> modules/(active|previous|tmp)(/.*)? 	semodule_store_t
>> modules/semanage.read.LOCK	--	semodule_read_lock_t
>> modules/semanage.trans.LOCK	--	semodule_trans_lock_t
> 
> Will libsemanage be modified to set and preserve the type on the lock
> files? 

Assuming that the semodule policy isn't present at initialization time 
(bootstrap) the module store will have to be relabeled anyway. I could 
add matchpathcon requests to create_store but I'm unsure if it will be 
helpful.

> How will it obtain the correct type for the lock files in the
> bootstrap case where there is no file_contexts yet? 

right, the problem I'm avoiding by not handling it in libsemanage :)

> It would be easier
> if they lived in separate subdirectories so that we could just use
> directory inheritance, as with the installed kernel binary policy file
> and the installed file_contexts file. 

the locks aren't ever deleted after creation (although if they are 
deleted it shouldn't cause problems), a single file per directory is 
kind of broken but I see why it might be helpful

> Top-level files
> in /etc/selinux/$SELINUXTYPE have the same issue, like seusers and
> setrans.conf, if we ever want them individually typed.  selinux_config_t
> tends to be widely readable.
> 
>> Then semodule_t would have a dir type_transition on selinux_config_t.
>> Then the rest of semodule_t policy should hopefully fall in place.
> 
> Should the domain be semanage_t to reflect use of libsemanage, and put
> all three of semodule, setsebool, and semanage into it?

probably. The other issue is that semanage/semodule/setsebool needs to 
run in the user context in the policy server case so that policy access 
control is done against their domain. I guess this will be a boolean/tunable

> 
>> As for /usr/share/selinux/$NAME/*.pp, I agree that they should have a
>> different label, but I'm not sure they should be policy_config_t.
>>
>> [1] http://marc.theaimsgroup.com/?l=selinux&m=113992576831596&w=2
> 
> Likely should add a new type for them.  Then we can possibly create
> pipelines from their type to the store files via the approved programs.
> 

sure.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
