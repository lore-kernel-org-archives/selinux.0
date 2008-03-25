Message-ID: <47E965AE.8090804@manicmethod.com>
Date: Tue, 25 Mar 2008 16:50:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Caleb Case <ccase@tresys.com>
Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
References: <47E7E7A5.6090603@manicmethod.com> <1206463352.3302.200.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206463352.3302.200.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-03-24 at 13:40 -0400, Joshua Brindle wrote:
>   
>> This implements user_transition in the toolchain. It should help on
>> distro's like Ubuntu that can't use run_init due to the user not knowing
>> the root password. It also seems like a more eloquent way to handle
>> service restarts than assigning system_r to user accounts and having the
>> daemons run as someuser:system_r:foo_t.
>>
>> This has some issues in policy due to users not always being known in
>> the policy (eg., semanage users). I hope Chris or Dan will be able to
>> give some suggestions there.
>>
>> The kernel patch (forthcoming after this is accepted) so far only
>> implements the transition on process transitions. Later on I plan on
>> doing a patch to expand role_transition to object classes (this is a
>> change needed for policy rbac support to work). I suspect I'll do the
>> same for user at that time. The question here is, do we think its worth
>> it to do fine grained transitions like we did for range_trans? (I don't).
>>
>> Index: libsepol/include/sepol/policydb/policydb.h
>> ===================================================================
>> --- libsepol/include/sepol/policydb/policydb.h	(revision 2854)
>> +++ libsepol/include/sepol/policydb/policydb.h	(working copy)
>> @@ -156,6 +156,14 @@
>> 	mls_level_t exp_dfltlevel; /* expanded range used for validation */
>> } user_datum_t;
>>
>> +typedef struct user_trans {
>> +	uint32_t user;		/* current role */
>> +	uint32_t type;		/* program executable type */
>> +	uint32_t new_user;	/* new role */
>> +	struct user_trans *next;
>> +} user_trans_t;
>> +
>> +
>> /* Sensitivity attributes */
>> typedef struct level_datum {
>> 	mls_level_t *level;	/* sensitivity and associated categories */
>> @@ -225,6 +233,13 @@
>> 	struct role_trans_rule *next;
>> } role_trans_rule_t;
>>
>> +typedef struct user_trans_rule {
>> +	ebitmap_t users;	/* current role */
>> +	type_set_t types;	/* program executable type */
>> +	uint32_t new_user;	/* new role */
>> +	struct user_trans_rule *next;
>> +} user_trans_rule_t;
>>     
>
> Possibly crazy idea - given the current trend, would it be better to
> just save the user transition rules in symbolic form in the module
> format.  Would that simplify the link/expand code?
>
>   

Possibly, I am hoping policyrep will supplant this code in the near 
future so I didn't think about it much. This is consistent with how we 
store other modular things.

>> Index: libsepol/src/policydb.c
>> ===================================================================
>> --- libsepol/src/policydb.c	(revision 2854)
>> +++ libsepol/src/policydb.c	(working copy)
>> @@ -348,6 +367,30 @@
>> 	}
>> }
>>
>> +void user_trans_rule_init(user_trans_rule_t * x)
>> +{
>> +	memset(x, 0, sizeof(*x));
>>     
>
> Not unique to this patch, but it seems funny that we use memset followed
> by explicit initializers for fields that have them.  And that as a
> result of the memset here, we don't calloc when allocate the structs.
>
>   

I would normally never memset a struct, rather than use an initializer 
but I was going for minimal changes here, I don't plan on this code 
being around for long.

>> +	ebitmap_init(&x->users);
>> +	type_set_init(&x->types);
>> +}
>> +
>> +void user_trans_rule_destroy(user_trans_rule_t * x)
>> +{
>> +	if (x != NULL) {
>> +		ebitmap_init(&x->users);
>>     
>
> Should be ebitmap_destroy, right?
>
>   
Oops, yes

>> +		type_set_destroy(&x->types);
>> +	}
>> +}
>> +
>>     
>
> Usual boilerplate - make sure it runs under valgrind cleanly and doesn't
> introduce any (new) leaks on monolithic and modular build+link

This was an RFC patch and didn't go through any rigorous testing or 
valgrind (though I did ask for comments..) I recently found a bug in it 
so there will be another patch soon. Thanks for the comments.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
