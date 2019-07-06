Return-Path: <SRS0=bwx0=VD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F599C0650E
	for <selinux@archiver.kernel.org>; Sat,  6 Jul 2019 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B105214AF
	for <selinux@archiver.kernel.org>; Sat,  6 Jul 2019 10:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfGFKVQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:21:16 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:51851 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGFKVQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 Jul 2019 06:21:16 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1C64B5612BC
        for <selinux@vger.kernel.org>; Sat,  6 Jul 2019 12:21:12 +0200 (CEST)
Received: by mail-ot1-f45.google.com with SMTP id r6so11399340oti.3
        for <selinux@vger.kernel.org>; Sat, 06 Jul 2019 03:21:12 -0700 (PDT)
X-Gm-Message-State: APjAAAU+s3HpIxPtY1tOV9ckdK0wodvAQDX3JkL3dI05LuqOJDRUf9Sb
        ka5kM4vFqfXEkomLNGoTmA8/slSt3RKheUj5+Ow=
X-Google-Smtp-Source: APXvYqzVnQM2g1toiT7zB0mEVSUCYmpwF7xj6JUlKUK+TUMyWxm+4TyhLx/YHMCRh5E+gyBia20qppXtnl/LU0R7aQA=
X-Received: by 2002:a9d:460c:: with SMTP id y12mr6221336ote.358.1562408471154;
 Sat, 06 Jul 2019 03:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190704155621.20227-1-richard_c_haines@btinternet.com> <20190704155621.20227-2-richard_c_haines@btinternet.com>
In-Reply-To: <20190704155621.20227-2-richard_c_haines@btinternet.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 6 Jul 2019 12:20:59 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nwhZf9RnQ6TXdd-t8Ee-Tin3RjUewYjsad28eCLn+ZxA@mail.gmail.com>
Message-ID: <CAJfZ7=nwhZf9RnQ6TXdd-t8Ee-Tin3RjUewYjsad28eCLn+ZxA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] libselinux: Save digest of all partial matches for directory
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Tianjie Xu <xunchang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jul  6 12:21:12 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 4, 2019 at 6:02 PM Richard Haines
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
> V2 Change:
> Restore using SELABEL_OPT_DIGEST
> V3 Change:
> Replace memcpy in get_digests_all_partial_matches() to overcome error
> flagged by -D_FORTIFY_SOURCE= when building only libselinux.
[...]
> +static void digestcpy(uint8_t *dest, const uint8_t *src, size_t count)
> +{
> +       uint8_t *destp = dest;
> +       const uint8_t *srcp = src;
> +
> +       while (count) {
> +               *(destp++) = *(srcp++);
> +               --count;
> +       }
> +}
> +
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
> +               digestcpy(*xattr_digest, read_digest, SHA1_HASH_SIZE);
> +       }
> +
> +       if (status) {
> +               *calculated_digest = calloc(1, sizeof(SHA1_HASH_SIZE + 1));
> +               if (!*calculated_digest)
> +                       goto oom;
> +
> +               digestcpy(*calculated_digest, hash_digest, SHA1_HASH_SIZE);
> +       }
> +

No. This is hiding a real bug, not fixing it. Here is what this code does:

* sizeof(SHA1_HASH_SIZE + 1) gets replaced with sizeof(( 160 / 8 ) +
1) = sizeof(int) = 4
* "*xattr_digest = calloc(1, sizeof(SHA1_HASH_SIZE + 1));" is replaced
by "*xattr_digest = calloc(1, 4);" : it allocates 4 bytes instead of
160/8=20
* digestcpy(*xattr_digest, read_digest, SHA1_HASH_SIZE) copies 20
bytes into a 4-byte buffer, which is a vulnerability kind called "heap
overflow".

In the end, you have only hidden the heap overflow you wanted to
introduce and which was correctly reported by the compiler. Please do
not re-implement memcpy.

A real fix would consists in using calloc(1, SHA1_HASH_SIZE + 1),
without the sizeof.

Thanks,
Nicolas

