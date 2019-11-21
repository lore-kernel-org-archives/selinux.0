Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E96C432C0
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9308B20672
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKUSnR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:43:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59193 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUSnR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 13:43:17 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iXrQA-00033Z-0B; Thu, 21 Nov 2019 18:43:14 +0000
Subject: Re: [PATCH v11 08/25] LSM: Use lsmblob in security_ipc_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20191113181925.2437-1-casey@schaufler-ca.com>
 <20191113181925.2437-9-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
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
Message-ID: <1aa73f7b-11a9-8382-abf3-83d736154576@canonical.com>
Date:   Thu, 21 Nov 2019 10:43:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113181925.2437-9-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 10:19 AM, Casey Schaufler wrote:
> There may be more than one LSM that provides IPC data
> for auditing. Change security_ipc_getsecid() to fill in
> a lsmblob structure instead of the u32 secid. The
> audit data structure containing the secid will be updated
> later, so there is a bit of scaffolding here.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  include/linux/security.h |  7 ++++---
>  kernel/auditsc.c         |  5 ++++-
>  security/security.c      | 12 +++++++++---
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a3e99bccb1bb..9519b4fb43ae 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -464,7 +464,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			unsigned long arg4, unsigned long arg5);
>  void security_task_to_inode(struct task_struct *p, struct inode *inode);
>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
>  int security_msg_msg_alloc(struct msg_msg *msg);
>  void security_msg_msg_free(struct msg_msg *msg);
>  int security_msg_queue_alloc(struct kern_ipc_perm *msq);
> @@ -1172,9 +1172,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
>  	return 0;
>  }
>  
> -static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
> +					 struct lsmblob *blob)
>  {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>  }
>  
>  static inline int security_msg_msg_alloc(struct msg_msg *msg)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 04803c3099b2..ce8bf2d8f8d2 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2285,11 +2285,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
>  void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
>  	struct audit_context *context = audit_context();
> +	struct lsmblob blob;
>  	context->ipc.uid = ipcp->uid;
>  	context->ipc.gid = ipcp->gid;
>  	context->ipc.mode = ipcp->mode;
>  	context->ipc.has_perm = 0;
> -	security_ipc_getsecid(ipcp, &context->ipc.osid);
> +	security_ipc_getsecid(ipcp, &blob);
> +	/* scaffolding on the [0] - change "osid" to a lsmblob */
> +	context->ipc.osid = blob.secid[0];
>  	context->type = AUDIT_IPC;
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index 0fc75a31a6bb..b60c6a51f622 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1783,10 +1783,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>  	return call_int_hook(ipc_permission, 0, ipcp, flag);
>  }
>  
> -void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
> +void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
>  {
> -	*secid = 0;
> -	call_void_hook(ipc_getsecid, ipcp, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
> +	}
>  }
>  
>  int security_msg_msg_alloc(struct msg_msg *msg)
> 

