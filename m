Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E9C433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 20:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiDNU5L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiDNU5K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 16:57:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AEBF32B
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 13:54:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ks6so12306952ejb.1
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 13:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sTxjS6BStUu0Wmo0nP4F2y+IGf2b4gBfsN+RpAfhxQ=;
        b=2AEVc9MZk5l9Y1W+mtiM40iuppZ7Ua3lU01wkg0imSQ47wSyISWHfmafu9nkhCnc/W
         bT9tAYLCQwOag8Kq9nSP2vUx8gIirLBZ+bZgoK1fuxbrmrnhzDUBm4FWCaVNovveN8DL
         hJG6dUyg4MhDxHRdtBgptT6yFlWHuSHE3wg4V2v01a+RIcIjYAUkq/BWYEM0cs8dj3ip
         6BngViWL+DlMest/BDj6BLfyg0r1GMqHnkRH8pCjVv+osyaajm01Ibr5Xl2E+RIdztGy
         1alRop4XpMGXzfxiGlxDDh1gv12BejVGEwpUv26iuXKyTCe1OK2DPVZxSLbeKoNm97DA
         pHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sTxjS6BStUu0Wmo0nP4F2y+IGf2b4gBfsN+RpAfhxQ=;
        b=dRqmtd9J8UwZSberwatVSpfcxOMrIJNiW8dvK/irvQ4kfW3FCeBt+LWJmvZE4LQsb8
         tD7FXBn8W3U2qo8LutmW9rsOJ466MUeIpV13D0DRJtHLmHI3wDZ8rACdKzpplxwNYhQq
         Nk2pGlP/0Z/aMdUCIm4P8DTWwPHVWMhrmi/w+iqX1WjioUN3KV54DwlWBQro4lHYJUgo
         kPCgjaMeqcKSL4pZNJlx5BaSdMU8AHEQT/eUL+2tXEtLIWPMeQa8h2PSc5b6bkN7vpaA
         bNFWkACPQ/Wzxm5elxSJUplAhADkSniCrhwD9Wx950b/gUx9J2OsyN7Gs3q+J6Czm1q4
         e5pg==
X-Gm-Message-State: AOAM530fw1D+3AL0dnxeCyRCOQqP16pBCE53o3TsSacL6/Bb8mUTuzV7
        EcaP4BBAZERet01ZW+z7BBdbg2G/5MvFm70okDQpAl6J4g==
X-Google-Smtp-Source: ABdhPJxmdZmhn6flnVCqRN9Sxw+RpDXCcSUUyg00DkhZFh/IIcGcoDOjUe3FPJQ8eGyrwgrwDTMWTFb/53h3p1UH02Y=
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id
 dr2-20020a170907720200b006df83a967d2mr3754558ejc.327.1649969683129; Thu, 14
 Apr 2022 13:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <164996959615.228204.13557296900347416352.stgit@olly>
In-Reply-To: <164996959615.228204.13557296900347416352.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Apr 2022 16:54:32 -0400
Message-ID: <CAHC9VhTm2rgrP9wRiuQFDDY2iCN=iguBeopVU0=saA=jvP0VtQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't sleep when CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE
 is true
To:     selinux@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 4:53 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Unfortunately commit 81200b0265b1 ("selinux: checkreqprot is
> deprecated, add some ssleep() discomfort") added a five second sleep
> during early kernel boot, e.g. start_kernel(), which could cause a
> "scheduling while atomic" panic.  This patch fixes this problem by
> moving the sleep out of checkreqprot_set() and into
> sel_write_checkreqprot() so that we only sleep when the checkreqprot
> setting is set during runtime, after the kernel has booted.  The
> error message remains the same in both cases.
>
> Fixes: 81200b0265b1 ("selinux: checkreqprot is deprecated, add some ssleep() discomfort")
> Reported-by: J. Bruce Fields <bfields@fieldses.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/include/security.h |    4 +---
>  security/selinux/selinuxfs.c        |    2 ++
>  2 files changed, 3 insertions(+), 3 deletions(-)

This patch is very trivial, but just a word of warning that I haven't
actually tested it yet, so YMMV ... my test kernel is building now.

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index f7e6be63adfb..393aff41d3ef 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -152,10 +152,8 @@ static inline bool checkreqprot_get(const struct selinux_state *state)
>
>  static inline void checkreqprot_set(struct selinux_state *state, bool value)
>  {
> -       if (value) {
> +       if (value)
>                 pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot\n");
> -               ssleep(5);
> -       }
>         WRITE_ONCE(state->checkreqprot, value);
>  }
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 6c8b6a0ddecf..8fcdd494af27 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -762,6 +762,8 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>         }
>
>         checkreqprot_set(fsi->state, (new_value ? 1 : 0));
> +       if (new_value)
> +               ssleep(5);
>         length = count;
>
>         selinux_ima_measure_state(fsi->state);
>


-- 
paul-moore.com
