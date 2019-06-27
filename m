Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356AFC48BD6
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 03:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0202720656
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 03:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+Pxu4J4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfF0DvW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:51:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34186 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfF0DvW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 23:51:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so362756pgn.1
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 20:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wFwQn/CCk/+bX2Fy3Uf/AfjAV0pQZ7WVrQfe+LHHx8U=;
        b=W+Pxu4J4A9ig84/8Xr4HjOEoUDgqNTrz1d9NX8PeOiqAi4q+G2To4dsqAG/U7jvS88
         8yv0aR4lA1/pFjtO8Ugo1LUu/Kqvxduc3GACLIiwQYBgeVYPgjHGIdoTh745CUVLqhCO
         Tg053pntOUvpR2G86x+LH7Qei1Dsj1lKb7v78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wFwQn/CCk/+bX2Fy3Uf/AfjAV0pQZ7WVrQfe+LHHx8U=;
        b=F4rxkPxLNMosC6JarP6iSR4yz6a9IOuoa8JjCi2nAAiyYgorJi/QQIlk1k2cw1eLLP
         iR9oM23OK9cTue3btC6DO8xjkZpEV8zVdowO1+htzYDkbB3fAL/9he3hEkNnIpXg5sfn
         MPuEusbm2EP+0wOFgpyqSw5YcfutAfhtx4O8+flgKG+YeNEiBlUCYASZ5OtE/+7/8rx6
         m75BjJSseXSN2KgB7p3LiHJnZk9VlYoLnQSJ++rCj7nvOnKuu1D1MqircQxSaPZsrOG1
         a5JbB2Oy+/Szq2qE7BpLU1plhbh0nkUPgJaexRK51+Cd3RRLuZ5BTyO6Rul8sbVVyePh
         FRbQ==
X-Gm-Message-State: APjAAAWy9KbC0+2zKssuwXmE9RFXbRLItSxehcehGGumHQ4wI2QF5yhw
        hvNMe7Je/1u2ziBu0Dlky4dIBw==
X-Google-Smtp-Source: APXvYqwUMAZtNsnrnS6AaN7w0wXnR8EzL3m8jxC3H/RiWWKu94d4WxWPSeoQo7t5STmKnRmfYhgDtA==
X-Received: by 2002:a17:90a:208e:: with SMTP id f14mr3295762pjg.57.1561607481819;
        Wed, 26 Jun 2019 20:51:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 27sm555045pgt.6.2019.06.26.20.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 20:51:21 -0700 (PDT)
Date:   Wed, 26 Jun 2019 20:51:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
Message-ID: <201906262034.B17D2C5@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <alpine.LRH.2.21.1906271230490.12379@namei.org>
 <alpine.LRH.2.21.1906271245210.13254@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1906271245210.13254@namei.org>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 27, 2019 at 12:46:01PM +1000, James Morris wrote:
> On Thu, 27 Jun 2019, James Morris wrote:
> 
> > On Wed, 26 Jun 2019, Casey Schaufler wrote:
> > 
> > > This patchset provides the changes required for
> > > the AppArmor security module to stack safely with any other.
> > 
> > I get a kernel oops with this patchset when running the SELinux testsuite 
> > (binder test) with:
> > 
> > $ cat /sys/kernel/security/lsm 
> > capability,yama,loadpin,safesetid,selinux,tomoyo
> > 
> > 
> > [  485.357377] binder: 4224 RLIMIT_NICE not set
> > [  485.360727] binder: 4224 RLIMIT_NICE not set
> > [  485.361480] binder: 4224 RLIMIT_NICE not set
> > [  485.362164] BUG: unable to handle kernel paging request at 0000000000001080
> > [  485.362927] #PF error: [normal kernel read fault]
> > [  485.363143] ------------[ cut here ]------------
> > [  485.363581] PGD 800000044e17b067 P4D 800000044e17b067 PUD 44b796067 PMD 0 
> > [  485.364226] kernel BUG at drivers/android/binder_alloc.c:1139!
> 
> It's this BUG_ON:
> 
> static void binder_alloc_do_buffer_copy(struct binder_alloc *alloc,
>                                         bool to_buffer,
>                                         struct binder_buffer *buffer,
>                                         binder_size_t buffer_offset,
>                                         void *ptr,
>                                         size_t bytes)
> {
>         /* All copies must be 32-bit aligned and 32-bit size */
>         BUG_ON(!check_buffer(alloc, buffer, buffer_offset, bytes));

Before:

        if (secctx) {
                size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
                                    ALIGN(tr->offsets_size, sizeof(void *)) +
                                    ALIGN(extra_buffers_size, sizeof(void *)) -
                                    ALIGN(secctx_sz, sizeof(u64));

                t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
                binder_alloc_copy_to_buffer(&target_proc->alloc,
                                            t->buffer, buf_offset,
                                            secctx, secctx_sz);
                security_release_secctx(secctx, secctx_sz);
                secctx = NULL;
        }

After:

        if (lsmctx.context) {
                size_t buf_offset = ALIGN(tr->data_size, sizeof(void *)) +
                                    ALIGN(tr->offsets_size, sizeof(void *)) +
                                    ALIGN(extra_buffers_size, sizeof(void *)) -
                                    ALIGN(lsmctx.len, sizeof(u64));

                t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
                binder_alloc_copy_to_buffer(&target_proc->alloc,
                                            t->buffer, buf_offset,
                                            lsmctx.context, lsmctx.len);
                security_release_secctx(&lsmctx);
        }

Which changes the "src" and "bytes" argument, assuming the size
calculation for buf_offset is the same. But, a quick shows:

-       char *secctx = NULL;
-       u32 secctx_sz = 0;
+       struct lsmcontext lsmctx;
...
-       if (secctx) {
+       if (lsmctx.context) {

lsmctx.context isn't being initialized, and it was passed by reference,
so compiler won't complain. I'll find the patch and comment. Totally
missed it in review!

-- 
Kees Cook
