Return-Path: <SRS0=kJrL=Y5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89FC5DF60
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0D6217F5
	for <selinux@archiver.kernel.org>; Tue,  5 Nov 2019 17:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TC6vYTrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbfKERxI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:53:08 -0500
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:49400 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbfKERxI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Nov 2019 12:53:08 -0500
X-EEMSG-check-017: 45896544|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,271,1569283200"; 
   d="scan'208";a="45896544"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Nov 2019 17:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572976386; x=1604512386;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=bFhLapA4q0QZChZP7k2KLfOakzJXvUCpp0vkIPKvwE4=;
  b=TC6vYTrdlxF1/35zKXUK+YbH2HssjuogxVijaLdf91g3jVktFSpCECdy
   imM4eDRp4TtmWRtKa8lVqclFRqbkllJM/nK4O4NkAWgHxOV++mgvbZhOZ
   uXgIX3F0IxumiLbw9PW85L96JLv9pKLOouj82GssCM+BjOJ+pg7aNtEbL
   5B5eY7x7aYaN01ONMXYlqp6PQ7kGp42XQqmQFkZ4dg2xsHwGl6R26DcYE
   6MN7la/Qi5vSAM6ofiPgMPcPVmSa/0zU/k+3baTTMnTa49Yjz+Yb5RTwM
   sBgPE0BYf68CLd0/N9othF8x+84zHgonHN+L7KpIjsAEXzsKeSbQnq4zf
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,271,1569283200"; 
   d="scan'208";a="35140251"
IronPort-PHdr: =?us-ascii?q?9a23=3ACubRLRZRW8H0n4R9wszv1BX/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsy+YR7h7PlgxGXEQZ/co6odzbaP6Oa5ADFLuM7c+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8UanItvJqksxh?=
 =?us-ascii?q?fVonZDZvhby35vKV+PhRj3+92+/IRk8yReuvIh89BPXKDndKkmTrJWESorPX?=
 =?us-ascii?q?kt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RC?=
 =?us-ascii?q?ii4qJ2QxLmlCsLKzg0+3zMh8dukKxUvg6upx1nw47Vfo6VMuZ+frjAdt8eXG?=
 =?us-ascii?q?ZNQ9pdWzBEDo66YYQPFe4BNvtGoYf7qVUFsB+yCRCsCe7rzzNFgGL9068n3O?=
 =?us-ascii?q?Q7CQzIwRIuH9wOvnrXotv6OqgdXuKpw6fH1jjDc/Fb1C3h5ITUfB0so/eBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgEiMqYP7JzOV1voCs26G5OR9UOKgkWonqwVvrTmv28whjZ?=
 =?us-ascii?q?LJiZ8Oyl3f6SV4wJo6Jd2/SEJhZ96kC4FfuzuVN4txXMMvWmdlszs5xL0eoZ?=
 =?us-ascii?q?O3YScHxZs9yxPfdvCLaZaE7x39WOqLPDt1gm9udqiliBao60egz/XxVsyz0F?=
 =?us-ascii?q?lXsCVIisLMtnUR1xzL7ciHV+d98l+h2TmR0wDT7flJIVwumqrBKp4h36Uwmo?=
 =?us-ascii?q?APsUXDAiD2mEL2gLWQdko44ein9/7rYrDnpp+YL4N0iwf+PboymsGnHOg1PQ?=
 =?us-ascii?q?cDU3Kb9OihzrHv40L0TKtQgvEriqXZtYrVJcUfpq63GQ9V1YMj5g6kDzi7y9?=
 =?us-ascii?q?QVhmUHLVJZdxKHiIjlIVfOIOviAvuljFSslylry+jcPrL9GpXNMmTDkLD5cL?=
 =?us-ascii?q?Z/9UFcxgQzzc5E6pJbDbEBJ/3zWkvvu9DCEhA5NAm0yf79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPaPJr1CI4uMvI++RZI4aozv9Nfcl6OD0jXMjml8SY7Op3Z0JZ3C8BPhmJF?=
 =?us-ascii?q?+ZYXX0iNcbDWgKphY+TPDtiFCaST5cfWuyX6Yn6zEjEo2mEIPDSpmogLyG2y?=
 =?us-ascii?q?e7BINZanpaBVCLFHfib5+EVOsUaCKOPs9hlSQJVb+kS48mzhGushX1xKZ5Ie?=
 =?us-ascii?q?fP4C0Xq4/s1Nhv6O3Pjx096Tt0D8GF2WGXU250hn8IRyMx3K1no0x9zUmD3r?=
 =?us-ascii?q?J+g/NCFtxe/PxJUgA9NZ7Ty+x1Fcr+VR7GfteMGx6aRYCEDD8/Buw4xdMDeQ?=
 =?us-ascii?q?5GB9KvlliX3SekDaE9mLuMC5g5tKnb2i61b91wz3fAybkJkVYrWI1MOHegi6?=
 =?us-ascii?q?o58BLcVKDTlEDMrLqnbaQR2mb28W6HyWef9BVDXBVYTbTOXXdZYFDf69v++B?=
 =?us-ascii?q?WRHPeVFb07P14Zmoa5IaxQZ4is1AgXSQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BUAACatcFd/wHyM5BeCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfoF0LGxUATIqhCmPYQEBAQEBAQaBESV/iGWPXIFnCQEBAQEBA?=
 =?us-ascii?q?QEBASMRAQIBAYRAAoQOJDgTAg4BAQEEAQEBAQEFAwEBbIU3DII7KQGCbAEBA?=
 =?us-ascii?q?QECASMEETYLBQsLGAICJgICVwYBDAgBAYJfHhcKAYJSBSCwQnV/M4VOgymBS?=
 =?us-ascii?q?IEOKIwUGHiBB4ERJwyCKjU+hBIBDQUBB4Mogl4EjHKIamFElnWCLoI0hGGOI?=
 =?us-ascii?q?QYbgjxyixqLIY5DgUCaLSJncSsIAhgIIQ8aIYJsCUcRFIMRAReJEoUvIwMwg?=
 =?us-ascii?q?QUBAY5cgjABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Nov 2019 17:52:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA5HqqfE018627;
        Tue, 5 Nov 2019 12:52:53 -0500
Subject: Re: [PATCH v3] selinux: sidtab: reverse lookup hash table
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     paul@paul-moore.com, omosnace@redhat.com,
        Jovana Knezevic <jovanak@google.com>
References: <20191105134217.132137-1-jeffv@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <104b930c-a01f-1e51-0173-9661eb8b4b49@tycho.nsa.gov>
Date:   Tue, 5 Nov 2019 12:52:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191105134217.132137-1-jeffv@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/5/19 8:42 AM, Jeff Vander Stoep wrote:
> This replaces the reverse table lookup and reverse cache with a
> hashtable which improves cache-miss reverese-lookup times from

reverse

> O(n) to O(1)* and maintains the same performance as a reverse
> cache hit.
> 
> This reduces the time needed to add a new sidtab entry from ~500us
> to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
> 
> The implementation uses the kernel's generic hashtable API,
> It uses the context's string represtation as the hash source,
> and the kernels generic string hashing algorithm full_name_hash()
> to reduce the string to a 32 bit value.
> 
> This change also maintains the improvement introduced in commit
> ee1a84fd which removed the need to keep the current sidtab locked

Preferred style is "commit <12+ chars of sha1> ("title line")"; 
checkpatch.pl would have caught it except for the line break between 
commit and the hash I think.  ala
commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve 
performance")
This ensures that the commit is unambiguously identified and the reader 
gets an idea of what it is without having to go look.

> during policy reload. It does however introduce periodic locking of
> the target sidtab while converting the hashtable. Sidtab entries
> are never modified or removed, so the context struct stored in the
> sid_to_context tree can also be used for the context_to_sid
> hashtable to reduce memory usage.
> 
> This bug was reported by:
> - Stephen Smally on the selinux bug tracker.

Smalley (although I don't think I'm the original reporter, came from a 
mailing list email IIRC)

<snip>
> V3:
> -Move the hash_add() and count increment to after an smp_wmb()
> statement to enforce that prior objects have been written before
> becoming available for lookups.

smp_wmb() is SMP-conditional; wmb() is mandatory per 
memory-barriers.txt. I thought we needed wmb() for the old sidtab hash 
table update to avoid reordering even on the UP case.  And I think 
memory-barriers.txt recommends pairing every write barrier with a 
corresponding read barrier for the reader code, which my code lacked 
(since memory-barriers.txt didn't exist at the time and I was just 
following the guidance from other docs), so presumably you want/need that.

> -Add lock nesting notation.

Is it truly needed locking nesting or can we get rid of it as suggested 
by Ondrej?

Patch wouldn't apply for me (on selinux/next); not sure why but some 
comments below.

> 
> Change-Id: I9b498100c94f05222c54e24f53eba76468f360fd

Don't include AOSP Change-Ids in upstream patches.

<snip>
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 8af7a690eb40..5494379e1ac7 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -99,3 +99,15 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
>   	  via /selinux/checkreqprot if authorized by policy.
>   
>   	  If you are unsure how to answer this question, answer 0.
> +
> +config SECURITY_SELINUX_SIDTAB_HASH_BITS
> +	int "NSA SELinux sidtab hashtable size"
> +	depends on SECURITY_SELINUX
> +	range 8 13
> +	default 9
> +	help
> +	  This option sets the number of buckets used in the sitab hashtable

sidtab

> +	  to 2^SECURITY_SELINUX_SIDTAB_HASH_BITS buckets. The number of hash
> +	  collisions may be viewed at /selinux/ss/sidtab_hash_stats. If chain

Since Linux 3.0, selinuxfs is mounted on /sys/fs/selinux rather than 
/selinux so it would be /sys/fs/selinux/ss/sidtab_hash_stats.  The other 
config option help texts are out of date but don't worry about those in 
this patch.

> +	  lengths are high (e.g. > 20) than selecting a higher value here will
> +	  ensure that lookups times are fast and stable.
<snip>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 7eff19c41bcb..4bb4ff027042 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
<snip>
> @@ -1576,6 +1602,7 @@ static int sel_make_avc_files(struct dentry *dir)
>   		{ "cache_threshold",
>   		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
>   		{ "hash_stats", &sel_avc_hash_stats_ops, S_IRUGO },
> +		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },

Still awaiting a verdict from Paul on whether we should conform to 
checkpatch.pl warning on symbolic modes or stick with them for 
consistency until such a time as we convert them en masse?

>   #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
>   		{ "cache_stats", &sel_avc_cache_stats_ops, S_IRUGO },
>   #endif
> @@ -1601,6 +1628,35 @@ static int sel_make_avc_files(struct dentry *dir)
>   	return 0;
>   }
>   
> +static int sel_make_ss_files(struct dentry *dir)
> +{
> +	struct super_block *sb = dir->d_sb;
> +	struct selinux_fs_info *fsi = sb->s_fs_info;
> +	int i;
> +	static struct tree_descr files[] = {
> +		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(files); i++) {
> +		struct inode *inode;
> +		struct dentry *dentry;
> +
> +		dentry = d_alloc_name(dir, files[i].name);
> +		if (!dentry)
> +			return -ENOMEM;
> +
> +		inode = sel_make_inode(dir->d_sb, S_IFREG|files[i].mode);
> +		if (!inode)

dput(dentry); here (got fixed elsewhere recently IIRC).

> +			return -ENOMEM;
> +
> +		inode->i_fop = files[i].ops;
> +		inode->i_ino = ++fsi->last_ino;
> +		d_add(dentry, inode);
> +	}
> +
> +	return 0;
> +}
> +
>   static ssize_t sel_read_initcon(struct file *file, char __user *buf,
>   				size_t count, loff_t *ppos)
>   {
<snip>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 62e6a53f4ac9..9578fb3e994f 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
<snip>
> @@ -1433,6 +1446,7 @@ static int string_to_context_struct(struct policydb *pol,
>   	rc = -EINVAL;
>   	if (!policydb_context_isvalid(pol, ctx))
>   		goto out;
> +
>   	rc = 0;
>   out:
>   	if (rc)

Avoid unrelated whitespace changes

> @@ -1440,6 +1454,42 @@ static int string_to_context_struct(struct policydb *pol,
>   	return rc;
>   }
>   
> +int context_add_hash(struct policydb *policydb,
> +		     struct context *context)
> +{
> +	int rc;
> +	char *str;
> +	int len;
> +
> +	if (context->str) {
> +		context->hash = context_compute_hash(context->str);
> +	} else {
> +		rc = context_struct_to_string(policydb, context,
> +					      &str, &len);
> +		if (rc)
> +			return rc;
> +		context->hash = context_compute_hash(str);
> +		kfree(str);
> +	}

I'm guessing that KCSAN is going to complain about this and other 
existing cases in our code that rely on atomic load/store of 
naturally-aligned word-sized values.  At some point we'll probably need 
to convert them all to using READ_ONCE/WRITE_ONCE or similar constructs 
when we do this outside of a spinlock or write lock (as here).  Offhand, 
this may only be a problem for the cases where we are passing in a 
context structure that is part of the active policydb, as in 
security_port_sid() and other callers, since it is then a shared 
structure that could be visible to other threads.  Same issue already 
exists however for the sid field there so not really new.

> +	return 0;
> +}
> +
<snip>
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 9d156d5156da..2267878da626 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -16,26 +16,37 @@
>   #include "security.h"
>   #include "sidtab.h"
>   
> +#define index_to_sid(index) (index + SECINITSID_NUM + 1)
> +#define sid_to_index(sid) (sid - (SECINITSID_NUM + 1))
> +
>   int sidtab_init(struct sidtab *s)
>   {
>   	u32 i;
>   
>   	memset(s->roots, 0, sizeof(s->roots));
>   
> -	/* max count is SIDTAB_MAX so valid index is always < SIDTAB_MAX */
> -	for (i = 0; i < SIDTAB_RCACHE_SIZE; i++)
> -		s->rcache[i] = SIDTAB_MAX;
> -
>   	for (i = 0; i < SECINITSID_NUM; i++)
>   		s->isids[i].set = 0;
>   
>   	s->count = 0;
>   	s->convert = NULL;
> +	hash_init(s->context_to_sid);
>   
>   	spin_lock_init(&s->lock);
>   	return 0;
>   }
>   
> +static u32 context_to_sid(struct sidtab *s, struct context *context)
> +{
> +	struct sidtab_entry_leaf *entry;
> +

I think we need a read barrier or ACQUIRE operation of some kind here or 
in the callers to ensure that the hash is in a good state.

> +	hash_for_each_possible(s->context_to_sid, entry, list, context->hash) {
> +		if (context_cmp(&entry->context, context))
> +			return entry->sid;
> +	}
> +	return 0;
> +}
> +
>   int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
>   {
>   	struct sidtab_isid_entry *entry;
<snip>
> @@ -304,29 +274,35 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>   		rc = -ENOMEM;
>   		dst_convert = sidtab_do_lookup(convert->target, count, 1);
>   		if (!dst_convert) {
> -			context_destroy(dst);
> +			context_destroy(&dst->context);
>   			goto out_unlock;
>   		}
>   
> -		rc = convert->func(context, dst_convert, convert->args);
> +		rc = convert->func(context, &dst_convert->context,
> +				convert->args);
>   		if (rc) {
> -			context_destroy(dst);
> +			context_destroy(&dst->context);
>   			goto out_unlock;
>   		}
> +		dst_convert->sid = index_to_sid(count);
>   
>   		/* at this point we know the insert won't fail */
> +		spin_lock_irqsave(&convert->target->lock, flags);
>   		convert->target->count = count + 1;
> +		hash_add(convert->target->context_to_sid,
> +			 &dst_convert->list, dst_convert->context.hash);
> +		spin_unlock_irqrestore(&convert->target->lock, flags);

As Ondrej asked, do we need to take this lock?

>   	}
>   
>   	if (context->len)
>   		pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
>   			context->str);
>   
> -	sidtab_rcache_push(s, count);
> -	*index = count;
> +	*sid = index_to_sid(count);
>   
> -	/* write entries before writing new count */
> +	/* Write entries before updating count and inserting into hashtable. */
>   	smp_store_release(&s->count, count + 1);
> +	hash_add(s->context_to_sid, &dst->list, dst->context.hash);

I think we need a separate acquire/release or write/read barrier pairing 
for the reverse hash table that is independent of the one for the 
forward table.

>   
>   	rc = 0;
>   out_unlock:
