Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D84A499A
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387319; cv=none; b=i9hk7Ut5fle0pdxkjaSYLZr2fx38xxpm5nFnSag1c1qQzvKe6F2t0RKoccvNqZZCLHNGjL5mpaPkBrWtOzyqIOllh1ZKEMtS/axl5CXwkGx7x/Qnek4P1Ptm9ujXMaAszDUQlPo6GDbY5LYV8MCf5cp5uSq85YvlDW+PQnpkNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387319; c=relaxed/simple;
	bh=4xa7Gh3kMhvGiZnvF6Jaz62AwOhT9FN/Vt+8P4Tq3QQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kxywKIR4s/dEuMYaziJ0rZ/dW3PPPE1thg7dLsEYFsWP8Qbx0jdEdCf/7bBXAN4y9jd1fgBO9agKtiRykqnh+Pgop8GamUqhAwDyMG3kb1OITFBdgybmfu0U6kgCqHDuCVLsWmqocrsWeL0P+s4BuFUt0SHmxXcbeddA1AMLWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3ipxoGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3ipxoGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656D21F000E9
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 22:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387314;
	bh=oct2nji69rJBel2biXyPFQ4d4b3ZkMob3qmjLGQiWEs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=W3ipxoGbXW0K8t+e7k9GR0apSnvv+JAMDVYYmeSww9ZkPdPn5EZgAJS0+SsWEp+Uf
	 rm46/p247kr9cIqhvCh18Ms6bPgl2juLAcxe0JWSBxSzd7CexZjzAHgFXkgIqeWJty
	 cxTb9uwkPKQDjyGDx2F4gge3jhG5BLqB35eMV1AzCgnGL4GvmXFQZgRiBdPGJd5qS4
	 ALtEk8uEnWiWPsTtBsRZl9NvwFp3a1SCB3iCIlStbsW87kFGy1wVRkLAOC8S5QCYL3
	 YpRSf5acTZY+A15WOapNA030ym4NoG9fVcbPndiF1M44K4oR1illRt894AAyl4zBbP
	 DIJIThrvEnU3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] net, lsm: Change skb secmarks to x-array indexes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260902220150.18586-8-casey@schaufler-ca.com>
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-8-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 22:15:13 +0000
Message-Id: <20260902221514.656D21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] The function smack_from_skb() checks an uninitialized pointer =
instead of the error code after calling secxa_get_lsmprop(), leading to a w=
ild pointer dereference.
- [Critical] The first lsm_prop entry will be allocated ID 0, which is trea=
ted as 'no secmark', bypassing security checks.
- [Critical] AppArmor's secmark hook unconditionally dereferences `prop->ap=
parmor.label`, which can be NULL if the entry was created by another LSM.
- [High] secxa_set_secmark() unconditionally dereferences pointers returned=
 by xa_load() without checking for NULL.
- [High] Stack-allocated `struct lsm_prop` variables are passed uninitializ=
ed to `secxa_from_lsmprop()`, causing `memcmp()` to read stack garbage, res=
ulting in deduplication failure and memory leaks.
- [High] A TOCTOU race condition in secxa_from_lsmprop causes duplicate xar=
ray entries and memory leaks under concurrent load.
- [High] Per-packet O(N) linear scan over the global secmark xarray introdu=
ces a massive performance bottleneck and DoS vector.
- [Medium] Missing garbage collection for dynamically allocated `secxa_xa` =
xarray entries causes a permanent memory leak.
--

commit a49336f616a25ecd3f9284efec92c647cceaa92a
Author: Casey Schaufler <casey@schaufler-ca.com>

net, lsm: Change skb secmarks to x-array indexes
   =20
Maintain a xarray of lsm_prop structures which represent the
LSM security information passed via skb->secmark. Pass the xarray
index of the appropriate lsm_prop (the secxa) instead of an LSM
specific secid. Allow multiple LSMs to specify their components
in xarray entries, or create new entries as necessary.

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

[Severity: High]
Can this pass an uninitialized stack variable to memcmp?

tmp_prop is allocated on the stack but not zero-initialized.
security_secctx_to_lsmprop populates only the active LSM's fields, leaving
the remainder of the struct as stack garbage. When secxa_from_lsmprop is
subsequently called, it uses memcmp on the entire struct. The stack garbage
will cause the strict binary comparison to fail, failing to match identical
logical entries and forcing a new allocation every time.

> +	u32 secxa =3D 0;
>  	int err;
> =20
> -	err =3D security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_sec=
id);
> +	err =3D security_secctx_to_lsmprop(priv->ctx, strlen(priv->ctx),
> +					 &tmp_prop, LSM_ID_UNDEF);

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

[Severity: High]
Is this stack variable prop also uninitialized?

It appears to suffer from the exact same memcmp garbage-read issue described
in nft_secmark_compute_secid.

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

[ ... ]

> +	err =3D secxa_from_lsmprop(&prop, &info->secid);

[Severity: Critical]
Could this inadvertently bypass security checks for the first loaded rule?

Since secxa_from_lsmprop allocates an index using xa_limit_31b
([0, 0x7fffffff]), the very first allocated entry will receive index 0.
Throughout the networking and LSM stacks, a secmark value of 0 is explicitly
treated as no secmark. This means the first secmark rule loaded into the
system will silently fail to enforce security marks on matching traffic.

[Severity: High]
Is there a memory leak and duplicate xarray entry issue when called
concurrently?

secxa_from_lsmprop performs a lockless check-then-act sequence: it searches
the xarray, and if no match is found, allocates and inserts a new entry. If
multiple threads process the same new lsm_prop concurrently, they can all
observe a miss and insert their own duplicate entries at different indices.

[Severity: Medium]
Will this dynamically allocated xarray entry permanently leak memory?

secxa_from_lsmprop dynamically allocates new entries via kzalloc and adds
them to the global xarray, but there appears to be no corresponding mechani=
sm
(like xa_erase and kfree) to remove and free these entries when the
associated netfilter rules are deleted.

> +	if (err) {
> +		pr_info_ratelimited("unable to obtain secmark\n");
> +		return err;
> +	}
> +
>  	security_secmark_refcount_inc();
>  	return 0;
>  }

[ ... ]

> diff --git a/security/apparmor/net.c b/security/apparmor/net.c
> index cf590dd08540c..e26e15c2d9473 100644
> --- a/security/apparmor/net.c
> +++ b/security/apparmor/net.c
> @@ -378,7 +384,7 @@ static int aa_secmark_perm(struct aa_profile *profile=
, u32 request, u32 secid,
>  				return ret;
>  		}
> =20
> -		if (rules->secmark[i].secid =3D=3D secid ||
> +		if (rules->secmark[i].secid =3D=3D prop->apparmor.label->secid ||

[Severity: Critical]
Might this unconditionally dereference a NULL pointer?

If an skb is labeled by an LSM other than AppArmor (e.g., SELinux or Smack),
the lsm_prop entry in the xarray will have a NULL apparmor.label. When
AppArmor evaluates this packet, it will unconditionally access
prop->apparmor.label->secid and cause a kernel panic.

>  		    rules->secmark[i].secid =3D=3D AA_SECID_WILDCARD) {
>  			if (rules->secmark[i].deny)
>  				perms.deny =3D ALL_PERMS_MASK;

[ ... ]

> diff --git a/security/lsm_secxa.c b/security/lsm_secxa.c
> index ccbe78095d703..f0702ac5601dd 100644
> --- a/security/lsm_secxa.c
> +++ b/security/lsm_secxa.c
> @@ -103,7 +103,25 @@ EXPORT_SYMBOL(secxa_from_lsmprop);
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
Are the pointers from xa_load dereferenced without checking for NULL?

If skb->secmark or secxa is an invalid xarray index, xa_load will return
NULL. The function immediately dereferences olp (prop =3D *olp) and passes
nlp to security_update_lsmprop, which also dereferences it, resulting in a
kernel panic.

> +	security_update_lsmprop(&prop, nlp, LSM_ID_UNDEF);
> +
> +	rc =3D secxa_from_lsmprop(&prop, &tsecxa);
> +	if (!rc)
> +		skb->secmark =3D tsecxa;
>  }
>  EXPORT_SYMBOL(secxa_set_secmark);

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

[Severity: Critical]
Are we checking an uninitialized pointer instead of the error code here?

If an skb has a non-zero secmark that is not found in the xarray,
secxa_get_lsmprop returns an error without initializing prop. The code
ignores rc and checks if prop is valid. This will evaluate uninitialized
stack memory and potentially cause a wild pointer dereference when accessing
prop->smack.skp.

> +
> +	return NULL;
>  }

[ ... ]

> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netf=
ilter.c
> index b363c42f252e8..0378f74aa22bc 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -24,13 +24,17 @@ static unsigned int smack_ip_output(void *priv,
>  				    struct sk_buff *skb,
>  				    const struct nf_hook_state *state)
>  {
>  	struct sock *sk =3D skb_to_full_sk(skb);
> +	struct lsm_prop prop =3D { };
>  	struct socket_smack *ssp;
> -	struct smack_known *skp;
> +	u32 secxa;
> +	int rc;
> =20
>  	if (sk) {
>  		ssp =3D smack_sock(sk);
> -		skp =3D ssp->smk_out;
> -		secxa_set_secmark(skb, skp->smk_secid);
> +		prop.smack.skp =3D ssp->smk_out;
> +		rc =3D secxa_from_lsmprop(&prop, &secxa);

[Severity: High]
Will this introduce a massive performance bottleneck on the outbound network
fast-path?

For every outbound packet, smack_ip_output calls secxa_from_lsmprop. Because
secxa_from_lsmprop linearly scans the entire global secxa_xa xarray using
xa_for_each to find a match, this could cause severe performance degradation
and high CPU usage under network load.

> +		if (!rc)
> +			secxa_set_secmark(skb, secxa);
>  	}
> =20
>  	return NF_ACCEPT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902220150.1858=
6-1-casey@schaufler-ca.com?part=3D7
