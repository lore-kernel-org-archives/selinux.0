Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0F4457BA
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520889; cv=none; b=CPqRYE/Y52vsVxIz4SAKiMUQH51YbyHNIhyO73AuwFTMlRvNldlEgHdxoG/BOAE3JV0Vxzkch/yk3SRCIwYokwHmdvDYMWlD7hEEGbyPoQdUeAbYtFieV27SIxCM4otYrJRE3p1iiPWS9+jrDCkgQIXg/H5jbOMOXW705D0+tsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520889; c=relaxed/simple;
	bh=Y8FIqPr+UsrwQ/ex7mUldzJfIh8d3K/7pUuZTg7e3Ss=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i9NDgdEAJpBSp4MfwI9ZtcjGllfHry/MAKAsD1oLJi4DXpOefgzWyA4eci/CBl6QAmN13oUrlJQ6x68SRe1tPF9pVACCLwnC8v5KpZM7TOl6/96GKM33dtRREzdDfshHszeWoROQAYN2suVGF/J3n/1Fn4/emIeXTBX/pnel+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl7RgwUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl7RgwUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92F21F00AC4
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785520888;
	bh=SEvmVMWCxutnbbwvUX2Cq+3RrWqz3vagl/rhGg50Tk0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Rl7RgwUTTswVV5t0Ary9Nu1gT12n1hJBb4B45QtpdP5KdMNgI+SlfQw93n3BNwvZu
	 zLZDboW0FQea7lVJiQhNqkvCyVCeaFGYF5knUtBX75y5S502UX/AUJ0+wDXt9DPnVM
	 CaNH58L26k1UInWpHVkLz0NZxx7gXqqWCP3yV4gven56AamCpd0tdlyl2dGF3z5qE3
	 GqriBOkDQmUqWj2U1HDvY/mwSR8hIY/Ba+KpeS2T6PzyZRdRzM1PW716Bci4InhnJ7
	 bpXflQ41FwOcYbGxhX315tglj68tBfzx411EIMhmZmw759gnGW1Y5tNx35kHcBCD/Y
	 avSbTlMBCOBXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] selinux: require every boolean value to be defined
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260731-b4-disp-d32e997b-v1-4-0341d038ee47@proton.me>
References: <20260731-b4-disp-d32e997b-v1-0-0341d038ee47@proton.me>
 <20260731-b4-disp-d32e997b-v1-4-0341d038ee47@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:01:27 +0000
Message-Id: <20260731180127.D92F21F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation for sparse types and users in `policydb_context=
_isvalid()` allows a crafted SELinux policy to trigger kernel panics.
--

--- Patch [4]: [PATCH 4/4] selinux: require every boolean value to be defin=
ed ---
commit 44c8d8193cd1a1c62c2bebd114870d7131ceb5ab
Author: Bryam Vargas <hexlabsecurity@proton.me>

selinux: require every boolean value to be defined

This commit adds validation during SELinux policy loading to ensure every
declared boolean is defined. This prevents NULL pointer dereferences when
consumers iterate over the bool_val_to_struct array.

Cc: stable@vger.kernel.org

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index d358200817bd9..d88713201be92 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c

[ ... ]

> @@ -769,6 +770,24 @@ static int policydb_index(struct policydb *p)
>  		if (rc)
>  			goto out;
>  	}
> +
> +	/*
> +	 * A sparse class value is absorbed by policydb_class_isvalid() and
> +	 * its siblings, but no such predicate exists for booleans: every
> +	 * user of bool_val_to_struct[] walks it by index and dereferences
> +	 * each entry -- cond_evaluate_expr(), the two getters and
> +	 * security_set_bools() -- so an unclaimed one has no consumer that
> +	 * can tolerate it.
> +	 */
> +	for (v =3D 0; v < p->p_bools.nprim; v++) {
> +		if (!p->bool_val_to_struct[v]) {
> +			pr_err("SELinux:  boolean %u is declared but not defined\n",
> +			       v + 1);
> +			rc =3D -EINVAL;
> +			goto out;
> +		}
> +	}
> +

[Severity: High]
This is a pre-existing issue, but since this patch adds validation for
sparse booleans, is it necessary to add similar validation for sparse types
and users?

Context validation skips checking if the type is actually defined when
c->role =3D=3D OBJECT_R_VAL:

security/selinux/ss/policydb.c:policydb_context_isvalid() {
    ...
    if (!c->type || c->type > p->p_types.nprim)
        return false;

    if (c->role !=3D OBJECT_R_VAL) {
    ...
}

If a crafted policy assigns a sparse type to an object context, it is
accepted. Later, when the context is evaluated, does this trigger a kernel
panic when fetching the NULL struct?

security/selinux/ss/services.c:type_attribute_bounds_av() {
    ...
    target =3D policydb->type_val_to_struct[tcontext->type - 1];
    BUG_ON(!target);
    ...
}

It also looks like this could cause a NULL pointer dereference during string
conversion (such as in audit logs) because sym_name() returns NULL:

security/selinux/ss/services.c:context_struct_to_string() {
    ...
    *scontext_len +=3D strlen(sym_name(p, SYM_TYPES, context->type - 1)) + =
1;
    ...
}

Could a malicious container policy exploit this missing type validation to
crash the host system?

>  	rc =3D 0;
>  out:
>  	return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-b4-disp-d3=
2e997b-v1-0-0341d038ee47@proton.me?part=3D4
