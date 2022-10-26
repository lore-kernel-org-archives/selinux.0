Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B2C433FE
	for <selinux@archiver.kernel.org>; Wed, 26 Oct 2022 20:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiJZULp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiJZULo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Oct 2022 16:11:44 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13450119BE7
        for <selinux@vger.kernel.org>; Wed, 26 Oct 2022 13:11:44 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-36cbcda2157so103090207b3.11
        for <selinux@vger.kernel.org>; Wed, 26 Oct 2022 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s+yB9JWzLCvOQcp5Rtm+NpUgpVIhpMOKoZ5axYcO2dk=;
        b=SZFYjlAgl6qWr9aT58Drcf74EJ5wIPZy4fCJjF4F6FbVuOoluVEJEFPooRotvTZ1kx
         9hVzhaJtau2ugy5E72gcbrqL5+rZFkgxQvEBBC/8+vdTXwyECmtBHFauTFx5oTFHaAiP
         upRfDmAkfJXsOnK1Wv9LJAosuGmF9ehGUqvs4SsZTwU9L/sMoJU+88+nVQe+hEgAy9kw
         Plk1049c48W957UJ688Gy6w7ubcbN76AS/cmGQGiTjT6126QIcyx5wuj91Arc9qKJHq6
         CfyJbzFwu7PP05K4HbBI61yG+bL7nb+ck/YogQVWLYOi6vS4QcFDPQlbLqlw77XzaQrr
         BE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+yB9JWzLCvOQcp5Rtm+NpUgpVIhpMOKoZ5axYcO2dk=;
        b=sJuvSyJZCXC0sFpopbrOKO/H3eUHSDm9hC2YZcCowlMG3S9BCsctUIXEr5PvvTmWT1
         xfOjSvx1IRXrtiDvo4n2K5apWKMkQYRm0qihet0ycg03clETkYRpLt4MB5AttKA24yzN
         VmBcls2+6KdCg9AQ9emr3V/G6yI+ASjLyLEzhuzfZwNM7Sl6x/ZL2mfH45Zc6lhiooxc
         c3t9LYZqpQi2t3s1W1/n17g3Rt+93Ugqw0HeOhX9OPWAQuJiaDGmRDhHvUAAXbDnGQSg
         mWrAaTXsmsH2MVxoDd5+vCmNNHy61Imdq67Lp9fK9Gdi3vJUAea3hjqnyxZ/s1d8ZOcS
         Hfsw==
X-Gm-Message-State: ACrzQf374euknFqoPYUNzBtEtDurDL+s7TnxJ3WLLkHdocY5JQ4KP7AM
        oq1hhhy/R5cqMOV1t/Ka/S74aYXDzt/LxB42nN1JdqICO+ZS
X-Google-Smtp-Source: AMsMyM6lmq7EnEcaLyRqwHwy7n/ne2R70IePENv0WDRopqrTSXpsR3RkipltXX/iojSZXiX0U1hMMO+moWlUxiEg2Xo=
X-Received: by 2002:a81:f87:0:b0:368:e612:2dc with SMTP id 129-20020a810f87000000b00368e61202dcmr30774776ywp.244.1666815093067;
 Wed, 26 Oct 2022 13:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com> <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com> <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com> <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com> <e9ce6253-c8a3-19c3-1b71-f3a2e04539bc@I-love.SAKURA.ne.jp>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com> <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com> <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com> <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
In-Reply-To: <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Oct 2022 16:11:21 -0400
Message-ID: <CAHC9VhQy91eezWMQ=MoLe3fQSu_Rc+ZUWW2Mm3+78Mr7vS_Z0A@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 25, 2022 at 7:20 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2022/10/25 19:26, John Johansen wrote:
> > no, Casey is not. He is trying to find a path forward to get LSM
> > stacking upstream sooner than later. He has made proposals that
> > admittedly you have not liked, but he has at least tried to propose
> > ideas that could work within the insane set of constraints.
>
> I'm OK with getting LSM stacking upstream. But changes made based on
> only built-in modules are bad. If LSM id cannot be assigned to loadable
> LSM modules at runtime because not all loadable LSM modules will be
> in-tree in order to get an LSM id assigned, loadable LSM modules won't
> be able to utilize e.g. lsm_module_list system call (or whatever
> changes made while trying to unshare resources/interfaces currently
> shared among SELinux/Smack/AppArmor).

As a reminder, the LSM layer, just like the rest of the kernel, has no
plans to provide any level of consideration or support for out-of-tree
kernel code.  LSMs which are not part of the upstream Linux kernel are
not our concern here; if they fail to work with the syscall and/or LSM
stacking changes merged, that should not be considered a blocker to
upstream development.

-- 
paul-moore.com
