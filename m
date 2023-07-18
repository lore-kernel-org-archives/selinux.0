Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1291EB64DD
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGRWC0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjGRWBx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDAF1FEC
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:29 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7672303c831so572969485a.2
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717688; x=1692309688;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7cvKLgtD/217BQRA+bkKMA4ANBUEIBaK9JXp5Tj1STM=;
        b=fgyUOy16nTE/+8D/AcsZWujerTOKHVFqSoHNpJaDj19SFZj5C4I4E2QX06T3BCyQIu
         cdSqre6IZm/RTrJrl8SYJqLAEBpyXW27DzRlWoNrQJnW4AvfGR6KGjqXZ+3yQQvQVlDB
         PF/nIVNQLYlrlyoC5vSkbb/4nJ7vGseCAS9yQ07WdK1H+4QWXkCc/40pYoWbTwGNRJAg
         yIYmb4bOMGdRWkOT2awOpeP8vZ8oE1Ke7VGwBcSumLrI5x3XCpxStxoBXWCow7F7G8i/
         lFdtsHzdB5t7bSVxAfCLw4NwWAulmjmuhp08/nVwzfbuXyJTyxglTYE1R3J8HYuspcrc
         R/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717688; x=1692309688;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cvKLgtD/217BQRA+bkKMA4ANBUEIBaK9JXp5Tj1STM=;
        b=chGL2g6N7KO1afaENcpTWo6Hp2R2t0LZsc7tRL9YbKqs+Rpmc0T/3BczVqG+LhOh4y
         hMW8WxF9EXX3n+a40K+5lLDzVqHtZmtL/Sef3TBgHcOki15/HtOInaft8Pk5LRy0xjK9
         4PBiSNFxyoQ7xZANUO+WRqA36aE9tpZ+nYNSIEqQ2sfdV1CLXdk65j0zO+FY5CTnP+1d
         Suhj/1nPlIt9jVmZoV5plLPGuiRKwArZU5XDvehSU4kCYseeO3WJNIR1WC2HKXRIYXY6
         FJ6vH7rPy9Wqfcxb7zSvdhvw2FumUHgDnNe3b8Z5mPU8imCC5EaLtTqENINe+2u4v1qS
         MZYw==
X-Gm-Message-State: ABy/qLY0AOkYkro9HSStunKi9l5s+YXvGP42AImW7HS+2Rj3RGwGTXyl
        4b5q3snzYMresQ99IE22YSaK0+8XaSanuVCaEQ==
X-Google-Smtp-Source: APBJJlFSuSd4IQ0+xazwsY3DF2Xz6ADU7iBtxV41Dt00hSAJsfnNtbJrSeoTSgHuMIWB00PWZWkQIw==
X-Received: by 2002:a05:620a:4105:b0:767:1b06:ba58 with SMTP id j5-20020a05620a410500b007671b06ba58mr18610646qko.29.1689717688372;
        Tue, 18 Jul 2023 15:01:28 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l21-20020a37f515000000b00767d05117fesm894644qkk.36.2023.07.18.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:27 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:27 -0400
Message-ID: <336bba31975d43e1d2f4ad9c2b9fc170.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 17/20] selinux: services: implicit conversions
References: <20230706132337.15924-17-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-17-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the type identical to the source for local variables.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/services.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

More loop iterators, see my previous comments.

--
paul-moore.com
