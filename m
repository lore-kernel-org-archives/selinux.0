Message-ID: <43D0A4C6.9060406@cornell.edu>
Date: Fri, 20 Jan 2006 01:52:22 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Seusers vs ldap
References: <43CE880B.3020908@cornell.edu> <43CE8AD6.7050109@redhat.com> <43CEAF5E.5020503@tresys.com>
In-Reply-To: <43CEAF5E.5020503@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> How would we go about implementing LDAP support for seusers in 
>>> libsemanage?
>>> I asked Joshua about this on IRC, but I think we to plan this on list.
>>>
>>> I think the most important question to be decided is whether we'll 
>>> use libldap directly, or execute external programs to work with 
>>> LDAP? The first option makes libsemanage always linked to libldap.
>>
>> Why not loadable module?
>>
> it's a possibility. there is no kind of dynamic library loading 
> infrastructure in libsemanage though, and we should really figure out 
> which is the best way to do it before proceeding on any of these routes.
Well, what's your justification for using external programs in 
libsemanage - for verify operations, and for loading the policy (I'm not 
sure if there's any justification for genhomedircon, it should be 
absorbed by libsemanage eventually). I thought there were security 
issues involved - maybe confine the load_policy or verifier program 
differently from the libsemanage client. Are any such issues applicable 
in the ldap case?

With regard to loadable module - what kind of infrastructure is needed - 
do we use dlopen()?
What resources are there to learn about this kind of thing...
Can you think of other uses of loadable modules in libsemanage?
Stephen, do you have an opinion on what should be done?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
