Message-ID: <43D0E148.6010400@tresys.com>
Date: Fri, 20 Jan 2006 08:10:32 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Seusers vs ldap
References: <43CE880B.3020908@cornell.edu> <43CE8AD6.7050109@redhat.com> <43CEAF5E.5020503@tresys.com> <43D0A4C6.9060406@cornell.edu>
In-Reply-To: <43D0A4C6.9060406@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>>> How would we go about implementing LDAP support for seusers in 
>>>> libsemanage?
>>>> I asked Joshua about this on IRC, but I think we to plan this on list.
>>>>
>>>> I think the most important question to be decided is whether we'll 
>>>> use libldap directly, or execute external programs to work with 
>>>> LDAP? The first option makes libsemanage always linked to libldap.
>>>
>>>
>>> Why not loadable module?
>>>
>> it's a possibility. there is no kind of dynamic library loading 
>> infrastructure in libsemanage though, and we should really figure out 
>> which is the best way to do it before proceeding on any of these routes.
> 
> Well, what's your justification for using external programs in 
> libsemanage - for verify operations, and for loading the policy (I'm not 
> sure if there's any justification for genhomedircon, it should be 
> absorbed by libsemanage eventually). I thought there were security 
> issues involved - maybe confine the load_policy or verifier program 
> differently from the libsemanage client. Are any such issues applicable 
> in the ldap case?

privilege separation primarily. While verifier programs are trusted to 
give us a good answer regarding whether a policy is ok to load it 
shouldn't be trusted with write access to the policy. Same with 
genhomedircon, it can write file context files but not the policy or 
anything in the module store (granted that it can do a whole lot of 
potential damage by writing incorrect file contexts).
> 
> With regard to loadable module - what kind of infrastructure is needed - 
> do we use dlopen()?
> What resources are there to learn about this kind of thing...
> Can you think of other uses of loadable modules in libsemanage?
> Stephen, do you have an opinion on what should be done?
> 

well, infrastructure meaning some way of configuring which modules get 
loaded, passing options to them, an api between libsemanage and the 
dynamic modules. It isn't as simple as just calling dlopen().

Now that I think of it loading a random network module into the memory 
space of semanage is a bad idea, we should be limiting the amount of 
trust we put in the alternate (esp networked) backends

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
