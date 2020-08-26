Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79068C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D82E20737
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQyFvYOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZSYF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHZSYD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 14:24:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DDFC061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:24:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z195so2371244oia.6
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MsD9J4vfiXCh6HZDHsMivB6sotpzrk3/3YnIekYpgXI=;
        b=dQyFvYOWEKS2L4hpUiSZfm/abREQzc05S7Teeive0umnErk7DfiSQePtUhSbvcktzF
         sSDy+BtbO6KfaHFHxjvg2vX9EAlVhR+/XUJvYBg3GgV9boz+gehgV6QDKA7j5O9njTKI
         3dP1g/ruqtfs+wIrh80f0K4ElNOH2/byzp70DK4hgft8PvV4LLHR2wuqa5hZ/Jjh3Icg
         8mWYuQAr94/jh4FQQVqRxqa9CqyA6xe3x2DOhYGSHbGB/X+hbdcoTn6KfWtucbVn6MHr
         D7kfXPAwta/STLALREC88kj3qOHI2JRHC5v0riE9nk+JovQDTMV3naXSjwX4QxnECdvq
         w6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MsD9J4vfiXCh6HZDHsMivB6sotpzrk3/3YnIekYpgXI=;
        b=fRG3WeN1Hvn+XSARbAsClh1/sGEyarEm3dwRwNIF/S8HiDvoa2kkogH1I2jCao5+SG
         QsYy8x9l0jlv+rB21rHvOvTdZYsQyzI7JCbbGoyxExwtPYMvF6HRUAGIZh+h/ByECPAP
         T1BmFIInrTD/lR1r8W71H82KZs0lHwJx0nwyEDpV9yXoKub+kZrl6EXAUsjBM+h+8nGv
         F763zwF8jFieuq4sSf7NddMmng7Y4ySLAr61C0lOxJz5uBixi/px96SpBmp41cU3Xb3R
         WINc7ovGCTUEbwUa+N5DmtiTk3lDtObmfoHus68BhToYMURn5r7CQbioC0Zmw6/PieYL
         DMrg==
X-Gm-Message-State: AOAM533rDsORA6smi1HygO+wUvpf+4ZzjyUNuXTZE/cpz8MJFjbY4WR3
        A0/RB2utjA0g5rR0UVrcG1I/jI5BTeOiOE1pOtuL6wdP
X-Google-Smtp-Source: ABdhPJxDqxJkSanyJr4CKvAsTUBexudDx5t/KEl3+kITUjZew4Wwu4I8098OjOwLB69Pi/R6jI2Mr2tIgjvs9k0S34c=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr4421979oic.92.1598466240975;
 Wed, 26 Aug 2020 11:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200819150534.18026-1-cgzones@googlemail.com>
 <20200819150534.18026-2-cgzones@googlemail.com> <CAEjxPJ6Mr3-A8j6+3abwghfQKQ=Q-hCKd4PNSuA_QVCjk6jyJw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Mr3-A8j6+3abwghfQKQ=Q-hCKd4PNSuA_QVCjk6jyJw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 14:23:50 -0400
Message-ID: <CAEjxPJ6AVfMDRLQrg11sfcFtmhytiPj_7TUedK3vYx8X9wZd5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] sepolgen: sort extended rules like normal ones
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 9:46 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 19, 2020 at 11:07 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Currently:
> >
> >     #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D sshd_t =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow sshd_t ptmx_t:chr_file ioctl;
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow sshd_t sshd_devpts_t:chr_file ioctl;
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow sshd_t user_devpts_t:chr_file ioctl;
> >
> >     #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D user_t =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow user_t devtty_t:chr_file ioctl;
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow user_t user_devpts_t:chr_file ioctl;
> >     allowxperm sshd_t ptmx_t:chr_file ioctl { 0x5430-0x5431 0x5441 };
> >     allowxperm sshd_t sshd_devpts_t:chr_file ioctl 0x5401;
> >     allowxperm sshd_t user_devpts_t:chr_file ioctl { 0x5401-0x5402 0x54=
0e };
> >     allowxperm user_t user_devpts_t:chr_file ioctl { 0x4b33 0x5401 0x54=
03 0x540a 0x540f-0x5410 0x5413-0x5414 };
> >     allowxperm user_t devtty_t:chr_file ioctl 0x4b33;
> >
> > Changed:
> >
> >     #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D sshd_t =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow sshd_t ptmx_t:chr_file ioctl;
> >     allowxperm sshd_t ptmx_t:chr_file ioctl { 0x5430-0x5431 0x5441 };
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow sshd_t sshd_devpts_t:chr_file ioctl;
> >     allowxperm sshd_t sshd_devpts_t:chr_file ioctl 0x5401;
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow sshd_t user_devpts_t:chr_file ioctl;
> >     allowxperm sshd_t user_devpts_t:chr_file ioctl { 0x5401-0x5402 0x54=
0e };
> >
> >     #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D user_t =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow user_t devtty_t:chr_file ioctl;
> >     allowxperm user_t devtty_t:chr_file ioctl 0x4b33;
> >
> >     #!!!! This avc is allowed in the current policy
> >     #!!!! This av rule may have been overridden by an extended permissi=
on av rule
> >     allow user_t user_devpts_t:chr_file ioctl;
> >     allowxperm user_t user_devpts_t:chr_file ioctl { 0x4b33 0x5401 0x54=
03 0x540a 0x540f-0x5410 0x5413-0x5414 };
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Both applied.
