Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B26C48BE5
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B876A613B9
	for <selinux@archiver.kernel.org>; Tue, 15 Jun 2021 18:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFOSV2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhFOSV2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jun 2021 14:21:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9BC061574
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:19:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r5so28535534lfr.5
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Av+6lPQlyv+Sn6WN/JAS+BG6bGNrpjaP5opx8sV0nnc=;
        b=WQuQwtCiT/eoKl6qV5lHYx4lH+0EDr7+nOJYQ1h6yvBunl0woPiervNHkI2DWuHNMS
         q2DNf1dI8WkF30DAo2o970Na/Exs7H+KKRGluFxJ9QUdoPaAT85CHvggye+xAbjL8yy7
         H4ASmIp9BBpePbCJfnUYj3imRXf4Pc4Dds7lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Av+6lPQlyv+Sn6WN/JAS+BG6bGNrpjaP5opx8sV0nnc=;
        b=n51c4NoAwjFVsHgB+lGKEvwbT8PejIc1JtucXRnGlLh7Kk9uNfiNRkpXFv1OqjNp9U
         u9ehgOcqzKA0kP9w0xIrvEuKrsG5p23pJHnT4/G7Mz/+xxDJ139y6TZuRUVLtzkVzaRs
         c5pBsI9vsJk/cP3qVBTWJ6Pa0KH6fir+KEusjAwXuLC/r9taNNID8mXti6lz7/Bysv7M
         iUCrXeGxn5Dth6o2eT7M/FfuknXV/CUe6NLSotEWrDwUaRXLWh7McoX3liY/I5HMHE0D
         nU4Onn4bMxG+mvCv41/PV7RMQ3Tuac25ctBGU8gn/Bl5NYFkItTfDL+BnsNJ1MvvVOqS
         IkoQ==
X-Gm-Message-State: AOAM533INxdRUOHBRqaA2S3ZAndOG650e+J2wQ/B89+bno3MmDDuf4iF
        /s3e6H4RGJgd1xoQAuDovqpdfWu2/O7CrCVc
X-Google-Smtp-Source: ABdhPJzxqbIGvxoIorr6hUjfb0WlAtlfuG2DxeTXEq4ALcVEHKFEctNTbLtifMLb12sj6s1WwPKziA==
X-Received: by 2002:a19:7d83:: with SMTP id y125mr496694lfc.135.1623781161423;
        Tue, 15 Jun 2021 11:19:21 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j28sm1879989lfh.98.2021.06.15.11.19.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 11:19:20 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id f30so28560753lfj.1
        for <selinux@vger.kernel.org>; Tue, 15 Jun 2021 11:19:20 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr468018lfs.377.1623781160087;
 Tue, 15 Jun 2021 11:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210608171221.276899-1-keescook@chromium.org>
 <20210614100234.12077-1-youling257@gmail.com> <202106140826.7912F27CD@keescook>
 <202106140941.7CE5AE64@keescook> <CAOzgRdZJeN6sQWP=Ou0H3bTrp+7ijKuJikG-f4eer5f1oVjrCQ@mail.gmail.com>
 <202106141503.B3144DFE@keescook> <CAOzgRdahaEjtk4jS5N=FQEDbsZVnB+-=xD+-WtV9zD9Tgbm0Hg@mail.gmail.com>
In-Reply-To: <CAOzgRdahaEjtk4jS5N=FQEDbsZVnB+-=xD+-WtV9zD9Tgbm0Hg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Jun 2021 11:19:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=winAqy0sjgog9oEsjoBWOGJscFYEc3-=nvtzbyjTw_b+g@mail.gmail.com>
Message-ID: <CAHk-=winAqy0sjgog9oEsjoBWOGJscFYEc3-=nvtzbyjTw_b+g@mail.gmail.com>
Subject: Re: [PATCH] proc: Track /proc/$pid/attr/ opener mm_struct
To:     youling 257 <youling257@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, regressions@lists.linux.dev,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 14, 2021 at 6:55 PM youling 257 <youling257@gmail.com> wrote:
>
> if try to find problem on userspace, i used linux 5.13rc6 on old
> android 7 cm14.1, not aosp android 11.
> http://git.osdn.net/view?p=android-x86/system-core.git;a=blob;f=init/service.cpp;h=a5334f447fc2fc34453d2f6a37523bedccadc690;hb=refs/heads/cm-14.1-x86#l457
>
>  457         if (!seclabel_.empty()) {
>  458             if (setexeccon(seclabel_.c_str()) < 0) {
>  459                 ERROR("cannot setexeccon('%s'): %s\n",
>  460                       seclabel_.c_str(), strerror(errno));
>  461                 _exit(127);
>  462             }
>  463         }

I have no idea where the cm14.1 libraries are. Does anybody know where
the matching source code for setexeccon() would be?

For me - obviously not on cm14.1 - all "setexeccon()" does is

   n = openat(AT_FDCWD, "/proc/thread-self/attr/exec", O_RDWR|O_CLOEXEC)
   write(n, string, len)
   close(n)

and if that fails, it would seem to indicate that proc_mem_open()
failed. Which would be mm_access() failing. But I don't see how that
can be the case, because mm_access() explicitly allows "mm ==
current->mm" (which the above clearly should be).

youling, can you double-check with the current -git tree? But as far
as I can tell, my minimal patch is exactly the same as Kees' patch
(just smaller and simpler).

Kees, do you see anything?

           Linus
