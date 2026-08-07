Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97931F985
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130419; cv=none; b=p6789Rg13iqSE4Vhbs/vhmhrasCGctdE45AS03Qj+p5YNABFTz/2Q77ORGxNvgLoQR3evQo9xV1piGAcPQkEehiGgA+9givN6vyws0gY/3f1UbIiw/ZlhTSxInBB/EgQHrUiExbRxda1jk+912S2qTzdH1JFQmlkvz6RFkwt7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130419; c=relaxed/simple;
	bh=05h5gg+kxP9A6gOfv01lKpl/JDr8DiSqMn9Ltj7fFMU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IhTK8zNfOoKPGeyERT5hU5To6fNhuN6ODDIvZ4NqPUaSUihGx4H/IYn1yqQz+eXbeWTi8tL5+Kmeqyie9XX+Y1TgU62xEaBzKsMSzlIl+UBzjZqYSL6uJvzY/wSuOoSV+j/NuTqbLsV3bfhLVwqGUn5eus5doeJ2rXIGhNbcTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7GtxEE2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7GtxEE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAD51F000E9
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786130418;
	bh=05h5gg+kxP9A6gOfv01lKpl/JDr8DiSqMn9Ltj7fFMU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=n7GtxEE2J8jkCjxbwCodZ5SsqDgZOGleLv86mOwLsfhA0fTPiROz0JeMBbgWEePeT
	 66qKjvyT0R0XFZIHIuI7MoV3m0uEU553sooSQTBilWgO37f/cpRBTY6AxMhZIXMzGE
	 qQUQggoYn6cSpvqgiANmVcab8dM14fIPKF03iZOjwSY2MILQsrg3bDNiaCcKrqPzPR
	 DwL66SMNF2ZIjsl+4C/I0C75/T+gxqssrNkOARHd1pP52IF8TQCzStYsvVEG+leLUB
	 WqIkj3AM1FEY3sVwd30+J0/MYJV+Ps/tdDonDkHspTZNrciE+qLQjnWy2t6+nuS35O
	 t/96z5ekh+BcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selinux: tighten policydb_context_isvalid() checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: selinux@vger.kernel.org
In-Reply-To: <20260807191342.19500-2-stephen.smalley.work@gmail.com>
References: <20260807191342.19500-2-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 19:20:17 +0000
Message-Id: <20260807192018.3EAD51F000E9@smtp.kernel.org>
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
> arrays are populated. The now-redundant NULL guards on role and
> usrdatum in the OBJECT_R_VAL block can then be dropped.
>=20
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807191342.1950=
0-2-stephen.smalley.work@gmail.com?part=3D1

