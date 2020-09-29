Return-Path: <SRS0=dH2y=DG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A745DC4727C
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E13208FE
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 20:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wcnlSswd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgI2U62 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbgI2U60 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Sep 2020 16:58:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE14C061755
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 13:58:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so17329026ejo.9
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=r23GbmNL4LDMeVQW45P66vg5+mjeMlxx7B+AkZOW/HA=;
        b=wcnlSswdpkTqNgRQsVmE4dXMEuSPyHNzNsdUOU6lASC3TcDt3M+6jFdJninMIKr1AZ
         i9jols1mMWBuL+RrX2CrwDWEaUA2U8v1fGgDiQoDEZ9AuX8CmM6wnvYmW6KAhtepWvy1
         x9HEbzJcbBQ0mvClzxHqRVoAVi+/M70OzD8iiUeJNtRxvDCR52fyaJkuwHYi8EqG5xgp
         +VB5BbVWmrzt+WXuSHir9GzQIRBfD0CFaKBEg2NGq1kXCo6MZmNuWAoP5wyNoGLCTCQ7
         XLt2W/onUnl8/c3CzGEWBC0f/q13BhXWyrQmpUKp2qGt19gB724WB4xRf3AltlKr/mdI
         61hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=r23GbmNL4LDMeVQW45P66vg5+mjeMlxx7B+AkZOW/HA=;
        b=chg4OMwJ/+14HoTZBrI30lRYzHVThnLYlKREW1kQhsWFoc5BtQqSzV/HuzRUuelBo9
         xdcre4Kd8yIJxngUbftwydpIEaOVCy3TK9+8MPjNkNHwK8emvhU1FXSayWyhGyIiSEQ6
         UWjX36DK6lcYYoNcU9zmgeDv7bGeuPO6fVs8bhTVSVigsOQQrvmDyPHOy2uVCg/g5Ym7
         a1ldIsYaUtj+OwwdGYNhN0mvnfe1vQ5dHBxXw1iVhUU2k4sAUqrEmTO8IS82lX8vKMJT
         f7a9lQcavCGeGmrEQHqbEF56sWOfxVP/pTZcJoXO8Dx98AJSTBfLr4qZ6N7TLrmBFHPP
         HDOg==
X-Gm-Message-State: AOAM533gp6dHCH34J0oC5KP59KdKTVYe74TE2490XgGzFe0DHBwlw2Hp
        0YuPg+xZjDN2esofbaVH1xbHlr699sfnNNSYGRdYrBxewA==
X-Google-Smtp-Source: ABdhPJw7jTOpRJFvpNuhM8U459vB/w0nqC3iLRdLAosqEwxRGXo9PEFsegGdKtHNWTfAhI3MZa+WX3QCP+QA+T8dTo4=
X-Received: by 2002:a17:906:14ca:: with SMTP id y10mr5720625ejc.542.1601413104074;
 Tue, 29 Sep 2020 13:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <160126062161.7010.15501362260483844999.stgit@sifl>
In-Reply-To: <160126062161.7010.15501362260483844999.stgit@sifl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Sep 2020 16:58:13 -0400
Message-ID: <CAHC9VhTXEWDeYnx0XWmso=wEw0L-dPLbRLw-fESqMyf=iM91-Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: provide a "no sooner than" date for the
 checkreqprot removal
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Sep 27, 2020 at 10:37 PM Paul Moore <paul@paul-moore.com> wrote:
>
> We marked /sys/fs/selinux/checkreqprot as deprecated in Linux v5.7,
> but didn't provide any guidance as to the timeframe.  Considering
> the state of checkreqprot, it seems like one year should be enough
> time.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  .../ABI/obsolete/sysfs-selinux-checkreqprot        |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot b/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
> index 49ed9c8fd1e5..ed6b52ca210f 100644
> --- a/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
> +++ b/Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
> @@ -15,7 +15,7 @@ Description:
>         actual protection), and Android and Linux distributions have been
>         explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
>         initialization for some time.  Support for setting checkreqprot to 1
> -       will be removed in a future kernel release, at which point the kernel
> +       will be removed no sooner than June 2021, at which point the kernel
>         will always cease using checkreqprot internally and will always
>         check the actual protections being applied upon mmap/mprotect calls.
>         The checkreqprot selinuxfs node will remain for backward compatibility

As this is a minor documentation change and not anything more
significant I've gone ahead and merged this into selinux/next.

-- 
paul moore
www.paul-moore.com
