Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD5Xatvl"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7995
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 08:26:15 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bfe99b6edso622797e87.1
        for <selinux@vger.kernel.org>; Mon, 04 Dec 2023 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701707173; x=1702311973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+/tD+TLAH+A11lbU7xHJ+HLglEMoiGIyDrqdEuHry4=;
        b=UD5XatvlEP/LiU7hiNnAtPyoX5oGhfePSqSsjn+n/TqRgj1fYuQnmaL/MDowVltSGm
         FxsLnJdd5OJkN/sudWPTLzCeRQ936rCVshZ1L2T48KcIDWuxkn9Bw5UhkXExMwhJv2lT
         UOtxKCP2ZWMwKgJRR4fVuP0fvZt6MTISodFyea5QTJciJ553ukhgkD6c0lw5guaN0FPk
         wJhR8ri1rndKBz1PemedZuU5F06btxLnWJYVLZrcy0hNPzl6/eTijp2SPas9rOR++Qk3
         r3lvFV8equhFlsq8Quw0jiJaFqzqFMA9ruI/9hjLEPlp6v0KjMHKp33O8Tq2x7dw6Brk
         XW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707173; x=1702311973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+/tD+TLAH+A11lbU7xHJ+HLglEMoiGIyDrqdEuHry4=;
        b=XDT1kb1biQrOMeOpPId0z0zXPq82Ljkty/9vfKSaRZ5nDYzJuU/AxIdL6ccHigBsVE
         FGCylbzFtdofHb1BjE1SJtBlv7xf13qqahIRpv1ax74W7STdQ27x1OImOsF77VXmVXgs
         VG6QoOpRMWT0ridhSa1UySk8P8BIW+SPTYObDoTR0f/BBDuXUc4aX0NtN5f9aoKE13Er
         I3OhTb2mI9dV1XVNvtIQlrcCQlLm/IzsCJDJDnIZ3wx1KkI0ZWmCeMCrTlLhCy1F+VzM
         esTrUyIz2gBULGhdbkqxtZKAWOeJWd+ZCNGeWQrmYYdbxrU45w/yyRyb/UT7NVmVJqnW
         UdQQ==
X-Gm-Message-State: AOJu0YxmWnQIVj8UDv05geOLAGoHdeM+f7iNrDDa+qGf71AwPwP4VwdH
	M/0jH9T41VSSGLS4ipfA+V+NNua0fRGOWJvt2OFtmpLo
X-Google-Smtp-Source: AGHT+IHwHKL2Umxyhif7DagBGQyiVvOD327fP+ZaV8v8AcM3k3fT86TeFI/FzRYkp9NbOI/QcfeNYZwWkO97MCIEoyk=
X-Received: by 2002:a05:6512:1593:b0:50b:fc77:2d51 with SMTP id
 bp19-20020a056512159300b0050bfc772d51mr726355lfb.45.1701707173159; Mon, 04
 Dec 2023 08:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877cluszxo.fsf@redhat.com>
In-Reply-To: <877cluszxo.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Dec 2023 11:26:01 -0500
Message-ID: <CAP+JOzStqUftw9NVjRouxbDe=_naUsvX=A=HxQ3yvDDnMq=+iw@mail.gmail.com>
Subject: Re: setools build is broken by 61f21385004 ("libsepol: rename struct
 member"), revert?
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't have any objections.
Jim

On Mon, Dec 4, 2023 at 11:19=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Hi,
>
> it's reported at https://github.com/SELinuxProject/setools/issues/110
>
> While the API change is described in the commit message, SETools is not
> ready for this.
>
> I haven't found a way how to use COND_EXPR_T_RENAME_BOOL_BOOLEAN in
> Cython code so that SETools could be built with 3.6 and with older
> releases.
>
> I consider this as a blocker for 3.6 release and therefore I propose to
> revert this change and leave it for the next release together with the
> proper (if possible) fix of SETools.
>
> Objections?
>
> Petr
>
>
