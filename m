Return-Path: <SRS0=kXWH=DX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A5C43457
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 13:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3300920866
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 13:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rRNxRHvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407440AbgJPNzi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408053AbgJPNzi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Oct 2020 09:55:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEEFC0613D3
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2020 06:55:38 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qp15so3330648ejb.3
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2020 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7AeE/8ZEYkMdda7MRqPSGY/h9PZ7ZMGSOdv+l0BJqM=;
        b=rRNxRHvXxrdIkThWmsaSEzV2wmuxFRR9aLf90NFlOlcnyVWeb9Ivsapeydl0B4gecP
         BBIg0z6f5GUSAasmZBjmL82isvl+jwMxxQgb4oRVwU/g3sXRptjlUQqiHihHEgJHzAFa
         RbvvPJCq+WT5se4YSjFqmGBegd7jS5GqTs7WDwVEF4YJqPvysLEqdJUN3s5uKfdZJbXt
         oYxOuV/guWTsr8tO67DN026/CBQ7lsxnZCVYIQIwJtu18G5vo80lhODixW9fOXOtibn6
         4bEU5Q5bSHRC6fYGo/TqhYPW/V7DNGytWYOQm65+VgGczbNmdIiNTIMMmR/xGNpmnWjF
         D1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7AeE/8ZEYkMdda7MRqPSGY/h9PZ7ZMGSOdv+l0BJqM=;
        b=Aw7UhES0xpMMpf4QldMzUDg68tODg0hYNSghJyDJzmLXWboMtk1e9SWhMtMfuBNv+r
         IvobjXBYLGZA/L/86FoJwXlhjgpkQnNZbVtX0nWPm2jkYqeJ9FEPzxvvN5Z+vD1eJwLJ
         So1VXh0b/B027MEWQRCETaeGql4MZnIMnm4vaRzi7oX9u++dq5p92vkvnduUpPeIs272
         DsD/XF2tmMtjvFevMMNkqeQ09nLf/VakYz8L4CWg2R0qcax2gZkEgUMirN8O2Qfksq8Q
         3UX7NXZo5az7a/kryjWmf/ny53XIlT8E+2Ydhta5Eq2OoHWPwNoMJKCO6jTz0bkRAN7c
         FfZQ==
X-Gm-Message-State: AOAM533iuAle/j7aC/KSXrLrvdyHiyeNlk5kaX20+PYkXUWoaN6ZhZir
        SUwjf7wOxEsRj5b1WPS6FD71Bvl18e1el0vvEqWx
X-Google-Smtp-Source: ABdhPJynpfGeTPWurMLvjzhlpYPkK/ETBVsdQbqGys3We0W4hWQwS/FxKI6JPMO+fEQn/oPqD24TzEsWF3/WNpYLZ8w=
X-Received: by 2002:a17:906:f2d2:: with SMTP id gz18mr3783320ejb.542.1602856536545;
 Fri, 16 Oct 2020 06:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201015192956.1797021-1-dburgener@linux.microsoft.com>
 <20201016050036.GB461792@kroah.com> <9aeaa66d-d369-a1eb-7a07-08d9244585f3@linux.microsoft.com>
In-Reply-To: <9aeaa66d-d369-a1eb-7a07-08d9244585f3@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 16 Oct 2020 09:55:25 -0400
Message-ID: <CAHC9VhR_WG13wLT-rJs0AdDgh6kwN_ei46btyXp5KusUdzuOag@mail.gmail.com>
Subject: Re: [PATCH v5.4 0/3] Update SELinuxfs out of tree and then swapover
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     Greg KH <greg@kroah.com>, stable@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, James Morris <jmorris@namei.org>,
        sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 16, 2020 at 9:05 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> Yes, thank you.  I will fix up the series with the third commit
> included, and add commit ids.  Thanks.

Greg and I have different opinions on what is classified as a good
candidate for the -stable trees, but in my opinion this patch series
doesn't qualify.  There are a lot of dependencies, it is intertwined
with a lot of code, and the issue that this patchset fixes has been
around for a *long* time.  I personally feel the risk of backporting
this to -stable does not outweigh the potential wins.

My current opinion is that backporting this patchset is not a good
idea; it gets a NACK from me.

Daniel, in the future if this is something you want to see backported
please bring this issue up on the SELinux mailing list when the
patchset is originally posted so we can have a discussion about it and
plan accordingly.

-- 
paul moore
www.paul-moore.com
