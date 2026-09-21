Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6D2BE053
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998512; cv=none; b=uSlFQQag2S6cU08bb/KaaWcYJxkMq5icLIbxtXDQFTeOqjFxYkD3AwkkSYywTt9cEIEDo1DhuUM03oUYBTtx/K9NdaDL4BLU6dFkL/QBteWDcozmZw5sJzhZw6rehFFldpB2n54sQIN0JlOBbDxR7eVNf1j6lPeJ4lQXqtizGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998512; c=relaxed/simple;
	bh=ZjclHJnoJY65G2yeExN9IyvpUqiKqYSTR5kQRjxjkyM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BB22EOVK1nGLiPjJW0WFQUScb++9JKzr2HpfpF5p0Wfj5uqIjRwzaOcvCYgIZKj3xgMAX2CKiQE5QpM8iRykfKfNGFnAq/T4v2U2wMbte8i5VlOTZ6Aau4+SPeoZALNkZsACN3NozAVJCJ4lamP8i99kZNYY2VjdpQ2mgS/EZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzTl4NXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzTl4NXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFE41F000FF
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998510;
	bh=pRYfSxaJf8sCvIshtSmfUlGj7VYdIu8O71vRW3yu06A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gzTl4NXdsN/04Y4hzyDWRkHXPiJ1n3j4UfOs1RoixqaVQ7V7ROxVTf6qRrmpbMMOt
	 0KZPazfE7xS1gUK/+n+5uPHOMoj1zf6RMeiBThyB2XzG1MDbGx6hZA6Q0MVeCwh8Li
	 cBZbRxo8JbhBdreMyXmHjgHTq4dEFzi/hzaA8elQ235mETi4boWruFYfSLRt0Q9Mkp
	 MQO6wfpZgmowO5FzCHumt49l8kTntgkmR1QoyJf0pdBjCRgY0P9zGXCQ1TZLT8/wM2
	 1qXHc2z1CQo5t65kfSwVZkSnaXGCnCf07ASl8tKybKZXSbXj92SP4UN1ZYSpYpod5N
	 TISAzGWE7Stlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] selinux: implement namespace_init and
 namespace_install hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260921133145.17768-2-stephen.smalley.work@gmail.com>
References: <20260921133145.17768-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:48:30 +0000
Message-Id: <20260921134830.ADFE41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selinux: audit log records ns_id=3D0 for all namespace creations
--

commit ee58aea3229beb02443b58cad2bfbb58dd22830b
Author: Daniel Durning <danieldurning.work@gmail.com>

selinux: implement namespace_init and namespace_install hooks

Add implementations of the namespace_init and namespace_install
hooks for SELinux. Corresponding permissions are defined for each
hook (create and setns, respectively).

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
Will this regression result in the audit log systematically recording an
ns_id of 0 for every namespace creation?

Looking at __ns_common_init() in kernel/nscommon.c, it initializes ns->ns_id
to 0 just before the security_namespace_init() hook is invoked:

kernel/nscommon.c:__ns_common_init() {
	ns->ns_id =3D 0;
	ns->ns_type =3D ns_type;
	...
	ret =3D security_namespace_init(ns);
}

The actual namespace ID appears to be generated only after the namespace
infrastructure finishes invoking the security hooks. For example, in
alloc_mnt_ns() in fs/namespace.c:

fs/namespace.c:alloc_mnt_ns() {
	if (anon)
		ret =3D ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
	else
		ret =3D ns_common_init(new_ns);
	if (ret) {
		kfree(new_ns);
		dec_mnt_namespaces(ucounts);
		return ERR_PTR(ret);
	}
	ns_tree_gen_id(new_ns);
}

Could this timing behavior prevent properly correlating namespace creation
events with subsequent actions in the security audit logs, since the actual
ID isn't assigned until after the audit record is generated?

> +
> +	nssec->sid =3D sid;
> +	if (ns->inum =3D=3D MNT_NS_ANON_INO)
> +		return avc_has_perm(sid, sid, sclass,
> +					MNT_NAMESPACE__CREATE_ANON, &ad);
> +
> +	return avc_has_perm(sid, sid, sclass, NAMESPACE__CREATE, &ad);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921133145.1776=
8-2-stephen.smalley.work@gmail.com?part=3D1
