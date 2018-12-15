Return-Path: <SRS0=8Orh=OY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63030C43387
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 15:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E55206C2
	for <selinux@archiver.kernel.org>; Sat, 15 Dec 2018 15:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbeLOP23 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:28:29 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:38734 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbeLOP23 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Dec 2018 10:28:29 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 5B78556481A
        for <selinux@vger.kernel.org>; Sat, 15 Dec 2018 16:28:25 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id i20so8337119otl.0
        for <selinux@vger.kernel.org>; Sat, 15 Dec 2018 07:28:25 -0800 (PST)
X-Gm-Message-State: AA+aEWaz9Yq1qOj+u/vz5fgVV6tx/0WwYJHxywjr5g8sqOEhHRYTAfKA
        5wPZFfRr5k3UXCPRQypoO9VzKt/KjK6Q1l1FdbA=
X-Google-Smtp-Source: AFSGD/W6G+agBmA9MWpKtr7ll1XV7+7XgUlAdBpHZWbypRgjCYM3OcfDSgvBjIRHmWlj7qojCn/G4f5+FXgVDDW5Ogg=
X-Received: by 2002:a9d:6c44:: with SMTP id g4mr4652143otq.368.1544887704328;
 Sat, 15 Dec 2018 07:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20181212152826.24140-1-plautrba@redhat.com>
In-Reply-To: <20181212152826.24140-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 15 Dec 2018 16:28:12 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==ehVcSkb1NdMch1mErAVMTevWuvQzd_JdTsmkb2WOsUQ@mail.gmail.com>
Message-ID: <CAJfZ7==ehVcSkb1NdMch1mErAVMTevWuvQzd_JdTsmkb2WOsUQ@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: search() also for dontaudit rules
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Dec 15 16:28:25 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 12, 2018 at 4:28 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> dontaudit rules were accidentally dropped during rewrite to SETools 4 API in
> 97d5f6a2
>
> Fixes:
> >>> import sepolicy
> >>> sepolicy.search(['dontaudit'])
> []
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

> ---
>
> Same patch as https://lore.kernel.org/selinux/20180918134401.22956-1-plautrba@redhat.com/
> but with a slightly reworded commit message
>
>  python/sepolicy/sepolicy/__init__.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index cd7af7cf..fbeb731d 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -344,6 +344,8 @@ def search(types, seinfo=None):
>          tertypes.append(NEVERALLOW)
>      if AUDITALLOW in types:
>          tertypes.append(AUDITALLOW)
> +    if DONTAUDIT in types:
> +        tertypes.append(DONTAUDIT)
>
>      if len(tertypes) > 0:
>          q = setools.TERuleQuery(_pol,
> --
> 2.19.2
>

