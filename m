Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B7C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhLHUR2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhLHUR1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:17:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF18C061746
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:13:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e3so12362861edu.4
        for <selinux@vger.kernel.org>; Wed, 08 Dec 2021 12:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esrdpUX0SoROnKkrrW/RD+qbhq9gFQcU/WOb4cXTMow=;
        b=D3/fm5I7W1FFTStF14/3p+oKUyq5UklJOa2IqUucRVxQ4bh6P92X0zAYnrV3dtpEmV
         o/1PvbrwusaOuWVgWg7AgBe8kjCjHcXFEWza9nm6BMhbVjUzDMRr/YKzwngnqX5xUzsV
         3bfegQWrgW54sCY9KU5WmWi1kkI9r1BhJPVj62CjK/40q1+BaE+7x9ZwmbvYunEHzQft
         zwEnKb9hbejucg1CCBrDEpT96tYvtZc45TJag+H7HynKrf1ic4ICPhRkCT76XVJxKpDT
         A0uqd8iyxF4OWMaUN2mCv5ffQ2oXWBHNXa64+08UM1dQQ5GN1B9CB1R6+ggS9eeEz+x5
         SPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esrdpUX0SoROnKkrrW/RD+qbhq9gFQcU/WOb4cXTMow=;
        b=koVmADOGR2ztkaod0wMzARkKUHq780x46fPi6fYAlFIopNm08nrA3BhoGZtlyP+zRn
         anqJ/XMjlsb9WQKnAMzcsf8H3ARUg3bueCkyvp+3C+ldSzYPSV+8JSAoKRDC9WTzp96x
         M1iNboSH+faQ59pYVRHj/walk5lZkFreWO54pI0C2BaDt0kRBYge94sEyAU5wW8AkjqT
         WHvfC1TycEmsSKjM+LvIsMDBRfs3b3CUynPDMXKw21EyJhKHsVGwhr5t7WdQFhf18KaY
         CLAF+ThXe9LWf/9ugSIuGx9dP63m/AF1jON9fGTCtDY7MV5g0z3iq6Bz0mKgId5gaCC3
         xQTw==
X-Gm-Message-State: AOAM532WfWyBWzPrUxrRFQhw+mn0phPe1InZvOtcdiIrJ59xbiInQ/NG
        P4B60HGiI91uZS1yKPgEqCqCJ9XgFT9g9nA/bURZ1PdXKQ==
X-Google-Smtp-Source: ABdhPJz65BvU/ghkJQPODjTPHBHfjbtA/pTPMpMTWMTr4gDK6g3O73q+8LTcZAdP+hxHODzxzj+zEyrguilwUZ48BSs=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr9949076ejc.126.1638994434120;
 Wed, 08 Dec 2021 12:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20211208121654.7591-1-richard_c_haines@btinternet.com> <20211208121654.7591-7-richard_c_haines@btinternet.com>
In-Reply-To: <20211208121654.7591-7-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:13:43 -0500
Message-ID: <CAHC9VhSYoOuqLaF2BK0ACmUPxprk57O7y1zBG-rASGPvb5LGgA@mail.gmail.com>
Subject: Re: [PATCH V2 6/7] policy_config_files.md: Update snapperd_contexts contents
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 8, 2021 at 7:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Used by snapper(8) for filesystem snapshot management.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/policy_config_files.md | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Merged, thank you.

-- 
paul moore
www.paul-moore.com
