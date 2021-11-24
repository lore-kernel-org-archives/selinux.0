Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D00C433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 18:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbhKXSri (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbhKXSri (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Nov 2021 13:47:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30156C061574
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 10:44:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x6so14630481edr.5
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 10:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P717wxUJUtqZpc5a2tCa5X84M4R8mhovpQiw6dwFRbA=;
        b=OUAenDmmMlenxkqw2jW7B0lPRmeREiGrDd9vsDIcaKnCEBeiHvBXO66GF5ZQTOw62f
         AKYcwUjFTzPOTUCuIcwYH37qXjdUlTogpPiki3xCOslrCkyNUZ1oR2WXfjUuWY1E9yi0
         j3e+qSbjJzip/2L64ncN8OClxXZewQhwe64QQdUocxmYbWrp56XRyQ0GlTSh4SrpOXNA
         9cpZq2c7F8TZuRyoWBJmxPJ+zuDNOJEO11XxoBKBIjr07jLCgBVHdF3VpiVohSC4lruD
         rhIDP2x3CRt2l3hoHyjk0G+p9ayKlSsAjbxARml5TBK9mTq2JUClbUNCXWHvgXcbG6QC
         kI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P717wxUJUtqZpc5a2tCa5X84M4R8mhovpQiw6dwFRbA=;
        b=cjoxuneC7LqF6rVVuzDyINCsO90kgf9+mgmrBNWUgtYf+oHoIAetaqNVeCq3x3Paiw
         3ATdAhckjAj016hiCrD3M2uVMiNxc8hxCRzCbXNIukiU1/Ym0vnxWZ3MHUYiH+jlUEBh
         qm0UrbKjUEMkgW2HOKziPIDRHzyThYSv7PdIdn6ekmlLah0rmg9gy7MsuL/tOBpyj22z
         kWvCvcvKQeNki5dY5icoDQDnwB5gc2mdlSbTSn8O5VpblEzP8nF+1g+Up2jJsteRNdpv
         xg0jI+YPyskRSsp4okjFAgOJuy2K7CxvLh5S/uHHEFJ5iltuZCZpyA0gVmV8y8zdmz+5
         rqtw==
X-Gm-Message-State: AOAM531+yWDHKgv3XbqnYolG8txL+kA37hdRbNL7EKjVCZ1JRMvBXqPF
        BSrUgQnAQSR8jX8vm8G4+BcgZYNp4YC4twId96Rc
X-Google-Smtp-Source: ABdhPJy/G9SC3q5VqY+WxKOLgPd6Cv8UEj387j5UUpaadkQP9DWE7M81p1uzCPu+kZ5O8zapXEElcztXUUXtYBRoK3E=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr22326396ejc.126.1637779466696;
 Wed, 24 Nov 2021 10:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20211116163838.10888-1-richard_c_haines@btinternet.com>
In-Reply-To: <20211116163838.10888-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Nov 2021 13:44:16 -0500
Message-ID: <CAHC9VhR31kRBZFCubZJsAYMo1pyF+V-gq3YEew2AU23tzOFn4w@mail.gmail.com>
Subject: Re: [PATCH V2] netlabel: Update man page to clarify SELinux labeling
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 16, 2021 at 11:38 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Clarify how SELinux setsockcreatecon(3) and policy socket* class
> type_transition rules can impact domain:<domain> entries.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2: Clarify the labels returned using getsockopt(2)
>
>  doc/man/man8/netlabelctl.8 | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)

Merged, thanks!

-- 
paul moore
www.paul-moore.com
