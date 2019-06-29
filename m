Return-Path: <SRS0=45Fk=U4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF7C4321A
	for <selinux@archiver.kernel.org>; Sat, 29 Jun 2019 17:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C6216FD
	for <selinux@archiver.kernel.org>; Sat, 29 Jun 2019 17:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF2RaM convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Jun 2019 13:30:12 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:38763 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfF2RaL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 29 Jun 2019 13:30:11 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2019 13:30:10 EDT
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 406E5561264
        for <selinux@vger.kernel.org>; Sat, 29 Jun 2019 19:20:29 +0200 (CEST)
Received: by mail-ot1-f54.google.com with SMTP id b7so9250494otl.11
        for <selinux@vger.kernel.org>; Sat, 29 Jun 2019 10:20:29 -0700 (PDT)
X-Gm-Message-State: APjAAAViYkGtA0edKfU2FbqnWvxJjZInri8foC4DG8B5XUsDxDPtBDbA
        x3aORdwHA2UokBpGQeYyjgNLWbRuCpHwxgYMOHk=
X-Google-Smtp-Source: APXvYqy6Eacqny2PRXg5ju4nJZQCHE6mh7kLRIbEZdNXX8qgspAYqT6aj7SjxSX3qw3GmnJSOsG1oOOeH/9j3TplBqw=
X-Received: by 2002:a05:6830:12d5:: with SMTP id a21mr13615249otq.29.1561828828293;
 Sat, 29 Jun 2019 10:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190603095452.21321-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190603095452.21321-1-richard_c_haines@btinternet.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 29 Jun 2019 19:20:17 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nr2UuLO4u+PY7UKbiuwLsCY5RhbYhZ6o18HbjqP=_a5Q@mail.gmail.com>
Message-ID: <CAJfZ7=nr2UuLO4u+PY7UKbiuwLsCY5RhbYhZ6o18HbjqP=_a5Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] libselinux: Save digest of all partial matches for directory
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        xunchang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jun 29 19:20:29 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 3, 2019 at 12:02 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> We used to hash the file_context and skip the restorecon on the top
> level directory if the hash doesn't change. But the file_context
> might change after an OTA update; and some users experienced long
> restorecon time as they have lots of files under directories like
> /data/media.
>
> This CL tries to hash all the partial match entries in the
> file_context for each directory; and skips the restorecon if that
> digest stays the same, regardless of the changes to the other parts
> of file_context.
>
> This is a version ported from Android that was originally written by:
> xunchang <xunchang@google.com>
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Change
> Restore using SELABEL_OPT_DIGEST
>
[...]
> +/*
> + * Returns true if the digest of all partial matched contexts is the same as
> + * the one saved by setxattr, otherwise returns false. The length of the SHA1
> + * digest will always be returned. The caller must free any returned digests.
> + */
> +static bool get_digests_all_partial_matches(struct selabel_handle *rec,
> +                                           const char *pathname,
> +                                           uint8_t **calculated_digest,
> +                                           uint8_t **xattr_digest,
> +                                           size_t *digest_len)
> +{
> +       uint8_t read_digest[SHA1_HASH_SIZE];
> +       ssize_t read_size = getxattr(pathname, RESTORECON_PARTIAL_MATCH_DIGEST,
> +                                    read_digest, SHA1_HASH_SIZE);
> +       uint8_t hash_digest[SHA1_HASH_SIZE];
> +       bool status = selabel_hash_all_partial_matches(rec, pathname,
> +                                                      hash_digest);
> +
> +       *xattr_digest = NULL;
> +       *calculated_digest = NULL;
> +       *digest_len = SHA1_HASH_SIZE;
> +
> +       if (read_size == SHA1_HASH_SIZE) {
> +               *xattr_digest = calloc(1, sizeof(SHA1_HASH_SIZE + 1));
> +               if (!*xattr_digest)
> +                       goto oom;
> +
> +               memcpy(*xattr_digest, read_digest, SHA1_HASH_SIZE);
> +       }
> +
> +       if (status) {
> +               *calculated_digest = calloc(1, sizeof(SHA1_HASH_SIZE + 1));
> +               if (!*calculated_digest)
> +                       goto oom;
> +
> +               memcpy(*calculated_digest, hash_digest, SHA1_HASH_SIZE);
> +       }

Hi,
I do not know whether this patch is still pending or has been
withdrawn (https://patchwork.kernel.org/patch/10972685/ tells "State:
New"). In case you are still waiting for review/tests, I have been
testing this patch, and it appears that this breaks on Travis-CI (gcc
5.4.0 on Ubuntu 16.04):

In function ‘memcpy’,
    inlined from ‘get_digests_all_partial_matches’ at label_file.c:1005:3:
/usr/include/x86_64-linux-gnu/bits/string3.h:53:10: error: call to
__builtin___memcpy_chk will always overflow destination buffer
[-Werror]
   return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
          ^
In function ‘memcpy’,
    inlined from ‘get_digests_all_partial_matches’ at label_file.c:1013:3:
/usr/include/x86_64-linux-gnu/bits/string3.h:53:10: error: call to
__builtin___memcpy_chk will always overflow destination buffer
[-Werror]
   return __builtin___memcpy_chk (__dest, __src, __len, __bos0 (__dest));
          ^

This is a true-positive error: sizeof(SHA1_HASH_SIZE + 1) is the size
of an integer, not "SHA1_HASH_SIZE + 1". Therefore gcc is right to
report a heap overflow.

Nicolas

