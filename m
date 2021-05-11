Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23112C433ED
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC7E616E8
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 01:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhEKBun (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 21:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhEKBun (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 21:50:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95280C06175F
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:49:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s7so16259297edq.12
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 18:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GC+jcwYuSlGwJ2d485mepP4KelpwOyaTe94c08xajfQ=;
        b=xZeeTRD1Py3Ep5O8bkGrjjCbMORAPBblaI9SG5G7RNQvcwF81lU7VKMHEEx/RZbbis
         H+eTlm5BQh3XW4suI5xn6He5ui1geRSvdmxGw4kDXGHZMKzThcUNQBrc+QPsOjF7ecNi
         X3Ks+DVHKy+IDRyoi+WPFcJLy86hLZar9QnLg9lHmteELQIN38+03VEyGnZOpOfUBFEr
         iibOmzhCeqDu4tLZCsCNDGf622ynCiSOu+5B6xFKtD7kxriPKDFGNwFqs8a/FQOAV/PT
         eoJMf0C+Q7LrtUzVpQk4L8TK50IWSjEPOjPhbzqV2bBicMp2n2Ty6nLRMnISFyJfAxqm
         huCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GC+jcwYuSlGwJ2d485mepP4KelpwOyaTe94c08xajfQ=;
        b=pKBQWxl/TTHcECSGNXUnbxwJaKnBXGizbiUfCDuM82SoUtneBvhJWORr3m9kvvWATm
         UIFGw2MF9AonqgqnVGca8wHlpccXb2fHXEjvY/vlr4EzxYk63qoFTnJp0JzbHqsVtJTm
         +MV6nMuv6AkLuSQv2ilkh6xMCM0NG0RLalnSksQ4b6aRI6G9V/TpD6JfhMSLhqAf1+06
         4UyzDfTQA8mM3SjJmUJOcHXP9V/ea2m5hx1G6QKV1c+vuW/kW8vC1Wi7iYs3d0mvONke
         s/o0ekkNZfOp2GkdYCTzCOCHbKVLPNBKQwbYLrSpfE/Q7ReHQoayfH3FTytuoAmYUwhN
         3F8g==
X-Gm-Message-State: AOAM530OyYNBNYiYteRWUOcSirPck/4W4FvQkrJVgMoDMZ0U2KAtLhpb
        sIYXtHQw+vQtn5EYjMBxW9ynxlt/9kScM0rpgjK0lmCRuEFy
X-Google-Smtp-Source: ABdhPJwjVnamGG/jYjAW0Ym/j+pyybJ9iee8648B3crpa2HR6Of28omAtKhJZFw8AuC+pWNa7k/q/lNaLnMvtk51mew=
X-Received: by 2002:aa7:de9a:: with SMTP id j26mr10088284edv.269.1620697775288;
 Mon, 10 May 2021 18:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <1619604015-117734-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1619604015-117734-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:49:24 -0400
Message-ID: <CAHC9VhSxDoxnKrw+bZQ18YVMm56ajza4wzFv=3L3SZf7qd5QgA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove redundant assignment to rc
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 28, 2021 at 6:00 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Variable rc is set to '-EINVAL' but this value is never read as
> it is overwritten or not used later on, hence it is a redundant
> assignment and can be removed.
>
> Cleans up the following clang-analyzer warning:
>
> security/selinux/ss/services.c:2103:3: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> security/selinux/ss/services.c:2079:2: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> security/selinux/ss/services.c:2071:2: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> security/selinux/ss/services.c:2062:2: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> security/selinux/ss/policydb.c:2592:3: warning: Value stored to 'rc' is
> never read [clang-analyzer-deadcode.DeadStores].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  security/selinux/ss/policydb.c | 1 -
>  security/selinux/ss/services.c | 4 ----
>  2 files changed, 5 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
