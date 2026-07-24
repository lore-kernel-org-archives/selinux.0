Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4C40802E
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906304; cv=none; b=nvZUgHtZ4SJLsqikepFTqXG27hpY1SE2m58sfpCUGHOtB2Z5chc/coT7V666Wqm5LHPr/1RMHiIIjx5+GkDXNnh4ZCwcFlqVjqYdz/N0rgmAXEVrGj0aqF3aTSxt6ZPKBzddsl/Wka+Gj1n7cAqRjpXZaTPI6W60J572yRJTHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906304; c=relaxed/simple;
	bh=83luAlFUfh4vxiO0fg/gCUgCVRp961KFcA1TemdaQU4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c1IJxU9QmnSfcjj+f59yWLjDbRrm18cbY/xUX9mi8o2Z2HyYwf6yBQbbSm+JPt83ZRJWjXEGNynbH6iRTCsBiJDRBsBJeetVpmujTvvuPBCTYKuDiKz6rsdBGLzFJnilLVyeGOv5rFfbxLjoiRvHjyoMpmoGsCNI/MKvFRXtrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZxbqEmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZxbqEmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8661F000E9
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784906302;
	bh=vmukmxKxzrOlNhrsYy995x9fENjgF5baNHWp1K1tAQ0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eZxbqEmMLCtYP45/4o+1w3Jb2pqQYlEiWdUKbhYVGebHzRjzmpkAmkp9+VsRaoI3H
	 JjLnX0R9X0cC9uB8T9Q7oWT2wTqezwyU5MahFbv8ofROD6o+x3lJVNZ6fxuU+oZNqU
	 9d4bIU3SopN9zYLFkBIx1z0auTNeoqe22+OTQ3BvnjWkjzfNbqu7Mlfpt9jNi6RfMT
	 0XVBW3Ug95J3y2GOBpQA+pjZbXWKhsvL8xezxC1SOd23Iq5t+iYzdKNI+wr1MmLTWn
	 qnQ0XmliANMVsrL8Wdpb1LRCHCuz0owGbME/O/Am8okTsbjFFY6jome9xrwwp1Zx3h
	 eAlURvQFcaJwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: reject a permission value exceeding the class
 permission count
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
References: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 15:18:22 +0000
Message-Id: <20260724151822.BB8661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents an out-of-bounds write for class-specific permi=
ssions but fails to address the identical vulnerability when a class inheri=
ts permissions from a common. If a malicious policy declares a common with =
a large `nprim` and a class that inherits it but specifies a small `nprim`,=
 the common permissions will bypass the patch's check and map to out-of-bou=
nds indices in `security_get_permissions()`.
- [High] NULL pointer dereference in selinuxfs when a policy contains gaps =
in permission or class values. If a policy defines a sparse set of values (=
e.g., `nprim` is 3, but only values 1 and 3 are populated), `security_get_p=
ermissions()` leaves gaps in its allocated string array as NULL pointers. W=
hen `sel_make_perm_files()` iterates through these arrays, it passes the NU=
LL pointers to `sel_attach_file()`, causing a kernel panic.
--

--- Patch [1]: [PATCH] selinux: reject a permission value exceeding the cla=
ss permission count ---
commit eb44c136ba9338c4aa49d6ec88bea5f639bd151b
Author: Bryam Vargas <hexlabsecurity@proton.me>

selinux: reject a permission value exceeding the class permission count

This commit adds a bounds check in perm_read() to ensure a permission value
does not exceed the nprim value of its owning class or common. It attempts
to prevent an out-of-bounds heap write when security_get_permissions()
allocates an array sized by nprim and populates it.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
> index ead504a639e36..6973b68d9782a 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1175,6 +1175,9 @@ static int perm_read(struct policydb *p, struct sym=
tab *s, struct policy_file *f
>  	rc =3D -EINVAL;
>  	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
>  		goto bad;
> +	/* the value indexes an nprim-sized array in security_get_permissions()=
 */
> +	if (perdatum->value > s->nprim)
> +		goto bad;

[Severity: High]
This is a pre-existing issue, but does this patch fully prevent the
out-of-bounds write if a class inherits permissions from a common?

While this check bounds the permission value against its immediate
symbol table's nprim, it seems a malicious policy could declare a
common with a large nprim and a class that inherits it with a small
nprim.

The parser sets the class's nprim without validating it against the
inherited common:

security/selinux/ss/policydb.c:class_read() {
    ...
    cladatum->permissions.nprim =3D le32_to_cpu(buf[3]);
    ...
}

Then security_get_permissions() allocates an array based solely on the
class's nprim:

security/selinux/ss/services.c:security_get_permissions() {
    ...
    *nperms =3D match->permissions.nprim;
    *perms =3D kcalloc(*nperms, sizeof(**perms), GFP_ATOMIC);
    ...
    if (match->comdatum) {
        rc =3D hashtab_map(&match->comdatum->permissions.table,
                         get_permissions_callback, *perms);
    ...
}

Since the common permissions bypass this patch's symtab-specific bounds
check and are mapped into the undersized perms array, could this still
lead to a slab-out-of-bounds write in get_permissions_callback()?

[Severity: High]
This is a pre-existing issue, but could this sparse array allocation
lead to a null pointer dereference later on?

If a policy defines a sparse set of values (for instance, if nprim is 3
but only values 1 and 3 are populated), get_permissions_callback() maps
the present permissions:

security/selinux/ss/services.c:get_permissions_callback() {
    ...
    perms[value] =3D kstrdup(name, GFP_ATOMIC);
    ...
}

This leaves intermediate unpopulated indices as NULL in the array. When
sel_make_perm_files() iterates through this array:

security/selinux/selinuxfs.c:sel_make_perm_files() {
    ...
    for (i =3D 0; i < nperms; i++) {
        rc =3D sel_attach_file(dir, perms[i], inode);
    ...
}

It passes the NULL pointer to sel_attach_file(), which passes it to
d_alloc_name(), which requires a valid string for hashlen_string().

Can this cause a kernel panic when a process loads such a crafted policy?

> =20
>  	rc =3D str_read(&key, GFP_KERNEL, fp, len);
>  	if (rc)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-b4-disp-ec=
8ac9f6-v1-1-d76d51a69b9d@proton.me?part=3D1
