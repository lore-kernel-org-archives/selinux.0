Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEFAC4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 22:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLPWCN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 17:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiLPWB3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 17:01:29 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E5D28E1E
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 14:01:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v8so5511816edi.3
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 14:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zU3NzxC6ZXi1zBl4MXHBEYiSgdCZ6KTZyE10zbuYBaQ=;
        b=W8iMECDQqY8DhR4dEBKgLeY23cRv30Yn6noSYAKJQD83ryW+Ww1NfQTHagmM/KqE89
         vf76kGDko6ra7Rh7EkXgi3KGd3cEPAxScXrBaROlFcpY1anJR+xsDKqCz7rvHGzpnrDB
         PnidAQkFSy7uOAaP+EWFsy4kA4q0CievKE0rSD0EZ6WUufTqm4O9u5Cc7ybpmi11i++Q
         VnXKSWnhBgz9DgmFtIzd3Poaj/XWZEkbFyD0dFin6CRgitF4FNRFtJqlFjQw93Xt5RsC
         8Vkb2NJgWLbd882FvT6yoH8U1gK8Hk394atRlwk30Q+uUbpkGcTnfwAKsx3n2shCt5kI
         OPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zU3NzxC6ZXi1zBl4MXHBEYiSgdCZ6KTZyE10zbuYBaQ=;
        b=byCJ2U9/dGsaFhEjh9G0MrLg4sYYrBHbR962DSk+t+Ic+NYOwlia3y8JHJMKr4C3aN
         ynDJSUJRcsN5pRM2ksu1kV9/9JhTI1COA7Ixqjy2kz5IRQfiXw661GnlOT4WUFc5Btk6
         JACBhGWJMfMnbBX9Ptd3na4p/XrMq8/ErQrjtQapByh99g0Z2KfcRrdlbeUQL2QR3eS6
         LhdCFMChG+zYLMnmxumEVqfX2bahMpnaEWghcaishUNS9wfmsoiAr3vSodu7gIC7b1C7
         h5JEpnTcSKUhdNlSbqSh04TwZZinUJ3CvZYP4wlwx/R16gqelcTfgYawBcO/0SYnPh3j
         wpcA==
X-Gm-Message-State: ANoB5pn3eORgEEDUCT/erAPxrF/H1CjEo/OqYCFI2YFkD5YEHatNyya5
        Lbl/vP3o1yI3j0BSJxPJCyTcPJEZ9QtPSvcmlR98seWs
X-Google-Smtp-Source: AA0mqf7cW/u9KOniPAKAhkx/X9Vmd9faZmFu/txYE0UsJ7kZbyUg+3KvLkevsG/YxSokTpx+j86GSMRiVpnkvK+HtWA=
X-Received: by 2002:a05:6402:4499:b0:46c:43fd:d1ab with SMTP id
 er25-20020a056402449900b0046c43fdd1abmr12938408edb.197.1671228086701; Fri, 16
 Dec 2022 14:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20221129120020.1915666-1-lujie54@huawei.com> <CAP+JOzSa5KU90uwNt3d16WKQudo_zDDbruHaVzUa1d67-gtcVw@mail.gmail.com>
In-Reply-To: <CAP+JOzSa5KU90uwNt3d16WKQudo_zDDbruHaVzUa1d67-gtcVw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 17:01:15 -0500
Message-ID: <CAP+JOzTmd6Vqct2HVzKJ8N4DJXw8sg_0Fs6HWst56Ur=vLuvdQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux:add check for malloc
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 9:15 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Nov 29, 2022 at 9:45 AM Jie Lu <lujie54@huawei.com> wrote:
> >
> > Add return check for regex_data_create() to avoid NULL reference of regex_data
> >
> > (gdb) bt
> >  #0  0x00007fbde5caec14 in pthread_mutex_init () from /usr/lib64/libc.so.6
> >  #1  0x00007fbde5e3a489 in regex_data_create () at regex.c:260
> >  #2  0x00007fbde5e3a4af in regex_prepare_data (regex=regex@entry=0x7fbde4613770, pattern_string=pattern_string@entry=0x563c6799a820 "^/home$", errordata=errordata@entry=0x7ffeb83fa950) at regex.c:76
> >  #3  0x00007fbde5e32fe6 in compile_regex (errbuf=0x0, spec=0x7fbde4613748) at label_file.h:407
> >  #4  lookup_all (key=0x563c679974e5 "/var/log/kadmind.log", type=<optimized out>, partial=partial@entry=false, match_count=match_count@entry=0x0, rec=<optimized out>, rec=<optimized out>)
> >      at label_file.c:949
> >  #5  0x00007fbde5e33350 in lookup (rec=<optimized out>, key=<optimized out>, type=<optimized out>) at label_file.c:1092
> >  #6  0x00007fbde5e31878 in selabel_lookup_common (rec=0x563c67998cc0, translating=1, key=<optimized out>, type=<optimized out>) at label.c:167
> >
> > Signed-off-by: Jie Lu <lujie54@huawei.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/regex.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> > index 73987d9f..149a7973 100644
> > --- a/libselinux/src/regex.c
> > +++ b/libselinux/src/regex.c
> > @@ -257,6 +257,9 @@ struct regex_data *regex_data_create(void)
> >  {
> >         struct regex_data *regex_data =
> >                 (struct regex_data *)calloc(1, sizeof(struct regex_data));
> > +       if (!regex_data)
> > +               return NULL;
> > +
> >         __pthread_mutex_init(&regex_data->match_mutex, NULL);
> >         return regex_data;
> >  }
> > --
> > 2.27.0
> >
