Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCADC433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 03:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhLFDEJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 5 Dec 2021 22:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhLFDEJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 5 Dec 2021 22:04:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C1C061354
        for <selinux@vger.kernel.org>; Sun,  5 Dec 2021 19:00:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id e3so37079148edu.4
        for <selinux@vger.kernel.org>; Sun, 05 Dec 2021 19:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8XwGiTSdfjzsQMCJh72uWK8Wih1xLMBGRw/JJ9t7jo=;
        b=J2FiySOmo1p06R4yLl4Fbax8C6J2lDzrgmZGRp3XjAJlTH3nW6wwGdXKVvn2VxWC1p
         eoQO85zvY5NG6j/0CRCFEZTPoO8jyesyTmJ11gZwIO0UaXWIT/5b4frxNuFRKCUR/iwO
         /k7QP0KacB33uLJ1lM3utN2gpSIB7CJPOyM6oVsu3hALWZ+I+N7B04fr7w9cCRASZDlF
         wZeO7GHtr1Lj17LZ7lMVd7Wzx6P1r4061hPUENTz9PbtOXYbJXoXmZ3LDsZiP8CGXJ5+
         q9Fp+0kRUNrDNi76NRVvuUbx+ellf6oVMcNEIxj/AJPiyU9K61yFj9DyhYtnoAN3Nv5N
         Nw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8XwGiTSdfjzsQMCJh72uWK8Wih1xLMBGRw/JJ9t7jo=;
        b=Sp/8RoCU9X0JzdaDL6Vn/AsZkF5bKkZm5VuqaW6OIjWhQnEC3z0SHlFj0wO2tvGTOs
         P6djBMfr3SN2jzr/GXYvVwNU82vbiRhCHmRvKAY+tjQDHKh9CKAH4t4ulnDUcv+fTOSt
         DhYEQX4ix4MTMXr1dWGAXdg2jqfOIkQsmoEZsI1DAruAgoR2v6cwz29Ob7RbMQh7qU+a
         XdC4b2vm5xF+N1jmmltJhd9GOcrBAFvIyJTvn97bPiUwZdt2D4778g/vuFuqHAF+ytIp
         unG9uY/pinUotfrMMVPBKyTKIPcfQyrXc2vkP2Zo3ykcfVJbQ1M4ISHO/OzynZY4JaDK
         O3xg==
X-Gm-Message-State: AOAM530qL7eq6sr9zd0Zn4z68Dc4ZHCNvTZlBy6FGzaDzMUKAfbjavQ+
        vkrc2wveiAYVnYMYG5MgtOHuo11Jk3+ujQUltYaL
X-Google-Smtp-Source: ABdhPJyhQR4tvE1MCQcoLhazqK5yvby/xMf1+slbVJzbD9Ck/Wk4nPvy3/5kTEeM3PBnJTA2Prpfj1+fwmw0/TJRYag=
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr50606773edc.103.1638759639626;
 Sun, 05 Dec 2021 19:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20211202073533.104072-1-xiujianfeng@huawei.com>
In-Reply-To: <20211202073533.104072-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 22:00:28 -0500
Message-ID: <CAHC9VhQZx1F9TUbEYOKxK3mEAg8n5bCJZ7RuZHh0jEhwNg7eig@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Use struct_size() helper in kmalloc()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 2, 2021 at 2:34 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Make use of struct_size() helper instead of an open-coded calculation.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/sidtab.c | 2 +-
>  security/selinux/xfrm.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next, thank you.

-- 
paul moore
www.paul-moore.com
