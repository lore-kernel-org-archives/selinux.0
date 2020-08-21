Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C35C433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 21:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA67207DA
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 21:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LSCVdlSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHUVaC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHUVaA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 17:30:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F9DC061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 14:30:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qc22so4115278ejb.4
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=SjBM2w+yqamBFqHY3HMQ7v8oFi5QuuhimQFUb6IqlwE=;
        b=LSCVdlSbnuE0WXQj7nYao7ySVQ9bjH0oAm/BSZAFA/3EiKTVFk4JS9dCw37ZizOkza
         TMKIqfcs9zc06g/VBMVwPS8czCrXHzXeG6x6I5XSuaXl6os7umgA5GhcivE4EFqNws7W
         rUFuQpopCDWIr2BfvMar70uV8/MXkIwGWGYZ0GbyO5FyejYrEWEnXn0OylUCXBtsD4H8
         Cx+wL1te6+vysiZl4hrfBlIuXevpD6KEiEnGTm1Mvu6zu+dUk1wKPn2JLHohbMEcBYVY
         ZWu8R+t4Jk9lmoaYiAs/IMydtgdgUcFIrg5GUEITxggyf0NUDohwd2a37J58N1o1pDqI
         /0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SjBM2w+yqamBFqHY3HMQ7v8oFi5QuuhimQFUb6IqlwE=;
        b=avn/pGEB2/zROsPwnNEmw6ED/Z4DMVqno92zUhNoIbgBjLBThx+snd4N0lx9yREBg9
         jXSdbb5jG97wtYOHETtBk6sty7dLpkRWnxcfsHstSNLkXA/yjHaDlDElb/3hgG3QVa6B
         nma/646TJPHJSkM3zDRvNHjJw+rPmPY/tyIWtEKCEvx3D/Q06h9b00N8S9gCX8uehYFl
         dbZ1WhVsWgt4Et9Ra++k34blidhSi786x4X12FQ3QLadfJPk8OaMIzks5ly113NFAs1/
         Ibq4reXYRYWYe4InTYI72IDiRnYS9nTHEJkQqGed8HfDtRuCQ716KEVmFz5uvg1ZEB9S
         sMoA==
X-Gm-Message-State: AOAM530Ctvg8pohRB/j5CfVQxvsnhHCwXsSyixzR7xedJwvJkpc59cr6
        Cj/H+YUrHOtoyLNnw1+Df0Feuy/M3zzKA+ilTvwrPEMmJlhx
X-Google-Smtp-Source: ABdhPJyVtUsPPllf3r2GfU/ceecY/UAKYAubbujFfcs2wMmGUP7HiW2+I1nM826tpVTyNh2sKsATHoS9XWpn2MthYHE=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr4820912ejb.91.1598045396245;
 Fri, 21 Aug 2020 14:29:56 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 17:29:45 -0400
Message-ID: <CAHC9VhT0ucY=C4yOiO5ctMG6-xQD62=r=Ufm+WxeUeCCByY0iQ@mail.gmail.com>
Subject: Administrivia
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A heads-up that I've replaced the "master" branch in the SELinux
kernel repo with the "main" branch.  This should have little to no
practical impact, but if you run into problems let me know.

-- 
paul moore
www.paul-moore.com
