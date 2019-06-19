Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CF1C46477
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AABD2173E
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HD9Y9Jst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbfFSQer (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:34:47 -0400
Received: from sonic308-13.consmr.mail.gq1.yahoo.com ([98.137.68.37]:37354
        "EHLO sonic308-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbfFSQeq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 12:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560962084; bh=Kcxulaj4p/InEZ1pEFM5MFzXxeT5lj47jIsJGMXp6G8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=HD9Y9Jst+ojUm9WbZxxYTrEtNfeE4jfQA3d9EeDW36cLxhWnve3t93YVXd3bJKACx3ZFdssEsaoEXaJJaujNsbehuDmFJ6yQLgBqetJfXVLkgO+++lveAZAdQ02TyPD1xhkqYnPoNRI1cOfmImxRc4L0zOp+0GejW6KxKG+G8jTuSBK7/ci4UfCdhqit0H4QKUpjc4pZGEmYZXFC4IfSloaXW7fdMrb3i6lx6F5jCBQJtMq/elD8ill0J81NZDDzUVmhD2W6MG37Vp/o1vpWWwKDRQk6569+1rjO7lXyBWPnAjU9RyTayvv9nkjuZ+XJB4p8Sm1R7wYuRvEgG63v3A==
X-YMail-OSG: isO2.cAVM1ntJ9a0yHv9bB7gpZzIOyeTL5pHoItUcP47tgug8kQan35771mzCxL
 a.477jBnOFIMqvfNpJvO8Cg07nyuMMWXANXuHEx1k_3tLgRf4wBsQRj3YGIZtJEU4HUWFtm5t8_0
 ZtBY1q2y1wdeuNl5_ixQ0gKmk4dA0sF46jhseOF9ixbf87_5v.QdACeVwXClyHAiv6e.VNhq_CQ5
 tCH0.X5Jw.MeXuqmhfvD9CYTuBxD8gtMOHaOIG.Y097BwZjq6CWXHSS4O2LuHIWSiV.PNvsrPBVw
 AcsZe2MQLi_GMZ_P_ZwBBgB3eFiYlo4e7LmWbloaXcB7ZYTjcZ2itZFbo6dByM2Dkq4Hy5uUAeaL
 dWNfizUtbW6._JyCjnp8LuD8Hr_wLaY7qJGBvl0a21rZ8JX2INfaFf90mKMkXqVVYdL7FcdS3LF6
 aOfVhhSyPWBYoEPqu1qxewWat55Gy0Rvgrc2p86hzsipuzdkSGzkbOQO5GneQMK_Bkv9Kv2C2PA3
 UOkgYq1n3ZukawHYbtD4GKNfyieYD2eRohCc0oyoiFA94CXiEB0m440Y8H8imU_Kb1WV0YCAeeZc
 LogC_cIw8j_RqBG_V6Xy.NsIiW1wKfSh78g2_w.l9R9RLiZLTBe80XWl6tLi_QN6c55_xFXZ0m0R
 sOjh900huznvUWPOipXLt0CDoJJg5p9BAs2uUolbQYJpU.xtf.LlhM6q7KO1dfEr_iS7ahgJFTB3
 ZNxlAcG9iei2pwZCN8gBW1sCpozBR4zaz2581yV1NcfC6kwuIfSa0GrtdeVbOVyYr3rrpSB4s.vZ
 MDDtCIKb0_XF2itexTuFIFgJk4fXCGnDSw.cJoaZzc.Ef0WgRpBkjBa4BZQkXKfyJTliXQMyNM_Y
 NDQimq82NxKI0HsF2JMqSTZd659exIz20ankM3774eUj7.p5oz8BcdxNbth7FBM948yhoPzYI3pt
 dslQN058.5LRcdEm6gYplumFJ4zQqPgI8Yte4haStlqUWktVBxIhk5he7iuz5vMpGaMW5us3liLn
 ja_YWJY8lpQ27g0K7jHWpvwM7iTmr70ljeUl1iVJcOlofY2LPDA14WnYiWFdRzCLw3_dRTs_F2iA
 cl.WvWEtE.bS4svGEOMEzM18Lewtw_29iQp1wmiW3I4HhxSSDz8406NzVnyxjTlQDX_lGf1.T01Z
 YQzcS84Gy7CgWZ5_o5_NFl5Jwu7eDR8Z.H8o70pGdv80HGIk6elN3vD1k23b87qiI.rZYKqRK6t6
 _c4_vV6Wd4wcjIHBEygIZ4VpXhpwbEBkbVg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 16:34:44 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3a878f999efcbb24a6c5936242e5d0fd;
          Wed, 19 Jun 2019 16:34:39 +0000 (UTC)
Subject: Re: [PATCH v2 04/25] LSM: Create and manage the lsmblob data
 structure.
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-5-casey@schaufler-ca.com>
 <201906182147.0A592CBB62@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <edc9309e-45ca-7775-c056-6e9ea97b8b5d@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 09:34:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182147.0A592CBB62@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 9:52 PM, Kees Cook wrote:
> On Tue, Jun 18, 2019 at 04:05:30PM -0700, Casey Schaufler wrote:
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
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h |  1 +
>>  include/linux/security.h  | 62 ++++++++++++++++++++++++++++++++++++++=
+
>>  security/security.c       | 31 ++++++++++++++++++++
>>  3 files changed, 94 insertions(+)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 3fe39abccc8f..4d1ddf1a2aa6 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -2038,6 +2038,7 @@ struct security_hook_list {
>>  	struct hlist_head		*head;
>>  	union security_list_options	hook;
>>  	char				*lsm;
>> +	int				slot;
>>  } __randomize_layout;
> Hm, this feels redundant (as does the existing "char *lsm") now that we=

> have lsm_info. The place for assigned-at-init value is blob_sizes, whic=
h
> hangs off of lsm_info (as does the LSM char *)...

Hm, is right. If the "char *lsm" pointer were replaced with a
"struct lsm_info *lsm_info" pointer, and "int slot" added to
lsm_info it would be a touch cleaner. A little bit of gimmickry
might be required for initialization, but maybe not. It's
worth looking into.

>> =20
>>  /*
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 49f2685324b0..28d074866895 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -76,6 +76,68 @@ enum lsm_event {
>>  	LSM_POLICY_CHANGE,
>>  };
>> =20
>> +/*
>> + * Data exported by the security modules
>> + */
>> +#define LSMDATA_ENTRIES ( \
> LSMBLOB_ENTRIES?

That would be about 7% better.

>> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) )
>> +
>> +struct lsmblob {
>> +	u32     secid[LSMDATA_ENTRIES];
>> +};
> Cool; I like this auto-sizing.

I figured this was either clever or hideous, but
hadn't fully decided which.

>> +
>> +#define LSMDATA_INVALID	-1
>> +
>> +/**
>> + * lsmblob_init - initialize an lsmblob structure.
>> + * @l: Pointer to the data to initialize
>> + * @secid: The initial secid value
>> + *
>> + * Set all secid for all modules to the specified value.
>> + */
>> +static inline void lsmblob_init(struct lsmblob *l, u32 secid)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < LSMDATA_ENTRIES; i++)
>> +		l->secid[i] =3D secid;
> For all these LSMDATA_ENTRIES, I prefer ARRAY_SIZE(l->secid), but
> *shrug*

I suppose, although you're adding compile time, and the
definition of LSMDATA_ENTRIES is just above.

>> +}
>> +
>> +/**
>> + * lsmblob_is_set - report if there is an value in the lsmblob
>> + * @l: Pointer to the exported LSM data
>> + *
>> + * Returns true if there is a secid set, false otherwise
>> + */
>> +static inline bool lsmblob_is_set(struct lsmblob *l)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < LSMDATA_ENTRIES; i++)
>> +		if (l->secid[i] !=3D 0)
>> +			return true;
>> +	return false;
>> +}
>> +
>> +/**
>> + * lsmblob_equal - report if the two lsmblob's are equal
>> + * @l: Pointer to one LSM data
>> + * @m: Pointer to the other LSM data
>> + *
>> + * Returns true if all entries in the two are equal, false otherwise
>> + */
>> +static inline bool lsmblob_equal(struct lsmblob *l, struct lsmblob *m=
)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < LSMDATA_ENTRIES; i++)
>> +		if (l->secid[i] !=3D m->secid[i])
>> +			return false;
>> +	return true;
>> +}
>> +
>>  /* These functions are in security/commoncap.c */
>>  extern int cap_capable(const struct cred *cred, struct user_namespace=
 *ns,
>>  		       int cap, unsigned int opts);
>> diff --git a/security/security.c b/security/security.c
>> index d05f00a40e82..5aa3c052d702 100644
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
>> @@ -420,6 +421,11 @@ static int lsm_append(char *new, char **result)
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
>> @@ -427,15 +433,40 @@ static int lsm_append(char *new, char **result)
>>   * @lsm: the name of the security module
>>   *
>>   * Each LSM has to register its hooks with the infrastructure.
>> + * If the LSM is using hooks that export secids allocate a slot
>> + * for it in the lsmblob.
>>   */
>>  void __init security_add_hooks(struct security_hook_list *hooks, int =
count,
>>  				char *lsm)
>>  {
>> +	int slot =3D LSMDATA_INVALID;
>>  	int i;
>> =20
>>  	for (i =3D 0; i < count; i++) {
>>  		hooks[i].lsm =3D lsm;
>>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>> +		/*
>> +		 * If this is one of the hooks that uses a secid
>> +		 * note it so that a slot can in allocated for the
>> +		 * secid in the lsmblob structure.
>> +		 */
>> +		if (hooks[i].head =3D=3D &security_hook_heads.audit_rule_match ||
>> +		    hooks[i].head =3D=3D &security_hook_heads.kernel_act_as ||
>> +		    hooks[i].head =3D=3D
>> +			&security_hook_heads.socket_getpeersec_dgram ||
>> +		    hooks[i].head =3D=3D &security_hook_heads.secctx_to_secid ||
>> +		    hooks[i].head =3D=3D &security_hook_heads.secid_to_secctx ||
>> +		    hooks[i].head =3D=3D &security_hook_heads.ipc_getsecid ||
>> +		    hooks[i].head =3D=3D &security_hook_heads.task_getsecid ||
>> +		    hooks[i].head =3D=3D &security_hook_heads.inode_getsecid ||
>> +		    hooks[i].head =3D=3D &security_hook_heads.cred_getsecid) {
>> +			if (slot =3D=3D LSMDATA_INVALID) {
>> +				slot =3D lsm_slot++;
> This needs to sanity check lsm_slot against lsmblob secids array size,
> just we we catch cases cleanly if an LSM adds a hook but doesn't add
> itself to the LSMDATA_ENTRIES macro.

Point, and easy enough.

>> +				init_debug("%s assigned lsmblob slot %d\n",
>> +					hooks[i].lsm, slot);
>> +			}
>> +		}
>> +		hooks[i].slot =3D slot;
>>  	}
>>  	if (lsm_append(lsm, &lsm_names) < 0)
>>  		panic("%s - Cannot get early memory.\n", __func__);
>> --=20
>> 2.20.1
>>

