Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE4DC4167B
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 21:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLPV5U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 16:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLPV5C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 16:57:02 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0083518E0D
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 13:56:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kw15so9173485ejc.10
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 13:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/oqQQ5YBGkHyRZ6r9CZy+yUTY+MaSS95fu5gOTSong=;
        b=TH3yAGaBwMPOiWcuJkI8hbNZTeajFB9hPLY5O8jsZcpH6fqgWEFm5ivUayaRdigJXe
         P9rWxbJjr90AdB4XnECCE9gqaqor34Ikv1xDTk2XMsc7GV1YiYXUjcJkDBtQ3OxGdCgZ
         Q5mY9gipVIuvISK2duiFMscLu4g0Fy9Ki9NAqjvGXqEGydAD/ed5WOd0Ih7q/UN64d2b
         RDlzDvyxjcb61QvhqfjBHNVQyexgwGL4bB47motHeJ7n78gIshzRi/jyT/cxVYZmgMQ4
         pMc9pmWSgD3243Gwbzp/NP2MeHP2Q66OSq/DKttSpb+HA2HQeLjWRuZZ+/Cmhz2X2Oti
         8qvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/oqQQ5YBGkHyRZ6r9CZy+yUTY+MaSS95fu5gOTSong=;
        b=APtkFgsJbOenYzklyRP/cltd+54DeSnR5SgFou15PA//3ChLwtG8DuYQIMNgYoPvtg
         0edBJctRaLrdnKoWtA/cnhoUzAeitoctvMWZ0PKkf9BD06voEvk9LMUigeLQRAgWvnwr
         WjqYksf2qIZ1ZMJ7ZqY/CET4C2k7yYiYtTjb63kqIPdWnEQjpkKYTr6SJlyak3kb1h3c
         4wa3eJRNOyPbvcpAaqbsOsNgd4acovTD5FiZrmgapWdVm3+ZJu2CJVl+EndTNWeZCcpH
         ipE7d0xFOASDnUn9wH3gQfp6VnDnCc3O4XSslRTkDU53YIATObXmhnUDJJKdAnyq0SrT
         /7UQ==
X-Gm-Message-State: ANoB5plOYreY4xIaQWCgMdtksMylQ9BpzrDvSiu/w2o+0xMvaZzxxmZ2
        LsisgY0ZKlUlujKOShQrx0NqfmZB91qbFHEHq4w=
X-Google-Smtp-Source: AA0mqf5og+Duxcb259vxyqw+q29Msm8JX4I26BUUv2vTvr79IE+zyFIYgs2FAuA2pfPRK/qmTCygttiGYWWSPQdF3/o=
X-Received: by 2002:a17:906:fc3:b0:7c0:a880:dc71 with SMTP id
 c3-20020a1709060fc300b007c0a880dc71mr31832612ejk.705.1671227815569; Fri, 16
 Dec 2022 13:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20221122052110.2433833-1-lujie54@huawei.com> <CAP+JOzRJPWenEVwwNLSeqZEG7HExP0r3kPQC93VdpwAgMB-AOw@mail.gmail.com>
In-Reply-To: <CAP+JOzRJPWenEVwwNLSeqZEG7HExP0r3kPQC93VdpwAgMB-AOw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 16:56:44 -0500
Message-ID: <CAP+JOzT73UWoQK_qAbmUM4vgetczP=vj9xFsR5E7PtDhMNvZqw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: fix some memory issues in db_init
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 23, 2022 at 10:31 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Nov 22, 2022 at 3:05 AM Jie Lu <lujie54@huawei.com> wrote:
> >
> > 1. check the return of strdup to avoid a potential NULL reference.
> > 2. make sure line_buf is freed.
> >
> > Signed-off-by: Jie Lu <lujie54@huawei.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
Thanks,
Jim

>
> > ---
> >  libselinux/src/label_db.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
> > index 94c05c6d..bd73201c 100644
> > --- a/libselinux/src/label_db.c
> > +++ b/libselinux/src/label_db.c
> > @@ -293,6 +293,11 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
> >                 return NULL;
> >         }
> >         rec->spec_file = strdup(path);
> > +       if (!rec->spec_file) {
> > +                free(catalog);
> > +                fclose(filp);
> > +                return NULL;
> > +       }
> >
> >         /*
> >          * Parse for each lines
> > @@ -322,18 +327,19 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
> >                 if (process_line(path, line_buf, ++line_num, catalog) < 0)
> >                         goto out_error;
> >         }
> > -       free(line_buf);
> >
> >         if (digest_add_specfile(rec->digest, filp, NULL, sb.st_size, path) < 0)
> >                 goto out_error;
> >
> >         digest_gen_hash(rec->digest);
> >
> > +       free(line_buf);
> >         fclose(filp);
> >
> >         return catalog;
> >
> >  out_error:
> > +       free(line_buf);
> >         for (i = 0; i < catalog->nspec; i++) {
> >                 spec_t         *spec = &catalog->specs[i];
> >
> > --
> > 2.27.0
> >
