Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CE8C4332F
	for <selinux@archiver.kernel.org>; Thu, 13 Oct 2022 15:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJMP1G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJMP1G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Oct 2022 11:27:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B1B25C7D
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 08:27:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cl1so2208026pjb.1
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0w1TWc5CCWZKeNxspLI6V6nosZv0ZPLNAdzFUjVkZw=;
        b=nLZc+hdnrp26WGH813n4UQttOKXGgH8E8cHraZOOT7Pih+W1rxRYrhRJ/cQ/cYTxpX
         SDYhyd1LVQGqgdnIWgzlIyAx0HfjdhNoSq4MysB34WULQVL1fcNgv7haGZMhxM4mnVu9
         aNnNPtSDH1POdhqxSMyjgRaZ8L1eN95IybfqABMoEa9GppL88nbO54sydJezX3X8kIV0
         wzgLe928n8GlHiNgqNQB+S/VB75gJP8OYYuKaAbORPP6kjFUOwFVb3FsRtG8/eYKNc3g
         mhIiQwKdu9DAu29NsYRe0qfVYA5XZggWwoW9ib72JTEs+wh32F23TDINryLjehzSOJfi
         GoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0w1TWc5CCWZKeNxspLI6V6nosZv0ZPLNAdzFUjVkZw=;
        b=n41kEoE12N8t43BRihUajGI8K2mq1QQtkr3C0CjJTJkFX+BpPyXX3xaNYhjNUCpo2t
         uOtKGuLsfbBPlbawPCnDHqYrJb75JfshWx5pLzVif4mo4NGVEZ2MNOnVzMdGtERNokJB
         44MtgC5BbwpuF0nX+8vu5Lfij/JXDvN+Ab36LX0wI7Z/zAQH+ZkzcP5NeIlq0URybQw1
         HjWLQm8WOZz2zF3ow3yGsEsxtd1Fp1HIwrEYaq3n4P6QpplwbsKfxiI7u2Ab4dNYIakG
         voLwFfCPDmB3oePTHSrwDltCOiyBAbpMXWuIhClZcFxuS7ThjEP5pQ/XFLhv4eJ8y/3d
         MeUg==
X-Gm-Message-State: ACrzQf0hZ3fmnGGJmuoYp+LeJwgI1q4HiGPglPKB35Qgnr1AxrDgc8st
        JrVmxhjEnf8L0rdJE8IchS5k9aumJM7AUXMTXnw=
X-Google-Smtp-Source: AMsMyM7xW9+9VWilzYDSFv2Obs6X3yyjHLRrCyKf7GGuu9bUJiw3/aW0bV31434ZWa0uYuwHQPEt7em0lPTPfu/lhFM=
X-Received: by 2002:a17:90b:3b82:b0:20b:516:5ff5 with SMTP id
 pc2-20020a17090b3b8200b0020b05165ff5mr379081pjb.92.1665674824319; Thu, 13 Oct
 2022 08:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220830175455.40660-1-cgzones@googlemail.com> <CAP+JOzTxAjJ0SKL-eDxn0GmY0ZJTfqa9BpdorfTvjXajK68ibQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTxAjJ0SKL-eDxn0GmY0ZJTfqa9BpdorfTvjXajK68ibQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 13 Oct 2022 11:26:53 -0400
Message-ID: <CAP+JOzTJxUenDckhws8hFvnVyca=VSZNcL-j7UBDP_LGOxq29w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: support objname in compute_create
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 12, 2022 at 11:39 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Aug 30, 2022 at 2:04 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Support passing an optional object name to compute_create for name
> > based type transitions.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Jim

> > ---
> >  libselinux/utils/compute_create.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compu=
te_create.c
> > index c6481f4b..5401fe96 100644
> > --- a/libselinux/utils/compute_create.c
> > +++ b/libselinux/utils/compute_create.c
> > @@ -10,10 +10,11 @@ int main(int argc, char **argv)
> >  {
> >         char *buf;
> >         security_class_t tclass;
> > +       const char *objname;
> >         int ret;
> >
> > -       if (argc !=3D 4) {
> > -               fprintf(stderr, "usage:  %s scontext tcontext tclass\n"=
,
> > +       if (argc !=3D 4 && argc !=3D 5) {
> > +               fprintf(stderr, "usage:  %s scontext tcontext tclass [o=
bjname]\n",
> >                         argv[0]);
> >                 exit(1);
> >         }
> > @@ -34,7 +35,9 @@ int main(int argc, char **argv)
> >                 exit(2);
> >         }
> >
> > -       ret =3D security_compute_create(argv[1], argv[2], tclass, &buf)=
;
> > +       objname =3D (argc =3D=3D 5) ? argv[4] : NULL;
> > +
> > +       ret =3D security_compute_create_name(argv[1], argv[2], tclass, =
objname, &buf);
> >         if (ret < 0) {
> >                 fprintf(stderr, "%s:  security_compute_create failed:  =
%s\n",
> >                         argv[0], strerror(errno));
> > --
> > 2.37.2
> >
