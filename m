Message-ID: <47602CFC.9030100@tresys.com>
Date: Wed, 12 Dec 2007 13:48:28 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Todd C. Miller" <tmiller@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: PATCH: libsepol should not write policy.18 with mls enabled
References: <200712112220.lBBMKOme018372@cadmus.columbia.tresys.com> <1197472028.1125.42.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1197472028.1125.42.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-12-11 at 17:20 -0500, Todd C. Miller wrote:
>> Currently, libsepol will write a binary policy with the MLS flag set
>> even if the policy version is unable to support MLS.  For instance, you
>> can build a policy.18 with mls enabled.  The resulting policy binary is
>> invalid and can't be read by the kernel or the various tools.
>>
>> Fixing this is just a matter of adding the appropriate check to
>> policydb_write().
> 
> Is that the right place to check it (vs. upon sepol_policydb_set_vers,
> although checkpolicy/checkmodule don't presently use that)?
> 
> Also, what does this mean for automatic dowgrading of policy versions at
> policy load time?  For example, if booting an old kernel with a newer
> policy that had MLS enabled.
> 

His original patch cleared the mls bit on the downgrade path but I 
objected that it wasn't appropriate to take what the user gave (an MLS 
policy) and remove the MLS part if its being downgraded to a version 
that doesn't support MLS. This is clearly an error condition IMO.

This is also a centralized place to give the error where everything is 
known, and happens on all conditions (checkpolicy, libsemanage, 
semodule_expand, init, etc). Granted sepol_policydb_set_vers is used for 
libsemanage and semodule_expand but that doesn't cover every use case 
and we will have inconsistent behavior.

Having an MLS policy on a system that doesn't support MLS is broken, 
what about the file_contexts that are associated with the policy and so on.

>> Signed-off-by: Todd C. Miller <tmiller@tresys.com>
>>
>> Index: libsepol/src/write.c
>> ===================================================================
>> --- libsepol/src/write.c	(revision 2704)
>> +++ libsepol/src/write.c	(working copy)
>> @@ -1531,8 +1531,19 @@
>>  	pd.p = p;
>>  
>>  	config = 0;
>> -	if (p->mls)
>> +	if (p->mls) {
>> +		if ((p->policyvers < POLICYDB_VERSION_MLS &&
>> +		    p->policy_type == POLICY_KERN) ||
>> +		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
>> +		    p->policy_type == POLICY_BASE) ||
>> +		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
>> +		    p->policy_type == POLICY_MOD)) {
> 
> I think you can simplify that expression.
> 
>> +			ERR(fp->handle, "policy version %d cannot support MLS",
>> +			    p->policyvers);
>> +			return POLICYDB_ERROR;
>> +		}
>>  		config |= POLICYDB_CONFIG_MLS;
>> +	}
>>  
>>  	config |= (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown);
>>  
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
