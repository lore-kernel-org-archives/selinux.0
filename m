Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B2C433E2
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 19:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E400B2083B
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 19:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PMhA1QLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgIDTqy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgIDTqy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 15:46:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD2CC061245
        for <selinux@vger.kernel.org>; Fri,  4 Sep 2020 12:46:52 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so10084607ejf.6
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2020 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahv6Gcf8u2r+jQtV3sHwka6vcwXItXD23IbL0Z84Fnc=;
        b=PMhA1QLYRMgTBVzgBMJvGFmchumzjN0ffgrocswxS7tr6J0PMaEeP0i5nB11Ody686
         /jXbvj4JouI2JqA6KhwfIOCP/wfmPDEkYOfD6SajYfJ7DBfQfc75Cp/O6nDmtMjm6gLs
         Jhny/FgB+4m76MAPZul7M4FJateijfYVT/TVPmpxppwjccKtHM8AmypyIbCLXFxxs4SF
         FwESGbGaxwII3xoPS+sAPi9zRNFbJUWUXyI5Eo6BiHWd9oJOEjoI1s+5CDTBrFapMP/j
         5wcdRw7QNBR40U2nz2n+38ZXDKGlYbbMomU3fI2cH5gNCx8Cq7pQqtlr4dsOOJ/kId+M
         BG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahv6Gcf8u2r+jQtV3sHwka6vcwXItXD23IbL0Z84Fnc=;
        b=ARaYnFuy4bgRunEQeR572aWMpmFmxoZK5A9ibpQbJenoe0OcRFj1cd4pCmNqfKjyKU
         v5YvvZI6H33CZPxzez16lIs0m44XK+eSIj5WWyk9YtYkR00THUv72hVinJY7Fsem1gOD
         7XvYuwNMgt6HGlMfcfxoDirFWThH0IzSojiBLkmJOzu2LG11rhvBoU/wAFzsMQ8kPX3B
         m5L9uwpSIsHBrZD1fJ5wc949afCDcA/cn5k5QvtGe9wHZpmfaVOijZBUV5xh5my5HUYj
         CfAQ19jAbaltJGgs0rxw1ydJk42VZSbhL3BUh13DAy3zeWGlCcoJY0dpsIT7B80ycSGU
         /uXg==
X-Gm-Message-State: AOAM5333CKe1NrUvNlFeEFqqFLFGQU1FKIs7/fzSn8Zd05GzKwwHMknk
        NTE1uCO9g/RoYalcV/VYtEurrNfK29pJvoJfygRr917NPg==
X-Google-Smtp-Source: ABdhPJz6jGSVTQEdTCAyQ7P6P1g32qaLILNtTQua1cP7DRd/2P2IL6el9t6w9LAbPjr1LDVsw2QSQ3OLEv+yCzp5DqQ=
X-Received: by 2002:a17:906:15d4:: with SMTP id l20mr8873629ejd.178.1599248811394;
 Fri, 04 Sep 2020 12:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-5-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-5-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Sep 2020 15:46:40 -0400
Message-ID: <CAHC9VhSNkycyfv8Aeh23CHPRz9-TZAbM1ipN8jd_amwUqoawfw@mail.gmail.com>
Subject: Re: [PATCH v20 04/23] LSM: Use lsmblob in security_kernel_act_as
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:05 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the security_kernel_act_as interface to use a lsmblob
> structure in place of the single u32 secid in support of
> module stacking. Change its only caller, set_security_override,
> to do the same. Change that one's only caller,
> set_security_override_from_ctx, to call it with the new
> parameter type.
>
> The security module hook is unchanged, still taking a secid.
> The infrastructure passes the correct entry from the lsmblob.
> lsmblob_init() is used to fill the lsmblob structure, however
> this will be removed later in the series when security_secctx_to_secid()
> is undated to provide a lsmblob instead of a secid.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/cred.h     |  3 ++-
>  include/linux/security.h |  5 +++--
>  kernel/cred.c            | 10 ++++++----
>  security/security.c      | 14 ++++++++++++--
>  4 files changed, 23 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
