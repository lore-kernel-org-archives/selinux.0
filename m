Return-Path: <SRS0=Kg/k=ED=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A782C56202
	for <selinux@archiver.kernel.org>; Wed, 28 Oct 2020 23:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D63720796
	for <selinux@archiver.kernel.org>; Wed, 28 Oct 2020 23:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="A/QRGsZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbgJ1X26 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgJ1X1c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Oct 2020 19:27:32 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D1CC0613CF
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2020 16:27:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id m20so1093818ljj.5
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2020 16:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWft5hZntjfk8A421MGU6aw0mG21W1JeK/uUTh133MI=;
        b=A/QRGsZ0dZzRdTU/9cfrqhpVd1Q2ZvOalmUgATmPrtacvSfzWzc8BB8ST+SotXHtbj
         5A++vO+nbRfhxEsVDuapmdPyXgfGOb5bWNONeB6lFKn5i/fWUhR2RaFRnq6UZZ9+O6h5
         IbHt6pXnu+2tpeJ3OOUHlnT39E1P75rVhDPr9h8JGgv8wYR5uVpkdwL8VuFWwCFHlQO9
         8SP0l9GIgaOaDA2OrGVL0dz1ezq7UtZAzMgMzVYOogxG8A7ovpCFRICzrZoiJaoKYNT8
         lIsI84Q/h/hzdJSxzbDJA4iRJHAIz2FU453/kEGtWR50w22aGrwmW0RzqpGSpbVdPnHY
         96Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWft5hZntjfk8A421MGU6aw0mG21W1JeK/uUTh133MI=;
        b=Jv4Mojt7jZ2BBjpHdnssVzR9cKbBtZaz2G6v86zHW7DOu4Vc8WyPuo32INKbntOCuf
         uKnBz8pDETalTyqovW0QVSP3Z8IUa4Vymw1G3lLsjIaMCJUIv+n2wLHe8sAjEc57JfGf
         002ux3RJP6BlnZBhctK5S9VrOdVp8hcOc+AJzxJTensIuLywMXTvOfJybbWFAMmJMUoq
         E8PToRkhiJGl6IACggFb4lKuRnouplQQylHE3hxa6gUfUVEwB3Y7McbKBWSIm+mUDzts
         nK99p4Uhkt/ahd+qeca2uuCmx/+c+f323Ddl+56OqzZJgDI8rerQjis37Z23YMrnRANk
         VE5A==
X-Gm-Message-State: AOAM5311z4jpxCjf7OyGYgldG+dJJt24LZQol1duvQ3rNoJ6iZyzp50H
        l3M5nsyKSD9INkSpmSNvdmPcmueV+jRFj+tZFalSQJ/IUA==
X-Google-Smtp-Source: ABdhPJzZWfbZFYe/7U2xXYFZkGB51VUAaBDhLvS/IleVc1AFXhuy3R5f6pNyqMu33yHvXEIXKx/5N5HUYd2e7MZ2htw=
X-Received: by 2002:a17:906:4811:: with SMTP id w17mr5064677ejq.431.1603850727759;
 Tue, 27 Oct 2020 19:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201001200527.13226-1-toiwoton@gmail.com>
In-Reply-To: <20201001200527.13226-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Oct 2020 22:05:16 -0400
Message-ID: <CAHC9VhR0khcDrCPWf62PeUoeGxCfpaFh=V6CBCf9+ticf0z8Yg@mail.gmail.com>
Subject: Re: [PATCH][selinux-notebook] Link to Reference policy
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 1, 2020 at 4:05 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Use links to https://github.com/SELinuxProject/refpolicy where useful.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  src/class_permission_statements.md | 13 ++--
>  src/constraint_statements.md       | 18 +++---
>  src/reference_policy.md            | 98 +++++++++++++++---------------
>  3 files changed, 70 insertions(+), 59 deletions(-)

I apologize for the delay, I lost track of this patch; it's now merged.

While I think we need to be careful not to clutter the text with too
many external links, I think this is a nice improvement - thanks Topi!

-- 
paul moore
www.paul-moore.com
