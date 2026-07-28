Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D91439009
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242076; cv=pass; b=EJ0cbD6hskQT5/2kuun4sejuWIr5BzhXVFBaTd3xWiPDD8UHjzHzzX86wvEXQQQAmmXwL+kfOLvA0kUiiv0antY55JdzsdQKNR+87Dg/sC9MR3mRIwTq1jOr2kK2ZJO27uKyQ7yYNH8++83u14sV8N2QaeeJzU5LW1jmAooF/xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242076; c=relaxed/simple;
	bh=l3zxB43zgx7JTti7uGXREB7aUtU3vA3dZLD82GmHwXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kF+gq5ErTE2AMW8ovUb9VQ73KRuM6OeF3bIP/OKCDxfnS7t82lVdJ5A9UtbDwFS5NFeoXk4Mwbm7aAFZD4mOoaJbySWKEiByIrFlWYsLCvDVPr5CYk78RYxBJpBmGoJBpj3lwd4nfk1DmHvVSUvWehNWh1lpshm/S+7cwQYY1Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0vAhn3n; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0vAhn3n"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so1356710fac.2
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 05:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785242074; cv=none;
        d=google.com; s=arc-20260327;
        b=iOHA/iRsFoUs6AhI/X4oF5URN3sQauEfjwquWj53M9Zeb/TiKuOKhQ0jagPdGNkq0J
         75RPFUfImPFcSxuFg+/p7+Peof0SI6kc2aULs15HVmTuZ6XYsWcCOMsyczxiuJQ7QgPr
         5/Q+UpQbort6YiajIrPAObk8eKke+qLNlybsmb7UxIdoCJngS6IZN2zWC1g2hmK0VMdL
         I2KBZKwvTtz6WjrfhagO2HJNy9Pbvib8/I/kYT01UeSsvb0Ob+zMTb7XgRPDJykWV+DS
         IMiwnINzhqHcQY9T2d7IrNYvGu3yaTk2LijgcJNw7+ZJZghsJq/lj9kHFlRrS5EwXbVu
         ovZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXm6u71gEWtuk0SoEi/s/IEZNroAXzps9trI2r5slWU=;
        fh=J61V3OUGMbPg9PEhaVOaAjeaFLNhlaRAyHIlP9GupwM=;
        b=cXJCFNZ8Cv7bosiJglMv1vye09n8tC7gYou6okrs7IJZm9se2OAsCM8wvA3KywwqHd
         86ONvUkf+hF++URiPtT/Ea91aco/2qtGT6gxrtKv1T/078AFTeWZWUiCyE95so09wj7P
         5b5WgQ3a5bKb5qM5iI8f9aAQd7e8Ipw+qDI6ekSz3czmYgDJkfh8HPsbVu8Pw2V/LuhQ
         om4PlGgwzY4d2eoPVgDsPkLj7uRpV07URTC1wSunsHc70CNCfdYRe1Xe3DjGXbWssvzN
         WiKTZDvya0emEol2djSLViLijrxjto855wYheCDttuBr1aHYmCTpzHZtcaq6aqEayV9j
         ztfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785242074; x=1785846874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXm6u71gEWtuk0SoEi/s/IEZNroAXzps9trI2r5slWU=;
        b=E0vAhn3nJ/XJSVJDCyNTyVgbmrQOh3pfhbaILP5vXFN4Fnpqe+mtQGKdeFF2c5ydg5
         eSDBwe5EATcUkewEcDAITq9drQSGfz/75t7byZ5lHe1FRQnmVVFAPK5RQSSOJkXjg6R3
         cbPtYoZpCW9Bq7ZBNnkljhQnHjKanwb+XgK0XY8VX6cWGA1mdULe0ZbN0ppqzVSs8ibi
         wAQ61Pdinh9qb/pQ021zyHPefa8s4JWgTyeTKN9QH0zJ8ZZ+qi+qyrW49BB5neEL7EV3
         155psgw+1RZIT/8oxhocS6LOUCyvN8NoewroAco8j/52eLzU7Gdck6pjS/EeV16lcAu8
         ZmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785242074; x=1785846874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXm6u71gEWtuk0SoEi/s/IEZNroAXzps9trI2r5slWU=;
        b=ktl1SI5RUjgFDyR3v5d28O9VOouvjqBvQ5eIo0qFu+G9TMLPAZUBV+XxswaXQ2BJBY
         TGjC8xg77yHIA8p4HGQCKrwDs/2GtIAxspYIBEuoZDKeEOi7lysbM1NaOOSyau99n1Gc
         vmCNSK6b/+npy0UJMp/jaNK40FGTolT5xLrmT+wGYHajM93Ea1zOp1ssSaCOVA5T1CTh
         DEJhzZkI9JawmUSUVf9YKFTBLnhIJWV4BNUGyOfwnkfRloYlRqqi5zqyM5NqqJhZ0+w2
         6uAbIFJEfP3lvu8GmK/ap7QfQn671Jnf5Hx5l19esLsDL8lbLNuuh0usM2T4s90SPcG2
         64eQ==
X-Gm-Message-State: AOJu0YxX08zWpAfegmi4v1c0HC+pty/UNF8AOU6yuR4tJ1TgXFb+zwvb
	au2xGDqHpdyH8MUg29g8cXzfct8c6QZ3tkLzqWzxl92bWRAfxESeoJXdgXKqyXJsnDr3VqdsZSi
	lJ/nCf9zUG+d7S2pSpcANuvTuwcWlq8k=
X-Gm-Gg: AR+sD10Gwcgdnw9Vjhhx0RVGC6w2QTXxAFevswiwKcaKYiQxeYxvlOOcQxfIPV7lVC0
	fP94tZLn26srK9BgCMbUNYDJ0XPEZ+IdVLBWEGXqRKTnuM7YzkU83W6QFVGfcMcTjZfZYj20Lf+
	mB/Iuw0cHRtRMPz+7AG5XPjksOmBLeD6yyNZykSJcVRNXYlxIkz9R+qPDsmC1Jq5wv+KF+2wICj
	rSXBIG8xxJWkXJB5SPXd0WxCQ20uHzvo/cmd79O39t0ztsG8vaQER6eMHOXNw==
X-Received: by 2002:a05:6870:31c5:b0:456:9b53:c6b5 with SMTP id
 586e51a60fabf-4586cadd068mr1409966fac.13.1785242074072; Tue, 28 Jul 2026
 05:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727223242.2507658-1-akkohli@redhat.com> <20260727223242.2507658-2-akkohli@redhat.com>
In-Reply-To: <20260727223242.2507658-2-akkohli@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 08:34:23 -0400
X-Gm-Features: AUfX_mybrMX9rZXCGouBvYwRRH8Od9N3coLM-3ZHBj6iQqgVyaC--k5a0HJui-8
Message-ID: <CAEjxPJ4cNnYyN=YSXYArpUwFBSf-CkSNcKNLFnBQ_fkedKPHFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] checkpolicy: extend bad-data tests for type, role,
 and user errors
To: Akhil Kohli <akkohli@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 6:33=E2=80=AFPM Akhil Kohli <akkohli@redhat.com> wr=
ote:
>
> Add negative .te fixtures for duplicate type/attribute declarations,
> type/attribute name conflicts, invalid type names, and malformed role
> and user stanzas. Run checkmodule negative tests as non-root in CI so
> the unreadable .te case is exercised outside root-only skips.
>
> Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> ---
>
> diff --git a/checkpolicy/tests/negative/bad_role.te b/checkpolicy/tests/n=
egative/bad_role.te
> new file mode 100644
> index 00000000..3aae2719
> --- /dev/null
> +++ b/checkpolicy/tests/negative/bad_role.te
> @@ -0,0 +1,12 @@
> +module bad_role 1.0;
> +
> +require {
> +       type foo_t;
> +       class file { read };
> +}
> +
> +role bad_role_r types ;
> +
> +type foo_t;
> +
> +allow foo_t foo_t:file read;
> diff --git a/checkpolicy/tests/negative/bad_user.te b/checkpolicy/tests/n=
egative/bad_user.te
> new file mode 100644
> index 00000000..e7460dd7
> --- /dev/null
> +++ b/checkpolicy/tests/negative/bad_user.te
> @@ -0,0 +1,3 @@
> +module bad_user 1.0;
> +
> +user bad_user_u garbage_token;

You might have missed my earlier comment, but again:
this fails NOT on "garbage_token" but on "user" because of
the lack of any "requires" block to meet the grammar
requirement for avrule_decls. Is that intentional?
