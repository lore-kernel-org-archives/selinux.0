Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A34C433E0
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 20:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7044064D9E
	for <selinux@archiver.kernel.org>; Sun, 31 Jan 2021 20:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhAaUZJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:25:09 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:43285 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhAaUNm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 31 Jan 2021 15:13:42 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8B93A5646AA
        for <selinux@vger.kernel.org>; Sun, 31 Jan 2021 18:45:44 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id i20so14007627otl.7
        for <selinux@vger.kernel.org>; Sun, 31 Jan 2021 09:45:44 -0800 (PST)
X-Gm-Message-State: AOAM532dh1MQSX1dIbRHdLMseGv7ucAPoGaJLcQQtytFkSd5u3arMwQp
        yDloNCb2rCc2ULRlmOhQiR6a/3x4iFI3n+XKgWY=
X-Google-Smtp-Source: ABdhPJxViee7l+3yaU+Ypr6t7KdAe0N+IDrk95zOZHq/AUFGnydaAZIc9863s06/r8i2YcLuJ9IiMPljxSiWoXbpsuA=
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr9183906otr.96.1612115143489;
 Sun, 31 Jan 2021 09:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20210131110251.300553-1-plautrba@redhat.com>
In-Reply-To: <20210131110251.300553-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 31 Jan 2021 18:45:32 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kpTbkjZPF7MdgxshvfbSWumN5+iMdAcN7Cypm6aiqH8w@mail.gmail.com>
Message-ID: <CAJfZ7=kpTbkjZPF7MdgxshvfbSWumN5+iMdAcN7Cypm6aiqH8w@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: sync filesystem with sandbox
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Jan 31 18:45:45 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 31, 2021 at 12:53 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Commit 331a109f91ea ("libsemanage: fsync final files before rename")
> added fsync() for policy files and improved situation when something
> unexpected happens right after rename(). However the module store could
> be affected as well. After the following steps module files could be 0
> size:
>
> 1. Run `semanage fcontext -a -t var_t "/tmp/abc"`
> 2. Force shutdown the server during the command is run, or right after
>    it's finished
> 3. Boot the system and look for empty files:
>     # find /var/lib/selinux/targeted/ -type f -size 0 | wc -l
>     1266
>
> It looks like this situation can be avoided if the filesystem with the
> sandbox is sync()ed before we start to rename() directories in the
> store.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>
> - syncfs() moved before rename() dance
>
>  libsemanage/src/semanage_store.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index cd5e46bb2401..c6a736fe2d26 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1736,6 +1736,19 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>         }
>         close(fd);
>
> +       /* sync changes in sandbox to filesystem */
> +       fd = open(sandbox, O_DIRECTORY);
> +       if (fd == -1) {
> +               ERR(sh, "Error while opening %s for syncfs(): %d", sandbox, errno);
> +               return -1;
> +       }
> +       if (syncfs(fd) == -1) {
> +               ERR(sh, "Error while syncing %s to filesystem: %d", sandbox, errno);
> +               close(fd);
> +               return -1;
> +       }
> +       close(fd);
> +
>         retval = commit_number;
>
>         if (semanage_get_active_lock(sh) < 0) {
> --
> 2.30.0
>

