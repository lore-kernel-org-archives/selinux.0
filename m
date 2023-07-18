Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0396DC0015E
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGRWBl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjGRWBX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9251BC0
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:20 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-403a3df88a8so44291661cf.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717680; x=1692309680;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OvXAgibfz88Twe5DWtMIjMHTvNVQ0cptuu2/ShBaOKI=;
        b=RCy1kHFz1HpIt7I3hzeQODGal8NT1mvWLYncvmcQ1OUfSIZoSKY7hbwKr53DRYCGXQ
         ICuba3XLSFEFRUAxcvR3npblEEDAWGMRcNyFpebi+Z5V98PBKZbl5C/bxUoDhlRsKR0/
         zU1SpZFlOZ4uDpcuhLGerIwtgkeO9YD1WPwQgpuqzDEuZIHf+quegRXu6pP6eNHNmO4o
         kLRDT0KmUprRi4THUxuPfgYWQ2TZzQ+rjRJFWkDo29btXidYj2qceeDutj0xezXJWd11
         AQzauI+Rsnyb5SWe1gpOc+nNtfziidmqdQfmo7Ebq/2n6X5ogZ4OilyAlOHpU63WgJlP
         3Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717680; x=1692309680;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvXAgibfz88Twe5DWtMIjMHTvNVQ0cptuu2/ShBaOKI=;
        b=B0viJM6PaNSzdSGDWnY+gDT/nyByqXMabICham8p2swlk5OmdeeW7kJwZnpSJYab00
         dSkJMfW2GwWPs73gfelY5P3owHYTTHl5+qdTcMuac9zSARo7o/nhSrDRdUzqzP+LdN8I
         pPoPm37qdeJGlbLtBU32HiFE13aCyZCHMxSmcdCAI08JZt1BmmXzZy4jwqi1SfGQ7UDQ
         NrN7B1MPF2pVAZYIZ4uUW4Ggyx6oCfaqUanq2H6jix8GtrIHOc6g8IenyQ8JpW2W5V2X
         ZKlSC2SupMP2CZi7AKajc667LqVXOBNBVdveHtjEQaDuUeEY1FrwpWoiBYZAJMuaKJiJ
         O+1g==
X-Gm-Message-State: ABy/qLZrvhlEVtVi76i9A9YFuUhqPILxcBE129xuUtzR7Z5NmjVOecV1
        vEMRZY02U5YWMXLzp9lr8Daw
X-Google-Smtp-Source: APBJJlEszandnHR1XyofohFdDXATQUDj1sibeWyzqvd4qTxdjOsBAfRtdarqouKU8XiKZ9en2sldQA==
X-Received: by 2002:ac8:7f07:0:b0:403:b395:33e3 with SMTP id f7-20020ac87f07000000b00403b39533e3mr22252178qtk.52.1689717679905;
        Tue, 18 Jul 2023 15:01:19 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z7-20020ac87107000000b003e3918f350dsm922896qto.25.2023.07.18.15.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:19 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:18 -0400
Message-ID: <1111b348800451acbf5f5c13db05abef.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 8/20] selinux: services: avoid implicit conversions
References: <20230706132337.15924-8-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-8-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use u32 as the output parameter type in security_get_classes() and
> security_get_permissions(), based on the type of the symtab nprim
> member.
> 
> Declare the read-only class string parameter of
> security_get_permissions() const.
> 
> Avoid several implicit conversions by using the identical type for the
> destination.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h |  4 ++--
>  security/selinux/selinuxfs.c        |  7 ++++---
>  security/selinux/ss/services.c      | 22 +++++++++-------------
>  3 files changed, 15 insertions(+), 18 deletions(-)

More loop iterators ...

--
paul-moore.com
