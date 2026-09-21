Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17931813A
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998356; cv=none; b=fqPQFCqfcovnshEWO3pAiKK36KkzvUV9jTFaIAROvcWSEgjqWT/iykULrn9RklL8lmxT9L25PITiRTObQGylQ6jnpLUBn9+vwRj8UO01+cBNBKWRKhG33BMiXJEbv5nDAXGfsLKTTdBpQoE0OZSsGaytyjjuyW5WzNQq1vfKnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998356; c=relaxed/simple;
	bh=dlTJlzWJ3CNTNB2dY1Ffp4X4cB5fPH3lyDgrpE7FNYA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QwqEZHfYNrdrewiWET1MpYykq8GnIPykbi+sYDpdv8U4jiZ7c7R9IyS8yYi3c5/x1iU71IWi9oFi23oxWLebyalEM089KqbQkj6vMfn0DxRmk/X2bnUm9IKwumC5yjem9VWF9HS0lqtJPhROntNZWfrOG5Vaev78PkcQLmLNXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFykbg0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFykbg0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D051F000FF
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998354;
	bh=2jTnWj+k1s1CNJ+2kWqeaGNG8QXJTAXs0AnWXEBnWVM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LFykbg0amiszL0AvLmu6+uaR62r5XPSexrjrEwZmKm3yI25oDyqDNxUyPgP+Dy2cy
	 S83QiudVZh0EeUM4BZW84njSFVVwpSK6uuOlh0Wlo6q/BRUGO62SwVKcmScvIwPApU
	 dgNyoSGWEsQt7wEoPqO4X5zImMlImL8hK8xTcfMVuQdpl5RXEVRWj5WEuV93xqIo5u
	 rvreqgyv5bhCFe2kz3NNeqFmbC03ZQ7/noYc6S0ls56ZM3Y+UlU0p1w6MRYoQ04CNX
	 w3JTlYvNBvYbePvSkaEmGGEPSEO9sMg6MjDD79keegacrIZhSRp8Jd4yLh/+SSwFOJ
	 nwcyyS4BFc/nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] selinux: implement namespace_init and
 namespace_install hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260921132825.17526-1-stephen.smalley.work@gmail.com>
References: <20260921132825.17526-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:45:53 +0000
Message-Id: <20260921134554.15D051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] selinux: missing SECINITSID_KERNEL fallback for initial namespaces=
 in setns
- [Medium] selinux: audit logs report zero ns_id during namespace creation
--

commit 7cfaed9361f973ecdd7fd2e074c01074e97b7cd5
Author: Daniel Durning <danieldurning.work@gmail.com>

selinux: implement namespace_init and namespace_install hooks
   =20
This commit adds implementations for the namespace_init and
namespace_install hooks to control namespace creation and setns
operations via SELinux. It defines new security classes for different
namespace types and saves the creator's SID in the namespace security
blob for validation.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f2394cf6646e5..cd7ec2c90d1d0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

[ ... ]

> @@ -7184,6 +7211,41 @@ static int selinux_inode_getsecctx(struct inode *i=
node, struct lsm_context *cp)
>  	cp->id =3D LSM_ID_SELINUX;
>  	return 0;
>  }
> +
> +static int selinux_namespace_init(struct ns_common *ns)
> +{
> +	struct common_audit_data ad;
> +	struct ns_security_struct *nssec =3D selinux_ns(ns);
> +	u16 sclass =3D ns_type_to_security_class(ns);
> +	u32 sid =3D current_sid();
> +
> +	ad.type =3D LSM_AUDIT_DATA_NS;
> +	ad.u.ns.ns_type =3D ns->ns_type;
> +	ad.u.ns.ns_id =3D ns->ns_id;

[Severity: Medium]
Will this audit log record an ns_id of 0 for all namespace creation events?

During namespace creation, ns_common_init() initializes ns->ns_id to 0 and
immediately calls security_namespace_init(). The actual namespace ID isn't
assigned until ns_tree_gen_id() is called later in the lifecycle.

Because selinux_namespace_init() reads ns->ns_id before it is assigned, does
this leave the audit logs ineffective for correlating namespace lifecycle
events?

> +
> +	nssec->sid =3D sid;
> +	if (ns->inum =3D=3D MNT_NS_ANON_INO)
> +		return avc_has_perm(sid, sid, sclass,
> +					MNT_NAMESPACE__CREATE_ANON, &ad);
> +
> +	return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, &ad);
> +}
> +
> +static int selinux_namespace_install(const struct nsset *nsset,
> +				  struct ns_common *ns)
> +{
> +	struct common_audit_data ad;
> +	struct ns_security_struct *nssec =3D selinux_ns(ns);
> +	u16 sclass =3D ns_type_to_security_class(ns);
> +	u32 sid =3D current_sid();
> +
> +	ad.type =3D LSM_AUDIT_DATA_NS;
> +	ad.u.ns.ns_type =3D ns->ns_type;
> +	ad.u.ns.ns_id =3D ns->ns_id;
> +
> +	return avc_has_perm(sid, nssec->sid, sclass, NAMESPACE__SETNS, &ad);

[Severity: High]
Is the fallback to SECINITSID_KERNEL missing here?

The commit message states: "We fall back to SECINITSID_KERNEL if ns_common =
is
pointing to an init namespace, since these are created before policy load a=
nd
will be lacking a security blob."

However, this line unconditionally dereferences nssec->sid. If setns() targ=
ets
an initial namespace (where ns->ns_security might be uninitialized or NULL),
could this result in a NULL pointer dereference or an evaluation against
SECINITSID_UNLABELED instead of SECINITSID_KERNEL?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921132825.1752=
6-1-stephen.smalley.work@gmail.com?part=3D1
