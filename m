Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF53DCCA47A
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 01:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345369AbiFOBxv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 21:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbiFOBxu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 21:53:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944B14B1CC
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 18:53:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q15so13360625wrc.11
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 18:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zuurJxZcce+GoDsmp1XsGsqucLz8Pm2d/LbWYRwxasg=;
        b=Hk75TzxKOU+b4LJdwcRUJ4IfLV9WW0VYtYya1btgDzruS3jcFLy9dTRQcIp7DncVGz
         GxEHj33eh4N1GgAgd26Rs8hwr99dTS6/DxgKGHYHu6LVcB+/IQ9vDRqJUq0M6+vHdc8N
         Y9NEOrflVbbc0MhUSDowycMbhRKDv0oVjpXywOIS5+XAMDYv2mT4eZu+Ykgef6gfD1Hj
         rIdrT8frAu76Rv400YZeIHkkG370n8DXHXTqxP8Fw2qbwWuqGjX90lvZK5A90atalhCt
         HFYYNjCiQYpslG9M0VIbqtV0urX9jiGrPT/ca5e4VyeBvX5xehCEDjVY+mwQZa6Nki87
         qyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zuurJxZcce+GoDsmp1XsGsqucLz8Pm2d/LbWYRwxasg=;
        b=Sftq+joIkQ410jx9KbUh3Wjl/dSkr77j9PuEwFuObHY0SZjjCprCx/zoJoznv3PWzY
         EK+nQlSoFxCOwjZw3B3S67tF5zyDZf7SINLwU90PkvJKaMGPtFx6ZmPBkifezDfX7JJv
         Rfb14K9C4tMzUukIJc7dDU+gdnxPzAUzG5bBjGSo3aIGxkX1dLHYRILQ0SJrdaViHI2n
         IYnPhjp4fe1SnoIlYPH0pHAWTcMwvZ7qk9WesGVuXFpxFkH7w9/RWOAugXIGe4PRXrmg
         VQyswmMqfQOu8LpPAKpoJ0I+Me3BNm8gRQDMAmeE6cj6HxWhChmArUbJVivWJWvhHrC5
         GB1w==
X-Gm-Message-State: AJIora86Pmuu9yzAp9JosT+5Al0FLaZf/5gl+AMwQjgsYfO1F8UBAamt
        p48jPGRxY0boJrsZPiwB7RdMq8ot6l9MN5XmhZo4
X-Google-Smtp-Source: AGRyM1vRsOUPtdqjt1mrMHgiOilk/Nt9zj7WZR0tLboCsjgSZz0A/NS3Za/zmRV2TH9XT4dZvUjEqyid3O0bvErZd/c=
X-Received: by 2002:a5d:5272:0:b0:210:33b8:ac4a with SMTP id
 l18-20020a5d5272000000b0021033b8ac4amr7283282wrc.483.1655258028115; Tue, 14
 Jun 2022 18:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220614021449.39255-1-xiujianfeng@huawei.com>
In-Reply-To: <20220614021449.39255-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jun 2022 21:53:37 -0400
Message-ID: <CAHC9VhRQJ8F9xd0YbAut7a2n_8q8RpqHatE4R47uhcHebfrJBg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Add boundary check in put_entry()
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 13, 2022 at 10:16 PM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> Just like next_entry(), boundary check is necessary to prevent memory
> out-of-bound access.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/policydb.h | 2 ++
>  1 file changed, 2 insertions(+)

It's not as critical here as it is for next_entry(), but it's still
not a bad idea.  Merged into selinux/next.

-- 
paul-moore.com
