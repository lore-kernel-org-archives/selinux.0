Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A74BC433FE
	for <selinux@archiver.kernel.org>; Wed,  5 Oct 2022 14:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJEOrn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJEOrm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Oct 2022 10:47:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CBD7AC02
        for <selinux@vger.kernel.org>; Wed,  5 Oct 2022 07:47:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id l5so17823541oif.7
        for <selinux@vger.kernel.org>; Wed, 05 Oct 2022 07:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lxgbHuk4hk/FCEA0EsLHQHiO28PaYggwKBV/XG3knRM=;
        b=PPEPRrlNbwXDuNQpyfC2sAW27qhbcwpLzJj4vJ0LbZB44Vxma+ztcF8qJ4RnBrNs3D
         93k/n8AoHosfaKSY2eSp+HZghm3C4nFBRqD14T4ldxisu8CCKglDjEkY7k4HD9uoGKPb
         Smr1Ha8heYYnV7KZCMGGtpidAJ33PSGTyq0kwKebl7YxIYGOu/7hbqTXTr1f2w9m7W90
         czCBmXNK9B3b5dAEoPjNm5w35zgJAEkWXhgPtx7kFi+RBJiGmmz41bQ/VGku155RKlif
         rI0Av35kG47Rlq2VDogzooIMTZlf73KWst4/ve8u+9LyWcGpfCqTKunANwtYfkmspDU/
         d2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lxgbHuk4hk/FCEA0EsLHQHiO28PaYggwKBV/XG3knRM=;
        b=aZWKJw0QGQzE+Vp/UNFxzko+7/GK3NIcaJm8r3+zRSQzYHzkt+jfzlyXWSoNr9pV0K
         c/yeML33NyHUQzZi/UbII6fYKf/gZoZk76QvebcCORukGViwN0WhjPlk5Rx5QA13hQ0T
         Ed1nuCRUIpfDJMOJkvRkUq2P/VnmFvBGYLwnYjWnc+TbYgfhHxxO3fP9mSuDmaEYz/e7
         vaGpI5wXUsv6hIIdVhn6oVRt5T/z3hnryecb97pUL8DQ2guxrPekIKUoqPhhjPFOFMCA
         roRVt/9iwr1pb5ccIWlZ7CdaCNiPxVCeaHwckw0xIKtIapXtlOIz7kpQZuHe+J3TKg+K
         AURA==
X-Gm-Message-State: ACrzQf1el8aN0keFc6rNpz1bpxXae6dob+ISntNtUC+NOcJSdI8829Q5
        fb4mbA97AKqGzcRe2z8pyxMQLC/9ZKFuQoCWqld/
X-Google-Smtp-Source: AMsMyM47qWc0eOGdmfCajsqXt5/gh7Kxz7472Rfr9n9NcSQdPtSlR/Ukibs1N65s+HoMVHmxSWlD+wjQHlVL1YUxDc8=
X-Received: by 2002:a05:6808:218d:b0:354:b8c:f47f with SMTP id
 be13-20020a056808218d00b003540b8cf47fmr68151oib.172.1664981261030; Wed, 05
 Oct 2022 07:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRNJjzGSbQgcTeP=GcUyAHTn__KDz-r02zSs-xcQFO-gg@mail.gmail.com>
 <CAP+JOzS-tit_5wLgYGBGBgWSzLvx8zDsb8mts76GsP673x9Xvw@mail.gmail.com> <CAP+JOzTHCKfzfznjyq370_BSYmmQ-dh0=sxd94C7pSdPVCh6-g@mail.gmail.com>
In-Reply-To: <CAP+JOzTHCKfzfznjyq370_BSYmmQ-dh0=sxd94C7pSdPVCh6-g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Oct 2022 10:47:30 -0400
Message-ID: <CAHC9VhRNkFapNjtKdUM+fSRqjb5KHV_t0aR_YVOuHHbdGXdiXw@mail.gmail.com>
Subject: Re: [PATCH] docs: provide a top level LICENSE file
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 5, 2022 at 10:40 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Oct 3, 2022 at 10:59 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Fri, Sep 30, 2022 at 11:05 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Okay, so this email isn't really a patch, but it does point to one :)
> > >
> > > * https://github.com/SELinuxProject/selinux/pull/370
> > >
> > > While the PR referenced above is quite large, too large for email in
> > > fact, it is that size because of the number of renamed files
> > > (COPYING->LICENSE).  The only new addition, a top level LICENSE file,
> > > is quite small.
> > >
> > > Please review and merge into the SELinux userspace repo.
> > >
> > > --
> > > paul-moore.com
> >
> > Acked-by: James Carter <jwcart2@gmail.com>

Thanks!

-- 
paul-moore.com
