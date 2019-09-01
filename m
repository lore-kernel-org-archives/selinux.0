Return-Path: <SRS0=nwEP=W4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A99CC3A5A4
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061CD21897
	for <selinux@archiver.kernel.org>; Sun,  1 Sep 2019 17:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfIARvq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 1 Sep 2019 13:51:46 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:41859 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfIARvq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 1 Sep 2019 13:51:46 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3E79856460B
        for <selinux@vger.kernel.org>; Sun,  1 Sep 2019 19:51:43 +0200 (CEST)
Received: by mail-oi1-f181.google.com with SMTP id o6so8916972oic.9
        for <selinux@vger.kernel.org>; Sun, 01 Sep 2019 10:51:43 -0700 (PDT)
X-Gm-Message-State: APjAAAWGQbaBQyzErLuTbhb3rjwlfk6zJpQR76DAJrnvdrODIl8RcPK1
        b3JK4/jjJbqHBgIZaW6Oho3ExdSXtE3Qk9J5kOg=
X-Google-Smtp-Source: APXvYqzrhXLwFhVXi8bNPniW+cN5inQB0qPMglsNvluMHsD0ZQwI8ln6j/DOWF7Ni26/ac7S0MUs3f2jfd7szXOAHSw=
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr17233302oie.39.1567360302204;
 Sun, 01 Sep 2019 10:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190805211302.28465-1-nicolas.iooss@m4x.org>
In-Reply-To: <20190805211302.28465-1-nicolas.iooss@m4x.org>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 1 Sep 2019 19:51:31 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kmENN17vf4iEL3R_nCEsPY_xiw0mwogxirgbZN3PHoMQ@mail.gmail.com>
Message-ID: <CAJfZ7=kmENN17vf4iEL3R_nCEsPY_xiw0mwogxirgbZN3PHoMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux: ensure that digest_len is not zero
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Sep  1 19:51:43 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 5, 2019 at 11:13 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> In add_xattr_entry(), if selabel_get_digests_all_partial_matches()
> returns with digest_len = 0, the code gets executed as:
>
>     sha1_buf = malloc(digest_len * 2 + 1);  /* Allocate 1 byte */
>
>     /* ... */
>
>     for (i = 0; i < digest_len; i++)  /* Do not do anything */
>         sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);
>
>     /* ... */
>
>     new_entry->digest = strdup(sha1_buf);  /* use of uninitiliazed content */
>
> This is reported by some static code analyzers, even though in practise
> digest_len should never be zero, and the call to sprintf() ensures that
> the content of sha1_buf is initialized and terminated by '\0'.
>
> Make sure to never call strdup() on an uninitialized string by verifying
> that digest_len != 0.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

> ---
>  libselinux/src/selinux_restorecon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 1be453f3b494..028d8924235f 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -309,7 +309,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
>                                                 &calculated_digest,
>                                                 &xattr_digest, &digest_len);
>
> -       if (!xattr_digest) {
> +       if (!xattr_digest || !digest_len) {
>                 free(calculated_digest);
>                 return 1;
>         }
> --
> 2.22.0
>

