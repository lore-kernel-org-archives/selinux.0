Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF6C433E0
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6457723A53
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 21:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbhAUVZ3 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:25:29 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:59835 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbhAUVZW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jan 2021 16:25:22 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9B8065649C6
        for <selinux@vger.kernel.org>; Thu, 21 Jan 2021 22:24:38 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id e70so3064635ote.11
        for <selinux@vger.kernel.org>; Thu, 21 Jan 2021 13:24:38 -0800 (PST)
X-Gm-Message-State: AOAM532ZtjkjfM73oX7kp5gQfXvnk4tVydPbOor6hy7DAeYq0sEwOkxw
        HeFxCUKW6yWvGBKPyvy6iP+9y1TfLiOi+bEkGJY=
X-Google-Smtp-Source: ABdhPJzj3SoqGlpaQLvO7RKrcj5dFXcxM7LzKirUg5a/HaxPxAnRm81D3oYHWxJlzPPzfmx2DquZvXieDeK+tqMB2Lg=
X-Received: by 2002:a05:6830:4121:: with SMTP id w33mr75115ott.361.1611264277521;
 Thu, 21 Jan 2021 13:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20210108160048.67386-1-cgzones@googlemail.com>
 <20210108160048.67386-2-cgzones@googlemail.com> <CAJfZ7=mWSXAEsdzK1D0zdyd7JX=Pj+mdzNsata611gmfFngnTg@mail.gmail.com>
In-Reply-To: <CAJfZ7=mWSXAEsdzK1D0zdyd7JX=Pj+mdzNsata611gmfFngnTg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 21 Jan 2021 22:24:26 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==JzeBdo=H6=ZaeiTL2GX4rmimLV5v5jay2p5_HeDWd1A@mail.gmail.com>
Message-ID: <CAJfZ7==JzeBdo=H6=ZaeiTL2GX4rmimLV5v5jay2p5_HeDWd1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: update getseuser
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 21 22:24:39 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 20, 2021 at 5:06 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Jan 8, 2021 at 5:02 PM Christian Göttsche
> <cgzones@googlemail.com> wrote:
> >
> > - Bail out if not running on a SELinux enabled system
> > - Check whether the passed context is valid
> > - Do not report a get_ordered_context_list_with_level failure on zero
> >   found contexts
> >
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/utils/getseuser.c | 47 +++++++++++++++++++++++++-----------
> >  1 file changed, 33 insertions(+), 14 deletions(-)
> >
> > diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.c
> > index 9193fe0a..ce1b7b27 100644
> > --- a/libselinux/utils/getseuser.c
> > +++ b/libselinux/utils/getseuser.c
> > @@ -9,32 +9,51 @@ int main(int argc, char **argv)
> >  {
> >         char *seuser = NULL, *level = NULL;
> >         char **contextlist;
> > -       int rc, n, i;
> > +       int rc, n;
> >
> >         if (argc != 3) {
> >                 fprintf(stderr, "usage:  %s linuxuser fromcon\n", argv[0]);
> > -               exit(1);
> > +               return 1;
> > +       }
> > +
> > +       if (!is_selinux_enabled()) {
> > +               fprintf(stderr, "%s may be used only on a SELinux enabled kernel.\n", argv[0]);
> > +               return 4;
> >         }
> >
> >         rc = getseuserbyname(argv[1], &seuser, &level);
> >         if (rc) {
> > -               fprintf(stderr, "getseuserbyname failed:  %s\n",
> > -                       strerror(errno));
> > -               exit(2);
> > +               fprintf(stderr, "getseuserbyname failed:  %s\n", strerror(errno));
> > +               return 2;
> >         }
> >         printf("seuser:  %s, level %s\n", seuser, level);
> > -       n = get_ordered_context_list_with_level(seuser, level, argv[2],
> > -                                               &contextlist);
> > -       if (n <= 0) {
> > -               fprintf(stderr,
> > -                       "get_ordered_context_list_with_level failed:  %s\n",
> > -                       strerror(errno));
> > -               exit(3);
> > +
> > +       rc = security_check_context(argv[2]);
> > +       if (rc) {
> > +               fprintf(stderr, "context '%s' is invalid\n", argv[2]);
> > +               free(seuser);
> > +               free(level);
> > +               return 5;
> > +       }
> > +
> > +       n = get_ordered_context_list_with_level(seuser, level, argv[2], &contextlist);
> > +       if (n < 0) {
> > +               fprintf(stderr, "get_ordered_context_list_with_level failed:  %s\n", strerror(errno));
> > +               free(seuser);
> > +               free(level);
> > +               return 3;
> >         }
> > +
> >         free(seuser);
> >         free(level);
> > -       for (i = 0; i < n; i++)
> > +
> > +       if (n == 0)
> > +               printf("no valid context found\n");
> > +
> > +       for (int i = 0; i < n; i++)
> >                 printf("Context %d\t%s\n", i, contextlist[i]);
> > +
> >         freeconary(contextlist);
> > -       exit(EXIT_SUCCESS);
> > +
> > +       return EXIT_SUCCESS;
> >  }
> > --
> > 2.30.0
>
> Thanks for your patch! Sorry for the delay: I wanted to test things
> and I have been to busy in the past few days to boot my test machine,
> and now I see that your patch greatly improves the usability of
> getseuser! Many thanks!
>
> As an example of the improvement, before (on a non-MLS system):
>
> $ getseuser myadmin system_u:system_r:sshd_t
> seuser:  unconfined_u, level (null)
> Context 0 unconfined_u:unconfined_r:unconfined_t
> $ getseuser myadmin sshd_t
> seuser:  unconfined_u, level (null)
> get_ordered_context_list:  error in processing configuration file
> /etc/selinux/refpolicy-git/contexts/users/unconfined_u
> get_ordered_context_list:  error in processing configuration file
> /etc/selinux/refpolicy-git/contexts/default_contexts
> get_ordered_context_list_with_level failed:  Invalid argument
>
> With your patch, the first command did not change, but the second one
> now returns:
>
> $ getseuser myadmin sshd_t
> seuser:  unconfined_u, level (null)
> context 'sshd_t' is invalid
>
> ... which is much more helpful, in my humble opinion.
>
> So for both your patches: Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> I will merge the 2 patches tomorrow if nobody complains.
>
> Nicolas

Merged. Thanks!
Nicolas

