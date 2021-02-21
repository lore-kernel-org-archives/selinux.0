Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F5BC433E0
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 19:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DDE64EDE
	for <selinux@archiver.kernel.org>; Sun, 21 Feb 2021 19:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBUTB5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Feb 2021 14:01:57 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44465 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBUTB4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Feb 2021 14:01:56 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3DCD3564C53
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 20:01:13 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id r75so11822175oie.11
        for <selinux@vger.kernel.org>; Sun, 21 Feb 2021 11:01:13 -0800 (PST)
X-Gm-Message-State: AOAM533kfY0m9dLEQnBksTEwT0bPi730P3009xY4pO8jyWVTPsjX/2ry
        y+kEUG78Hph++8PRFULdINg06cHg7NhHniU4EwM=
X-Google-Smtp-Source: ABdhPJxzFk7f5/TIcTvJPgXsAmA+Uk7xgBmv76Z3jqgj55rcU4wI30iaynAvsvjs1/+NMKMXpYkE4o2PIcO2tGfAtyM=
X-Received: by 2002:aca:b254:: with SMTP id b81mr13767838oif.20.1613934072282;
 Sun, 21 Feb 2021 11:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20210216141446.171306-1-plautrba@redhat.com>
In-Reply-To: <20210216141446.171306-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 21 Feb 2021 20:01:01 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nDggfdRVxZT=aWJbr8gKS6r2ZctGHdbsd_P7y3u9KmpA@mail.gmail.com>
Message-ID: <CAJfZ7=nDggfdRVxZT=aWJbr8gKS6r2ZctGHdbsd_P7y3u9KmpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: fix segfault in add_xattr_entry()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 21 20:01:14 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 16, 2021 at 3:16 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> When selabel_get_digests_all_partial_matches(), resp
> get_digests_all_partial_matches() doesn't find a match,
> calculated_digest is not initialized and followup memcmp() could
> segfault. Given that calculated_digest and xattr_digest are already
> compared in get_digests_all_partial_matches() and the function returns
> true or false based on this comparison, it's not neccessary to compare

(minor typo: necessary with only one C)

> these values again.
>
> Fixes:
>     # restorecon_xattr -d -v tmp
>     specfiles SHA1 digest: afc752f47d489f3e82ac1da8fd247a2e1a6af5f8
>     calculated using the following specfile(s):
>     /etc/selinux/targeted/contexts/files/file_contexts.subs_dist
>     /etc/selinux/targeted/contexts/files/file_contexts.subs
>     /etc/selinux/targeted/contexts/files/file_contexts.bin
>     /etc/selinux/targeted/contexts/files/file_contexts.homedirs.bin
>     /etc/selinux/targeted/contexts/files/file_contexts.local.bin
>
>     Segmentation fault (core dumped)
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks! I wanted to reproduce the issue on an Arch Linux test VM and
it was slightly more complex. Here is what I did:

cd /root
mkdir tmp
restorecon -D -Rv tmp  # create security.sehash attribute
restorecon_xattr -d -v tmp # this segfaults in the memcmp()

Both your patches look good. Nevertheless there is some
inconsistencies in the "coding style" used in your patches:

> ---
>  libselinux/src/selinux_restorecon.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 6993be6fda17..4bca29b9de78 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -297,6 +297,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
>         char *sha1_buf = NULL;
>         size_t i, digest_len = 0;
>         int rc, digest_result;
> +       bool match;
>         struct dir_xattr *new_entry;
>         uint8_t *xattr_digest = NULL;
>         uint8_t *calculated_digest = NULL;
> @@ -306,7 +307,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
>                 return -1;
>         }
>
> -       selabel_get_digests_all_partial_matches(fc_sehandle, directory,
> +       match = selabel_get_digests_all_partial_matches(fc_sehandle, directory,
>                                                 &calculated_digest,
>                                                 &xattr_digest, &digest_len);

Here: the parameters need to be indented with the new indentation.

>
> @@ -326,11 +327,10 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
>         for (i = 0; i < digest_len; i++)
>                 sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);
>
> -       rc = memcmp(calculated_digest, xattr_digest, digest_len);
> -       digest_result = rc ? NOMATCH : MATCH;
> +       digest_result = match ? MATCH : NOMATCH;
>
> -       if ((delete_nonmatch && rc != 0) || delete_all) {
> -               digest_result = rc ? DELETED_NOMATCH : DELETED_MATCH;
> +       if ((delete_nonmatch && ! match) || delete_all) {

Here: the space between "!" and "match" is unexpected.

> +               digest_result = match ? DELETED_MATCH : DELETED_NOMATCH;
>                 rc = removexattr(directory, RESTORECON_PARTIAL_MATCH_DIGEST);
>                 if (rc) {
>                         selinux_log(SELINUX_ERROR,
> --
> 2.30.1

... and in the second patch, the indentation of the parameters of the
new fprintf(stderr,...) does not match the one used in other places of
the file.

Anyway these are minor issues, and ignoring them, for both patches:
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

