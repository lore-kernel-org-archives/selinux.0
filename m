Return-Path: <SRS0=e+Ck=VN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB94C7618F
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 15:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C048E2173B
	for <selinux@archiver.kernel.org>; Tue, 16 Jul 2019 15:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzDHCy4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfGPPVH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:21:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45959 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPPVH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Jul 2019 11:21:07 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so40482328ioc.12
        for <selinux@vger.kernel.org>; Tue, 16 Jul 2019 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZxGFUb574qqiZEX401UVLYCsFrwl2X4yftIqXzB5TJQ=;
        b=BzDHCy4j/ygVXRYOFTm8tzwbjLj4BDTspHk1qNTwJGc4+XaiCunBYKqryDDzvHRHKy
         XEAT+kocTXQ/vIdYDYGa4Y7BD66klE42K81Fx+ES1BYZdP6BPJUPo7+jeSLnZ+Q95u0T
         pjIyTcjU2FASYBrL58h47o5FUWBZ3RmGkiiCHNLeYgm28UNnyrdHCacEfYcmJo9K1HbK
         3eP2yydurKh61RCDhyRfKSsfDddtQAxOUE45wVvmpm44mfDFEbtI0ixyuKbjA7Hk6gfg
         O8HRuZZ7OzXLCwANo7v9IS3MOkmsgYkaGSUA07joJr6xNTNOiJZCZUeqS70pbeb45jJE
         3g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZxGFUb574qqiZEX401UVLYCsFrwl2X4yftIqXzB5TJQ=;
        b=bMJ8UZQsRFL+DLurWJjuJEScDIoFis0Gx/v/EgRoLf2BMi+KmZRZAZi/fBypuLEqY3
         0cSeAzKYb4rg/ueIFBIau4iCvkCv+mZf5oV5t4IgZeXTh+BHXGyqU16LBRTPfvv0PahB
         3iy99yZUVDBlw2EywvuoPHjPl/43Z42FaKAmzdD1CeK4XmppBDLylK2fkWLhgUnEasJd
         5mNDRvvT7DkdjoQ0pIo+xn6Mcp3zG+3Ye0oeQP5p8YFeMf03/c1RiyXDhosf2X1qsh+v
         uaxJb0iDhVm10NWUYlDU9QFPiPbxug8ZVppZNWNYSX0LvX6CHFpLeVNhrSe18ROEVIQz
         CeDg==
X-Gm-Message-State: APjAAAWoZ5DdCWuTnQLaM3M/uQjnElF2kgDJ9Kj23DMyL5tGGZcpxX6e
        7P6PLbzC1vLk9BhRdonR6yeo3DObr9J7+KM11FHpLxuJ
X-Google-Smtp-Source: APXvYqy2x4Ee+I2UNg0bpjP32LDODXKHZAu1XY3qrmkEJB+7mrkpAGodiaUXacZtideC9aq9zCIv0pYQa3CnqliLuaQ=
X-Received: by 2002:a6b:6012:: with SMTP id r18mr29576837iog.241.1563290466346;
 Tue, 16 Jul 2019 08:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190715144502.30547-1-bigon@debian.org> <20190715144502.30547-3-bigon@debian.org>
In-Reply-To: <20190715144502.30547-3-bigon@debian.org>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 16 Jul 2019 10:20:54 -0500
Message-ID: <CAFftDdpaEeCQiw6KNDQq+_RO48GNuDmLbxMAb1wxQp9ES8sEWQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mcstrans: Add reference to setools.conf man page in
 the daemon one
To:     Laurent Bigonville <bigon@debian.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The three in the series LGTM. Ack.

On Mon, Jul 15, 2019 at 9:55 AM Laurent Bigonville <bigon@debian.org> wrote=
:
>
> From: Laurent Bigonville <bigon@bigon.be>
>
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> ---
>  mcstrans/man/man8/mcstransd.8    | 2 +-
>  mcstrans/man/ru/man8/mcstransd.8 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mcstrans/man/man8/mcstransd.8 b/mcstrans/man/man8/mcstransd.=
8
> index 64774a52..9a5922ba 100644
> --- a/mcstrans/man/man8/mcstransd.8
> +++ b/mcstrans/man/man8/mcstransd.8
> @@ -29,4 +29,4 @@ The program was enhanced/rewritten by Joe Nall <joe@nal=
l.com>.
>  /etc/selinux/{SELINUXTYPE}/setrans.conf
>
>  .SH "SEE ALSO"
> -.BR mcs (8),
> +.BR setrans.conf (5), mcs (8)
> diff --git a/mcstrans/man/ru/man8/mcstransd.8 b/mcstrans/man/ru/man8/mcst=
ransd.8
> index 90247c32..4cd68c17 100644
> --- a/mcstrans/man/ru/man8/mcstransd.8
> +++ b/mcstrans/man/ru/man8/mcstransd.8
> @@ -23,7 +23,7 @@ mcstransd \- =D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=D0=BD=
=D0=BD=D1=8F=D1=8F =D1=81=D0=BB=D1=83=D0=B6=D0=B1=D0=B0 MCS (=D0=BC=D1=83=
=D0=BB=D1=8C=D1=82=D0=B8=D0=BA=D0=B0=D1=82=D0=B5=D0=B3=D0=BE=D1=80=D0=B8
>  /etc/selinux/{SELINUXTYPE}/setrans.conf
>
>  .SH "=D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=D0=9A=
=D0=96=D0=95"
> -.BR mcs (8)
> +.BR setrans.conf (5), mcs (8)
>
>  .SH "=D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB"
>  =D0=AD=D1=82=D0=B0 man-=D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Walsh <dwalsh@redhat.c=
om>.
> --
> 2.22.0
>
