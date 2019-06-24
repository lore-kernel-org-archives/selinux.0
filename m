Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4116FC4646B
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 21:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5AB20665
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 21:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pgtIdmNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfFXVyB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:54:01 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:42945
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbfFXVyB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 17:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561413238; bh=CceU0uIg7Z/d+r7edWGK+Xq1Zcie+Y22DVA6ivYdbXY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=pgtIdmNEyPYUblwPGYCd53zJv5YGomnonQtMhmDLyD5k1l1Lb9o+nAkMm73FSE6d8Cr2LI2Q3kt5EapiyaHB+1t5/5smWqjjOafUywwf62/WrHSMsp5qLq9zag48PcSsrIvUeFoHOpDlNNfL4toNYVfT5woY5MsjPaAuNJgyiLriMdCJNGDrIbidWjnHJ5rP8ZrKVD1pNJlceLQzcEPhPc6MVsDTjSQcGTc1bZLEHC9QwTfq3K16dy2MAaAh/YojybKCHv5WGIEn4NGj+gNabL/qnDrVCZpVFSRWUY3J7kkbVp9VldbA9WJc8oEVCEkJp+W0pUyhOGfjJbWGSC21BA==
X-YMail-OSG: b_V4cl8VM1nWPcPKIjNyu4tC14ivmDYxIEmoT9eiQ1mbpb0tJ9tKOMlRxXpncba
 PccbioYgqL_LC9v5jMJ2hSj_3TvoKgbWjh0KE0yytqNd_XvYJOrQqzi6yv5Sb81_rYcCDSjRygpf
 d6f4bwePsvBU9MF1J2E.ptoaFpX_6OzPnI4O8aCh_HLBn59quFQDKeKsgEBNQGCVx_5iDgZQygLX
 t49UJR07eUMpbnQZRB0niDSKDfT2tIgeByFEDbWGpyb41SDy0TrRThYG5GfiQ0Tir9fqjWdl6IrK
 5Be2SaB6BPc_ef8WL5JwwvOcvixYKPKMLmmvyKQKdEvaoCKmxT_NkTwA7YWjcrU8xsgoecj66erC
 bgPkD7Cu.78e23h7_FKlVE0MRcSuSBdqDDjSyxbjt3kbCgjgFUUEn3B8wU2Pviq1xpRSCIGnN97u
 0tBjSn_b1JQvYZvrcfxniHoSa7KURZaNvJhgToPiO3zMHp3lrT6ihfg272HYh21.7pAko_ub.oPk
 U0SnhvCRFhDoA81aDm0uj8gRv3qyw8yGkZWPcqFYFhxScToILrshjQEZ9xFLudvc2aQwXzLSkvD5
 XLZEHLWWqzjjwps8CnRpgzE53XkfVxKvToNBjNK4mo.niR1jdgFioJGbTYzakb77NkypgnMoka6_
 HCNZ7LoTOo2yNOvS9azAjME3UW9.Eueftghl4aaE0OnIcYNUs8ggGuOorGOFjn5sh4JQTi9N_OSj
 GNTNkZkUDJNaBVFjvZYHCImJgtWgHr5WwwevdCKxytdLqvUm83BD4S3XqUOQ_pIaykfLsHMLYzwp
 7ndmPSoeGbUuf7XXL8bTFr0AGzCGnoMgAO5i7QbjCZ08odEtIUT0KIwvVd0s8_OWXMHYmAnc1S0h
 Xxo2nJvfamCz9QicXGrfWeKmxCMnlPFUPbX7YloXqePlAf8PpvlPEV048PggItB5JzIYqoo7V8s6
 cPwdNmDhCxe4PU43QvyCj9wnw19RMnApteDMPwfKJTRieBuRXMlORQffJ9zGuotswBSGwMG1hqhv
 GnUyyDPAaPzIpz2t.kklLDp_jhwj31pxRVQEVeNGvf3EDZjNliwl6wfs8HLLcbIfcW4HYElRLVX3
 zGHTRww0qNMkhs.sdh224MMlqJyKcLdeDEVaYTU71NG6bLJesj1FLyJDoIrOvOa90OJhW1SJbDWm
 LAmV.79twpoEYIT_79p_ejJTP7AITKNHzIXTgRlsjirnXs5bPC6ERaAAhFXY9gMtn72XE6V3FWOA
 N8MUNo24.Q9iMFrm0RUAu.lV2_1Xg_OYCW0ZFKHr_pw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Jun 2019 21:53:58 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 23c319493ede373edf524b13799da3c6;
          Mon, 24 Jun 2019 21:53:55 +0000 (UTC)
Subject: Re: [PATCH v3 22/24] LSM: Return the lsmblob slot on initialization
To:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-23-casey@schaufler-ca.com>
 <201906221613.3443FA528B@keescook>
 <6d18ee4f-fe1b-39ae-dbe6-59ff120112c4@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <b1db2b88-dbb1-fd66-9a2b-6973e712e74f@schaufler-ca.com>
Date:   Mon, 24 Jun 2019 14:53:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <6d18ee4f-fe1b-39ae-dbe6-59ff120112c4@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/24/2019 2:39 PM, John Johansen wrote:
> On 6/22/19 4:13 PM, Kees Cook wrote:
>> On Fri, Jun 21, 2019 at 11:52:31AM -0700, Casey Schaufler wrote:
>>> Return the slot allocated to the calling LSM in the lsmblob
>>> structure. This can be used to set lsmblobs explicitly for
>>> netlabel interfaces.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> (I have some thoughts on refactoring the slot assignment, but that
>> should happen after this series -- it's nothing more than a storage
>> optimization.)
>>
>> -Kees
> haha so do I, now I am curious as to how close they align

Plan A: Each LSM has a lsm_id {.name, .slot}, the address of which
is passed to security_add_hooks() in place of the current char *lsm.
This is added to each hook instead of the *lsm. The slot value is
set if the LSM requests one. One slot integer per LSM instead of one
per hook.

>
>
>>> ---
>>>  include/linux/lsm_hooks.h  | 4 ++--
>>>  security/apparmor/lsm.c    | 8 ++++++--
>>>  security/security.c        | 9 +++++++--
>>>  security/selinux/hooks.c   | 5 ++++-
>>>  security/smack/smack_lsm.c | 5 ++++-
>>>  5 files changed, 23 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index 4d1ddf1a2aa6..ce341bcbce5d 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -2068,8 +2068,8 @@ struct lsm_blob_sizes {
>>>  extern struct security_hook_heads security_hook_heads;
>>>  extern char *lsm_names;
>>>  
>>> -extern void security_add_hooks(struct security_hook_list *hooks, int count,
>>> -				char *lsm);
>>> +extern int security_add_hooks(struct security_hook_list *hooks, int count,
>>> +			      char *lsm);
>>>  
>>>  #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>>>  #define LSM_FLAG_EXCLUSIVE	BIT(1)
>>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>>> index 2716e7731279..dcbbefbd95ff 100644
>>> --- a/security/apparmor/lsm.c
>>> +++ b/security/apparmor/lsm.c
>>> @@ -47,6 +47,9 @@
>>>  /* Flag indicating whether initialization completed */
>>>  int apparmor_initialized;
>>>  
>>> +/* Slot for the AppArmor secid in the lsmblob structure */
>>> +int apparmor_lsmblob_slot;
>>> +
>>>  DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
>>>  
>>>  
>>> @@ -1678,8 +1681,9 @@ static int __init apparmor_init(void)
>>>  		aa_free_root_ns();
>>>  		goto buffers_out;
>>>  	}
>>> -	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
>>> -				"apparmor");
>>> +	apparmor_lsmblob_slot = security_add_hooks(apparmor_hooks,
>>> +						   ARRAY_SIZE(apparmor_hooks),
>>> +						   "apparmor");
>>>  
>>>  	/* Report that AppArmor successfully initialized */
>>>  	apparmor_initialized = 1;
>>> diff --git a/security/security.c b/security/security.c
>>> index b2ffcd1f3057..c93a368b697b 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -437,9 +437,12 @@ static int lsm_slot __initdata;
>>>   * Each LSM has to register its hooks with the infrastructure.
>>>   * If the LSM is using hooks that export secids allocate a slot
>>>   * for it in the lsmblob.
>>> + *
>>> + * Returns the slot number in the lsmblob structure if one is
>>> + * allocated or LSMBLOB_INVALID if one was not allocated.
>>>   */
>>> -void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>> -				char *lsm)
>>> +int __init security_add_hooks(struct security_hook_list *hooks, int count,
>>> +			      char *lsm)
>>>  {
>>>  	int slot = LSMBLOB_INVALID;
>>>  	int i;
>>> @@ -479,6 +482,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>>  	}
>>>  	if (lsm_append(lsm, &lsm_names) < 0)
>>>  		panic("%s - Cannot get early memory.\n", __func__);
>>> +
>>> +	return slot;
>>>  }
>>>  
>>>  int call_lsm_notifier(enum lsm_event event, void *data)
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index ee840fecfebb..1e09acbf9630 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -103,6 +103,7 @@
>>>  #include "avc_ss.h"
>>>  
>>>  struct selinux_state selinux_state;
>>> +int selinux_lsmblob_slot;
>>>  
>>>  /* SECMARK reference count */
>>>  static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
>>> @@ -6877,7 +6878,9 @@ static __init int selinux_init(void)
>>>  
>>>  	hashtab_cache_init();
>>>  
>>> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
>>> +	selinux_lsmblob_slot = security_add_hooks(selinux_hooks,
>>> +						  ARRAY_SIZE(selinux_hooks),
>>> +						  "selinux");
>>>  
>>>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>>>  		panic("SELinux: Unable to register AVC netcache callback\n");
>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>> index 3834b751d1e9..273f311fb153 100644
>>> --- a/security/smack/smack_lsm.c
>>> +++ b/security/smack/smack_lsm.c
>>> @@ -60,6 +60,7 @@ static LIST_HEAD(smk_ipv6_port_list);
>>>  #endif
>>>  static struct kmem_cache *smack_inode_cache;
>>>  int smack_enabled;
>>> +int smack_lsmblob_slot;
>>>  
>>>  #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
>>>  static struct {
>>> @@ -4749,7 +4750,9 @@ static __init int smack_init(void)
>>>  	/*
>>>  	 * Register with LSM
>>>  	 */
>>> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
>>> +	smack_lsmblob_slot = security_add_hooks(smack_hooks,
>>> +						ARRAY_SIZE(smack_hooks),
>>> +						"smack");
>>>  	smack_enabled = 1;
>>>  
>>>  	pr_info("Smack:  Initializing.\n");
>>> -- 
>>> 2.20.1
>>>
