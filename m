Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B72BE8FDB8
	for <selinux@archiver.kernel.org>; Tue,  3 Oct 2023 21:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjJCVHN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjJCVHM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Oct 2023 17:07:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CD583
        for <selinux@vger.kernel.org>; Tue,  3 Oct 2023 14:07:06 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7742da399a2so101624385a.0
        for <selinux@vger.kernel.org>; Tue, 03 Oct 2023 14:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696367225; x=1696972025; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evQDzfAhsvEznxB9DGT0/RC2AhsNetfoH4qR7Qm9lGQ=;
        b=a+qLYGc6X2lqnlK4asaYNrvFtP4yRf4YR81gwVrXGKvbnRGghjxPQOWnoOjAU9Atbk
         oxdFnTEd0Gl7ApSFMO6SZkAaCAqwf72DQzpBoBEn7TzbOCuIGnIbdqv7t9vYEJBUaw/c
         qNq60tdZsMW3saLevaZG+TShH2nY8NG8UO4zwej48TyuVbqog1IVWlo4+giMWTwoFstD
         lfnwHDtFvcUtxPIUzvzG5Tsg2etHd0Hw1n/B273Oblwyk8VTpZ835vVchW+BvvGQ7tfx
         lQ1FUHUKjxTBJombr6UdGgPOAA9KLUqwEzkwKtcsSSR6lhqvspYh655bt3kgSDPmfuuf
         A+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367225; x=1696972025;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evQDzfAhsvEznxB9DGT0/RC2AhsNetfoH4qR7Qm9lGQ=;
        b=XC4Cv0DOqHJLFag+hXlt2ICNjEwvNmK/skMC93NEE6VProV1YhvdY8WygF8Ni/Ntn0
         5hG1toFcasYnIsAqbykegCDX4EUaZ6lHoiVyDwKpL3KZY0jzxPqZPFp3nuuCPSHiP7zB
         Ye2tPkwbfBk4Af4gq6Vji7z/9cGWddkqkhdZEIJAhJg9Z2o3gO+LFCn/fDZGTpNJ5n8X
         p8NruQtEoV9g+RS24I7d0brtFVhwUa9y13ZMNXPlIXjGXV/l+zDuLNzT7dW1+fTUV1Ra
         Ej50t8/yMlw0a3QPLKqvD4sTA9VTwg4OT1a9mkEgZlsANMfByvw3Sy6B8rHoeje7wXz9
         gmtQ==
X-Gm-Message-State: AOJu0Yxp6EJLkMTE0Q73/9x/MPvc/uHaNWyepSrEBI5Arz3/s825ek2k
        xdhsJy5D4wnP9u4zs90uRQgj2cGyuizii87+hA==
X-Google-Smtp-Source: AGHT+IFzv4EmiLz784+Ng0qc9IwcUejeLsJK6QutasLRuKIG/13U8udRZjCO1rR/cVRGXmzpPJpp7Q==
X-Received: by 2002:a05:620a:4413:b0:76f:1272:2aa8 with SMTP id v19-20020a05620a441300b0076f12722aa8mr795922qkp.6.1696367225507;
        Tue, 03 Oct 2023 14:07:05 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id oo14-20020a05620a530e00b0076f21383b6csm762361qkn.112.2023.10.03.14.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:07:04 -0700 (PDT)
Date:   Tue, 03 Oct 2023 17:07:04 -0400
Message-ID: <54358efcbc1dc1509c41028389eb3885.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Subject: Re: [PATCH 1/4] selinux: simplify avtab_insert_node() prototype
References: <20230929195617.65120-2-jsatterfield.linux@gmail.com>
In-Reply-To: <20230929195617.65120-2-jsatterfield.linux@gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sep 29, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> __hashtab_insert() in hashtab.h has a cleaner interface that allows the
> caller to specify the chain node location that the new node is being
> inserted into so that it can update the node that currently occupies it.
> 
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

Merged into selinux/next, thanks!

--
paul-moore.com
