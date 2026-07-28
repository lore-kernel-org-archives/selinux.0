Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721729BD91
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 01:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203187; cv=none; b=a5VzV1fIgQH+WIknVKMjQQ6cYXMRIB0jrPawQQs0Zcnp0aLxI60M3ILx8STYui5XotQdbSWweeQYLgdID+6kmLEvfPMLwuR5frpVCKAxAwbXJjNN2bP9SsmkMd5I3kXNY2pqrIbWA2SSRFGqGWWj+JteMXNoUxEcCAf2QFlDRTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203187; c=relaxed/simple;
	bh=ECzs2MWMF8fJtolyMvamQS/nFljllscYpoSP0i+FqR0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dtXbX1BLUZ6ONMpUy8Y3gn5dr1lZxNF+ldmvy9hqXhtZVSkTXaA7/LggvWODgTlhcRpBWnxW691rAzzQ/AWor2Pj938rKoc7DSOXu/ETjCFTdyIDWVm3e/bMjU/wZ4H7no/QVOHS3UZ3c0dqQbQFYPe/kYtRlGbkBsAdAwQOrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3C4S8lR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3C4S8lR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A391F000E9
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 01:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203185;
	bh=ReGoEpUBgnScsz41+gQoYPmC03VmtXt8D3TVR9ft2LI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=J3C4S8lRi5uaT41h5tHUD+2aGWT1zgnDtZGq7/y2LgUYpFMvpneP6aElEnW6KIrPQ
	 ob9B5VZugCjuRVqrEzdolIl0b1L/Wphp9NNf7buC7zsCAowNSZWJGZDYXsNV25ZjPN
	 94kD+Dz+psZf58FFhzUnbIUaAt9iKisX33Mnz/0X44KSRwAJq2JPYKs5nNTHd6TNpC
	 H+JfJlLHeukXyjDrEtqASZArxi//bLnLu2tmR+N6H/NhqEaPNmd7YkXIRVILndl+pW
	 pbSMQ+B1MUqwXLZjZ+6TZCP96O5++H7V9/LENnKjhUnlZtsCyr6+SGaZ+Ik6qFIu1J
	 FADxF98Po6yEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selinux: reject a class permission count below
 its inherited common
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me>
References: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me>
 <20260727-b4-disp-eed1276a-v2-2-82d58cf5f882@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:46:25 +0000
Message-Id: <20260728014625.C7A391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Loading a crafted SELinux policy with sparse permission/class valu=
es or an inflated `nprim` leaves NULL pointers in symbol arrays, causing a =
kernel panic in selinuxfs directory creation.
- [Medium] A crafted SELinux policy with duplicate permission or class valu=
es causes unbounded memory leaks in `security_get_permissions()` and `secur=
ity_get_classes()`.
--

--- Patch [2]: [PATCH v2 2/2] selinux: reject a class permission count belo=
w its inherited common ---
commit 0b87262f147a0083f6daa265c846c87ddbbf878b
Author: Bryam Vargas <hexlabsecurity@proton.me>

selinux: reject a class permission count below its inherited common

security_get_permissions() maps an inherited common's permissions into
an array sized by the class's own permissions.nprim, but class_read()
takes that nprim verbatim from the policy image and never checks that it
covers the common. A class that inherits a common of N permissions while
declaring a smaller nprim is accepted, and on load the common's
permissions are written past the class-sized array -- an out-of-bounds
heap write.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index 6973b68d9782a..c6f55f0b4cb55 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1422,6 +1422,18 @@ static int class_read(struct policydb *p, struct s=
ymtab *s, struct policy_file *
>  			       cladatum->comkey);
>  			goto bad;
>  		}
> +
> +		/*
> +		 * security_get_permissions() maps the common's permissions
> +		 * into an array sized by this class's nprim, so a class must
> +		 * declare at least as many as the common it inherits.
> +		 */
> +		if (cladatum->permissions.nprim <
> +		    cladatum->comdatum->permissions.nprim) {

[Severity: High]
This isn't a bug introduced by this patch, but does the kernel handle a pol=
icy
with sparse permission or class values correctly?

If a policy is loaded with an nprim value larger than the number of
contiguous, defined classes or permissions, security_get_classes() and
security_get_permissions() will allocate arrays of size nprim but only
populate the defined elements, leaving the rest as NULL.

Later, sel_make_classes() and sel_make_perm_files() pass these NULL pointer=
s:

security/selinux/selinuxfs.c:sel_make_perm_files() {
    ...
    rc =3D sel_attach_file(dir, perms[i], inode);
    ...
}

Can this lead to a NULL pointer dereference in d_alloc_name() ->
hashlen_string() during selinuxfs directory creation?

> +			pr_err("SELinux:  class %s has fewer permissions than common %s\n",
> +			       key, cladatum->comkey);
> +			goto bad;
> +		}
>  	}
>  	for (i =3D 0; i < nel; i++) {
>  		rc =3D perm_read(p, &cladatum->permissions, fp);

[Severity: Medium]
This is a pre-existing issue, but does perm_read() enforce uniqueness of
permission and class values?

If an SELinux policy is loaded with multiple classes or permissions sharing=
 the
same integer value, symtab_insert() only enforces uniqueness on the string
name.

During selinuxfs initialization, could get_permissions_callback() and
get_classes_callback() repeatedly execute kstrdup() to the same array index:

security/selinux/ss/services.c:get_permissions_callback() {
    ...
    perms[value] =3D kstrdup(name, GFP_ATOMIC);
    ...
}

Does this overwrite the previous pointer and leak the memory allocation?

>  		if (rc)
>  			goto bad;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-b4-disp-ee=
d1276a-v2-0-82d58cf5f882@proton.me?part=3D2
