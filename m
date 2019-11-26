Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8006DC432C0
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 14:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5246D20727
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 14:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="A84KCxo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfKZO7B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:59:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39112 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZO7A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 09:59:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id f18so14331091lfj.6
        for <selinux@vger.kernel.org>; Tue, 26 Nov 2019 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eayF6Yqhzpqvz9bB8ZXM3qGNWF9TDQ7NmIzBjxe7aYo=;
        b=A84KCxo3JplzfN47P0+T33FuhKaHV7oZBRfQOL7YKOccGbW9/xBjv9h36FbBYrSjwf
         xBzQA11iGqiNTu5DsHDgBfD0V9rH3G1l0ZVcZeaPdY4CP3EI43lByVv9yda3j2Oy7F4u
         u5EgyvHCgGd31lhCEpRV2T3l64+GUS4k7EjuXq9RMNWDxBYW4KAqHyz4iQT1nuKdIGhT
         J6cJmYSQaiw2PxyMbRS4Hg/ZVmu+BS6DNPFwlTrUbymkmRalxhRasFeL9PfcnxMR0SCK
         4y9IyVL1JpZcGpOgSauIv6pPlRScB5yUuPYg+gc+iQ95uSF3uROri9GKH3Qr14jJzj4Z
         /gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eayF6Yqhzpqvz9bB8ZXM3qGNWF9TDQ7NmIzBjxe7aYo=;
        b=NfbkDWWw2Xxn9/FzMTvlZBcRTIszSJmvmqN9ACARU1ZBxPvKxugaDjRmD5LIfXWId3
         xlGGhkmEpJjWwBDEsrjyC3tKJUmixKRlhNVYgrpRzlSgpKb4UxjxqkVeHEwRs6VwFWzM
         j80/dZH57yj813DLUiA20JIoN9zAG4/yb37axcJh/ROIzI7+D/9wRWousxbQVrrbHfrj
         Vxc55UnDXW7iaZmOzcco+N7BjNZc4DlrfbWHHMDUIjFDqZvYBpu8UF+HUGMVu76O8Usp
         YQf7Dri6wCfQHVX2ZA6B/R1H6D7Axpo0IVazxxmlxYxPuksTehL10ePBTVZxxmjF6R5j
         QI3Q==
X-Gm-Message-State: APjAAAWII+brV5abVkISQ1tFNhDRsJjR4k6hfyQRgJjHEvCcY/gKSNXv
        IBF0y+trpaptMYM0ZZXWTYXXZPO6nW9jZQ8g3nCV
X-Google-Smtp-Source: APXvYqzIPR8GqnX8vicUKyTvvUVeNrKwiBWpc0adiw2qgXrDYgjL61C+TUQyice7opEnxlFHqP+CHClwKVbkKYGu+Ks=
X-Received: by 2002:a19:6553:: with SMTP id c19mr24805266lfj.158.1574780338762;
 Tue, 26 Nov 2019 06:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20191126135700.743238-1-omosnace@redhat.com> <7ea9d889-c226-68a3-7dfc-3c507eefa53f@tycho.nsa.gov>
In-Reply-To: <7ea9d889-c226-68a3-7dfc-3c507eefa53f@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Nov 2019 09:58:47 -0500
Message-ID: <CAHC9VhQvoMaH8ioQhExFV_noRXvcpro1yJ59vxrJCaT+-Mhzug@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: cache the SID -> context string translation
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 26, 2019 at 9:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Looks good to me and tests passed.  I anticipate resolving conflicts
> between this and the sidtab reverse lookup hash table being non-trivial
> so it will probably require some review when/if Paul merges them both.

I haven't yet looked at the latest revision of either patch, but the
previous versions looked pretty good (my only comments were rather
small, and for the most part everyone else seemed happy as well -
minus the small fixes).  After I send the merge window PRs off to
Linus (tests are passing so that should be today) I'm going to give
these a final look and start trying to smoosh them together; I'll
probably create a new branch ("next-queue" or something similar) once
I'm done where people can review the merge and point out where I
messed things up ;)

-- 
paul moore
www.paul-moore.com
