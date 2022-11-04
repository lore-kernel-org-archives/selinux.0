Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED76C4332F
	for <selinux@archiver.kernel.org>; Fri,  4 Nov 2022 20:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKDUFE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Nov 2022 16:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKDUEt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Nov 2022 16:04:49 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B403D50F20
        for <selinux@vger.kernel.org>; Fri,  4 Nov 2022 13:03:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c25so7872750ljr.8
        for <selinux@vger.kernel.org>; Fri, 04 Nov 2022 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iyGjnR8KcB8f1Mm9S1H1g2NgRRwPVU00hWqJJPwaEY4=;
        b=LfvWBMeDUBRotehylMrya/eMIhtIFnIQSToB5jbcGiTaGw3CZUMcphSyNuk4q57D/V
         YHMpWQYLbDKusR+YwVepE0bQ8gY4OsJn37E5KKxvFu1ybJDVWHzL2gxyk/LFPhhwT2qq
         JPzS7xA8NdJ7ATYP0nekhNUCOyht2h7KeCSY3wWuXnD17ST2R6lhny9leeJVjGqWYDdo
         AsZxHKTepOyhxxA5O9sPJnHtc1Fd2IpYt04Hx0xrvkKHMV1wlEfzfh0gror5bTSXvr2M
         qn3Z9nWCHcryEEvq6kWRzyBZlltdk/J7ozh0PQAuXoekJwPYIGB8xYBS1EA835aCPhHY
         Q/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyGjnR8KcB8f1Mm9S1H1g2NgRRwPVU00hWqJJPwaEY4=;
        b=YVGQwe2txSG8eiZdTDftkHZso+7sBmnYuRRWxl9CFTMXL8ezBy/HThukiqnwbV3zak
         9YfW+vIkPLQOEKy78jYU849aBOqBm/8xZvfdFVm7RShNZ715Nk6YXmpefRZ8bFzojTXJ
         LhpSzv4V1O0En1fpWV57cAp4qfPgQRYVKFzLEqxBCjI0PPPkVKKmSni7v/+JsudMSRmB
         cNk8KRg5Vh75utLPUGirlbuqa7fNRsNok9Hbn+D6TWZ2W4jZLjHHJ80NxUG+ZcDlNQoC
         XcmuuFrdhT9WghPKSrUQLPTbgTsSa/gLjKEoIv0nYnkjm+DfZUvKsrACSaNCcEjAbg8Z
         edVQ==
X-Gm-Message-State: ACrzQf1J3kjJVeroG5grAr/8N9YnI9kiUGlswUoWHmgc21JKb6shb8r9
        wW9/Ly5gz6VEgymYIa0sGhyY7a+GU/SIgU67DPx3EKYxfEI=
X-Google-Smtp-Source: AMsMyM7QB7ETLFSeqjGhxRl3t5UmtH7jm0HTJW2Y1cXZoPB/DJN3I3y8bITkQQ4ulV+h8CqLW0cYC4Bd+FwoIL5JOmQ=
X-Received: by 2002:a05:651c:1038:b0:277:5452:60f6 with SMTP id
 w24-20020a05651c103800b00277545260f6mr10347370ljm.21.1667592206559; Fri, 04
 Nov 2022 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221018203659.2329808-1-vmojzis@redhat.com>
In-Reply-To: <20221018203659.2329808-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Nov 2022 16:03:15 -0400
Message-ID: <CAP+JOzQBwgOwctaqT6ZQxTLXb5MF=FOhkagjbprqwvc4nEcbYQ@mail.gmail.com>
Subject: Re: [PATCH] python: Harden tools against "rogue" modules
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 18, 2022 at 4:40 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Python scripts present in "/usr/sbin" override regular modules.
> Make sure /usr/sbin is not present in PYTHONPATH.
>
> Fixes:
>   #cat > /usr/sbin/audit.py <<EOF
>   import sys
>   print("BAD GUY!", file=sys.stderr)
>   sys.exit(1)
>   EOF
>   #semanage boolean -l
>   BAD GUY!
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/audit2allow/audit2allow    | 2 +-
>  python/audit2allow/sepolgen-ifgen | 2 +-
>  python/chcat/chcat                | 2 +-
>  python/semanage/semanage          | 2 +-
>  python/sepolicy/sepolicy.py       | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/python/audit2allow/audit2allow b/python/audit2allow/audit2allow
> index 09b06f66..eafeea88 100644
> --- a/python/audit2allow/audit2allow
> +++ b/python/audit2allow/audit2allow
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
>  # Authors: Dan Walsh <dwalsh@redhat.com>
>  #
> diff --git a/python/audit2allow/sepolgen-ifgen b/python/audit2allow/sepolgen-ifgen
> index b7a04c71..f2cc0c32 100644
> --- a/python/audit2allow/sepolgen-ifgen
> +++ b/python/audit2allow/sepolgen-ifgen
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  #
>  # Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
>  #
> diff --git a/python/chcat/chcat b/python/chcat/chcat
> index 952cb818..68718ec5 100755
> --- a/python/chcat/chcat
> +++ b/python/chcat/chcat
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  # Copyright (C) 2005 Red Hat
>  # see file 'COPYING' for use and warranty information
>  #
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 10ab3fa6..b21d1484 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  # Copyright (C) 2012-2013 Red Hat
>  # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
>  # AUTHOR: David Quigley <selinux@davequigley.com>
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index c7a70e09..733d4048 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python3 -Es
> +#!/usr/bin/python3 -EsI
>  # Copyright (C) 2012 Red Hat
>  # AUTHOR: Dan Walsh <dwalsh@redhat.com>
>  # see file 'COPYING' for use and warranty information
> --
> 2.37.3
>
