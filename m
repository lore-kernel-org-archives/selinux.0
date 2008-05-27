Message-ID: <483C49CB.8060301@manicmethod.com>
Date: Tue, 27 May 2008 13:50:03 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Martin Orr <martin@martinorr.name>, SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>, setools@tresys.com
Subject: Re: [PATCH Take 3] user and role remapping in expander (was Re:	roles
 in base module)
References: <4820D9FB.8010802@martinorr.name>	 <1210248530.6434.145.camel@moss-spartans.epoch.ncsc.mil>	 <482E1DCD.1000505@manicmethod.com>	 <1211199052.7486.30.camel@moss-spartans.epoch.ncsc.mil>	 <4831F82F.3090702@manicmethod.com>	 <1211306138.7486.189.camel@moss-spartans.epoch.ncsc.mil>	 <4838CDDB.5000409@manicmethod.com> <1211907188.19360.17.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1211907188.19360.17.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Sat, 2008-05-24 at 22:24 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Mon, 2008-05-19 at 17:59 -0400, Joshua Brindle wrote:
>>>> Stephen Smalley wrote:
>>>>> On Fri, 2008-05-16 at 19:50 -0400, Joshua Brindle wrote:
>>>>>> Stephen Smalley wrote:
>>>>>>> On Tue, 2008-05-06 at 23:21 +0100, Martin Orr wrote:
>>>>>>>> Should I be able to build trunk refpolicy with the user roles included in
>>>>>>>> the base module?  I can build it with the roles as modules, but if I try
>>>>>>>> building them into base I get
>>>>>>>> /usr/bin/checkmodule -M base.conf -o tmp/base.mod
>>>>>>>> /usr/bin/checkmodule:  loading policy configuration from base.conf
>>>>>>>> libsepol.expand_module: Error while indexing out symbols
>>>>>>>> /usr/bin/checkmodule:  expand module failed
>>>>>>>>
>>>>>>>> I have refpolicy revision 2669, libsepol 2.0.25, checkpolicy 2.0.12.  I have
>>>>>>>> attached the modules.conf I am using, which seems to be the minimum number
>>>>>>>> of things I need to build in to be able to build in roles.
>>>>>>> Reproduced here as well, and naturally one should be able to build roles
>>>>>>> into base.
>>>>>>>
>>>>>>> We've seen this error condition in the past - it indicates that there is
>>>>>>> a hole in the symbol table, and requires mapping support in the expand
>>>>>>> code for roles to correctly handle it.  So that represents a
>>>>>>> bug/limitation of the current policy compiler.
>>>>>>>
>>>>>>> Walking through it I see that it is omitting the auditadm_r and secadm_r
>>>>>>> roles during the expand, and this is leaving the holes in the symbol
>>>>>>> table.
>>>>>>>
>>>>>>> Fixing the compiler requires adding mapping support for the roles
>>>>>>> similar to what Karl did for booleans in r2308.
>>>>>>>
>>>>>>> Hopefully though Chris can work around it in the policy in the interim.
>>>>>>>
>>>>>> Patch below should fix both user and role mapping issues.
>>>>> Why is it that we don't need a usermap too?
>>>>>
>>>> Updated patch includes usermap and mapping in constraint_node_clone, completely untested.
>>> Still fails in the same way as reported by Martin upon semodule -b of the base module.
>>> libsepol.context_read_and_validate: invalid security context
>>> libsepol.sepol_set_policydb_from_file: can't read binary policy: Success
>>> Error reading policy /etc/selinux/test/policy/policy.23: Success
>>> libsemanage.semanage_install_active: setfiles returned error code 1.
>>>
>>> Also fails upon just trying to semodule -B an existing valid policy
>>> store using the patched libsepol.
>>>
>> Ok, the following patch should address everything, it was more intrusive than I originally thought. 
>>
>> role->dominates will be incorrect when roles are copied and mapped from base into out policy, this is fixed after they've all been copied. 
>>
>> There is a tiny hack concerning object_r, at some point I'd like to address all the object_r hardcoding (both in the kernel and toolchain) but that is pretty low on the list.
>>
>> expand_module_avrules() which is used by external apps (eg., setools) has changed so those users will need to be fixed.
>>
>> valgrind and sediff are clean
>>
>> ------
>>
> 
>> diff -pruN -x .svn trunk.old/libsepol/src/expand.c trunk/libsepol/src/expand.c
>> --- trunk.old/libsepol/src/expand.c	2008-05-14 06:03:34.088691020 -0400
>> +++ trunk/libsepol/src/expand.c	2008-05-20 04:37:12.830478955 -0400
>> @@ -511,6 +538,28 @@ static int alias_copy_callback(hashtab_k
>>  	return 0;
>>  }
>>  
>> +static int role_remap_dominates(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *data)
>> +{
>> +	ebitmap_t mapped_roles;
>> +	role_datum_t *role = (role_datum_t *) datum;
>> +	expand_state_t *state = (expand_state_t *) data;
>> +
>> +	if (!(&role->dominates.node)) 
>> +		return 0;
> 
> That looks very odd.  What are you trying to test?
> !ebitmap_length(&role->dominates) is a test for empty ebitmap if you
> want that.
> 

Right, that was copied from role_copy_callback. looks like there are a few occurrences of this in expand.c, I'll make a patch on top of this to fix them all when I get a chance.

>> +
>> +	if (map_ebitmap(&role->dominates, &mapped_roles, state->rolemap))
>> +		return -1;
>> +
>> +	ebitmap_destroy(&role->dominates);	
>> +	
>> +	if (ebitmap_cpy(&role->dominates, &mapped_roles))
>> +		return -1;
>> +
>> +	ebitmap_destroy(&mapped_roles);
>> +
>> +	return 0;
>> +}
>> +
>>  static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>>  			      void *data)
>>  {
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
