Return-Path: <SRS0=JMXr=6K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A012C55194
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 18:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B63F206B6
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgDZSJk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:09:40 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:41785 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgDZSJj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Apr 2020 14:09:39 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7100D560077
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 20:09:36 +0200 (CEST)
Received: by mail-ot1-f44.google.com with SMTP id c3so22187618otp.8
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 11:09:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuYOBY8Gbo62uJwJgJPgUlFKWsdCH4Gt6J7iazcswBsDHFjxIhvw
        d5ovtYpHSwESwaTUQmV/XP5tHhjtwv1vVP9Jvd8=
X-Google-Smtp-Source: APiQypJECnhrLomAmNsZlcDY3ZeuInBnCc/2c0d+tO6jMcQlfFAZhbYhQcJ7z5Cta7sQYU4o/7cFmB5ynosxj3TdnOo=
X-Received: by 2002:aca:895:: with SMTP id 143mr12962648oii.153.1587924575457;
 Sun, 26 Apr 2020 11:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <5e3c6fbd-49be-8dcd-903e-b8d98939ae37@gmail.com>
In-Reply-To: <5e3c6fbd-49be-8dcd-903e-b8d98939ae37@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 26 Apr 2020 20:09:24 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==V=nHEYiAtDiUc=k3t9F2tcYXdeDCj6dJ5Cvwqoi2ZUw@mail.gmail.com>
Message-ID: <CAJfZ7==V=nHEYiAtDiUc=k3t9F2tcYXdeDCj6dJ5Cvwqoi2ZUw@mail.gmail.com>
Subject: Re: [PATCH] setsebool: report errors from commit phase
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 26 20:09:36 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 26, 2020 at 5:21 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> In case there are errors when committing changes to booleans, the
> errors may not be reported to user except by nonzero exit status. With
> "setsebool -V" it's possible to see errors from commit phase, but
> otherwise the unfixed command is silent:
>
>   # setsebool -V -P secure_mode_insmod=off
> libsemanage.semanage_install_final_tmp: Could not copy
> /var/lib/selinux/final/default/contexts/files/file_contexts to
> /etc/selinux/default/contexts/files/file_contexts. (Read-only file system).
> libsemanage.semanage_install_final_tmp: Could not copy
> /var/lib/selinux/final/default/contexts/files/file_contexts to
> /etc/selinux/default/contexts/files/file_contexts. (Read-only file system).
>
> Fixed version alerts the user about problems even without -V:
>   # setsebool -P secure_mode_insmod=off
> Failed to commit changes to booleans: Read-only file system
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Looks good to me. The patch below has been mangled (tabs have been
replaced by spaces) but I took the patch from your Pull Request
(https://github.com/SELinuxProject/selinux/pull/227.patch) and it
applied cleanly.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

If nobody raises an objection, I will merge the patch tomorrow.

Thanks,
Nicolas

> ---
>   policycoreutils/setsebool/setsebool.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/policycoreutils/setsebool/setsebool.c
> b/policycoreutils/setsebool/setsebool.c
> index 9d8abfac..60da5df1 100644
> --- a/policycoreutils/setsebool/setsebool.c
> +++ b/policycoreutils/setsebool/setsebool.c
> @@ -200,8 +200,10 @@ static int semanage_set_boolean_list(size_t boolcnt,
>
>          if (no_reload)
>                  semanage_set_reload(handle, 0);
> -       if (semanage_commit(handle) < 0)
> +       if (semanage_commit(handle) < 0) {
> +               fprintf(stderr, "Failed to commit changes to booleans:
> %m\n");
>                  goto err;
> +       }
>
>          semanage_disconnect(handle);
>          semanage_handle_destroy(handle);
> --
> 2.26.2

