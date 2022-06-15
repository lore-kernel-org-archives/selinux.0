Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358FDC43334
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 02:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiFOCDL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiFOCDL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 22:03:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9AD3123D
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 19:03:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c21so13448041wrb.1
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 19:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipK2xVBLHPOftN34BUGWDsuGecY3n8XAM7hkfiv9VF4=;
        b=Zen+bt9CQG1jdU1YiXYkeHp9jlh/y0vhgUUgRbxEZorTRPzLh8JTV5pMycsNGdDP0t
         G68vwkv78mv6nAbqqd/4LrH2Rj0/SQwOT85GtDJ0x8VDpQER+SL2Rk59c0guy3EPYyhN
         IVeSqTTw/+zH4ykdL7br+qCy0o28w0gxq0L7NS30DUgUw+r3svCpKu9bErunvw8vzQ7N
         esxy7hKjzLZ+a+bSkOB+oBx5HEV0Upg9iog+2CoxTxAmNeGWWdlvW80OigRUPXn1AFX8
         eFPOqzBZkoIckGZ9lTPDw2txUnxiuSdEp5poFo61UnLJmpZKZTFHKr5jdYFo5d9wJUk5
         AgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipK2xVBLHPOftN34BUGWDsuGecY3n8XAM7hkfiv9VF4=;
        b=DERHmVo2Pyx23wC/g5Bih8PfN0Wm5vxigCsKDjgXKGwXK6/nTIt0UYUbjbDCmMRua8
         U55kSxIAUuzY9b+onHMmWFXjkSVg4tCUghpk+w3GK3HPCUGBKGC/mn5852kGoPkK9+/b
         +eQBzKYtUOMpTmGPbWeLnxY4dnP7ch3c2Az9ibxLaGTf85DAG0562U4X2HsqX8fucLY7
         1Gco932Q5CVfWDF9vpEfkKom9dUNWnyFPLDViMiNP7WgvSuX9aaCMW5f39FWRiFnLrgw
         FXo9qmGmkG/cAaqU3K3ZcAF4QRjCzd99VwhNwsSaSkPzaL+QPFk5laPynN3Ds/3CEwk8
         HlZg==
X-Gm-Message-State: AJIora/QcvYC9CDQEJMaDckdfcG7RZmwD2Ep+alOxwL0845YU4amzOv3
        jxUKtIcrSCI/T7JiSdEe9eJjM7xVRc33ZYLhbQdB
X-Google-Smtp-Source: AGRyM1uENCeZZiPlJ60c8bFL+8XMUT4yEx1bjPhq9c8jfwIxvy/DROo9GfXYu0M9IaIA2YUcX+QZ9K7MdkLEOuwYH0Y=
X-Received: by 2002:a5d:6348:0:b0:213:3a8e:e75d with SMTP id
 b8-20020a5d6348000000b002133a8ee75dmr7142240wrw.55.1655258588850; Tue, 14 Jun
 2022 19:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220614132333.143042-1-xiujianfeng@huawei.com>
In-Reply-To: <20220614132333.143042-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jun 2022 22:02:58 -0400
Message-ID: <CAHC9VhQdfPBn4kbY0xRPaCvNBJJGdQQe_90A4Hhdsj6gVr6pAQ@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix memleak in security_read_policy
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        cgzones@googlemail.com, austin.kim@lge.com, omosnace@redhat.com,
        michalorzel.eng@gmail.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 14, 2022 at 9:25 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> In this function, it directly returns the result of __security_read_policy
> without freeing the allocated memory in *data, cause memory leak issue,
> so free the memory if __security_read_policy failed.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/ss/services.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

This is another case where there is not actually a memory leak as the
only caller of security_read_policy() is sel_open_policy() which will
free the buffer it passes to security_read_policy() on error.

If you want you could add a comment to security_read_policy()
indicating that the caller is responsible for freeing the memory.

-- 
paul-moore.com
