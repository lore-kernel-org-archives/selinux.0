Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2C1C169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 22:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5E720833
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 22:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfAaWGb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:06:31 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:49492 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfAaWGa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 17:06:30 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A3AB6564692
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 23:06:28 +0100 (CET)
Received: by mail-oi1-f169.google.com with SMTP id y23so4147812oia.4
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 14:06:28 -0800 (PST)
X-Gm-Message-State: AJcUuke6tRSrYmniVYpx1Y0rRTV6MOI9phuYy7Ob7OELXRBGkns7luTj
        ePZYRgpAZ1EiSmwZN8bk2cHTv+hrOrVRfxn2in8=
X-Google-Smtp-Source: AHgI3Ia9MOzPoHAVCWMcz0CelwGo5Yun07mdUFDuZcf4QTKWG1zhd5g8yd3NAahcKqmOBFdeXGQPVT5R2JQO6LzGihs=
X-Received: by 2002:aca:e142:: with SMTP id y63mr15876388oig.314.1548972387641;
 Thu, 31 Jan 2019 14:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20190131194140.3785-1-plautrba@redhat.com>
In-Reply-To: <20190131194140.3785-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 31 Jan 2019 23:06:16 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nUFYY9QLaArWAfLksvjB-xvvPwz2TvxuKPsTysSG5K=w@mail.gmail.com>
Message-ID: <CAJfZ7=nUFYY9QLaArWAfLksvjB-xvvPwz2TvxuKPsTysSG5K=w@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: Examples are no longer in the main
 semanage man page
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Dan Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 23:06:29 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 8:41 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: Dan Walsh <dwalsh@redhat.com>
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Indeed, commit 1925e1e91d99 ("Break the semanage man page into
different man pages per category.") moved the examples in 2013.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

> ---
>  python/semanage/semanage.8 | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/python/semanage/semanage.8 b/python/semanage/semanage.8
> index 0bdb90f4..0cdcfccd 100644
> --- a/python/semanage/semanage.8
> +++ b/python/semanage/semanage.8
> @@ -57,9 +57,8 @@ to SELinux user identities (which controls the initial security context
>  assigned to Linux users when they login and bounds their authorized role set)
>  as well as security context mappings for various kinds of objects, such
>  as network ports, interfaces, infiniband pkeys and endports, and nodes (hosts)
> -as well as the file context mapping. See the EXAMPLES section below for some
> -examples of common usage.  Note that the semanage login command deals with the
> -mapping from Linux usernames (logins) to SELinux user identities,
> +as well as the file context mapping. Note that the semanage login command deals
> +with the mapping from Linux usernames (logins) to SELinux user identities,
>  while the semanage user command deals with the mapping from SELinux
>  user identities to authorized role sets.  In most cases, only the
>  former mapping needs to be adjusted by the administrator; the latter
> --
> 2.20.1
>

