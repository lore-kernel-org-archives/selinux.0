Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0209C433E3
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2424207DE
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="P3tFgwbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgHUNqE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgHUNoi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 09:44:38 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EF0C061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:44:20 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id m22so2311298eje.10
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXXPJydGYLxVLAnND9+MkrJY76llbSccxUgNW+Lv5wU=;
        b=P3tFgwbNyM317sHhrjtKjK2APvK6lQs+3oKvUqo69/wpQAOZVAw8lE6cGolXn6bX2x
         kt0u9Fghb2r+lgs/kHUS3fcv/ToVWdWF3lB1L39XwhiJBA/ATZSfAaP2QXAy8TMZ/2fP
         ta5yZ2CmH1CwVy2OLH9tO/kLw/f8AAiw+B74R+08yUeQPrUoDVawlEUTdgu2vmaQgOOK
         QiVayDVtIv60YvuEczLcA/uiNx/AHTmtCfPoD46JhR7ILWQ5NWPFKBtKkwQRz9dZm/AP
         BcACyQzAvxSwefGCpBW6RYHLCAIJLsy6UuyKHgUP/5rpMUZQBYJTwILeG/wuqlh3Qn7W
         CKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXXPJydGYLxVLAnND9+MkrJY76llbSccxUgNW+Lv5wU=;
        b=Z99d5k/0bWGIhvEZbya6AWzxNTl8OFunfg2UUvjoUtdti8t/mAdjJ9gOtRvuln3LN7
         wID8nDlblP+Zs9PgcNnbAfYrUSQ7rKTXGaoAM+7ephjrROC2OEQSPLnG9dnsc7zJaqBd
         Y8U74IFCCeD7iuoe2GPkFIItjBwBjUZrkpLyC22VM5LihN0HeQz+7jvkwyiUdVIOBH2x
         ehBhI0B1ReodC1uZDqGAO5EApQPC3/rhOR5b+uu4nBK1g0hCPbkDz+L22P7RWUDR9vYB
         GSRaHT5bVO44tmPnPwCha3SSOgQETjwSnTRsbQeuWfLbTe6iusND7xDTUG8qnfkMHiqL
         1CDg==
X-Gm-Message-State: AOAM530GR1tRcHnljM4P9syuupyZ7yvFnKKEbvoJcvsRXDqTjlxADMrT
        bZlsIDuy3RW4D4v3qUdgsXBjzsV2IKBl7WQ6N96S
X-Google-Smtp-Source: ABdhPJwQg1C4vsXTA8yCZ8ot4n1xI46WPhXkaJY6J1PpBsCXA4+Yw6nwT2uG1SK5HAi+3s4lVb3+5O9gUzM1A+/+pwY=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr2902076ejn.542.1598017459107;
 Fri, 21 Aug 2020 06:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com> <20200819195935.1720168-4-dburgener@linux.microsoft.com>
In-Reply-To: <20200819195935.1720168-4-dburgener@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:44:08 -0400
Message-ID: <CAHC9VhRD7ZCK6ovxp4odCMphT-QWj4qV8d2oSmaormKTsYrWww@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: Standardize string literal usage for
 selinuxfs directory names
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 3:59 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> Switch class and policy_capabilities directory names to be referred to with
> global constants, consistent with booleans directory name.  This will allow
> for easy consistency of naming in future development.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>  security/selinux/selinuxfs.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
