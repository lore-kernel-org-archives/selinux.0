Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251D126F14
	for <selinux@vger.kernel.org>; Fri, 24 May 2024 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553466; cv=none; b=RNPzUSsGeHbKY4v1GGAAl7rzqxojeiFsbIgxjUWMULriPx7GUEJN4yKvBnB7zDm33XJmyLiPGNRzbijLLsS6xwcWGWGqQCxG4UFM3+tAeqIwVNQLaVxogHBcJzKvonGUs77KxfkZm2C8JRwJGngBvge6h/8S73m6yyeLU/vpswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553466; c=relaxed/simple;
	bh=yGpga7IeYI33iGsUpANQuONWyhzS0ndlo/su4E38WCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8KLczP3sANmAWepZT9GL3NOEZaDMFEZ3rDZESx3xJPZfPxAPm/7x/NQ4nqL2GnlIApq7aZ/1Pg2rzyvryzyD4DJqIKfUSmhPHwH5b2aItfVHfC6j+9c+HU0J+TOuQ5qXwpgrYskje7cgVjPeVbk41AQoY4/VAT/+al7czQlYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJeS4ySd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJeS4ySd"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bf5baa2773so752450a91.0
        for <selinux@vger.kernel.org>; Fri, 24 May 2024 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716553464; x=1717158264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvFUmxyEKvJdx4WIzjIszPj7rPxjzjRKKM/69Uv0/+w=;
        b=JJeS4ySd2KaGpY36miGtOcBmli70ToHEL5M+UpW6UNAENKQXQTB1YpsRYDW86YJDG/
         iCtwjM+x+GjiELBmclcV0wwlm/016xv51W2sj2U3pZbltrKBmXZOM7MDA28nHscI4QS/
         PYdrFlCC48gNI4PIdLQin52gEVagfHUdYd7pV49QFKAWmpZziJ25mU/hixmxhgVV7v7z
         8l+dZK+5zrUhAWvaSBG/N0CMAWJMdHBtj09dMItXrtEvlsAaAIJy8cY8ir1D/OkuGoff
         r4c6yqDI9r/29AYNI157OiFsNbZvj78+jyRnM/FBrfOQRE1KPe353Zpe5MZH4UIO2aeA
         QPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716553464; x=1717158264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvFUmxyEKvJdx4WIzjIszPj7rPxjzjRKKM/69Uv0/+w=;
        b=FyUokyZmiT6lXEC7WR9RCBWe1XM8WjG/7trvJkm65d0+BgpcHfhY13mF4tNtENAde6
         X34Lt+AoP7UovXtQL2iTYTS02v/UlRf4lVFdrVccQk+pVaCylCDLfrL/AW8nbPGxUAVT
         JtE6iB4BaFjxUp5K26gSJCFX66cq/9NSuj+Bq6TWJ+pRg6Q1fgnMnzsf+cFPgiLfBGWp
         7CMlpbKU3TI4XGQbJSb3Lxn0zktE64GjpAlGtgkqhkWkzi/UQ95zp4Gb4fcLtVWkNvkS
         GUpfDralWIEMPB8m5sXNkyk4UfQ9pU+azHtgbmyrAwutS3vRq2WnJqzmpy3AVMUl577K
         P/sw==
X-Gm-Message-State: AOJu0YyMF9D58K1CSFSij45eHNtBYjJnzOuo03iHgNMbx2gdkHnaCawE
	CcAbI1TW///ttdsY2HuMrIMM0BhNdNkL+Y1IvbFiNJCEY5ddRuYsK5oayhceBxEzmCL7zibs3Gj
	Dg346rhNPagWwxKIvdbFIC+2m53M=
X-Google-Smtp-Source: AGHT+IHBslWAP97vaxVoOWhxw9fAWKDv+pIDMUPrUxlr/h4cbSU0LK7lu1HPQNwFRfVqxs1rWlDTj0D+wrTBlzeeWM4=
X-Received: by 2002:a17:90a:17a3:b0:2bd:feb2:aa99 with SMTP id
 98e67ed59e1d1-2bf5ee14914mr2105041a91.19.1716553463868; Fri, 24 May 2024
 05:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506174948.26314-1-stephen.smalley.work@gmail.com>
 <20240506174948.26314-2-stephen.smalley.work@gmail.com> <CAEjxPJ6dsy-E98gmfGioYa8aVEZGLC230ZNVyCZL7f9=5Ev35g@mail.gmail.com>
 <CAEjxPJ78Ak9Nc1Mgc=6=4bYcp48AxgCSjcHC+iaeag2ME6G75Q@mail.gmail.com> <CAHC9VhRfnc5aV1UCEYHfZVw9K69SwNDHHVfJ=5-Znx87QX4-6A@mail.gmail.com>
In-Reply-To: <CAHC9VhRfnc5aV1UCEYHfZVw9K69SwNDHHVfJ=5-Znx87QX4-6A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 May 2024 08:24:11 -0400
Message-ID: <CAEjxPJ5cXmbbmUGuFM=rhd83sO11Kpk_Cjz77HZBu+ePXaeLFg@mail.gmail.com>
Subject: Re: [PATCH 2/2 testsuite] tools/nfs.sh: comment out the fscontext=
 tests for now
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:00=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, May 23, 2024 at 8:59=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, May 15, 2024 at 10:54=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Mon, May 6, 2024 at 1:51=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > These tests currently fail on mount(2) calls due to the directory b=
eing
> > > > unlabeled at the point where search access is checked. Until we can=
 resolve
> > > > the underlying issue, comment out these tests to allow the NFS test=
s to
> > > > be run.
> > >
> > > With these two patches, I can run the nfs.sh script to completion wit=
h
> > > all tests passing on not only the latest kernel w/ the fix but also
> > > Linux v5.14 with no changes. So it is unclear to me that the tests
> > > being disabled by these two patches ever worked...
> >
> > Last call - any objections to me applying these two patches?
>
> Do we have any hope of resolving the issues anytime soon?  It might be
> nice to see an in-depth discussion/brain-dump of the issues in the
> commit description so that someone looking at this at a later date has
> some hope of understanding the problem.

I already put what I knew into the commit messages, unless I missed somethi=
ng.
I am not sure the tests I am commenting out ever worked, and Ondrej
said earlier that he never enabled the NFS tests as part of his
automated testing because they still weren't working fully last he
tried. Meanwhile, we've had two separate regressions in labeled NFS
since that time, one from Neil Brown's patches and one from Ondrej's
patches, and only just discovered the one long after it was
introduced. Hence, to me the value of getting the tests running so we
can turn them on in automated testing far outweighs any benefit we get
from retaining these tests that may have never worked at all.
