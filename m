Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DA5C433B4
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 01:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A6361165
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 01:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhDHBf0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Apr 2021 21:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDHBf0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Apr 2021 21:35:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED484C061760
        for <selinux@vger.kernel.org>; Wed,  7 Apr 2021 18:35:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ba6so398384edb.1
        for <selinux@vger.kernel.org>; Wed, 07 Apr 2021 18:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wlm15GT5LEaEn73vhONOvWCJpWcPOnU+mIOBICfSgDU=;
        b=sOEGbwSv2ugr8WQULiaKse71mU/ave1bR9xhOj4WkFGOhCaeZDKW2RLgG4Z7Rc+LXs
         brq4GK4uutH2f+2WVh7iGwVIxQVcWljzcGf/7kUJHzHIVzWsqJFQcRLV9ezhxJg0TbSD
         daiYQ1t5QK40thbcTTDLboJ3mZPPwXRq1QyAQPhsACmx44tfZ40lpb+9HOiavUiuCT1q
         ygXmCUqC6KIHPJuSRptHJ6qlwWiqaZ27gSYuhLa0rhOB/rTP3LZMt5AWiB8l5gTVcKov
         Dn89f8M5zcogS/nDxerv+PyjtzaFCnsUfNyuyqXMXLHkW1kjaoxNISpk3iMfYYQ9ArBh
         UJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wlm15GT5LEaEn73vhONOvWCJpWcPOnU+mIOBICfSgDU=;
        b=NUQqtUn/xoK5UmlBknMM+zDhjm4FlXX6GUrfpGiSRKEiznXUqc6xq0WvcatKtu2Rmz
         S4hil3Jq/4RtFdD55v2hsC7vDUDrgwDW4xF/mvqnLnYVeH1R7jfnGY/hv2a/sHEeRL6w
         kmlFzREA9/xGihaWUQk8gdvWBNVBIPks4b42WPP7+P5+mntwTRlGStTgqWxWZ5q7jgPA
         R8YRojHC0BGm2Y+vcsOOGeDt3WNYWdQls4bQYFK0XjSX0KSkGHAOkqo6AV5G/ySrMerh
         dbr0ZaEisLSa4khMWConNc38mGJeVeYt/+t0sDiJMbZdUNcE7c/Imezdiw/z/BDNZdJr
         evbQ==
X-Gm-Message-State: AOAM531PnN/65fLUCnQ/zqjVmP6/aT/sUTljGDMfhAtuj8dKkwpJOyuX
        zl5EWjEzdegbqgukDYDGcN7yE4dzrjuGZNg738lRXB5ZAA==
X-Google-Smtp-Source: ABdhPJy+y0UtXEJEotF3pTf3YdBNFzHph8lxZEN0QYqZ8zWAOSzhC61B9K3NlyyDSGOkIA+EAY3qT7olZEboaGGkECk=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr7933245edb.135.1617845712436;
 Wed, 07 Apr 2021 18:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210309164602.145140-1-richard_c_haines@btinternet.com>
In-Reply-To: <20210309164602.145140-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Apr 2021 21:35:01 -0400
Message-ID: <CAHC9VhTKenaAAXa2rtLneCNpJHJRumv-HiHyBX3CyUcVdHoqOg@mail.gmail.com>
Subject: Re: [PATCH] object_classes_permissions.md: Add anon_inode class
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 9, 2021 at 11:46 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add anon_inode class and permissions with example rules. The kernel
> currently only supports userfaultfd(2) services.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/object_classes_permissions.md | 28 ++++++++++++++++++++++++++++
>  src/type_statements.md            |  4 ++++
>  2 files changed, 32 insertions(+)

My apologies that it took a month to merge this, but once again thank
you for the update!

-- 
paul moore
www.paul-moore.com
