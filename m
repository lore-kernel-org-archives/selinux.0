Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7950C433EF
	for <selinux@archiver.kernel.org>; Sun, 29 May 2022 22:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiE2WvP convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 May 2022 18:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiE2WvO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 May 2022 18:51:14 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B785666BE
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 15:51:13 -0700 (PDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 087DE5648F4
        for <selinux@vger.kernel.org>; Mon, 30 May 2022 00:51:11 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id y1so9090825pfr.6
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 15:51:10 -0700 (PDT)
X-Gm-Message-State: AOAM531XhB4EljM97xggE0LWuVBzAsGcro6KUdqUnW8AYzV0BTqKnGVO
        KeGiIZKB//tQI5QObO8N+7btWZYMka24Wq1+A/8=
X-Google-Smtp-Source: ABdhPJzPMb84vi9/+oiYrNOWRVzheB9cw4vl1ZZ6H8JDNEE9TQZrUbNalhL60ZWvvs2P9ANJi1W6scO+szmwpZwju1s=
X-Received: by 2002:a63:9dc7:0:b0:3f6:17f0:f310 with SMTP id
 i190-20020a639dc7000000b003f617f0f310mr45436042pgd.285.1653864669765; Sun, 29
 May 2022 15:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220520131610.11867-1-cgzones@googlemail.com>
In-Reply-To: <20220520131610.11867-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 30 May 2022 00:50:58 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=k5BqgsVgMt1=M69bPUrfh7+6c3oijoi-eUNsWCxM=j2A@mail.gmail.com>
Message-ID: <CAJfZ7=k5BqgsVgMt1=M69bPUrfh7+6c3oijoi-eUNsWCxM=j2A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: declare return value of context_str(3) const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon May 30 00:51:11 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 20, 2022 at 3:16 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> context_str(3) returns a string representation of the given context.
> This string is owned by the context and free'd on context_free(3).
> Declare it const, as already done in the man page, since it must not be
> free'd by the caller.
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!

> ---
>  libselinux/include/selinux/context.h |  2 +-
>  libselinux/src/context.c             |  2 +-
>  libselinux/src/get_context_list.c    | 11 ++++++-----
>  libselinux/src/query_user_context.c  |  2 +-
>  policycoreutils/newrole/newrole.c    |  2 +-
>  5 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/libselinux/include/selinux/context.h b/libselinux/include/selinux/context.h
> index 949fb1e1..82f4e690 100644
> --- a/libselinux/include/selinux/context.h
> +++ b/libselinux/include/selinux/context.h
> @@ -25,7 +25,7 @@ extern "C" {
>   * for the same context_t*
>   */
>
> -       extern char *context_str(context_t);
> +       extern const char *context_str(context_t);
>
>  /* Free the storage used by a context */
>         extern void context_free(context_t);
> diff --git a/libselinux/src/context.c b/libselinux/src/context.c
> index b2144c7c..9dddbc5a 100644
> --- a/libselinux/src/context.c
> +++ b/libselinux/src/context.c
> @@ -116,7 +116,7 @@ void context_free(context_t context)
>  /*
>   * Return a pointer to the string value of the context.
>   */
> -char *context_str(context_t context)
> +const char *context_str(context_t context)
>  {
>         context_private_t *n = context->ptr;
>         int i;
> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index cfe38e59..d774b9cf 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -143,6 +143,7 @@ static int get_context_user(FILE * fp,
>         char *linerole, *linetype;
>         char **new_reachable = NULL;
>         char *usercon_str;
> +       const char *usercon_str2;
>         context_t con;
>         context_t usercon;
>
> @@ -257,20 +258,20 @@ static int get_context_user(FILE * fp,
>                         rc = -1;
>                         goto out;
>                 }
> -               usercon_str = context_str(usercon);
> -               if (!usercon_str) {
> +               usercon_str2 = context_str(usercon);
> +               if (!usercon_str2) {
>                         context_free(usercon);
>                         rc = -1;
>                         goto out;
>                 }
>
>                 /* check whether usercon is already in reachable */
> -               if (is_in_reachable(*reachable, usercon_str)) {
> +               if (is_in_reachable(*reachable, usercon_str2)) {
>                         context_free(usercon);
>                         start = end;
>                         continue;
>                 }
> -               if (security_check_context(usercon_str) == 0) {
> +               if (security_check_context(usercon_str2) == 0) {
>                         new_reachable = realloc(*reachable, (*nreachable + 2) * sizeof(char *));
>                         if (!new_reachable) {
>                                 context_free(usercon);
> @@ -278,7 +279,7 @@ static int get_context_user(FILE * fp,
>                                 goto out;
>                         }
>                         *reachable = new_reachable;
> -                       new_reachable[*nreachable] = strdup(usercon_str);
> +                       new_reachable[*nreachable] = strdup(usercon_str2);
>                         if (new_reachable[*nreachable] == NULL) {
>                                 context_free(usercon);
>                                 rc = -1;
> diff --git a/libselinux/src/query_user_context.c b/libselinux/src/query_user_context.c
> index b8125c96..29a1b360 100644
> --- a/libselinux/src/query_user_context.c
> +++ b/libselinux/src/query_user_context.c
> @@ -115,7 +115,7 @@ int manual_user_enter_context(const char *user, char ** newcon)
>         int mls_enabled = is_selinux_mls_enabled();
>
>         context_t new_context;  /* The new context chosen by the user     */
> -       char *user_context = NULL;      /* String value of the user's context     */
> +       const char *user_context = NULL;        /* String value of the user's context     */
>         int done = 0;           /* true if a valid sid has been obtained  */
>
>         /* Initialize the context.  How this is done depends on whether
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
> index ae37d725..c2afa37e 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -842,7 +842,7 @@ static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
>         char *type_ptr = NULL;  /* stores malloc'd data from get_default_type */
>         char *level_s = NULL;   /* level spec'd by user in argv[] */
>         char *range_ptr = NULL;
> -       char *new_con = NULL;
> +       const char *new_con = NULL;
>         char *tty_con = NULL;
>         context_t context = NULL;       /* manipulatable form of new_context */
>         const struct option long_options[] = {
> --
> 2.36.1
>

