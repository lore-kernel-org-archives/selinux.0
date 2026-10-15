Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE251D524;
	Thu, 15 Oct 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067537; cv=none; b=P8gsNLy0yUxJjGztMjkhIzgAUmsrDbTP6IH1mkAzWgTtW+sdjNZcBRSAsIdndCoCXmfgIomQs0dIWsqlnB92NRW1rEt/C5IltwfKBJceZ7+TgjjGa6OcWNlFXPNbN1oIOUGvZHnXfo9+W6ZUl5A+0eqHGdb5wBvic6X2EDxG5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067537; c=relaxed/simple;
	bh=ekVfnPOTd9BZQyxWMnTmwpLgVk997cebPo2RZggR1O0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OAhiCbnq01DmE/CQYPdPdJwNKjPZGHWawx8VZfNFAX+kTajBp6IjxFBlFLi/Rq3szMd/2mww1e2NZYRMVOd2rLUkdT4fiXVD8QNUamHdMlbiOuQ+34OFhiPDU8aZeDqHi3ED5fkjx4xIYxG2k5ruKaxiss4KnlrVZnGfGFWCHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqH10T9h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqH10T9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D551F000C4;
	Thu, 15 Oct 2026 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067535;
	bh=xH5V+RjPMX2OoaIL0TYiuAC+eMv3PKbAFyVDC1jlDGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqH10T9hE3VBRyaUZ4z53EQViUSv8EZt3+HDL/iv30t3HscSg/NmPvGiNduKO9NKd
	 AzfkHl7rw4/Q5eH5CkPmMgUZ30cha5Xzrhkk6fjkHg0akfNamC1dD9djEHdwQsFBDJ
	 TeNRfhvpRvrgiIKIyJyKVSRhTBvJg6qGFwLy5V5mt+3KFBGdc5HmZJfSL/EJVASXSQ
	 r4XZaln2EgNwWC6r3/ps8GhgP159LgJt5t0cpjSf7xMgpqdx7hA2mkneA5/uaPpHVA
	 rFx2AI//YJmkxe0OB5fyRWx3Z9glkuewvGIfajSiLx/QBHmBZFphljRnwD5pz8V4Bs
	 8O09YIqi4F8/A==
Message-ID: <sashiko-outbox-172805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 10/18] LSM: rename inode_getattr to
 path_getattr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261015125425.3246251-11-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-11-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:32:15 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/bpf: use of deprecated CHECK() macro in updated test code
--

commit c4d97789c19b5bd634c796fba77ad30dd5acd56f
Author: Cai Xinchen <caixinchen1@huawei.com>

LSM: rename inode_getattr to path_getattr

This commit renames the inode_getattr hook to path_getattr to follow the
path_* naming convention used for other hooks taking a struct path. It also
updates the security_* wrappers and adjusts BPF selftests to use the new
names.

> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/test=
ing/selftests/bpf/prog_tests/d_path.c
> index 1a2a2f1abf033..9877c098e5c14 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -160,7 +160,7 @@ static void test_d_path_basic(void)
> =20
>  	if (CHECK(!bss->called_stat,
>  		  "stat",
> -		  "trampoline for security_inode_getattr was not called\n"))
> +		  "trampoline for security_path_getattr was not called\n"))

[Severity: Low]
The BPF subsystem guidelines prefer replacing the deprecated CHECK macros w=
ith
modern ASSERT_* macros (such as ASSERT_TRUE or ASSERT_EQ) when writing new
tests or updating existing ones.

Since this patch updates the string literal inside the CHECK macro call in
test_d_path_basic(), could this be migrated to the modern assertion standar=
d?

>  		goto cleanup;
> =20
>  	if (CHECK(!bss->called_close,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D10
