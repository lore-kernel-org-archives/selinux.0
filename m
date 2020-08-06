Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE78C433DF
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBB42173E
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 21:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XjuBUO/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgHFVpy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFVpy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 17:45:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3AC061574
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 14:45:53 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so51890927eje.7
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 14:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G003pjibfD3NMY1jAuFyg9fvP8+7h6flXS5wy6LoVCc=;
        b=XjuBUO/kLGHK/kIr3JbLdKhqbVlkAwK2udIXmWFg1kyPn4O61zAIYH4okHOSd7RRgn
         I7O6k0bfmhvcjfBwlTVBGIAMRNENftmQ7QbbdLhsyADpnLHpuVTLwXNnz15D4LX6PAN+
         ogF/q5Xd3jntMeR5BtjhBUijrQjH/MSS4vF6S3M31fpS8WmFyoEQyBGyTEUsxGs2C4L2
         bl0UiWnXN5qnpD9mGATzaH/P0sS6vMJpiX7vBdoMPrrdnyBXdskzSQELRjlIU18ep8w/
         8Aty4zj20tJ9eWl1e89Wh7SPG9k/2t8UL33a1Ab4R2tcaoZwFqjGUB8YCyE1o6kFbxg3
         hl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G003pjibfD3NMY1jAuFyg9fvP8+7h6flXS5wy6LoVCc=;
        b=qjlXLSK/W0iB3OiOgMSNINTbU9hWP5aKrfVcZ+lL89H1fzbZM2REhnb4p1ye39ddoK
         Shh0a2K/jTvz9BuIlvUOmn9l69e1e88oZnfv2cLDrea+hytiIcKUCrwug/WsP/Yy7DSc
         pURusQ8GsAyg541ELxPAhFkldt/M5+YZ5QkpRQi7bpKCgGJsLWbs//UdF9ZFwhTvXRl1
         tMu7D1uykTEIbiN2mbOFBX3ZSlYi55HRqXw+IBmH1AGcBMzHKYl90TwajMapDwJZ/J1T
         R7JEvvhc3wGy7cZ+okpWFSmCMDG8L8eYExvXBJMdxOOEgo9WgOsR65uP6BdTNkcsZsTy
         RV2w==
X-Gm-Message-State: AOAM530eB7bXUb4vN/flc0bfUOFna5JGD5Ast/JDHTM/YpK1YudmYCIF
        6yxkdSchHgE0q2nhPdZ2Hfj1RNPVSMwlFoENsxx5uJc+9w==
X-Google-Smtp-Source: ABdhPJz/JcDiRvbAiG5qzx80+/dMIopGs8FCfuciGO8yuRWVXQbJVkckrHacxSOk+vQfW9c1iEGE937nk6Vjz3d67XI=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr5936354eje.431.1596750351952;
 Thu, 06 Aug 2020 14:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200805154820.28667-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200805154820.28667-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Aug 2020 17:45:40 -0400
Message-ID: <CAHC9VhTEj7KrfZawcm5sdqe5cz-XNXAOwX25tDr_Hm7ncke_CA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux_notebook: reference_policy.md convert to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 5, 2020 at 11:49 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> This update adds a TOC to aid navigation, also converts most HTML tables
> to markdown unordered lists, the rest as pipe tables.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> This is built against Paul's tree [1]
>
> [1] https://github.com/pcmoore/misc-selinux_notebook/tree/working-md_full
>
>  src/reference_policy.md | 2524 ++++++++++++++++++---------------------
>  1 file changed, 1145 insertions(+), 1379 deletions(-)

Thanks Richard, that was quite a patch :)

I realize it never made it to the list (likely too big), but it's in
the repo now for those who want to take a peek (and offer any
edits/corrections).

-- 
paul moore
www.paul-moore.com
