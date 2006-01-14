Message-ID: <43C89C84.4060203@cornell.edu>
Date: Fri, 13 Jan 2006 23:39:00 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] User extra data (part 1)
References: <43C33ECB.2020608@cornell.edu> <43C3D4AE.8070403@tresys.com> <43C6DF28.2080500@cornell.edu> <43C88B94.8030804@redhat.com>
In-Reply-To: <43C88B94.8030804@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>>
>>> I really don't want to export a whole slew of extra interfaces for 
>>> dealing with system level stuff so some of the options are
>>>
>>> 1) letting rpm/whatever be trusted to smash things in the store 
>>> (non-ideal)
>>>
>>> 2) Write an 'import' interface that tells semanage to grab all the 
>>> system files from somewhere and smash the ones in the store (sort of 
>>> hackish)
>>>
>>> 3) add user_extra.system to the policy package and smash it on base 
>>> policy upgrade (this is my favorite)
>> I have no preference... Dan?
>>
> I really don't understand what you are trying to do here.
We're trying to come up with a way to ship a default configuration for 
labeling prefixes. This used to be stored in system.users (as the first 
role took the meaning of a prefix). Basically, there's a file now that 
looks like this:
user <name> prefix <name> ;
We have to get it into the sandbox somehow, and Joshua is suggesting an 
addition to the policy package as the way to do that.

> We are trying to build a mapping between SELinux User and default 
> login type?  Correct?  But there is a relationship between the default 
> login role and the type.  SO I guess I have no preference.  
Well, Steven's been claiming otherwise for a while now, and I thought 
that was at the core of the whole problem - the need to relate arbitrary 
labeling prefixes to selinux users. I do see how a relationship between 
the session login role and the labeling prefix would be useful if we had 
polyinstantiation (then we could label files differently for different 
logins). However, we currently don't have that - so we can't match a 
different label prefix for each of the possible login roles in 
default-contexts, we have to settle for a single prefix, that's 
associated with the user.
> The current policycoreutils is hacked to select user for user_u and 
> staff for root or staff_u in non targeted policy.
Yes, and this is the problem I'm trying to address.
Libsemanage now has the capability to provide you with a prefix. See:
semanage_user_get_prefix()
semanage_user_set_prefix().

However, all those prefixes default to user - we need the file I 
mentioned above to initialize them.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
