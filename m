Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD118FDDE
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 02:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786675147; cv=none; b=Ag7S1DBgOqD/ynF92rQ4CM+nQ6T7y4k3fGTxhuXiWuCF5m1FTRknqzzip4AiJRQD5quCf/xiIhJMRmhZ32AnBu0xMMrxwsUBpb1Rh/UTiZeyGzqoLvYR2Bp5gQWvH7tB7uSK5Jum4MeS/2I4+u91hq37S6w5q6EaVQEll+NJV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786675147; c=relaxed/simple;
	bh=lTKSLxp7EESD5AwLIQ72DniqW8jjRDlMo8WJF4g/Ros=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nvk1/jXuj7rkXyGljy9wxtpb+PVRMu+4SAWdm93Ey2r50SWG+Cht/EhblBa+gS5adCladmp5tNjOyZfw19w50nR5vyhNyKmtnI1jILPg9XxEIlV+IWlL1irdaYdH8s7KSY3ozwLjbmV5f4oBv+yCNewxTb1/CR6K9cJu8DSKvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ludxAZud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ludxAZud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2161F000E9
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786675145;
	bh=LdvPKdYL/p05SFziqYTw/kVzigVLWCpo1XaTjPAuYdM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ludxAZud0WAj8yQ+0/UTww+0XS4a2K6/SFEpqoJL47fBEPQnBZUTwW2T6DOqQjfNM
	 kLRLIs0+L3Tal/O4uL0pQVDUoy1LwooBGZ4ikE2AC0gfRSrVdtGznObKxeJcJtN0+r
	 pzYtHIk5ECAF+HDOKbkp4vAmnc4DskiUPUyCYZisn15bQrEHcURxO4G2xT+YgNSF6t
	 wuwDlQvz8qz/kYxEnBJrlHzB1HdXE7S+T51/dp0RcEtugc7z5+NqaJSU4n3rrLfU4f
	 U2VwpCjh1K53tc4s1hXIrORVuo62KOa1ieQH2nH/lY8vj/B7SpnhXiVtF6otjTJMYX
	 EK59C3skD/ZXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] net, lsm: Change skb secmarks to x-array indexes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260813204854.19211-8-casey@schaufler-ca.com>
References: <20260813204854.19211-1-casey@schaufler-ca.com>
 <20260813204854.19211-8-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:39:05 +0000
Message-Id: <20260814023905.7A2161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Missing NULL checks on the results of `xa_load()` in `secxa_se=
t_secmark()` causes unconditional kernel panics.
- [Critical] In `smack_from_skb()`, failure from `secxa_get_lsmprop()` leav=
es a stack pointer uninitialized, leading to a wild pointer dereference.
- [High] Uninitialized stack memory causes XArray deduplication failures an=
d leaks kernel stack data.
- [High] Negative error codes from `secxa_from_lsmprop()` are truncated to =
unsigned 32-bit integers, bypassing error checks.
- [High] The XArray is allowed to allocate index 0, breaking the `skb->secm=
ark =3D=3D 0` universal sentinel for unlabeled packets.
- [High] A newly allocated `struct lsm_prop` is inserted into the global XA=
rray before its contents are initialized, leading to a race condition that =
corrupts packet labels.
- [High] AppArmor unconditionally dereferences `prop->apparmor.label`, lead=
ing to a crash if the secmark was created by another LSM.
- [Medium] The XArray allocation limit `xa_limit_32b` exceeds the maximum p=
ositive value representable by the `int` return type.
- [Medium] Missing synchronization around the read-allocate-insert sequence=
 in `secxa_from_lsmprop()` allows concurrent threads to insert duplicate en=
tries.
- [Medium] SELinux hooks evaluate packets as unlabeled when `secxa_get_lsmp=
rop()` fails, potentially bypassing security policies.
--

--- Patch [7]: [PATCH 7/7] net, lsm: Change skb secmarks to x-array indexes=
 ---
commit 4d10524e4c6ddab86481df7f6394707d0a6f8278
Author: Casey Schaufler <casey@schaufler-ca.com>

net, lsm: Change skb secmarks to x-array indexes

This commit shifts the skb secmark infrastructure to maintain an xarray of
lsm_prop structures. It replaces the LSM-specific secid with an xarray
index representing the security information.

> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index bd9a9377919cf..0ce662ec3de06 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -926,17 +926,20 @@ static const struct nla_policy nft_secmark_policy[N=
FTA_SECMARK_MAX + 1] =3D {
> =20
>  static int nft_secmark_compute_secid(struct nft_secmark *priv)
>  {
> +	struct lsm_prop tmp_prop;
>  	u32 tmp_secid =3D 0;
>  	int err;
> =20
> -	err =3D security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_sec=
id);
> +	err =3D security_secctx_to_lsmprop(priv->ctx, strlen(priv->ctx),
> +					 &tmp_prop, LSM_ID_UNDEF);

[Severity: High]
Does this leave the tmp_prop structure partially uninitialized on the stack?

Since security_secctx_to_lsmprop() only initializes fields for the active
LSM, the rest of the struct might contain stack garbage. When passed to
secxa_from_lsmprop(), memcmp() is used on the entire struct, which can fail
to match due to garbage bytes, breaking XArray deduplication and leaking
kernel stack data.

Is it necessary to initialize this with an empty struct assignment?

>  	if (err)
>  		return err;
> =20
> -	if (!tmp_secid)
> -		return -ENOENT;
> +	tmp_secid =3D secxa_from_lsmprop(&tmp_prop);
> +	if (tmp_secid < 0)
> +		return tmp_secid;

[Severity: High]
Can the tmp_secid < 0 check ever be true here?

Since tmp_secid is declared as a u32, a negative error code from
secxa_from_lsmprop() (like -ENOMEM) will be truncated to a large unsigned
integer, bypassing the error check. This could store an invalid secmark that
causes guaranteed lookup failures and crashes later.

> diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
> index ea67aa92ddc2f..5a7b83c674305 100644
> --- a/net/netfilter/xt_SECMARK.c
> +++ b/net/netfilter/xt_SECMARK.c
> @@ -43,13 +43,15 @@ secmark_tg(struct sk_buff *skb, const struct xt_secma=
rk_target_info_v1 *info)
> =20
>  static int checkentry_lsm(struct xt_secmark_target_info_v1 *info)
>  {
> +	struct lsm_prop prop;
>  	int err;
> =20
>  	info->secctx[SECMARK_SECCTX_MAX - 1] =3D '\0';
>  	info->secid =3D 0;
> =20
> -	err =3D security_secctx_to_secid(info->secctx, strlen(info->secctx),
> -				       &info->secid);
> +	err =3D security_secctx_to_lsmprop(info->secctx, strlen(info->secctx),
> +					 &prop, LSM_ID_UNDEF);
> +

[Severity: High]
Similar to the issue in nft_meta.c, does this leave the prop variable
partially uninitialized on the stack?

[ ... ]

> -	err =3D security_secmark_relabel_packet(info->secid);
> +	err =3D security_secmark_relabel_packet(&prop);
>  	if (err) {
>  		pr_info_ratelimited("unable to obtain relabeling permission\n");
>  		return err;
>  	}
> =20
> +	info->secid =3D secxa_from_lsmprop(&prop);

[Severity: High]
Does this directly assign a potential negative error code to info->secid
without any error checking?

> diff --git a/security/apparmor/net.c b/security/apparmor/net.c
> index 44c04102062f3..1d33734d15594 100644
> --- a/security/apparmor/net.c
> +++ b/security/apparmor/net.c
> @@ -362,12 +363,17 @@ static int aa_secmark_perm(struct aa_profile *profi=
le, u32 request, u32 secid,
>  			   struct apparmor_audit_data *ad)
>  {
>  	int i, ret;
> +	struct lsm_prop *prop;
>  	struct aa_perms perms =3D { };
>  	struct aa_ruleset *rules =3D profile->label.rules[0];
> =20
>  	if (rules->secmark_count =3D=3D 0)
>  		return 0;
> =20
> +	ret =3D secxa_get_lsmprop(&prop, secid);
> +	if (ret)
> +		return ret;
> +
>  	for (i =3D 0; i < rules->secmark_count; i++) {
>  		if (!rules->secmark[i].secid) {
>  			ret =3D apparmor_secmark_init(&rules->secmark[i]);
> @@ -375,7 +381,7 @@ static int aa_secmark_perm(struct aa_profile *profile=
, u32 request, u32 secid,
>  				return ret;
>  		}
> =20
> -		if (rules->secmark[i].secid =3D=3D secid ||
> +		if (rules->secmark[i].secid =3D=3D prop->apparmor.label->secid ||

[Severity: High]
Does this unconditionally dereference prop->apparmor.label?

If the packet's secmark was generated by a different LSM (like SELinux
setting iptables rules), the apparmor.label field might be NULL. Could this
cause a NULL pointer dereference crash?

> diff --git a/security/lsm_secxa.c b/security/lsm_secxa.c
> index 5b67d8218fd25..2015dab01bdf4 100644
> --- a/security/lsm_secxa.c
> +++ b/security/lsm_secxa.c
> @@ -71,8 +71,6 @@ int secxa_from_lsmprop(struct lsm_prop *prop)
>  	int rc;
> =20
>  	xa_for_each(&secxa_xa, il, lp) {
> -		if (!memcmp(prop, lp, sizeof(*prop)))
> -			pr_info("%s found at index %lu\n", __func__, il);
>  		if (!memcmp(prop, lp, sizeof(*prop)))
>  			return il;
>  	}
> @@ -101,7 +99,21 @@ EXPORT_SYMBOL(secxa_from_lsmprop);

[Severity: Medium]
Is this read-allocate-insert sequence safe from concurrent updates?

Since there is no lock protecting this check-then-act block, multiple
threads processing packets with identical security contexts could
simultaneously fail the search phase and insert duplicate entries.

> +	rc =3D xa_alloc(&secxa_xa, &index, lp, xa_limit_32b, GFP_ATOMIC);

[Severity: High]
Could xa_alloc assign index 0 here?

The networking core across subsystems uses skb->secmark =3D=3D 0 as a unive=
rsal
sentinel for unlabeled packets. If index 0 is allocated to a valid context,
will those labeled packets be incorrectly evaluated as unlabeled?

[Severity: Medium]
Because xa_limit_32b allows indices up to U32_MAX, could an index larger
than INT_MAX be returned here as a negative integer, causing callers to
treat it as an error code since the function returns an int?

> +	if (rc) {
> +		kfree(lp);
> +		return -EINVAL;
> +	}
> +	*lp =3D *prop;
> +
> +	return index;
> +}

[Severity: High]
Does this introduce a race condition by assigning *lp =3D *prop after
xa_alloc() has made the pointer globally visible in the XArray?

Another thread doing a lookup might see the fully zeroed memory and use it
to label its packets before the memory is fully initialized here, leading to
incorrect policy application.

>  void secxa_set_secmark(struct sk_buff *skb, u32 secxa)
>  {
> -	if (!skb->secmark)
> +	struct lsm_prop *olp;
> +	struct lsm_prop *nlp;
> +	struct lsm_prop prop;
> +
> +	if (!skb->secmark) {
>  		skb->secmark =3D secxa;
> +		return;
> +	}
> +
> +	olp =3D xa_load(&secxa_xa, skb->secmark);
> +	nlp =3D xa_load(&secxa_xa, secxa);
> +
> +	prop =3D *olp;
> +	security_update_lsmprop(&prop, nlp, LSM_ID_UNDEF);

[Severity: Critical]
Does this safely handle xa_load() returning NULL?

If the secmark index does not exist, olp or nlp will be NULL, and the
subsequent prop =3D *olp assignment or security_update_lsmprop() call would
cause a panic.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 66f32dfadf9b3..1739dd2eb0779 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5996,10 +6014,21 @@ static unsigned int selinux_ip_forward(void *priv=
, struct sk_buff *skb,
>  		}
>  	}
> =20
> -	if (secmark_active)
> -		if (avc_has_perm(peer_sid, skb->secmark,
> +	if (secmark_active) {
> +		struct lsm_prop *prop;
> +		u32 secmark =3D 0;
> +		int err;
> +
> +		if (skb->secmark) {
> +			err =3D secxa_get_lsmprop(&prop, skb->secmark);
> +			if (!err)
> +				secmark =3D prop->selinux.secid;
> +		}
> +
> +		if (avc_has_perm(peer_sid, secmark,
>  				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
>  			return NF_DROP;
> +	}

[Severity: Medium]
If secxa_get_lsmprop() fails, secmark retains its default value of 0.
Will this cause the packet to be evaluated as unlabeled instead of being
dropped? This looks like it might act as a fallback that could bypass
restrictive policies. Similar logic applies to selinux_ip_postroute().

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cd9f5765979ff..2eddd47556c79 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4194,10 +4195,17 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *s=
kb, struct sockaddr_in6 *sip)
>  #ifdef CONFIG_NETWORK_SECMARK
>  static struct smack_known *smack_from_skb(struct sk_buff *skb)
>  {
> +	struct lsm_prop *prop;
> +	int rc;
> +
>  	if (skb =3D=3D NULL || skb->secmark =3D=3D 0)
>  		return NULL;
> =20
> -	return smack_from_secid(skb->secmark);
> +	rc =3D secxa_get_lsmprop(&prop, skb->secmark);
> +	if (prop)
> +		return prop->smack.skp;

[Severity: Critical]
If secxa_get_lsmprop() returns an error, could prop remain uninitialized on
the stack?

The if (prop) check evaluates this uninitialized stack memory, which might
evaluate to true and lead to a wild pointer dereference when accessing
prop->smack.skp.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813204854.1921=
1-1-casey@schaufler-ca.com?part=3D7
