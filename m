Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241E3214
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906559; cv=none; b=qTEOLYj+9r8x2gPZKYabBciFFtclMLl3vkzodCHRyjQ8f7QtubhC1zP7TApP71012VsFYEnTBTsLwzMJaW3iUV8zGPFxqh1ES/MFrYbPdOpoOsdY04C5P84bWAj9a50lzlGNVTcO/Uz4LDIfdmx1nkpKs6GGReSGcAjttkoOv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906559; c=relaxed/simple;
	bh=DTj6aLgaLwa6Ec4CqWeSLWcWsKhs6cg3gCrkMLds/mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRYRnBrpIO82zwkQGyEvncyMfmJn3k7Bim6WiL1kEQBdclE3jYi+kGwNbLwVXrVkrS/YXU/HKPEXogZNbHUgUL2eme5bx2UX1gX7ru59Esgn9ZSW8lYjnVxvkQWCRKRbraP63ibcm2rEb4SNIyXCBK3DrIp+JQ3v5HzmZOhQIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw6eVfWE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw6eVfWE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3134c67a173so3071361a91.1
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751906556; x=1752511356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23KpY9A6O+BGCz7v79cy774yBmBOA0odWB+g6yUlMV4=;
        b=cw6eVfWEWdsSwHwfuDP5R3ooAC6ubMp3Ko09Ks5TxxrV6IVR4xivkXxaEKSA3VUQ3A
         Zkp9SWk3AQJwhs2Ygw8SbQuaxXEMZCsU8dof3CQMdYBDBvmzrjZoYBx3HtvwpRWtqYKV
         /dqYTRRU9K/7gNFyUAWJLLmF1L/temeBBCx1Gltw0F6m8s0PISQ90vdvlpAx3ofJ5ece
         4eJyRxV0K2u/9wFAPS3oBt6J0NXg5bxHfT+v1Hgm/LgDKscpORA/0pbcRkl2wsZUPvyc
         qi7vFKVjHi8TI7Z/5Cn5WPfyViMPSBfXlYfL8FsQsqqjUa6WvCEhIntx738kX0b9A2uv
         jA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751906556; x=1752511356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23KpY9A6O+BGCz7v79cy774yBmBOA0odWB+g6yUlMV4=;
        b=Pe9qCE/jQBF0PUhepT9Ts+L2RUx+wIh5Ws8Ou3Bjuh2fQ5RSyyOoZaV6ZDkda3qdV5
         9ZgB6eRQ8A09rq9narLMVdt+EptupUnTCVcggpVeTbGCN5xjN9Zx+2Sjx+t2lFXVJEHq
         fnTx1gk+LXW4s4kRKFTXhgirhAraLvAw98H7bHwjBCTfDHI8zh/qC4fnZTIbssKMHz08
         uaaDfjlj2yqgh1LeOh6vxNty2lW1wdDuNocraueKHnUNPopi4cnmhCBVC57fP4x73rRS
         XSigAuP2/ie+89s4bUKTQWsCkG+6l//cJ56mNwAQ1Of+Ffi1Xy3JrSw55FiuuKHhxzDy
         evHw==
X-Gm-Message-State: AOJu0YyfR6H4CssLYEhIiGZNGKQfQdN/yozpHaAN5LqaEbQTa1+PPb5q
	fpxZS88kGmfDA0XcxxQ6UzF+/LrtWfRLrzBHHUVkw2mripKr1mCoioG7mWY3T0a5Q9K+KLgpIDU
	hoHNTCWDtgmN52mu+dnhMpIw/tGPgwFGsoGKO
X-Gm-Gg: ASbGncuKQunpiDVZNGt9lgf25qDi0/EcZ8wIwiJtLSy/62V8OISIgvMJiZE1x8mmyV4
	P4qLIcyid2cuyPRyRqw8PsFjm9l8vs+Qow9Nqxx0w/rrWRxUSEqkE+/o2Nd0JwQTN6aTcitBIDP
	OrIiMszbk1OQAZqQx5PEIIRzLl201e9Elk3nrEV7v6SvU=
X-Google-Smtp-Source: AGHT+IExyw1VaJT/1VOuPu6hOYWUk15UhfSpXFDsp+pPPSshODJe9jTRbI+0BRZeZ3o1bm1kZg6Rsaoj8RR+BaStyJ4=
X-Received: by 2002:a17:90b:53cb:b0:312:25dd:1c99 with SMTP id
 98e67ed59e1d1-31aac4b1a0cmr19188743a91.19.1751906555992; Mon, 07 Jul 2025
 09:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705121424.1221268-1-omosnace@redhat.com> <20250705121424.1221268-6-omosnace@redhat.com>
In-Reply-To: <20250705121424.1221268-6-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Jul 2025 12:42:24 -0400
X-Gm-Features: Ac12FXyoUbmkukMeJMfqytV3FIbCYsKbyC-uxOBYXysqF4J861EHViJLISMe31Q
Message-ID: <CAEjxPJ5rH=V6mLhzMupWiJOmSCu8zp54zWpAcjuZnOQTFVEaHQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 5/6] tests/module_load: fix the location of "2>&1"
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 8:14=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> It shoudln't be used in the inner shell invocation, but rather in the
> outer one.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  tests/module_load/test | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/module_load/test b/tests/module_load/test
> index b7318ef..3229f34 100755
> --- a/tests/module_load/test
> +++ b/tests/module_load/test
> @@ -121,7 +121,7 @@ qq(runcon -t test_policy_allow_policy_load_t sh -c "e=
cho '/tmp/test_ima_policy'
>
>      # Deny system { policy_load } - EACCES
>      $result =3D system
> -qq(runcon -t test_policy_deny_policy_load_t sh -c "echo '/tmp/test_ima_p=
olicy' > /sys/kernel/security/ima/policy 2>&1");
> +qq(runcon -t test_policy_deny_policy_load_t sh -c "echo '/tmp/test_ima_p=
olicy' > /sys/kernel/security/ima/policy" 2>&1);
>      ok( $result >> 8 eq 1 );
>
>      system("rm -f /tmp/test_ima_policy");
> --
> 2.50.0
>
>
