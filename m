Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57996C61D85
	for <selinux@archiver.kernel.org>; Tue, 21 Nov 2023 01:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjKUBaB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Nov 2023 20:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKUBaA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Nov 2023 20:30:00 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECFAD9
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 17:29:55 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db35caa1749so2968258276.2
        for <selinux@vger.kernel.org>; Mon, 20 Nov 2023 17:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700530195; x=1701134995; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rS0BMMKckAi9gAuC9R0G9PAO0Di0YgXL6I3vYQJss6Q=;
        b=JXFelcLCsas/uSAX4ra6UrLdpfV4xs/Axt9PUiYZc6GudNzc5SJh32QujRk+jRP6tv
         WUlKfEE5DWPeUOvibGBHnA2kpaeVrixbBY/bY8q+v5ho6097zNaLm1xgxtQ/QIeDtsTy
         xMBoJYXFFJMwhXf2RDEIrrU9We5GcvaAL1if9CZNEaFBlx3/pk9zt/KoNJ8evVe0XALR
         X546DL3nPifBKozJFcosfBcimwMU6zaE77qznGsdUBOrpYiSjGP5tQbV7VNM9OIcsENU
         dZjKuPjtvPX9oEF4J2kaRjpyJYR+13vJM5DySFiG1npsKHwnmSfnifs/xPwBpdtvBUmR
         l6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700530195; x=1701134995;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rS0BMMKckAi9gAuC9R0G9PAO0Di0YgXL6I3vYQJss6Q=;
        b=YzNSkU7vdk5fDgHUX/myBQYGHx6I6hkpg1wEQrSCjnJ2NO15Uhrifd7qaeLFqkXlcM
         ESMcRMasCl7VJfdJOGsILZWLuhgOy0uBmuYBSZmeNRM6kU3jBRWHzXV0sNhGe/fpUqCL
         JUPUAmmMJq/Xp+yANEqz4QhmTkdFQtOypcgSJ1/O54Hmtsh92uW0OHs0ovc+SD8Yoh9m
         JrwD/DRibp5lCeMQSHyDuBf0VSCddpqZWlZGwLQ1n2pGSLL/IJbq/7oQKWMkGTKasicS
         LGDtrjoqyN8MfENQJwELdY+AdgmKRNlZk7z9EWMVEflNgOcaUJ+X8EP6URBDjnS2iV4A
         8ydw==
X-Gm-Message-State: AOJu0YyT9JwRuH9fNeobU4hPaFl3kc7EDQhldxAMD8D2l+m9n87Kf8Oc
        o8PmQg+ofjoSz0xudsBCjY3wmupa+NRcZFYCyQ==
X-Google-Smtp-Source: AGHT+IEUlAAXbdocRsOfobaqg+XVpnOvxoARqD2h31TTg3eiJQGG0wLNFefIMUR9WJfM139RxXyOsg==
X-Received: by 2002:a25:870b:0:b0:db0:4239:cf6a with SMTP id a11-20020a25870b000000b00db04239cf6amr9040071ybl.12.1700530194821;
        Mon, 20 Nov 2023 17:29:54 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id rr7-20020a05620a678700b0076cc0a6e127sm3201227qkn.116.2023.11.20.17.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 17:29:54 -0800 (PST)
Date:   Mon, 20 Nov 2023 20:29:53 -0500
Message-ID: <a62f64edbee0ee155d42e8cb0b6446f2.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, omosnace@redhat.com
Subject: Re: [PATCH v5 1/3] selinux: refactor avtab_node comparisons
References: <20231103172953.24667-2-jsatterfield.linux@gmail.com>
In-Reply-To: <20231103172953.24667-2-jsatterfield.linux@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Nov  3, 2023 Jacob Satterfield <jsatterfield.linux@gmail.com> wrote:
> 
> In four separate functions within avtab, the same comparison logic is
> used. The only difference is how the result is handled or whether there
> is a unique specifier value to be checked for or used.
> 
> Extracting this functionality into the avtab_node_cmp() function unifies
> the comparison logic between searching and insertion and gets rid of
> duplicative code so that the implementation is easier to maintain.
> 
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c | 101 +++++++++++++++---------------------
>  1 file changed, 41 insertions(+), 60 deletions(-)

Looks good to me, merged into selinux/dev - thanks!

--
paul-moore.com
