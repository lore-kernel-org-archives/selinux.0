Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC08C63697
	for <selinux@archiver.kernel.org>; Mon, 23 Nov 2020 23:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB58206B6
	for <selinux@archiver.kernel.org>; Mon, 23 Nov 2020 23:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TH6uTo8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbgKWXHZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731290AbgKWXGu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Nov 2020 18:06:50 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D57C0613CF
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2020 15:06:50 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id y4so18865129edy.5
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2020 15:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxUY2dFIc6cOw38RaQRswDEYqPWmrOvWaXrgMqJUbPs=;
        b=TH6uTo8AipV6bSuRVHxThKvpImCV5b9rHCrVBEyQxEY+cr1A3F/6uQUHZdiDoO+bay
         KCHW7mfSgx/ARKKGY8pMvae6aUa/T51gRrBVnioHoloCGx0oCGh8MyEfX9vdrfMYWtX9
         iZrZ/FIxB1DRJdw5ZW6G/0R67iiCrd0N335xLBOik65FJrW4m2TjRvOXGZ2FnqhUp16p
         hqC1bBe2jvPzNBn8+njjKnM42W/2MsNmU5Z+1qorq5/Gg3hi92wknNzXeAo17Xwh4IKo
         ua6RyeFLqzq91NbpCW/DSnatbCf51j0b2D3lu9r4NAralmS5KQ2oSjeQmL3DN8pA4bHj
         pGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxUY2dFIc6cOw38RaQRswDEYqPWmrOvWaXrgMqJUbPs=;
        b=a1eA3ib3t4q2o94VGw5ARAb7E4vfafuLz4zyBuFPob7dDJs6CmW2sP5Wa/6/FNO+QU
         roqdN4UZ1No0cZQD06cShbWXylipwkVysVA9FAnC25tXDNqNJLjn8ITptuSey4WCfw8K
         Frbpb138wSaJE4QNoTLGC7vS3X5SLlgB24dUMkZ5hBj27UUAYVYVeEW3/vYVWtI+JS72
         QX81DTfA2dRcOE7zLjT/XmdZ8ED1vWO+7wBuZUQg9YjHq5SAYeCMc0z81a53L+FQ3x0e
         1PyYGnPcJPSDyxHLcRvkdv2VRbIDXlK2xLBQYVdsNjyNZUSi6wveRPvrwugIGDlge6iN
         N5kQ==
X-Gm-Message-State: AOAM532E1NjaAnLqcWBdXB/S298+ElVPQ/QrjgmKAg3KWvL0WjuPkoiN
        HT3RCpIjzs5KcH077Wr/nDrr1s242kqA+76fyWMOnhuqzH+U1wg=
X-Google-Smtp-Source: ABdhPJyC+0NGGdolPWX5slvgn/lDRyPivTYlvEZi0gnIk9DyMqmE1ZjOSI/ZGcavRL/waeZHq+dUj8RXgeBDXMqO374=
X-Received: by 2002:a05:6402:44b:: with SMTP id p11mr1436931edw.164.1606172809014;
 Mon, 23 Nov 2020 15:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20201120113807.11605-1-richard_c_haines@btinternet.com>
In-Reply-To: <20201120113807.11605-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Nov 2020 18:06:37 -0500
Message-ID: <CAHC9VhTzkCiaRXXO9ZwPNyG59c-uJx=jW5qYPqwfv9jeVPxcGQ@mail.gmail.com>
Subject: Re: [PATCH] mls_mcs.md: Convert section to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 20, 2020 at 6:38 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add a TOC to aid navigation and converted to markdown.
>
> Reworked a table that required rewording some text.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> RFC Change: Updated MLS/MCS text to reflect [1] comments.
>
> All Notebook sections should now be in markdown.
>
> [1] https://lore.kernel.org/selinux/80e38828-1473-5bc5-1b23-067cd242125a@gmail.com/
>
>  src/mls_mcs.md | 411 ++++++++++++++++++++++++-------------------------
>  1 file changed, 204 insertions(+), 207 deletions(-)

Merged, thanks Richard.

There are a few other small outstanding patches that I'm going to look
at now, but what does everyone think: time for a new GH release of the
notebook?

-- 
paul moore
www.paul-moore.com
