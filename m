Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77191C001E0
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjGRWC2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjGRWB4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:56 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D202101
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:31 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-634efb81e8dso32791596d6.1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717690; x=1692309690;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q4Z5WjiQYpjKKIHMmiUkMvLecKSdsud95ripsYJYW2c=;
        b=QBsSyIZKaJE90Dtf17zQLs/VEtM8h6oEKDB9Lvpz8F68B87gaBMsnAxtqdmOiUpgSX
         XnAvKCwxtxQgTdBDWlHf6SkmpaS3wc06CUFz2SbN1DmmDUDHh16L/21NreuiMdmlNLiO
         M+mNXiI7wk/4yCqK59a/88lOmmQF+QCCAIl3g4N+nsjQxg4LW5p4kJ2QgMyW+TGcIF9j
         WxxagWvidCFM0xSAM/5alVabK3VH/PAfXv9iiZYCvlHvFbsm9Z39Fgj3NwnAL6oKVzyA
         NKTTWcVZ9GM8ywDhMcsBHQL6+otdp5oVOjaJLr0mlMx/sK83qlSw23cZJnGI3DSbCrbg
         fZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717690; x=1692309690;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4Z5WjiQYpjKKIHMmiUkMvLecKSdsud95ripsYJYW2c=;
        b=RX0yjpCIfT+KjCBW8q0mX3yEmDeetF6305xcprrege3QbTw4z2xbc6h7T8jgnQuYAx
         zMokb4OkXs5yRPXFdSwHwcQbQG0AIONIR/+SLlLI/DxEKsipTZb5BmRfVRyPBpDiRvdE
         5jWGgxSAEH5OQP2EJJ2fdv4TXKR2V5vYku4Pj6Z5kitGGuAWTZt2zhOSJbLQGVA9i5zq
         VUbzCXd5vS1qxY4xGSL+VIxBh1J8NQXaN+VwfflNgXm2GsLsLEv8ivirgmnwG/qaJSp8
         e4fdJAZGLvA6uabtnlEQqSPOw1/xQXeBLbsmcMtxG6lY2Onm0QUdVqHy9ivEHF3URQUz
         rEEw==
X-Gm-Message-State: ABy/qLZ/A8zeZW3QqJSRYX7Ij99gzLg4pTIw7gaCXz4GQ3FXToghfDZz
        4wvxAIM+cQo9OVrda9f8qNpg
X-Google-Smtp-Source: APBJJlER8N9WfHQ6ncGSyNkwD8mvrvpnlHeOqVt86lvZVSCe8wYjB7PdwEBMyjUEvGsdm8uKxWw9rg==
X-Received: by 2002:a0c:f54e:0:b0:636:277f:4165 with SMTP id p14-20020a0cf54e000000b00636277f4165mr349296qvm.21.1689717690268;
        Tue, 18 Jul 2023 15:01:30 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id s12-20020a0ce30c000000b0062ffcda34c6sm1005353qvl.137.2023.07.18.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:29 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:29 -0400
Message-ID: <ee7408412dd3e1725ae9ef0eeb26e4a4.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 19/20] selinux: status: avoid implicit conversions  regarding enforcing status
References: <20230706132337.15924-19-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-19-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the type bool as parameter type in
> selinux_status_update_setenforce().  The related function
> enforcing_enabled() returns the type bool, while the struct
> selinux_kernel_status member enforcing uses an u32.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 2 +-
>  security/selinux/selinuxfs.c        | 7 ++++---
>  security/selinux/status.c           | 4 ++--
>  3 files changed, 7 insertions(+), 6 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
