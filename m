Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BB4C07E9C
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E269761418
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbhGLHRK convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 03:17:10 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:50083 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbhGLHQi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 03:16:38 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8B72D56479B
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 09:13:48 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so1655859pjb.3
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 00:13:48 -0700 (PDT)
X-Gm-Message-State: AOAM532PbVcS/YmKdJEZeZy2L29QkWevwvj7NKVr4EDdZONL6P5fU4K1
        4gaPpTZH5JX1d4lXylYf9BwpEs2ZqWv8zzrP9/8=
X-Google-Smtp-Source: ABdhPJxQGCJX5BVIlD1roYDmgb41fzhouXctV+6/8LYTCR8ruVhCKRzp9I3cGsviang1uSinDpDlLSIiuxf3JLrv8TI=
X-Received: by 2002:a17:902:b717:b029:11a:fae3:ba7c with SMTP id
 d23-20020a170902b717b029011afae3ba7cmr1246143pls.28.1626074027248; Mon, 12
 Jul 2021 00:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210706175433.29270-1-cgzones@googlemail.com> <20210706175433.29270-6-cgzones@googlemail.com>
In-Reply-To: <20210706175433.29270-6-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 12 Jul 2021 09:13:36 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kCirOQJAAECLnKQ0hKo7v55X8FpzvUv8x7PjucqvcH1w@mail.gmail.com>
Message-ID: <CAJfZ7=kCirOQJAAECLnKQ0hKo7v55X8FpzvUv8x7PjucqvcH1w@mail.gmail.com>
Subject: Re: [PATCH 06/13] checkpolicy: follow declaration-after-statement
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 12 09:13:49 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 6, 2021 at 7:54 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Follow the project style of no declaration after statement.
>
> Found by the GCC warning -Wdeclaration-after-statement.
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/checkmodule.c   | 6 ++++--
>  checkpolicy/policy_define.c | 3 ++-
>  checkpolicy/test/dismod.c   | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> index 40d0ec99..316b2898 100644
> --- a/checkpolicy/checkmodule.c
> +++ b/checkpolicy/checkmodule.c
> @@ -288,14 +288,16 @@ int main(int argc, char **argv)
>         }
>
>         if (policy_type != POLICY_BASE && outfile) {
> +               char *out_name;
> +               char *separator;
>                 char *mod_name = modpolicydb.name;
>                 char *out_path = strdup(outfile);
>                 if (out_path == NULL) {
>                         fprintf(stderr, "%s:  out of memory\n", argv[0]);
>                         exit(1);
>                 }
> -               char *out_name = basename(out_path);
> -               char *separator = strrchr(out_name, '.');
> +               out_name = basename(out_path);
> +               separator = strrchr(out_name, '.');
>                 if (separator) {
>                         *separator = '\0';
>                 }
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 7eff747a..22218c07 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1904,8 +1904,9 @@ int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
>  {
>         char *id;
>         struct av_ioctl_range_list *rnew, *r = NULL;
> -       *rangehead = NULL;
>         uint8_t omit = 0;
> +
> +       *rangehead = NULL;

Hello,
All the patches of this series look good to me. But here, you
introduced trailing tabs, which is reported by "git am" when applying
the patch:

        .git/rebase-apply/patch:40: trailing whitespace.

        .git/rebase-apply/patch:41: trailing whitespace.
                *rangehead = NULL;
        warning: 2 lines add whitespace errors.

Anyway I can remove these tabs when applying this patch.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

If nobody else has comments, I will apply them tomorrow.
Thanks!
Nicolas

