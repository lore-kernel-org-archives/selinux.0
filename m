Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64F6CCA481
	for <selinux@archiver.kernel.org>; Mon, 13 Jun 2022 20:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351445AbiFMU74 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351971AbiFMU6q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jun 2022 16:58:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED320167E8
        for <selinux@vger.kernel.org>; Mon, 13 Jun 2022 13:34:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k19so8510894wrd.8
        for <selinux@vger.kernel.org>; Mon, 13 Jun 2022 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F++4mxvxKCq3D0MOi1hm7r02V15ZXV/REZlzwvy9ouk=;
        b=j2adBRuldeFOlyGNeZXecupRfS1od6Xh2itNTGnXKvNwuvuj0sTo4+tBpwbOoQUjoZ
         Xw5/Y6VRboaE9ShCfnwDIZnZGzNe0UBnP7p85yggpZ996Zj6EDVLRZ/MwJuINbvAcmJZ
         wKNXfVZM/+zjJLD17EzOm6Q3qZ6slsFQMs35GciHNu/KM+rORkItSwa0C+04oGDuRuDV
         7xFjk4xk8JwQA8P3q+5YrQmQWZN6mHNP/xv/JzGOi96zHLEWBAINtzy31gOteVHeGA58
         eWgmH0arr8cGZulxXYnGAPuynMx0dJM6F5D11HkGOHyFsF4lIGR3zqFmLjhGeoCY6JW7
         0DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F++4mxvxKCq3D0MOi1hm7r02V15ZXV/REZlzwvy9ouk=;
        b=XB30avInQ/y2jCvPdT+1CNcmh272NONzsR9+HgIPaCrSUAnKWNz0AneQywM1xc6iLK
         247hqnuWmDriMiMUAVMh7Y8D35OKRfpYseUcjW3SHBj8uEogR/9BPEFIJxOjnDV6Q5xW
         nLuo3ssD7DsmrrUPJ/sFcliWu/RqaboyZcmueXZ6DzJJ59ZemFYDCmBv0pwoQOsohIH3
         xxv6ATPMORPRN2iYQCKQ8EE3PUnR8aKZgn6esLIXKbm2ziMNh9RnoHs6XQoueut1jKdE
         c4wnK/XYvVPPzJkEwS1Lv6aV8es2oXPbW58o2f16divOJg1hpCApITKPz9c4DJKg5Gry
         Vm2Q==
X-Gm-Message-State: AJIora/krIGYtn6A/bxXK82ghRohIG6aT3XbM++AYvIUoXTvjk8d3aks
        Qo3awLmwAhGYKEYf6rPh8WKqpt4tcHU2YsKJY1hM
X-Google-Smtp-Source: AGRyM1vYniplidzOuY5TAIYbimsWA/grGb4GRxaY2HWhql3MwuRYoLgOrYQtewKpRFU1AZ1P3cpbpdbefd+744wWgbU=
X-Received: by 2002:adf:fd84:0:b0:216:1595:82d3 with SMTP id
 d4-20020adffd84000000b00216159582d3mr1427711wrr.239.1655152461446; Mon, 13
 Jun 2022 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220613135953.135998-1-xiujianfeng@huawei.com>
In-Reply-To: <20220613135953.135998-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Jun 2022 16:34:10 -0400
Message-ID: <CAHC9VhR0-814-YsC3ugTsCzL1be37tyxZHTs7Dq2mY+iC8pjgA@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_state_kernel
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        cgzones@googlemail.com, omosnace@redhat.com,
        michalorzel.eng@gmail.com, austin.kim@lge.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 13, 2022 at 10:01 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> In this function, it directly returns the result of __security_read_policy
> without freeing the allocated memory in *data, cause memory leak issue,
> so free the memory if __security_read_policy failed.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/services.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks.

-- 
paul-moore.com
