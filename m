Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDF1B3758
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648429; cv=none; b=mNp2fv8AX6u1pwDVUPFAiSO8yUTFWo1upaEwkLTsiUU+CU1gQ4lI8oplpAGzZZZJ88Db4ZD7zBhEyEMCO7tkO9qjnXCrtCGnen5ObmVpGFBPjOOfNl2YbLrcgp98y3+9atxWSIPmlHl6Eansfz8kipZenfKRMWS9LSBGKDsHz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648429; c=relaxed/simple;
	bh=xchCpsjRgDt+1FpeDwE9wT2UIuSmuIQeVcehD9QaCcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9Bvzsp31bSQ9txbRoe+nzuCqa0YW5H4DP1X2+HCkp0ASymMIaQeyUt+UYjdcEFOlq9CZYWIDHbVjCofuVyMVRxqivsu5SI1zyq6JSZJDo2t0DfGpmtn+GG3UV+kKTaGOjbo9OKP5m7lMp9bVyNXqlGTbTrIoYdTF0Eyqkk/PJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FNrYCG/S; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FNrYCG/S"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6a4778dad26so286967b3.1
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723648427; x=1724253227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX+IfIKOESuUiIvW3aOFuEwOA14R96wJZLKJZ4T5b4Q=;
        b=FNrYCG/SbHCqEIAMrOXjm4fl3iebzvr+l0CjMTZ0y+OoXSoUTR1d1t2BgoLeqGLc9a
         vS1yrnKXHQQN2970ZFIBkMdoF6QJArBKK8MaJn3gQaOkwFhaCgvLzo0Kv9POVfX6or2e
         AXl6/jYdNpWT8RhZhvI3CuXuaTUB19NUfj6knQ2H7IGjLu+CUE3u2Xba1dNQ+7hDkZy4
         +lTy67pb099nNgGgWrMXA3+R2tCzyjW2WZo43KUQdiAPRMOBLJVT+Yp3lK2+yR6E40Bk
         LDqK+hyObU6nfo8IfPxyVkQNtq14jm4BL/e4CSgvVGEcEsok19OdI5fyU+hXraUWHxXe
         HhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648427; x=1724253227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX+IfIKOESuUiIvW3aOFuEwOA14R96wJZLKJZ4T5b4Q=;
        b=e49cYb+zZWzrazZgFtN5rVobGJWWdWDYP6PUTjzH2aN/5A7n+61gpmqj3neHi/Erra
         wJF7LEdFs4L5hGwSJcOyP9bJSik3Xs2Oc9S8Fv73G/JyjVa+kEzYHc7Foj4G5ENL1+Gx
         Y7ZmCOfqReRgDsYoSnCB/nSiFPTAfo1kbllrGl0qyXjJtGyaW4UwQHhFTz9aQUckYwc9
         QWgIDTvChHJrpIQtIlC7w5VwRQyj+1aVJMUnONmiI9VfRKu2cNMa1xW+DkeiCNPWrguz
         j08PFumm191HpZeqlB/0nl5pXGGyR/nzEJUraydgQok+/iwxob/UWk2dCtNvLMG+4/xI
         euDg==
X-Forwarded-Encrypted: i=1; AJvYcCUWPAzGd+lpqYDwtdW1CjbzBYezK38IQgQ7vyE69FtHcPfVIfl4Kg+9E6dzphQSILkBei62eZaVAb0TMAnjC0bie9KFUb+LuA==
X-Gm-Message-State: AOJu0Ywn2ISpOjSJ+TSgkswix1FKmtLitqccpFCGUTomkZHuvPxigJBX
	ZlKHgJ45vdk5xrjC7kTcgnIM4X9OYiTqkSD/V5gMYaAYnDhDfBduUL/RjkzVMh5uE6BP+rgDcn1
	reT+khrBJ38FeBPuW+Dt4YFyznnSPVN47wavb
X-Google-Smtp-Source: AGHT+IFooUxqBZZcqOQKLdlMNlZ2peRqQY9osovnnhB7zHJX8yyywSseq/vOHjb+0XSGyozBIt2AJXkETwlIdZd8LCs=
X-Received: by 2002:a05:690c:2a88:b0:6ad:feb0:d027 with SMTP id
 00721157ae682-6adfeb0defcmr14160067b3.19.1723648426820; Wed, 14 Aug 2024
 08:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812174421.1636724-1-mic@digikod.net> <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
 <20240813.la2Aiyico3lo@digikod.net> <CAHC9VhRrcTo4gXrexb=fqEGbNcynKUUoMWR=EseJ+oa0ZM-8qA@mail.gmail.com>
 <20240813.ideiNgoo1oob@digikod.net> <CAHC9VhR-jbQQpb6OZjtDyhmkq3gb5GLkt87tfUBQM84uG-q1bQ@mail.gmail.com>
 <20240814.OiNg5geethah@digikod.net>
In-Reply-To: <20240814.OiNg5geethah@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Aug 2024 11:13:35 -0400
Message-ID: <CAHC9VhSC+Qff9gtQ9ZM7mCUPWFqiO23tb=4Er7eYAQTUFZRs6w@mail.gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:35=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Tue, Aug 13, 2024 at 07:39:45PM -0400, Paul Moore wrote:
> > On Tue, Aug 13, 2024 at 2:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Aug 13, 2024 at 11:04:13AM -0400, Paul Moore wrote:
> > > > On Tue, Aug 13, 2024 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > On Mon, Aug 12, 2024 at 06:26:58PM -0400, Paul Moore wrote:
> > > > > > On Mon, Aug 12, 2024 at 1:44=E2=80=AFPM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:

...

> > > > > it guarantees
> > > > > that the VFS semantic is always visible to each LSMs thanks to th=
e use
> > > > > of the same f_owner.cred
> > > >
> > > > The existing hooks are designed to make sure that the F_SETOWN
> > > > operation is visible to the LSM.
> > >
> > > This should not change the F_SETOWN case.  Am I missing something?
> >
> > I don't know, you were talking about making sure the VFS semantics are
> > visible to the LSM and I was simply suggesting that the existing hooks
> > do that too.  To be honest, whatever point you are trying to make here
> > isn't very clear to me.
>
> The existing hooks does not reflect the VFS semantic because
> of the `if (force || !filp->f_owner.pid)` checks in f_modown().
> When f_modown() is explitly called from user space (F_SETOWN), force is
> true, but that is not the case for all call sites (e.g. TUN, TTY,
> dnotify).

Thanks for the clarification.  I believe moving the hook as discussed
should resolve this too.

--=20
paul-moore.com
