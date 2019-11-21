Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A8DC432C0
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0939B20672
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfKUSm3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:42:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59161 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUSm3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 13:42:29 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iXrPL-00030y-En; Thu, 21 Nov 2019 18:42:23 +0000
Subject: Re: [PATCH v11 06/25] LSM: Use lsmblob in security_secctx_to_secid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20191113181925.2437-1-casey@schaufler-ca.com>
 <20191113181925.2437-7-casey@schaufler-ca.com>
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
Message-ID: <5639aa97-2a22-c284-951a-fed9704ec16a@canonical.com>
Date:   Thu, 21 Nov 2019 10:42:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113181925.2437-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 10:19 AM, Casey Schaufler wrote:
> Change security_secctx_to_secid() to fill in a lsmblob instead
> of a u32 secid. Multiple LSMs may be able to interpret the
> string, and this allows for setting whichever secid is
> appropriate. In some cases there is scaffolding where other
> interfaces have yet to be converted.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>


Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  include/linux/security.h          |  5 +++--
>  kernel/cred.c                     |  4 +---
>  net/netfilter/nft_meta.c          | 13 ++++++-------
>  net/netfilter/xt_SECMARK.c        |  5 ++++-
>  net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
>  security/security.c               | 18 +++++++++++++++---
>  6 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d57f400a307e..b69877a13efa 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -494,7 +494,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> -int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
> +int security_secctx_to_secid(const char *secdata, u32 seclen,
> +			     struct lsmblob *blob);
>  void security_release_secctx(char *secdata, u32 seclen);
>  void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
> @@ -1300,7 +1301,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
>  
>  static inline int security_secctx_to_secid(const char *secdata,
>  					   u32 seclen,
> -					   u32 *secid)
> +					   struct lsmblob *blob)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 846ac4b23c16..7fef90f3f10b 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -756,14 +756,12 @@ EXPORT_SYMBOL(set_security_override);
>  int set_security_override_from_ctx(struct cred *new, const char *secctx)
>  {
>  	struct lsmblob blob;
> -	u32 secid;
>  	int ret;
>  
> -	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
> +	ret = security_secctx_to_secid(secctx, strlen(secctx), &blob);
>  	if (ret < 0)
>  		return ret;
>  
> -	lsmblob_init(&blob, secid);
>  	return set_security_override(new, &blob);
>  }
>  EXPORT_SYMBOL(set_security_override_from_ctx);
> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index 317e3a9e8c5b..7c49397c33fd 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -617,21 +617,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
>  
>  static int nft_secmark_compute_secid(struct nft_secmark *priv)
>  {
> -	u32 tmp_secid = 0;
> +	struct lsmblob blob;
>  	int err;
>  
> -	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
> +	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
>  	if (err)
>  		return err;
>  
> -	if (!tmp_secid)
> -		return -ENOENT;
> -
> -	err = security_secmark_relabel_packet(tmp_secid);
> +	/* Using le[0] is scaffolding */
> +	err = security_secmark_relabel_packet(blob.secid[0]);
>  	if (err)
>  		return err;
>  
> -	priv->secid = tmp_secid;
> +	/* Using le[0] is scaffolding */
> +	priv->secid = blob.secid[0];
>  	return 0;
>  }
>  
> diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
> index 2317721f3ecb..2d68416b4552 100644
> --- a/net/netfilter/xt_SECMARK.c
> +++ b/net/netfilter/xt_SECMARK.c
> @@ -45,13 +45,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
>  
>  static int checkentry_lsm(struct xt_secmark_target_info *info)
>  {
> +	struct lsmblob blob;
>  	int err;
>  
>  	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
>  	info->secid = 0;
>  
>  	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
> -				       &info->secid);
> +				       &blob);
>  	if (err) {
>  		if (err == -EINVAL)
>  			pr_info_ratelimited("invalid security context \'%s\'\n",
> @@ -59,6 +60,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
>  		return err;
>  	}
>  
> +	/* scaffolding during the transition */
> +	info->secid = blob.secid[0];
>  	if (!info->secid) {
>  		pr_info_ratelimited("unable to map security context \'%s\'\n",
>  				    info->secctx);
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index d2e4ab8d1cb1..7a5a87f15736 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -881,7 +881,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>  	void *addr;
>  	void *mask;
>  	u32 addr_len;
> -	u32 secid;
> +	struct lsmblob blob;
>  	struct netlbl_audit audit_info;
>  
>  	/* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -905,12 +905,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>  	ret_val = security_secctx_to_secid(
>  		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>  				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -				  &secid);
> +				  &blob);
>  	if (ret_val != 0)
>  		return ret_val;
>  
> +	/* scaffolding with the [0] */
>  	return netlbl_unlhsh_add(&init_net,
> -				 dev_name, addr, mask, addr_len, secid,
> +				 dev_name, addr, mask, addr_len, blob.secid[0],
>  				 &audit_info);
>  }
>  
> @@ -932,7 +933,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>  	void *addr;
>  	void *mask;
>  	u32 addr_len;
> -	u32 secid;
> +	struct lsmblob blob;
>  	struct netlbl_audit audit_info;
>  
>  	/* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -954,12 +955,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>  	ret_val = security_secctx_to_secid(
>  		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>  				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -				  &secid);
> +				  &blob);
>  	if (ret_val != 0)
>  		return ret_val;
>  
> +	/* scaffolding with the [0] */
>  	return netlbl_unlhsh_add(&init_net,
> -				 NULL, addr, mask, addr_len, secid,
> +				 NULL, addr, mask, addr_len, blob.secid[0],
>  				 &audit_info);
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index 55837706e3ef..32bb5383de9b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1970,10 +1970,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
> -int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
> +int security_secctx_to_secid(const char *secdata, u32 seclen,
> +			     struct lsmblob *blob)
>  {
> -	*secid = 0;
> -	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.secctx_to_secid(secdata, seclen,
> +					      &blob->secid[hp->lsmid->slot]);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>  }
>  EXPORT_SYMBOL(security_secctx_to_secid);
>  
> 

