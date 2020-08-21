Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EDBC433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 21:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2468207CD
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 21:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ULomP/h5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHUVKE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUVKB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 17:10:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F8C061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 14:10:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kq25so4057767ejb.3
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 14:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1GxeclShnz9s6YooeI4FTefDOr5GR0mdhr3H0v41iq8=;
        b=ULomP/h5zFTlK6svQoBHF/IY5NXh3ZFjFpYZi4r/DmgHSy9n0NMnL40xhDiTVrBqCA
         qWq+MSCwrWNKuOjgEsiabvf3Gkq5kKn/GU9zOfjHzFhZRu7wcZJr3CbM7mf1CYr9PWtI
         Hxybv7hJSJA7mQjOs6K3g0XUi4tYBRPGRhB2BHqpM3IE9Pa2qvTqstR8uBgqbWWhe6HP
         ZbHTHYsvq81ikZ1MGtAcM1fJqcNGeX8z+oxNg5xrrOkXFatp9LK6qEV8ObrLMZiKGmFQ
         4viLkDIN5bTT7Urlk7RA8BbHEH2aAOVvSt8ECoaghv+LdOF8rM2Sb2MwctjeQHrJUCTv
         3WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1GxeclShnz9s6YooeI4FTefDOr5GR0mdhr3H0v41iq8=;
        b=DhSOhhVoxnN07CMCnRXPJRah7VuNd+jVHL1YKoBafuvR/Fqcg+voMUJPPPwOzsHEEA
         kUkcMACdirgPAKhAulIG3dsO0yHhrwfb27DpatSzDj7BsuRdNFFvnpLZqhTReQJMNjlR
         bn0eE/HvYgtsTk7HmUsryjNl/2Ghz1BwCQkjJZd3Rng5IBW55V8Z+K005KNfioJn6+4O
         UQYSSti4ssj0rZsQZZstke//K/wRkqy1lArV5f2XbU8Fa0S5qBKQW4IZrXgwdgKQrcYq
         i2C7CNXoKklt/kf3IlGgjCeEZ4VYZPJDZu9GdR31XLdBFl+wi2Jn9wiy/YEfaOz3QHEY
         zGtA==
X-Gm-Message-State: AOAM533mEp/2QUcBVGA7A1tXhl+bRreb9Q3P6aV7O43bF+N8un0bcV6N
        QYWsrTwE6a1f3wtM+ni/Kaqnf954611J86ct/HpR
X-Google-Smtp-Source: ABdhPJyC10RptEQ9k5GLxJNC51Nlx7LkzAE/O9eV6nL87g4t/8Ya7DkqIpxF9e6v59lZiaYO0q6j+CRyXfS7fsR6qzg=
X-Received: by 2002:a17:906:5205:: with SMTP id g5mr727520ejm.488.1598044199461;
 Fri, 21 Aug 2020 14:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200821140836.3707282-1-tweek@google.com> <20200821140836.3707282-3-tweek@google.com>
In-Reply-To: <20200821140836.3707282-3-tweek@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 17:09:48 -0400
Message-ID: <CAHC9VhQz+iAvsRoq-Y8Up9W6tUSfnxNva06iK9pFC7wWCTfpUg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selinux: add basic filtering for audit trace events
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 10:09 AM Thi=C3=A9baud Weksteen <tweek@google.com> =
wrote:
>
> From: Peter Enderborg <peter.enderborg@sony.com>
>
> This patch adds further attributes to the event. These attributes are
> helpful to understand the context of the message and can be used
> to filter the events.
>
> There are three common items. Source context, target context and tclass.
> There are also items from the outcome of operation performed.
>
> An event is similar to:
>            <...>-1309  [002] ....  6346.691689: selinux_audited:
>        requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
>        result=3D-13
>        scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
>        tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile
>
> With systems where many denials are occurring, it is useful to apply a
> filter. The filtering is a set of logic that is inserted with
> the filter file. Example:
>  echo "tclass=3D=3D\"file\" " > events/avc/selinux_audited/filter
>
> This adds that we only get tclass=3Dfile.
>
> The trace can also have extra properties. Adding the user stack
> can be done with
>    echo 1 > options/userstacktrace
>
> Now the output will be
>          runcon-1365  [003] ....  6960.955530: selinux_audited:
>      requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
>      result=3D-13
>      scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
>      tcontext=3Dsystem_u:object_r:bin_t:s0 tclass=3Dfile
>           runcon-1365  [003] ....  6960.955560: <user stack trace>
>  =3D>  <00007f325b4ce45b>
>  =3D>  <00005607093efa57>
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> Reviewed-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---
>  include/trace/events/avc.h | 36 ++++++++++++++++++++++++++----------
>  security/selinux/avc.c     | 28 +++++++++++++++-------------
>  2 files changed, 41 insertions(+), 23 deletions(-)

... also merged into selinux/next, thanks everyone!

--=20
paul moore
www.paul-moore.com
