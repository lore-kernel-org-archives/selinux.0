Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98764C00140
	for <selinux@archiver.kernel.org>; Wed,  3 Aug 2022 02:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiHCCdo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 22:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiHCCdm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 22:33:42 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7341EAC0
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 19:33:41 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10dc1b16c12so19360765fac.6
        for <selinux@vger.kernel.org>; Tue, 02 Aug 2022 19:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=A6gftZrcUdueQmKWdeTE1pp+8j/wkTp6MNQ4hN4qL2Y=;
        b=0gOmKY/DXHFbApK1fX2d/gE+w0U9FEQi3IOF9IC7iJhQrc8zrEwYAkzZomAQhpnBfn
         7e2MdLaABK2zOcUDZAwxEH6umf/RntAlP7Cn8pEAt1dpNDFgV4Zj+w0RxWMbg8j8hIhN
         Jd5KxCWU4QzO2kYrcRz+z58+rpHLxtHS4GP7KR93WIb+V19+qQ97BmxGbBXiKPaZDWP0
         80MRJnU7NxaEtFVHYN50VHbAjclqG7yQrPmmEN0t2xe99//Z+i9jDR3laRYEO9USJCPz
         Sg/I7bB2CP6digOrlzxv4J7ihYWVKiIir2TV5tq9l5KLC5t4UMlBZ65Ndu0Dn1tZuhCl
         w8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=A6gftZrcUdueQmKWdeTE1pp+8j/wkTp6MNQ4hN4qL2Y=;
        b=1+aiwLjMYeZnXfBCrttactQezXDst5pFQX9+0RsLbxBG23DzhttW4GwRzWS5iet43f
         qeEvgr8aQ87+562bVSKnf0JkYlxby7k4g7JFB3GZCEHtwUZNtFxZf2/UYiyd026g079B
         i9TBlxYLpyqERB+F3zBBNL4+JXQz8H2QrpSBLiTEbWSzzzq+j+J9DkkYQOiiX8A3xfwU
         H8T9uvtXm9AJkw4zcThvlG7T4iaNXbLKtfXNaaNHQiLQn2sHonT6BT6YbnQsmMnREmgn
         ZWwi4AWJnDZOjYCT3yCM7Z3+81V29HWqPjCTlCOi2KNrhgEJzVfxgNkmLL5qfMHX6SoG
         H57w==
X-Gm-Message-State: ACgBeo1f3xrixGzNB1BlfXqcZkbP6pZCGDLEW/+377OXddwkw+YT5gJE
        T3JBJeuomE4E3Ffzdz6EYc1OtA6m5Fz38uGtaDym
X-Google-Smtp-Source: AA6agR7V9272OqR7+vcNI0x2j6crLxhlP9fCQynwUgBy1I/QIMbooxN3LBVlLTFHyodt4VK0wMAGDhLuZd5vjlMdycs=
X-Received: by 2002:a05:6870:b40d:b0:10b:8586:9d91 with SMTP id
 x13-20020a056870b40d00b0010b85869d91mr1071626oap.136.1659494020938; Tue, 02
 Aug 2022 19:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <d54b304b-ac52-7bd8-5444-334cad48bfac@schaufler-ca.com>
In-Reply-To: <d54b304b-ac52-7bd8-5444-334cad48bfac@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Aug 2022 22:33:30 -0400
Message-ID: <CAHC9VhTY=ek-U2pvQHjZ27Vd1S-wHH0p6GepAV2kJuvnM17=uw@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 2, 2022 at 10:15 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 8/2/2022 5:56 PM, Paul Moore wrote:
> > On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> I would like very much to get v38 or v39 of the LSM stacking for Apparmor
> >> patch set in the LSM next branch for 6.1. The audit changes have polished
> >> up nicely and I believe that all comments on the integrity code have been
> >> addressed. The interface_lsm mechanism has been beaten to a frothy peak.
> >> There are serious binder changes, but I think they address issues beyond
> >> the needs of stacking. Changes outside these areas are pretty well limited
> >> to LSM interface improvements.
> > The LSM stacking patches are near the very top of my list to review
> > once the merge window clears, the io_uring fixes are in (bug fix), and
> > SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
> > and SCTP stuff can be finished up in the next week or two.
> >
> > Since I'm the designated first stuckee now for the stacking stuff I
> > want to go back through everything with fresh eyes, which probably
> > isn't a bad idea since it has been a while since I looked at the full
> > patchset from bottom to top.  I can tell you that I've never been
> > really excited about the /proc changes,
>
> I have been and remain perfectly happy to do something completely
> different provided it works. The interface_lsm scheme as implemented
> is horrible, but it's better than the half dozen alternatives I've
> proposed. At least no one has pointed out a use case that it can't
> satisfy. I take full responsibility for mucking up "current".

Yes, I have no concerns around your willingness to do the Right Thing
Casey, whatever that may be :)

-- 
paul-moore.com
