Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A327EE020F
	for <selinux@archiver.kernel.org>; Wed, 13 Sep 2023 21:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjIMV5H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Sep 2023 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjIMV5G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Sep 2023 17:57:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ACE198B
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 14:57:02 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4136bfb3220so1475551cf.1
        for <selinux@vger.kernel.org>; Wed, 13 Sep 2023 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694642221; x=1695247021; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1fI0z3hvkFXxuX039z2cx7VykRCuw0/mepb/WnviFM=;
        b=dWjb7IrzdiUAoGHgGxD5Yv9XACKsKLdMwTBARFmvQbr6cUEl5ROshC/+wDRODVMTTO
         eOatVIl6mi+JR30RD15ChqvKi1hmyLvLRkKDN57KbTmvGudqhY4Ahfzh1EwJo2dm0ojN
         /A3hvW0qc7FG6S7xAUB+ERqDOx50kFHHElCt88aoyM8qUaLuIJPsai004gFM6f8YqTS8
         vfALYZ7UzhPlnLrCE32InBLj4E4akFMgDIjdML9coqz3eRQk00356bzVC2YkwiAIwQWU
         18BVWNUItVflJPLSsk11aIAuYtCerHhmqWK5/MnaszKaKRZNagLrIgeDf/BpGY3eQkOc
         PHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694642221; x=1695247021;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1fI0z3hvkFXxuX039z2cx7VykRCuw0/mepb/WnviFM=;
        b=Mhp2YH9BRzKWo2QdJG1Ybs1NQPuG2qAJJJDTu+ZExMS+ROjDE9CEnLkIxjCRH1hRgv
         jcePtamvMJz7jpG0M3Eg7+66EzHZfvVbc3Oy8zB7rvRyWvwMB1RlcKN0kJieE2d1Vikm
         deOAb+mxQhi2RUMAZ4GUGh+Zb9X7XuiipClvZkPmeEzG+3uNn2lUE3T+WiAyDrH/v1XJ
         UlQrOjibKyQyooTbNs5z26fJMkRyfI/kI9kqvfeU7y1k2YhLRBaN4fii3aXTRal70tcY
         iVDIABgtmIc8zd6zXlSKMnuAE7n1/W/B110zyam+VNYU6+DG6ZhSDAMiV1Fb8L8+ynQq
         dzRQ==
X-Gm-Message-State: AOJu0YxnjJP+wwMrcSby7llVGsm7nWuop0nP0vzW07K4dz8QZgMFurpn
        Pg2yGW89/9kEpD+5RroJyXCO
X-Google-Smtp-Source: AGHT+IEEx7g9ZHMZUerHPAehv2TzUr0HZkUE7qk5Y9FLUTaJrd6lNIRKttrjoAVsDGIy8Hnp/Bc4ag==
X-Received: by 2002:ac8:5753:0:b0:410:97af:cf86 with SMTP id 19-20020ac85753000000b0041097afcf86mr3909186qtx.31.1694642220981;
        Wed, 13 Sep 2023 14:57:00 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id y13-20020ac8524d000000b0041519ba589fsm67514qtn.6.2023.09.13.14.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:57:00 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:56:59 -0400
Message-ID: <476895eed013ebdb836ae40fc1f62561.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        ztarkhani@microsoft.com, alison.schofield@intel.com
Subject: Re: [PATCH] lsm: constify 'sb' parameter in security_quotactl()
References: <ZOWq2d5c7MpLl5A4@gmail.com>
In-Reply-To: <ZOWq2d5c7MpLl5A4@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug 23, 2023 Khadija Kamran <kamrankhadijadj@gmail.com> wrote:
> 
> SELinux registers the implementation for the "quotactl" hook. Looking at
> the function implementation we observe that the parameter "sb" is not
> changing.
> 
> Mark the "sb" parameter of LSM hook security_quotactl() as "const" since
> it will not be changing in the LSM hook.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)

Looks good to me, merged into lsm/next.  Thanks!

--
paul-moore.com
