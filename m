Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D2EB64DA
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 13:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGSNMD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGSNMC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 09:12:02 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357BA113
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 06:12:01 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c4dd264359cso5231319276.3
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689772320; x=1692364320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF/3KUebfKEMFcVqd3NlzkBZfJW9MpjTA71B780j67A=;
        b=Wj5zXzzlDkmzGpAaVIOefeAcICgFpcMANkHTbs6OS+y3teAtrdG2CE57Y3OZHfXQAr
         9yu1RaB1evTttKFxhvbY3Cf8k/dJ5DJWaCiVRtZbdXEm80GHtox7coz05wzAm4fLwIdW
         J/abX5QLeRPCZAcO/ES2GVwDPPeWwAF3V/k+FbtS3hx1C4vd1bZVycr+N99asAdbfPy+
         FKykY7qnkUz0bzv0F7yNHTHFbGi3pPKRnxoe3OHtrs01qQv6EzStB3icG0KqraPPN/uI
         0WdVAK+HsTXTZF79Vn+0VwHlSbE2MxZ7SZj2+UEx8XXShlrJJ2W4SroM3re2Li37Ua81
         jnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689772320; x=1692364320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF/3KUebfKEMFcVqd3NlzkBZfJW9MpjTA71B780j67A=;
        b=DU+rP6p3GG4QQ0uCK69GJiLb2+wM31HwhZ1Y2AYL3Y8Q7e0LxtPs3HuK9YP9PmX/oy
         kzTbhOMnor0zNIczaHLtHZhebIiDrrDl6nW4AQ/dBZwUj/tn9kEJLR4BZ9FWhwUryQQP
         GVb4XxRfN5xouHUlK1ViZOu0iKXb53Ej2INcSjYDtZw4nGYg2kFZeAxS6OqOr9V9jK+0
         IrnxY+vz+7sK+PnHkwT/xcpj/0P/5o98BqrFDM6icrxCuHGlVzD1lQl9Xga44ieT4CAY
         JcXuxR01yW88veVwMmgjGAOX6ltrzjK1db7fmMfHzI9DDNXPfAs2UX5qKDc2HY2XjlEg
         LvKQ==
X-Gm-Message-State: ABy/qLYh2ahfjKtm7++2MRz5nlA25NfSb7C2sJL/Eb/QDh7lAyCx+PyM
        d3J4k+8IE2D4x3vm4u/rT+LHO6tDzJVGIICXOrHM
X-Google-Smtp-Source: APBJJlFEO11ovSUZwWl2seTdnf4HhbY0uYkY4B+QJBAtldzMeDrhPHusypSI3FLHsB9NWD45PpH90U9yZ/+xHatTfTo=
X-Received: by 2002:a25:b191:0:b0:c5e:328:87c3 with SMTP id
 h17-20020a25b191000000b00c5e032887c3mr2504610ybj.53.1689772320415; Wed, 19
 Jul 2023 06:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <73a810980a8452f0cb98d25698c4ae83285b7393.1689604030.git.pabeni@redhat.com>
 <CAFqZXNsExEo_LYHZ49kQqt677UU5HXuKDomh6Zw_gNNeVSsS-w@mail.gmail.com> <dc7c9c969e60fef73b6d67976eda5756255898bf.camel@redhat.com>
In-Reply-To: <dc7c9c969e60fef73b6d67976eda5756255898bf.camel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Jul 2023 09:11:49 -0400
Message-ID: <CAHC9VhT3Nt4MpX7j45Y=LktCmCVwdcsW8kPfqb=PXYpB_Don-w@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: introduce and use ad_init_net*() helpers
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 19, 2023 at 5:36=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
> On Tue, 2023-07-18 at 09:17 +0200, Ondrej Mosnacek wrote:

...

> > Since there is nothing SELinux-specific in these helpers, maybe it
> > would be better to move them into <linux/lsm_audit.h> and also convert
> > the other users of lsm_network_audit (Smack and AppArmor) to use them.
> > (In fact AppArmor already seems to do something similar using its own
> > macros.)

...

> TL;DR: I would avoid extending the helpers usage at this point. If
> there is interest from other other lsm's maintainers, I think such
> extension could be a follow-up.

I agree.  Quite frankly there is a lot of stuff in the LSM common
audit code that could be improved.

--=20
paul-moore.com
