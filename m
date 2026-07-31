Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0B411FA5
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521014; cv=none; b=CN3jQ0RWJpkaLdyrw4/Vhgw3Fk6Bdszf8PKesAuqYhDRQ3OvSI3k1aauXEUyoMu7/WoWG6WI0Y5TDUONNJFHi1Nmz1DOEwKFmHoW8Lp7Efyqt2G4KbMgbo3PanqhjWKZet/higA+KF2geripzqNMPxdajolHCEPbV3nEJz9GV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521014; c=relaxed/simple;
	bh=WLKImL5e5YsLp1JtRikfAvgxCVdjcOR/DY8mbnOYDHY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqPvVddmvQYqSkpmtYqtrfViAZqdjuCVjKPIOIXNX0rPJYWRJsAdN44eWXR8sRIEdlx0JqbvRw6MM8S12APiiXivgQkyD/s/XRFHwhlZBK/TWCdWXPYG91BNE6b2T3SJ2RdS7pacYoWvi2j7xE77ObdC2At+WQkvo56XcP8RdZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyiyxuAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyiyxuAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FF81F00AC4
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785521012;
	bh=CGkauW1SXkd9SPw8Xpsqm5U9dBfgG/G1YceEzsE5A0s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CyiyxuAZktE6eXryn+zUUR+fjxCN6kJ7tKA5aDGXM8wHQIzr3IoB7AamIFBIsaxsy
	 Jesx70tqWtV8zB8z98lKl988GXWnhQkp5GkEf79Bkrt9aKQmVf9zVOD0IIn+sCKchU
	 2iMDFvnLHjQqOu0AgA+EegP27qeDxcjPnsCqrEgSs90+3Td4rP3n/vOMrkJ584K7QD
	 2xQvLeXa8KwBLHtrDqnRFE1U6FxuKsShVKZsEQGTe9/cEiCUMqkjpD34P9FeW8YzB5
	 9wrYAJltkcRRB1DqpF6e1lYXKDSgJ6IiuIa3NnlGxbAWPvZm6kIEx28uF5GzI222BV
	 je5ufjvYEsG4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] selinux: reject an unclaimed class value in
 security_get_classes()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260731-b4-disp-d32e997b-v1-3-0341d038ee47@proton.me>
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
 <20260731-b4-disp-d32e997b-v1-3-0341d038ee47@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:03:31 +0000
Message-Id: <20260731180332.20FF81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The boolean symbol table can be sparse, leading to unconditional N=
ULL pointer dereferences in `security_get_bools()`, `security_set_bools()`,=
 and `cond_evaluate_expr()`.
--

--- Patch [3]: [PATCH 3/4] selinux: reject an unclaimed class value in secu=
rity_get_classes() ---
commit 8c3d50aa472cc225281a590fe76e7aab43766da5
Author: Bryam Vargas <hexlabsecurity@proton.me>

selinux: reject an unclaimed class value in security_get_classes()

This commit updates security_get_classes() to fail the lookup if a class
value went unclaimed. This prevents a NULL pointer dereference in
sel_make_classes() when the policy defines a sparse class symbol table.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 90e81186cb2ee..7afce975436e9 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
[ ... ]
> @@ -3316,16 +3317,29 @@ int security_get_classes(struct selinux_policy *p=
olicy,
> =20
>  	rc =3D hashtab_map(&policydb->p_classes.table, get_classes_callback,
>  			 *classes);
> -	if (rc) {
> -		u32 i;
> +	if (rc)
> +		goto err;
> =20
> -		for (i =3D 0; i < *nclasses; i++)
> -			kfree((*classes)[i]);
> -		kfree(*classes);
> +	/*
> +	 * The class symtab may be sparse, which policydb_class_isvalid() exists
> +	 * to absorb; the callback fills this array by value, so an unclaimed
> +	 * one leaves a NULL that sel_make_classes() hands to sel_make_dir().
> +	 */
> +	for (i =3D 0; i < *nclasses; i++) {
> +		if (!(*classes)[i]) {
> +			rc =3D -EINVAL;
> +			goto err;
> +		}
>  	}

[Severity: High]
This is a pre-existing issue, but since this patch handles sparse class
symbol tables, does the boolean symbol table have a similar vulnerability?

In security/selinux/ss/services.c:security_get_bools(), there is an
unconditional dereference of bool_val_to_struct:

security_get_bools() {
    ...
        (*values)[i] =3D policydb->bool_val_to_struct[i]->state;
    ...
}

Similarly in security/selinux/ss/services.c:security_set_bools():

security_set_bools() {
    ...
        int old_state =3D newpolicy->policydb.bool_val_to_struct[i]->state;
    ...
}

And in security/selinux/ss/conditional.c:cond_evaluate_expr():

cond_evaluate_expr() {
    ...
        s[sp] =3D p->bool_val_to_struct[node->boolean - 1]->state;
    ...
}

Can a malformed policy with a sparse boolean symbol table cause a NULL
pointer dereference in these locations?

>  out:
>  	return rc;
> +
> +err:
> +	for (i =3D 0; i < *nclasses; i++)
> +		kfree((*classes)[i]);
> +	kfree(*classes);
> +	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-b4-disp-d3=
2e997b-v1-0-0341d038ee47@proton.me?part=3D3
