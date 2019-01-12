Return-Path: <SRS0=5ZFR=PU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B556C43387
	for <selinux@archiver.kernel.org>; Sat, 12 Jan 2019 18:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6334B206B7
	for <selinux@archiver.kernel.org>; Sat, 12 Jan 2019 18:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfALS4y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:56:54 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:51535 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfALS4x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 12 Jan 2019 13:56:53 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1E179564700
        for <selinux@vger.kernel.org>; Sat, 12 Jan 2019 19:56:50 +0100 (CET)
Received: by mail-oi1-f173.google.com with SMTP id a77so14878669oii.5
        for <selinux@vger.kernel.org>; Sat, 12 Jan 2019 10:56:50 -0800 (PST)
X-Gm-Message-State: AJcUukf56CTMqCZCOPZzyBBeEJktTyrEGRMBtPN2TkWSauQS2q+Z1Ezj
        PNHjnG6dJ6M1VdMvvDNU5BfouWsg2SA7p4M0lRA=
X-Google-Smtp-Source: ALg8bN7WK731ff+qVQOjQwNmWDZsH5HZ95MTN/lVzYDKYlRXUgJfFxENvFaPnXvAS50/PTljK3/HcmxbLURxf17SBfw=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr11511151oig.232.1547319409065;
 Sat, 12 Jan 2019 10:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20190110162624.29309-1-sds@tycho.nsa.gov>
In-Reply-To: <20190110162624.29309-1-sds@tycho.nsa.gov>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 12 Jan 2019 19:56:38 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kMj2P3MAykifW3mtWzwnE=fSMc5-F0ucsZd94W3KTj9g@mail.gmail.com>
Message-ID: <CAJfZ7=kMj2P3MAykifW3mtWzwnE=fSMc5-F0ucsZd94W3KTj9g@mail.gmail.com>
Subject: Re: [PATCH v2] setsebool: support use of -P on SELinux-disabled hosts
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan 12 19:56:51 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 10, 2019 at 5:24 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> As reported in #123, setsebool immediately exits with an error if
> SELinux is disabled, preventing its use for setting boolean persistent
> values.  In contrast, semanage boolean -m works on SELinux-disabled
> hosts.  Change setsebool so that it can be used with the -P option
> (persistent changes) even if SELinux is disabled.  In the SELinux-disabled
> case, skip setting of active boolean values, but set the persistent value
> in the policy store.  Policy reload is automatically disabled by libsemanage
> when SELinux is disabled, so we only need to call semanage_set_reload()
> if -N was used.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/123
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v2 changes setsebool to only call semanage_set_reload() if -N was specified;
> otherwise we can use the libsemanage defaults just as we do in semodule
> and semanage.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

>  policycoreutils/setsebool/setsebool.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
> index 53d3566c..a5157efc 100644
> --- a/policycoreutils/setsebool/setsebool.c
> +++ b/policycoreutils/setsebool/setsebool.c
> @@ -18,7 +18,7 @@
>  #include <errno.h>
>
>  int permanent = 0;
> -int reload = 1;
> +int no_reload = 0;
>  int verbose = 0;
>
>  int setbool(char **list, size_t start, size_t end);
> @@ -38,11 +38,6 @@ int main(int argc, char **argv)
>         if (argc < 2)
>                 usage();
>
> -       if (is_selinux_enabled() <= 0) {
> -               fputs("setsebool:  SELinux is disabled.\n", stderr);
> -               return 1;
> -       }
> -
>         while (1) {
>                 clflag = getopt(argc, argv, "PNV");
>                 if (clflag == -1)
> @@ -53,7 +48,7 @@ int main(int argc, char **argv)
>                         permanent = 1;
>                         break;
>                 case 'N':
> -                       reload = 0;
> +                       no_reload = 1;
>                         break;
>                 case 'V':
>                         verbose = 1;
> @@ -130,6 +125,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
>         semanage_bool_key_t *bool_key = NULL;
>         int managed;
>         int result;
> +       int enabled = is_selinux_enabled();
>
>         handle = semanage_handle_create();
>         if (handle == NULL) {
> @@ -191,7 +187,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
>                                                   boolean) < 0)
>                         goto err;
>
> -               if (semanage_bool_set_active(handle, bool_key, boolean) < 0) {
> +               if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>                         fprintf(stderr, "Failed to change boolean %s: %m\n",
>                                 boollist[j].name);
>                         goto err;
> @@ -202,7 +198,8 @@ static int semanage_set_boolean_list(size_t boolcnt,
>                 boolean = NULL;
>         }
>
> -       semanage_set_reload(handle, reload);
> +       if (no_reload)
> +               semanage_set_reload(handle, 0);
>         if (semanage_commit(handle) < 0)
>                 goto err;
>
> --
> 2.20.1
>

