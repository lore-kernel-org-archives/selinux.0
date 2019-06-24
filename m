Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8A7C4646B
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 21:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B2E204FD
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 21:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbfFXVre (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:47:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54074 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbfFXVre (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 17:47:34 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hfWoF-0006Ky-6s; Mon, 24 Jun 2019 21:47:31 +0000
From:   John Johansen <john.johansen@canonical.com>
Subject: [PATCH v3 22/24] LSM: Return the lsmblob slot on initialization
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-23-casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzR1Kb2huIEpvaGFu
 c2VuIDxqb2huQGpqbXgubmV0PsLBegQTAQoAJAIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIX
 gAUCTo0YVwIZAQAKCRAFLzZwGNXD2LxJD/9TJZCpwlncTgYeraEMeDfkWv8c1IsM1j0AmE4V
 tL+fE780ZVP9gkjgkdYSxt7ecETPTKMaZSisrl1RwqU0oogXdXQSpxrGH01icu/2n0jcYSqY
 KggPxy78BGs2LZq4XPfJTZmHZGnXGq/eDr/mSnj0aavBJmMZ6jbiPz6yHtBYPZ9fdo8btczw
 P41YeWoIu26/8II6f0Xm3VC5oAa8v7Rd+RWZa8TMwlhzHExxel3jtI7IzzOsnmE9/8Dm0ARD
 5iTLCXwR1cwI/J9BF/S1Xv8PN1huT3ItCNdatgp8zqoJkgPVjmvyL64Q3fEkYbfHOWsaba9/
 kAVtBNz9RTFh7IHDfECVaToujBd7BtPqr+qIjWFadJD3I5eLCVJvVrrolrCATlFtN3YkQs6J
 n1AiIVIU3bHR8Gjevgz5Ll6SCGHgRrkyRpnSYaU/uLgn37N6AYxi/QAL+by3CyEFLjzWAEvy
 Q8bq3Iucn7JEbhS/J//dUqLoeUf8tsGi00zmrITZYeFYARhQMtsfizIrVDtz1iPf/ZMp5gRB
 niyjpXn131cm3M3gv6HrQsAGnn8AJru8GDi5XJYIco/1+x/qEiN2nClaAOpbhzN2eUvPDY5W
 0q3bA/Zp2mfG52vbRI+tQ0Br1Hd/vsntUHO903mMZep2NzN3BZ5qEvPvG4rW5Zq2DpybWc7B
 TQROZqz6ARAAoqw6kkBhWyM1fvgamAVjeZ6nKEfnRWbkC94L1EsJLup3Wb2X0ABNOHSkbSD4
 pAuC2tKF/EGBt5CP7QdVKRGcQzAd6b2c1Idy9RLw6w4gi+nn/d1Pm1kkYhkSi5zWaIg0m5RQ
 Uk+El8zkf5tcE/1N0Z5OK2JhjwFu5bX0a0l4cFGWVQEciVMDKRtxMjEtk3SxFalm6ZdQ2pp2
 822clnq4zZ9mWu1d2waxiz+b5Ia4weDYa7n41URcBEUbJAgnicJkJtCTwyIxIW2KnVyOrjvk
 QzIBvaP0FdP2vvZoPMdlCIzOlIkPLgxE0IWueTXeBJhNs01pb8bLqmTIMlu4LvBELA/veiaj
 j5s8y542H/aHsfBf4MQUhHxO/BZV7h06KSUfIaY7OgAgKuGNB3UiaIUS5+a9gnEOQLDxKRy/
 a7Q1v9S+Nvx+7j8iH3jkQJhxT6ZBhZGRx0gkH3T+F0nNDm5NaJUsaswgJrqFZkUGd2Mrm1qn
 KwXiAt8SIcENdq33R0KKKRC80Xgwj8Jn30vXLSG+NO1GH0UMcAxMwy/pvk6LU5JGjZR73J5U
 LVhH4MLbDggD3mPaiG8+fotTrJUPqqhg9hyUEPpYG7sqt74Xn79+CEZcjLHzyl6vAFE2W0kx
 lLtQtUZUHO36afFv8qGpO3ZqPvjBUuatXF6tvUQCwf3H6XMAEQEAAcLBXwQYAQoACQUCTmas
 +gIbDAAKCRAFLzZwGNXD2D/XD/0ddM/4ai1b+Tl1jznKajX3kG+MeEYeI4f40vco3rOLrnRG
 FOcbyyfVF69MKepie4OwoI1jcTU0ADecnbWnDNHpr0SczxBMro3bnrLhsmvjunTYIvssBZtB
 4aVJjuLILPUlnhFqa7fbVq0ZQjbiV/rt2jBENdm9pbJZ6GjnpYIcAbPCCa/ffL4/SQRSYHXo
 hGiiS4y5jBTmK5ltfewLOw02fkexH+IJFrrGBXDSg6n2Sgxnn++NF34fXcm9piaw3mKsICm+
 0hdNh4afGZ6IWV8PG2teooVDp4dYih++xX/XS8zBCc1O9w4nzlP2gKzlqSWbhiWpifRJBFa4
 WtAeJTdXYd37j/BI4RWWhnyw7aAPNGj33ytGHNUf6Ro2/jtj4tF1y/QFXqjJG/wGjpdtRfbt
 UjqLHIsvfPNNJq/958p74ndACidlWSHzj+Op26KpbFnmwNO0psiUsnhvHFwPO/vAbl3RsR5+
 0Ro+hvs2cEmQuv9r/bDlCfpzp2t3cK+rhxUqisOx8DZfz1BnkaoCRFbvvvk+7L/fomPntGPk
 qJciYE8TGHkZw1hOku+4OoM2GB5nEDlj+2TF/jLQ+EipX9PkPJYvxfRlC6dK8PKKfX9KdfmA
 IcgHfnV1jSn+8yH2djBPtKiqW0J69aIsyx7iV/03paPCjJh7Xq9vAzydN5U/UA==
Organization: Canonical
Message-ID: <11e751ea-c93c-efe7-558e-632af59d2355@canonical.com>
Date:   Mon, 24 Jun 2019 14:47:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621185233.6766-23-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/21/19 11:52 AM, Casey Schaufler wrote:
> Return the slot allocated to the calling LSM in the lsmblob
> structure. This can be used to set lsmblobs explicitly for
> netlabel interfaces.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  include/linux/lsm_hooks.h  | 4 ++--
>  security/apparmor/lsm.c    | 8 ++++++--
>  security/security.c        | 9 +++++++--
>  security/selinux/hooks.c   | 5 ++++-
>  security/smack/smack_lsm.c | 5 ++++-
>  5 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4d1ddf1a2aa6..ce341bcbce5d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2068,8 +2068,8 @@ struct lsm_blob_sizes {
>  extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
> -extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +extern int security_add_hooks(struct security_hook_list *hooks, int count,
> +			      char *lsm);
>  
>  #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>  #define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 2716e7731279..dcbbefbd95ff 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -47,6 +47,9 @@
>  /* Flag indicating whether initialization completed */
>  int apparmor_initialized;
>  
> +/* Slot for the AppArmor secid in the lsmblob structure */
> +int apparmor_lsmblob_slot;
> +
>  DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
>  
>  
> @@ -1678,8 +1681,9 @@ static int __init apparmor_init(void)
>  		aa_free_root_ns();
>  		goto buffers_out;
>  	}
> -	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +	apparmor_lsmblob_slot = security_add_hooks(apparmor_hooks,
> +						   ARRAY_SIZE(apparmor_hooks),
> +						   "apparmor");
>  
>  	/* Report that AppArmor successfully initialized */
>  	apparmor_initialized = 1;
> diff --git a/security/security.c b/security/security.c
> index b2ffcd1f3057..c93a368b697b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -437,9 +437,12 @@ static int lsm_slot __initdata;
>   * Each LSM has to register its hooks with the infrastructure.
>   * If the LSM is using hooks that export secids allocate a slot
>   * for it in the lsmblob.
> + *
> + * Returns the slot number in the lsmblob structure if one is
> + * allocated or LSMBLOB_INVALID if one was not allocated.
>   */
> -void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +int __init security_add_hooks(struct security_hook_list *hooks, int count,
> +			      char *lsm)
>  {
>  	int slot = LSMBLOB_INVALID;
>  	int i;
> @@ -479,6 +482,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	}
>  	if (lsm_append(lsm, &lsm_names) < 0)
>  		panic("%s - Cannot get early memory.\n", __func__);
> +
> +	return slot;
>  }
>  
>  int call_lsm_notifier(enum lsm_event event, void *data)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ee840fecfebb..1e09acbf9630 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -103,6 +103,7 @@
>  #include "avc_ss.h"
>  
>  struct selinux_state selinux_state;
> +int selinux_lsmblob_slot;
>  
>  /* SECMARK reference count */
>  static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
> @@ -6877,7 +6878,9 @@ static __init int selinux_init(void)
>  
>  	hashtab_cache_init();
>  
> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +	selinux_lsmblob_slot = security_add_hooks(selinux_hooks,
> +						  ARRAY_SIZE(selinux_hooks),
> +						  "selinux");
>  
>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>  		panic("SELinux: Unable to register AVC netcache callback\n");
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 3834b751d1e9..273f311fb153 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -60,6 +60,7 @@ static LIST_HEAD(smk_ipv6_port_list);
>  #endif
>  static struct kmem_cache *smack_inode_cache;
>  int smack_enabled;
> +int smack_lsmblob_slot;
>  
>  #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
>  static struct {
> @@ -4749,7 +4750,9 @@ static __init int smack_init(void)
>  	/*
>  	 * Register with LSM
>  	 */
> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> +	smack_lsmblob_slot = security_add_hooks(smack_hooks,
> +						ARRAY_SIZE(smack_hooks),
> +						"smack");
>  	smack_enabled = 1;
>  
>  	pr_info("Smack:  Initializing.\n");
> 



