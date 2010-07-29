Message-ID: <4C517A99.80204@redhat.com>
Date: Thu, 29 Jul 2010 08:56:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Order 4 allocation in policydb_load
References: <1280340222.2734.94.camel@dhcp231-200.rdu.redhat.com>	 <1280350274.12879.36.camel@moss-pluto.epoch.ncsc.mil>	 <4C517408.6020504@redhat.com> <1280407479.3348.8.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1280407479.3348.8.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/29/2010 08:44 AM, Stephen Smalley wrote:
> On Thu, 2010-07-29 at 08:28 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 07/28/2010 04:51 PM, Stephen Smalley wrote:
>>> On Wed, 2010-07-28 at 14:03 -0400, Eric Paris wrote:
>>>> RH BZ 617255 shows that we have an order 4 allocation in policydb_load()
>>>>
>>>> <4>load_policy: page allocation failure. order:4, mode:0xd0
>>>>
>>>> # addr2line --inline --exe=vmlinux ffffffff81215304
>>>> /usr/src/debug/kernel-2.6.32/linux-2.6.32.x86_64/security/selinux/ss/policydb.c:2215
>>>>
>>>> which maps to:
>>>>
>>>>         p->type_attr_map = kmalloc(p->p_types.nprim*sizeof(struct ebitmap), GFP_KERNEL);
>>>>         if (!p->type_attr_map)
>>>>                 goto bad;
>>>>
>>>> Given that
>>>>
>>>> struct ebitmap {
>>>>         struct ebitmap_node *node;      /* first node in the bitmap */
>>>>         u32 highbit;    /* highest position in the total bitmap */
>>>> };
>>>>
>>>> We have a sizeof(struct ebitmap) on a 64 bit system is gong to be 12
>>>> (but it might round to 16, not certain)  Doing the basic math of about
>>>> 3300 types in current policy we come up with an allocation equal to:
>>>>
>>>> 3300 x 12 = 39600
>>>>
>>>> The largest 'safe' allocation is
>>>>
>>>> 2^2*4096 = 16384.
>>>>
>>>> Even if we stretch things a little bit and do an order 3 allocation:
>>>>
>>>> 2^3*4096 = 32764.
>>>>
>>>> So now I'm considering how to deal with it.  Couple of ideas spring to
>>>> mind.
>>>>
>>>> 1) Convert to flex arrays I don't know the perf of the flex arrays, but
>>>> context_struct_compute_av isn't necessarily the hottest path
>>>> 2) Convert to a 2d array type thing where p->type_attr_map is an array
>>>> of 64 pointers to arrays of 256 ebitmaps.  We could support 16k types
>>>> and the largest allocation would be 256 * 12 = 3072 bytes.  This would
>>>> add one memory dereference to our original linear lookup and certainly
>>>> keep up the perf.
>>>> 3) Put them in a proper selinux hash table.  Think this option would
>>>> grow the kernel in terms of both time and space as we would have to
>>>> store the id with the object and certainly wouldn't have linear lookup
>>>> time.
>>>> 4) Put them in a list.  Obviously the easiest but slowest....
>>>>
>>>> Another place where we create arrays based on the number of types is
>>>> type_val_to_struct but thankfully in that case we are only creating a
>>>> pointer.  So the allocation is
>>>>
>>>> 3300 x 8 = 26400
>>>>
>>>> Which fits inside the safer, but still not generally considered 'safe'
>>>> order 3 allocation.  We should probably apply whatever solution we think
>>>> is best here to that one as well....
>>>>
>>>> Anyone else want to chime in with which solution you think looks best or
>>>> if you can think of others?
>>>
>>> (1) or (2) sounds fine to me.
>>>
>>> I would however like to understand better why there are so many types in
>>> the current policy and how many of those types are actually being used.
>>>
>>> Perhaps we need to split more policy modules out of the base policy
>>> package and only install them if the corresponding application is
>>> installed?  That should become more feasible with the recent rpm
>>> enhancements.
>>>
>> That would only work if the types have alternatives.  For example if I
>> have the ability to install and remove apache and apache policy, what
>> happens to the files that are labeled httpd_sys_content_t?  To make this
>> work, you need to have the ability to say something like
>>
>> If installed
>>
>> httpd_sys_content_t,
>> httpd_sys_script_exec_t
>>
>> If removed
>>
>> typealias usr_t alias httpd_sys_content_t;
>> typealias bin_t alias httpd_sys_script_exec_t;
>>
>> Otherwise you end up with lots of domains generating AVC's looking at
>> unlabeled_t (Worse name ever for and undefined type).
> 
> I think Tresys punted on module removal, so that they won't actually
> remove the policy module if you install the package and later remove it.
> But if you never install the package at all, you shouldn't get the
> policy module for it.  So a minimal install should have a smaller policy
> as a result.
> 
> I was interested though in why we have so many types regardless -
> shouldn't the number of types have gone down markedly when we switched
> to UBAC and removed the per-role types?  Are we blindly adding new
> domains/types for every program or trying to group them into equivalence
> classes based on similarity in function and required accesses?  Are
> there sets of types that are unused, e.g. the secmark _packet_t types?
> Can we do any pruning of the type set (i.e. replacing some types with
> typealiases)?
> 


I have tried to do this with the spam class, potential other class would
be mailers.  But I do not believe you are going to get the bang for the
buck.  And I am sure no one wants to fund looking into this.  Then you
have the hassle of getting your changes upstream.  Currently dgrift and
I have a huge patch on upstream policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxRepkACgkQrlYvE4MpobN8NwCfUEyNhiaPdPrdv3zKnndqiDBp
EvYAoMuTIYcTm7ABkglK5S+jO1YUZYjm
=QnZt
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
