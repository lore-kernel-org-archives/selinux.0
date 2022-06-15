Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6C4C43334
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 10:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbiFOKEt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343877AbiFOKEr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 06:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 720253BF8D
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655287485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KvqCVAQytjRC5pnGMZtj//UN+D95bGj8Ywb9fXgge+Q=;
        b=N8RQjR22V7tddQx2XE8MiMGkjUmUay1wF6BME5Pffisb2J6vPAS22tVqKgYSarC50Fty73
        UuF3Due/TDYLso8PFkCkkJIJpkkJoJ7+w8Dm8vqQevKvSP10Nb/MGLK6oW4iCUEjQ6XpLP
        DnjVq2H1Zt3Nab0ehdDkXJfHxbnzBDo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-BBgwxOVWMNSvNjBg6CyqCA-1; Wed, 15 Jun 2022 06:04:44 -0400
X-MC-Unique: BBgwxOVWMNSvNjBg6CyqCA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-2dc7bdd666fso48522017b3.7
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 03:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvqCVAQytjRC5pnGMZtj//UN+D95bGj8Ywb9fXgge+Q=;
        b=Y1jTe1qWE3fqwN7H7WLwowSmyUojGZ7AvNafcAgU7raFnX5mec1QeVqWbgZcBixkbf
         d9N47IBtUQB+Dsdt5tBr357ZIW7HtPom3/R6srlEZLKpnQbSnn/fcs3fiGAVrtwEXkAp
         ClmcMMfZWuxGvF68xkzVMR0LtQ0dV+C/Ur3j/ZAWLBWlFGCJuWOVvc4oid2GsC9gKdR0
         ZtB22hAFfTTXbAGIlfvcvWLyVXYDUj/pF13yRlB0YDTEwVxeYQ3gxitgdkvs9NICZIm/
         Cfm+TDIjGtDNKmUHXwga7EhYTyLAAf5shplKYditlR0XCIrtD62ARPgT6eqTOg+h/7Ny
         z21g==
X-Gm-Message-State: AJIora+Z5uumyf1l09bWgzhKcsoEXxvsq1Unp2/fJmk1vc+XimuiYFlC
        Il3xhqgnzhlFQrt267sfORv0M//+v+jyyHQeEKyElVT9gEaBgB/FM9sYnP4Oob84/33KGHSyq9T
        iUA7Oqg7YE1ezuhYa/tHLu4vBkttdZ6uLtg==
X-Received: by 2002:a25:ce83:0:b0:664:6360:41ae with SMTP id x125-20020a25ce83000000b00664636041aemr9332105ybe.336.1655287483806;
        Wed, 15 Jun 2022 03:04:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sog9oD2BqIWvP3CAFG43nkBsaYyHyvoIWuWX1RsymVn4h6TgCzec2lpGYRhIMdWb9bnF1C+G0tHgDtlISsc/M=
X-Received: by 2002:a25:ce83:0:b0:664:6360:41ae with SMTP id
 x125-20020a25ce83000000b00664636041aemr9332079ybe.336.1655287483476; Wed, 15
 Jun 2022 03:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220614132333.143042-1-xiujianfeng@huawei.com> <CAHC9VhQdfPBn4kbY0xRPaCvNBJJGdQQe_90A4Hhdsj6gVr6pAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQdfPBn4kbY0xRPaCvNBJJGdQQe_90A4Hhdsj6gVr6pAQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 15 Jun 2022 12:04:32 +0200
Message-ID: <CAFqZXNswaUiHNZA65GCsgB7GNLm6tc2OFXsQrTWxBTfWviQ8+g@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_policy
To:     Paul Moore <paul@paul-moore.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Austin Kim <austin.kim@lge.com>, michalorzel.eng@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 15, 2022 at 4:03 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jun 14, 2022 at 9:25 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> >
> > In this function, it directly returns the result of __security_read_policy
> > without freeing the allocated memory in *data, cause memory leak issue,
> > so free the memory if __security_read_policy failed.
> >
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > ---
> >  security/selinux/ss/services.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
>
> This is another case where there is not actually a memory leak as the
> only caller of security_read_policy() is sel_open_policy() which will
> free the buffer it passes to security_read_policy() on error.
>
> If you want you could add a comment to security_read_policy()
> indicating that the caller is responsible for freeing the memory.

Can we please not have two almost identical functions with different
cleanup conventions? Please let's either make both functions guarantee
cleanup on error or neither of them (adapting the caller(s) and
comments accordingly).

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

