Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429FC433EF
	for <selinux@archiver.kernel.org>; Fri, 25 Mar 2022 14:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358449AbiCYOqS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245230AbiCYOqS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Mar 2022 10:46:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64373554BC
        for <selinux@vger.kernel.org>; Fri, 25 Mar 2022 07:44:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so15836764ejb.4
        for <selinux@vger.kernel.org>; Fri, 25 Mar 2022 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urG7wJTk7cfW0/ofN6lIZchUSJr5GfrgF/MGHRkbzfo=;
        b=0uRg1QezADBC/ILzIwNBoyspyE+c44iE0EV74wopWYwfcdaPLR0/iOlOqkaJD04K4m
         nJtf5lzxRfppUzB2TFGhB0T/LLpP1vPtgzoCPIboXORxHHDSaKop2nuyROd4PIkctcO3
         zrMS7kndvdEf+wg4lAsQ6NzHWdnzbk+X5DHQWuqQV10/4hgymFy2xthTzcsf5ipTTyyF
         qQ+kG14vRSkBK9VzKb5mdIzU8SiwKFpWBGZD7Kucer6GHbbYWaCBxAnLwJBzph+eIWbF
         hYsvNoNP617PWdyyv5a3ucJlptVhA7PJ8Sz5nZ0t0e81jkgL0KH88AOd+u8xVbtNpb86
         ry+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urG7wJTk7cfW0/ofN6lIZchUSJr5GfrgF/MGHRkbzfo=;
        b=Stv87SbsEOeLmMyTeteV9nvKmCMZPdyxe2+FlxSV8Clned3lc5Vu8Z+5LZ1+rEWx3z
         zLMvsKTua1HmGrw+j1Rtd5/dmi6AJlj5RbvG+2f6sO+tyfoZ1PFd6QQPtvJFhxgQfatx
         Jc8jMnVbDldyb5Xb8YLDH5zKGNAAmjkEvJf5TGsZBTzWYTKksO9hCpT5A8XkMc/kDN2z
         6uUmFwpa5jiYYcmc7Wx4wuAUIMj9uHALsYO69T9GXdsQBwi0WWv/DywZG/MGNK4rQBuG
         9uj+u/0TxXIqycwDo8kXiLHDd/B+hHMEwNCNhIOA1wB4tqHG6R1MeMhBy70LH+KjvizL
         agyw==
X-Gm-Message-State: AOAM530Ui7bffkWR599i8fBE+aZvoaftGpQR1h4cdgL+kPErTcrR2puu
        /B9oH7l5bjBz7jvLeeIgm42uFnU1c2+11pY/YkHE
X-Google-Smtp-Source: ABdhPJwgb34PQtxZiwkjD2cnEoZdlxAKPwCbK/YF6t1Jz/L6Ghi/seTC93M+pUkxGnTVXRpSNFIKVtrTIKR6bm39X4w=
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id
 dr2-20020a170907720200b006df83a967d2mr11765091ejc.327.1648219481881; Fri, 25
 Mar 2022 07:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211117015806.2192263-2-dvander@google.com> <CISWB5OO4TSD.1YIUVDSVYSIF0@otso>
In-Reply-To: <CISWB5OO4TSD.1YIUVDSVYSIF0@otso>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Mar 2022 10:44:31 -0400
Message-ID: <CAHC9VhRs95Be484hqDm8SW=dyYtziHSwo=7Eb5kwYxT1HxG7_Q@mail.gmail.com>
Subject: Re: [PATCH v19 1/4] Add flags option to get xattr method paired to __vfs_getxattr
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     dvander@google.com, Luca.Boccassi@microsoft.com,
        darrick.wong@oracle.com, dsterba@suse.com, hubcap@omnibond.com,
        jack@suse.cz, jlayton@kernel.org, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, paulmoore@microsoft.com,
        salyzyn@android.com, sds@tycho.nsa.gov, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 25, 2022 at 7:02 AM Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Hi David,
>
> this patch doesn't compile with CONFIG_SECURITY=n:
>
> ./include/linux/security.h: In function 'security_inode_need_killpriv':
> ./include/linux/security.h:893:40: error: passing argument 1 of 'cap_inode_need_killpriv' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   893 |         return cap_inode_need_killpriv(dentry);
>       |                                        ^~~~~~
>       |                                        |
>       |                                        struct dentry *
> ./include/linux/security.h:153:52: note: expected 'struct user_namespace *' but argument is of type 'struct dentry *'
>   153 | int cap_inode_need_killpriv(struct user_namespace *mnt_userns,
>       |                             ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
>
> I applied the patch on linux-next tag next-20220318, but the relevant part
> doesn't seem to have changed lately.

I believe David (and Google) have abandoned this patchset in favor of
another approach.  I'm possibly going to recycle some of the ideas in
this patchset for some future work, but the details are still TBD.

-- 
paul-moore.com
