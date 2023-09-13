Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E76EE01FC
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 17:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjIMRrC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjIMRrB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 13:47:01 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CCF19BF
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-450fce34e99so71726137.1
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694627214; x=1695232014; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZcFS3iOYkQO2W9mwcWv2JH1y1FxtklhD4Z215kPDlM=;
        b=GFNdi1KOqfLdtuk0R1uPPHQzi+NX4UlLmaO+Ul0vl0+LR0T/KSld967e7+FCf6rl4C
         G4OZiOFmLWNmcVLbrz14ELqZ4JKoqsbbvfBX6PyES8lmmDOZgI5/9zBmJ5chOeVDdrR5
         fHPPoIDnYybgONYGq7oBU0hnz80HplDYUtyOA/J4fCkvT5luh7WUANL4HAREBK1ZWsSU
         TVAsQwmyc8sRXdUn7uxAWAaVm3Y/06AAyojp2ZwzpIn2BaGm+vU3wcobMpEL8fsbH5za
         SDZuiYJVu+8IhXRULzasgJnqj73iB3zWD66v89Qw/dR9JidB8xTPVxOr98avigOPBlvM
         S5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627214; x=1695232014;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZcFS3iOYkQO2W9mwcWv2JH1y1FxtklhD4Z215kPDlM=;
        b=aAgsmVCjVpiP5MKAfjWd2YGK11QJEvrsi+RlRaQ3/3GiabkQKYINO8ytN9XRu1z73K
         nlsl0uHFpRM3KwV9KqIV3hQKP0+L6oZIh37p/Y009gcHE/qKtH7HmqXVuWKku0QC8hBw
         6oiZhbAF1eEJjlhrDd8Z7vf8/cBjE041vDLq8tesdrn6mk9DhjkyqTWmyNZw77j9tMjY
         02+82nfadTuViqL2Sw2MYFMqPp7sE0EE4T/54MiQWoIZ0V561CHyP4EzyBuxWTjVpTYb
         w9wfbILO+eyjLZ58rwemUaLhD6WvhJGH5kQK0PnpFsJinnCAqUdode/6Szy8dF+w06lg
         /8DA==
X-Gm-Message-State: AOJu0YwaDlPpJ9XLII5+sVl1Tvw2yksEKppJ7q+7i4hbJ2LV6p6GpqAz
        YFbYZ77SQWW2WsWVs8dOR0FZ
X-Google-Smtp-Source: AGHT+IEsLy5oMnv35nf0coOHBYWP0U4cJdBDcW5tlQYuaToqfLvM4OCZlHGLBbkzQBzrLXaeY6z4dA==
X-Received: by 2002:a67:fd97:0:b0:44d:5c61:e475 with SMTP id k23-20020a67fd97000000b0044d5c61e475mr2535485vsq.32.1694627214045;
        Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x18-20020ae9f812000000b00767da10efb6sm4026837qkh.97.2023.09.13.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:46:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:46:51 -0400
Message-ID: <186da545d95255f5ba2368d09fb1a667.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] selinux: print sum of chain lengths^2 for hash tables
References: <20230818151220.166215-6-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-6-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug 18, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Print the sum of chain lengths squared as a metric for hash tables to
> provide more insights, similar to avtabs.
> 
> While on it add a comma in the avtab message to improve readability of
> the output.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c    | 2 +-
>  security/selinux/ss/hashtab.c  | 5 +++++
>  security/selinux/ss/hashtab.h  | 1 +
>  security/selinux/ss/policydb.c | 4 ++--
>  4 files changed, 9 insertions(+), 3 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
