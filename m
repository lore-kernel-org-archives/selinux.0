Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46183C07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 19:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FFE61178
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 19:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhGMUCK convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:02:10 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59571 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhGMUCK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:02:10 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6C2A7564772
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 21:59:18 +0200 (CEST)
Received: by mail-il1-f171.google.com with SMTP id e13so24456045ilc.1
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 12:59:18 -0700 (PDT)
X-Gm-Message-State: AOAM530OwC4csVqis6tCL1xcrN7GlxYT4s0YVXAqX5/PoEpmrb/YJltJ
        Erh5Xd7xIb3Z6vENmm0ATF4WN917KRvP9AsBrpo=
X-Google-Smtp-Source: ABdhPJxAF2lZWtTWxlAxKIc/6jphCZTd4C8diGw6qpmW42yduX/1CoI0PWlzvD5ZnTyH/0RinrNGHoDKLZE5DwxfLNE=
X-Received: by 2002:a05:6e02:20eb:: with SMTP id q11mr3445786ilv.272.1626206357642;
 Tue, 13 Jul 2021 12:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210706175433.29270-1-cgzones@googlemail.com>
 <20210706175433.29270-6-cgzones@googlemail.com> <CAJfZ7=kCirOQJAAECLnKQ0hKo7v55X8FpzvUv8x7PjucqvcH1w@mail.gmail.com>
In-Reply-To: <CAJfZ7=kCirOQJAAECLnKQ0hKo7v55X8FpzvUv8x7PjucqvcH1w@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 21:59:06 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=noCkMGqRP9W1J_=cbb+h5BJ8AX0K2NsJSdhZ1AZZ-Myg@mail.gmail.com>
Message-ID: <CAJfZ7=noCkMGqRP9W1J_=cbb+h5BJ8AX0K2NsJSdhZ1AZZ-Myg@mail.gmail.com>
Subject: Re: [PATCH 06/13] checkpolicy: follow declaration-after-statement
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 21:59:18 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 9:13 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Jul 6, 2021 at 7:54 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > Follow the project style of no declaration after statement.
> >
> > Found by the GCC warning -Wdeclaration-after-statement.
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > ---
> >  checkpolicy/checkmodule.c   | 6 ++++--
> >  checkpolicy/policy_define.c | 3 ++-
> >  checkpolicy/test/dismod.c   | 2 +-
> >  3 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> > index 40d0ec99..316b2898 100644
> > --- a/checkpolicy/checkmodule.c
> > +++ b/checkpolicy/checkmodule.c
> > @@ -288,14 +288,16 @@ int main(int argc, char **argv)
> >         }
> >
> >         if (policy_type != POLICY_BASE && outfile) {
> > +               char *out_name;
> > +               char *separator;
> >                 char *mod_name = modpolicydb.name;
> >                 char *out_path = strdup(outfile);
> >                 if (out_path == NULL) {
> >                         fprintf(stderr, "%s:  out of memory\n", argv[0]);
> >                         exit(1);
> >                 }
> > -               char *out_name = basename(out_path);
> > -               char *separator = strrchr(out_name, '.');
> > +               out_name = basename(out_path);
> > +               separator = strrchr(out_name, '.');
> >                 if (separator) {
> >                         *separator = '\0';
> >                 }
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 7eff747a..22218c07 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1904,8 +1904,9 @@ int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
> >  {
> >         char *id;
> >         struct av_ioctl_range_list *rnew, *r = NULL;
> > -       *rangehead = NULL;
> >         uint8_t omit = 0;
> > +
> > +       *rangehead = NULL;
>
> Hello,
> All the patches of this series look good to me. But here, you
> introduced trailing tabs, which is reported by "git am" when applying
> the patch:
>
>         .git/rebase-apply/patch:40: trailing whitespace.
>
>         .git/rebase-apply/patch:41: trailing whitespace.
>                 *rangehead = NULL;
>         warning: 2 lines add whitespace errors.
>
> Anyway I can remove these tabs when applying this patch.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> If nobody else has comments, I will apply them tomorrow.
> Thanks!
> Nicolas

Merged with the trailing whitespaces removed.
Thanks!
Nicolas

