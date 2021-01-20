Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E43C433E6
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 16:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEBA233E2
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbhATQIW convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:08:22 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:46732 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391136AbhATQHp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jan 2021 11:07:45 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C5C7E564DE7
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 17:07:02 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id 36so12314886otp.2
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 08:07:02 -0800 (PST)
X-Gm-Message-State: AOAM532nIXTzv37djFzYjMfO2WV/ziHY4d2ahqhPFdKfz6BChHPwviWe
        mUslaexo4hmliB+QPnq3EnksDXwrP6xkd1YNTY8=
X-Google-Smtp-Source: ABdhPJzjtIYFsBvDqvpeCr3cSX7AO9xKB/KV/Zz2Dh9fmvVUG5dlhI5/YQoDTiX9M5fOH9wf7YB/9wLzBeKnB3L7ZpE=
X-Received: by 2002:a9d:66da:: with SMTP id t26mr5034785otm.279.1611158821640;
 Wed, 20 Jan 2021 08:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20210108160048.67386-1-cgzones@googlemail.com> <20210108160048.67386-2-cgzones@googlemail.com>
In-Reply-To: <20210108160048.67386-2-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 20 Jan 2021 17:06:50 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mWSXAEsdzK1D0zdyd7JX=Pj+mdzNsata611gmfFngnTg@mail.gmail.com>
Message-ID: <CAJfZ7=mWSXAEsdzK1D0zdyd7JX=Pj+mdzNsata611gmfFngnTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: update getseuser
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jan 20 17:07:03 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 8, 2021 at 5:02 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> - Bail out if not running on a SELinux enabled system
> - Check whether the passed context is valid
> - Do not report a get_ordered_context_list_with_level failure on zero
>   found contexts
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libselinux/utils/getseuser.c | 47 +++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.c
> index 9193fe0a..ce1b7b27 100644
> --- a/libselinux/utils/getseuser.c
> +++ b/libselinux/utils/getseuser.c
> @@ -9,32 +9,51 @@ int main(int argc, char **argv)
>  {
>         char *seuser = NULL, *level = NULL;
>         char **contextlist;
> -       int rc, n, i;
> +       int rc, n;
>
>         if (argc != 3) {
>                 fprintf(stderr, "usage:  %s linuxuser fromcon\n", argv[0]);
> -               exit(1);
> +               return 1;
> +       }
> +
> +       if (!is_selinux_enabled()) {
> +               fprintf(stderr, "%s may be used only on a SELinux enabled kernel.\n", argv[0]);
> +               return 4;
>         }
>
>         rc = getseuserbyname(argv[1], &seuser, &level);
>         if (rc) {
> -               fprintf(stderr, "getseuserbyname failed:  %s\n",
> -                       strerror(errno));
> -               exit(2);
> +               fprintf(stderr, "getseuserbyname failed:  %s\n", strerror(errno));
> +               return 2;
>         }
>         printf("seuser:  %s, level %s\n", seuser, level);
> -       n = get_ordered_context_list_with_level(seuser, level, argv[2],
> -                                               &contextlist);
> -       if (n <= 0) {
> -               fprintf(stderr,
> -                       "get_ordered_context_list_with_level failed:  %s\n",
> -                       strerror(errno));
> -               exit(3);
> +
> +       rc = security_check_context(argv[2]);
> +       if (rc) {
> +               fprintf(stderr, "context '%s' is invalid\n", argv[2]);
> +               free(seuser);
> +               free(level);
> +               return 5;
> +       }
> +
> +       n = get_ordered_context_list_with_level(seuser, level, argv[2], &contextlist);
> +       if (n < 0) {
> +               fprintf(stderr, "get_ordered_context_list_with_level failed:  %s\n", strerror(errno));
> +               free(seuser);
> +               free(level);
> +               return 3;
>         }
> +
>         free(seuser);
>         free(level);
> -       for (i = 0; i < n; i++)
> +
> +       if (n == 0)
> +               printf("no valid context found\n");
> +
> +       for (int i = 0; i < n; i++)
>                 printf("Context %d\t%s\n", i, contextlist[i]);
> +
>         freeconary(contextlist);
> -       exit(EXIT_SUCCESS);
> +
> +       return EXIT_SUCCESS;
>  }
> --
> 2.30.0

Thanks for your patch! Sorry for the delay: I wanted to test things
and I have been to busy in the past few days to boot my test machine,
and now I see that your patch greatly improves the usability of
getseuser! Many thanks!

As an example of the improvement, before (on a non-MLS system):

$ getseuser myadmin system_u:system_r:sshd_t
seuser:  unconfined_u, level (null)
Context 0 unconfined_u:unconfined_r:unconfined_t
$ getseuser myadmin sshd_t
seuser:  unconfined_u, level (null)
get_ordered_context_list:  error in processing configuration file
/etc/selinux/refpolicy-git/contexts/users/unconfined_u
get_ordered_context_list:  error in processing configuration file
/etc/selinux/refpolicy-git/contexts/default_contexts
get_ordered_context_list_with_level failed:  Invalid argument

With your patch, the first command did not change, but the second one
now returns:

$ getseuser myadmin sshd_t
seuser:  unconfined_u, level (null)
context 'sshd_t' is invalid

... which is much more helpful, in my humble opinion.

So for both your patches: Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I will merge the 2 patches tomorrow if nobody complains.

Nicolas

