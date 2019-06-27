Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0209AC48BE7
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D622086D
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FPalKRvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfF0Rn4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:43:56 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:35979
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbfF0Rnz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jun 2019 13:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561657434; bh=Sa6YO7NHPRMzhta2Hzep5oX6yHgcSdxMhxRNSiZN5Cg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=FPalKRvTnQOKNjTNVPVKO45o4F6sxAnA+3ycLdMJlHaUUTDCJWwv5Q2x4WOSmmHcX4DTmL1JF4GzeGH0X45NEsnT/CzeYmfBdXJJt+g+ru5cyvS11Pj7Zldw5wDmgoFgri0ZMnttDysk0j6Mj4f6QzRaQHjR+2slEq7rjSVqmuPy4LlBwHXaSdJbE2nIKcjn+1qyuoE8hbyXFxBv+05nhx/Ci9lRwzHVr6unHE9CpC5Wg0LMR3Ct8j3P39GLVjrqRh2L95YdxqWmjBvBhmDe50auwxOmjTZsQB6o+ohy0Z/+Lrf/Ctw8wpXLzoVQ/DgJsc0++W0/Kora3K3j1jTZCA==
X-YMail-OSG: 2PZfiu4VM1mvlg43BtQ5fL29kisJQfRny1Iwp8OlGtqoAitSVmX9E_QFG1MvRN4
 qjHp.6J4UCiy8VKsiK_R_N.qxm8BolCukame9381BODmKanXpvsZ1hk_ZthB1Gzm7hQD76msyJlS
 LdeJQIvmU4HXrIt2DMPXQSfXnGyHgEo5DvUugwIhYNM_wLBZwMky1ZJ_HJCgiyevO0jl_RQ7YQ_L
 Ug7G1HYkUTpWIG1D0F9cVfjJ6cRaV5pdeP6zdszPRcuAKbXyB_LcT.rgzeWxAGV7gRiOPWBoNxOU
 bWZUVUJvyszRQcs8jnYpqSdx7vok4da6Hk5e3SxS4Ttgiea_2qh4JWrgFSolaKWQRaDA92ImNVQJ
 eENa24en4oHXwsy4_zwJ7iPrAP0o.asG50HCYcrE84SGd0oIDD79fVk9jVh2s4uL7_GwDdE7dcIE
 HYDAlyc_2C79XfjKttC1Z_VvNnsnuTV2RHsDC0dz3DfQ3Zz.3Ztqo7ila2iGX0TGTImT1EL9hoSD
 UoAGTznMMxbRydzpe3zUhNDWcf2B97gGaIIQKTaHUF2I8_GRayHYU3Mb.ApaDp_JP2gWVI.yUMf.
 RPvQ4ahJECDqaVpQyo.3p6.31N6lLiQ7K_jWYukTjfqCr5oX5P9F6dPVD5ARVQJROsUbeO0eBhlt
 fBAoTYIPFgdtqNNOpKyxr4KBu_SaRdQgH.TzjiUoiw8d3vNeWW_4MmS3x_TdWssG91..F.hLQbSq
 2ejEEagyUd.4OsjG.SDzPYck8.jxsC2k50P_s3WtWE5QuCv7XiQVeYJ2vY3Hgp4DIE8E_h3lwUbU
 Z3uSEXe7B_YWiPanlU2a4gs6EXFuCuM1eJ12bRivwhuTELat5RJmB4HKepy9Hl6QJBNzO0Ylvkv7
 ZXGxX6sq.xgFjJoI2MCglhrAKmtB8FfensmbgqaZvldysgA7S.gQcmC1xN5SegYjkxgzpUYLqnHB
 ns5t0HwLdIz7fsr9SLNKiLTMWElM6iArcmC8VLxENgn9eATUnrGVl3knxdNF_VojERwjxD1dKRC0
 8jjsPbHcE5JWqHjDD3z.IbZOwk_XVZLXjdohwXYdG_B5dJCphIGppImcUM8VGqF3XsV9iTI2Nu0E
 kK0A9O9cOwS_ZOGPtByi8uRoCapstkaUGJgVKrRHhPo.JoN8F9L3jlEI4c.wtlh1StBAmmhOKusf
 38QIyXwhWZRk8mYfoq.TUvOjrGvYL.fibmKD2o_J5dlS88OuRGp7XpN8VH.czYjojSRl3ESOmQFX
 NM1qrftD1Fr274CDhyfNLlpCoNaA_t38Vuszazin0mvdY7z9Y.EPIjECRPC4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Jun 2019 17:43:54 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6ffc9f5f26d842f131a2d6021058b2dd;
          Thu, 27 Jun 2019 17:43:52 +0000 (UTC)
Subject: Re: [PATCH v4 04/23] LSM: Create and manage the lsmblob data
 structure.
To:     John Johansen <john.johansen@canonical.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-5-casey@schaufler-ca.com>
 <19468cf8-8702-b391-fae5-197ddbb6da4d@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <31652f35-463e-f510-7436-f7db2ab461e1@schaufler-ca.com>
Date:   Thu, 27 Jun 2019 10:43:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <19468cf8-8702-b391-fae5-197ddbb6da4d@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/26/2019 4:39 PM, John Johansen wrote:
> On 6/26/19 12:22 PM, Casey Schaufler wrote:
>> When more than one security module is exporting data to
>> audit and networking sub-systems a single 32 bit integer
>> is no longer sufficient to represent the data. Add a
>> structure to be used instead.
>>
>> The lsmblob structure is currently an array of
>> u32 "secids". There is an entry for each of the
>> security modules built into the system that would
>> use secids if active. The system assigns the module
>> a "slot" when it registers hooks. If modules are
>> compiled in but not registered there will be unused
>> slots.
>>
>> A new lsm_id structure, which contains the name
>> of the LSM and its slot number, is created. There
>> is an instance for each LSM, which assigns the name
>> and passes it to the infrastructure to set the slot.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h  | 12 +++++--
>>  include/linux/security.h   | 66 +++++++++++++++++++++++++++++++++++++=
+
>>  security/apparmor/lsm.c    |  4 ++-
>>  security/commoncap.c       |  7 +++-
>>  security/loadpin/loadpin.c |  8 ++++-
>>  security/safesetid/lsm.c   |  8 ++++-
>>  security/security.c        | 31 ++++++++++++++----
>>  security/selinux/hooks.c   |  5 ++-
>>  security/smack/smack_lsm.c |  4 ++-
>>  security/tomoyo/tomoyo.c   |  8 ++++-
>>  security/yama/yama_lsm.c   |  4 ++-
>>  11 files changed, 140 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 3fe39abccc8f..fe1fb7a69ee5 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -2029,6 +2029,14 @@ struct security_hook_heads {
>>  #endif /* CONFIG_BPF_SYSCALL */
>>  } __randomize_layout;
>> =20
>> +/*
>> + * Information that identifies a security module.
>> + */
>> +struct lsm_id {
>> +	const char	*lsm;	/* Name of the LSM */
>> +	int		slot;	/* Slot in lsmblob if one is allocated */
>> +};
>> +
>>  /*
>>   * Security module hook list structure.
>>   * For use with generic list macros for common operations.
>> @@ -2037,7 +2045,7 @@ struct security_hook_list {
>>  	struct hlist_node		list;
>>  	struct hlist_head		*head;
>>  	union security_list_options	hook;
>> -	char				*lsm;
>> +	struct lsm_id			*lsmid;
>>  } __randomize_layout;
>> =20
>>  /*
>> @@ -2068,7 +2076,7 @@ extern struct security_hook_heads security_hook_=
heads;
>>  extern char *lsm_names;
>> =20
>>  extern void security_add_hooks(struct security_hook_list *hooks, int =
count,
>> -				char *lsm);
>> +			       struct lsm_id *lsmid);
>> =20
>>  #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>>  #define LSM_FLAG_EXCLUSIVE	BIT(1)
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 49f2685324b0..5bb8b9a6fa84 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -76,6 +76,72 @@ enum lsm_event {
>>  	LSM_POLICY_CHANGE,
>>  };
>> =20
>> +/*
>> + * Data exported by the security modules
>> + *
>> + * Any LSM that provides secid or secctx based hooks must be included=
=2E
>> + */
>> +#define LSMBLOB_ENTRIES ( \
>> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0))
>> +
>> +struct lsmblob {
>> +	u32     secid[LSMBLOB_ENTRIES];
>> +};
>> +
>> +#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
>> +#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
>> +#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
>> +
>> +/**
>> + * lsmblob_init - initialize an lsmblob structure.
>> + * @blob: Pointer to the data to initialize
>> + * @secid: The initial secid value
>> + *
>> + * Set all secid for all modules to the specified value.
>> + */
>> +static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < LSMBLOB_ENTRIES; i++)
>> +		blob->secid[i] =3D secid;
>> +}
>> +
>> +/**
>> + * lsmblob_is_set - report if there is an value in the lsmblob
>> + * @blob: Pointer to the exported LSM data
>> + *
>> + * Returns true if there is a secid set, false otherwise
>> + */
>> +static inline bool lsmblob_is_set(struct lsmblob *blob)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < LSMBLOB_ENTRIES; i++)
>> +		if (blob->secid[i] !=3D 0)
>> +			return true;
>> +	return false;
>> +}
>> +
>> +/**
>> + * lsmblob_equal - report if the two lsmblob's are equal
>> + * @bloba: Pointer to one LSM data
>> + * @blobb: Pointer to the other LSM data
>> + *
>> + * Returns true if all entries in the two are equal, false otherwise
>> + */
>> +static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblo=
b *blobb)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < LSMBLOB_ENTRIES; i++)
>> +		if (bloba->secid[i] !=3D blobb->secid[i])
>> +			return false;
>> +	return true;
>> +}
>> +
>>  /* These functions are in security/commoncap.c */
>>  extern int cap_capable(const struct cred *cred, struct user_namespace=
 *ns,
>>  		       int cap, unsigned int opts);
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 2716e7731279..6d2eefc9b7c1 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1138,6 +1138,8 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_=
ro_after_init =3D {
>>  	.lbs_sock =3D sizeof(struct aa_sk_ctx),
>>  };
>> =20
>> +static struct lsm_id apparmor_lsmid =3D { .lsm=3D"apparmor", .slot=3D=
LSMBLOB_NEEDED };
> __lsm_ro_after_init
>
>
>> +
>>  static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init=
 =3D {
>>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>>  	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
>> @@ -1679,7 +1681,7 @@ static int __init apparmor_init(void)
>>  		goto buffers_out;
>>  	}
>>  	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
>> -				"apparmor");
>> +				&apparmor_lsmid);
>> =20
>>  	/* Report that AppArmor successfully initialized */
>>  	apparmor_initialized =3D 1;
>> diff --git a/security/commoncap.c b/security/commoncap.c
>> index afd9679ca866..305a6088c81e 100644
>> --- a/security/commoncap.c
>> +++ b/security/commoncap.c
>> @@ -1344,6 +1344,11 @@ int cap_mmap_file(struct file *file, unsigned l=
ong reqprot,
>> =20
>>  #ifdef CONFIG_SECURITY
>> =20
>> +static struct lsm_id capability_lsmid =3D {
> __lsm_ro_after_init
>
>> +	.lsm=3D"capability",
>> +	.slot=3DLSMBLOB_NOT_NEEDED
>> +};
>> +
>>  static struct security_hook_list capability_hooks[] __lsm_ro_after_in=
it =3D {
>>  	LSM_HOOK_INIT(capable, cap_capable),
>>  	LSM_HOOK_INIT(settime, cap_settime),
>> @@ -1368,7 +1373,7 @@ static struct security_hook_list capability_hook=
s[] __lsm_ro_after_init =3D {
>>  static int __init capability_init(void)
>>  {
>>  	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
>> -				"capability");
>> +			   &capability_lsmid);
>>  	return 0;
>>  }
>> =20
>> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
>> index 055fb0a64169..13db59d5327e 100644
>> --- a/security/loadpin/loadpin.c
>> +++ b/security/loadpin/loadpin.c
>> @@ -181,6 +181,11 @@ static int loadpin_load_data(enum kernel_load_dat=
a_id id)
>>  	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
>>  }
>> =20
>> +static struct lsm_id loadpin_lsmid =3D {
> __lsm_ro_after_init
>
>
>> +	.lsm=3D"loadpin",
>> +	.slot=3DLSMBLOB_NOT_NEEDED
>> +};
>> +
>>  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init =
=3D {
>>  	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>>  	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
>> @@ -191,7 +196,8 @@ static int __init loadpin_init(void)
>>  {
>>  	pr_info("ready to pin (currently %senforcing)\n",
>>  		enforce ? "" : "not ");
>> -	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpi=
n");
>> +	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
>> +			   &loadpin_lsmid);
>>  	return 0;
>>  }
>> =20
>> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
>> index cecd38e2ac80..ca34badde4cf 100644
>> --- a/security/safesetid/lsm.c
>> +++ b/security/safesetid/lsm.c
>> @@ -255,6 +255,11 @@ void flush_safesetid_whitelist_entries(void)
>>  	}
>>  }
>> =20
>> +static struct lsm_id safesetid_lsmid =3D {
> __lsm_ro_after_init
>
>
>> +	.lsm=3D"safesetid",
>> +	.slot=3DLSMBLOB_NOT_NEEDED
>> +};
>> +
>>  static struct security_hook_list safesetid_security_hooks[] =3D {
>>  	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
>>  	LSM_HOOK_INIT(capable, safesetid_security_capable)
>> @@ -263,7 +268,8 @@ static struct security_hook_list safesetid_securit=
y_hooks[] =3D {
>>  static int __init safesetid_security_init(void)
>>  {
>>  	security_add_hooks(safesetid_security_hooks,
>> -			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
>> +			   ARRAY_SIZE(safesetid_security_hooks),
>> +			   &safesetid_lsmid);
>> =20
>>  	/* Report that SafeSetID successfully initialized */
>>  	safesetid_initialized =3D 1;
>> diff --git a/security/security.c b/security/security.c
>> index 7cfedb90210a..27e2db3d6b04 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -317,6 +317,7 @@ static void __init ordered_lsm_init(void)
>>  	init_debug("sock blob size       =3D %d\n", blob_sizes.lbs_sock);
>>  	init_debug("superblock blob size =3D %d\n", blob_sizes.lbs_superbloc=
k);
>>  	init_debug("task blob size       =3D %d\n", blob_sizes.lbs_task);
>> +	init_debug("lsmblob size         =3D %lu\n", sizeof(struct lsmblob))=
;
>> =20
>>  	/*
>>  	 * Create any kmem_caches needed for blobs
>> @@ -399,7 +400,7 @@ static bool match_last_lsm(const char *list, const=
 char *lsm)
>>  	return !strcmp(last, lsm);
>>  }
>> =20
>> -static int lsm_append(char *new, char **result)
>> +static int lsm_append(const char *new, char **result)
>>  {
>>  	char *cp;
>> =20
>> @@ -420,24 +421,40 @@ static int lsm_append(char *new, char **result)
>>  	return 0;
>>  }
>> =20
>> +/*
>> + * Current index to use while initializing the lsmblob secid list.
>> + */
>> +static int lsm_slot __initdata;
>> +
>>  /**
>>   * security_add_hooks - Add a modules hooks to the hook lists.
>>   * @hooks: the hooks to add
>>   * @count: the number of hooks to add
>> - * @lsm: the name of the security module
>> + * @lsmid: the identification information for the security module
>>   *
>>   * Each LSM has to register its hooks with the infrastructure.
>> + * If the LSM is using hooks that export secids allocate a slot
>> + * for it in the lsmblob.
>>   */
>>  void __init security_add_hooks(struct security_hook_list *hooks, int =
count,
>> -				char *lsm)
>> +			       struct lsm_id *lsmid)
>>  {
>>  	int i;
>> =20
>> +	if (lsmid->slot =3D=3D LSMBLOB_NEEDED) {
>> +		if (lsm_slot >=3D LSMBLOB_ENTRIES)
>> +			panic("%s Too many LSMs registered.\n", __func__);
>> +		lsmid->slot =3D lsm_slot++;
>> +		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>> +			   lsmid->slot);
>> +	}
> It might be nice (but not required) to add back in the list of hooks th=
at need
> secids as a cross check of LSMLOB_NOT_NEEDED. It would allow us to catc=
h
> bad registrations upfront instead of crashing the kernel when the hook =
gets
> used.

I considered leaving that check in, but my experience with
creating the list leads me to expect it to become a headache
of the 3rd order when hooks are added or changed by anyone
who hasn't been involved in this protracted process. It's not
always obvious that a hook needs to be on the list. Hmm.
That makes me think that a bit of documentation on when to
use LSMBLOB_NEEDED vs LSMBLOB_NOT_NEEDED is needed.=20

>> +
>>  	for (i =3D 0; i < count; i++) {
>> -		hooks[i].lsm =3D lsm;
>> +		hooks[i].lsmid =3D lsmid;
>>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>>  	}
>> -	if (lsm_append(lsm, &lsm_names) < 0)
>> +
>> +	if (lsm_append(lsmid->lsm, &lsm_names) < 0)
>>  		panic("%s - Cannot get early memory.\n", __func__);
>>  }
>> =20
>> @@ -1917,7 +1934,7 @@ int security_getprocattr(struct task_struct *p, =
const char *lsm, char *name,
>>  	struct security_hook_list *hp;
>> =20
>>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>> -		if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
>> +		if (lsm !=3D NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>>  		return hp->hook.getprocattr(p, name, value);
>>  	}
>> @@ -1930,7 +1947,7 @@ int security_setprocattr(const char *lsm, const =
char *name, void *value,
>>  	struct security_hook_list *hp;
>> =20
>>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>> -		if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
>> +		if (lsm !=3D NULL && strcmp(lsm, hp->lsmid->lsm))
>>  			continue;
>>  		return hp->hook.setprocattr(name, value, size);
>>  	}
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index c83ec2652eda..8c93b07bb353 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6622,6 +6622,8 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_r=
o_after_init =3D {
>>  	.lbs_superblock =3D sizeof(struct superblock_security_struct),
>>  };
>> =20
>> +static struct lsm_id selinux_lsmid =3D { .lsm=3D"selinux", .slot=3DLS=
MBLOB_NEEDED };
>> +
>>  static struct security_hook_list selinux_hooks[] __lsm_ro_after_init =
=3D {
>>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr=
),
>>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>> @@ -6877,7 +6879,8 @@ static __init int selinux_init(void)
>> =20
>>  	hashtab_cache_init();
>> =20
>> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinu=
x");
>> +	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
>> +			   &selinux_lsmid);
>> =20
>>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RES=
ET))
>>  		panic("SELinux: Unable to register AVC netcache callback\n");
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index e9560b078efe..ad646b865295 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -4553,6 +4553,8 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_=
after_init =3D {
>>  	.lbs_superblock =3D sizeof(struct superblock_smack),
>>  };
>> =20
>> +static struct lsm_id smack_lsmid =3D { .lsm=3D"smack", .slot=3DLSMBLO=
B_NEEDED };
> __lsm_ro_after_init
>
>> +
>>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init =3D=
 {
>>  	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>> @@ -4743,7 +4745,7 @@ static __init int smack_init(void)
>>  	/*
>>  	 * Register with LSM
>>  	 */
>> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
>> +	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmi=
d);
>>  	smack_enabled =3D 1;
>> =20
>>  	pr_info("Smack:  Initializing.\n");
>> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
>> index 716c92ec941a..57e6b845ea51 100644
>> --- a/security/tomoyo/tomoyo.c
>> +++ b/security/tomoyo/tomoyo.c
>> @@ -529,6 +529,11 @@ static void tomoyo_task_free(struct task_struct *=
task)
>>  	}
>>  }
>> =20
>> +static struct lsm_id tomoyo_lsmid =3D {
> __lsm_ro_after_init
>
>> +	.lsm=3D"tomoyo",
>> +	.slot=3DLSMBLOB_NOT_NEEDED
>> +};
>> +
>>  /*
>>   * tomoyo_security_ops is a "struct security_operations" which is use=
d for
>>   * registering TOMOYO.
>> @@ -581,7 +586,8 @@ static int __init tomoyo_init(void)
>>  	struct tomoyo_task *s =3D tomoyo_task(current);
>> =20
>>  	/* register ourselves with the security framework */
>> -	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo")=
;
>> +	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
>> +			   &tomoyo_lsmid);
>>  	pr_info("TOMOYO Linux initialized\n");
>>  	s->domain_info =3D &tomoyo_kernel_domain;
>>  	atomic_inc(&tomoyo_kernel_domain.users);
>> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
>> index efac68556b45..2263822a4af7 100644
>> --- a/security/yama/yama_lsm.c
>> +++ b/security/yama/yama_lsm.c
>> @@ -425,6 +425,8 @@ static int yama_ptrace_traceme(struct task_struct =
*parent)
>>  	return rc;
>>  }
>> =20
>> +static struct lsm_id yama_lsmid =3D { .lsm=3D"yama", .slot=3DLSMBLOB_=
NOT_NEEDED };
> __lsm_ro_after_init
>
>> +
>>  static struct security_hook_list yama_hooks[] __lsm_ro_after_init =3D=
 {
>>  	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>>  	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>> @@ -482,7 +484,7 @@ static inline void yama_init_sysctl(void) { }
>>  static int __init yama_init(void)
>>  {
>>  	pr_info("Yama: becoming mindful.\n");
>> -	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
>> +	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);=

>>  	yama_init_sysctl();
>>  	return 0;
>>  }
>>
> I like the change,
>
> Reviewed-by: John Johansen <john.johansen@canonical.com>

