Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8365C433E2
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5147D221EB
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="uUyCe32y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgIKQp0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgIKPIO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 11:08:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFCCC06135B
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 08:04:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z23so14193073ejr.13
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01Hjpfl5TCrJ9zkcrpp5QzYrjKRNBEgxMme5wRHiSCg=;
        b=uUyCe32yD14JahfNXSDxr2yAi8cjm9eHXj+ufITEer58iIN32hiahSu2swohXzwwjr
         wHnRNDo3zbR/PN/vBAeRHotN5C87dgKqkzawffMnGOY4Gj4XQeexpBupoUfx9SQY5CH6
         9BSTi8DtILM04Ku4JDloe3WNmQXHIr21Da3PnOMmXA+Opi5bdy1S8yEGtbqRn9bPOql/
         vmVsVrCvedKIVxZ2Fa1V1ICit/UJvYo5SQsz09FHS4v0XHiCgdo3TI8QYbkOgfymmsmr
         oZvmTs+crS+PL5QKjGpH8l8NVe90cHRp9O3gyPvOOl4tWnnU6Ko3JBuJEpcU4JXOLu9E
         Mp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01Hjpfl5TCrJ9zkcrpp5QzYrjKRNBEgxMme5wRHiSCg=;
        b=fC2Vatre+WRSMCBsrboQY0AMw8F4E0giEPHx0DwYvxXqeVCsTU+lmfzT1Rn3PCjkYV
         kANXUJ65Kpq+pd+OIKdGfRkgR/YRs8it5gTI+CE2LLbImvpO0JhGwdnG1cGUf/doDlGa
         374ebQ9zN3DQzw1qKCpHVJPh0Lo2lhdRx8rIewae7HA+EctIXxCeGMeZHNSUGWQgBKmb
         84Z94+qVmzqha45xsQiMoXcixHFoR5wtrfjzUvh4PsBnlPIV5XTbxANYAtInVDx+CeVW
         TeK2bbrisBXaaNTXcDyWF6wp4d/NRTQxXUeQc50Wu7s0rxhoOfg2gkTy7yhxTsfESdrl
         WA4Q==
X-Gm-Message-State: AOAM532tsrsUDcXGPY9u+eN4wt9vvlXYDHPubHzKJgdINyEeAV2WCnlt
        xIZtGCHYl3ucyhmF25AA1FzUg2GhVrE0yVjcoSnK
X-Google-Smtp-Source: ABdhPJyU90cUDPr3XlqXUdB8VipSfnnOYMNPf9cly2QL8yWbXw+st3Ql+PngIvnluRP6nnLeIldnVnu1POfJNsiz52A=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr2418893ejn.542.1599836649274;
 Fri, 11 Sep 2020 08:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200910112435.4080-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200910112435.4080-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Sep 2020 11:03:57 -0400
Message-ID: <CAHC9VhTat5E8Kk3FVH7eerpcueW--tExCtW72G7i+-YH0V=c3w@mail.gmail.com>
Subject: Re: [PATCH] reference_policy: Tidy up formatting
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 10, 2020 at 7:24 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> Part of batch 3. This is large so sent directly to Paul
>
>  src/reference_policy.md | 1498 ++++++++++++++++++++-------------------
>  1 file changed, 753 insertions(+), 745 deletions(-)

Merged via the commit below, thanks Richard.

  commit e67de6695fdd79e345064fde3defe39860ea9f7e (HEAD -> main, github/main)
  Author: Richard Haines <richard_c_haines@btinternet.com>
  Date:   Thu Sep 10 12:24:35 2020 +0100

   reference_policy: Tidy up formatting

   Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
   Signed-off-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
