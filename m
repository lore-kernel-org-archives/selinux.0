Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96720C2BB1D
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 21:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6702076B
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 21:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="W/qz2Sgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440899AbgDNVub (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440827AbgDNVuU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Apr 2020 17:50:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF02C061A0F
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 14:50:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w2so1735104edx.4
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2020 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h75aC48js8sKCCySKREoqNg0w2m9dpiweb5HMYIp2qA=;
        b=W/qz2Sgx8KY4IIKpyDOn4B/ruWdOXHsrsK8E4O0CqCcuXoJxG+6q5bWayuJ7iU5Q63
         77Qm5zvHIGpP7JdrHlosyZk8VKrVrBzJiSpUqrcWLYwJrYHCbVNwOGt41rnF3lLupOoH
         0mvv1uoZizrYe5rGWLjnB7muRCDBo5bAf4/C6evfGcjIMF42SvDMkKE5Ub9j5qPunPtR
         fHFl1ul85wFvt6L46gR0cASVYsEQ9gidkX4Uf5sw0xo6ndJ/aAAW68Lhn0wm7lrhiDgM
         EZ2riSRnn6cIltAUMzATpovGHEwtMsgPYBoPY7gAVEWlB2fhM4rMWxRfyhukC8g6SMlH
         5Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h75aC48js8sKCCySKREoqNg0w2m9dpiweb5HMYIp2qA=;
        b=LQz3NjkLjLrsMwmEWrgwGgOYVSyiazSXMvUQEsPuBtshhiGKMrdx/HxxnnlCR9vNPU
         EFnb2bJgP8mSkJyykhImJinKj7sIo4ri+elG2Uqmhn4yJ0js1a4sHkPo5gdLOTGQm4rr
         wxwDydI/VH1DqBvpWRlt18bekQ7fwOyWVMAGGpa0v7oOY51I2n2Uz68ngbONFKQvZCVz
         JXAYui+VG9NlSlKv7EEeDhWRKfP0N4lLSCExVxixtKVo5mMTUv3deMibfMEc1o42RrAb
         2Jteo9GKotsNq1OURXIudb197XZcG5RSN8/jRXXi7Ng3yjmRAKllnT5XeL+52OcWoOW/
         7bhw==
X-Gm-Message-State: AGi0Pub/P3TsKAQoTTGSKSnfQujf34AmgALzEmSc6paOVuNSjOXE6RE3
        8dj6eT7XRtyoSslotYpepjgxa4dIiLkmJHgYSjdv
X-Google-Smtp-Source: APiQypI0aouWfIpTGMXISh790CWaIpd+XEJQb06iJoXpKToU3h+64hy2wBTAVA4ziaAHpFhnx69qP3t5Sl8Vd25GNw4=
X-Received: by 2002:aa7:c352:: with SMTP id j18mr4687235edr.196.1586901018782;
 Tue, 14 Apr 2020 14:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
 <CAHC9VhRJ=b-dTVwgTE1TKezqY8KWoGFoHSU1XdfMNjP6uoHQFg@mail.gmail.com> <20200413204334.GA10584@concurrent-rt.com>
In-Reply-To: <20200413204334.GA10584@concurrent-rt.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Apr 2020 17:50:07 -0400
Message-ID: <CAHC9VhQuDW5FnGkjJnoNqSBPit2L27Cdda1_5ohDhyiWuDmWnQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] SELinux: Improve hash functions and sizing of hash tables
To:     Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 13, 2020 at 4:43 PM Siarhei Liakh
<siarhei.liakh@concurrent-rt.com> wrote:
> Looks like I sent you a snapshot with a couple of minor porting errors before I
> fixed them. You can still look at the patches since the errors do not change
> the logic, just hold off on compiling. Apologies for the mix-up, I'll send out
> another version soon.

...

> I've got a Fedora 32 beta box installed, so I will get some benchmark numbers
> for Linus' tree with default F32 policies soon.

Okay, once you've got some updated numbers and a revised patchset we
can revisit this.

-- 
paul moore
www.paul-moore.com
