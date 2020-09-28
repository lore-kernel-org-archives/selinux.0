Return-Path: <SRS0=s25y=DF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BB5C2D0A8
	for <selinux@archiver.kernel.org>; Mon, 28 Sep 2020 13:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735A720759
	for <selinux@archiver.kernel.org>; Mon, 28 Sep 2020 13:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZh72gSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgI1Nlq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgI1Nlq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Sep 2020 09:41:46 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76FBC061755
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2020 06:41:45 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id h8so305054ooc.12
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2020 06:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=af/XUkXwCAYCpTdG62Dd/wVllC7/iQtupowFn0yKDpg=;
        b=GZh72gSRtoFG/W6oqUchEk7Dt3fCJcBveozYeqKx2U4lRpdzPHk610n/JhkE8fWW3C
         FmTx/VkXv+ddIhN53SBYPB95TBLt5+g3IJBRp0E/JMWFWFfvhoZIZI44kzW7vvXs04MR
         s6OrOQ3YIGeMa2Z5OTsC0m5vbIKw3+GWQf2Oux9E355vmWfcvzQyQY760//28qJwV6Kz
         4Krfkd/Kk8rZCjT1qAsQE4t6cKgX8eFLBbbp088UiEKXOb2JeHgCFhphCq+30tWEJnGW
         MK3snK6Gy68hZM6DwjHPVrHHGUFcRMUbgNCyQNUhG+bIPcZ6aA1Co8L/wI4yUTi4TOKZ
         gxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=af/XUkXwCAYCpTdG62Dd/wVllC7/iQtupowFn0yKDpg=;
        b=ci+VCrhraqoReVyc+9nMTc1Z6CpoaSOsH+wPnBAxwnj00kM2uYNeKDj7661XBE3Vct
         03w5A7X84qtlrT9ySeXgbeVrxz2iGCaCYdCUUJjVk7nFJNrFyAIH8zLwGhbmeXYvj7g+
         +98fEi6WyefCxudvCh42KWkY/kYOLpHSiJLJHqKa+mh/uNWIzqsysoTEIWLXFx2H91WV
         SXr2xJicSEnJth7I1ue00ajcPOmo4P3eG9dcKwoOPCIWxPGGKL1adwqmiXqMzrdxqJs9
         vOhBnobji1Um5J/lAvQBhCtGQX4SDy3OEBrne1WCTWZpyzhxdvxAbUguYaVpjyrGe30Z
         U7xA==
X-Gm-Message-State: AOAM531SWLjbFXTxYzsKRiBaiOfB4MMT01Om+YGvXD4tEmPvt2wzd6YX
        1B4bLYNp9waiCb/m1RFGO706QDw1Pj6Z66Rjh4uWdKyb
X-Google-Smtp-Source: ABdhPJztXe7vHrdpi1/omSt1kDIPiHgnbGA7g+XqB62qk5jUrfyDr5MPhJdrxPsV/Y/ITJgdn6MZDTQQN04BtvO5fMQ=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr881338ooq.13.1601300504553;
 Mon, 28 Sep 2020 06:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200927094243.43673-1-rentianyue@tj.kylinos.cn> <CAHC9VhSKDtp_YoNf=AopcxF19bp=WZsx7hR1rRb6gVPaUTeuRg@mail.gmail.com>
In-Reply-To: <CAHC9VhSKDtp_YoNf=AopcxF19bp=WZsx7hR1rRb6gVPaUTeuRg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 28 Sep 2020 09:41:33 -0400
Message-ID: <CAEjxPJ4Oa59q=LvdZhrjpGL3zQv7-qJthJQaSt=GQnE35MjA5w@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     Paul Moore <paul@paul-moore.com>
Cc:     rentianyue@tj.kylinos.cn, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, yangzhao@kylinos.cn,
        SElinux list <selinux@vger.kernel.org>,
        Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Sep 27, 2020 at 11:24 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Sun, Sep 27, 2020 at 5:44 AM <rentianyue@tj.kylinos.cn> wrote:
> > From: Tianyue Ren <rentianyue@kylinos.cn>
> >
> > I think there is a error initialization for isec->sid when the dentry is NULL,
> > when we do "remount -o rw,remount ${rootmnt}" action before selinux policy loading.It's
> > leading kernel getting wrong security label "unlabeled_t" when the userspace access
> > files such as /etc/fstab.
>
> Out of curiosity, can you provide some background information
> regarding why you made the decision to remount a filesystem before
> loading the SELinux policy?

And where is the original message and patch?  I didn't receive the
original (just the reply) and I don't see it in the list archives.
