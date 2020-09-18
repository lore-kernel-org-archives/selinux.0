Return-Path: <SRS0=V9Cn=C3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB789C43465
	for <selinux@archiver.kernel.org>; Fri, 18 Sep 2020 14:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EA3207FB
	for <selinux@archiver.kernel.org>; Fri, 18 Sep 2020 14:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vlKtU8tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIROfy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIROfy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Sep 2020 10:35:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435DC0613CF
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2020 07:35:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so8426625ejf.6
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2020 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goKY6TNFLoxYDgjg2ZEWcJZdveBv2QrfTYO76fvONkk=;
        b=vlKtU8tnMjvfek11VjW1A+zqlxQKEkh5ujzSauYSkvtng2stPXhhETpf7RtT8WIH/5
         u7lZjJIbEGQJqjhKxTm3ZAZ3iv+z9NUK5SJcaw9eVjXaPW8/U0dYx+fC0Sdz1IG2twZx
         DVozz6N0z7Y8AO7wqy0U7LBwUffzuT+8mDhy7HAsBNd98h7yVJOpZBTC3Hl+3q5n0QkN
         eaJCBRF3G3SX9uTbYfE+qK2VAUxkuVjxNZBLekRJnVolXUK1Q0EFWx67kbLXU+/WRksf
         SbAjPMCHK78HsmJCmsIf8W8hofSMmSqk0izTodUVavdlcSYJj8Nw65T4z1xLhSs5GsHQ
         xYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goKY6TNFLoxYDgjg2ZEWcJZdveBv2QrfTYO76fvONkk=;
        b=ERzgTqDSCIxDgg3yj+c85ywoGm93fGkqQbTMmS4se5nuyU/FJ98fsx2PBuRsVwt/Cv
         qK/fp47Xumd418YBp12hclc9FI2KIURPtY1/CgnncA8sqb70qgcfvK/YX74fGkF+3KXT
         uq7KjYZa1Ed97JKKSEZuIADzW1xPWO+4Pq0uMlfLA2Ve+GFirH7Xc7ZRSyEO+PgHCjMP
         +Ry4aAD5YlquPr+JSEB88kYFazyGeqzOKYJWixmEZO5zfGGkXCI7GqnuZUR8YtjtSwKH
         mwjjUmMctTkfrO9WK3gSaOpfkkrgmLKAGHApOCam9NhhcDlM1tgQJ642QhzLpWfuiSJv
         AZpA==
X-Gm-Message-State: AOAM533BijHpPb8W5V+dvaOZHBeto/M2h2Gs7RWOiBiW7UaPgobP4jBo
        PJVL0dB3ckAFAB5Y3YCykICdO9ltWlQNnXE5ijr+
X-Google-Smtp-Source: ABdhPJzP31on6mxrANNbLVrfvBLXeLct5x7qrr6i9ZChmvxHOCwzD8E6IO/vJ7kqQ5CxKu++he4nPfvSha04rhu9+c4=
X-Received: by 2002:a17:906:14ca:: with SMTP id y10mr13617102ejc.542.1600439752566;
 Fri, 18 Sep 2020 07:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200916134119.314487-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200916134119.314487-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Sep 2020 10:35:41 -0400
Message-ID: <CAHC9VhRKgv4YRRUR+FduyCSpKULxnKadfDiq_uCcmzHTNGYEcw@mail.gmail.com>
Subject: Re: [PATCH] lsm_selinux: Convert to Markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 16, 2020 at 9:41 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add a TOC to aid navigation and convert to markdown.
>
> To convert to markdown required updating and moving text. Also
> added comments regarding later LSM support (such as the
> include/linux/lsm_hook_defs.h file etc.).
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/lsm_selinux.md | 1310 +++++++++++++++++++++++---------------------
>  1 file changed, 672 insertions(+), 638 deletions(-)

Merged, thanks Richard.

-- 
paul moore
www.paul-moore.com
