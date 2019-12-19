Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED4EC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 02:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F00A21D7D
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 02:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xykzybc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLSCJM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:09:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39984 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSCJM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 21:09:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so4373301ljk.7
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 18:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpoNjwUwuLASUbxB30Xnoe1xrW5RYg+Kmb4VBQ4nnHM=;
        b=xykzybc2KlstAxIejnd9nWZiPyd00YNKX9cqCVmAcp7bkQqIxYp+iLtl394UwN34U9
         y1cGsrNT1kJhoe7Wc0JfZ/0Lw3G9g3RvdVMH4TSLLzGqg0rE37KtXPdfYGuvkj/4cCa8
         +Zx2P1nE0nASMh7jBDU1rk/xEhw8OGuFSqx1KLxZdKTHo/lYapcfMJ73ZBiU0wtjSijL
         vdjYOxB+96dltbb9uGHy9S80dnFWrkQ30Suf3dK/si2r9mTXXGg60fa8sGaSJk0+Y8KC
         k1clk1S5QGrJuNtHUw9IiVUpI+EyWdj+wv8KlCnsoTMwWAEBHJ9eX2tA8Q+gYHZojzZb
         c2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpoNjwUwuLASUbxB30Xnoe1xrW5RYg+Kmb4VBQ4nnHM=;
        b=C6uh33s+ori+3JZtE0tdGJlw5vlvgbys00QxptjDHoj7VHF7/VyHQ7UkqrfVjKYNCv
         OTGAnWgg+SZ6bmaE359RIvGIqCfV+XowXzkVdIME7V/7guWTaoy2sfjshTxUHY4IRKHF
         cDaeOb7qiA442oRAzkmuUlUmwvPjR+KYOhfdEPaKSlsG5sufUIS7BCqHLH7YOeV1SUzP
         HA3Yr8soj1+mnG4xg3Tw//YWhdCQs6o9qOcNlxS7twA8g3sREyzVrhKmqFyokbeUFc02
         y/rimdTIBqWzXMr/tipTS0q7kL2DpNQqznGleb72TNyMuVM/eV2gt9/rt++N2SFzr1Tu
         y+Bg==
X-Gm-Message-State: APjAAAWt/SgGiHBaikGRMLT4EI1kEJeUPsVP+E4yOxPRKaNyfhLa97yo
        vdwsJX5tOlBKhp8qTxQgvZcxGGZEaT7TrXf+CunpXwqNmw==
X-Google-Smtp-Source: APXvYqzUtwkqM8xWCeGeWUZv4bMEzcNYYJNjxv19Xjz4UxV7NGTM/2bNvmOadt/7GviAkbIraMH66V8J9sHRIciSSAI=
X-Received: by 2002:a2e:800b:: with SMTP id j11mr3756002ljg.126.1576721350007;
 Wed, 18 Dec 2019 18:09:10 -0800 (PST)
MIME-Version: 1.0
References: <002301d5b568$8149c7a0$83dd56e0$@codeaurora.org>
In-Reply-To: <002301d5b568$8149c7a0$83dd56e0$@codeaurora.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Dec 2019 21:08:58 -0500
Message-ID: <CAHC9VhRqsGQfO-7EYctCmcjXbPznh=+xm7OJ_oN1RLGWaywGag@mail.gmail.com>
Subject: Re: [PATCH] selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 18, 2019 at 1:01 AM Ravi Kumar Siddojigari
<rsiddoji@codeaurora.org> wrote:
> -----Original Message-----
> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On Behalf Of Ravi Kumar Siddojigari
> Sent: Tuesday, December 17, 2019 8:42 PM
> To: 'Paul Moore' <paul@paul-moore.com>
> Cc: selinux@vger.kernel.org
> Subject: RE: [PATCH] selinux: move pkey sid cache based retrieval under defconfig
>
> Yes Paul,  it should be under  CONFIG_SECURITY_INFINIBAND thanks for correcting this .
> Hope  we can taken it fwd as all the targets with disabled  InfiniBand can be gained .
> Please find the updated path for review .
>
> From 6a8c60eacd0b6e5189722bb1823864b6728c2e34 Mon Sep 17 00:00:00 2001
> From: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> Date: Wed, 11 Dec 2019 19:57:24 +0530
> Subject: [PATCH] selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.
>
> Move cache based  pkey sid  retrieval code which was added with  Commit 409dcf31. under CONFIG_SECURITY_INFINIBAND.
> As its  going to alloc a new cache which may impact low ram devices which was enabled by default.
>
> Change-Id: I80a13fb7bce8723c8c880cb77cbaee42db413a7a
> Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> ---
>  security/selinux/Makefile         | 4 +++-
>  security/selinux/hooks.c          | 6 ++++++
>  security/selinux/include/objsec.h | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c index b1a9ac9..157faaf 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -94,7 +94,11 @@
>  #include "netif.h"
>  #include "netnode.h"
>  #include "netport.h"
> +
> +#ifdef CONFIG_SECURITY_INFINIBAND
>  #include "ibpkey.h"
> +#endif

See the comments below ...


>  #include "xfrm.h"
>  #include "netlabel.h"
>  #include "audit.h"
> @@ -198,7 +202,9 @@ static int selinux_netcache_avc_callback(u32 event)  static int selinux_lsm_notifier_avc_callback(u32 event)  {
>         if (event == AVC_CALLBACK_RESET) {
> +#ifdef CONFIG_SECURITY_INFINIBAND
>                 sel_ib_pkey_flush();
> +#endif
>                 call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>         }

In cases like the you see directly above, and in the #include further
up, the kernel usually solves this by creating dummy function in the
header file.  In this case, ibpkey.h would look something like this:

>>>
/* header comments, blah blah blah */

#ifndef _SELINUX_IB_PKEY_H
#define _SELINUX_IB_PKEY_H

#ifdef CONFIG_SECURITY_INFINIBAND
void sel_ib_pkey_flush(void);
int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid);
#else
static inline void sel_ib_pkey_flush(void)
{
  return;
}
static inline int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid)
{
  *sid = SECINITSID_UNLABELED;
  return 0;
}
#endif

#endif
>>>

Does that make sense?

--
paul moore
www.paul-moore.com
