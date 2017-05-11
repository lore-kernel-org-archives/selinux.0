Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4BKjiiv024028
 for <selinux@tycho.nsa.gov>; Thu, 11 May 2017 16:45:44 -0400
Subject: Re: [PATCH v3 1/2] selinux: add brief info to policydb
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
References: <1494507551-4643-1-git-send-email-sbuisson@ddn.com>
 <2161c45f-dd29-8269-2bb1-5d5afa78104b@schaufler-ca.com>
 <1494534152.10447.11.camel@tycho.nsa.gov>
Cc: Sebastien Buisson <sbuisson@ddn.com>, james.l.morris@oracle.com
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5d7a2409-db08-b142-c71b-a7a38ecc175d@schaufler-ca.com>
Date: Thu, 11 May 2017 13:45:39 -0700
MIME-Version: 1.0
In-Reply-To: <1494534152.10447.11.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/11/2017 1:22 PM, Stephen Smalley wrote:
> On Thu, 2017-05-11 at 08:56 -0700, Casey Schaufler wrote:
>> On 5/11/2017 5:59 AM, Sebastien Buisson wrote:
>>> Add policybrief field to struct policydb. It holds a brief info
>>> of the policydb, in the following form:
>>> <0 or 1 for enforce>:<0 or 1 for checkreqprot>:<hashalg>=<checksum>
>>> Policy brief is computed every time the policy is loaded, and when
>>> enforce or checkreqprot are changed.
>>>
>>> Add security_policy_brief hook to give access to policy brief to
>>> the rest of the kernel. Lustre client makes use of this information
>>> to detect changes to the policy, and forward it to Lustre servers.
>>> Depending on how the policy is enforced on Lustre client side,
>>> Lustre servers can refuse connection.
>>>
>>> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
>>> ---
>>>  include/linux/lsm_hooks.h           | 16 ++++++++
>>>  include/linux/security.h            |  7 ++++
>>>  security/security.c                 |  6 +++
>>>  security/selinux/hooks.c            |  7 ++++
>>>  security/selinux/include/security.h |  2 +
>>>  security/selinux/selinuxfs.c        |  2 +
>>>  security/selinux/ss/policydb.c      | 76
>>> +++++++++++++++++++++++++++++++++++++
>>>  security/selinux/ss/policydb.h      |  2 +
>>>  security/selinux/ss/services.c      | 62
>>> ++++++++++++++++++++++++++++++
>>>  9 files changed, 180 insertions(+)
>>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index 080f34e..9cac282 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -1336,6 +1336,20 @@
>>>   *	@inode we wish to get the security context of.
>>>   *	@ctx is a pointer in which to place the allocated
>>> security context.
>>>   *	@ctxlen points to the place to put the length of @ctx.
>>> + *
>>> + * Security hooks for policy brief
>>> + *
>>> + * @policy_brief:
>>> + *
>>> + *	Returns a string containing a brief info of the
>>> policydb, in the
>>> + *	following form:
>>> + *	<0 or 1 for enforce>:<0 or 1 for
>>> checkreqprot>:<hashalg>=<checksum>
>> This sure looks like SELinux specific information. If the Spiffy
>> security module has multiple values for enforcement (e.g. off,
>> soft and hard) this interface definition does not work. What is a
>> "checkreqprot", and what is it for?
>>
>> I expect that you have no interest (or incentive) in supporting
>> security modules other than SELinux, and that's OK. What's I'm
>> after is an interface that another security module could use if
>> someone where interested (or inspired) to do so.
>>
>> Rather than a string with predefined positional values (something
>> I was taught not to do when 1 MIPS and 1 MEG was a big computer)
>> you might use
>> "enforce=<value>:checkreqprot=<value>:hashalg=<checksum>"
> No objection to the above, although it makes his updating code for
> enforce/checkreqprot a bit uglier.

Sure, but can you imagine trying to use find(1) if the
options where positional?
 

>> for SELinux and define @policy_brief as
>>
>> 	A string containing colon separated name and value pairs
>> 	that will be parsed and interpreted by the security module
>> 	or modules.
> Actually, I'm not clear it will be parsed or interpreted by the
> security module(s).  I think he is just fetching it and then doing a
> simple comparison to check for inconsistencies between clients and the
> server, and optionally admins/users can read it and interpret it as
> they see fit.

OK, in which case human eyes *need* the name as well as the value.
That, and strcmp(value, "enforce=0") is no harder than strcmp(value, "0").

>> You already have it right for the "hashalg" field. If you want to
>> be really forward looking you could use names field names that
>> identify the security module that uses them, such as
>>
>> 	"selinux/enforce=1:selinux/checkreqprot=0:selinux/MD5=8675309"
> That seems a bit verbose, particularly the duplicated selinux/ bit.

True that, on the other hand

	"selinux(enforce=1:checkreqprot=0:MD5=8675309)"

would be harder to parse. Either works for me.

>> Note that I put "selinux/" onto the MD5 as well. You may have
>> multiple modules that use this interface on a system at the same
>> time in the not to distant future:
>>
>> 	selinux/enforce=1:selinux/checkreqprot=0:
>> 	selinux/MD5=8675309:spiffy/enforce=soft:
>> 	spiffy/updatefreq=32544:spiffy/SHA256=84521
>>
>> If you deal with this now it won't be a major headache to deal with
>> later.
>>
>>> + *
>>> + *	@brief: pointer to buffer holding brief
>>> + *	@len: in: brief buffer length if no alloc, out: brief
>>> string len
>>> + *	@alloc: whether to allocate buffer for brief or not
>>> + *	On success 0 is returned , or negative value on error.
>>> + *
>>>   * This is the main security structure.
>>>   */
>>>  
>>> @@ -1568,6 +1582,7 @@
>>>  	int (*inode_setsecctx)(struct dentry *dentry, void *ctx,
>>> u32 ctxlen);
>>>  	int (*inode_getsecctx)(struct inode *inode, void **ctx,
>>> u32 *ctxlen);
>>>  
>>> +	int (*policy_brief)(char **brief, size_t *len, bool
>>> alloc);
>>>  #ifdef CONFIG_SECURITY_NETWORK
>>>  	int (*unix_stream_connect)(struct sock *sock, struct sock
>>> *other,
>>>  					struct sock *newsk);
>>> @@ -1813,6 +1828,7 @@ struct security_hook_heads {
>>>  	struct list_head inode_notifysecctx;
>>>  	struct list_head inode_setsecctx;
>>>  	struct list_head inode_getsecctx;
>>> +	struct list_head policy_brief;
>>>  #ifdef CONFIG_SECURITY_NETWORK
>>>  	struct list_head unix_stream_connect;
>>>  	struct list_head unix_may_send;
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index af675b5..3b72053 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -377,6 +377,8 @@ int security_sem_semop(struct sem_array *sma,
>>> struct sembuf *sops,
>>>  int security_inode_notifysecctx(struct inode *inode, void *ctx,
>>> u32 ctxlen);
>>>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32
>>> ctxlen);
>>>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32
>>> *ctxlen);
>>> +
>>> +int security_policy_brief(char **brief, size_t *len, bool alloc);
>>>  #else /* CONFIG_SECURITY */
>>>  struct security_mnt_opts {
>>>  };
>>> @@ -1166,6 +1168,11 @@ static inline int
>>> security_inode_getsecctx(struct inode *inode, void **ctx, u32
>>>  {
>>>  	return -EOPNOTSUPP;
>>>  }
>>> +
>>> +static inline int security_policy_brief(char **brief, size_t *len,
>>> bool alloc)
>>> +{
>>> +	return -EOPNOTSUPP;
>>> +}
>>>  #endif	/* CONFIG_SECURITY */
>>>  
>>>  #ifdef CONFIG_SECURITY_NETWORK
>>> diff --git a/security/security.c b/security/security.c
>>> index b9fea39..954b391 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -1285,6 +1285,12 @@ int security_inode_getsecctx(struct inode
>>> *inode, void **ctx, u32 *ctxlen)
>>>  }
>>>  EXPORT_SYMBOL(security_inode_getsecctx);
>>>  
>>> +int security_policy_brief(char **brief, size_t *len, bool alloc)
>>> +{
>>> +	return call_int_hook(policy_brief, -EOPNOTSUPP, brief,
>>> len, alloc);
>>> +}
>>> +EXPORT_SYMBOL(security_policy_brief);
>>> +
>>>  #ifdef CONFIG_SECURITY_NETWORK
>>>  
>>>  int security_unix_stream_connect(struct sock *sock, struct sock
>>> *other, struct sock *newsk)
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index e67a526..da245e8 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -6063,6 +6063,11 @@ static int selinux_inode_getsecctx(struct
>>> inode *inode, void **ctx, u32 *ctxlen)
>>>  	*ctxlen = len;
>>>  	return 0;
>>>  }
>>> +
>>> +static int selinux_policy_brief(char **brief, size_t *len, bool
>>> alloc)
>>> +{
>>> +	return security_policydb_brief(brief, len, alloc);
>>> +}
>>>  #ifdef CONFIG_KEYS
>>>  
>>>  static int selinux_key_alloc(struct key *k, const struct cred
>>> *cred,
>>> @@ -6277,6 +6282,8 @@ static int selinux_key_getsecurity(struct key
>>> *key, char **_buffer)
>>>  	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
>>>  	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
>>>  
>>> +	LSM_HOOK_INIT(policy_brief, selinux_policy_brief),
>>> +
>>>  	LSM_HOOK_INIT(unix_stream_connect,
>>> selinux_socket_unix_stream_connect),
>>>  	LSM_HOOK_INIT(unix_may_send,
>>> selinux_socket_unix_may_send),
>>>  
>>> diff --git a/security/selinux/include/security.h
>>> b/security/selinux/include/security.h
>>> index f979c35..a0d4d7d 100644
>>> --- a/security/selinux/include/security.h
>>> +++ b/security/selinux/include/security.h
>>> @@ -97,6 +97,8 @@ enum {
>>>  int security_load_policy(void *data, size_t len);
>>>  int security_read_policy(void **data, size_t *len);
>>>  size_t security_policydb_len(void);
>>> +int security_policydb_brief(char **brief, size_t *len, bool
>>> alloc);
>>> +void security_policydb_update_info(u32 requested);
>>>  
>>>  int security_policycap_supported(unsigned int req_cap);
>>>  
>>> diff --git a/security/selinux/selinuxfs.c
>>> b/security/selinux/selinuxfs.c
>>> index 50062e7..8c9f5b7 100644
>>> --- a/security/selinux/selinuxfs.c
>>> +++ b/security/selinux/selinuxfs.c
>>> @@ -159,6 +159,7 @@ static ssize_t sel_write_enforce(struct file
>>> *file, const char __user *buf,
>>>  			from_kuid(&init_user_ns,
>>> audit_get_loginuid(current)),
>>>  			audit_get_sessionid(current));
>>>  		selinux_enforcing = new_value;
>>> +		security_policydb_update_info(SECURITY__SETENFORCE
>>> );
>>>  		if (selinux_enforcing)
>>>  			avc_ss_reset(0);
>>>  		selnl_notify_setenforce(selinux_enforcing);
>>> @@ -621,6 +622,7 @@ static ssize_t sel_write_checkreqprot(struct
>>> file *file, const char __user *buf,
>>>  		goto out;
>>>  
>>>  	selinux_checkreqprot = new_value ? 1 : 0;
>>> +	security_policydb_update_info(SECURITY__SETCHECKREQPROT);
>>>  	length = count;
>>>  out:
>>>  	kfree(page);
>>> diff --git a/security/selinux/ss/policydb.c
>>> b/security/selinux/ss/policydb.c
>>> index 0080122..58e73f5 100644
>>> --- a/security/selinux/ss/policydb.c
>>> +++ b/security/selinux/ss/policydb.c
>>> @@ -32,11 +32,13 @@
>>>  #include <linux/errno.h>
>>>  #include <linux/audit.h>
>>>  #include <linux/flex_array.h>
>>> +#include <crypto/hash.h>
>>>  #include "security.h"
>>>  
>>>  #include "policydb.h"
>>>  #include "conditional.h"
>>>  #include "mls.h"
>>> +#include "objsec.h"
>>>  #include "services.h"
>>>  
>>>  #define _DEBUG_HASHES
>>> @@ -879,6 +881,8 @@ void policydb_destroy(struct policydb *p)
>>>  	ebitmap_destroy(&p->filename_trans_ttypes);
>>>  	ebitmap_destroy(&p->policycaps);
>>>  	ebitmap_destroy(&p->permissive_map);
>>> +
>>> +	kfree(p->policybrief);
>>>  }
>>>  
>>>  /*
>>> @@ -2220,6 +2224,73 @@ static int ocontext_read(struct policydb *p,
>>> struct policydb_compat_info *info,
>>>  }
>>>  
>>>  /*
>>> + * Compute summary of a policy database binary representation
>>> file,
>>> + * and store it into a policy database structure.
>>> + */
>>> +static int policydb_brief(struct policydb *policydb, void *ptr)
>>> +{
>>> +	struct policy_file *fp = ptr;
>>> +	struct crypto_shash *tfm;
>>> +	char hashalg[] = "sha256";
>>> +	size_t hashsize;
>>> +	u8 *hashval;
>>> +	int idx;
>>> +	unsigned char *p;
>>> +
>>> +	if (policydb->policybrief)
>>> +		return -EINVAL;
>>> +
>>> +	tfm = crypto_alloc_shash(hashalg, 0, 0);
>>> +	if (IS_ERR(tfm)) {
>>> +		printk(KERN_ERR "Failed to alloc crypto hash
>>> %s\n", hashalg);
>>> +		return PTR_ERR(tfm);
>>> +	}
>>> +
>>> +	hashsize = crypto_shash_digestsize(tfm);
>>> +	hashval = kmalloc(hashsize, GFP_KERNEL);
>>> +	if (hashval == NULL) {
>>> +		crypto_free_shash(tfm);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	{
>>> +		int rc;
>>> +
>>> +		SHASH_DESC_ON_STACK(desc, tfm);
>>> +		desc->tfm = tfm;
>>> +		desc->flags = 0;
>>> +		rc = crypto_shash_digest(desc, fp->data, fp->len,
>>> hashval);
>>> +		crypto_free_shash(tfm);
>>> +		if (rc) {
>>> +			printk(KERN_ERR "Failed
>>> crypto_shash_digest: %d\n", rc);
>>> +			kfree(hashval);
>>> +			return rc;
>>> +		}
>>> +	}
>>> +
>>> +	/* policy brief is in the form:
>>> +	 * <0 or 1 for enforce>:<0 or 1 for
>>> checkreqprot>:<hashalg>=<checksum>
>>> +	 */
>>> +	policydb->policybrief = kzalloc(5 + strlen(hashalg) +
>>> 2*hashsize + 1,
>>> +					GFP_KERNEL);
>>> +	if (policydb->policybrief == NULL) {
>>> +		kfree(hashval);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	sprintf(policydb->policybrief, "%d:%d:%s=",
>>> +		selinux_enforcing, selinux_checkreqprot, hashalg);
>>> +	p = policydb->policybrief + strlen(policydb->policybrief);
>>> +	for (idx = 0; idx < hashsize; idx++) {
>>> +		snprintf(p, 3, "%02x", hashval[idx]);
>>> +		p += 2;
>>> +	}
>>> +	kfree(hashval);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>>   * Read the configuration data from a policy database binary
>>>   * representation file into a policy database structure.
>>>   */
>>> @@ -2238,6 +2309,11 @@ int policydb_read(struct policydb *p, void
>>> *fp)
>>>  	if (rc)
>>>  		return rc;
>>>  
>>> +	/* Compute summary of policy, and store it in policydb */
>>> +	rc = policydb_brief(p, fp);
>>> +	if (rc)
>>> +		goto bad;
>>> +
>>>  	/* Read the magic number and string length. */
>>>  	rc = next_entry(buf, fp, sizeof(u32) * 2);
>>>  	if (rc)
>>> diff --git a/security/selinux/ss/policydb.h
>>> b/security/selinux/ss/policydb.h
>>> index 725d594..31689d2f 100644
>>> --- a/security/selinux/ss/policydb.h
>>> +++ b/security/selinux/ss/policydb.h
>>> @@ -293,6 +293,8 @@ struct policydb {
>>>  	size_t len;
>>>  
>>>  	unsigned int policyvers;
>>> +	/* summary computed on the policy */
>>> +	unsigned char *policybrief;
>>>  
>>>  	unsigned int reject_unknown : 1;
>>>  	unsigned int allow_unknown : 1;
>>> diff --git a/security/selinux/ss/services.c
>>> b/security/selinux/ss/services.c
>>> index 60d9b02..3bbe649 100644
>>> --- a/security/selinux/ss/services.c
>>> +++ b/security/selinux/ss/services.c
>>> @@ -2170,6 +2170,68 @@ size_t security_policydb_len(void)
>>>  }
>>>  
>>>  /**
>>> + * security_policydb_brief - Get policydb brief
>>> + * @brief: pointer to buffer holding brief
>>> + * @len: in: brief buffer length if no alloc, out: brief string
>>> len
>>> + * @alloc: whether to allocate buffer for brief or not
>>> + *
>>> + * On success 0 is returned , or negative value on error.
>>> + **/
>>> +int security_policydb_brief(char **brief, size_t *len, bool alloc)
>>> +{
>>> +	size_t policybrief_len;
>>> +
>>> +	if (!ss_initialized || brief == NULL)
>>> +		return -EINVAL;
>>> +
>>> +	read_lock(&policy_rwlock);
>>> +	policybrief_len = strlen(policydb.policybrief);
>>> +	read_unlock(&policy_rwlock);
>>> +
>>> +	if (alloc)
>>> +		/* *brief must be kfreed by caller in this case */
>>> +		*brief = kzalloc(policybrief_len + 1, GFP_KERNEL);
>>> +	else
>>> +		/*
>>> +		 * if !alloc, caller must pass a buffer that
>>> +		 * can hold policybrief_len+1 chars
>>> +		 */
>>> +		if (*len < policybrief_len + 1) {
>>> +			/* put in *len the string size we need to
>>> write */
>>> +			*len = policybrief_len;
>>> +			return -ENAMETOOLONG;
>>> +		}
>>> +
>>> +	if (*brief == NULL)
>>> +		return -ENOMEM;
>>> +
>>> +	read_lock(&policy_rwlock);
>>> +	*len = strlen(policydb.policybrief);
>>> +	strncpy(*brief, policydb.policybrief, *len);
>>> +	read_unlock(&policy_rwlock);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +void security_policydb_update_info(u32 requested)
>>> +{
>>> +	/* policy brief is in the form:
>>> +	 * <0 or 1 for enforce>:<0 or 1 for
>>> checkreqprot>:<hashalg>=<checksum>
>>> +	 */
>>> +
>>> +	if (!ss_initialized)
>>> +		return;
>>> +
>>> +	/* update global policydb, needs write lock */
>>> +	write_lock_irq(&policy_rwlock);
>>> +	if (requested == SECURITY__SETENFORCE)
>>> +		policydb.policybrief[0] = '0' + selinux_enforcing;
>>> +	else if (requested == SECURITY__SETCHECKREQPROT)
>>> +		policydb.policybrief[2] = '0' +
>>> selinux_checkreqprot;
>>> +	write_unlock_irq(&policy_rwlock);
>>> +}
>>> +
>>> +/**
>>>   * security_port_sid - Obtain the SID for a port.
>>>   * @protocol: protocol number
>>>   * @port: port number
