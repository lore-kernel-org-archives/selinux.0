Message-ID: <4831CD9B.7060003@martinorr.name>
Date: Mon, 19 May 2008 19:57:31 +0100
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J.PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: roles in base module
References: <EXCHANGEY5pCxlICSsi0000021e@exchange.columbia.tresys.com>
In-Reply-To: <EXCHANGEY5pCxlICSsi0000021e@exchange.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 19/05/08 18:46, Joshua Brindle wrote:
> Sorry if this is badly formatted, writing it from my phone :)
> 
> Anyway, the usermap wasn't used so i removed it but now that i think about it constraint_clone_node needs to map both roles and users, ill get an update out when i can-----Original Message-----
> From: Stephen Smalley <sds@tycho.nsa.gov>
> Sent: Monday, May 19, 2008 5:10 AM
> To: Joshua Brindle <method@manicmethod.com>
> Cc: Martin Orr <martin@martinorr.name>; SELinux List <selinux@tycho.nsa.gov>; Christopher J. PeBenito <cpebenito@tresys.com>; Karl MacMillan <kmacmillan@tresys.com>
> Subject: Re: roles in base module
> 
> 
> On Fri, 2008-05-16 at 19:50 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Tue, 2008-05-06 at 23:21 +0100, Martin Orr wrote:
>>>> Should I be able to build trunk refpolicy with the user roles included in
>>>> the base module?  I can build it with the roles as modules, but if I try
>>>> building them into base I get
>>>> /usr/bin/checkmodule -M base.conf -o tmp/base.mod
>>>> /usr/bin/checkmodule:  loading policy configuration from base.conf
>>>> libsepol.expand_module: Error while indexing out symbols
>>>> /usr/bin/checkmodule:  expand module failed
>>>>
>>>> I have refpolicy revision 2669, libsepol 2.0.25, checkpolicy 2.0.12.  I have
>>>> attached the modules.conf I am using, which seems to be the minimum number
>>>> of things I need to build in to be able to build in roles.
>>> Reproduced here as well, and naturally one should be able to build roles
>>> into base.
>>>
>>> We've seen this error condition in the past - it indicates that there is
>>> a hole in the symbol table, and requires mapping support in the expand
>>> code for roles to correctly handle it.  So that represents a
>>> bug/limitation of the current policy compiler.
>>>
>>> Walking through it I see that it is omitting the auditadm_r and secadm_r
>>> roles during the expand, and this is leaving the holes in the symbol
>>> table.
>>>
>>> Fixing the compiler requires adding mapping support for the roles
>>> similar to what Karl did for booleans in r2308.
>>>
>>> Hopefully though Chris can work around it in the policy in the interim.
>>>
>> Patch below should fix both user and role mapping issues.
> 
> Why is it that we don't need a usermap too?

This patch gives me:
make[1]: Entering directory `/home/martin/selinux/toolchain/trunk/libsepol/src'
cc -Werror -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
-I. -I../include -D_GNU_SOURCE -fPIC -c -o expand.o expand.c
cc1: warnings being treated as errors
expand.c: In function 'attr_convert_callback':
expand.c:154: error: implicit declaration of function 'map_ebitmap'
expand.c: At top level:
expand.c:1849: error: static declaration of 'map_ebitmap' follows non-static
declaration
expand.c:154: error: previous implicit declaration of 'map_ebitmap' was here
make[1]: *** [expand.o] Error 1

I moved map_ebitmap to the top of the file to get something which would
compile.  Then I can build the policy, but not install the result:

martin@caligula:~/selinux/refpolicy/quilt$ sudo semodule -n -b base.pp
libsepol.context_read_and_validate: invalid security context
libsepol.sepol_set_policydb_from_file: can't read binary policy: Success
Error reading policy /etc/selinux/refpolicy-debian-martin/policy/policy.22:
Success
libsemanage.semanage_install_active: setfiles returned error code 1
semodule:  Failed!

The failure seems to be at the check:
		role = p->role_val_to_struct[c->role - 1];
                if (!ebitmap_get_bit(&role->cache, c->type - 1))
                        /* role may not be associated with type */
                        return 0;
at line 57 of libsepol/src/context.c.

>> Signed-off-by: Joshua Brindle <method@manicmethod.com>
>>
>> diff -pruN -x .svn trunk.old/checkpolicy/policy_define.c trunk/checkpolicy/policy_define.c
>> --- trunk.old/checkpolicy/policy_define.c	2008-05-14 06:03:32.588668393 -0400
>> +++ trunk/checkpolicy/policy_define.c	2008-05-14 02:08:43.876143370 -0400
>> @@ -2006,7 +2006,7 @@ int define_role_trans(void)
>>  	}
>>  
>>  	/* This ebitmap business is just to ensure that there are not conflicting role_trans rules */
>> -	if (role_set_expand(&roles, &e_roles, policydbp))
>> +	if (role_set_expand(&roles, &e_roles, policydbp, NULL))
>>  		goto bad;
>>  
>>  	if (type_set_expand(&types, &e_types, policydbp, 1))
>> diff -pruN -x .svn trunk.old/libsepol/include/sepol/policydb/expand.h trunk/libsepol/include/sepol/policydb/expand.h
>> --- trunk.old/libsepol/include/sepol/policydb/expand.h	2008-05-14 06:03:34.088691020 -0400
>> +++ trunk/libsepol/include/sepol/policydb/expand.h	2008-05-14 01:50:32.859685635 -0400
>> @@ -59,7 +59,7 @@ extern int expand_convert_type_set(polic
>>  				   unsigned char alwaysexpand);
>>  extern int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
>>  			   unsigned char alwaysexpand);
>> -extern int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p);
>> +extern int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * rolemap);
>>  extern int mls_semantic_level_expand(mls_semantic_level_t *sl, mls_level_t *l,
>>                                       policydb_t *p, sepol_handle_t *h);
>>  extern int mls_semantic_range_expand(mls_semantic_range_t *sr, mls_range_t *r,
>> diff -pruN -x .svn trunk.old/libsepol/src/expand.c trunk/libsepol/src/expand.c
>> --- trunk.old/libsepol/src/expand.c	2008-05-14 06:03:34.088691020 -0400
>> +++ trunk/libsepol/src/expand.c	2008-05-14 06:05:22.090320200 -0400
>> @@ -41,6 +41,7 @@ typedef struct expand_state {
>>  	int verbose;
>>  	uint32_t *typemap;
>>  	uint32_t *boolmap;
>> +	uint32_t *rolemap;
>>  	policydb_t *base;
>>  	policydb_t *out;
>>  	sepol_handle_t *handle;
>> @@ -150,7 +151,7 @@ static int attr_convert_callback(hashtab
>>  		ERR(state->handle, "attribute %s vanished!", id);
>>  		return -1;
>>  	}
>> -	if (convert_type_ebitmap(&type->types, &tmp_union, state->typemap)) {
>> +	if (map_ebitmap(&type->types, &tmp_union, state->typemap)) {
>>  		ERR(state->handle, "out of memory");
>>  		return -1;
>>  	}
>> @@ -552,8 +553,9 @@ static int role_copy_callback(hashtab_ke
>>  			return -1;
>>  		}
>>  
>> -		new_role->s.value = role->s.value;
>>  		state->out->p_roles.nprim++;
>> +		new_role->s.value = state->out->p_roles.nprim;
>> +		state->rolemap[role->s.value - 1] = new_role->s.value;
>>  		ret = hashtab_insert(state->out->p_roles.table,
>>  				     (hashtab_key_t) new_id,
>>  				     (hashtab_datum_t) new_role);
>> @@ -692,8 +694,8 @@ static int user_copy_callback(hashtab_ke
>>  		}
>>  		memset(new_user, 0, sizeof(user_datum_t));
>>  
>> -		new_user->s.value = user->s.value;
>>  		state->out->p_users.nprim++;
>> +		new_user->s.value = state->out->p_users.nprim;
>>  
>>  		new_id = strdup(id);
>>  		if (!new_id) {
>> @@ -756,7 +758,7 @@ static int user_copy_callback(hashtab_ke
>>  	ebitmap_init(&tmp_union);
>>  
>>  	/* get global roles for this user */
>> -	if (role_set_expand(&user->roles, &tmp_union, state->base)) {
>> +	if (role_set_expand(&user->roles, &tmp_union, state->base, state->rolemap)) {
>>  		ERR(state->handle, "Out of memory!");
>>  		ebitmap_destroy(&tmp_union);
>>  		return -1;
>> @@ -938,14 +940,16 @@ static int copy_role_allows(expand_state
>>  		ebitmap_init(&roles);
>>  		ebitmap_init(&new_roles);
>>  
>> -		if (role_set_expand(&cur->roles, &roles, state->out)) {
>> +		if (role_set_expand(&cur->roles, &roles, state->out, state->rolemap)) {
>>  			ERR(state->handle, "Out of memory!");
>>  			return -1;
>>  		}
>> -		if (role_set_expand(&cur->new_roles, &new_roles, state->out)) {
>> +
>> +		if (role_set_expand(&cur->new_roles, &new_roles, state->out, state->rolemap)) {
>>  			ERR(state->handle, "Out of memory!");
>>  			return -1;
>>  		}
>> +
>>  		ebitmap_for_each_bit(&roles, snode, i) {
>>  			if (!ebitmap_node_get_bit(snode, i))
>>  				continue;
>> @@ -1005,7 +1009,7 @@ static int copy_role_trans(expand_state_
>>  		ebitmap_init(&roles);
>>  		ebitmap_init(&types);
>>  
>> -		if (role_set_expand(&cur->roles, &roles, state->out)) {
>> +		if (role_set_expand(&cur->roles, &roles, state->out, state->rolemap)) {
>>  			ERR(state->handle, "Out of memory!");
>>  			return -1;
>>  		}
>> @@ -1842,7 +1846,7 @@ static int type_attr_remove(hashtab_key_
>>  	return 0;
>>  }
>>  
>> -int convert_type_ebitmap(ebitmap_t * src, ebitmap_t * dst, uint32_t * typemap)
>> +static int map_ebitmap(ebitmap_t * src, ebitmap_t * dst, uint32_t * map)
>>  {
>>  	unsigned int i;
>>  	ebitmap_node_t *tnode;
>> @@ -1851,9 +1855,9 @@ int convert_type_ebitmap(ebitmap_t * src
>>  	ebitmap_for_each_bit(src, tnode, i) {
>>  		if (!ebitmap_node_get_bit(tnode, i))
>>  			continue;
>> -		if (!typemap[i])
>> +		if (!map[i])
>>  			continue;
>> -		if (ebitmap_set_bit(dst, typemap[i] - 1, 1))
>> +		if (ebitmap_set_bit(dst, map[i] - 1, 1))
>>  			return -1;
>>  	}
>>  	return 0;
>> @@ -1870,10 +1874,10 @@ int expand_convert_type_set(policydb_t *
>>  
>>  	type_set_init(&tmpset);
>>  
>> -	if (convert_type_ebitmap(&set->types, &tmpset.types, typemap))
>> +	if (map_ebitmap(&set->types, &tmpset.types, typemap))
>>  		return -1;
>>  
>> -	if (convert_type_ebitmap(&set->negset, &tmpset.negset, typemap))
>> +	if (map_ebitmap(&set->negset, &tmpset.negset, typemap))
>>  		return -1;
>>  
>>  	tmpset.flags = set->flags;
>> @@ -1915,12 +1919,14 @@ int expand_rule(sepol_handle_t * handle,
>>  	return retval;
>>  }
>>  
>> -int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p)
>> +int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * rolemap)
>>  {
>>  	unsigned int i;
>>  	ebitmap_node_t *rnode;
>> +	ebitmap_t mapped_roles;
>>  
>>  	ebitmap_init(r);
>> +	ebitmap_init(&mapped_roles);
>>  
>>  	if (x->flags & ROLE_STAR) {
>>  		for (i = 0; i < p->p_roles.nprim++; i++)
>> @@ -1929,13 +1935,23 @@ int role_set_expand(role_set_t * x, ebit
>>  		return 0;
>>  	}
>>  
>> -	ebitmap_for_each_bit(&x->roles, rnode, i) {
>> +	if (rolemap) {
>> +		if (map_ebitmap(&x->roles, &mapped_roles, rolemap))
>> +			return -1;
>> +	} else {
>> +		if (ebitmap_cpy(&mapped_roles, &x->roles))
>> +			return -1;
>> +	}
>> +
>> +	ebitmap_for_each_bit(&mapped_roles, rnode, i) {
>>  		if (ebitmap_node_get_bit(rnode, i)) {
>>  			if (ebitmap_set_bit(r, i, 1))
>>  				return -1;
>>  		}
>>  	}
>>  
>> +	ebitmap_destroy(&mapped_roles);
>> +
>>  	/* if role is to be complimented, invert the entire bitmap here */
>>  	if (x->flags & ROLE_COMP) {
>>  		for (i = 0; i < ebitmap_length(r); i++) {
>> @@ -2309,6 +2325,12 @@ int expand_module(sepol_handle_t * handl
>>  		goto cleanup;
>>  	}
>>  
>> +	state.rolemap = (uint32_t *)calloc(state.base->p_roles.nprim, sizeof(uint32_t));
>> +	if (!state.rolemap) {
>> +		ERR(handle, "Out of memory!");
>> +		goto cleanup;
>> +	}
>> +
>>  	/* order is important - types must be first */
>>  
>>  	/* copy types */
>> @@ -2464,6 +2486,7 @@ int expand_module(sepol_handle_t * handl
>>        cleanup:
>>  	free(state.typemap);
>>  	free(state.boolmap);
>> +	free(state.rolemap);
>>  	return retval;
>>  }
>>  
>> diff -pruN -x .svn trunk.old/libsepol/src/policydb.c trunk/libsepol/src/policydb.c
>> --- trunk.old/libsepol/src/policydb.c	2008-05-14 06:03:34.088691020 -0400
>> +++ trunk/libsepol/src/policydb.c	2008-05-14 01:52:40.361608972 -0400
>> @@ -559,7 +559,7 @@ int policydb_user_cache(hashtab_key_t ke
>>  	p = (policydb_t *) arg;
>>  
>>  	ebitmap_destroy(&user->cache);
>> -	if (role_set_expand(&user->roles, &user->cache, p)) {
>> +	if (role_set_expand(&user->roles, &user->cache, p, NULL)) {
>>  		return -1;
>>  	}
>>  
>> diff -pruN -x .svn trunk.old/libsepol/src/users.c trunk/libsepol/src/users.c
>> --- trunk.old/libsepol/src/users.c	2008-05-14 06:03:34.088691020 -0400
>> +++ trunk/libsepol/src/users.c	2008-05-14 01:48:17.857649160 -0400
>> @@ -260,7 +260,7 @@ int sepol_user_modify(sepol_handle_t * h
>>  
>>  		/* Expand roles */
>>  		if (role_set_expand
>> -		    (&usrdatum->roles, &usrdatum->cache, policydb)) {
>> +		    (&usrdatum->roles, &usrdatum->cache, policydb, NULL)) {
>>  			ERR(handle, "unable to expand role set");
>>  			goto err;
>>  		}


-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
