Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16429353A82
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786675186; cv=pass; b=R1rv13XjOjJ3ojIxbG6daZjL8jzLY3Dx0H7Cn66sH3RHru2Z7YZIk2MoCfnY6XlS4alcbAXHvmxKzkKbZECN60V74tNMG/uoVFrlSX4r6BOdUZOSL01XYyOU0XlDT7G/AFkwu6Yqc5J4xoCTI/6cme5m7CdcTx0MnQUwcA7StAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786675186; c=relaxed/simple;
	bh=e7GDZuZq4XH1GHVz2EUb/xqxBiAsPOx7DRBEqWgDGBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dP1Whg4vaBMm6qBhTNapSHUL+lHQJ3nepTO2GD2IDzT2PJkR7t5ARZIGY2WLcrz7RZP1EgRh0uZd3utFC6fAlNhhdBF+sdXucSQEk+1Pgabe+uLM1mKyIxSxdM6Kw43x5hu/MnsE5dl4zZvpe3BBk58N2h9UOgKpGDNtV4flNHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESYTMAEx; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESYTMAEx"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c10e86e52so70781cf.1
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 19:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786675184; cv=none;
        d=google.com; s=arc-20260327;
        b=RuZ5NCZwszWNglFztcU1/bvpZBl56/g7guwtx0H2QqxDSPw5l+RDYiQB1/ySPKLfR9
         LVQBbcLJ7CFWjm2OnNT9zBeOJggucYQ5qg9C2WOLRGKaLkL/4XDnsvWOcEqFW61ONa46
         rXmdT/JHTj3Zuah2eTfxTlx6rR/jfUtzp/hA1TdlThjzpYUxuiQUgsfh5mr63wgJY1rA
         uPMKrBQkCNE/JOCf+EKgO7YK7MMh4IqQRAfseeJxAwUjAku8p18UGDgDIL6deJM4u4AR
         Cvp6CSsXgMitrvkn5Jd/m5JNFBX+kAzBbNn3pqc+ElfnbF5zHURpFx8pVwtXpmvgQ3Hk
         wIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=apV1Fy4BVlFMGCNcXXiVKBIiYAex4zPqpD7SYa0z2p4=;
        fh=T7KHZ77fNjtq8z9QKw8SKNTKKvtfhK5kUIAxKJPklZw=;
        b=SaaxTwGcPZoT9gl/c57TIqmd9GYPDqugmVOcgym2ZAy8XDEh1RGY2F6J2ZNfepo2N9
         80XFgTnhTZkU8cRXVJ6YkFS5U+Vx4yqK5sUILNVgmwO2GsK8toGzvqg2ryYCMBxDHu3D
         C64dmadmI2GiKliL08dxbGwlkQw2sTnjtlQYg8MGv9tO8GvbnyEFoVzZGsby6wqOyi5y
         pL0cysneHqpGNQ5L5eeZtMW6SGdCwFMGQ9o1KSMSzDTZWj741gIgtepg+E0FpDXH/7VN
         Sp1ZRxcz9hkJruLQKLF7kWIKTSYQN8dnpRS/RZHf8kHsOzrBZVqwy2XmHNiWYcLOmT5T
         GuPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786675184; x=1787279984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=apV1Fy4BVlFMGCNcXXiVKBIiYAex4zPqpD7SYa0z2p4=;
        b=ESYTMAExKDJCy8MtU390n99vzFsI1W84pcLurNbSGn04lUJZzGmrx4pQKc7l/VwsX/
         V1pslc3QGcn4eAiXKYLNc1lwZCflMoCsDHIK1TBXR7PzjQ/BthCouyz9GwoZePlIkDO9
         Q5dyJC+7cqrIhK8fZ0TyKJ3w220pvoThS89WAZ2lX8hfDK5ZhsGixD7GTsWd3JRx7NGc
         8PCM1ssAiDBHpIui9MhOM953MEM8nbLP6S5NM2AnTYsrc5l0o+WbbxxWwY/1EUW/o4pe
         K5OlU39E8qTwti1OlO1dH1Ar6yZ5VtM6KUfIYS6OG8WvOaeaElOqbV/ouQBCeU72Bpuw
         fAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786675184; x=1787279984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=apV1Fy4BVlFMGCNcXXiVKBIiYAex4zPqpD7SYa0z2p4=;
        b=HpP0aoQAtV/GdfmA9jICoQuM+1Cz13LR3EMcOuYAOY2+Zu+3BcCaeMM1rts+N5VD4d
         F6xwSArWcX3vJuwSA5RMqsogWms64eNeWfTCMxnsHRARBcud0CnJteNVAypHpf8+TYDc
         I3QyrbQq5AOPdG4kjoAtQCBIkIsO/o97fUPWB839aHhoNAOMVugEsVYD6UAsivsIYAlb
         +O9oep3SBSiNbVS32yXPM2pAzq6ZbhQFY4vqaFjhsr2VQSzk7pwo7gWHim2szeRcFH3R
         5PMNIXlxsSyDkOfghxqFzO4gCb4J1jXqbMIZXeqGUPdhGHugRCasedj2lMgpxa+3yBHF
         iTTQ==
X-Gm-Message-State: AOJu0YxRWA812OYkO89oRNmtUpdCY2mMqEao3C3MLER7EzNSo+tJe5rz
	hy54YZrMxR42StjMc0sISf0bEcIYqeCEzYZ5AwAeS8bcd38GWjvJBq57sQ9pI3w4hujGaBa0gJK
	zwBtXwJTQyldcrric/XHJTTBRC5L/LJlH9LheG19V
X-Gm-Gg: AR+sD10ubxTbmy3WJGxgl/UT313YOK2YMfHsM/QbD1efqSB56gUe0GWdeBnnQ+vG0xX
	caSrPqZpP3od1MGjGuE5wxycMUWHzfvv83noqX1yG+Zoczoss1+AgZUy4FKKOsBaGxR1AYKyWp4
	z8iqRlUiyQfG5fronwI4zdFAxqI9U9rZrM+7wEO6oJSPubTT8/ZdJiGzG/tuCmb9xx7qBDqKwZG
	aq1v7tN1OMVTDJoKXCfOlIoFJxQaWSXR0BxCQIh/5LrQuo1lWklHM7YSqascAUMqwbbq1WyH+8J
	Pwk7S9rCoWuYsMvHo65LPQS/D8HxPCbaTjb3RMXmzQnod4443k/7yCNr6uduj1BE5qr7EozqNFx
	9v/BOja3S+znwgdo/mw8wNqNI9BQu
X-Received: by 2002:a05:622a:591:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-52d845c0170mr9874351cf.6.1786675183260; Thu, 13 Aug 2026
 19:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813195956.197456-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260813195956.197456-1-stephen.smalley.work@gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 14 Aug 2026 12:39:25 +1000
X-Gm-Features: AUfX_mwRbYnIGOfEFeLWUPWs0KVM1nRXJN4GFCqSAaLXOmUgS6PRNsJYnY3jZF4
Message-ID: <CA+zpnLcjJcEAUJJcHT9euu266WE++dFmC7-ukGisPTfa4nb04w@mail.gmail.com>
Subject: Re: [PATCH] README.md: Further elaboration on minimum policy versions
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 6:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Provide further elaboration on minimum policy versions and
> considerations when updating them.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  README.md | 59 +++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 10 deletions(-)
>
> diff --git a/README.md b/README.md
> index bfd32b89..a2427bb4 100644
> --- a/README.md
> +++ b/README.md
> @@ -25,8 +25,9 @@ for more information.
>
>  Minimum Supported Kernel Version
>  --------------------------------
> -Linux v3.0 (for /sys/fs/selinux mount point directory) for libselinux
> -and anything that uses libselinux to access selinuxfs.
> +The minimum supported kernel version is Linux v3.0 (for the
> +/sys/fs/selinux mount point directory) for libselinux and anything
> +that uses libselinux to access selinuxfs.
>
>  Note that the policy build toolchain (e.g. libsepol, checkpolicy,
>  checkmodule, secilc, semodule_package/expand/link) does not link with
> @@ -35,18 +36,56 @@ Linux kernel version. The policy build toolchain has =
in the past
>  successfully been built and run on non-Linux platforms as well
>  (e.g. macOS), although this is not officially supported.
>
> -Minimum Supported Policy Version
> ---------------------------------
> -Kernel policy version 24 (boundary) for the SELinux and Xen
> -targets. Support for this policy version first shipped in libsepol
> +Minimum Supported Policy Versions
> +---------------------------------
> +The minimum kernel policy version is 24 (boundary) for the SELinux and
> +Xen targets. Support for this policy version first shipped in libsepol
>  2.0.34 (userspace release 20090403), Linux v2.6.28, and Xen
>  4.0.0. libsepol dropped support for kernel policy versions older than
>  24 starting with libsepol 3.12.
>
> -Modular policy version 10 (boundary alias). Support for this modular
> -policy version first shipped in libsepol 2.0.35 (userspace release
> -20090403). libsepol dropped support for modular policies older than 10
> -starting with libsepol 3.12
> +The minimum modular policy version is 10 (boundary alias). Support for
> +this modular policy version first shipped in libsepol 2.0.35
> +(userspace release 20090403). libsepol dropped support for modular
> +policies older than 10 starting with libsepol 3.12
> +
> +These minimum policy versions in libsepol affect:
> +1. The policy build toolchain. For example, checkpolicy, checkmodule,
> +and secilc cannot generate a policy with a version less than the
> +minimum.
> +2. libselinux and its users. For example, libselinux cannot downgrade a
> +policy file to a version less than the minimum, and libsemanage cannot
> +read a binary policy module that was compiled with a version less than
> +the minimum.
> +3. SELinux policy analysis tools. For example, setools cannot read a
> +policy with a version less the minimum.
> +4. The Xen hypervisor, which compiles its XSM/Flask policies using
> +checkpolicy, and only currently supports kernel policy versions 24 and
> +30 for the Xen target. Xen does not use binary policy modules so it is
> +unaffected by changes to the minimum modular policy version.
> +5. Android, which has remained on kernel policy version 30 since
> +moving to it since it has not needed any of the newer policy version

nit: double "since" here. Maybe something like:

Android, which is on kernel policy version 30. There has not been any
need for newer policy version features yet.

Link to our build configuration, if that helps:
https://cs.android.com/android/platform/superproject/+/android-latest-relea=
se:system/sepolicy/build/soong/policy.go;l=3D31

> +features yet. Android does not use binary policy modules so it is
> +unaffected by changes to the minimum modular policy version.

Acked-by: Thi=C3=A9baud Weksteen <tweek@google.com>
