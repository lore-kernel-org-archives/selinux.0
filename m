Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F89EC35280
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546CE216FD
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MHcfvujW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgEATzJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 15:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgEATzJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 15:55:09 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEB2C061A0E
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 12:55:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id f12so8074733edn.12
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vd/NTDk45CB/fePqWXBGsmO9Bn5XFylQDEfLobAzR8U=;
        b=MHcfvujWPP0pZkfx1BjaIjxDsUHYxnm+2SOsoecV2W9XTF4+TQsRhCgDL8Xvjw7VAb
         YGdP/MC77O10pa91UP/c6c+vXCfKrKEDUM7tEdZwaDo9vzO4eoci+38a2QNrlfVPdU8m
         HsXaLjqCybKIppphjzhNNX+GGzSoyiIRRyjxNe0wJUWFjfAX9IkB7VYk4so5WYJHK9V9
         /PBgfuJTjexnGBUtx3HZ65s1EZHmxkqjtU3vNOw1lu8ahxSWmtWzz/qkogv2Y2yF6Z+I
         pAL5RaVLk6onVVUL3s206o0hvTmhZ56elUbpvrSdkixW0+Mv0IrWp+Oc+WZ7+Jg0+smm
         4L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vd/NTDk45CB/fePqWXBGsmO9Bn5XFylQDEfLobAzR8U=;
        b=gYRYvCqjE2MgHvnv9dtuLHyjoWwqJrPC2a0aqIn4ngczXUIDscfS9druUAzLUsDcou
         U50LE3gkglygdB79YP97TZIxAh/7xSlJsHXzqiuJA2e4HsYTcNdpQ/YGDX3xZt48lrx0
         liXiM3KvqQuisXaDEV4FdDhXG2c4lJiGPmm6wzqfUyX6mqbGXECpzo9cOp4SFqbDyHzY
         Jwv+W4vMR8qTzhBnrvjWVbR9Zb0Ovp6Rc5WrmfJE/Vu7ro5KF6gOGI97IaxfdFLV2kE7
         dDZYw8IO7jkIXDvT1IrLBx/gLX/QLD9R44tuu/cjqOy/W4wYIARD9e/mYTuWFbbpcZDO
         g4xA==
X-Gm-Message-State: AGi0PubDrlk3kJsH9Q/ATCIUdcKuh4pneSljqRuSJo8iKgJQ5XwW4+cB
        iXQePmpii0PTu8Am3jBwBbM08mCFHFSZQ1GJnA1M
X-Google-Smtp-Source: APiQypLn7W1R7xYVvSzl2/q9NQc0qIuXpz2ML3a6e//ZLcQp29/ArK0d2NQHLCp0a0N5Q0Su7JIi5vTJXOpyJ9+yalw=
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr4892967edt.164.1588362906610;
 Fri, 01 May 2020 12:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200501195111.3335258-1-omosnace@redhat.com>
In-Reply-To: <20200501195111.3335258-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 15:54:55 -0400
Message-ID: <CAHC9VhT7EDa_HJpeq476G=euHz3=p5b4u2KONeMEAMef=ASy8A@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix return value on error in policydb_read()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 1, 2020 at 3:51 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The value of rc is still zero from the last assignment when the error
> path is taken. Fix it by setting it to -ENOMEM before the
> hashtab_create() call.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: e67b2ec9f617 ("selinux: store role transitions in a hash table")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 1 +
>  1 file changed, 1 insertion(+)

Here I was just about to reply to your other patches that patch 2/4
looked fine to me but I was going to hold off on applying it until
this patch came through :)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
