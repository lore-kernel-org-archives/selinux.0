Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672955821D
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879673; cv=none; b=IGLKzLTY3/mIvnlmDv9lQespUwyax4QaCqn2GWg6OG3wVW8KrvU+HYb5boh3T5ObJMa1zl9txSgqWse1A+BezibOLtYkG5ySIfQIGnuhmULU4ItNTqJd7qky+9J5s1lwk+EfFZArR+x0OBivY1gNT84Q5FaTD4Me39BeuR5ypAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879673; c=relaxed/simple;
	bh=qUD0BSQcZdTP6VYmZ6X5wZrUHQm0KPjKaUitxw7fNn8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ShZAtdmNwg9BS/UI1XOMkE8+hkGnrlM2WWiZly8XLWmMfxjwWqgZqgNVZw3PcWF01ZpAKFQHMR3C5IT6/qCpYfgVoqa+8U2U8GSBQGnxpKQUAeIwTGgKiDieza7G6W+zJmFSQ1ERnpDdzpEk6fXb71pkHb342Uv4t4opa9PhpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfFH7iVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfFH7iVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013DA1F00A3A
	for <selinux@vger.kernel.org>; Tue,  8 Sep 2026 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788879654;
	bh=KFjirTQ/8V0T1adDdY+3/jG7e2Q2QuxODRG8wjmk6Jk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TfFH7iVjTNJ8zv53zZyahfc0+/dUgcQo3YH5Tb/qcavl9Sq2ES/YgbrJNWOqcK/CV
	 n7GdQfiXkWyVPsiCbDFJpxLP00tzhag6iVkRF9h0wdlqSx7RD2o/7fmn2vIIOBc9M6
	 JNxqFJFdhBy+JV64f9IDEYKWYTpSKJOcLzqjBGYzTYp/F1+YBh6R3B+lFRFcFZ7A0g
	 6rMGWsS9/PROZDTGYo3y/PJl5kn3CTcuDq46DPkj/XHY0LO2FHhsXhP9LRm02LxIGP
	 bQMTHJ+U5maBxddTfxXNTLJoxSOJMJ+8uMD3RYrjVPVFEHr7TWlf+1GI98WAN6Uoqu
	 g3r23rIdXhI6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: treat genfscon lookup failure as non-fatal for
 booleans
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260908144341.17206-1-stephen.smalley.work@gmail.com>
References: <20260908144341.17206-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:00:53 +0000
Message-Id: <20260908150054.013DA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch adds `ret =3D 0;` to prevent an error code from propag=
ating, but it is a dead store because `ret` is unconditionally overwritten =
immediately afterward.
--

commit 56d806498916952baebbc4306bdac863b09cae9c
Author: Stephen Smalley <stephen.smalley.work@gmail.com>

selinux: treat genfscon lookup failure as non-fatal for booleans

This commit aims to make genfscon lookup failures non-fatal when labeling
inodes for policy booleans. It resets the error code from
selinux_policy_genfs_sid() to zero to prevent the error from propagating.

Link: https://lore.kernel.org/selinux/RvCmRlQYQ3uewSzEeY0utQ@coker.com.au/

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 5aaaf69410bb0..fb1d11e8fd371 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1278,6 +1278,7 @@ static int sel_make_bools(struct selinux_policy *ne=
wpolicy, struct dentry *bool_
>  			pr_warn_ratelimited("SELinux: no sid found, defaulting to security is=
id for %s\n",
>  					   page);
>  			sid =3D SECINITSID_SECURITY;
> +			ret =3D 0;

[Severity: Medium]
Is this assignment a dead store?

Looking at sel_make_bools(), ret is unconditionally overwritten just a few
lines later by the result of sel_attach_file():

		isec->sid =3D sid;
		isec->initialized =3D LABEL_INITIALIZED;
		inode->i_fop =3D &sel_bool_ops;
		inode->i_ino =3D i|SEL_BOOL_INO_OFFSET;

		ret =3D sel_attach_file(bool_dir, names[i], inode);

Because ret is overwritten regardless of the prior error state, the added
assignment doesn't appear to change the functional behavior of the code.

The error code from selinux_policy_genfs_sid() was already being discarded
by the sel_attach_file() assignment before the loop condition could evaluate
it.

Does sel_attach_file() need to be skipped if selinux_policy_genfs_sid()
initially failed, or is there another way the error was intended to be
handled here?

>  		}
> =20
>  		isec->sid =3D sid;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908144341.1720=
6-1-stephen.smalley.work@gmail.com?part=3D1
