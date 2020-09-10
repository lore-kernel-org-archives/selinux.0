Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19824C433E2
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3932075B
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mj1ksRYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIJVZe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgIJOXK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 10:23:10 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6FCC0617A3
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 07:11:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w1so6484553edr.3
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqER1n/S/bVapO+RyrM1xxWOQKbNzVguXbfv8iwgPWk=;
        b=mj1ksRYlYZoHO7kIpCwr5VKl8QULoy2ghTj3LYS/kfji3j2CawjoMCGn42zS79XNRh
         WnAI5fHo5s/8DNoLXqOv92dWpYX5paf1rXOWMU60tkmXsWATdO6Pw4W7TVAV2Tt6gLBw
         fMahCQYUhQ0eGLb3crDNL0DixDC2fR/N9X7QyM/1+bRWkSC1gO1vqbsQMv+cIL/bd5Zk
         UxjIAtIySJgzO8XbV+0+BGxHgqrGrETxylsz7OmcMjO7wbExWp2bcEV97VSNj80I5Vyz
         Bqdvy09ZzA21IET4hSfY4IoRwccGy8h8N4SBVhYpRHEEd0rl8X1PS/VgM+Tlx/+Uf7z+
         /PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqER1n/S/bVapO+RyrM1xxWOQKbNzVguXbfv8iwgPWk=;
        b=gHfe1dnyA2RA02eCRjX+bLvgldWEBp7vvQCZOfUzFcOL8HXV/GBVNlaWSBijGNh4gS
         sl4R7IDfUXL/Daz2IIAi1zR/7sbluvcysqC2EdO7TVTpvVn5O7K8sD8AA4idSn1yH4Hc
         PCTjFNXLBl/6BbyzVmm/Ia1OE9RpoLlatcg0/BBgWEftJWDwWCZSxi+p0NVxduWMPPVA
         HwO/hGoXsvV0ma9oEdlyEXVO6vtq70/r7gNAe/CtL42Zn5010xX8l7/dSC6jLT8Z2eNz
         0LUeZ+gtQ0r7XGHI2Sw+9nWMefgGlUkZtKCIyrIbSnXW7v0qdMfoJHxdeTrwvlJidUjW
         Dpfg==
X-Gm-Message-State: AOAM533KTu8WWfwTcGdjGQ+s5s5ZkaFTK33f6gKjvN67fx20a7kPd0Js
        zFQuYSY2gkqwQM5lnpVz0b42yTWvTnxTHQDv+Rt9
X-Google-Smtp-Source: ABdhPJy1FTJ7DXFJo05WoW+t4O9pZDdDoW4TpXiv609ezJYlL+41ua8D4GnLvm80oWsYted6RRcGfRiYYQPB685hrWg=
X-Received: by 2002:a05:6402:1805:: with SMTP id g5mr9107156edy.135.1599747084327;
 Thu, 10 Sep 2020 07:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com> <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com> <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com> <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
 <585600d7-70fb-0982-1e6b-ffd7b7c33e32@schaufler-ca.com> <9a58d14c-eaff-3acf-4689-925cf08ba406@canonical.com>
 <CAEjxPJ7i5Ruy=NZ+sq3qCm8ux+sZXY5+XX_zJu3+OqFq3d_SLQ@mail.gmail.com>
 <CAEjxPJ5KudgTjhmXBNdCO_ctvioy5UA5PXcoKX4zc19NYKgHZA@mail.gmail.com>
 <c5bef71e-6d78-2058-bcaa-8497c76d7375@schaufler-ca.com> <b320f0f6-02db-95a5-acc5-cadd5dbb57dc@canonical.com>
 <CAEjxPJ6wFJz935RR_1u+-EjAw3VMv4nabo-Za_OqkZGJuNS5Sg@mail.gmail.com> <b67799e2-fa22-2890-698d-f410913b0c8a@canonical.com>
In-Reply-To: <b67799e2-fa22-2890-698d-f410913b0c8a@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Sep 2020 10:11:13 -0400
Message-ID: <CAHC9VhRMubBNRNRKSLWrQw9nGZFX1G96+8EZzaG69OHWvZaJoQ@mail.gmail.com>
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     John Johansen <john.johansen@canonical.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, linux-audit@redhat.com,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 2:47 PM John Johansen
<john.johansen@canonical.com> wrote:
> ... For now Casey can drop it from this series.

As long as that whenever it reappears there is at the very least some
note of the limits in the commit description and the code (via
comments in the struct).  Of course that assumes we can't find an
alternate solution that we can all agree on which doesn't have these
stacking limits.

-- 
paul moore
www.paul-moore.com
