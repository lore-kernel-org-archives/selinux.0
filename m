Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D2CC43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 21:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677E020873
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 21:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbeLSVwT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:52:19 -0500
Received: from mx3.polytechnique.org ([91.121.62.107]:53929 "EHLO
        mx3.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbeLSVwT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 16:52:19 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2018 16:52:18 EST
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8F8861E48AD
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 22:44:25 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id w25so20484156otm.13
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 13:44:25 -0800 (PST)
X-Gm-Message-State: AA+aEWawnhiDdrWaNjGSgbg9CNReYRWvhlAvlvsLQohqTdyfgLdUoMWP
        1v+YA+Udt9TkV20UT1YIk3+5aeuASzDytoGu3pE=
X-Google-Smtp-Source: AFSGD/Vwe8pDFGse9hMCZBk/Keo6nJLtp3WNqxfbojtppRGgpAwpxdWfRIHrP+He3NhL8AK+l/oq+nRhuZCa86ghcpM=
X-Received: by 2002:a9d:3e4a:: with SMTP id h10mr17244816otg.74.1545255863573;
 Wed, 19 Dec 2018 13:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20181219114500.22113-1-plautrba@redhat.com>
In-Reply-To: <20181219114500.22113-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 19 Dec 2018 22:44:12 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mxwdQje-fSt=1HOP86rF+H+-Uj7vTNrtszC6CL0EtUeQ@mail.gmail.com>
Message-ID: <CAJfZ7=mxwdQje-fSt=1HOP86rF+H+-Uj7vTNrtszC6CL0EtUeQ@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: Fix check in raw_color()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at mx3.polytechnique.org (Wed Dec 19 22:44:25 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 19, 2018 at 12:45 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> raw_color() uses color_str as an output argument which is assigned to a new
> allocated memory. Therefore it should fail when color_str is null; or
> when *color_str is not null in order to avoid a memory leak.
>
> Fixes:
> >>> selinux.selinux_raw_context_to_color('system_u:system_r:inetd_t:s0')
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> OSError: [Errno 0] Error
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

> ---
>  mcstrans/src/mcscolor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mcstrans/src/mcscolor.c b/mcstrans/src/mcscolor.c
> index cc6174bb..6ea1aa97 100644
> --- a/mcstrans/src/mcscolor.c
> +++ b/mcstrans/src/mcscolor.c
> @@ -292,7 +292,7 @@ int raw_color(const security_context_t raw, char **color_str) {
>         size_t result_size = (N_COLOR * CHARS_PER_COLOR) + 1;
>         int rc = -1;
>
> -       if (!color_str || !*color_str) {
> +       if (!color_str || *color_str) {
>                 return -1;
>         }
>
> --
> 2.20.0
>

