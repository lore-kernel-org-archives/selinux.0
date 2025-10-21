Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71BF2F546E
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054566; cv=none; b=dC/rJGasF5h7VuNnayr0K96Fvj9n0qb7Q9Llqbdn5JKufo/+R2KgnUG6TN2fETf93vvlex1QaNwSFJBn0KguYIHRlTMPvaYC2QLtLpJfSIeZoKXocSSEmiUtfO+WdZDW4kZjSE8Y8+wvVYXrPmfbxbiOIBjwTfQ4r8yY27TfPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054566; c=relaxed/simple;
	bh=56rfWiR61m21EgWCGQmgQ6ty4BYhDFnVzAqGJdmXX3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QK7E3xbbxd1lCa64e+wCQPKh0INokM+XACMOrgiP3NbU0nOeeiuHRgo/7bUFK1lLiEi0dIuUh/yAbVXIFh7NcjQI0zAUv98NdyD8JF2iuAlvALI4VQ5+G1zFDc2HBFYFQa10dFJGM6JTfvwvjpfticcfo/bKB6dSIr0dMJul6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibuUqhua; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibuUqhua"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so5462183a91.1
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761054564; x=1761659364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKIO/1fswRA2uqghGUsx+29cDfZiaaPYy/NDQNXGXEc=;
        b=ibuUqhuawtdRIgYZtLDaQnb1QSGEdgHcDGOazCEyiTGBmbbr1VSUOWQnQmQf4xO3Gp
         XF/yDpJbL+Ntntgb36RDiG6205l9/t3yLXxtXbg0g+d9MJpvQLam2S+XNgljzCmIpyGu
         QGcYNKPegceRVsNjgrS2U8OlwF0baCLpqyKVyEt8ADMhG7hE1mOd4UXsdQE+HsUZmu+8
         rAJStNVKodifbtMsFBhV5k4afraypAGWtC6IqlrjGd8Nu7beiSwpKRKJnQulKs8AmxSJ
         VpLED7GQJAQLs/yb9gMct+5rAz0W4FNA4l4YLLYJ7dMpday1drIAmbXXowrqUPDGNUX/
         suOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054564; x=1761659364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKIO/1fswRA2uqghGUsx+29cDfZiaaPYy/NDQNXGXEc=;
        b=hS3z3l0/lAybXun46XL0iDYV7N2rDptwJy5lj/6VKXCvsXgu0uS/PpVpbSwemRSTAe
         +QSBOmxKp1hkg9inthe/q7M+MbOi0OQ6DM/bZzXPFFtC0D9FKgO6Sgd6CjGadoQnSPdW
         ThDRSm5mfoTne4v0kl/+ikUdIM2g5Id5orWOydG7pjZ53+GTXH0kcFdrHSyGchdq4FEo
         zwhGQ7baUMo3QK5UKNyb99KBzb/ctL959X/UD8GD+nqzZqepz3dxCI9nRBw1ax4ea6Wv
         r9ownLyircH0lrbL4Q8lVthZqFJ7tJu+wq+WJeZwQch4CkGEIFHpnSUHi4T1pxgeM5BZ
         JTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXSyNFxoxf7eMyTt4ZbpAH/p9NeQho5Y5uktrWqtTw4pGplcLFerE+c/uKSXa3sQDBKPRqvNZw@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlmGPvtW2YqfcpS+bTbdGxD3VUAw/yVmtmHqKan5FzRg9iOfG
	36ffTwuCamy344QW9vx3fwBfD5ZM7Wkf1DjTHUgHes8mjO9a8jBCA1jxMHWjeqk7QMYBUO6bHxj
	UqdFNiVIT3h6qLH8wYdk/IvglSteCQAw=
X-Gm-Gg: ASbGncuKN63i2E9WYim3cjb7FJ8g+LLs+1CKeIH/qrOKBT7En8lt701VpBaer0oyz3U
	4PMU9m4n3z8KQ3Gc90+6u400Lq2IwVBdccjTGpSABVO5Qy2JpI8QwGM/jTZBWp6J/TKa2sCYJRb
	TWmsXtvMVAFV79ToVSt3ncqEhewueSL9IvObfaA87u2yH6yLZ1gUOc0hXY6GEixEprx8gbTHOr1
	egyv8D+4kPZ5UzGJiz3J5QbGx+0kBDgqC1bcoII7RbSBhNnpBgHAkraIrHE
X-Google-Smtp-Source: AGHT+IF1ydtMXuDwDBYZbc2G34YuwHZqU7lV8slHYxkelYLWjk0fg7gX+1UkuFc7nZJS+ncpJYfU918TbgiN9IAMtRY=
X-Received: by 2002:a17:90b:3c90:b0:33b:d371:c361 with SMTP id
 98e67ed59e1d1-33bd371c454mr20997536a91.2.1761054563898; Tue, 21 Oct 2025
 06:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020140732.4703-1-nvraxn@gmail.com> <20251020140941.4769-1-nvraxn@gmail.com>
 <CAEjxPJ6-po0nSioWywXnkPoxYBOSmdb6dQQud3dT5sbxs_RHqw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6-po0nSioWywXnkPoxYBOSmdb6dQQud3dT5sbxs_RHqw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Oct 2025 09:49:11 -0400
X-Gm-Features: AS18NWDm-DkLyMLsO39jCWSY5DIqDo5maN9Q8JDy3BR4GSfLiJEzpCa-KKCjcqA
Message-ID: <CAEjxPJ5tFQeRTKravTn5irxozkBhnDz-GvoDcb3DXf0Uv0K=Bg@mail.gmail.com>
Subject: Re: [PATCH v6] treewide: add .clang-format configuration file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: lautrbach@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:55=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Oct 20, 2025 at 10:09=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> =
wrote:
> >
> > Add the .clang-format configuration file, taken from the Linux kernel
> > repository. We don't have any official style guidelines in tree at
> > present, which makes it a bit unclear how to format C code for new
> > contributors. As well as this, different parts of the codebase seem to
> > been formatted with different styles on occasion, so using an automatic
> > formatter should resolve this.
> >
> > As well as this, replace all the existing indent targets with a single
> > toplevel `format` target. Managing all the source files to be formatted
> > is not pretty to maintain, and doesn't really give us much.
> >
> > Also define a toplevel `check-format` target to verify that all code is
> > formatted properly. This only becomes useful in the future once we have
> > reformatted all existing code, but is wired up for now.
> >
> > For the future:
> > 1. Reformat all existing code. I understand this is a big change, but
> >    we may as well get all code formatted if we go down this route;
> >    afterall, it's not like this will cause any breaking changes.
> >
> > 2. Add a CI target to check that all code is formatted as per the new
> >    clang-format configuration. The `check-format` target can be used
> >    for this.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged this patch but as I noted, will defer to one of the
other maintainers to apply make format prior to making the next
release.
