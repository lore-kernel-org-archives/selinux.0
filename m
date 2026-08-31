Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE83C0A1F
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217638; cv=none; b=Y2aCPMDwr4hQmcgzDB+vhShtgcq/XSN4Q9qViAPPEWYb/4dYPHaoqY4u29gSXosHg1GaU1c/MyBS4I5x23h50x+/eeho6kC16+lbVvhzhB9m8jHhsmqa4vVjLf4xqioL1Y/uqsdeDU3b4joT0ah9FSHG6bIf7wkHY2FEt5RomtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217638; c=relaxed/simple;
	bh=u1sCfyozAocUVnGkl39En5oNdEqXFhbFOHW+g8ncZKM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vdda3aH1ewqoUkZIs5hiwV863ThAOSfTVtC7m3i+GdF6CO6rMZoK44TJfeyuiiMHj3oq+QCMRgSBY43BKmN3YY8wHMg92icqUhnGsyQl5p7QanTjhJOO5/k3XQRd+KLysRoax0E2yPVQDEeOidaRdBwMY8wG6ZNz3gsN0Xf4vyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixo2Byze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixo2Byze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400E81F000E9
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217636;
	bh=0p0w0VnFPbbDBhUuOE7oCWrKWH9qPubBHqiA/lChSGE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ixo2ByzegVdkXkLTRm/CXkGYO0Q31LsEjg4m4Ek074i9QJBW9orDRgQxCVQouYtnn
	 4UEy1tXLmk2Ykgpdr9JIXj3+N1bvg84Gj/jT7XE99/RRF7IIwcuu994/5RacpqI7XQ
	 uBsGm3xGI4X7bkjDMpSmPNEhqJgarnRJCHp7sxIyYRojw4G2ALyMcQ+lvqwG0USJCP
	 9un/ca2VuYn1AIR8vdqiaDmjfSx5nKJkJABXb+th2Vn1tVcyTRhPZbR52JoXgNYcOU
	 dAkRt+hCGgOBOrFVeL+jh+S9I1hAXhgFofbO+JvYYm449cEQ8Vfug3GgKsE6It4JYS
	 f8c++iQCt4Pdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] net, lsm: Change skb secmarks to x-array indexes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260831223748.4304-8-casey@schaufler-ca.com>
References: <20260831223748.4304-1-casey@schaufler-ca.com>
 <20260831223748.4304-8-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:07:15 +0000
Message-Id: <20260831230716.400E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Uninitialized stack memory in `struct lsm_prop` causes duplicate x=
array insertions and potential kernel stack leaks.
- [High] Unconditional NULL pointer dereference in `secxa_set_secmark` on i=
nvalid secmarks.
- [High] UAPI Breakage / Type Confusion in Netfilter conntrack secmark dump=
s.
- [High] Unconditional NULL pointer dereference in AppArmor secmark evaluat=
ion.
- [High] Uninitialized pointer dereference in `smack_from_skb` due to ignor=
ed error code.
- [Medium] Check-then-act (TOCTOU) race condition in `secxa_from_lsmprop`.
- [Low] Syntax error due to stray `CBS` tokens in `secxa_from_lsmprop`.
--

commit c9d03ed061e68de8297b30e74360121ca809d4cc
Author: Casey Schaufler <casey@schaufler-ca.com>

net, lsm: Change skb secmarks to x-array indexes

This commit changes skb->secmark to store an xarray index representing an
lsm_prop structure instead of a direct LSM secid. It updates various netfil=
ter
modules and LSM hooks to translate between this index and the underlying
security properties.

> Maintain a xarray of lsm_prop structures which represent the
> LSM security information passed via skb->secmark. Pass the xarray
> index of the appropriate lsm_prop (the secxa) instead of an LSM
> specific secid. Allow multiple LSMs to specify their components
> in xarray entries, or create new entries as necessary.
>
> Change uses of security_secctx_to_secid() to security_secctx_to_lsmprop()
> in the netfilter and iptables code. Change security_secmark_relabel_packe=
t()
> to accept an lsm_prop pointer rather than a secid. Change secxa_set_secma=
rk()
> to update and create new entries as necessary.

[Severity: High]
Are there missing updates for connection tracking? The commit updates
netfilter and iptables code, but it appears conntrack dumps via netlink
(ctnetlink_dump_secctx) and procfs (seq_print_acct) still pass ct->secmark
directly to security_secid_to_secctx(). Since the secmark is now an xarray
index rather than an LSM secid, won't this result in invalid memory lookups
and broken userspace dumps?

[ ... ]

> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index bd0f7a0931f44..664191dfa4b29 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -927,21 +927,24 @@ static const struct nla_policy nft_secmark_policy[N=
FTA_SECMARK_MAX + 1] =3D {
> =20
>  static int nft_secmark_compute_secid(struct nft_secmark *priv)
>  {
> -	u32 tmp_secid =3D 0;
> +	struct lsm_prop tmp_prop;
> +	u32 secxa =3D 0;
>  	int err;
> =20
> -	err =3D security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_sec=
id);
> +	err =3D security_secctx_to_lsmprop(priv->ctx, strlen(priv->ctx),
> +					 &tmp_prop, LSM_ID_UNDEF);

[Severity: High]
Can this leak uninitialized stack memory into the xarray cache? The tmp_prop
structure is declared on the stack without zeroing. When
security_secctx_to_lsmprop() populates it, it may only write to the specific
active LSM's fields, leaving the padding and other fields uninitialized.
Later, when secxa_from_lsmprop() performs a memcmp on this struct, the
uninitialized stack garbage will prevent matches on identical labels and ca=
use
boundless duplicate entries to be allocated.

[ ... ]

> diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
> index ea67aa92ddc2f..05b023a7c5760 100644
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
Similar to the issue in nft_secmark_compute_secid(), does this code also pa=
ss
an uninitialized struct lsm_prop to security_secctx_to_lsmprop()? This looks
like it could cause the same memcmp failures and duplicate xarray allocatio=
ns.

[ ... ]

> diff --git a/security/apparmor/net.c b/security/apparmor/net.c
> index cf590dd08540c..e26e15c2d9473 100644
> --- a/security/apparmor/net.c
> +++ b/security/apparmor/net.c
> @@ -365,12 +366,17 @@ static int aa_secmark_perm(struct aa_profile *profi=
le, u32 request, u32 secid,
>  			   struct apparmor_audit_data *ad)
>  {
[ ... ]
> +	ret =3D secxa_get_lsmprop(&prop, secid);
> +	if (ret)
> +		return ret;
> +
>  	for (i =3D 0; i < rules->secmark_count; i++) {
>  		if (!rules->secmark[i].secid) {
>  			ret =3D apparmor_secmark_init(&rules->secmark[i]);
> @@ -378,7 +384,7 @@ static int aa_secmark_perm(struct aa_profile *profile=
, u32 request, u32 secid,
>  				return ret;
>  		}
> =20
> -		if (rules->secmark[i].secid =3D=3D secid ||
> +		if (rules->secmark[i].secid =3D=3D prop->apparmor.label->secid ||

[Severity: High]
Will this unconditionally dereference a NULL pointer if the packet was labe=
led
by a different LSM? If another LSM (like SELinux) populated the lsm_prop
structure but AppArmor did not, prop->apparmor.label would be NULL, causing
a panic when accessing its secid field.

[ ... ]

> diff --git a/security/lsm_secxa.c b/security/lsm_secxa.c
> index 361ce6770edc4..7ad6a6711f881 100644
> --- a/security/lsm_secxa.c
> +++ b/security/lsm_secxa.c
> @@ -99,7 +99,25 @@ EXPORT_SYMBOL(secxa_from_lsmprop);
>   */
>  void secxa_set_secmark(struct sk_buff *skb, u32 secxa)
>  {
> -	if (!skb->secmark)
> +	struct lsm_prop *olp;
> +	struct lsm_prop *nlp;
> +	struct lsm_prop prop;
> +	u32 tsecxa;
> +	int rc;
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

[Severity: High]
Can xa_load() return NULL here and cause an unconditional NULL pointer
dereference? If network packets arrive with an invalid or untrusted secmark,
the xarray lookup could fail. Does this code need to check if olp and nlp
are valid before dereferencing them?

[ ... ]

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fcfadd5d99941..79140e6829a47 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4189,10 +4190,17 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *s=
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

[Severity: High]
Does this code ignore the return value of secxa_get_lsmprop() and evaluate
an uninitialized pointer? If the lookup fails, prop remains uninitialized
and checking if (prop) will evaluate stack garbage, potentially leading to
a wild pointer dereference when accessing prop->smack.skp. Should this check
if (!rc) instead?

[ ... ]

Additionally, in the new secxa_from_lsmprop() function introduced in this
series:

[Severity: Low]
Is there a syntax error here that will prevent the kernel from compiling?

security/lsm_secxa.c:secxa_from_lsmprop() {
    ...
    xa_for_each(&secxa_xa, il, lp) {
        if (!memcmp(prop, lp, sizeof(*prop))) {
            *secxa =3D il; return 0; CBS }
                                   ^^^
The CBS token appears to be a stray undeclared identifier at the end of the
return statement.

[Severity: Medium]
Is there a check-then-act (TOCTOU) race condition during concurrent xarray
insertions?

security/lsm_secxa.c:secxa_from_lsmprop() {
    ...
    xa_for_each(&secxa_xa, il, lp) {
        if (!memcmp(prop, lp, sizeof(*prop))) {
            *secxa =3D il; return 0;
        }
    }
    ...
    rc =3D xa_alloc_bh(&secxa_xa, &index, lp, xa_limit_31b, GFP_ATOMIC);
    ...
}

The lockless xa_for_each search and the subsequent xa_alloc_bh insertion
are not atomic. If two threads check for the same property simultaneously,
could they both fail the initial check and blindly insert duplicates into
the xarray cache?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831223748.4304=
-1-casey@schaufler-ca.com?part=3D7
