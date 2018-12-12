Return-Path: <SRS0=wb4z=OV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44AC65BAF
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 22:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEC72084E
	for <selinux@archiver.kernel.org>; Wed, 12 Dec 2018 22:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="M3686huM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEC72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeLLWYU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:24:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42676 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLLWYU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Dec 2018 17:24:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so4341lfh.9
        for <selinux@vger.kernel.org>; Wed, 12 Dec 2018 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlSryIbYey5QtHb7IvgVv0wywHinBsbgwed2UQ+zml4=;
        b=M3686huML2jBskS5Tl84RHK++4qtKjHFk/UUjgioEJy3s86rJhYXJJK8R7hRToFvcQ
         4LryB8h/xZNhRH7ixxrvw1SvDIOiReh3wmBFfGx996wtBXvT+/viG3ckuHoiSi+9Gq0H
         AfnHjSGQFY7cd3KyrsDKMS51P+VtyIhU3C2x0zPEERdPyrATI2knsXSsC3IdTRqAs/Js
         HE4UT4GD5PZ0/F5/247Jyk7IXThkbumtcnZTR5Tj0gXYB9oU3SGdANgCimFnLGZcghu5
         N4tduWINDVXopqUR8500sUh1plM4lYOSMSe/L2YfdKTzw83NTXY1momRXTGZAR8Vq5u0
         j5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlSryIbYey5QtHb7IvgVv0wywHinBsbgwed2UQ+zml4=;
        b=cFVwYw6lBLpfJVw25HzRK3nHMkPhBT8yIG0qiPLMFvqGM9ty0NlPkQEUWrXO2wdiaD
         WT/ldszDbNMzYLk/tqHRFfuTEi5E5qx6TPkBb3XFdh1na+vGoHkUAL+00t0RiFp27uam
         bI81bnxcTw94CYULZ/JDVOJrjy+8WiMv7k+dKFAkdN6Tq0D515dlnyU/2kroer+eSzgM
         98dW58SMNypwUpSKeAVapug3lkp2VBgojf70zJde+g/f5UrFUuLC3XEuAkl77DfY8MoL
         U1ImwIYkP9WPLOD9Ev6lKHJJAI4J+TsF0eZEQXcgzT1UhS22l6+2Bg3KM3HGVU9u9YLc
         c8Kg==
X-Gm-Message-State: AA+aEWYlFe5ikvY6KM0YjRz4Th/NKlJwpTkHC8MR7DaSBQCMZSuuwORB
        JDEgcA/p1x2H1RE8goeyTzP/Vkm0kgVg7lCVQ7xs
X-Google-Smtp-Source: AFSGD/XXza78TuFqNj2ZCgvWqQIR5z1u+7RayaV2gSGIJPAF/c30IM3viBx5zpXQwhFlhrU6XJ9joPqZ518uJY6ltec=
X-Received: by 2002:a19:6719:: with SMTP id b25mr4940504lfc.38.1544653458384;
 Wed, 12 Dec 2018 14:24:18 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812130915190.5053@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812130915190.5053@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Dec 2018 17:24:06 -0500
Message-ID: <CAHC9VhTGF3SxRh0iTMhqFYExh3HrKVn7Wnko-_hb+y+6BmCRaQ@mail.gmail.com>
Subject: Re: SELinux testsuite failure in overlayfs with v4.20-rc kernels
To:     James Morris <jmorris@namei.org>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, mszeredi@redhat.com,
        bfields@fieldses.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 12, 2018 at 5:19 PM James Morris <jmorris@namei.org> wrote:
> The SELinux testsuite is failing in the overlayfs tests in current -rc
> kernels. I bisected the issue to
>
> commit 007ea44892e6fa963a0876a979e34890325c64eb
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Fri Oct 26 23:34:39 2018 +0200
>
>     ovl: relax permission checking on underlying layers
>
>     Make permission checking more consistent:
>
>      - special files don't need any access check on underling fs
>
>      - exec permission check doesn't need to be performed on underlying fs
>
>     Reported-by: "J. Bruce Fields" <bfields@fieldses.org>
>     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>
> Reverting this commit fixes the testsuite failure.
>
> Is there any more information on the rationale for the change?

This is a known problem, see the archive link below, with Miklos
promising to send a revert to Linus for v4.20.  I just pinged him
earlier this week to remind him, but I haven't heard back yet and I
don't see anything in Linus' tree.

I would much prefer if Miklos sent the revert, but if he doesn't send
the revert by the end of the week, I'm going to send one next week.

https://lore.kernel.org/selinux/CAJfpeguJoEOEjQs4ZpJQaJXF-xCnevUApzNobwmqNX27KQ4vHQ@mail.gmail.com

-- 
paul moore
www.paul-moore.com
