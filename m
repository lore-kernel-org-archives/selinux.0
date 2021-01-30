Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661DEC433E0
	for <selinux@archiver.kernel.org>; Sat, 30 Jan 2021 13:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3948164DD8
	for <selinux@archiver.kernel.org>; Sat, 30 Jan 2021 13:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhA3NqK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 30 Jan 2021 08:46:10 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:60862 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhA3NqG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 30 Jan 2021 08:46:06 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9663E56126A
        for <selinux@vger.kernel.org>; Sat, 30 Jan 2021 14:45:16 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id e70so11482153ote.11
        for <selinux@vger.kernel.org>; Sat, 30 Jan 2021 05:45:16 -0800 (PST)
X-Gm-Message-State: AOAM532zkMMIOcxiZ+mkFmvY8ArcphrCFzNRiUJ1OqGSOvMLkqVEUG3c
        6cm1FOMdCNs80BUwA8HCoznH8UNEak4vogVRysw=
X-Google-Smtp-Source: ABdhPJzLNmaKaQXZRN4KRT/9c9YkFMSEW4I6uYoyjY5iraBD1dgt11BA1oNjTv6QEfGnJ/XlsDq3K7P3e/ZrzBjLenI=
X-Received: by 2002:a9d:66da:: with SMTP id t26mr5844089otm.279.1612014315487;
 Sat, 30 Jan 2021 05:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20210128102741.101112-1-plautrba@redhat.com> <20210128104231.102470-1-plautrba@redhat.com>
In-Reply-To: <20210128104231.102470-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 30 Jan 2021 14:45:04 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kwaQcrDKF+2b4K4EPezXdRec_E7Fuia5FPY2xNWPF9rA@mail.gmail.com>
Message-ID: <CAJfZ7=kwaQcrDKF+2b4K4EPezXdRec_E7Fuia5FPY2xNWPF9rA@mail.gmail.com>
Subject: Re: [PATCH v2] libsemanage: sync filesystem with sandbox
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan 30 14:45:17 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 28, 2021 at 11:44 AM Petr Lautrbach <plautrba@redhat.com> wrote:
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
> It looks like this situation can be avoided it the filesystem with the
> store is sync()ed before rename()
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> - fixed close(fd) indentation
>
>  libsemanage/src/semanage_store.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index cd5e46bb2401..9a81be54db60 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1764,6 +1764,21 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>         /* clean up some files from the sandbox before install */
>         /* remove homedir_template from sandbox */
>
> +       /* sync filesystem with sandbox first */
> +       fd = open(sandbox, O_DIRECTORY);
> +       if (fd == -1) {
> +               ERR(sh, "Error while opening %s for syncfs(): %d", sandbox, errno);
> +               retval = -1;
> +               goto cleanup;
> +       }
> +       if (syncfs(fd) == -1) {
> +               ERR(sh, "Error while syncing %s to filesystem: %d", sandbox, errno);
> +               close(fd);
> +               retval = -1;
> +               goto cleanup;
> +       }
> +       close(fd);
> +
>         if (rename(sandbox, active) == -1) {
>                 ERR(sh, "Error while renaming %s to %s.", sandbox, active);
>                 /* note that if an error occurs during the next
> --
> 2.30.0
>
Hello,

The sync logic seems to be fine, but why does it happen between
rename(active, backup) and rename(sandbox, active)? It feels more
logical to me if the syncing (which could take time) was done before
the rename dance (so before rename(active, backup)). Nevertheless I
could be missing something to understand your choice. If it is so, a
comment about why syncfs() is done after rename(active, backup) would
be very useful.

Cheers,
Nicolas

