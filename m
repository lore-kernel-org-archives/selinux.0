Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265512DB78B
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203104; cv=none; b=hyHE8zmxsy44/DKUJV32lLi2N4fCskMwMTVayLOON1YkGNVSYVshSAm1CQZDJYS8LD/syDzJaLx8Mk8MjmPoa+1Z60gzod1wY3+qKZQtq3DydgQiPvOkuoRXhZXEzq+LFNfS5sTZ38cC8hst5LLIsH3+NgcknBRl0plT8Tps9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203104; c=relaxed/simple;
	bh=qyDDQ+qmJsACYYbzm51uQsQNJQjpV1zRzN0ibPf+QTQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VgvlSO6hqpovc3qf31sMoG/R7X9F9G43UIRX6qUG60vgjrJu0b4A92GQvSSdZq/JsOUgQDBjmBHxBi8dWEb3d97edw1qweeFMiDY8DEsBEVPjEesExyfSR23gIAaguq4xzTsx1UPAoy0lWPuKTIVOHcHjr3ZFsPy9Fj5fs8tZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC26EMJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC26EMJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9623B1F000E9
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 01:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203102;
	bh=W1WGngHXjji6A7F1+itPA+uBJPl+cZ0mr/np/Rn0ykk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oC26EMJf04pnq1mCJgPcx5FwMKRnXYQUybeHhbueLJgaBkDZblLoevuG8UZkCYKlE
	 vszEGu9KH469tDDVsz0ou1Qa9frWIXvhRxRfxvSVgQiotLWuXU3+UhIsakzbgwV6nq
	 +I3edXW8Z+d9XhC94dIxktimwzfnTo6CyV3rwAp1I3IUEhr4XMArT+u7ldL46WYvND
	 V0d50aKqFDtA70lD+WAdmrJeeJT0Kq1nNTx1mdER5U9JAu2WN03B/82lJRfw9i+U5+
	 p99O76qBSjYJONNJpYr9DcOPvyy5NCQA16qfseSjgXW/RBPTdyQOFOwgnsL5kBHVd+
	 LvqcyTherAOrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] selinux: reject a permission value exceeding the
 class permission count
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260727-b4-disp-eed1276a-v2-1-82d58cf5f882@proton.me>
References: <20260727-b4-disp-eed1276a-v2-0-82d58cf5f882@proton.me>
 <20260727-b4-disp-eed1276a-v2-1-82d58cf5f882@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:45:02 +0000
Message-Id: <20260728014502.9623B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Out-of-Bounds Heap Write in `security_get_permiss=
ions` via inherited common classes.
--

--- Patch [1]: [PATCH v2 1/2] selinux: reject a permission value exceeding =
the class permission count ---
commit b4fe3642552433263525065c279ba6cb8b2c045e
Author: Bryam Vargas <hexlabsecurity@proton.me>

selinux: reject a permission value exceeding the class permission count

This patch adds a bounds check in perm_read() to ensure that a permission
value does not exceed the symbol table's nprim. This is intended to prevent
out-of-bounds heap writes during policy loading when
security_get_permissions() populates an nprim-sized array.

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
This is a pre-existing issue, but does this fully prevent the out-of-bounds
write when a class inherits from a common class?

The bounds check added here validates permissions against their immediate
symbol table's nprim (which is comdatum->permissions.nprim for common
permissions). It seems this misses the inheritance vector where a class's
nprim is smaller than its inherited common class.

For example, when the inheritance link is established in class_read():

security/selinux/ss/policydb.c:class_read() {
	...
	cladatum->comdatum =3D symtab_search(&p->p_commons, cladatum->comkey);
	...
}

There is no validation to ensure that
cladatum->permissions.nprim >=3D cladatum->comdatum->permissions.nprim.

Later, in security_get_permissions(), an undersized array could be allocated
using the class's nprim, and populated with the common's permissions:

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

Could a crafted policy still trigger an out-of-bounds write here if the cla=
ss
declares fewer permissions than its inherited common class?

> =20
>  	rc =3D str_read(&key, GFP_KERNEL, fp, len);
>  	if (rc)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-b4-disp-ee=
d1276a-v2-0-82d58cf5f882@proton.me?part=3D1
