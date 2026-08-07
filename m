Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13372E737C
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123052; cv=none; b=JbHYqpgUGsYKqphUeSIN3rvwBRj//F0V4P4FgRK6sgY9SzKtFEvKGWtGcE7yQ+IgznxjDFYgZ2f0Mv+O4pQz7sYAzJxhBJ7dVCJLSsmupX1r1Ucmx6T6sbh8ht5u/iCo0lAr8nbof8AdIB1MmE2oHbMTkXljtIrSzQEJyUxGqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123052; c=relaxed/simple;
	bh=px3uSr8BLTxyb7Hww8O08ZVtoKF8EBSqnv00Q8WV4P0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kGh9joCqx2nZjUUWBTcda6DYoxWgNDEjAsrPN67fhW+Xt1ANl7DqVc0DNziOOFk+bJA+fEni7VhRXdb6w0kABM53zBsliimE2BMTj4ENNwyEe53vzrHjctf6OBuulUeYPpLdugsIcSlp2ofaaB1aIEr07/gn8YbH55/Ofyi/Mwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C665tVhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C665tVhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853E41F000E9
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786123051;
	bh=px3uSr8BLTxyb7Hww8O08ZVtoKF8EBSqnv00Q8WV4P0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=C665tVhhP1aqDutkYmCMrGzhQig/vwwcObZlwa4xfubjZ3XatMtEB5nR6vtK+zHsy
	 SM+PgrWlJ4EqBs8JztWiPaAxORXB3jt+ZowmZuDs1RxY+J3pS0/F5UMOHUvQzmdwG1
	 kmVNI+pXhUAdGaYGAVtP6FdDU955KZ5fAR7TVEXRqRlxnlluKMrn32i1codlqAuIe6
	 sWRK6mcl8sasB+nT7/iWylJAHv3ueoCFcwx4t2xioHvkDf8cWmSK/3zQQuZ5MDLPL4
	 WzIn60mycJ1qqTKxf76M2dRjHrolXzD9WwQKL8QTfBooXXiSem4ecJLm4MEin18ZwB
	 0hx2W4RBAlOZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selinux: tighten policydb_context_isvalid() checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260807170541.11895-1-stephen.smalley.work@gmail.com>
References: <20260807170541.11895-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 17:17:31 +0000
Message-Id: <20260807171731.853E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

> policydb_context_isvalid() bounds each of user, role, and type but
> does not require the value to be defined. A crafted policy can declare
> more identifiers that it defines, so an initial SID or ocontext
> context whose type is not defined can be inserted into the sidtab and
> later reach type_attribute_bounds_av() from
> context_struct_compute_av(), thereby reaching the
> BUG_ON(!type_val_to_struct[type - 1]). A user with no datum can reach
> context_struct_to_string() and thereby trigger strlen(NULL). The user
> and role datums are already NULL-checked further down but only when
> role is not OBJECT_R_VAL, so an object context can carry an undefined
> value through.
>=20
> Use policydb_{role,user,type}_isvalid(), which check both the range
> and that the value has a name, in place of the inline range checks.
> The name and datum arrays are populated by *_index(), so a value with
> a name also has a datum. This runs after policydb_index(), so the
> arrays are populated. The now-redundant NULL guars on role and
> usrdatum in the OBJECT_R_VAL block can then be dropped.
>=20
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807170541.1189=
5-1-stephen.smalley.work@gmail.com?part=3D1

