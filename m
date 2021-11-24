Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66636C433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 18:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350814AbhKXSo6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350837AbhKXSou (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Nov 2021 13:44:50 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5A4C061574
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 10:41:40 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so14462525eds.10
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 10:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyUwDbrDWXzAc77WTfWDgb6go9NZG74/mI5SjZsV+Es=;
        b=DkrTXsnP6d0MiGqy2Z5/Uy5tXrLtW2yPMFVy0M9Ep7zvRqeUDRtl5vDFbqGlGLf9Uj
         OBmZRKuNRMAjw3HsyUt05OjPp4gXvD3EcwayNNRBO/G3HHs5+p95dBMz8+nUWNT09tuR
         U9kDpD5WK5TC1zAwKd9Av8PsLSD0YotKD0aZrplyfFhiVN0m1IchTyflTy6wEjXogopO
         dtcNBYTh1vLOOXr18cNXd5lKmIgxaszLCcvyHE2M5fCNs51gSXnjTtItswzg9XIhVLVk
         e0nH7ZVNZSjWGQAPSWjMlrJiinM5WJ7LkmTOaRpca7CjCFl8mQuszJ6rxcTWQXsqOXD+
         aCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyUwDbrDWXzAc77WTfWDgb6go9NZG74/mI5SjZsV+Es=;
        b=RKcCPcUhdu3xYSLY41n9X3diDgBetnwagY429ZNq9xH3Ygdh4HppGw6RrkqFSqXBch
         2N1aJEYwUckFFSwaE3P5M6HmcFfFnZ4LBqdELcLirMOsgltMCEg1QUc+iiWJBt8kw6Mr
         TJZUUDaXXY43YmEPdx6tyDoo+Jadkcjzfl2is/GwHz8eQncFNI8Wt9IMHG3pa9z6TCH3
         gOpxuxXScwme/mZ1dH7Am/H6647pxO56X8+j9o2E3gTqv99nAhhY8mdg5kBDYq0vSSwE
         Q1SWCIhuB33xAaO/TN2bJqfqfyN06Ty3ljemXZiIOAMlc54q3cxOEREPB/I1KFTkH33S
         jxkw==
X-Gm-Message-State: AOAM532nSHlc+7YWvNsDonQCffs+qh1GaoLBQXKIbdHmagOz0KFeAImN
        6OC+9iU3hybcnKl4Yyj7yfGIocifb9eH/gT4QuVLY2+EpQ==
X-Google-Smtp-Source: ABdhPJzrcuxMr2lJfxA9G7lRMNuKJUSjGQFHsDWZ4GK5NoXyeNMaMfjpsbN6+xnHXtZldvtwG2ywwxOh/aqMfQ/ZYRk=
X-Received: by 2002:aa7:c30e:: with SMTP id l14mr28399006edq.370.1637779298959;
 Wed, 24 Nov 2021 10:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20211116163838.10888-1-richard_c_haines@btinternet.com> <39a355a3d56b14d4f6b7323ad34e93b29666ffb7.camel@btinternet.com>
In-Reply-To: <39a355a3d56b14d4f6b7323ad34e93b29666ffb7.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Nov 2021 13:41:28 -0500
Message-ID: <CAHC9VhT2j+tFA5tc-WLc-TWPFD0E+k2r+dGj=g0Lh8t4TEzj6A@mail.gmail.com>
Subject: Re: [PATCH V2] netlabel: Update man page to clarify SELinux labeling
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 18, 2021 at 3:15 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Are these really bugs or just features ?? The new tests in [1] treat
> them as features.
>
> [1] https://lore.kernel.org/selinux/20211117131450.41705-1-richard_c_haines@btinternet.com/
> https://lore.kernel.org/selinux/20211117131450.41705-1-richard_c_haines@btinternet.com/

Unless I'm misunderstanding what you've written, it looks like you've
written is what I would expect to happen.

-- 
paul moore
www.paul-moore.com
