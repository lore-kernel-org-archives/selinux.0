Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687E2E0907
	for <selinux@vger.kernel.org>; Tue,  8 Jul 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984705; cv=none; b=qua/7lko9TugVPNCqCMZvIwLbIFbEkmLTWDuOnBkhTfn0jVXCQz2uXo+VhfDOIihPBTSyoksVljNvf0WycnYXL/0SIVbxfpestrvmOtBiM0LWutsQe+rBEZ1Gu901ARCHk8ts2aCd5Oy866iKDzWgcUGbuBEG003TIHXCzGNHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984705; c=relaxed/simple;
	bh=lhTIhW6KttUH8Yh3e6uVk2azeuTr9Va+o1yJVEl0h0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZG0hDE1zEGvNDedtcPMB7VVtWLY/RAQOOne/4uO2u98OijMbRiiukh7tqUN6BIgUpGgCYsxo+0Eph5qyOs3wEMCEk0/qVemCGTM0mBqsHVTEldMrL0l+LQxRBn9K9zs3+anoJJKcsqeLrWDQZ63F6OgMxiIHqjC3LBU/BHh8rig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2mocPx1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2mocPx1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b392142d426so1431951a12.1
        for <selinux@vger.kernel.org>; Tue, 08 Jul 2025 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984703; x=1752589503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuzVgajKv6MP0FVSrtQ20joRZWMYlHeNeCbJbnygOPg=;
        b=R2mocPx13thvylYFTz/CPyvelJNANxVXD2dwh5hu5FxCCu6jNgzM6EsDi0gAN7OEBq
         QZ2nFiprmMQupKiI0TZaybkZVTZjEiiOT4WZ8aBt6/UWN7Msd5qGEQnjGSXbBh9oAh+m
         ZkxT8LKbqbe2JZcpF4yGzglgkOUx2OFGTpHr1To7j6GzLLkqw7/PlgmI0evN3TO9sQhR
         uaiVOWxdqfevsnKhlghLGqQvcrAwzJneECGGT4JOwDlRySGpx4VcCkhmTNevJ71/AwjH
         +atfc/hXsZoNTw9foQZQOXFBbac/35H3utda8YWlpBEjwFr0qqBmdkadUder0+9XN2U8
         HgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984703; x=1752589503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuzVgajKv6MP0FVSrtQ20joRZWMYlHeNeCbJbnygOPg=;
        b=hJf1o+jfFvIYzjKJ3B92ioyQJXa/4NRZk4Zed/lx4mwQ301bPvinRrpPGYIhi8YIgR
         Wr4tvX5Bz9Jjcq8G2g28U9GX0quS0usr9SRHzoLqwiNl4I7y7ZfGOC59nATVL88u3Vu0
         LHSon8WTvznwaH+OOGtKpGuBcOBC0tMy13JwZuaThjOWd7chyI3UkF4P5sKloDOzTuqq
         Xx6s5NvEuMXwNIqBGbqSQfioG1L3iMXeeiY5vgq5Ecn9MbwLgdcVYOz2eslApcZF7a7g
         QfVD7uWzyqnL9AK1MNes2dO2cwxKSxu50nNh4Ldq6Yuw7LDQB6XC/qNyg5GgYABsFeEy
         Qwzw==
X-Gm-Message-State: AOJu0YwBegQBmHka+zOHu+RXqGKUNkH2E4Rwm9jh8ZoUUQHHJjT7kgje
	mlj8BPqBvm4grxbPwBJWj7dqbVUZ1Zb3DDfji1XFV17fh9ZESaTZ4oB6JFwDcUkB3HovU3rQPPp
	wjT3mE3yp2HQLaVdt02ehfDRtVL7jCaw=
X-Gm-Gg: ASbGncvM+RsaTHhmfneaHXmWN1gdcQhySooW2cDQ8EkDVZZRqL4SDqCAXzNS8Iqyz2m
	QXa32W3Pxh/8wFFF0I6r8ldOgtHiLrvW1WFL5uwyHfbAL1qePo1LbrD7PIBMG/Rtb6MZy8yz9gS
	UOUz/vWpycL6GII1pKwzCCtEh1rnavS4BYh6bBtXeoaVQ=
X-Google-Smtp-Source: AGHT+IHsw9Rh3yRiGxRQkRdbIaRxw7j1LGnKXKPLme+CwBiiIIK7hiDd2UiUwnFiKk7Y2tYT67JhHDBGrFtNjVUf04E=
X-Received: by 2002:a05:6a21:113:b0:220:2fe9:f07a with SMTP id
 adf61e73a8af0-22b668e900fmr5181199637.6.1751984703078; Tue, 08 Jul 2025
 07:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250705121424.1221268-1-omosnace@redhat.com> <CAEjxPJ7Us8cwOJp7voShry7iDkSMHEv+-RObUncVx5xwZGbLEA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Us8cwOJp7voShry7iDkSMHEv+-RObUncVx5xwZGbLEA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 8 Jul 2025 10:24:51 -0400
X-Gm-Features: Ac12FXzfP6MFXM28oK3YH0M25jaEmHkq7cJf7jhbVTuE4GS4N2JJlXZj1s_FItQ
Message-ID: <CAEjxPJ6D9sB2mtgeutogVecczrU+0op-aGAFpzzDfwGAzVuWLw@mail.gmail.com>
Subject: Re: [PATCH testsuite 0/6] Make more tests run in the CI
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 12:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, Jul 5, 2025 at 8:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > This series adjusts the TMT setup scripts so that some permissions that
> > are currently not supported in the Fedora policy can be tested. It also
> > cleans up and fixes the module_load test so that it passes on both
> > x86_64 and aarch64.
> >
> > Ondrej Mosnacek (6):
> >   policy/test_file_load.te: remove excess semicolons
> >   policy/test_file_load.te: use testsuite_domain_type()
> >   policy/test_file_load.te: adjust to kexec behavior on aarch64
> >   tests/module_load: run sh instead of bash
> >   tests/module_load: fix the location of "2>&1"
> >   tmt: add some missing permissions to policy before running the tests
>
> I acked the entire series but am fine with either one of us merging
> it, whatever is easier for you.

I went ahead and merged it with my Acks included.

>
> >
> >  policy/test_file_load.te | 84 ++++++++++++++++++++++------------------
> >  tests/module_load/test   |  4 +-
> >  tmt/tests.fmf            | 28 ++++++++++++++
> >  3 files changed, 76 insertions(+), 40 deletions(-)
> >
> > --
> > 2.50.0
> >
> >
