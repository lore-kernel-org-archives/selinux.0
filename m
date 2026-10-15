Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651052189B;
	Thu, 15 Oct 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067968; cv=none; b=PEpmzqxhdtH3ChZS+WMHR+m/bEuj0n/xFVtAPlwWAZAy0KB02V3eVCoFeNAU6qgiixIXoZDVnXKaWyosF89AQ9Iw/TTpuU7FzyIp7c9j9f0LoTXglBMI+A9W5VKIQuPJUsg1m8D1JaWBwhuZ7dGVZBZz3skTgVjWTBdeXZqva48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067968; c=relaxed/simple;
	bh=akN7Bna5gRbWfB3XLMaSyhCBmYH9yrdV2cejM9SoijE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l8kSvn4QJIU6wm8UA444+Iq7Sp2yH3/dqg7B4aJWD41/geKdQZ/3tsyr+2BCmvWbTYQYGA7O/BnaMD3IKWYWyixDth+CwPwpAadgLYruOuKfa0EnZKVMaFu0Q7xbk0Iw8wJ26kLq/PWSrdWTQGJJGJ7/+KyrrFYURK8Na+GH8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLqtMe0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLqtMe0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C02A1F000C4;
	Thu, 15 Oct 2026 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067967;
	bh=hMWDw3wGB+And8jSS38SbQ7urgevZyOha/etbU1he18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLqtMe0B2vGLQt9pVsnsLe+O6BNKMJoWqMsrYjICJJK/1A27SD5ostEfo2sUKZH85
	 OmHn3CzTLD8rm6GRt2EtV3qOoni45pFtEK7kBCdzmna5f4kIwi3ek5Xs0EeepOdB9n
	 6JhQ7Bfi91ijb4QWkVwqj/ydsIuFvdInpDc3KgIOZMgOOA2HWDhvhk7rLN0u/ClH4b
	 KNKdyQdXcfzTbgufiS7QXhGJwM7S/Q4PcyCrR7k0NqCq21t8MCmf+mtfz182bMx/JJ
	 X0EVfr7Nj3wxsntYgCNxixOfovcj5pUdb1GyWQj6qX51yl03sPa9lPEXekxD2bR1kl
	 qKvF+Upv1Ddlw==
Message-ID: <sashiko-outbox-172821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 -next 18/18] Documentation: Update landlock doc for
 metadata rights
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>
In-Reply-To: <20261015125425.3246251-19-caixinchen1@huawei.com>
References: <20261015125425.3246251-1-caixinchen1@huawei.com>
 <20261015125425.3246251-19-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:39:26 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] docs: landlock: missing case 12 in ABI fallback switch example
--

commit ffdbac73c2bfbb47b618cd72408a33f8fb82d15b
Author: Cai Xinchen <caixinchen1@huawei.com>

    Documentation: Update landlock doc for metadata rights
   =20
    Update the user space documentation for the new
    LANDLOCK_ACCESS_FS_READ_METADATA and
    LANDLOCK_ACCESS_FS_WRITE_METADATA access rights.

> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/use=
rspace-api/landlock.rst
> index 3d45b956b6407..62fe39a8b61e6 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst

[ ... ]

> @@ -159,6 +161,10 @@ version, and only use the available subset of access=
 rights:
>          ruleset_attr.handled_permissions &=3D
>              ~(LANDLOCK_PERMISSION_NAMESPACE_USE |
>                LANDLOCK_PERMISSION_CAPABILITY_USE);
> +        /* Removes metadata rights for ABI < 13 */
> +        ruleset_attr.handled_access_fs &=3D
> +            ~(LANDLOCK_ACCESS_FS_READ_METADATA |
> +              LANDLOCK_ACCESS_FS_WRITE_METADATA);
>      }
> =20
>  This enables the creation of an inclusive ruleset that will contain our =
rules.

[Severity: Medium]
Does this documentation example skip the removal of metadata rights when the
Landlock ABI version is exactly 12?

If a developer copies this example and runs it on a kernel providing Landlo=
ck
ABI 12, the switch statement will fail to match any case since there is no
case 12 label.

This means it will bypass the removal of the ABI 13 features
(LANDLOCK_ACCESS_FS_READ_METADATA and LANDLOCK_ACCESS_FS_WRITE_METADATA),
which will subsequently cause landlock_create_ruleset() to fail with -EINVA=
L.

Should this modification be introduced under a new case 12 label with a
fallthrough from case 11, rather than being appended to the existing case 11
block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015125425.3246=
251-1-caixinchen1@huawei.com?part=3D18
