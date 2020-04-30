Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A5C4724C
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B43B2166E
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 21:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ya9KFbXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgD3VZb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726447AbgD3VZb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 17:25:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7CAC035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 14:25:31 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l3so5732455edq.13
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 14:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ARrKkt2oOviflPL7roHyhtztZJejuJ2ZLjqFxYP4ERs=;
        b=ya9KFbXEvO2OcXEJalofdrW01KyKpFlcfvWKGbANSWEHRLFke6DVVyG6XQUrK5XIIV
         hwc03mTmkvbTgb4NUS3aVTS/ZU9PaWAfD9YKH/wEaA4tmWrWLSIY61YbuJ/flg0pd3+j
         3mhpDiEN7gjH5Ndgf2mt9x2wWptrgn2EC5/yge9DY9pFP96lqR1r0RoWq9+LH0DcJ2QE
         Z4SaSR4oe2xABm/wKiSiKFrnLYB0goaC+HiXL9P1iVPwakcn4KnSDpa2LfQd43vMhprM
         vPFhBM86UvRjoNDQG3yIYgHNDO8xWovjIMnuGX3NRAtjno311moZdUS/vBGLZRW0L8S9
         pftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ARrKkt2oOviflPL7roHyhtztZJejuJ2ZLjqFxYP4ERs=;
        b=italW7K3F/4Wjj1F3xYBZWXU6Z+1f3tKIPKK8HSrIZW0y29nCMEz9ZZjMNi3DXMNIG
         W66jwDdNy+VHcS2+gG120uqe/xSxAIK7AUMmCaXkjIWjwClsnA42NIxvB4e5QhZ6LmZq
         wm/wN+c/mahGMNMmOz67e00/tXQwAeAYQim02lspHc/m2SLYDSUWM2THYLixVTh6fjRK
         ybRLB8zGBog7/kK+vXaA+gnJIrwVJf6mHTph8n42zfPIlCJFDJC9r4vz6Bn1dUuaIs0B
         nlCBsBGqpQyXrz0gA5zPyTc6qBEqIPIbff1EP9nydvLXGveRut0+91Qp/I3Sax/vxYS+
         59AA==
X-Gm-Message-State: AGi0PuZbBnV95iBEGwepy4no1Zgm4Kqc5D1SxwTnVYUukL0Z3ODyUocU
        A2GkVEA9xP6MkkIEnYg7T23/Pg1HO32x228Ywzv0Jn0=
X-Google-Smtp-Source: APiQypLXTKb4KrdJ6CyHIHW3YZ8PPNOhewwCUMCiTzOcvrwtVSW1x1nM4rmZSWTW44etTYdWtKwnNQTkEMJHI4721k4=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr1002669edw.128.1588281929537;
 Thu, 30 Apr 2020 14:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <158827786575.204093.6741581954492272816.stgit@chester>
In-Reply-To: <158827786575.204093.6741581954492272816.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Apr 2020 17:25:18 -0400
Message-ID: <CAHC9VhSLLiPkbR7DgGR7uRdEPGOUk_nfyZejR0zy1i+PKiWDVQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: properly handle multiple messages in selinux_netlink_send()
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 4:17 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Fix the SELinux netlink_send hook to properly handle multiple netlink
> messages in a single sk_buff; each message is parsed and subject to
> SELinux access control.  Prior to this patch, SELinux only inspected
> the first message in the sk_buff.
>
> Cc: stable@vger.kernel.org
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |   70 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 25 deletions(-)

This has been merged into selinux/stable-5.7.

-- 
paul moore
www.paul-moore.com
