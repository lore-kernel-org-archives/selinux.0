Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C47C0015E
	for <selinux@archiver.kernel.org>; Fri,  4 Aug 2023 02:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjHDCUn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 22:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjHDCUY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 22:20:24 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3FB3AA4
        for <selinux@vger.kernel.org>; Thu,  3 Aug 2023 19:20:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63cf69f3c22so10157776d6.3
        for <selinux@vger.kernel.org>; Thu, 03 Aug 2023 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115622; x=1691720422;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DL7QqO7gdzDeLZ4Lt5CqIM0zO9j+hCqUuNJLaJnYEts=;
        b=YO6AR1bylUT5ii8VCBNh9R0U4hbO7k4kTFszkplDtOGaEUPqA9/wpEt9bK3SlDEw9Q
         DhzcmaWXYWqNuMlAD22xpOR7fEkvyspILNenTSW1NHgMSAKDMWSWnK9nbyEDJntCR/hL
         GFKR7kSjx38aS3Ulw7ODbw9f1GgujM5RNMh8qiPCWhn9NxSfDXmhtoEMxtcBtHL1mkZz
         aQMk+Vpd+n9bPQhaoH/kUe0HyDRtgYcXzgVEQyfdAY6d2qKTO/XwVj2oyBOijJrKrHOK
         D8dkUjOz/iJtRKNL5LGnp7Ur4e1Xv+F4eyA6uqG8ATpZnBOfRxty2kExP7Lf240FKb6M
         mPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115622; x=1691720422;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DL7QqO7gdzDeLZ4Lt5CqIM0zO9j+hCqUuNJLaJnYEts=;
        b=KFRBdc6SdaqPZwAHIfAXRdwcyTizZrBUhM+ALdt45eyzYQkz7z00mik1fnSBdEjFkm
         9MArY477fRDmGdKyEN63Gi2tDDKKOn3gMnOnL1EikLpOG4qOOyJZ1fvGcOUb0agIUiLP
         A+jKvI0YszVuoUHY6OCwI/Cf+FhSFVKTGvgv4P0ySbz6VMl5uN4PN96vvvnWHKYvmXGZ
         eev4ER+lNvETraynrvUXhQkoMmmgwxajLpz7X64NMqJYl5h5H5AFbG9uZ7D2TS64JTxs
         NVmlF0CJy4G+PYpkfAdg7GbWqnNm1JrV0/c/KLNuFx+U2jeywh/YQi/qhJ+TZY6a7L+T
         c3Dw==
X-Gm-Message-State: AOJu0YxP5PeJ9mS889FHiIPqQqUeeLZlQX4OPhVuaToaNWRfLu7v8+BL
        l7pWBlP3mJqsCIqQ+v5nAjKSWCckHc0YxizRLU9M
X-Google-Smtp-Source: AGHT+IHgyO6fkDjwMzmm5bVGuOPfS6kqod4OR8dR2047XqNcjl4XCrQSIlI7QK2pPaj94P9T+xRxQQ==
X-Received: by 2002:a0c:f40e:0:b0:626:1163:b446 with SMTP id h14-20020a0cf40e000000b006261163b446mr426720qvl.4.1691115621940;
        Thu, 03 Aug 2023 19:20:21 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a038700b00767db6f47bbsm331331qkm.73.2023.08.03.19.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:21 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:21 -0400
Message-ID: <80ff0d20d4d796ecf57bb5f08d3aaf7d.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] selinux: avoid implicit conversions in services  code
References: <20230728155501.39632-5-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-5-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
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
> Use the type identical to the source for local variables.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/include/security.h |  4 ++--
>  security/selinux/selinuxfs.c        |  7 ++++---
>  security/selinux/ss/services.c      | 23 ++++++++++++-----------
>  3 files changed, 18 insertions(+), 16 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
