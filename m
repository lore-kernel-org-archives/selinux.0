Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01F32720C
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075140; cv=pass; b=A3RYYzDqn4iX9KK6KThdBHx36/kpZG0qJClm8ZPojlodKernx40tYJaUPtbSIBWLtU1BNMbHxeQ+zSKkgzR7SqRKFl6rfkoROi/rgeEizMnbj2iBCNhHWDHNGgGJv03vhWSXrIxygVylxyKk/ofyIe6x5caNc+CMFQ4KvzthoTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075140; c=relaxed/simple;
	bh=27cQfQSZg8Km02AKa/i7F94fYQpUVeN4urNqh0nj9WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCCo7kBd6uI9JALMbLoduEp4lgGv+9Cl6pVoHmykT0f94mZfJ/O8l37QslyzKIn0AQkatjPgK0xhaqFoo1WSla/uwJVNoITfPfE/SvH7+oEGOKDVIGYGqNjS4PjMDzQa1FZptGVKn8HvIZ+cMHNvIe4+GQxfKQYUR/xOA2PhfKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUOgE8JX; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUOgE8JX"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6798c4b882eso1557561d50.0
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792075138; cv=none;
        d=google.com; s=arc-20260327;
        b=XvuTSMhlnS0AfoJZR7MQBe4yq3S11rEALFutCUPYGNCN1qbsn/GbAjhwNMQXufNJnZ
         TW9zi9eDlodKFXIqMJETwrFqgUIjWuciRBDeAO8qSeTJ196Ej0+0dhyGT/yvCQ866215
         Zekw7WAQXYri6Ht8SFDVM8BepyanNfULyUZ44RL6u2dILU0HJhDl9Tokqznv+DvYZgrS
         yTmYt4+Fu2x5IbySOdoYYgqlPHlDI31jHWDdFgH7+TIiaVm2ac4+uRH/JBSh28P3GFWH
         /VL4JMz4EW1KsweHC0IgvjGuvpdxn1Mco3npqw5EtBAtx8OBop+pbwb3pddrIoqixiu8
         Sr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27cQfQSZg8Km02AKa/i7F94fYQpUVeN4urNqh0nj9WE=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=YSAYzU8isxcjC5UjL3WWa6vaLkEX6j5q6VHcZqooNIxMV6/LNyRD2zuMdJZjLs9/d2
         blCbWy3xVAL7oAm52/zI5c+kn7jTxZLvQPvbUGvLNPO9wFvHn/ZR2dk3KDH+i7rjPh0l
         9F96RF2dId1p3+Hrtf5/GlR9munzRQxsYxG0/W/VRuV3N7JjdsPJLQcO+x5L3P8OkYh+
         8Kv2QGLFdtBVY8XocHN0Jn2egtc7xgO/brWpntyJL6fSrz5wdO4Mrdi4eETK6C+fuEn8
         tC1rDv7dkrQLjtcYsEjAdfw/iW9JvUBnsj/PuIYqcbSlnkOvogQXOZcwJihtqi+/tnes
         e9tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792075138; x=1792679938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=27cQfQSZg8Km02AKa/i7F94fYQpUVeN4urNqh0nj9WE=;
        b=oUOgE8JXzVPQ+gPBgDLplvR1MoJNRGw/L78pTTEOtKI9stdp857p+goR38cK03z4SO
         seia+0ENO0nuCPQ/8dK3DZe6DEGJnoGagPRAD2Eneide7ugA7JLDDKZgorIJ0CbyDxoG
         3YmKJkwSFkq0L261u7ERttyWxtmCpKb8Eca8jgFvWl0uraoQPPH3NyjhyyTUmlCyyxIS
         t+rAmb1CHFZnH7FFNVsR68Fvz1IHBqM3lQQlYsvi9zBZuwJ3Uh5gfyYbF2ScaL46i5Df
         kP9X+evYioPFMAgC2fBFQFokESLMBTgX8j2jHsispXc5KaAlIbE+glGpaXy3+l8WPNdU
         Dolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075138; x=1792679938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27cQfQSZg8Km02AKa/i7F94fYQpUVeN4urNqh0nj9WE=;
        b=1UTSOGz1t/WbYQN1a4pfk4aViMowVQEjqA3xVd7RM4EJI+3/YtioaZTzMDo8ObYI45
         YDulFHi54qwCzhDn4ZPTdSOyNKFRfH/GQFHNp1T3PGKWgDr8sR0EAFu6L3WlwwHZb/fY
         PoMsS81mZ/bqQ7m6qpcg30II3IjWC90Xy4mp/VkpfvjNosqqGI6Nsiix8eVoOrI+/aFb
         uFsJmIRGWJF7bPqvI6yp2DaEjV28hkRPVyNKS1AVPjVEpbGOdgFNkG180JIiStDJ0PRR
         14bIryt+DlAc4/qs5PQiJ3hMScHFJ9b/fVaof5UPt9Lkdnj5UI9C1NQ+6QlxTXkY8vlh
         z1BQ==
X-Gm-Message-State: AFq9FYLgN1CGWGFhyoOLVOBVmlPYPzrW2cigx6k8LBQLhpBGUpsnkOSo
	+WTc2TF7gF49JS/EyNlfONrKIfzVQCofG6RirddObFROz+AGX6Z84pz2/bRfyeulRxGqun6Zqoo
	feqJeGjOXE2PybLs5IV5jc6jHczFKpWU=
X-Gm-Gg: AYBFou31L9iL9jEjjWAd65N0Wq+wPR59pVAVnOyfK1Nm5wW+1g4gj7p35nhOtrGP1/6
	WuRuQbfy5tkj0bACo9KVEoaDhW8TPrB/KbbVzfrxMwhTAqPRtP8NB5O634Bsu0PQlPtjET5ls0B
	OOW3G5DGX+FRc3IBL2xYgpXkH7OP6pvc9vCI2dD5jkqB6hErOIk9qf8hO27Li2OvVDqa/bbWM0s
	egeGweiOqxmXaAfnW2L5JFKGW15jZNJ45ALTkpHYw1fLtoOrSQzBhyc7FFZ4Mgr/wLAB3pfV/pF
	umzNBKSKDNEay5nAAJqRuikGGWHZ6J6xoZDoKicN7FkBL5P4lQsxWzQ=
X-Received: by 2002:a05:690e:4419:b0:677:d6b1:d993 with SMTP id
 956f58d0204a3-67936038458mr4413398d50.47.1792075138251; Thu, 15 Oct 2026
 07:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054535.844874-1-omosnacek@gmail.com> <20261015054535.844874-6-omosnacek@gmail.com>
In-Reply-To: <20261015054535.844874-6-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:38:46 -0400
X-Gm-Features: AclHuK_qon0oV3imYuMMNENpdhofYDqF-Sf1dknJF1srjMTxz5qGRy-KbZuIcnk
Message-ID: <CAEjxPJ6i4XvQJYL=OCGom3MQ-DmuBbTGpOTaSjDC6sDRCfzbwA@mail.gmail.com>
Subject: Re: [PATCH testsuite 5/5] ci: disable guest setup in Testing Farm requests
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:46=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> Our usage doesn't require it and disabling it saves around 5 minutes
> from the request duration.
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
