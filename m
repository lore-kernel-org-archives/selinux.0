Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8A9C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D4C21907
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 21:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfBGVYH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:24:07 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:51758 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGVYH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 16:24:07 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A4DED56468E
        for <selinux@vger.kernel.org>; Thu,  7 Feb 2019 22:24:04 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id e12so2416570otl.5
        for <selinux@vger.kernel.org>; Thu, 07 Feb 2019 13:24:04 -0800 (PST)
X-Gm-Message-State: AHQUAubT3mAtHnbgpkCpxiXlu8hSrwRNZ0HJP68+piAkjPMD7yEz6Ood
        jXGrI2AqGwcRmy7BTS9wQjXdL8QS+gujQP9Ubqk=
X-Google-Smtp-Source: AHgI3IbMdM8Bod7gGfmtxd1rxp8OMrYomqdWblZ0/pRWvA8EvUqs7v38G2XuyxisRBVlgvQUvpEXXI9Xs4uJGc5FAX4=
X-Received: by 2002:a9d:2f66:: with SMTP id h93mr10234630otb.165.1549574643780;
 Thu, 07 Feb 2019 13:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20190206194111.24729-1-plautrba@redhat.com>
In-Reply-To: <20190206194111.24729-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 7 Feb 2019 22:23:52 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=ndwhAsaJB7EuYneFU1fyPQwW8YZsnBSo_d1gN7XUTVMA@mail.gmail.com>
Message-ID: <CAJfZ7=ndwhAsaJB7EuYneFU1fyPQwW8YZsnBSo_d1gN7XUTVMA@mail.gmail.com>
Subject: Re: [PATCH] libselinux/selinux_restorecon: Skip customized files also
 without -v
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Feb  7 22:24:05 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 6, 2019 at 8:41 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> In the original code, customizable file contexts were not changed only if -v was
> used. It lead to different behavior when selinux_restorecon was run with -v and
> without it.
>
> Based on an initial patch by Jan Zarsky <jzarsky@redhat.com>
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libselinux/src/selinux_restorecon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 42a48f5a..0f0fd6ca 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -672,8 +672,8 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
>                                 selinux_log(SELINUX_INFO,
>                                  "%s not reset as customized by admin to %s\n",
>                                                             pathname, curcon);
> -                               goto out;
>                         }
> +                       goto out;
>                 }
>
>                 if (!flags->set_specctx && curcon) {
> --
> 2.20.1
>

