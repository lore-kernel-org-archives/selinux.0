Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A9C001DE
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjGRWCN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjGRWBo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:44 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856B1FCD
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:27 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7679ea01e16so565257285a.2
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717686; x=1692309686;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNBgqhbwS3m6bM0Sx4mFuoy8DGUxjMTmWp+uII1JX8o=;
        b=BCrdpvT0EtYv8uEi5CZ4oBTiadWO0/j6QFw/wO1ORmRcpGPA1NfDg8IQNLTnx8tTXw
         hjAEx8OUhLv5LTdmIk/w+3BSZz2TiWaUBo9gCnTTlt2pdBe84wjDNubgJ5W8lC0P1YA+
         XmD9Ivj+c19AEX9GJt64jWsKD9mBXPd9NjNX4vMDD+RjhUWlh98NBm9jzxyNnxsG8dQ2
         7Wk2oRTbyDneRiUWrBeumiNQ7lA5fjz0tiSSoFl7AgyGNpwGFiiWyug9zgM+2yMOcIKt
         vm5PxFm4H7ijvkBQCyZjiqFiZzTUFvPvblq92ekFp+pAapsbmeMiXqJkKJ17wn8cpJVV
         9+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717686; x=1692309686;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNBgqhbwS3m6bM0Sx4mFuoy8DGUxjMTmWp+uII1JX8o=;
        b=Ez16ldRAYOMR2JO5N5XxWZLeCmR9kpilnCDpWzsTy2vBlUKRpIAo8AyKuwEIjCqEcq
         ujXqx5n6/UNBRrR+Wo2ui3rPF3fFyUCH7r0QwckLuHcG+BPOgyCzHlHvmN+lbb+TvvQX
         Ub5E4HeSnFv24S/HWkk512HnmxGXXDLkTtkAnampcSrk0VNuJuKfConQnwD+X+h9PwJu
         SY9JxJmR+b5vyFFxbP/6gyawcwfPsXSEf86qgzfmOIQub0JgeD1xc4DZ6mH3GgI8ASEM
         rbFDMKUsxgkmfoCKs1x6fqrQZk1uHNZGmZQMkvsXJugEPRO5WyrPwWt9j4ifQ+11fMht
         h1tw==
X-Gm-Message-State: ABy/qLZDBqQ2RDwRmwI3MfDJzua9qUOALheeub6ajKGIQRqdKxnAB417
        7/N7Xuf76NPGit6v8TU7M4XN
X-Google-Smtp-Source: APBJJlGl5vbaXsutc56BsIHY4QBJ4VtDW3dC3kcKTyQT8SIb2I5XttMf5ZPcxUa4KB+fsz923atByg==
X-Received: by 2002:ad4:514b:0:b0:62d:fddb:1856 with SMTP id g11-20020ad4514b000000b0062dfddb1856mr14051160qvq.43.1689717686374;
        Tue, 18 Jul 2023 15:01:26 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w11-20020a0ce10b000000b006300722883fsm1024024qvk.33.2023.07.18.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:25 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:25 -0400
Message-ID: <5b5dcaa8860c3cd3f40b63b855cecd96.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 15/20] selinux: policydb: implicit conversions
References: <20230706132337.15924-15-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-15-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical type for local variables, e.g. loop counters.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 112 +++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 47 deletions(-)

Loop iterators ...

--
paul-moore.com
