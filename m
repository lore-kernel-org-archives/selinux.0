Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F00C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 22:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C117B20833
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 22:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfAaWCW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:02:22 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:37198 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfAaWCW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 17:02:22 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1E2075612BE
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 23:02:20 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id e12so4269445otl.5
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 14:02:20 -0800 (PST)
X-Gm-Message-State: AJcUukdNNs/AN/YPy2CH05xX8erYYxn7XrvwN7RXu6enxxk5MajEnDTH
        KzqarkmNbRsBKJXW7MBjisNuEIXKYTQlV48i8Bg=
X-Google-Smtp-Source: ALg8bN5t/CAjkS7KroHy8oG43bScOZm0lBK3K8Dq7eAnku3nQt/DgJMiyFpICVNhg4pFo/qb2wSAP/sEYNudqlwRJBc=
X-Received: by 2002:a9d:2f66:: with SMTP id h93mr28014595otb.165.1548972139131;
 Thu, 31 Jan 2019 14:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20190131194824.4944-1-plautrba@redhat.com>
In-Reply-To: <20190131194824.4944-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 31 Jan 2019 23:02:08 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kF0quUm_KAJqxw+u5KyYoOveaVMXBOTxevgOu41VWRPA@mail.gmail.com>
Message-ID: <CAJfZ7=kF0quUm_KAJqxw+u5KyYoOveaVMXBOTxevgOu41VWRPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: set an appropriate errno in booleans.c
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 23:02:20 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 8:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Fixes:
> $ mkdir booleans
> $ sudo mount --bind ./booleans /sys/fs/selinux/booleans
> $ sudo getsebool -a
> getsebool:  Unable to get boolean names:  Success
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libselinux/src/booleans.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
> index b3ea3623..a6d46fea 100644
> --- a/libselinux/src/booleans.c
> +++ b/libselinux/src/booleans.c
> @@ -55,6 +55,7 @@ int security_get_boolean_names(char ***names, int *len)
>         snprintf(path, sizeof path, "%s%s", selinux_mnt, SELINUX_BOOL_DIR);
>         *len = scandir(path, &namelist, &filename_select, alphasort);
>         if (*len <= 0) {
> +               errno = ENOENT;
>                 return -1;
>         }
>
> --
> 2.20.1
>

