To: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
 <20180126143241.23108-5-peter.enderborg@sony.com>
 <1517323047.14420.14.camel@tycho.nsa.gov>
From: peter enderborg <peter.enderborg@sony.com>
Message-ID: <44f6385f-b2a5-2dbe-7034-851e5d06e42d@sony.com>
Date: Thu, 8 Feb 2018 08:16:56 +0100
MIME-Version: 1.0
In-Reply-To: <1517323047.14420.14.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
Subject: Re: [PATCH v2 4/5] selinux: Use pointer to switch policydb and sidtab
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/30/2018 03:37 PM, Stephen Smalley wrote:
> On Fri, 2018-01-26 at 15:32 +0100, peter.enderborg@sony.com wrote:
> goto err;
>  
> -	rc = security_preserve_bools(newpolicydb);
> +	rc = security_preserve_bools(&next_rcu->policydb);
>  	if (rc) {
>  		printk(KERN_ERR "SELinux:  unable to preserve
> booleans\n");
>  		goto err;
> Most of this shouldn't need to be under the read lock.
>
>> @@ -2189,7 +2194,7 @@ int security_load_policy(void *data, size_t
>> len)
>>  	 * in the new SID table.
>>  	 */
>>  	args.oldp = &crm->policydb;
>> -	args.newp = newpolicydb;
>> +	args.newp = &next_rcu->policydb;
>>  	rc = sidtab_map(&newsidtab, convert_context, &args);
>>  	if (rc) {
>>  		printk(KERN_ERR "SELinux:  unable to convert the
>> internal"
>> @@ -2204,8 +2209,9 @@ int security_load_policy(void *data, size_t
>> len)
>>  
>>  	/* Install the new policydb and SID table. */
>>  	/* next */
>> +	security_load_policycaps(&next_rcu->policydb);
> This cannot be done outside of the write lock; it has to be atomic with
> the policy switch.
Can you please elaborate, does some else write the policydb without a lock?
Is there any other data that is shared? I see this as a private until we switch the pointer.
>> +	read_unlock(&policy_rwlock);
>>  	write_lock_irq(&policy_rwlock);
>> -	memcpy(&next_rcu->policydb, newpolicydb, sizeof(struct
>> policydb));
>>  	sidtab_set(&next_rcu->sidtab, &newsidtab);
>>  	security_load_policycaps(&next_rcu->policydb);
>>  	oldmap = crm->current_mapping;
>> @@ -2213,8 +2219,9 @@ int security_load_policy(void *data, size_t
>> len)
>>  	next_rcu->current_mapping_size = map_size;
>>  
>>  	seqno = ++latest_granting;
>> -	write_unlock_irq(&policy_rwlock);
>> +	old_rcu = crm;
>>  	crm = next_rcu;
>> +	write_unlock_irq(&policy_rwlock);
>>  
>>  	/* Free the old policydb and SID table. */
>>  	policydb_destroy(oldpolicydb);
>> @@ -2226,17 +2233,16 @@ int security_load_policy(void *data, size_t
>> len)
>>  	selinux_status_update_policyload(seqno);
>>  	selinux_netlbl_cache_invalidate();
>>  	selinux_xfrm_notify_policyload();
>> +	kfree(oldpolicydb);
>> +	kfree(old_rcu);
>>  
>>  	rc = 0;
>>  	goto out;
>> -
>>  err:
>>  	kfree(map);
>>  	sidtab_destroy(&newsidtab);
>> -	policydb_destroy(newpolicydb);
>> -
>> +	
