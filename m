Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBDAEE4992
	for <selinux@archiver.kernel.org>; Fri, 18 Aug 2023 20:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379932AbjHRUNS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379983AbjHRUNF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Aug 2023 16:13:05 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB123C2D
        for <selinux@vger.kernel.org>; Fri, 18 Aug 2023 13:13:03 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-488534b62e4so464036e0c.0
        for <selinux@vger.kernel.org>; Fri, 18 Aug 2023 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692389582; x=1692994382;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1qfw+EnVrd9gLJH5+oijG+oLHdKZ78bTzt/OSCrmLYY=;
        b=Eglv2DBwVkm8H9yQm0BywCzrlNn4OWRV/c9gXI92XHYtDcsNYhhkO8KbRxctrhlFUx
         +M9mKHky05xRfUzXBS4LJitqvf5TrV1xHZprQt/gdSwiO6N/5mWuMpgINbgLftf6F8pN
         nH4eXH+dnM45zHMa0UU1X/QPl9biGlgwRi6uhihDQYKrIMSrN6VqUctCdqCePSlYHOMF
         fn/7fqOhylA4NemjT02GK3JpJ5CETYNUpd9b7xaCZ/+r/1C8GuXyQmUYS01LEwembz6N
         YGsiZ/3WW48GnkCDFdH7ijNDWZdGTQdluSeEjN93NhxxyrVYOqRRhlu7hE4KncKNYJnR
         g/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692389582; x=1692994382;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qfw+EnVrd9gLJH5+oijG+oLHdKZ78bTzt/OSCrmLYY=;
        b=XJhn4GThflpTFqEVi3Yc8G/BT3auSgITHf7mZ3FWTW6LeDcLsXOYME2GDEn7/eTcq7
         sjw8n1XbA3/olldxF+ogBuCAqM5QgwkC2I4JwLwrZhW6XxE7HHLeVrTgHEz4HRuoJ+LC
         FRJa3VdC3SMeTADpWviRXhoiDpdhBrRAjzq5KUDNPfppnr4U1fD5Fwtav9lqyQzYXqhw
         VVHukV6LVgHsxYCh0AddIuka8mnb1mq9q53Hpg5LkBpZW0JkInw7aJ6hy/SvXKIm++ip
         qZudBciRfq8HnB2yv6x10nSFGuY/vBHLC3jecPv+tbEvnPsQ7ANFky7SnWoI/mgOUtZQ
         ILKw==
X-Gm-Message-State: AOJu0Yzl1FbT2FIyj1KNfDuCFD8rJ34hq5X1tHRmEzgh9g1GPkuf2PjX
        uP/BhadZ+u6b/lh9aMa2FuZB
X-Google-Smtp-Source: AGHT+IFKykS3b/PjBdqpdQtpRGcS1hUj6y0jGtEVb5O2ZGMXjgxF7qbLv9Tstq8Wl7OE12zfQp9ZLQ==
X-Received: by 2002:a1f:5e91:0:b0:48a:d98:23f1 with SMTP id s139-20020a1f5e91000000b0048a0d9823f1mr379610vkb.1.1692389582663;
        Fri, 18 Aug 2023 13:13:02 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cf44b000000b0063c71b62239sm489940qvm.42.2023.08.18.13.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 13:13:02 -0700 (PDT)
Date:   Fri, 18 Aug 2023 16:13:01 -0400
Message-ID: <b123a7a8c87915d56537f5fe0690e4c3.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: set next pointer before attaching to list
References: <20230818153358.179248-1-cgzones@googlemail.com>
In-Reply-To: <20230818153358.179248-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug 18, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Set the next pointer in filename_trans_read_helper() before attaching
> the new node under construction to the list, otherwise garbage would be
> dereferenced on subsequent failure during cleanup in the out goto label.
> 
> Fixes: 430059024389 ("selinux: implement new format of filename transitions")
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Christian, nice catch!

I'm going to merge this into selinux/stable-6.5 with a stable tag, and
assuming all goes well with the automated testing I'll send this up to
Linus early next week.

--
paul-moore.com
