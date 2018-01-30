Message-ID: <1517323047.14420.14.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: peter.enderborg@sony.com, Paul Moore <paul@paul-moore.com>, Eric Paris
 <eparis@parisplace.org>, James Morris <jmorris@namei.org>, Daniel Jurgens
 <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, alsa-devel@alsa-project.org,
 "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 30 Jan 2018 09:37:27 -0500
In-Reply-To: <20180126143241.23108-5-peter.enderborg@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
 <20180126143241.23108-5-peter.enderborg@sony.com>
Content-Type: multipart/mixed; boundary="=-GfOUtvhMJ+/VALkJxb3Z"
Mime-Version: 1.0
Subject: Re: [PATCH v2 4/5] selinux: Use pointer to switch policydb and sidtab
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--=-GfOUtvhMJ+/VALkJxb3Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-01-26 at 15:32 +0100, peter.enderborg@sony.com wrote:
> From: Peter Enderborg <peter.enderborg@sony.com>
> 
> This i preparation for switching to RCU locks. To be able to use
> RCU we need atomic switched pointer. This adds the dynamic
> memory copying to be a single pointer. It copy all the
> data structures in to new ones. This is an overhead
> for writing rules but the benifit is RCU.
> 
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/services.c | 139 +++++++++++++++++++++++------
> ------------
>  1 file changed, 78 insertions(+), 61 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index 2a8486c..81c5717 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2064,76 +2064,67 @@ static int security_preserve_bools(struct
> policydb *p);
>   */
>  int security_load_policy(void *data, size_t len)
>  {
> -	struct policydb *oldpolicydb, *newpolicydb;
> +	struct policydb *oldpolicydb;
>  	struct sidtab oldsidtab, newsidtab;
>  	struct selinux_mapping *oldmap = NULL, *map = NULL;
>  	struct convert_context_args args;
> -	struct shared_current_mapping *new_mapping;
>  	struct shared_current_mapping *next_rcu;
> -
> +	struct shared_current_mapping *old_rcu;
>  	u32 seqno;
>  	u16 map_size;
>  	int rc = 0;
>  	struct policy_file file = { data, len }, *fp = &file;
>  
> -	oldpolicydb = kzalloc(2 * sizeof(*oldpolicydb), GFP_KERNEL);
> -	if (!oldpolicydb) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	new_mapping = kzalloc(sizeof(struct shared_current_mapping),
> -			      GFP_KERNEL);
> -	if (!new_mapping) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	newpolicydb = oldpolicydb + 1;
> -	next_rcu = kmalloc(sizeof(struct shared_current_mapping),
> GFP_KERNEL);
> -	if (!next_rcu) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -
>  	if (!ss_initialized) {
> -		crm = kzalloc(sizeof(struct shared_current_mapping),
> -			      GFP_KERNEL);
> -		if (!crm) {
> +		struct shared_current_mapping *first_mapping;
> +
> +		first_mapping = kzalloc(sizeof(struct
> shared_current_mapping),
> +					GFP_KERNEL);
> +		if (!first_mapping) {
>  			rc = -ENOMEM;
>  			goto out;
>  		}
>  		avtab_cache_init();
>  		ebitmap_cache_init();
>  		hashtab_cache_init();
> -		rc = policydb_read(&crm->policydb, fp);
> +		rc = policydb_read(&first_mapping->policydb, fp);
>  		if (rc) {
>  			avtab_cache_destroy();
>  			ebitmap_cache_destroy();
>  			hashtab_cache_destroy();
> +			kfree(first_mapping);
>  			goto out;
>  		}
>  
> -		crm->policydb.len = len;
> -		rc = selinux_set_mapping(&crm->policydb,
> secclass_map,
> -					 &crm->current_mapping,
> -					 &crm-
> >current_mapping_size);
> +		first_mapping->policydb.len = len;
> +		rc = selinux_set_mapping(&first_mapping->policydb,
> secclass_map,
> +					 &first_mapping-
> >current_mapping,
> +					 &first_mapping-
> >current_mapping_size);
>  		if (rc) {
> -			policydb_destroy(&crm->policydb);
> +			policydb_destroy(&first_mapping->policydb);
>  			avtab_cache_destroy();
>  			ebitmap_cache_destroy();
>  			hashtab_cache_destroy();
> +			kfree(first_mapping);
>  			goto out;
>  		}
>  
> -		rc = policydb_load_isids(&crm->policydb, &crm-
> >sidtab);
> +		rc = policydb_load_isids(&first_mapping->policydb,
> +					 &first_mapping->sidtab);
>  		if (rc) {
> -			policydb_destroy(&crm->policydb);
> +			policydb_destroy(&first_mapping->policydb);
>  			avtab_cache_destroy();
>  			ebitmap_cache_destroy();
>  			hashtab_cache_destroy();
> +			kfree(first_mapping);
>  			goto out;
>  		}
>  
> -		security_load_policycaps(&crm->policydb);
> +		security_load_policycaps(&first_mapping->policydb);
> +		crm = first_mapping;
> +
> +		smp_mb(); /* make sure that crm exist before we */
> +			  /* switch ss_initialized */
>  		ss_initialized = 1;
>  		seqno = ++latest_granting;
>  		selinux_complete_init();
> @@ -2148,30 +2139,44 @@ int security_load_policy(void *data, size_t
> len)
>  #if 0
>  	sidtab_hash_eval(&crm->sidtab, "sids");
>  #endif
> +	oldpolicydb = kzalloc(sizeof(*oldpolicydb), GFP_KERNEL);
> +	if (!oldpolicydb) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	next_rcu = kzalloc(sizeof(struct shared_current_mapping),
> GFP_KERNEL);
> +	if (!next_rcu) {
> +		kfree(oldpolicydb);
> +		rc = -ENOMEM;
> +		goto out;
> +	}
>  
> -	rc = policydb_read(newpolicydb, fp);
> +	rc = policydb_read(&next_rcu->policydb, fp);
>  	if (rc)
>  		goto out;
>  
> -	newpolicydb->len = len;
> +	next_rcu->policydb.len = len;
> +	read_lock(&policy_rwlock);
>  	/* If switching between different policy types, log MLS
> status */
> -	if (crm->policydb.mls_enabled && !newpolicydb->mls_enabled)
> +	if (crm->policydb.mls_enabled && !next_rcu-
> >policydb.mls_enabled)
>  		printk(KERN_INFO "SELinux: Disabling MLS
> support...\n");
> -	else if (!crm->policydb.mls_enabled && newpolicydb-
> >mls_enabled)
> +	else if (!crm->policydb.mls_enabled && next_rcu-
> >policydb.mls_enabled)
>  		printk(KERN_INFO "SELinux: Enabling MLS
> support...\n");
>  
> -	rc = policydb_load_isids(newpolicydb, &newsidtab);
> +	rc = policydb_load_isids(&next_rcu->policydb, &newsidtab);
>  	if (rc) {
>  		printk(KERN_ERR "SELinux:  unable to load the
> initial SIDs\n");
> -		policydb_destroy(newpolicydb);
> +		policydb_destroy(&next_rcu->policydb);
>  		goto out;
>  	}
>  
> -	rc = selinux_set_mapping(newpolicydb, secclass_map, &map,
> &map_size);
> +	rc = selinux_set_mapping(&next_rcu->policydb, secclass_map,
> +				 &map, &map_size);
>  	if (rc)
>  		goto err;
>  
> -	rc = security_preserve_bools(newpolicydb);
> +	rc = security_preserve_bools(&next_rcu->policydb);
>  	if (rc) {
>  		printk(KERN_ERR "SELinux:  unable to preserve
> booleans\n");
>  		goto err;

Most of this shouldn't need to be under the read lock.

> @@ -2189,7 +2194,7 @@ int security_load_policy(void *data, size_t
> len)
>  	 * in the new SID table.
>  	 */
>  	args.oldp = &crm->policydb;
> -	args.newp = newpolicydb;
> +	args.newp = &next_rcu->policydb;
>  	rc = sidtab_map(&newsidtab, convert_context, &args);
>  	if (rc) {
>  		printk(KERN_ERR "SELinux:  unable to convert the
> internal"
> @@ -2204,8 +2209,9 @@ int security_load_policy(void *data, size_t
> len)
>  
>  	/* Install the new policydb and SID table. */
>  	/* next */
> +	security_load_policycaps(&next_rcu->policydb);

This cannot be done outside of the write lock; it has to be atomic with
the policy switch.

> +	read_unlock(&policy_rwlock);
>  	write_lock_irq(&policy_rwlock);
> -	memcpy(&next_rcu->policydb, newpolicydb, sizeof(struct
> policydb));
>  	sidtab_set(&next_rcu->sidtab, &newsidtab);
>  	security_load_policycaps(&next_rcu->policydb);
>  	oldmap = crm->current_mapping;
> @@ -2213,8 +2219,9 @@ int security_load_policy(void *data, size_t
> len)
>  	next_rcu->current_mapping_size = map_size;
>  
>  	seqno = ++latest_granting;
> -	write_unlock_irq(&policy_rwlock);
> +	old_rcu = crm;
>  	crm = next_rcu;
> +	write_unlock_irq(&policy_rwlock);
>  
>  	/* Free the old policydb and SID table. */
>  	policydb_destroy(oldpolicydb);
> @@ -2226,17 +2233,16 @@ int security_load_policy(void *data, size_t
> len)
>  	selinux_status_update_policyload(seqno);
>  	selinux_netlbl_cache_invalidate();
>  	selinux_xfrm_notify_policyload();
> +	kfree(oldpolicydb);
> +	kfree(old_rcu);
>  
>  	rc = 0;
>  	goto out;
> -
>  err:
>  	kfree(map);
>  	sidtab_destroy(&newsidtab);
> -	policydb_destroy(newpolicydb);
> -
> +	policydb_destroy(&next_rcu->policydb);
>  out:
> -	kfree(oldpolicydb);
>  	return rc;
>  }
>  
> @@ -2795,54 +2801,65 @@ int security_get_bools(int *len, char
> ***names, int **values)
>  	goto out;
>  }
>  
> -
>  int security_set_bools(int len, int *values)
>  {
> +	struct shared_current_mapping *next_rcu, *old_rcu;
>  	int i, rc;
>  	int lenp, seqno = 0;
>  	struct cond_node *cur;
>  
> -	write_lock_irq(&policy_rwlock);
> -
> +	next_rcu = kzalloc(sizeof(struct shared_current_mapping),
> GFP_KERNEL);
> +	read_lock(&policy_rwlock);
> +	old_rcu = crm;
> +	memcpy(&next_rcu->policydb, &old_rcu->policydb,
> +	       sizeof(struct policydb));

You are only doing a "shallow" copy of the policydb here, which
contains pointers to other structures.  So then below when you modify
state, you are modifying the original, not just the copy.  And you'll
end up double freeing if you free them both.

For reference, attached is a very old attempt to convert the policy
rwlock to RCU from KaiGai Kohei.  It may provide some insight into what
is needed here.
 
>  	rc = -EFAULT;
> -	lenp = crm->policydb.p_bools.nprim;
> +	lenp = next_rcu->policydb.p_bools.nprim;
> +
>  	if (len != lenp)
>  		goto out;
>  
>  	for (i = 0; i < len; i++) {
>  		if (!!values[i] !=
> -		    crm->policydb.bool_val_to_struct[i]->state) {
> +		    next_rcu->policydb.bool_val_to_struct[i]->state) 
> {
>  			audit_log(current->audit_context,
> GFP_ATOMIC,
>  				AUDIT_MAC_CONFIG_CHANGE,
>  				"bool=%s val=%d old_val=%d auid=%u
> ses=%u",
> -				sym_name(&crm->policydb, SYM_BOOLS,
> i),
> +				sym_name(&next_rcu->policydb,
> SYM_BOOLS, i),
>  				!!values[i],
> -				crm->policydb.bool_val_to_struct[i]-
> >state,
> +				next_rcu-
> >policydb.bool_val_to_struct[i]->state,
>  				from_kuid(&init_user_ns,
> audit_get_loginuid(current)),
>  				audit_get_sessionid(current));
>  		}
>  		if (values[i])
> -			crm->policydb.bool_val_to_struct[i]->state =
> 1;
> +			next_rcu->policydb.bool_val_to_struct[i]-
> >state = 1;
>  		else
> -			crm->policydb.bool_val_to_struct[i]->state =
> 0;
> +			next_rcu->policydb.bool_val_to_struct[i]-
> >state = 0;
>  	}
>  
> -	for (cur = crm->policydb.cond_list; cur; cur = cur->next) {
> -		rc = evaluate_cond_node(&crm->policydb, cur);
> +	for (cur = next_rcu->policydb.cond_list; cur; cur = cur-
> >next) {
> +		rc = evaluate_cond_node(&next_rcu->policydb, cur);
>  		if (rc)
>  			goto out;
>  	}
> +	read_unlock(&policy_rwlock);
> +	rc = 0;
>  
> +	write_lock_irq(&policy_rwlock);
>  	seqno = ++latest_granting;
> -	rc = 0;
> -out:
> +	crm = next_rcu;
>  	write_unlock_irq(&policy_rwlock);
> +out:
>  	if (!rc) {
>  		avc_ss_reset(seqno);
>  		selnl_notify_policyload(seqno);
>  		selinux_status_update_policyload(seqno);
>  		selinux_xfrm_notify_policyload();
> +	} else {
> +		kfree(next_rcu);
>  	}
> +	kfree(old_rcu);
> +
>  	return rc;
>  }
>  
--=-GfOUtvhMJ+/VALkJxb3Z
Content-Disposition: attachment; filename="selinux-nolock-policydb-041110.patch"
Content-Type: text/x-patch; name="selinux-nolock-policydb-041110.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtck5VNCBsaW51eC0yLjYuOS5zZWxpbnV4L3NlY3VyaXR5L3NlbGludXgvaG9va3MuYyBs
aW51eC0yLjYuOS5zZWxpbnV4LXBvbGljeWRiL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYwotLS0g
bGludXgtMi42Ljkuc2VsaW51eC9zZWN1cml0eS9zZWxpbnV4L2hvb2tzLmMJMjAwNC0xMS0wOSAx
OToyNzowOS4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4LTIuNi45LnNlbGludXgtcG9saWN5ZGIv
c2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCTIwMDQtMTEtMDkgMTk6Mjc6MDcuMDAwMDAwMDAwICsw
OTAwCkBAIC0yOTAsOSArMjkwLDkgQEAKICNlbmRpZgkvKiBDT05GSUdfU0VDVVJJVFlfTkVUV09S
SyAqLwogCiAvKiBUaGUgc2VjdXJpdHkgc2VydmVyIG11c3QgYmUgaW5pdGlhbGl6ZWQgYmVmb3Jl
CiAgICBhbnkgbGFiZWxpbmcgb3IgYWNjZXNzIGRlY2lzaW9ucyBjYW4gYmUgcHJvdmlkZWQuICov
Ci1leHRlcm4gaW50IHNzX2luaXRpYWxpemVkOworZXh0ZXJuIHN0cnVjdCBwb2xpY3lkYiAqcG9s
aWN5ZGI7CiAKIC8qIFRoZSBmaWxlIHN5c3RlbSdzIGxhYmVsIG11c3QgYmUgaW5pdGlhbGl6ZWQg
cHJpb3IgdG8gdXNlLiAqLwogCiBzdGF0aWMgY2hhciAqbGFiZWxpbmdfYmVoYXZpb3JzWzZdID0g
ewpAQCAtNTA2LDE2ICs1MDYsMTggQEAKIAlkb3duKCZzYnNlYy0+c2VtKTsKIAlpZiAoc2JzZWMt
PmluaXRpYWxpemVkKQogCQlnb3RvIG91dDsKIAotCWlmICghc3NfaW5pdGlhbGl6ZWQpIHsKKwly
Y3VfcmVhZF9sb2NrKCk7CisJaWYgKCFwb2xpY3lkYikgewogCQkvKiBEZWZlciBpbml0aWFsaXph
dGlvbiB1bnRpbCBzZWxpbnV4X2NvbXBsZXRlX2luaXQsCiAJCSAgIGFmdGVyIHRoZSBpbml0aWFs
IHBvbGljeSBpcyBsb2FkZWQgYW5kIHRoZSBzZWN1cml0eQogCQkgICBzZXJ2ZXIgaXMgcmVhZHkg
dG8gaGFuZGxlIGNhbGxzLiAqLwogCQlzcGluX2xvY2soJnNiX3NlY3VyaXR5X2xvY2spOwogCQlp
ZiAobGlzdF9lbXB0eSgmc2JzZWMtPmxpc3QpKQogCQkJbGlzdF9hZGQoJnNic2VjLT5saXN0LCAm
c3VwZXJibG9ja19zZWN1cml0eV9oZWFkKTsKIAkJc3Bpbl91bmxvY2soJnNiX3NlY3VyaXR5X2xv
Y2spOworCQlyY3VfcmVhZF91bmxvY2soKTsKIAkJZ290byBvdXQ7CiAJfQogCiAJLyogRGV0ZXJt
aW5lIHRoZSBsYWJlbGluZyBiZWhhdmlvciB0byB1c2UgZm9yIHRoaXMgZmlsZXN5c3RlbSB0eXBl
LiAqLwpAQCAtNDQxNiwxMiArNDQxOCwxNSBAQAogewogCWV4dGVybiB2b2lkIGV4aXRfc2VsX2Zz
KHZvaWQpOwogCXN0YXRpYyBpbnQgc2VsaW51eF9kaXNhYmxlZCA9IDA7CiAKLQlpZiAoc3NfaW5p
dGlhbGl6ZWQpIHsKKwlyY3VfcmVhZF9sb2NrKCk7CisJaWYgKHBvbGljeWRiKSB7CiAJCS8qIE5v
dCBwZXJtaXR0ZWQgYWZ0ZXIgaW5pdGlhbCBwb2xpY3kgbG9hZC4gKi8KKwkJcmN1X3JlYWRfdW5s
b2NrKCk7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KKwlyY3VfcmVhZF91bmxvY2soKTsKIAogCWlm
IChzZWxpbnV4X2Rpc2FibGVkKSB7CiAJCS8qIE9ubHkgZG8gdGhpcyBvbmNlLiAqLwogCQlyZXR1
cm4gLUVJTlZBTDsKZGlmZiAtck5VNCBsaW51eC0yLjYuOS5zZWxpbnV4L3NlY3VyaXR5L3NlbGlu
dXgvc3MvYXZ0YWIuYyBsaW51eC0yLjYuOS5zZWxpbnV4LXBvbGljeWRiL3NlY3VyaXR5L3NlbGlu
dXgvc3MvYXZ0YWIuYwotLS0gbGludXgtMi42Ljkuc2VsaW51eC9zZWN1cml0eS9zZWxpbnV4L3Nz
L2F2dGFiLmMJMjAwNC0xMS0wOSAxOToyNzowOC4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4LTIu
Ni45LnNlbGludXgtcG9saWN5ZGIvc2VjdXJpdHkvc2VsaW51eC9zcy9hdnRhYi5jCTIwMDQtMTEt
MTAgMTE6NDM6MzkuMDAwMDAwMDAwICswOTAwCkBAIC0yMzEsOSArMjMxLDkgQEAKIAkJCWttZW1f
Y2FjaGVfZnJlZShhdnRhYl9ub2RlX2NhY2hlcCwgdGVtcCk7CiAJCX0KIAkJaC0+aHRhYmxlW2ld
ID0gTlVMTDsKIAl9Ci0JdmZyZWUoaC0+aHRhYmxlKTsKKwlrZnJlZShoLT5odGFibGUpOwogCWgt
Pmh0YWJsZSA9IE5VTEw7CiB9CiAKIApAQCAtMjY0LDkgKzI2NCw5IEBACiBpbnQgYXZ0YWJfaW5p
dChzdHJ1Y3QgYXZ0YWIgKmgpCiB7CiAJaW50IGk7CiAKLQloLT5odGFibGUgPSB2bWFsbG9jKHNp
emVvZigqKGgtPmh0YWJsZSkpICogQVZUQUJfU0laRSk7CisJaC0+aHRhYmxlID0ga21hbGxvYyhz
aXplb2YoKihoLT5odGFibGUpKSAqIEFWVEFCX1NJWkUsIEdGUF9LRVJORUwpOwogCWlmICghaC0+
aHRhYmxlKQogCQlyZXR1cm4gLUVOT01FTTsKIAlmb3IgKGkgPSAwOyBpIDwgQVZUQUJfU0laRTsg
aSsrKQogCQloLT5odGFibGVbaV0gPSBOVUxMOwpAQCAtNDA2LDQgKzQwNiwzOCBAQAogCWF2dGFi
X25vZGVfY2FjaGVwID0ga21lbV9jYWNoZV9jcmVhdGUoImF2dGFiX25vZGUiLAogCQkJCQkgICAg
ICBzaXplb2Yoc3RydWN0IGF2dGFiX25vZGUpLAogCQkJCQkgICAgICAwLCBTTEFCX1BBTklDLCBO
VUxMLCBOVUxMKTsKIH0KKworaW50IGF2dGFiX2R1cGxpY2F0ZShzdHJ1Y3QgYXZ0YWIgKm5ldywg
c3RydWN0IGF2dGFiICpvcmlnKQoreworCWludCBpLHJjOworCXN0cnVjdCBhdnRhYl9ub2RlICpu
b2RlLCAqdG1wLCAqdGFpbDsKKworCWlmICghbmV3IHx8ICFvcmlnKQorCQlyZXR1cm4gLUVGQVVM
VDsKKworCXJjID0gYXZ0YWJfaW5pdChuZXcpOworCWlmIChyYykKKwkJcmV0dXJuIHJjOworCisJ
Zm9yIChpID0gMDsgaSA8IEFWVEFCX1NJWkU7IGkrKykgeworCQl0YWlsID0gTlVMTDsKKwkJZm9y
IChub2RlID0gb3JpZy0+aHRhYmxlW2ldOyBub2RlOyBub2RlID0gbm9kZS0+bmV4dCkgeworCQkJ
dG1wID0ga21lbV9jYWNoZV9hbGxvYyhhdnRhYl9ub2RlX2NhY2hlcCwgU0xBQl9LRVJORUwpOwor
CQkJaWYgKCF0bXApCisJCQkJZ290byBlcnJvcjsKKwkJCW1lbWNweSh0bXAsIG5vZGUsIHNpemVv
ZihzdHJ1Y3QgYXZ0YWJfbm9kZSkpOworCQkJaWYgKCF0YWlsKSB7CisJCQkJbmV3LT5odGFibGVb
aV0gPSB0bXA7CisJCQl9IGVsc2UgeworCQkJCXRhaWwtPm5leHQgPSB0bXA7CisJCQl9CisJCQl0
YWlsID0gdG1wOworCQkJbmV3LT5uZWwrKzsKKwkJfQorCX0KKwlyZXR1cm4gMDsKKyBlcnJvcjoK
KwlhdnRhYl9kZXN0cm95KG5ldyk7CisJcmV0dXJuIC1FTk9NRU07Cit9CmRpZmYgLXJOVTQgbGlu
dXgtMi42Ljkuc2VsaW51eC9zZWN1cml0eS9zZWxpbnV4L3NzL2F2dGFiLmggbGludXgtMi42Ljku
c2VsaW51eC1wb2xpY3lkYi9zZWN1cml0eS9zZWxpbnV4L3NzL2F2dGFiLmgKLS0tIGxpbnV4LTIu
Ni45LnNlbGludXgvc2VjdXJpdHkvc2VsaW51eC9zcy9hdnRhYi5oCTIwMDQtMTEtMDkgMTk6Mjc6
MDcuMDAwMDAwMDAwICswOTAwCisrKyBsaW51eC0yLjYuOS5zZWxpbnV4LXBvbGljeWRiL3NlY3Vy
aXR5L3NlbGludXgvc3MvYXZ0YWIuaAkyMDA0LTExLTEwIDExOjQ0OjA5LjAwMDAwMDAwMCArMDkw
MApAQCAtNzksOSArNzksMTIgQEAKIHN0cnVjdCBhdnRhYl9ub2RlICphdnRhYl9zZWFyY2hfbm9k
ZV9uZXh0KHN0cnVjdCBhdnRhYl9ub2RlICpub2RlLCBpbnQgc3BlY2lmaWVkKTsKIAogdm9pZCBh
dnRhYl9jYWNoZV9pbml0KHZvaWQpOwogCi0jZGVmaW5lIEFWVEFCX0hBU0hfQklUUyAxNQoraW50
IGF2dGFiX2R1cGxpY2F0ZShzdHJ1Y3QgYXZ0YWIgKm5ldywgc3RydWN0IGF2dGFiICpvcmlnKTsK
KworLy8jZGVmaW5lIEFWVEFCX0hBU0hfQklUUyAxNQorI2RlZmluZSBBVlRBQl9IQVNIX0JJVFMg
MTMKICNkZWZpbmUgQVZUQUJfSEFTSF9CVUNLRVRTICgxIDw8IEFWVEFCX0hBU0hfQklUUykKICNk
ZWZpbmUgQVZUQUJfSEFTSF9NQVNLIChBVlRBQl9IQVNIX0JVQ0tFVFMtMSkKIAogI2RlZmluZSBB
VlRBQl9TSVpFIEFWVEFCX0hBU0hfQlVDS0VUUwpkaWZmIC1yTlU0IGxpbnV4LTIuNi45LnNlbGlu
dXgvc2VjdXJpdHkvc2VsaW51eC9zcy9jb25kaXRpb25hbC5jIGxpbnV4LTIuNi45LnNlbGludXgt
cG9saWN5ZGIvc2VjdXJpdHkvc2VsaW51eC9zcy9jb25kaXRpb25hbC5jCi0tLSBsaW51eC0yLjYu
OS5zZWxpbnV4L3NlY3VyaXR5L3NlbGludXgvc3MvY29uZGl0aW9uYWwuYwkyMDA0LTExLTA5IDE5
OjI3OjA3LjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42Ljkuc2VsaW51eC1wb2xpY3lkYi9z
ZWN1cml0eS9zZWxpbnV4L3NzL2NvbmRpdGlvbmFsLmMJMjAwNC0xMS0xMCAyMToyOTowOC4wMDAw
MDAwMDAgKzA5MDAKQEAgLTEyLDkgKzEyLDkgQEAKICNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4K
ICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgogI2luY2x1ZGUgPGFzbS9zZW1hcGhvcmUuaD4K
ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Ci0KKyNpbmNsdWRlIDxsaW51eC9yY3VwZGF0ZS5oPgog
I2luY2x1ZGUgInNlY3VyaXR5LmgiCiAjaW5jbHVkZSAiY29uZGl0aW9uYWwuaCIKIAogLyoKQEAg
LTQ4NCw0ICs0ODQsMjEzIEBACiAJCQlhdmQtPmF1ZGl0YWxsb3cgfD0gYXZ0YWJfYXVkaXRhbGxv
dygmbm9kZS0+ZGF0dW0pOwogCX0KIAlyZXR1cm47CiB9CisvKiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8KK3N0YXRpYyBzdHJ1
Y3QgY29uZF9hdl9saXN0ICpjb25kX2R1cF9hdl9saXN0KHN0cnVjdCBjb25kX2F2X2xpc3QgKm9y
aWcsIHN0cnVjdCBhdnRhYiAqdGVfY29uZCkKK3sKKwlzdHJ1Y3QgYXZ0YWJfZGF0dW0gKmF2ZGF0
dW07CisJc3RydWN0IGNvbmRfYXZfbGlzdCAqY3VyLCAqdG1wLCAqdGFpbCA9IE5VTEwsICpoZWFk
ID0gTlVMTDsKKworCWZvciAoY3VyID0gb3JpZzsgY3VyOyBjdXIgPSBjdXItPm5leHQpIHsKKwkJ
YXZkYXR1bSA9IGF2dGFiX3NlYXJjaCh0ZV9jb25kLCAmY3VyLT5ub2RlLT5rZXksIGN1ci0+bm9k
ZS0+ZGF0dW0uc3BlY2lmaWVkKTsKKwkJaWYgKCFhdmRhdHVtKQorCQkJZ290byBlcnJvcjsKKwor
CQl0bXAgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgY29uZF9hdl9saXN0KSwgR0ZQX0tFUk5FTCk7
CisJCWlmICghdG1wKQorCQkJZ290byBlcnJvcjsKKworCQl0bXAtPm5vZGUgPSBjb250YWluZXJf
b2YoYXZkYXR1bSwgc3RydWN0IGF2dGFiX25vZGUsIGRhdHVtKTsKKwkJdG1wLT5uZXh0ID0gTlVM
TDsKKwkJaWYgKCFoZWFkKSB7CisJCQloZWFkID0gdGFpbCA9IHRtcDsKKwkJfSBlbHNlIHsKKwkJ
CXRhaWwtPm5leHQgPSB0bXA7CisJCQl0YWlsID0gdG1wOworCQl9CisJfQorCXJldHVybiBoZWFk
OworIGVycm9yOgorCWZvciAoY3VyPWhlYWQ7IGN1cjsgY3VyID0gdG1wKSB7CisJCXRtcCA9IGN1
ci0+bmV4dDsKKwkJa2ZyZWUodG1wKTsKKwl9CisJcmV0dXJuIE5VTEw7Cit9CisKK3N0YXRpYyBz
dHJ1Y3QgY29uZF9leHByICpjb25kX2R1cF9leHByKHN0cnVjdCBjb25kX2V4cHIgKm9yaWcpCit7
CisJc3RydWN0IGNvbmRfZXhwciAqY3VyLCAqdG1wLCAqdGFpbCwgKmhlYWQ7CisKKwl0YWlsID0g
aGVhZCA9IE5VTEw7CisJZm9yIChjdXIgPSBvcmlnOyBjdXI7IGN1ciA9IGN1ci0+bmV4dCkgewor
CQl0bXAgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgY29uZF9leHByKSwgR0ZQX0tFUk5FTCk7CisJ
CWlmICghdG1wKQorCQkJZ290byBlcnJvcjsKKwkJdG1wLT5leHByX3R5cGUgPSBjdXItPmV4cHJf
dHlwZTsKKwkJdG1wLT5ib29sID0gY3VyLT5ib29sOworCQl0bXAtPm5leHQgPSBOVUxMOworCQlp
ZiAoIWhlYWQpIHsKKwkJCWhlYWQgPSB0YWlsID0gdG1wOworCQl9IGVsc2UgeworCQkJdGFpbC0+
bmV4dCA9IHRtcDsKKwkJCXRhaWwgPSB0bXA7CisJCX0KKwl9CisJcmV0dXJuIGhlYWQ7IC8qIHN1
Y2Nlc3MgKi8KKworIGVycm9yOgorICAgICAgICBmb3IgKGN1ciA9IGhlYWQ7IGN1cjsgY3VyID0g
dG1wKSB7CisgICAgICAgICAgICAgICAgdG1wID0gY3VyLT5uZXh0OworICAgICAgICAgICAgICAg
IGtmcmVlKGN1cik7CisgICAgICAgIH0KKyAgICAgICAgcmV0dXJuIE5VTEw7Cit9CisKKy8qIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSAqLworaW50IGR1cGxpY2F0ZV9wb2xpY3lkYl9jb25kX2xpc3Qoc3RydWN0IHBvbGljeWRiICpu
ZXcsIHN0cnVjdCBwb2xpY3lkYiAqb3JpZykKK3sKKwlpbnQgcmM7CisJc3RydWN0IGNvbmRfbm9k
ZSAqY3VyLCAqdG1wLCAqdGFpbCA9IE5VTEw7CisKKwlyYyA9IGF2dGFiX2R1cGxpY2F0ZSgmbmV3
LT50ZV9jb25kX2F2dGFiLCAmb3JpZy0+dGVfY29uZF9hdnRhYik7CisJaWYgKHJjKQorCQlyZXR1
cm4gcmM7CisKKwluZXctPmNvbmRfbGlzdCA9IE5VTEw7CisJZm9yIChjdXIgPSBvcmlnLT5jb25k
X2xpc3Q7IGN1cjsgY3VyID0gY3VyLT5uZXh0KSB7CisJCXRtcCA9IGttYWxsb2Moc2l6ZW9mKHN0
cnVjdCBjb25kX25vZGUpLCBHRlBfS0VSTkVMKTsKKwkJaWYgKCF0bXApCisJCQlnb3RvIGVycm9y
OworCQltZW1zZXQodG1wLCAwLCBzaXplb2Yoc3RydWN0IGNvbmRfbm9kZSkpOworCQl0bXAtPmN1
cl9zdGF0ZSA9IGN1ci0+Y3VyX3N0YXRlOworCisJCWlmICghdGFpbCkgeworCQkJbmV3LT5jb25k
X2xpc3QgPSB0bXA7CisJCX0gZWxzZSB7CisJCQl0YWlsLT5uZXh0ID0gdG1wOworCQl9CisJCXRh
aWwgPSB0bXA7CisKKwkJdG1wLT5leHByID0gY29uZF9kdXBfZXhwcihjdXItPmV4cHIpOworCQlp
ZiAoY3VyLT5leHByICYmICF0bXAtPmV4cHIpCisJCQlnb3RvIGVycm9yOworCisJCXRtcC0+dHJ1
ZV9saXN0ID0gY29uZF9kdXBfYXZfbGlzdChjdXItPnRydWVfbGlzdCwgJm5ldy0+dGVfY29uZF9h
dnRhYik7CisJCWlmIChjdXItPnRydWVfbGlzdCAmJiAhdG1wLT50cnVlX2xpc3QpCisJCQlnb3Rv
IGVycm9yOworCisJCXRtcC0+ZmFsc2VfbGlzdCA9IGNvbmRfZHVwX2F2X2xpc3QoY3VyLT5mYWxz
ZV9saXN0LCAmbmV3LT50ZV9jb25kX2F2dGFiKTsKKwkJaWYgKGN1ci0+ZmFsc2VfbGlzdCAmJiAh
dG1wLT5mYWxzZV9saXN0KQorCQkJZ290byBlcnJvcjsKKwl9CisJcmV0dXJuIDA7IC8qIHN1Y2Nl
c3MqLworCisgZXJyb3I6CisJY29uZF9saXN0X2Rlc3Ryb3kobmV3LT5jb25kX2xpc3QpOworCXJl
dHVybiAtRU5PTUVNOworfQorCitzdGF0aWMgaW50IGNvbmRfYm9vbHNfZGVzdHJveSh2b2lkICpr
ZXksIHZvaWQgKmRhdHVtLCB2b2lkICphcmdzKQoreworCWtmcmVlKGRhdHVtKTsKKwlyZXR1cm4g
MDsKK30KKworc3RhdGljIGludCBjb25kX2Jvb2xzX2NvcHkoc3RydWN0IGhhc2h0YWJfbm9kZSAq
bmV3LCBzdHJ1Y3QgaGFzaHRhYl9ub2RlICpvcmlnLCB2b2lkICphcmdzKQoreworCXN0cnVjdCBj
b25kX2Jvb2xfZGF0dW0gKmRhdHVtOworCisJZGF0dW0gPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3Qg
Y29uZF9ib29sX2RhdHVtKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFkYXR1bSkKKwkJcmV0dXJuIC1F
Tk9NRU07CisKKwltZW1jcHkoZGF0dW0sIG9yaWctPmRhdHVtLCBzaXplb2Yoc3RydWN0IGNvbmRf
Ym9vbF9kYXR1bSkpOworCisJbmV3LT5rZXkgPSBvcmlnLT5rZXk7IC8qIE5vdCBuZWVkIHRvIGR1
cGxpY2F0ZSAqLworCW5ldy0+ZGF0dW0gPSBkYXR1bTsKKwlyZXR1cm4gMDsKK30KKworc3RhdGlj
IGludCBjb25kX2Jvb2xzX2luZGV4KHZvaWQgKmtleSwgdm9pZCAqZGF0dW0sIHZvaWQgKmFyZ3Mp
Cit7CisJc3RydWN0IGNvbmRfYm9vbF9kYXR1bSAqYm9vbGRhdHVtLCAqKmNvbmRfYm9vbF9hcnJh
eTsKKworCWJvb2xkYXR1bSA9IGRhdHVtOworCWNvbmRfYm9vbF9hcnJheSA9IGFyZ3M7CisJY29u
ZF9ib29sX2FycmF5W2Jvb2xkYXR1bS0+dmFsdWUgLTFdID0gYm9vbGRhdHVtOworCisJcmV0dXJu
IDA7Cit9CisKK3N0YXRpYyBpbnQgZHVwbGljYXRlX3BvbGljeWRiX2Jvb2xzKHN0cnVjdCBwb2xp
Y3lkYiAqbmV3ZGIsIHN0cnVjdCBwb2xpY3lkYiAqb3JpZykKK3sKKwlpbnQgbGVuOworCXN0cnVj
dCBoYXNodGFiICpuZXdodDsKKwlzdHJ1Y3QgY29uZF9ib29sX2RhdHVtICoqY29uZF9ib29sX2Fy
cmF5OworCisJaWYgKCFuZXdkYiB8fCAhb3JpZykKKwkJcmV0dXJuIC1FRkFVTFQ7CisKKwlsZW4g
PSBzaXplb2Yoc3RydWN0IGNvbmRfYm9vbF9kYXR1bSAqKSAqIG9yaWctPnBfYm9vbHMubnByaW07
CisJY29uZF9ib29sX2FycmF5ID0ga21hbGxvYyhsZW4sIEdGUF9LRVJORUwpOworCWlmICghY29u
ZF9ib29sX2FycmF5KQorCQlyZXR1cm4gLUVOT01FTTsKKwltZW1zZXQoY29uZF9ib29sX2FycmF5
LCAwLCBsZW4pOworCisJbmV3aHQgPSBoYXNodGFiX2R1cGxpY2F0ZShvcmlnLT5wX2Jvb2xzLnRh
YmxlLCBjb25kX2Jvb2xzX2NvcHksCisJCQkJCWNvbmRfYm9vbHNfZGVzdHJveSwgTlVMTCk7CisJ
aWYgKCFuZXdodCkgeworCQlrZnJlZShjb25kX2Jvb2xfYXJyYXkpOworCQlyZXR1cm4gLUVOT01F
TTsKKwl9CisJaGFzaHRhYl9tYXAobmV3aHQsIGNvbmRfYm9vbHNfaW5kZXgsIGNvbmRfYm9vbF9h
cnJheSk7CisJbmV3ZGItPmJvb2xfdmFsX3RvX3N0cnVjdCA9IGNvbmRfYm9vbF9hcnJheTsKKwlu
ZXdkYi0+cF9ib29scy50YWJsZSA9IG5ld2h0OworCW5ld2RiLT5wX2Jvb2xzLm5wcmltID0gbmV3
aHQtPm5lbDsKKworCXJldHVybiAwOworfQorCit2b2lkIGNvbmRfcG9saWN5ZGJfZnJlZV9yY3Uo
c3RydWN0IHJjdV9oZWFkICpwKQoreworCXN0cnVjdCBwb2xpY3lkYiAqb2xkX3BvbGljeTsKKwor
CW9sZF9wb2xpY3kgPSBjb250YWluZXJfb2YocCwgc3RydWN0IHBvbGljeWRiLCByaGVhZCk7CisK
KwloYXNodGFiX21hcChvbGRfcG9saWN5LT5wX2Jvb2xzLnRhYmxlLCBjb25kX2Jvb2xzX2Rlc3Ry
b3ksIE5VTEwpOworCWhhc2h0YWJfZGVzdHJveShvbGRfcG9saWN5LT5wX2Jvb2xzLnRhYmxlKTsK
KwlrZnJlZShvbGRfcG9saWN5LT5ib29sX3ZhbF90b19zdHJ1Y3QpOworCQorCWF2dGFiX2Rlc3Ry
b3koJm9sZF9wb2xpY3ktPnRlX2NvbmRfYXZ0YWIpOworCWNvbmRfbGlzdF9kZXN0cm95KG9sZF9w
b2xpY3ktPmNvbmRfbGlzdCk7CisKKwlwcmludGsoIm9sZGRiIHdhcyBrZnJlZSgpJ2QgYXQgY29u
ZF9wb2xpY3lkYl9mcmVlX3JjdSgpXG4iKTsKKwkKKwlrZnJlZShvbGRfcG9saWN5KTsKK30KKwor
c3RydWN0IHBvbGljeWRiICpjb25kX3BvbGljeWRiX2R1cChzdHJ1Y3QgcG9saWN5ZGIgKm9yaWcp
Cit7CisJc3RydWN0IHBvbGljeWRiICpuZXdkYjsKKworCW5ld2RiID0ga21hbGxvYyhzaXplb2Yo
c3RydWN0IHBvbGljeWRiKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFuZXdkYikKKwkJcmV0dXJuIE5V
TEw7CisKKwltZW1jcHkobmV3ZGIsIG9yaWcsIHNpemVvZihzdHJ1Y3QgcG9saWN5ZGIpKTsKKwor
CWlmIChkdXBsaWNhdGVfcG9saWN5ZGJfYm9vbHMobmV3ZGIsIG9yaWcpKSB7CisJCWtmcmVlKG5l
d2RiKTsKKwkJcmV0dXJuIE5VTEw7CisJfQorCisJaWYgKGR1cGxpY2F0ZV9wb2xpY3lkYl9jb25k
X2xpc3QobmV3ZGIsIG9yaWcpKSB7CisJCWNvbmRfcG9saWN5ZGJfZGVzdHJveShuZXdkYik7CisJ
CWtmcmVlKG5ld2RiKTsKKwkJcmV0dXJuIE5VTEw7CisJfQorCisJcmV0dXJuIG5ld2RiOyAvKiBz
dWNjZXNzICovCit9CisvKiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8KZGlmZiAtck5VNCBsaW51eC0yLjYuOS5zZWxpbnV4L3Nl
Y3VyaXR5L3NlbGludXgvc3MvY29uZGl0aW9uYWwuaCBsaW51eC0yLjYuOS5zZWxpbnV4LXBvbGlj
eWRiL3NlY3VyaXR5L3NlbGludXgvc3MvY29uZGl0aW9uYWwuaAotLS0gbGludXgtMi42Ljkuc2Vs
aW51eC9zZWN1cml0eS9zZWxpbnV4L3NzL2NvbmRpdGlvbmFsLmgJMjAwNC0xMS0wOSAxOToyNzow
OC4wMDAwMDAwMDAgKzA5MDAKKysrIGxpbnV4LTIuNi45LnNlbGludXgtcG9saWN5ZGIvc2VjdXJp
dHkvc2VsaW51eC9zcy9jb25kaXRpb25hbC5oCTIwMDQtMTEtMDkgMTk6Mjc6MDUuMDAwMDAwMDAw
ICswOTAwCkBAIC03Myw1ICs3Myw4IEBACiB2b2lkIGNvbmRfY29tcHV0ZV9hdihzdHJ1Y3QgYXZ0
YWIgKmN0YWIsIHN0cnVjdCBhdnRhYl9rZXkgKmtleSwgc3RydWN0IGF2X2RlY2lzaW9uICphdmQp
OwogCiBpbnQgZXZhbHVhdGVfY29uZF9ub2RlKHN0cnVjdCBwb2xpY3lkYiAqcCwgc3RydWN0IGNv
bmRfbm9kZSAqbm9kZSk7CiAKK3ZvaWQgY29uZF9wb2xpY3lkYl9mcmVlX3JjdShzdHJ1Y3QgcmN1
X2hlYWQgKnApOworc3RydWN0IHBvbGljeWRiICpjb25kX3BvbGljeWRiX2R1cChzdHJ1Y3QgcG9s
aWN5ZGIgKm9yaWcpOworCiAjZW5kaWYgLyogX0NPTkRJVElPTkFMX0hfICovCmRpZmYgLXJOVTQg
bGludXgtMi42Ljkuc2VsaW51eC9zZWN1cml0eS9zZWxpbnV4L3NzL2hhc2h0YWIuYyBsaW51eC0y
LjYuOS5zZWxpbnV4LXBvbGljeWRiL3NlY3VyaXR5L3NlbGludXgvc3MvaGFzaHRhYi5jCi0tLSBs
aW51eC0yLjYuOS5zZWxpbnV4L3NlY3VyaXR5L3NlbGludXgvc3MvaGFzaHRhYi5jCTIwMDQtMTEt
MDkgMTk6Mjc6MDguMDAwMDAwMDAwICswOTAwCisrKyBsaW51eC0yLjYuOS5zZWxpbnV4LXBvbGlj
eWRiL3NlY3VyaXR5L3NlbGludXgvc3MvaGFzaHRhYi5jCTIwMDQtMTEtMTAgMjE6MzI6NTYuMDAw
MDAwMDAwICswOTAwCkBAIC0yNzcsNCArMjc3LDU2IEBACiAKIAlpbmZvLT5zbG90c191c2VkID0g
c2xvdHNfdXNlZDsKIAlpbmZvLT5tYXhfY2hhaW5fbGVuID0gbWF4X2NoYWluX2xlbjsKIH0KKwor
c3RydWN0IGhhc2h0YWIgKmhhc2h0YWJfZHVwbGljYXRlKHN0cnVjdCBoYXNodGFiICpvcmlnLAor
CQlpbnQgKCpjb3B5KShzdHJ1Y3QgaGFzaHRhYl9ub2RlICpuZXcsIHN0cnVjdCBoYXNodGFiX25v
ZGUgKm9yaWcsIHZvaWQgKmFyZ3MpLAorCQlpbnQgKCpkZXN0cm95KSh2b2lkICprLCB2b2lkICpk
LCB2b2lkICphcmdzKSwKKwkJdm9pZCAqYXJncykKK3sKKwlpbnQgaSxyYzsKKwlzdHJ1Y3QgaGFz
aHRhYiAqbmV3OworCXN0cnVjdCBoYXNodGFiX25vZGUgKmN1ciwgKnRtcCwgKnRhaWw7CisKKwlp
ZiAoIW9yaWcgfHwgIWNvcHkgfHwgIWRlc3Ryb3kpCisJCXJldHVybiBOVUxMOworCisJbmV3ID0g
aGFzaHRhYl9jcmVhdGUob3JpZy0+aGFzaF92YWx1ZSwgb3JpZy0+a2V5Y21wLCBvcmlnLT5zaXpl
KTsKKwlpZiAoIW5ldykKKwkJcmV0dXJuIE5VTEw7CisKKwlmb3IgKGkgPSAwOyBpIDwgb3JpZy0+
c2l6ZTsgaSsrKSB7CisJCXRhaWwgPSBOVUxMOworCQlmb3IgKGN1ciA9IG9yaWctPmh0YWJsZVtp
XTsgY3VyOyBjdXIgPSBjdXItPm5leHQpIHsKKwkJCXRtcCA9IGttYWxsb2Moc2l6ZW9mKHN0cnVj
dCBoYXNodGFiX25vZGUpLCBHRlBfS0VSTkVMKTsKKwkJCWlmICghdG1wKQorCQkJCWdvdG8gZXJy
b3I7CisJCQlyYyA9IGNvcHkodG1wLCBjdXIsIGFyZ3MpOworCQkJaWYgKHJjKSB7CisJCQkJa2Zy
ZWUodG1wKTsKKwkJCQlnb3RvIGVycm9yOworCQkJfQorCQkJdG1wLT5uZXh0ID0gTlVMTDsKKwkJ
CWlmICghdGFpbCkgeworCQkJCW5ldy0+aHRhYmxlW2ldID0gdG1wOworCQkJfSBlbHNlIHsKKwkJ
CQl0YWlsLT5uZXh0ID0gdG1wOworCQkJfQorCQkJdGFpbCA9IHRtcDsKKwkJCW5ldy0+bmVsKys7
CisJCX0KKwl9CisJcmV0dXJuIG5ldzsKKyBlcnJvcjoKKwlmb3IgKGkgPSAwOyBpIDwgbmV3LT5z
aXplOyBpKyspIHsKKwkJZm9yIChjdXIgPSBuZXctPmh0YWJsZVtpXTsgY3VyOyBjdXIgPSB0bXAp
IHsKKwkJCXRtcCA9IGN1ci0+bmV4dDsKKwkJCWRlc3Ryb3koY3VyLT5rZXksIGN1ci0+ZGF0dW0s
IGFyZ3MpOworCQkJa2ZyZWUoY3VyKTsKKwkJfQorCX0KKwlrZnJlZShuZXcpOworCXJldHVybiBO
VUxMOwkKK30KKworCmRpZmYgLXJOVTQgbGludXgtMi42Ljkuc2VsaW51eC9zZWN1cml0eS9zZWxp
bnV4L3NzL2hhc2h0YWIuaCBsaW51eC0yLjYuOS5zZWxpbnV4LXBvbGljeWRiL3NlY3VyaXR5L3Nl
bGludXgvc3MvaGFzaHRhYi5oCi0tLSBsaW51eC0yLjYuOS5zZWxpbnV4L3NlY3VyaXR5L3NlbGlu
dXgvc3MvaGFzaHRhYi5oCTIwMDQtMTEtMDkgMTk6Mjc6MDguMDAwMDAwMDAwICswOTAwCisrKyBs
aW51eC0yLjYuOS5zZWxpbnV4LXBvbGljeWRiL3NlY3VyaXR5L3NlbGludXgvc3MvaGFzaHRhYi5o
CTIwMDQtMTEtMDkgMTk6Mjc6MDUuMDAwMDAwMDAwICswOTAwCkBAIC0xMjEsNSArMTIxLDEyIEBA
CiAKIC8qIEZpbGwgaW5mbyB3aXRoIHNvbWUgaGFzaCB0YWJsZSBzdGF0aXN0aWNzICovCiB2b2lk
IGhhc2h0YWJfc3RhdChzdHJ1Y3QgaGFzaHRhYiAqaCwgc3RydWN0IGhhc2h0YWJfaW5mbyAqaW5m
byk7CiAKKworc3RydWN0IGhhc2h0YWIgKmhhc2h0YWJfZHVwbGljYXRlKHN0cnVjdCBoYXNodGFi
ICpvcmlnLAorCQlpbnQgKCpjb3B5KShzdHJ1Y3QgaGFzaHRhYl9ub2RlICpuZXcsIHN0cnVjdCBo
YXNodGFiX25vZGUgKm9yaWcsIHZvaWQgKmFyZ3MpLAorCQlpbnQgKCpkZXN0cm95KSh2b2lkICpr
LCB2b2lkICpkLCB2b2lkICphcmdzKSwKKwkJdm9pZCAqYXJncyk7CisKKwogI2VuZGlmCS8qIF9T
U19IQVNIVEFCX0ggKi8KZGlmZiAtck5VNCBsaW51eC0yLjYuOS5zZWxpbnV4L3NlY3VyaXR5L3Nl
bGludXgvc3MvcG9saWN5ZGIuYyBsaW51eC0yLjYuOS5zZWxpbnV4LXBvbGljeWRiL3NlY3VyaXR5
L3NlbGludXgvc3MvcG9saWN5ZGIuYwotLS0gbGludXgtMi42Ljkuc2VsaW51eC9zZWN1cml0eS9z
ZWxpbnV4L3NzL3BvbGljeWRiLmMJMjAwNC0xMS0wOSAxOToyNzowOC4wMDAwMDAwMDAgKzA5MDAK
KysrIGxpbnV4LTIuNi45LnNlbGludXgtcG9saWN5ZGIvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xp
Y3lkYi5jCTIwMDQtMTEtMTEgMTA6Mjc6NTQuODg5MjMwNzczICswOTAwCkBAIC0xNDEsOCArMTQx
LDEzIEBACiAJaW50IGksIHJjOwogCiAJbWVtc2V0KHAsIDAsIHNpemVvZigqcCkpOwogCisJcC0+
c2lkdGFiID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IHNpZHRhYiksIEdGUF9LRVJORUwpOworCWlm
ICghcC0+c2lkdGFiKQorCQlyZXR1cm4gLUVOT01FTTsKKwlzaWR0YWJfaW5pdChwLT5zaWR0YWIp
OworCiAJZm9yIChpID0gMDsgaSA8IFNZTV9OVU07IGkrKykgewogCQlyYyA9IHN5bXRhYl9pbml0
KCZwLT5zeW10YWJbaV0sIHN5bXRhYl9zaXplc1tpXSk7CiAJCWlmIChyYykKIAkJCWdvdG8gb3V0
X2ZyZWVfc3ltdGFiOwpAQCAtMTY4LDggKzE3Myw5IEBACiAKIG91dF9mcmVlX3N5bXRhYjoKIAlm
b3IgKGkgPSAwOyBpIDwgU1lNX05VTTsgaSsrKQogCQloYXNodGFiX2Rlc3Ryb3kocC0+c3ltdGFi
W2ldLnRhYmxlKTsKKwlrZnJlZShwLT5zaWR0YWIpOwogCWdvdG8gb3V0OwogfQogCiAvKgpkaWZm
IC1yTlU0IGxpbnV4LTIuNi45LnNlbGludXgvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5o
IGxpbnV4LTIuNi45LnNlbGludXgtcG9saWN5ZGIvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lk
Yi5oCi0tLSBsaW51eC0yLjYuOS5zZWxpbnV4L3NlY3VyaXR5L3NlbGludXgvc3MvcG9saWN5ZGIu
aAkyMDA0LTExLTA5IDE5OjI3OjA4LjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42Ljkuc2Vs
aW51eC1wb2xpY3lkYi9zZWN1cml0eS9zZWxpbnV4L3NzL3BvbGljeWRiLmgJMjAwNC0xMS0wOSAx
OToyNzowNC4wMDAwMDAwMDAgKzA5MDAKQEAgLTE3LDggKzE3LDkgQEAKIAogI2lmbmRlZiBfU1Nf
UE9MSUNZREJfSF8KICNkZWZpbmUgX1NTX1BPTElDWURCX0hfCiAKKyNpbmNsdWRlIDxsaW51eC9y
Y3VwZGF0ZS5oPgogI2luY2x1ZGUgInN5bXRhYi5oIgogI2luY2x1ZGUgImF2dGFiLmgiCiAjaW5j
bHVkZSAic2lkdGFiLmgiCiAjaW5jbHVkZSAiY29udGV4dC5oIgpAQCAtMjQ1LDggKzI0NiwxMCBA
QAogCXN0cnVjdCBlYml0bWFwIHRydXN0ZWRyZWFkZXJzOwogCXN0cnVjdCBlYml0bWFwIHRydXN0
ZWR3cml0ZXJzOwogCXN0cnVjdCBlYml0bWFwIHRydXN0ZWRvYmplY3RzOwogI2VuZGlmCisJc3Ry
dWN0IHJjdV9oZWFkIHJoZWFkOworCXN0cnVjdCBzaWR0YWIgKnNpZHRhYjsKIH07CiAKIGV4dGVy
biBpbnQgcG9saWN5ZGJfaW5pdChzdHJ1Y3QgcG9saWN5ZGIgKnApOwogZXh0ZXJuIGludCBwb2xp
Y3lkYl9pbmRleF9jbGFzc2VzKHN0cnVjdCBwb2xpY3lkYiAqcCk7CmRpZmYgLXJOVTQgbGludXgt
Mi42Ljkuc2VsaW51eC9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMgbGludXgtMi42Ljku
c2VsaW51eC1wb2xpY3lkYi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMKLS0tIGxpbnV4
LTIuNi45LnNlbGludXgvc2VjdXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5jCTIwMDQtMTEtMDkg
MjA6MTQ6MTUuMDAwMDAwMDAwICswOTAwCisrKyBsaW51eC0yLjYuOS5zZWxpbnV4LXBvbGljeWRi
L3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMuYwkyMDA0LTExLTEwIDIxOjI5OjE1LjAwMDAw
MDAwMCArMDkwMApAQCAtNDEsMjEgKzQxLDE2IEBACiAKIGV4dGVybiB2b2lkIHNlbG5sX25vdGlm
eV9wb2xpY3lsb2FkKHUzMiBzZXFubyk7CiBleHRlcm4gaW50IHBvbGljeWRiX2xvYWRlZF92ZXJz
aW9uOwogCi1zdGF0aWMgcndsb2NrX3QgcG9saWN5X3J3bG9jayA9IFJXX0xPQ0tfVU5MT0NLRUQ7
Ci0jZGVmaW5lIFBPTElDWV9SRExPQ0sgcmVhZF9sb2NrKCZwb2xpY3lfcndsb2NrKQotI2RlZmlu
ZSBQT0xJQ1lfV1JMT0NLIHdyaXRlX2xvY2tfaXJxKCZwb2xpY3lfcndsb2NrKQotI2RlZmluZSBQ
T0xJQ1lfUkRVTkxPQ0sgcmVhZF91bmxvY2soJnBvbGljeV9yd2xvY2spCi0jZGVmaW5lIFBPTElD
WV9XUlVOTE9DSyB3cml0ZV91bmxvY2tfaXJxKCZwb2xpY3lfcndsb2NrKQorI2RlZmluZSBQT0xJ
Q1lfUkRMT0NLCXJjdV9yZWFkX2xvY2soKTsKKyNkZWZpbmUgUE9MSUNZX1JEVU5MT0NLCXJjdV9y
ZWFkX3VubG9jaygpOwogCiBzdGF0aWMgREVDTEFSRV9NVVRFWChsb2FkX3NlbSk7Ci0jZGVmaW5l
IExPQURfTE9DSyBkb3duKCZsb2FkX3NlbSkKLSNkZWZpbmUgTE9BRF9VTkxPQ0sgdXAoJmxvYWRf
c2VtKQorI2RlZmluZSBMT0FEX0xPQ0sgZG97IGRvd24oJmxvYWRfc2VtKTsgcmN1X3JlYWRfbG9j
aygpOyB9IHdoaWxlKDApCisjZGVmaW5lIExPQURfVU5MT0NLIGRveyByY3VfcmVhZF91bmxvY2so
KTsgdXAoJmxvYWRfc2VtKTsgfSB3aGlsZSgwKQogCi1zdHJ1Y3Qgc2lkdGFiIHNpZHRhYjsKLXN0
cnVjdCBwb2xpY3lkYiBwb2xpY3lkYjsKLWludCBzc19pbml0aWFsaXplZCA9IDA7CitzdHJ1Y3Qg
cG9saWN5ZGIgKnBvbGljeWRiID0gTlVMTDsKIAogLyoKICAqIFRoZSBsYXJnZXN0IHNlcXVlbmNl
IG51bWJlciB0aGF0IGhhcyBiZWVuIHVzZWQgd2hlbgogICogcHJvdmlkaW5nIGFuIGFjY2VzcyBk
ZWNpc2lvbiB0byB0aGUgYWNjZXNzIHZlY3RvciBjYWNoZS4KQEAgLTY4LDkgKzYzLDEwIEBACiAg
KiBSZXR1cm4gdGhlIGJvb2xlYW4gdmFsdWUgb2YgYSBjb25zdHJhaW50IGV4cHJlc3Npb24KICAq
IHdoZW4gaXQgaXMgYXBwbGllZCB0byB0aGUgc3BlY2lmaWVkIHNvdXJjZSBhbmQgdGFyZ2V0CiAg
KiBzZWN1cml0eSBjb250ZXh0cy4KICAqLwotc3RhdGljIGludCBjb25zdHJhaW50X2V4cHJfZXZh
bChzdHJ1Y3QgY29udGV4dCAqc2NvbnRleHQsCitzdGF0aWMgaW50IGNvbnN0cmFpbnRfZXhwcl9l
dmFsKHN0cnVjdCBwb2xpY3lkYiAqcCwKKwkJCQlzdHJ1Y3QgY29udGV4dCAqc2NvbnRleHQsCiAJ
CQkJc3RydWN0IGNvbnRleHQgKnRjb250ZXh0LAogCQkJCXN0cnVjdCBjb25zdHJhaW50X2V4cHIg
KmNleHByKQogewogCXUzMiB2YWwxLCB2YWwyOwpAQCAtMTEwLDEwICsxMDYsMTAgQEAKIAkJCQli
cmVhazsKIAkJCWNhc2UgQ0VYUFJfUk9MRToKIAkJCQl2YWwxID0gc2NvbnRleHQtPnJvbGU7CiAJ
CQkJdmFsMiA9IHRjb250ZXh0LT5yb2xlOwotCQkJCXIxID0gcG9saWN5ZGIucm9sZV92YWxfdG9f
c3RydWN0W3ZhbDEgLSAxXTsKLQkJCQlyMiA9IHBvbGljeWRiLnJvbGVfdmFsX3RvX3N0cnVjdFt2
YWwyIC0gMV07CisJCQkJcjEgPSBwLT5yb2xlX3ZhbF90b19zdHJ1Y3RbdmFsMSAtIDFdOworCQkJ
CXIyID0gcC0+cm9sZV92YWxfdG9fc3RydWN0W3ZhbDIgLSAxXTsKIAkJCQlzd2l0Y2ggKGUtPm9w
KSB7CiAJCQkJY2FzZSBDRVhQUl9ET006CiAJCQkJCXNbKytzcF0gPSBlYml0bWFwX2dldF9iaXQo
JnIxLT5kb21pbmF0ZXMsCiAJCQkJCQkJCSAgdmFsMiAtIDEpOwpAQCAtMTkxLDkgKzE4NywxMCBA
QAogLyoKICAqIENvbXB1dGUgYWNjZXNzIHZlY3RvcnMgYmFzZWQgb24gYSBjb250ZXh0IHN0cnVj
dHVyZSBwYWlyIGZvcgogICogdGhlIHBlcm1pc3Npb25zIGluIGEgcGFydGljdWxhciBjbGFzcy4K
ICAqLwotc3RhdGljIGludCBjb250ZXh0X3N0cnVjdF9jb21wdXRlX2F2KHN0cnVjdCBjb250ZXh0
ICpzY29udGV4dCwKK3N0YXRpYyBpbnQgY29udGV4dF9zdHJ1Y3RfY29tcHV0ZV9hdihzdHJ1Y3Qg
cG9saWN5ZGIgKnAsCisJCQkJICAgICBzdHJ1Y3QgY29udGV4dCAqc2NvbnRleHQsCiAJCQkJICAg
ICBzdHJ1Y3QgY29udGV4dCAqdGNvbnRleHQsCiAJCQkJICAgICB1MTYgdGNsYXNzLAogCQkJCSAg
ICAgdTMyIHJlcXVlc3RlZCwKIAkJCQkgICAgIHN0cnVjdCBhdl9kZWNpc2lvbiAqYXZkKQpAQCAt
MjE0LDE0ICsyMTEsMTQgQEAKIAkJaWYgKHRjbGFzcyA+PSBTRUNDTEFTU19ORVRMSU5LX1JPVVRF
X1NPQ0tFVCAmJgogCQkgICAgdGNsYXNzIDw9IFNFQ0NMQVNTX05FVExJTktfRE5SVF9TT0NLRVQp
CiAJCQl0Y2xhc3MgPSBTRUNDTEFTU19ORVRMSU5LX1NPQ0tFVDsKIAotCWlmICghdGNsYXNzIHx8
IHRjbGFzcyA+IHBvbGljeWRiLnBfY2xhc3Nlcy5ucHJpbSkgeworCWlmICghdGNsYXNzIHx8IHRj
bGFzcyA+IHAtPnBfY2xhc3Nlcy5ucHJpbSkgewogCQlwcmludGsoS0VSTl9FUlIgInNlY3VyaXR5
X2NvbXB1dGVfYXY6ICB1bnJlY29nbml6ZWQgY2xhc3MgJWRcbiIsCiAJCSAgICAgICB0Y2xhc3Mp
OwogCQlyZXR1cm4gLUVJTlZBTDsKIAl9Ci0JdGNsYXNzX2RhdHVtID0gcG9saWN5ZGIuY2xhc3Nf
dmFsX3RvX3N0cnVjdFt0Y2xhc3MgLSAxXTsKKwl0Y2xhc3NfZGF0dW0gPSBwLT5jbGFzc192YWxf
dG9fc3RydWN0W3RjbGFzcyAtIDFdOwogCiAJLyoKIAkgKiBJbml0aWFsaXplIHRoZSBhY2Nlc3Mg
dmVjdG9ycyB0byB0aGUgZGVmYXVsdCB2YWx1ZXMuCiAJICovCkBAIC0yMzcsOSArMjM0LDkgQEAK
IAkgKi8KIAlhdmtleS5zb3VyY2VfdHlwZSA9IHNjb250ZXh0LT50eXBlOwogCWF2a2V5LnRhcmdl
dF90eXBlID0gdGNvbnRleHQtPnR5cGU7CiAJYXZrZXkudGFyZ2V0X2NsYXNzID0gdGNsYXNzOwot
CWF2ZGF0dW0gPSBhdnRhYl9zZWFyY2goJnBvbGljeWRiLnRlX2F2dGFiLCAmYXZrZXksIEFWVEFC
X0FWKTsKKwlhdmRhdHVtID0gYXZ0YWJfc2VhcmNoKCZwLT50ZV9hdnRhYiwgJmF2a2V5LCBBVlRB
Ql9BVik7CiAJaWYgKGF2ZGF0dW0pIHsKIAkJaWYgKGF2ZGF0dW0tPnNwZWNpZmllZCAmIEFWVEFC
X0FMTE9XRUQpCiAJCQlhdmQtPmFsbG93ZWQgPSBhdnRhYl9hbGxvd2VkKGF2ZGF0dW0pOwogCQlp
ZiAoYXZkYXR1bS0+c3BlY2lmaWVkICYgQVZUQUJfQVVESVRERU5ZKQpAQCAtMjQ4LDkgKzI0NSw5
IEBACiAJCQlhdmQtPmF1ZGl0YWxsb3cgPSBhdnRhYl9hdWRpdGFsbG93KGF2ZGF0dW0pOwogCX0K
IAogCS8qIENoZWNrIGNvbmRpdGlvbmFsIGF2IHRhYmxlIGZvciBhZGRpdGlvbmFsIHBlcm1pc3Np
b25zICovCi0JY29uZF9jb21wdXRlX2F2KCZwb2xpY3lkYi50ZV9jb25kX2F2dGFiLCAmYXZrZXks
IGF2ZCk7CisJY29uZF9jb21wdXRlX2F2KCZwLT50ZV9jb25kX2F2dGFiLCAmYXZrZXksIGF2ZCk7
CiAKIAkvKgogCSAqIFJlbW92ZSBhbnkgcGVybWlzc2lvbnMgcHJvaGliaXRlZCBieSB0aGUgTUxT
IHBvbGljeS4KIAkgKi8KQEAgLTI2MSw5ICsyNTgsOSBAQAogCSAqLwogCWNvbnN0cmFpbnQgPSB0
Y2xhc3NfZGF0dW0tPmNvbnN0cmFpbnRzOwogCXdoaWxlIChjb25zdHJhaW50KSB7CiAJCWlmICgo
Y29uc3RyYWludC0+cGVybWlzc2lvbnMgJiAoYXZkLT5hbGxvd2VkKSkgJiYKLQkJICAgICFjb25z
dHJhaW50X2V4cHJfZXZhbChzY29udGV4dCwgdGNvbnRleHQsCisJCSAgICAhY29uc3RyYWludF9l
eHByX2V2YWwocCwgc2NvbnRleHQsIHRjb250ZXh0LAogCQkJCQkgIGNvbnN0cmFpbnQtPmV4cHIp
KSB7CiAJCQlhdmQtPmFsbG93ZWQgPSAoYXZkLT5hbGxvd2VkKSAmIH4oY29uc3RyYWludC0+cGVy
bWlzc2lvbnMpOwogCQl9CiAJCWNvbnN0cmFpbnQgPSBjb25zdHJhaW50LT5uZXh0OwpAQCAtMjc2
LDkgKzI3Myw5IEBACiAJICovCiAJaWYgKHRjbGFzcyA9PSBTRUNDTEFTU19QUk9DRVNTICYmCiAJ
ICAgIChhdmQtPmFsbG93ZWQgJiBQUk9DRVNTX19UUkFOU0lUSU9OKSAmJgogCSAgICBzY29udGV4
dC0+cm9sZSAhPSB0Y29udGV4dC0+cm9sZSkgewotCQlmb3IgKHJhID0gcG9saWN5ZGIucm9sZV9h
bGxvdzsgcmE7IHJhID0gcmEtPm5leHQpIHsKKwkJZm9yIChyYSA9IHAtPnJvbGVfYWxsb3c7IHJh
OyByYSA9IHJhLT5uZXh0KSB7CiAJCQlpZiAoc2NvbnRleHQtPnJvbGUgPT0gcmEtPnJvbGUgJiYK
IAkJCSAgICB0Y29udGV4dC0+cm9sZSA9PSByYS0+bmV3X3JvbGUpCiAJCQkJYnJlYWs7CiAJCX0K
QEAgLTMwNywzOCArMzA0LDQwIEBACiAJCQl1MTYgdGNsYXNzLAogCQkJdTMyIHJlcXVlc3RlZCwK
IAkJCXN0cnVjdCBhdl9kZWNpc2lvbiAqYXZkKQogeworCXN0cnVjdCBwb2xpY3lkYiAqcDsKIAlz
dHJ1Y3QgY29udGV4dCAqc2NvbnRleHQgPSBOVUxMLCAqdGNvbnRleHQgPSBOVUxMOwogCWludCBy
YyA9IDA7CiAKLQlpZiAoIXNzX2luaXRpYWxpemVkKSB7CisJUE9MSUNZX1JETE9DSzsKKwlwID0g
cG9saWN5ZGI7CisKKwlpZiAoIXApIHsKIAkJYXZkLT5hbGxvd2VkID0gcmVxdWVzdGVkOwogCQlh
dmQtPmRlY2lkZWQgPSByZXF1ZXN0ZWQ7CiAJCWF2ZC0+YXVkaXRhbGxvdyA9IDA7CiAJCWF2ZC0+
YXVkaXRkZW55ID0gMHhmZmZmZmZmZjsKIAkJYXZkLT5zZXFubyA9IGxhdGVzdF9ncmFudGluZzsK
LQkJcmV0dXJuIDA7CisJCWdvdG8gb3V0OwogCX0KIAotCVBPTElDWV9SRExPQ0s7Ci0KLQlzY29u
dGV4dCA9IHNpZHRhYl9zZWFyY2goJnNpZHRhYiwgc3NpZCk7CisJc2NvbnRleHQgPSBzaWR0YWJf
c2VhcmNoKHAtPnNpZHRhYiwgc3NpZCk7CiAJaWYgKCFzY29udGV4dCkgewogCQlwcmludGsoS0VS
Tl9FUlIgInNlY3VyaXR5X2NvbXB1dGVfYXY6ICB1bnJlY29nbml6ZWQgU0lEICVkXG4iLAogCQkg
ICAgICAgc3NpZCk7CiAJCXJjID0gLUVJTlZBTDsKIAkJZ290byBvdXQ7CiAJfQotCXRjb250ZXh0
ID0gc2lkdGFiX3NlYXJjaCgmc2lkdGFiLCB0c2lkKTsKKwl0Y29udGV4dCA9IHNpZHRhYl9zZWFy
Y2gocC0+c2lkdGFiLCB0c2lkKTsKIAlpZiAoIXRjb250ZXh0KSB7CiAJCXByaW50ayhLRVJOX0VS
UiAic2VjdXJpdHlfY29tcHV0ZV9hdjogIHVucmVjb2duaXplZCBTSUQgJWRcbiIsCiAJCSAgICAg
ICB0c2lkKTsKIAkJcmMgPSAtRUlOVkFMOwogCQlnb3RvIG91dDsKIAl9CiAKLQlyYyA9IGNvbnRl
eHRfc3RydWN0X2NvbXB1dGVfYXYoc2NvbnRleHQsIHRjb250ZXh0LCB0Y2xhc3MsCisJcmMgPSBj
b250ZXh0X3N0cnVjdF9jb21wdXRlX2F2KHAsIHNjb250ZXh0LCB0Y29udGV4dCwgdGNsYXNzLAog
CQkJCSAgICAgICByZXF1ZXN0ZWQsIGF2ZCk7CiBvdXQ6CiAJUE9MSUNZX1JEVU5MT0NLOwogCXJl
dHVybiByYzsKQEAgLTM1MCwxOSArMzQ5LDIwIEBACiAgKiBhbGxvY2F0ZWQgc3RyaW5nIG9mIHRo
ZSBjb3JyZWN0IHNpemUuICBTZXQgYCpzY29udGV4dCcKICAqIHRvIHBvaW50IHRvIHRoaXMgc3Ry
aW5nIGFuZCBzZXQgYCpzY29udGV4dF9sZW4nIHRvCiAgKiB0aGUgbGVuZ3RoIG9mIHRoZSBzdHJp
bmcuCiAgKi8KLWludCBjb250ZXh0X3N0cnVjdF90b19zdHJpbmcoc3RydWN0IGNvbnRleHQgKmNv
bnRleHQsIGNoYXIgKipzY29udGV4dCwgdTMyICpzY29udGV4dF9sZW4pCitpbnQgY29udGV4dF9z
dHJ1Y3RfdG9fc3RyaW5nKHN0cnVjdCBwb2xpY3lkYiAqcCwgc3RydWN0IGNvbnRleHQgKmNvbnRl
eHQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKipzY29udGV4dCwgdTMyICpz
Y29udGV4dF9sZW4pCiB7CiAJY2hhciAqc2NvbnRleHRwOwogCiAJKnNjb250ZXh0ID0gTlVMTDsK
IAkqc2NvbnRleHRfbGVuID0gMDsKIAogCS8qIENvbXB1dGUgdGhlIHNpemUgb2YgdGhlIGNvbnRl
eHQuICovCi0JKnNjb250ZXh0X2xlbiArPSBzdHJsZW4ocG9saWN5ZGIucF91c2VyX3ZhbF90b19u
YW1lW2NvbnRleHQtPnVzZXIgLSAxXSkgKyAxOwotCSpzY29udGV4dF9sZW4gKz0gc3RybGVuKHBv
bGljeWRiLnBfcm9sZV92YWxfdG9fbmFtZVtjb250ZXh0LT5yb2xlIC0gMV0pICsgMTsKLQkqc2Nv
bnRleHRfbGVuICs9IHN0cmxlbihwb2xpY3lkYi5wX3R5cGVfdmFsX3RvX25hbWVbY29udGV4dC0+
dHlwZSAtIDFdKSArIDE7CisJKnNjb250ZXh0X2xlbiArPSBzdHJsZW4ocC0+cF91c2VyX3ZhbF90
b19uYW1lW2NvbnRleHQtPnVzZXIgLSAxXSkgKyAxOworCSpzY29udGV4dF9sZW4gKz0gc3RybGVu
KHAtPnBfcm9sZV92YWxfdG9fbmFtZVtjb250ZXh0LT5yb2xlIC0gMV0pICsgMTsKKwkqc2NvbnRl
eHRfbGVuICs9IHN0cmxlbihwLT5wX3R5cGVfdmFsX3RvX25hbWVbY29udGV4dC0+dHlwZSAtIDFd
KSArIDE7CiAJKnNjb250ZXh0X2xlbiArPSBtbHNfY29tcHV0ZV9jb250ZXh0X2xlbihjb250ZXh0
KTsKIAogCS8qIEFsbG9jYXRlIHNwYWNlIGZvciB0aGUgY29udGV4dDsgY2FsbGVyIG11c3QgZnJl
ZSB0aGlzIHNwYWNlLiAqLwogCXNjb250ZXh0cCA9IGttYWxsb2MoKnNjb250ZXh0X2xlbisxLEdG
UF9BVE9NSUMpOwpAQCAtMzc0LDE0ICszNzQsMTQgQEAKIAkvKgogCSAqIENvcHkgdGhlIHVzZXIg
bmFtZSwgcm9sZSBuYW1lIGFuZCB0eXBlIG5hbWUgaW50byB0aGUgY29udGV4dC4KIAkgKi8KIAlz
cHJpbnRmKHNjb250ZXh0cCwgIiVzOiVzOiVzOiIsCi0JCXBvbGljeWRiLnBfdXNlcl92YWxfdG9f
bmFtZVtjb250ZXh0LT51c2VyIC0gMV0sCi0JCXBvbGljeWRiLnBfcm9sZV92YWxfdG9fbmFtZVtj
b250ZXh0LT5yb2xlIC0gMV0sCi0JCXBvbGljeWRiLnBfdHlwZV92YWxfdG9fbmFtZVtjb250ZXh0
LT50eXBlIC0gMV0pOwotCXNjb250ZXh0cCArPSBzdHJsZW4ocG9saWN5ZGIucF91c2VyX3ZhbF90
b19uYW1lW2NvbnRleHQtPnVzZXIgLSAxXSkgKwotCSAgICAgICAgICAgICAxICsgc3RybGVuKHBv
bGljeWRiLnBfcm9sZV92YWxfdG9fbmFtZVtjb250ZXh0LT5yb2xlIC0gMV0pICsKLQkgICAgICAg
ICAgICAgMSArIHN0cmxlbihwb2xpY3lkYi5wX3R5cGVfdmFsX3RvX25hbWVbY29udGV4dC0+dHlw
ZSAtIDFdKSArIDE7CisJCXAtPnBfdXNlcl92YWxfdG9fbmFtZVtjb250ZXh0LT51c2VyIC0gMV0s
CisJCXAtPnBfcm9sZV92YWxfdG9fbmFtZVtjb250ZXh0LT5yb2xlIC0gMV0sCisJCXAtPnBfdHlw
ZV92YWxfdG9fbmFtZVtjb250ZXh0LT50eXBlIC0gMV0pOworCXNjb250ZXh0cCArPSBzdHJsZW4o
cC0+cF91c2VyX3ZhbF90b19uYW1lW2NvbnRleHQtPnVzZXIgLSAxXSkgKworCSAgICAgICAgICAg
ICAxICsgc3RybGVuKHAtPnBfcm9sZV92YWxfdG9fbmFtZVtjb250ZXh0LT5yb2xlIC0gMV0pICsK
KwkgICAgICAgICAgICAgMSArIHN0cmxlbihwLT5wX3R5cGVfdmFsX3RvX25hbWVbY29udGV4dC0+
dHlwZSAtIDFdKSArIDE7CiAKIAltbHNfc2lkX3RvX2NvbnRleHQoY29udGV4dCwgJnNjb250ZXh0
cCk7CiAKIAlzY29udGV4dHAtLTsKQEAgLTQwMywxMiArNDAzLDE2IEBACiAgKiB0byBwb2ludCB0
byB0aGlzIHN0cmluZyBhbmQgc2V0IEBzY29udGV4dF9sZW4gdG8gdGhlIGxlbmd0aCBvZiB0aGUg
c3RyaW5nLgogICovCiBpbnQgc2VjdXJpdHlfc2lkX3RvX2NvbnRleHQodTMyIHNpZCwgY2hhciAq
KnNjb250ZXh0LCB1MzIgKnNjb250ZXh0X2xlbikKIHsKKwlzdHJ1Y3QgcG9saWN5ZGIgKnA7CiAJ
c3RydWN0IGNvbnRleHQgKmNvbnRleHQ7CiAJaW50IHJjID0gMDsKIAotCWlmICghc3NfaW5pdGlh
bGl6ZWQpIHsKKwlQT0xJQ1lfUkRMT0NLOworCXAgPSBwb2xpY3lkYjsKKworCWlmICghcCkgewog
CQlpZiAoc2lkIDw9IFNFQ0lOSVRTSURfTlVNKSB7CiAJCQljaGFyICpzY29udGV4dHA7CiAKIAkJ
CSpzY29udGV4dF9sZW4gPSBzdHJsZW4oaW5pdGlhbF9zaWRfdG9fc3RyaW5nW3NpZF0pICsgMTsK
QEAgLTQyMSwyMCArNDI1LDE5IEBACiAJCSAgICAgICAibG9hZF9wb2xpY3kgb24gdW5rbm93biBT
SUQgJWRcbiIsIHNpZCk7CiAJCXJjID0gLUVJTlZBTDsKIAkJZ290byBvdXQ7CiAJfQotCVBPTElD
WV9SRExPQ0s7Ci0JY29udGV4dCA9IHNpZHRhYl9zZWFyY2goJnNpZHRhYiwgc2lkKTsKKworCWNv
bnRleHQgPSBzaWR0YWJfc2VhcmNoKHAtPnNpZHRhYiwgc2lkKTsKIAlpZiAoIWNvbnRleHQpIHsK
IAkJcHJpbnRrKEtFUk5fRVJSICJzZWN1cml0eV9zaWRfdG9fY29udGV4dDogIHVucmVjb2duaXpl
ZCBTSUQgIgogCQkgICAgICAgIiVkXG4iLCBzaWQpOwogCQlyYyA9IC1FSU5WQUw7Ci0JCWdvdG8g
b3V0X3VubG9jazsKKwkJZ290byBvdXQ7CiAJfQotCXJjID0gY29udGV4dF9zdHJ1Y3RfdG9fc3Ry
aW5nKGNvbnRleHQsIHNjb250ZXh0LCBzY29udGV4dF9sZW4pOwotb3V0X3VubG9jazoKLQlQT0xJ
Q1lfUkRVTkxPQ0s7CisJcmMgPSBjb250ZXh0X3N0cnVjdF90b19zdHJpbmcocCwgY29udGV4dCwg
c2NvbnRleHQsIHNjb250ZXh0X2xlbik7CiBvdXQ6CisJUE9MSUNZX1JEVU5MT0NLOwogCXJldHVy
biByYzsKIAogfQogCkBAIC00NTEsNDcgKzQ1NCw0NiBAQAogICovCiBpbnQgc2VjdXJpdHlfY29u
dGV4dF90b19zaWQoY2hhciAqc2NvbnRleHQsIHUzMiBzY29udGV4dF9sZW4sIHUzMiAqc2lkKQog
ewogCWNoYXIgKnNjb250ZXh0MjsKKwlzdHJ1Y3QgcG9saWN5ZGIgKnBvbDsKIAlzdHJ1Y3QgY29u
dGV4dCBjb250ZXh0OwogCXN0cnVjdCByb2xlX2RhdHVtICpyb2xlOwogCXN0cnVjdCB0eXBlX2Rh
dHVtICp0eXBkYXR1bTsKIAlzdHJ1Y3QgdXNlcl9kYXR1bSAqdXNyZGF0dW07CiAJY2hhciAqc2Nv
bnRleHRwLCAqcCwgb2xkYzsKIAlpbnQgcmMgPSAwOwogCi0JaWYgKCFzc19pbml0aWFsaXplZCkg
eworCS8qIENvcHkgdGhlIHN0cmluZyBzbyB0aGF0IHdlIGNhbiBtb2RpZnkgdGhlIGNvcHkgYXMg
d2UgcGFyc2UgaXQuCisJICAgVGhlIHN0cmluZyBzaG91bGQgYWxyZWFkeSBieSBudWxsIHRlcm1p
bmF0ZWQsIGJ1dCB3ZSBhcHBlbmQgYQorCSAgIG51bGwgc3VmZml4IHRvIHRoZSBjb3B5IHRvIGF2
b2lkIHByb2JsZW1zIHdpdGggdGhlIGV4aXN0aW5nCisJICAgYXR0ciBwYWNrYWdlLCB3aGljaCBk
b2Vzbid0IHZpZXcgdGhlIG51bGwgdGVybWluYXRvciBhcyBwYXJ0CisJICAgb2YgdGhlIGF0dHJp
YnV0ZSB2YWx1ZS4gKi8KKwlzY29udGV4dDIgPSBrbWFsbG9jKHNjb250ZXh0X2xlbisxLEdGUF9L
RVJORUwpOworCWlmICghc2NvbnRleHQyKQorCQlyZXR1cm4gLUVOT01FTTsKKwltZW1jcHkoc2Nv
bnRleHQyLCBzY29udGV4dCwgc2NvbnRleHRfbGVuKTsKKwlzY29udGV4dDJbc2NvbnRleHRfbGVu
XSA9IDA7CisKKwlQT0xJQ1lfUkRMT0NLOworCXBvbCA9IHBvbGljeWRiOworCisJaWYgKCFwb2wp
IHsKIAkJaW50IGk7CiAKIAkJZm9yIChpID0gMTsgaSA8IFNFQ0lOSVRTSURfTlVNOyBpKyspIHsK
LQkJCWlmICghc3RyY21wKGluaXRpYWxfc2lkX3RvX3N0cmluZ1tpXSwgc2NvbnRleHQpKSB7CisJ
CQlpZiAoIXN0cmNtcChpbml0aWFsX3NpZF90b19zdHJpbmdbaV0sIHNjb250ZXh0MikpIHsKIAkJ
CQkqc2lkID0gaTsKIAkJCQlnb3RvIG91dDsKIAkJCX0KIAkJfQogCQkqc2lkID0gU0VDSU5JVFNJ
RF9LRVJORUw7CiAJCWdvdG8gb3V0OwogCX0KLQkqc2lkID0gU0VDU0lEX05VTEw7Ci0KLQkvKiBD
b3B5IHRoZSBzdHJpbmcgc28gdGhhdCB3ZSBjYW4gbW9kaWZ5IHRoZSBjb3B5IGFzIHdlIHBhcnNl
IGl0LgotCSAgIFRoZSBzdHJpbmcgc2hvdWxkIGFscmVhZHkgYnkgbnVsbCB0ZXJtaW5hdGVkLCBi
dXQgd2UgYXBwZW5kIGEKLQkgICBudWxsIHN1ZmZpeCB0byB0aGUgY29weSB0byBhdm9pZCBwcm9i
bGVtcyB3aXRoIHRoZSBleGlzdGluZwotCSAgIGF0dHIgcGFja2FnZSwgd2hpY2ggZG9lc24ndCB2
aWV3IHRoZSBudWxsIHRlcm1pbmF0b3IgYXMgcGFydAotCSAgIG9mIHRoZSBhdHRyaWJ1dGUgdmFs
dWUuICovCi0Jc2NvbnRleHQyID0ga21hbGxvYyhzY29udGV4dF9sZW4rMSxHRlBfS0VSTkVMKTsK
LQlpZiAoIXNjb250ZXh0MikgewotCQlyYyA9IC1FTk9NRU07Ci0JCWdvdG8gb3V0OwotCX0KLQlt
ZW1jcHkoc2NvbnRleHQyLCBzY29udGV4dCwgc2NvbnRleHRfbGVuKTsKLQlzY29udGV4dDJbc2Nv
bnRleHRfbGVuXSA9IDA7CiAKIAljb250ZXh0X2luaXQoJmNvbnRleHQpOwogCSpzaWQgPSBTRUNT
SURfTlVMTDsKIAotCVBPTElDWV9SRExPQ0s7Ci0KIAkvKiBQYXJzZSB0aGUgc2VjdXJpdHkgY29u
dGV4dC4gKi8KIAogCXJjID0gLUVJTlZBTDsKIAlzY29udGV4dHAgPSAoY2hhciAqKSBzY29udGV4
dDI7CkBAIC01MDUsOSArNTA3LDkgQEAKIAkJZ290byBvdXRfdW5sb2NrOwogCiAJKnArKyA9IDA7
CiAKLQl1c3JkYXR1bSA9IGhhc2h0YWJfc2VhcmNoKHBvbGljeWRiLnBfdXNlcnMudGFibGUsIHNj
b250ZXh0cCk7CisJdXNyZGF0dW0gPSBoYXNodGFiX3NlYXJjaChwb2wtPnBfdXNlcnMudGFibGUs
IHNjb250ZXh0cCk7CiAJaWYgKCF1c3JkYXR1bSkKIAkJZ290byBvdXRfdW5sb2NrOwogCiAJY29u
dGV4dC51c2VyID0gdXNyZGF0dW0tPnZhbHVlOwpAQCAtNTIxLDkgKzUyMyw5IEBACiAJCWdvdG8g
b3V0X3VubG9jazsKIAogCSpwKysgPSAwOwogCi0Jcm9sZSA9IGhhc2h0YWJfc2VhcmNoKHBvbGlj
eWRiLnBfcm9sZXMudGFibGUsIHNjb250ZXh0cCk7CisJcm9sZSA9IGhhc2h0YWJfc2VhcmNoKHBv
bC0+cF9yb2xlcy50YWJsZSwgc2NvbnRleHRwKTsKIAlpZiAoIXJvbGUpCiAJCWdvdG8gb3V0X3Vu
bG9jazsKIAljb250ZXh0LnJvbGUgPSByb2xlLT52YWx1ZTsKIApAQCAtNTMzLDkgKzUzNSw5IEBA
CiAJCXArKzsKIAlvbGRjID0gKnA7CiAJKnArKyA9IDA7CiAKLQl0eXBkYXR1bSA9IGhhc2h0YWJf
c2VhcmNoKHBvbGljeWRiLnBfdHlwZXMudGFibGUsIHNjb250ZXh0cCk7CisJdHlwZGF0dW0gPSBo
YXNodGFiX3NlYXJjaChwb2wtPnBfdHlwZXMudGFibGUsIHNjb250ZXh0cCk7CiAJaWYgKCF0eXBk
YXR1bSkKIAkJZ290byBvdXRfdW5sb2NrOwogCiAJY29udGV4dC50eXBlID0gdHlwZGF0dW0tPnZh
bHVlOwpAQCAtNTQ5LDQzICs1NTEsNDQgQEAKIAkJZ290byBvdXRfdW5sb2NrOwogCX0KIAogCS8q
IENoZWNrIHRoZSB2YWxpZGl0eSBvZiB0aGUgbmV3IGNvbnRleHQuICovCi0JaWYgKCFwb2xpY3lk
Yl9jb250ZXh0X2lzdmFsaWQoJnBvbGljeWRiLCAmY29udGV4dCkpIHsKKwlpZiAoIXBvbGljeWRi
X2NvbnRleHRfaXN2YWxpZChwb2wsICZjb250ZXh0KSkgewogCQlyYyA9IC1FSU5WQUw7CiAJCWdv
dG8gb3V0X3VubG9jazsKIAl9CiAJLyogT2J0YWluIHRoZSBuZXcgc2lkLiAqLwotCXJjID0gc2lk
dGFiX2NvbnRleHRfdG9fc2lkKCZzaWR0YWIsICZjb250ZXh0LCBzaWQpOworCXJjID0gc2lkdGFi
X2NvbnRleHRfdG9fc2lkKHBvbC0+c2lkdGFiLCAmY29udGV4dCwgc2lkKTsKIG91dF91bmxvY2s6
CiAJUE9MSUNZX1JEVU5MT0NLOwogCWNvbnRleHRfZGVzdHJveSgmY29udGV4dCk7Ci0Ja2ZyZWUo
c2NvbnRleHQyKTsKIG91dDoKKwlrZnJlZShzY29udGV4dDIpOwogCXJldHVybiByYzsKIH0KIAog
c3RhdGljIGludCBjb21wdXRlX3NpZF9oYW5kbGVfaW52YWxpZF9jb250ZXh0KAorCXN0cnVjdCBw
b2xpY3lkYiAqcCwKIAlzdHJ1Y3QgY29udGV4dCAqc2NvbnRleHQsCiAJc3RydWN0IGNvbnRleHQg
KnRjb250ZXh0LAogCXUxNiB0Y2xhc3MsCiAJc3RydWN0IGNvbnRleHQgKm5ld2NvbnRleHQpCiB7
CiAJY2hhciAqcyA9IE5VTEwsICp0ID0gTlVMTCwgKm4gPSBOVUxMOwogCXUzMiBzbGVuLCB0bGVu
LCBubGVuOwogCi0JaWYgKGNvbnRleHRfc3RydWN0X3RvX3N0cmluZyhzY29udGV4dCwgJnMsICZz
bGVuKSA8IDApCisJaWYgKGNvbnRleHRfc3RydWN0X3RvX3N0cmluZyhwLCBzY29udGV4dCwgJnMs
ICZzbGVuKSA8IDApCiAJCWdvdG8gb3V0OwotCWlmIChjb250ZXh0X3N0cnVjdF90b19zdHJpbmco
dGNvbnRleHQsICZ0LCAmdGxlbikgPCAwKQorCWlmIChjb250ZXh0X3N0cnVjdF90b19zdHJpbmco
cCwgdGNvbnRleHQsICZ0LCAmdGxlbikgPCAwKQogCQlnb3RvIG91dDsKLQlpZiAoY29udGV4dF9z
dHJ1Y3RfdG9fc3RyaW5nKG5ld2NvbnRleHQsICZuLCAmbmxlbikgPCAwKQorCWlmIChjb250ZXh0
X3N0cnVjdF90b19zdHJpbmcocCwgbmV3Y29udGV4dCwgJm4sICZubGVuKSA8IDApCiAJCWdvdG8g
b3V0OwogCWF1ZGl0X2xvZyhjdXJyZW50LT5hdWRpdF9jb250ZXh0LAogCQkgICJzZWN1cml0eV9j
b21wdXRlX3NpZDogIGludmFsaWQgY29udGV4dCAlcyIKIAkJICAiIGZvciBzY29udGV4dD0lcyIK
IAkJICAiIHRjb250ZXh0PSVzIgogCQkgICIgdGNsYXNzPSVzIiwKLQkJICBuLCBzLCB0LCBwb2xp
Y3lkYi5wX2NsYXNzX3ZhbF90b19uYW1lW3RjbGFzcy0xXSk7CisJCSAgbiwgcywgdCwgcC0+cF9j
bGFzc192YWxfdG9fbmFtZVt0Y2xhc3MtMV0pOwogb3V0OgogCWtmcmVlKHMpOwogCWtmcmVlKHQp
OwogCWtmcmVlKG4pOwpAQCAtNTk5LDE3ICs2MDIsMjEgQEAKIAkJCQl1MTYgdGNsYXNzLAogCQkJ
CXUzMiBzcGVjaWZpZWQsCiAJCQkJdTMyICpvdXRfc2lkKQogeworCXN0cnVjdCBwb2xpY3lkYiAq
cDsKIAlzdHJ1Y3QgY29udGV4dCAqc2NvbnRleHQgPSBOVUxMLCAqdGNvbnRleHQgPSBOVUxMLCBu
ZXdjb250ZXh0OwogCXN0cnVjdCByb2xlX3RyYW5zICpyb2xldHIgPSBOVUxMOwogCXN0cnVjdCBh
dnRhYl9rZXkgYXZrZXk7CiAJc3RydWN0IGF2dGFiX2RhdHVtICphdmRhdHVtOwogCXN0cnVjdCBh
dnRhYl9ub2RlICpub2RlOwogCXVuc2lnbmVkIGludCB0eXBlX2NoYW5nZSA9IDA7CiAJaW50IHJj
ID0gMDsKIAotCWlmICghc3NfaW5pdGlhbGl6ZWQpIHsKKwlQT0xJQ1lfUkRMT0NLOworCXAgPSBw
b2xpY3lkYjsKKworCWlmICghcCkgewogCQlzd2l0Y2ggKHRjbGFzcykgewogCQljYXNlIFNFQ0NM
QVNTX1BST0NFU1M6CiAJCQkqb3V0X3NpZCA9IHNzaWQ7CiAJCQlicmVhazsKQEAgLTYxOSwxOCAr
NjI2LDE2IEBACiAJCX0KIAkJZ290byBvdXQ7CiAJfQogCi0JUE9MSUNZX1JETE9DSzsKLQotCXNj
b250ZXh0ID0gc2lkdGFiX3NlYXJjaCgmc2lkdGFiLCBzc2lkKTsKKwlzY29udGV4dCA9IHNpZHRh
Yl9zZWFyY2gocC0+c2lkdGFiLCBzc2lkKTsKIAlpZiAoIXNjb250ZXh0KSB7CiAJCXByaW50ayhL
RVJOX0VSUiAic2VjdXJpdHlfY29tcHV0ZV9zaWQ6ICB1bnJlY29nbml6ZWQgU0lEICVkXG4iLAog
CQkgICAgICAgc3NpZCk7CiAJCXJjID0gLUVJTlZBTDsKIAkJZ290byBvdXRfdW5sb2NrOwogCX0K
LQl0Y29udGV4dCA9IHNpZHRhYl9zZWFyY2goJnNpZHRhYiwgdHNpZCk7CisJdGNvbnRleHQgPSBz
aWR0YWJfc2VhcmNoKHAtPnNpZHRhYiwgdHNpZCk7CiAJaWYgKCF0Y29udGV4dCkgewogCQlwcmlu
dGsoS0VSTl9FUlIgInNlY3VyaXR5X2NvbXB1dGVfc2lkOiAgdW5yZWNvZ25pemVkIFNJRCAlZFxu
IiwKIAkJICAgICAgIHRzaWQpOwogCQlyYyA9IC1FSU5WQUw7CkBAIC02NjksMTMgKzY3NCwxMyBA
QAogCS8qIExvb2sgZm9yIGEgdHlwZSB0cmFuc2l0aW9uL21lbWJlci9jaGFuZ2UgcnVsZS4gKi8K
IAlhdmtleS5zb3VyY2VfdHlwZSA9IHNjb250ZXh0LT50eXBlOwogCWF2a2V5LnRhcmdldF90eXBl
ID0gdGNvbnRleHQtPnR5cGU7CiAJYXZrZXkudGFyZ2V0X2NsYXNzID0gdGNsYXNzOwotCWF2ZGF0
dW0gPSBhdnRhYl9zZWFyY2goJnBvbGljeWRiLnRlX2F2dGFiLCAmYXZrZXksIEFWVEFCX1RZUEUp
OworCWF2ZGF0dW0gPSBhdnRhYl9zZWFyY2goJnAtPnRlX2F2dGFiLCAmYXZrZXksIEFWVEFCX1RZ
UEUpOwogCiAJLyogSWYgbm8gcGVybWFuZW50IHJ1bGUsIGFsc28gY2hlY2sgZm9yIGVuYWJsZWQg
Y29uZGl0aW9uYWwgcnVsZXMgKi8KIAlpZighYXZkYXR1bSkgewotCQlub2RlID0gYXZ0YWJfc2Vh
cmNoX25vZGUoJnBvbGljeWRiLnRlX2NvbmRfYXZ0YWIsICZhdmtleSwgc3BlY2lmaWVkKTsKKwkJ
bm9kZSA9IGF2dGFiX3NlYXJjaF9ub2RlKCZwLT50ZV9jb25kX2F2dGFiLCAmYXZrZXksIHNwZWNp
ZmllZCk7CiAJCWZvciAoOyBub2RlICE9IE5VTEw7IG5vZGUgPSBhdnRhYl9zZWFyY2hfbm9kZV9u
ZXh0KG5vZGUsIHNwZWNpZmllZCkpIHsKIAkJCWlmIChub2RlLT5kYXR1bS5zcGVjaWZpZWQgJiBB
VlRBQl9FTkFCTEVEKSB7CiAJCQkJYXZkYXR1bSA9ICZub2RlLT5kYXR1bTsKIAkJCQlicmVhazsK
QEAgLTcwMyw5ICs3MDgsOSBAQAogCXN3aXRjaCAodGNsYXNzKSB7CiAJY2FzZSBTRUNDTEFTU19Q
Uk9DRVNTOgogCQlpZiAoc3BlY2lmaWVkICYgQVZUQUJfVFJBTlNJVElPTikgewogCQkJLyogTG9v
ayBmb3IgYSByb2xlIHRyYW5zaXRpb24gcnVsZS4gKi8KLQkJCWZvciAocm9sZXRyID0gcG9saWN5
ZGIucm9sZV90cjsgcm9sZXRyOworCQkJZm9yIChyb2xldHIgPSBwLT5yb2xlX3RyOyByb2xldHI7
CiAJCQkgICAgIHJvbGV0ciA9IHJvbGV0ci0+bmV4dCkgewogCQkJCWlmIChyb2xldHItPnJvbGUg
PT0gc2NvbnRleHQtPnJvbGUgJiYKIAkJCQkgICAgcm9sZXRyLT50eXBlID09IHRjb250ZXh0LT50
eXBlKSB7CiAJCQkJCS8qIFVzZSB0aGUgcm9sZSB0cmFuc2l0aW9uIHJ1bGUuICovCkBAIC03NDAs
MTggKzc0NSwxNiBAQAogCWlmIChyYykKIAkJZ290byBvdXRfdW5sb2NrOwogCiAJLyogQ2hlY2sg
dGhlIHZhbGlkaXR5IG9mIHRoZSBjb250ZXh0LiAqLwotCWlmICghcG9saWN5ZGJfY29udGV4dF9p
c3ZhbGlkKCZwb2xpY3lkYiwgJm5ld2NvbnRleHQpKSB7Ci0JCXJjID0gY29tcHV0ZV9zaWRfaGFu
ZGxlX2ludmFsaWRfY29udGV4dChzY29udGV4dCwKLQkJCQkJCQl0Y29udGV4dCwKLQkJCQkJCQl0
Y2xhc3MsCi0JCQkJCQkJJm5ld2NvbnRleHQpOworCWlmICghcG9saWN5ZGJfY29udGV4dF9pc3Zh
bGlkKHAsICZuZXdjb250ZXh0KSkgeworCQlyYyA9IGNvbXB1dGVfc2lkX2hhbmRsZV9pbnZhbGlk
X2NvbnRleHQocCwgc2NvbnRleHQsIHRjb250ZXh0LAorCQkJCQkJCXRjbGFzcywgJm5ld2NvbnRl
eHQpOwogCQlpZiAocmMpCiAJCQlnb3RvIG91dF91bmxvY2s7CiAJfQogCS8qIE9idGFpbiB0aGUg
c2lkIGZvciB0aGUgY29udGV4dC4gKi8KLQlyYyA9IHNpZHRhYl9jb250ZXh0X3RvX3NpZCgmc2lk
dGFiLCAmbmV3Y29udGV4dCwgb3V0X3NpZCk7CisJcmMgPSBzaWR0YWJfY29udGV4dF90b19zaWQo
cC0+c2lkdGFiLCAmbmV3Y29udGV4dCwgb3V0X3NpZCk7CiBvdXRfdW5sb2NrOgogCVBPTElDWV9S
RFVOTE9DSzsKIAljb250ZXh0X2Rlc3Ryb3koJm5ld2NvbnRleHQpOwogb3V0OgpAQCAtOTEzLDkg
KzkxNiw5IEBACiAKIAlyZXR1cm4gc2lkdGFiX2luc2VydChzLCBzaWQsIGNvbnRleHQpOwogfQog
Ci1zdGF0aWMgaW5saW5lIGludCBjb252ZXJ0X2NvbnRleHRfaGFuZGxlX2ludmFsaWRfY29udGV4
dChzdHJ1Y3QgY29udGV4dCAqY29udGV4dCkKK3N0YXRpYyBpbmxpbmUgaW50IGNvbnZlcnRfY29u
dGV4dF9oYW5kbGVfaW52YWxpZF9jb250ZXh0KHN0cnVjdCBwb2xpY3lkYiAqcCwgc3RydWN0IGNv
bnRleHQgKmNvbnRleHQpCiB7CiAJaW50IHJjID0gMDsKIAogCWlmIChzZWxpbnV4X2VuZm9yY2lu
ZykgewpAQCAtOTIzLDkgKzkyNiw5IEBACiAJfSBlbHNlIHsKIAkJY2hhciAqczsKIAkJdTMyIGxl
bjsKIAotCQljb250ZXh0X3N0cnVjdF90b19zdHJpbmcoY29udGV4dCwgJnMsICZsZW4pOworCQlj
b250ZXh0X3N0cnVjdF90b19zdHJpbmcocCwgY29udGV4dCwgJnMsICZsZW4pOwogCQlwcmludGso
S0VSTl9FUlIgInNlY3VyaXR5OiAgY29udGV4dCAlcyBpcyBpbnZhbGlkXG4iLCBzKTsKIAkJa2Zy
ZWUocyk7CiAJfQogCXJldHVybiByYzsKQEAgLTk5MywyNiArOTk2LDM3IEBACiAJCWdvdG8gYmFk
OwogCiAJLyogQ2hlY2sgdGhlIHZhbGlkaXR5IG9mIHRoZSBuZXcgY29udGV4dC4gKi8KIAlpZiAo
IXBvbGljeWRiX2NvbnRleHRfaXN2YWxpZChhcmdzLT5uZXdwLCBjKSkgewotCQlyYyA9IGNvbnZl
cnRfY29udGV4dF9oYW5kbGVfaW52YWxpZF9jb250ZXh0KCZvbGRjKTsKKwkJcmMgPSBjb252ZXJ0
X2NvbnRleHRfaGFuZGxlX2ludmFsaWRfY29udGV4dChhcmdzLT5vbGRwLCAmb2xkYyk7CiAJCWlm
IChyYykKIAkJCWdvdG8gYmFkOwogCX0KIAogCWNvbnRleHRfZGVzdHJveSgmb2xkYyk7CiBvdXQ6
CiAJcmV0dXJuIHJjOwogYmFkOgotCWNvbnRleHRfc3RydWN0X3RvX3N0cmluZygmb2xkYywgJnMs
ICZsZW4pOworCWNvbnRleHRfc3RydWN0X3RvX3N0cmluZyhhcmdzLT5vbGRwLCAmb2xkYywgJnMs
ICZsZW4pOwogCWNvbnRleHRfZGVzdHJveSgmb2xkYyk7CiAJcHJpbnRrKEtFUk5fRVJSICJzZWN1
cml0eTogIGludmFsaWRhdGluZyBjb250ZXh0ICVzXG4iLCBzKTsKIAlrZnJlZShzKTsKIAlnb3Rv
IG91dDsKIH0KIAogZXh0ZXJuIHZvaWQgc2VsaW51eF9jb21wbGV0ZV9pbml0KHZvaWQpOwogCit2
b2lkIHBvbGljeWRiX2Rlc3Ryb3lfcmN1KHN0cnVjdCByY3VfaGVhZCAqcCkKK3sKKwlzdHJ1Y3Qg
cG9saWN5ZGIgKm9sZGRiOworCW9sZGRiID0gY29udGFpbmVyX29mKHAsIHN0cnVjdCBwb2xpY3lk
YiwgcmhlYWQpOworCisJc2lkdGFiX2Rlc3Ryb3kob2xkZGItPnNpZHRhYik7CQorCXBvbGljeWRi
X2Rlc3Ryb3kob2xkZGIpOworCWtmcmVlKG9sZGRiKTsKKwlwcmludGsoImtmcmVlKG9sZGRiKSBp
biBwb2xpY3lkYl9kZXN0cm95X3JjdSgpIHByZWVtcHQoKT0weCV4XG4iLHByZWVtcHRfY291bnQo
KSk7Cit9CisKIC8qKgogICogc2VjdXJpdHlfbG9hZF9wb2xpY3kgLSBMb2FkIGEgc2VjdXJpdHkg
cG9saWN5IGNvbmZpZ3VyYXRpb24uCiAgKiBAZGF0YTogYmluYXJ5IHBvbGljeSBkYXRhCiAgKiBA
bGVuOiBsZW5ndGggb2YgZGF0YSBpbiBieXRlcwpAQCAtMTAyMywyOSArMTAzNywzNCBAQAogICog
bG9hZGluZyB0aGUgbmV3IHBvbGljeS4KICAqLwogaW50IHNlY3VyaXR5X2xvYWRfcG9saWN5KHZv
aWQgKmRhdGEsIHNpemVfdCBsZW4pCiB7Ci0Jc3RydWN0IHBvbGljeWRiIG9sZHBvbGljeWRiLCBu
ZXdwb2xpY3lkYjsKLQlzdHJ1Y3Qgc2lkdGFiIG9sZHNpZHRhYiwgbmV3c2lkdGFiOworCXN0cnVj
dCBwb2xpY3lkYiAqbmV3ZGIsICpvbGRkYjsKIAlzdHJ1Y3QgY29udmVydF9jb250ZXh0X2FyZ3Mg
YXJnczsKIAl1MzIgc2Vxbm87CiAJaW50IHJjID0gMDsKIAlzdHJ1Y3QgcG9saWN5X2ZpbGUgZmls
ZSA9IHsgZGF0YSwgbGVuIH0sICpmcCA9ICZmaWxlOwogCisJbmV3ZGIgPSBrbWFsbG9jKHNpemVv
ZihzdHJ1Y3QgcG9saWN5ZGIpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIW5ld2RiKQorCQlyZXR1cm4g
LUVOT01FTTsKKwogCUxPQURfTE9DSzsKKwlvbGRkYiA9IHBvbGljeWRiOwogCi0JaWYgKCFzc19p
bml0aWFsaXplZCkgeworCWlmICghb2xkZGIpIHsKIAkJYXZ0YWJfY2FjaGVfaW5pdCgpOwotCQlp
ZiAocG9saWN5ZGJfcmVhZCgmcG9saWN5ZGIsIGZwKSkgeworCQlpZiAocG9saWN5ZGJfcmVhZChu
ZXdkYiwgZnApKSB7CiAJCQlMT0FEX1VOTE9DSzsKIAkJCXJldHVybiAtRUlOVkFMOwogCQl9Ci0J
CWlmIChwb2xpY3lkYl9sb2FkX2lzaWRzKCZwb2xpY3lkYiwgJnNpZHRhYikpIHsKKwkJaWYgKHBv
bGljeWRiX2xvYWRfaXNpZHMobmV3ZGIsIG5ld2RiLT5zaWR0YWIpKSB7CiAJCQlMT0FEX1VOTE9D
SzsKLQkJCXBvbGljeWRiX2Rlc3Ryb3koJnBvbGljeWRiKTsKKwkJCXBvbGljeWRiX2Rlc3Ryb3ko
bmV3ZGIpOwogCQkJcmV0dXJuIC1FSU5WQUw7CiAJCX0KLQkJc3NfaW5pdGlhbGl6ZWQgPSAxOwor
CQlzbXBfd21iKCk7CisJCXBvbGljeWRiID0gbmV3ZGI7CiAKIAkJTE9BRF9VTkxPQ0s7CiAJCXNl
bGludXhfY29tcGxldGVfaW5pdCgpOwogCQlyZXR1cm4gMDsKQEAgLTEwNTQsNjIgKzEwNzMsNTIg
QEAKICNpZiAwCiAJc2lkdGFiX2hhc2hfZXZhbCgmc2lkdGFiLCAic2lkcyIpOwogI2VuZGlmCiAK
LQlpZiAocG9saWN5ZGJfcmVhZCgmbmV3cG9saWN5ZGIsIGZwKSkgeworCWlmIChwb2xpY3lkYl9y
ZWFkKG5ld2RiLCBmcCkpIHsKIAkJTE9BRF9VTkxPQ0s7CiAJCXJldHVybiAtRUlOVkFMOwogCX0K
IAotCXNpZHRhYl9pbml0KCZuZXdzaWR0YWIpOwotCiAJLyogVmVyaWZ5IHRoYXQgdGhlIGV4aXN0
aW5nIGNsYXNzZXMgZGlkIG5vdCBjaGFuZ2UuICovCi0JaWYgKGhhc2h0YWJfbWFwKHBvbGljeWRi
LnBfY2xhc3Nlcy50YWJsZSwgdmFsaWRhdGVfY2xhc3MsICZuZXdwb2xpY3lkYikpIHsKKwlpZiAo
aGFzaHRhYl9tYXAob2xkZGItPnBfY2xhc3Nlcy50YWJsZSwgdmFsaWRhdGVfY2xhc3MsIG5ld2Ri
KSkgewogCQlwcmludGsoS0VSTl9FUlIgInNlY3VyaXR5OiAgdGhlIGRlZmluaXRpb24gb2YgYW4g
ZXhpc3RpbmcgIgogCQkgICAgICAgImNsYXNzIGNoYW5nZWRcbiIpOwogCQlyYyA9IC1FSU5WQUw7
CiAJCWdvdG8gZXJyOwogCX0KLQorCQogCS8qIENsb25lIHRoZSBTSUQgdGFibGUuICovCi0Jc2lk
dGFiX3NodXRkb3duKCZzaWR0YWIpOwotCWlmIChzaWR0YWJfbWFwKCZzaWR0YWIsIGNsb25lX3Np
ZCwgJm5ld3NpZHRhYikpIHsKKwlzaWR0YWJfc2h1dGRvd24ob2xkZGItPnNpZHRhYik7CisJaWYg
KHNpZHRhYl9tYXAob2xkZGItPnNpZHRhYiwgY2xvbmVfc2lkLCBuZXdkYi0+c2lkdGFiKSkgewog
CQlyYyA9IC1FTk9NRU07CiAJCWdvdG8gZXJyOwogCX0KIAogCS8qIENvbnZlcnQgdGhlIGludGVy
bmFsIHJlcHJlc2VudGF0aW9ucyBvZiBjb250ZXh0cwogCSAgIGluIHRoZSBuZXcgU0lEIHRhYmxl
IGFuZCByZW1vdmUgaW52YWxpZCBTSURzLiAqLwotCWFyZ3Mub2xkcCA9ICZwb2xpY3lkYjsKLQlh
cmdzLm5ld3AgPSAmbmV3cG9saWN5ZGI7Ci0Jc2lkdGFiX21hcF9yZW1vdmVfb25fZXJyb3IoJm5l
d3NpZHRhYiwgY29udmVydF9jb250ZXh0LCAmYXJncyk7Ci0KLQkvKiBTYXZlIHRoZSBvbGQgcG9s
aWN5ZGIgYW5kIFNJRCB0YWJsZSB0byBmcmVlIGxhdGVyLiAqLwotCW1lbWNweSgmb2xkcG9saWN5
ZGIsICZwb2xpY3lkYiwgc2l6ZW9mIHBvbGljeWRiKTsKLQlzaWR0YWJfc2V0KCZvbGRzaWR0YWIs
ICZzaWR0YWIpOwotCi0JLyogSW5zdGFsbCB0aGUgbmV3IHBvbGljeWRiIGFuZCBTSUQgdGFibGUu
ICovCi0JUE9MSUNZX1dSTE9DSzsKLQltZW1jcHkoJnBvbGljeWRiLCAmbmV3cG9saWN5ZGIsIHNp
emVvZiBwb2xpY3lkYik7Ci0Jc2lkdGFiX3NldCgmc2lkdGFiLCAmbmV3c2lkdGFiKTsKKwlhcmdz
Lm9sZHAgPSBvbGRkYjsKKwlhcmdzLm5ld3AgPSBuZXdkYjsKKwlzaWR0YWJfbWFwX3JlbW92ZV9v
bl9lcnJvcihuZXdkYi0+c2lkdGFiLCBjb252ZXJ0X2NvbnRleHQsICZhcmdzKTsKKworCS8qIHVw
ZGF0ZSBwb2xpY3lkYiBhdG9taWNhbGx5ICovCisJc21wX3dtYigpOworCXBvbGljeWRiID0gbmV3
ZGI7CiAJc2Vxbm8gPSArK2xhdGVzdF9ncmFudGluZzsKLQotCVBPTElDWV9XUlVOTE9DSzsKKwkK
IAlMT0FEX1VOTE9DSzsKIAotCS8qIEZyZWUgdGhlIG9sZCBwb2xpY3lkYiBhbmQgU0lEIHRhYmxl
LiAqLwotCXBvbGljeWRiX2Rlc3Ryb3koJm9sZHBvbGljeWRiKTsKLQlzaWR0YWJfZGVzdHJveSgm
b2xkc2lkdGFiKTsKKwljYWxsX3JjdSgmb2xkZGItPnJoZWFkLCBwb2xpY3lkYl9kZXN0cm95X3Jj
dSk7CiAKIAlhdmNfc3NfcmVzZXQoc2Vxbm8pOwogCXNlbG5sX25vdGlmeV9wb2xpY3lsb2FkKHNl
cW5vKTsKIAogCXJldHVybiAwOwogCiBlcnI6CiAJTE9BRF9VTkxPQ0s7Ci0Jc2lkdGFiX2Rlc3Ry
b3koJm5ld3NpZHRhYik7Ci0JcG9saWN5ZGJfZGVzdHJveSgmbmV3cG9saWN5ZGIpOworCXNpZHRh
Yl9kZXN0cm95KG5ld2RiLT5zaWR0YWIpOworCXBvbGljeWRiX2Rlc3Ryb3kobmV3ZGIpOwogCXJl
dHVybiByYzsKIAogfQogCkBAIC0xMTI2LDE0ICsxMTM1LDIxIEBACiAJCSAgICAgIHU4IHByb3Rv
Y29sLAogCQkgICAgICB1MTYgcG9ydCwKIAkJICAgICAgdTMyICpvdXRfc2lkKQogeworCXN0cnVj
dCBwb2xpY3lkYiAqcDsKIAlzdHJ1Y3Qgb2NvbnRleHQgKmM7CiAJaW50IHJjID0gMDsKIAogCVBP
TElDWV9SRExPQ0s7CisJcCA9IHBvbGljeWRiOwogCi0JYyA9IHBvbGljeWRiLm9jb250ZXh0c1tP
Q09OX1BPUlRdOworCWlmICghcCkgeworCQkqb3V0X3NpZCA9IFNFQ0lOSVRTSURfUE9SVDsKKwkJ
Z290byBvdXQ7CisJfQorCisJYyA9IHAtPm9jb250ZXh0c1tPQ09OX1BPUlRdOwogCXdoaWxlIChj
KSB7CiAJCWlmIChjLT51LnBvcnQucHJvdG9jb2wgPT0gcHJvdG9jb2wgJiYKIAkJICAgIGMtPnUu
cG9ydC5sb3dfcG9ydCA8PSBwb3J0ICYmCiAJCSAgICBjLT51LnBvcnQuaGlnaF9wb3J0ID49IHBv
cnQpCkBAIC0xMTQyLDkgKzExNTgsOSBAQAogCX0KIAogCWlmIChjKSB7CiAJCWlmICghYy0+c2lk
WzBdKSB7Ci0JCQlyYyA9IHNpZHRhYl9jb250ZXh0X3RvX3NpZCgmc2lkdGFiLAorCQkJcmMgPSBz
aWR0YWJfY29udGV4dF90b19zaWQocC0+c2lkdGFiLAogCQkJCQkJICAgJmMtPmNvbnRleHRbMF0s
CiAJCQkJCQkgICAmYy0+c2lkWzBdKTsKIAkJCWlmIChyYykKIAkJCQlnb3RvIG91dDsKQEAgLTEx
NjksMjcgKzExODUsMzUgQEAKIAkJICAgICAgIHUzMiAqaWZfc2lkLAogCQkgICAgICAgdTMyICpt
c2dfc2lkKQogewogCWludCByYyA9IDA7CisJc3RydWN0IHBvbGljeWRiICpwOwogCXN0cnVjdCBv
Y29udGV4dCAqYzsKIAogCVBPTElDWV9SRExPQ0s7CisJcCA9IHBvbGljeWRiOworCisJaWYgKCFw
KSB7CisJCSppZl9zaWQgPSBTRUNJTklUU0lEX05FVElGOworCQkqbXNnX3NpZCA9IFNFQ0lOSVRT
SURfTkVUTVNHOworCQlnb3RvIG91dDsKKwl9CiAKLQljID0gcG9saWN5ZGIub2NvbnRleHRzW09D
T05fTkVUSUZdOworCWMgPSBwLT5vY29udGV4dHNbT0NPTl9ORVRJRl07CiAJd2hpbGUgKGMpIHsK
IAkJaWYgKHN0cmNtcChuYW1lLCBjLT51Lm5hbWUpID09IDApCiAJCQlicmVhazsKIAkJYyA9IGMt
Pm5leHQ7CiAJfQogCiAJaWYgKGMpIHsKIAkJaWYgKCFjLT5zaWRbMF0gfHwgIWMtPnNpZFsxXSkg
ewotCQkJcmMgPSBzaWR0YWJfY29udGV4dF90b19zaWQoJnNpZHRhYiwKKwkJCXJjID0gc2lkdGFi
X2NvbnRleHRfdG9fc2lkKHAtPnNpZHRhYiwKIAkJCQkJCSAgJmMtPmNvbnRleHRbMF0sCiAJCQkJ
CQkgICZjLT5zaWRbMF0pOwogCQkJaWYgKHJjKQogCQkJCWdvdG8gb3V0OwotCQkJcmMgPSBzaWR0
YWJfY29udGV4dF90b19zaWQoJnNpZHRhYiwKKwkJCXJjID0gc2lkdGFiX2NvbnRleHRfdG9fc2lk
KHAtPnNpZHRhYiwKIAkJCQkJCSAgICZjLT5jb250ZXh0WzFdLAogCQkJCQkJICAgJmMtPnNpZFsx
XSk7CiAJCQlpZiAocmMpCiAJCQkJZ290byBvdXQ7CkBAIC0xMjMxLDExICsxMjU1LDE4IEBACiAJ
CSAgICAgIHUzMiBhZGRybGVuLAogCQkgICAgICB1MzIgKm91dF9zaWQpCiB7CiAJaW50IHJjID0g
MDsKKwlzdHJ1Y3QgcG9saWN5ZGIgKnA7CiAJc3RydWN0IG9jb250ZXh0ICpjOwogCiAJUE9MSUNZ
X1JETE9DSzsKKwlwID0gcG9saWN5ZGI7CisKKwlpZiAoIXApIHsKKwkJKm91dF9zaWQgPSBTRUNJ
TklUU0lEX05PREU7CisJCWdvdG8gb3V0OworCX0KIAogCXN3aXRjaCAoZG9tYWluKSB7CiAJY2Fz
ZSBBRl9JTkVUOiB7CiAJCXUzMiBhZGRyOwpAQCAtMTI0Niw5ICsxMjc3LDkgQEAKIAkJfQogCiAJ
CWFkZHIgPSAqKCh1MzIgKilhZGRycCk7CiAKLQkJYyA9IHBvbGljeWRiLm9jb250ZXh0c1tPQ09O
X05PREVdOworCQljID0gcC0+b2NvbnRleHRzW09DT05fTk9ERV07CiAJCXdoaWxlIChjKSB7CiAJ
CQlpZiAoYy0+dS5ub2RlLmFkZHIgPT0gKGFkZHIgJiBjLT51Lm5vZGUubWFzaykpCiAJCQkJYnJl
YWs7CiAJCQljID0gYy0+bmV4dDsKQEAgLTEyNjAsOSArMTI5MSw5IEBACiAJCWlmIChhZGRybGVu
ICE9IHNpemVvZih1NjQpICogMikgewogCQkJcmMgPSAtRUlOVkFMOwogCQkJZ290byBvdXQ7CiAJ
CX0KLQkJYyA9IHBvbGljeWRiLm9jb250ZXh0c1tPQ09OX05PREU2XTsKKwkJYyA9IHAtPm9jb250
ZXh0c1tPQ09OX05PREU2XTsKIAkJd2hpbGUgKGMpIHsKIAkJCWlmIChtYXRjaF9pcHY2X2FkZHJt
YXNrKGFkZHJwLCBjLT51Lm5vZGU2LmFkZHIsCiAJCQkJCQljLT51Lm5vZGU2Lm1hc2spKQogCQkJ
CWJyZWFrOwpAQCAtMTI3Niw5ICsxMzA3LDkgQEAKIAl9CiAKIAlpZiAoYykgewogCQlpZiAoIWMt
PnNpZFswXSkgewotCQkJcmMgPSBzaWR0YWJfY29udGV4dF90b19zaWQoJnNpZHRhYiwKKwkJCXJj
ID0gc2lkdGFiX2NvbnRleHRfdG9fc2lkKHAtPnNpZHRhYiwKIAkJCQkJCSAgICZjLT5jb250ZXh0
WzBdLAogCQkJCQkJICAgJmMtPnNpZFswXSk7CiAJCQlpZiAocmMpCiAJCQkJZ290byBvdXQ7CkBA
IC0xMzEzLDY0ICsxMzQ0LDY2IEBACiAJICAgICAgICAgICAgICAgICAgIGNoYXIgKnVzZXJuYW1l
LAogCQkJICAgdTMyICoqc2lkcywKIAkJCSAgIHUzMiAqbmVsKQogeworCXN0cnVjdCBwb2xpY3lk
YiAqcDsKIAlzdHJ1Y3QgY29udGV4dCAqZnJvbWNvbiwgdXNlcmNvbjsKIAl1MzIgKm15c2lkcywg
Km15c2lkczIsIHNpZDsKIAl1MzIgbXluZWwgPSAwLCBtYXhuZWwgPSBTSURTX05FTDsKIAlzdHJ1
Y3QgdXNlcl9kYXR1bSAqdXNlcjsKIAlzdHJ1Y3Qgcm9sZV9kYXR1bSAqcm9sZTsKIAlzdHJ1Y3Qg
YXZfZGVjaXNpb24gYXZkOwogCWludCByYyA9IDAsIGksIGo7CiAKLQlpZiAoIXNzX2luaXRpYWxp
emVkKSB7CisJUE9MSUNZX1JETE9DSzsKKwlwID0gcG9saWN5ZGI7CisKKwlpZiAoIXApIHsKIAkJ
KnNpZHMgPSBOVUxMOwogCQkqbmVsID0gMDsKIAkJZ290byBvdXQ7CiAJfQogCi0JUE9MSUNZX1JE
TE9DSzsKLQotCWZyb21jb24gPSBzaWR0YWJfc2VhcmNoKCZzaWR0YWIsIGZyb21zaWQpOworCWZy
b21jb24gPSBzaWR0YWJfc2VhcmNoKHAtPnNpZHRhYiwgZnJvbXNpZCk7CiAJaWYgKCFmcm9tY29u
KSB7CiAJCXJjID0gLUVJTlZBTDsKLQkJZ290byBvdXRfdW5sb2NrOworCQlnb3RvIG91dDsKIAl9
CiAKLQl1c2VyID0gaGFzaHRhYl9zZWFyY2gocG9saWN5ZGIucF91c2Vycy50YWJsZSwgdXNlcm5h
bWUpOworCXVzZXIgPSBoYXNodGFiX3NlYXJjaChwLT5wX3VzZXJzLnRhYmxlLCB1c2VybmFtZSk7
CiAJaWYgKCF1c2VyKSB7CiAJCXJjID0gLUVJTlZBTDsKLQkJZ290byBvdXRfdW5sb2NrOworCQln
b3RvIG91dDsKIAl9CiAJdXNlcmNvbi51c2VyID0gdXNlci0+dmFsdWU7CiAKIAlteXNpZHMgPSBr
bWFsbG9jKG1heG5lbCpzaXplb2YoKm15c2lkcyksIEdGUF9BVE9NSUMpOwogCWlmICghbXlzaWRz
KSB7CiAJCXJjID0gLUVOT01FTTsKLQkJZ290byBvdXRfdW5sb2NrOworCQlnb3RvIG91dDsKIAl9
CiAJbWVtc2V0KG15c2lkcywgMCwgbWF4bmVsKnNpemVvZigqbXlzaWRzKSk7CiAKIAlmb3IgKGkg
PSBlYml0bWFwX3N0YXJ0Yml0KCZ1c2VyLT5yb2xlcyk7IGkgPCBlYml0bWFwX2xlbmd0aCgmdXNl
ci0+cm9sZXMpOyBpKyspIHsKIAkJaWYgKCFlYml0bWFwX2dldF9iaXQoJnVzZXItPnJvbGVzLCBp
KSkKIAkJCWNvbnRpbnVlOwotCQlyb2xlID0gcG9saWN5ZGIucm9sZV92YWxfdG9fc3RydWN0W2ld
OworCQlyb2xlID0gcC0+cm9sZV92YWxfdG9fc3RydWN0W2ldOwogCQl1c2VyY29uLnJvbGUgPSBp
KzE7CiAJCWZvciAoaiA9IGViaXRtYXBfc3RhcnRiaXQoJnJvbGUtPnR5cGVzKTsgaiA8IGViaXRt
YXBfbGVuZ3RoKCZyb2xlLT50eXBlcyk7IGorKykgewogCQkJaWYgKCFlYml0bWFwX2dldF9iaXQo
JnJvbGUtPnR5cGVzLCBqKSkKIAkJCQljb250aW51ZTsKIAkJCXVzZXJjb24udHlwZSA9IGorMTsK
IAkJCW1sc19mb3JfdXNlcl9yYW5nZXModXNlcix1c2VyY29uKSB7Ci0JCQkJcmMgPSBjb250ZXh0
X3N0cnVjdF9jb21wdXRlX2F2KGZyb21jb24sICZ1c2VyY29uLAorCQkJCXJjID0gY29udGV4dF9z
dHJ1Y3RfY29tcHV0ZV9hdihwLCBmcm9tY29uLCAmdXNlcmNvbiwKIAkJCQkJCQkgICAgICAgU0VD
Q0xBU1NfUFJPQ0VTUywKIAkJCQkJCQkgICAgICAgUFJPQ0VTU19fVFJBTlNJVElPTiwKIAkJCQkJ
CQkgICAgICAgJmF2ZCk7CiAJCQkJaWYgKHJjIHx8ICAhKGF2ZC5hbGxvd2VkICYgUFJPQ0VTU19f
VFJBTlNJVElPTikpCiAJCQkJCWNvbnRpbnVlOwotCQkJCXJjID0gc2lkdGFiX2NvbnRleHRfdG9f
c2lkKCZzaWR0YWIsICZ1c2VyY29uLCAmc2lkKTsKKwkJCQlyYyA9IHNpZHRhYl9jb250ZXh0X3Rv
X3NpZChwLT5zaWR0YWIsICZ1c2VyY29uLCAmc2lkKTsKIAkJCQlpZiAocmMpIHsKIAkJCQkJa2Zy
ZWUobXlzaWRzKTsKLQkJCQkJZ290byBvdXRfdW5sb2NrOworCQkJCQlnb3RvIG91dDsKIAkJCQl9
CiAJCQkJaWYgKG15bmVsIDwgbWF4bmVsKSB7CiAJCQkJCW15c2lkc1tteW5lbCsrXSA9IHNpZDsK
IAkJCQl9IGVsc2UgewpAQCAtMTM3OCw5ICsxNDExLDkgQEAKIAkJCQkJbXlzaWRzMiA9IGttYWxs
b2MobWF4bmVsKnNpemVvZigqbXlzaWRzMiksIEdGUF9BVE9NSUMpOwogCQkJCQlpZiAoIW15c2lk
czIpIHsKIAkJCQkJCXJjID0gLUVOT01FTTsKIAkJCQkJCWtmcmVlKG15c2lkcyk7Ci0JCQkJCQln
b3RvIG91dF91bmxvY2s7CisJCQkJCQlnb3RvIG91dDsKIAkJCQkJfQogCQkJCQltZW1zZXQobXlz
aWRzMiwgMCwgbWF4bmVsKnNpemVvZigqbXlzaWRzMikpOwogCQkJCQltZW1jcHkobXlzaWRzMiwg
bXlzaWRzLCBteW5lbCAqIHNpemVvZigqbXlzaWRzMikpOwogCQkJCQlrZnJlZShteXNpZHMpOwpA
QCAtMTM5MywxMiArMTQyNiwxMCBAQAogCX0KIAogCSpzaWRzID0gbXlzaWRzOwogCSpuZWwgPSBt
eW5lbDsKLQotb3V0X3VubG9jazoKLQlQT0xJQ1lfUkRVTkxPQ0s7CiBvdXQ6CisJUE9MSUNZX1JE
VU5MT0NLOwogCXJldHVybiByYzsKIH0KIAogLyoqCkBAIC0xNDE3LDE1ICsxNDQ4LDIzIEBACiAJ
CSAgICAgICB1MTYgc2NsYXNzLAogCQkgICAgICAgdTMyICpzaWQpCiB7CiAJaW50IGxlbjsKKwlz
dHJ1Y3QgcG9saWN5ZGIgKnA7CiAJc3RydWN0IGdlbmZzICpnZW5mczsKIAlzdHJ1Y3Qgb2NvbnRl
eHQgKmM7CiAJaW50IHJjID0gMCwgY21wID0gMDsKIAogCVBPTElDWV9SRExPQ0s7CisJcCA9IHBv
bGljeWRiOwogCi0JZm9yIChnZW5mcyA9IHBvbGljeWRiLmdlbmZzOyBnZW5mczsgZ2VuZnMgPSBn
ZW5mcy0+bmV4dCkgeworCWlmICghcCkgeworCQkqc2lkID0gU0VDSU5JVFNJRF9VTkxBQkVMRUQ7
CisJCXJjID0gLUVOT0VOVDsKKwkJZ290byBvdXQ7CisJfQorCisJZm9yIChnZW5mcyA9IHAtPmdl
bmZzOyBnZW5mczsgZ2VuZnMgPSBnZW5mcy0+bmV4dCkgewogCQljbXAgPSBzdHJjbXAoZnN0eXBl
LCBnZW5mcy0+ZnN0eXBlKTsKIAkJaWYgKGNtcCA8PSAwKQogCQkJYnJlYWs7CiAJfQpAQCAtMTQ0
OSw5ICsxNDg4LDkgQEAKIAkJZ290byBvdXQ7CiAJfQogCiAJaWYgKCFjLT5zaWRbMF0pIHsKLQkJ
cmMgPSBzaWR0YWJfY29udGV4dF90b19zaWQoJnNpZHRhYiwKKwkJcmMgPSBzaWR0YWJfY29udGV4
dF90b19zaWQocC0+c2lkdGFiLAogCQkJCQkgICAmYy0+Y29udGV4dFswXSwKIAkJCQkJICAgJmMt
PnNpZFswXSk7CiAJCWlmIChyYykKIAkJCWdvdG8gb3V0OwpAQCAtMTQ3NCwxMyArMTUxMywyMSBA
QAogCXVuc2lnbmVkIGludCAqYmVoYXZpb3IsCiAJdTMyICpzaWQpCiB7CiAJaW50IHJjID0gMDsK
KwlzdHJ1Y3QgcG9saWN5ZGIgKnA7CiAJc3RydWN0IG9jb250ZXh0ICpjOwogCiAJUE9MSUNZX1JE
TE9DSzsKKwlwID0gcG9saWN5ZGI7CisKKwlpZiAoIXApIHsKKwkJKnNpZCA9IFNFQ0lOSVRTSURf
VU5MQUJFTEVEOworCQkqYmVoYXZpb3IgPSBTRUNVUklUWV9GU19VU0VfTk9ORTsKKwkJZ290byBv
dXQ7CisJfQogCi0JYyA9IHBvbGljeWRiLm9jb250ZXh0c1tPQ09OX0ZTVVNFXTsKKwljID0gcC0+
b2NvbnRleHRzW09DT05fRlNVU0VdOwogCXdoaWxlIChjKSB7CiAJCWlmIChzdHJjbXAoZnN0eXBl
LCBjLT51Lm5hbWUpID09IDApCiAJCQlicmVhazsKIAkJYyA9IGMtPm5leHQ7CkBAIC0xNDg4LDkg
KzE1MzUsOSBAQAogCiAJaWYgKGMpIHsKIAkJKmJlaGF2aW9yID0gYy0+di5iZWhhdmlvcjsKIAkJ
aWYgKCFjLT5zaWRbMF0pIHsKLQkJCXJjID0gc2lkdGFiX2NvbnRleHRfdG9fc2lkKCZzaWR0YWIs
CisJCQlyYyA9IHNpZHRhYl9jb250ZXh0X3RvX3NpZChwLT5zaWR0YWIsCiAJCQkJCQkgICAmYy0+
Y29udGV4dFswXSwKIAkJCQkJCSAgICZjLT5zaWRbMF0pOwogCQkJaWYgKHJjKQogCQkJCWdvdG8g
b3V0OwpAQCAtMTUxMywxNCArMTU2MCwyNSBAQAogCiBpbnQgc2VjdXJpdHlfZ2V0X2Jvb2xzKGlu
dCAqbGVuLCBjaGFyICoqKm5hbWVzLCBpbnQgKip2YWx1ZXMpCiB7CiAJaW50IGksIHJjID0gLUVO
T01FTTsKKwlzdHJ1Y3QgcG9saWN5ZGIgKnA7CiAKIAlQT0xJQ1lfUkRMT0NLOworCXAgPSBwb2xp
Y3lkYjsKKwlpZiAoIXApIHsKKwkJKmxlbiA9IDA7CisJCSpuYW1lcyA9IE5VTEw7CisJCSp2YWx1
ZXMgPSBOVUxMOworCQlyYyA9IDA7CisJCWdvdG8gb3V0OworCX0KKworCiAJKm5hbWVzID0gTlVM
TDsKIAkqdmFsdWVzID0gTlVMTDsKIAotCSpsZW4gPSBwb2xpY3lkYi5wX2Jvb2xzLm5wcmltOwor
CSpsZW4gPSBwLT5wX2Jvb2xzLm5wcmltOwogCWlmICghKmxlbikgewogCQlyYyA9IDA7CiAJCWdv
dG8gb3V0OwogCX0KQEAgLTE1MzUsMTQgKzE1OTMsMTQgQEAKIAkJZ290byBlcnI7CiAKIAlmb3Ig
KGkgPSAwOyBpIDwgKmxlbjsgaSsrKSB7CiAJCXNpemVfdCBuYW1lX2xlbjsKLQkJKCp2YWx1ZXMp
W2ldID0gcG9saWN5ZGIuYm9vbF92YWxfdG9fc3RydWN0W2ldLT5zdGF0ZTsKLQkJbmFtZV9sZW4g
PSBzdHJsZW4ocG9saWN5ZGIucF9ib29sX3ZhbF90b19uYW1lW2ldKSArIDE7CisJCSgqdmFsdWVz
KVtpXSA9IHAtPmJvb2xfdmFsX3RvX3N0cnVjdFtpXS0+c3RhdGU7CisJCW5hbWVfbGVuID0gc3Ry
bGVuKHAtPnBfYm9vbF92YWxfdG9fbmFtZVtpXSkgKyAxOwogCQkoKm5hbWVzKVtpXSA9IChjaGFy
KilrbWFsbG9jKHNpemVvZihjaGFyKSAqIG5hbWVfbGVuLCBHRlBfQVRPTUlDKTsKIAkJaWYgKCEo
Km5hbWVzKVtpXSkKIAkJCWdvdG8gZXJyOwotCQlzdHJuY3B5KCgqbmFtZXMpW2ldLCBwb2xpY3lk
Yi5wX2Jvb2xfdmFsX3RvX25hbWVbaV0sIG5hbWVfbGVuKTsKKwkJc3RybmNweSgoKm5hbWVzKVtp
XSwgcC0+cF9ib29sX3ZhbF90b19uYW1lW2ldLCBuYW1lX2xlbik7CiAJCSgqbmFtZXMpW2ldW25h
bWVfbGVuIC0gMV0gPSAwOwogCX0KIAlyYyA9IDA7CiBvdXQ6CkBAIC0xNTYzLDQyICsxNjIxLDUz
IEBACiBpbnQgc2VjdXJpdHlfc2V0X2Jvb2xzKGludCBsZW4sIGludCAqdmFsdWVzKQogewogCWlu
dCBpLCByYyA9IDA7CiAJaW50IGxlbnAsIHNlcW5vID0gMDsKKwlzdHJ1Y3QgcG9saWN5ZGIgKm5l
d2RiLCAqb2xkZGI7CiAJc3RydWN0IGNvbmRfbm9kZSAqY3VyOwogCi0JUE9MSUNZX1dSTE9DSzsK
KwlMT0FEX0xPQ0s7CisJb2xkZGIgPSBwb2xpY3lkYjsKIAotCWxlbnAgPSBwb2xpY3lkYi5wX2Jv
b2xzLm5wcmltOworCWxlbnAgPSBvbGRkYi0+cF9ib29scy5ucHJpbTsKIAlpZiAobGVuICE9IGxl
bnApIHsKIAkJcmMgPSAtRUZBVUxUOwogCQlnb3RvIG91dDsKIAl9CisJbmV3ZGIgPSBjb25kX3Bv
bGljeWRiX2R1cChvbGRkYik7CisJaWYgKCFuZXdkYikgeworCQlyYyA9IC1FTk9NRU07CisJCWdv
dG8gb3V0OworCX0KIAogCXByaW50ayhLRVJOX0lORk8gInNlY3VyaXR5OiBjb21taXR0ZWQgYm9v
bGVhbnMgeyAiKTsKIAlmb3IgKGkgPSAwOyBpIDwgbGVuOyBpKyspIHsKIAkJaWYgKHZhbHVlc1tp
XSkgewotCQkJcG9saWN5ZGIuYm9vbF92YWxfdG9fc3RydWN0W2ldLT5zdGF0ZSA9IDE7CisJCQlu
ZXdkYi0+Ym9vbF92YWxfdG9fc3RydWN0W2ldLT5zdGF0ZSA9IDE7CiAJCX0gZWxzZSB7Ci0JCQlw
b2xpY3lkYi5ib29sX3ZhbF90b19zdHJ1Y3RbaV0tPnN0YXRlID0gMDsKKwkJCW5ld2RiLT5ib29s
X3ZhbF90b19zdHJ1Y3RbaV0tPnN0YXRlID0gMDsKIAkJfQogCQlpZiAoaSAhPSAwKQogCQkJcHJp
bnRrKCIsICIpOwotCQlwcmludGsoIiVzOiVkIiwgcG9saWN5ZGIucF9ib29sX3ZhbF90b19uYW1l
W2ldLAotCQkgICAgICAgcG9saWN5ZGIuYm9vbF92YWxfdG9fc3RydWN0W2ldLT5zdGF0ZSk7CisJ
CXByaW50aygiJXM6JWQiLCBuZXdkYi0+cF9ib29sX3ZhbF90b19uYW1lW2ldLAorCQkgICAgICAg
bmV3ZGItPmJvb2xfdmFsX3RvX3N0cnVjdFtpXS0+c3RhdGUpOwogCX0KIAlwcmludGsoIiB9XG4i
KTsKIAotCWZvciAoY3VyID0gcG9saWN5ZGIuY29uZF9saXN0OyBjdXIgIT0gTlVMTDsgY3VyID0g
Y3VyLT5uZXh0KSB7Ci0JCXJjID0gZXZhbHVhdGVfY29uZF9ub2RlKCZwb2xpY3lkYiwgY3VyKTsK
LQkJaWYgKHJjKQorCWZvciAoY3VyID0gbmV3ZGItPmNvbmRfbGlzdDsgY3VyICE9IE5VTEw7IGN1
ciA9IGN1ci0+bmV4dCkgeworCQlyYyA9IGV2YWx1YXRlX2NvbmRfbm9kZShuZXdkYiwgY3VyKTsK
KwkJaWYgKHJjKSB7CisJCQljYWxsX3JjdSgmbmV3ZGItPnJoZWFkLCBjb25kX3BvbGljeWRiX2Zy
ZWVfcmN1KTsKIAkJCWdvdG8gb3V0OworCQl9CiAJfQotCisJc21wX3dtYigpOworCXBvbGljeWRi
ID0gbmV3ZGI7CiAJc2Vxbm8gPSArK2xhdGVzdF9ncmFudGluZzsKIAorCWNhbGxfcmN1KCZvbGRk
Yi0+cmhlYWQsIGNvbmRfcG9saWN5ZGJfZnJlZV9yY3UpOwogb3V0OgotCVBPTElDWV9XUlVOTE9D
SzsKKwlMT0FEX1VOTE9DSzsKIAlpZiAoIXJjKSB7CiAJCWF2Y19zc19yZXNldChzZXFubyk7CiAJ
CXNlbG5sX25vdGlmeV9wb2xpY3lsb2FkKHNlcW5vKTsKIAl9CkBAIC0xNjA4LDE4ICsxNjc3LDI1
IEBACiBpbnQgc2VjdXJpdHlfZ2V0X2Jvb2xfdmFsdWUoaW50IGJvb2wpCiB7CiAJaW50IHJjID0g
MDsKIAlpbnQgbGVuOworCXN0cnVjdCBwb2xpY3lkYiAqcDsKIAogCVBPTElDWV9SRExPQ0s7CisJ
cCA9IHBvbGljeWRiOworCWlmICghcCkgeworCQlyYyA9IC1FRkFVTFQ7CisJCWdvdG8gb3V0Owor
CX0KKwogCi0JbGVuID0gcG9saWN5ZGIucF9ib29scy5ucHJpbTsKKwlsZW4gPSBwLT5wX2Jvb2xz
Lm5wcmltOwogCWlmIChib29sID49IGxlbikgewogCQlyYyA9IC1FRkFVTFQ7CiAJCWdvdG8gb3V0
OwogCX0KIAotCXJjID0gcG9saWN5ZGIuYm9vbF92YWxfdG9fc3RydWN0W2Jvb2xdLT5zdGF0ZTsK
KwlyYyA9IHAtPmJvb2xfdmFsX3RvX3N0cnVjdFtib29sXS0+c3RhdGU7CiBvdXQ6CiAJUE9MSUNZ
X1JEVU5MT0NLOwogCXJldHVybiByYzsKIH0KZGlmZiAtck5VNCBsaW51eC0yLjYuOS5zZWxpbnV4
L3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMuaCBsaW51eC0yLjYuOS5zZWxpbnV4LXBvbGlj
eWRiL3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMuaAotLS0gbGludXgtMi42Ljkuc2VsaW51
eC9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmgJMjAwNC0xMS0wOSAxOToyNzowNy4wMDAw
MDAwMDAgKzA5MDAKKysrIGxpbnV4LTIuNi45LnNlbGludXgtcG9saWN5ZGIvc2VjdXJpdHkvc2Vs
aW51eC9zcy9zZXJ2aWNlcy5oCTIwMDQtMTEtMDkgMTk6Mjc6MDUuMDAwMDAwMDAwICswOTAwCkBA
IC0xMyw5ICsxMyw5IEBACiAgKiBUaGUgc2VjdXJpdHkgc2VydmVyIHVzZXMgdHdvIGdsb2JhbCBk
YXRhIHN0cnVjdHVyZXMKICAqIHdoZW4gcHJvdmlkaW5nIGl0cyBzZXJ2aWNlczogIHRoZSBTSUQg
dGFibGUgKHNpZHRhYikKICAqIGFuZCB0aGUgcG9saWN5IGRhdGFiYXNlIChwb2xpY3lkYikuCiAg
Ki8KLWV4dGVybiBzdHJ1Y3Qgc2lkdGFiIHNpZHRhYjsKLWV4dGVybiBzdHJ1Y3QgcG9saWN5ZGIg
cG9saWN5ZGI7CisvL2V4dGVybiBzdHJ1Y3Qgc2lkdGFiIHNpZHRhYjsKK2V4dGVybiBzdHJ1Y3Qg
cG9saWN5ZGIgKnBvbGljeWRiOwogCiAjZW5kaWYJLyogX1NTX1NFUlZJQ0VTX0hfICovCiAK


--=-GfOUtvhMJ+/VALkJxb3Z--
