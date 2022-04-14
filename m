Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9C1C433F5
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 22:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbiDNWHp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 18:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245200AbiDNWHk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 18:07:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506F8AD134
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 15:05:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bh17so12516365ejb.8
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ApBD2A0LwrOfDgF6j1YycOcw0oEox0Pgdq87EYw1DU=;
        b=58w8Vr+ovY+tNaNQJOVxehwy/wlezFQPDp3c9x+Ef4+hMIiozUZLBbsvlsDv0UZwcT
         G+GJ9RVJCvAhVDh+/oKXZi4S3lUCluTN89R8yYzgDnfPWX9EL0FzxBpNCGkTPU0Tgd8i
         e1pwoovuSodQ6u3yPhDCdhW+2PcaU9u3pl0TEiLlF8SheQ/iR3gc/qPVFc4nuejzOvLW
         1zKjL44dOs2GXVCDQbPQNwpIAgPJUeUEB63izEJl/RvbuWziHtAMQ9kdP+YLFrpIhGIR
         avHMAvMXi7Yzjq9exo4cneQu+i5yxg4uNOO05hstZ0kaSfFOMSsCkI9oAeLUBUfmOkgF
         COYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ApBD2A0LwrOfDgF6j1YycOcw0oEox0Pgdq87EYw1DU=;
        b=YpLa87QkbY1aLPz9lzrRHheXwa1DMGTsdEUSpfMYiJf4JSZz/xTnhpV0jlQT4KcjYC
         JeFCxpt7ePKFs3kBkIFKLCkhad9r8VmfOvLitMBnx6iKHBZoXWfsRgg4xlEw1Q6K838F
         x6RjFoZh5CD1V7qIdfm551mSSILhwCSLXEfF1925Mv1KYvhLApWvR+RfzfeBlkQSXJQX
         /lVljRLne6XuH5UaT6fQkPmfM7HVewZ/apnuq98om2nPljzF5fGn+65PPWUdlktFClJO
         SzyOXk0XWml/yPa4A4rLoAiZd3WT/2kk6luwmGz67pJ8mgrsoFQhUCzRK+ydRZkk+fbc
         tAEw==
X-Gm-Message-State: AOAM532F3mo90y8+Lkn5QwXq9GyAnMZDPJ8D/qkkAlN6ERIvGNofvH0X
        7J25Go6bOQjDauxaRfykjgxTtgCHhNIeSolRisPIMotokQ==
X-Google-Smtp-Source: ABdhPJzVVGyzXhXFvtpDq817HUHJ7Zfs4FRlcH6DbFFE3sM2uT17hZQbmRjMeH9f5WJ2FFSVFokJkQ7WMjx7WRFY4hM=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr4068904ejb.517.1649973911293; Thu, 14
 Apr 2022 15:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <164996959615.228204.13557296900347416352.stgit@olly> <CAHC9VhTm2rgrP9wRiuQFDDY2iCN=iguBeopVU0=saA=jvP0VtQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTm2rgrP9wRiuQFDDY2iCN=iguBeopVU0=saA=jvP0VtQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Apr 2022 18:05:00 -0400
Message-ID: <CAHC9VhQWBp1xffJp22KexsanEt4vqyUgbSR1LSWOjEtYXKc+fw@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't sleep when CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE
 is true
To:     selinux@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 4:54 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Apr 14, 2022 at 4:53 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Unfortunately commit 81200b0265b1 ("selinux: checkreqprot is
> > deprecated, add some ssleep() discomfort") added a five second sleep
> > during early kernel boot, e.g. start_kernel(), which could cause a
> > "scheduling while atomic" panic.  This patch fixes this problem by
> > moving the sleep out of checkreqprot_set() and into
> > sel_write_checkreqprot() so that we only sleep when the checkreqprot
> > setting is set during runtime, after the kernel has booted.  The
> > error message remains the same in both cases.
> >
> > Fixes: 81200b0265b1 ("selinux: checkreqprot is deprecated, add some ssleep() discomfort")
> > Reported-by: J. Bruce Fields <bfields@fieldses.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/include/security.h |    4 +---
> >  security/selinux/selinuxfs.c        |    2 ++
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>
> This patch is very trivial, but just a word of warning that I haven't
> actually tested it yet, so YMMV ... my test kernel is building now.

Everything is behaving sanely on my Rawhide VM, both when built with 0
and 1 values for checkreqprot, so unless I hear any objections I'll
merge this later tonight.

-- 
paul-moore.com
