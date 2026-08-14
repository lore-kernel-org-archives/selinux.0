Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585E2459EA
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674207; cv=none; b=Fz2MOH83/c/lHAGtJZLMUd5M6oUw7KiZR4veLjwJh3AWXkF6T07UGUgdAhSbosdIKWd2PpLvcqyiPzWdI2CEZYmEARpP5gcKM4orWjnrXls4/1WHqgDWHs8GIaY7n+ZY4wclkYPSkSDMrmkCP7BeDKY9Mvg56p1IiOqqQp7UqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674207; c=relaxed/simple;
	bh=PuceYZMX584szq1sgOmXDx4cnzxGl5pBQQcQC4N8n/c=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OeTdsBsV1hOPFGMfIB7ww/BSg4NEEA+OaWl/m+RnZ9obbju7Xl1mz3ORIynjBZWVKteHCj51dRatuCWxY/7ETj5ir2pdhAMzZ658MaRFCebqrpOYG2oCmC6eXWxOdZLjkNwlXPhkwNhSVJt/9hr43pDa0WHbelU/eGddPAn53Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ/qVs7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ/qVs7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0081F000E9
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 02:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786674205;
	bh=aQPjYrlLk1nTKzqra3BL4Tv2OZJ4THV+khJT2PMmrfM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IZ/qVs7X0mF329HCLKCLXOzVUaHEtliyvEiz8NtTRqvuQ25LH1L35OCiAF5a3FLkb
	 QEVdgoEoacoR02qxdhwl/QwYCgly9F1GbW0C2JQy8RC65yeW597g1KbJHZuhx14TBS
	 Y7g6avdM44JYfvycszWuEbuS9h2wGy5awHQ43B3It+dK9mnB8yadrFuCCewiF+nVoo
	 vrZE++eMJ1M+L4hj92icyYasoeskrDxAt/gjiNN1+D0w2qJDgo8BpnUfIt9/bSBT1E
	 S867s12rn/qwr2xwKLlxwRF7Pf8N1Gxzg7kEUjjxMWGD1QJOobcMBAHvtob1cehcUi
	 ZI/HHcfbiBgQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] Apparmor: hooks for secctx_to_lsmprop and
 update_lsmprop
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260813204854.19211-7-casey@schaufler-ca.com>
References: <20260813204854.19211-1-casey@schaufler-ca.com>
 <20260813204854.19211-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:23:25 +0000
Message-Id: <20260814022325.BA0081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] apparmor_secctx_to_lsmprop leaks a reference count on the parsed a=
a_label, exposing a fundamental design conflict with lsm_prop.

Pre-existing issues:
- [High] Preexisting memory leak in apparmor_secctx_to_secid when extractin=
g the secid from a parsed aa_label.
--

--- Patch [6]: [PATCH 6/7] Apparmor: hooks for secctx_to_lsmprop and update=
_lsmprop ---
commit 81357db42de4a31531a31239f8d75a01c866a80e
Author: Casey Schaufler <casey@schaufler-ca.com>

Apparmor: hooks for secctx_to_lsmprop and update_lsmprop

This commit implements the secctx_to_lsmprop and update_lsmprop LSM
hooks for AppArmor. It adds the capability to convert a security
context string into a struct lsm_prop containing an AppArmor label.

> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 28caf66b90335..51f3e4ab053e5 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -106,6 +106,29 @@ int apparmor_secctx_to_secid(const char *secdata, u3=
2 seclen, u32 *secid)
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does apparmor_secctx_to_secid leak the
label reference?

When aa_label_strn_parse is called, it allocates or refcounts an aa_label.
The secid is extracted, but it appears aa_put_label is never called
before returning, causing a memory leak that could be triggered by an
unprivileged user with CAP_NET_ADMIN in a user or network namespace.

> +int apparmor_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +			       struct lsm_prop *prop)
> +{
> +	struct aa_label *label;
> +
> +	label =3D aa_label_strn_parse(&root_ns->unconfined->label, secdata,
> +				    seclen, GFP_KERNEL, false, false);
> +	if (IS_ERR(label))
> +		return PTR_ERR(label);
> +	prop->apparmor.label =3D label;
> +
> +	return 0;
> +}

[Severity: High]
Does this code leak the refcount on the parsed aa_label?

Similar to the above issue, aa_label_strn_parse returns a refcounted label,
but struct lsm_prop does not seem to have a mechanism to release it.

Furthermore, since struct lsm_prop acts as an unmanaged container (as seen
in apparmor_update_lsmprop performing a raw pointer copy), if we were
to drop the reference here, wouldn't prop->apparmor.label become a dangling
pointer, leading to a use-after-free?

> +int apparmor_update_lsmprop(struct lsm_prop *dest, struct lsm_prop *src,
> +			    int lsmid)
> +{
> +	if (lsmid =3D=3D LSM_ID_APPARMOR || lsmid =3D=3D LSM_ID_UNDEF)
> +		dest->apparmor.label =3D src->apparmor.label;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813204854.1921=
1-1-casey@schaufler-ca.com?part=3D6
