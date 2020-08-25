Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427A4C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB9520738
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oSeWlq92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHYN26 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgHYN24 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 09:28:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D9CC061574
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:28:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so16557607ejc.2
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEf93p3lfUil3bz7qYG92Zs4RPftc/qRDaUGWOsdh4U=;
        b=oSeWlq92OfAwPKtU5NaojDEsG6jSIE5n3ghXcqszytETayxmofStKXtapfzVo3EZq1
         Q4+U840cjeV7hYEm9y/Kj1xv02pTHkDqeKQxqb7vGHUt1n9o057RTdu35mlGkXYq/PMb
         3zNJQgfr/oRyfwGOMNb6LJmKo86J2FH6cotPn/+193yZdpS60Reg1k38RI8lIXpAC491
         YWa+wjHyjF6wBNKG6v3mly1Ao+64sp5iEmVfeL19tGIcZOTzZXpWd1pPLYIPzIAglOxW
         +4dtKWh41hB7OEcbJGPG7HpowByW1eS1GA9hvfedx2u4weWlHkhl44RQ4M8NN8MLtkhO
         3VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEf93p3lfUil3bz7qYG92Zs4RPftc/qRDaUGWOsdh4U=;
        b=UQRJd/1QNEUK39kPgTsBTHevrmgDhcXC5FgtHOHDOUVaBCQoIjiypCMmWla+qeYXnI
         GM1igVhD+zZla+oCAwkcfZgQIhazJcqTOnxDIVlkDkIy8yaPzW72GKqZMnOL78BM69o2
         9ex2v/fdTdwctzUcghnJr0a0nroZwc4y5HqnW7cHKiRr8+bSIQTvLAuzIXEKetVVMEbi
         x8UaDdVulzO+aqkkpKyRyT+mTIeJXeHtYPQEsIPJdjfsxNdzgPlooYvKQ6KTWiRldUyN
         7yB3fVGeJ/B6dYhk9fZZWUvqKFXxZXKzU2VxPRnSIYEWU4WIN4waKSv4fFu6wHZkJKSo
         VTLQ==
X-Gm-Message-State: AOAM530SaD8i94BayvybdYqlfKpAKFA99G/Ps4KjzlpodFLoVFGOvXYL
        FmXVO3KKxMB+gkxG9OMQklOI7Vb2R7+h0TGCsQmV
X-Google-Smtp-Source: ABdhPJzkhY/bn4cvl5LHUvIur9wCHeWdcuueEXI2z17mAkp5FTsEuGYtQato3cstl09kkCj8ih9evt3MINsnTRxE44A=
X-Received: by 2002:a17:906:7c46:: with SMTP id g6mr10284492ejp.178.1598362134973;
 Tue, 25 Aug 2020 06:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200824113015.1375857-1-omosnace@redhat.com> <20200824113015.1375857-2-omosnace@redhat.com>
 <CAEjxPJ6sTB+SCKQFg=4uMHMih1gAnCTYdcPUJ=FGMpYZwYYo5Q@mail.gmail.com>
 <CAEjxPJ4j3+C0tCCuMPc5a8Y9-Yp=n3Xc+217OkNV7i=CC6P=Uw@mail.gmail.com> <CAFqZXNuMP+BJBPLLRd6ir8txvvKJAT1ryRkJQQjNOyhtq2uFhw@mail.gmail.com>
In-Reply-To: <CAFqZXNuMP+BJBPLLRd6ir8txvvKJAT1ryRkJQQjNOyhtq2uFhw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Aug 2020 09:28:43 -0400
Message-ID: <CAHC9VhS+444Q8U73bMVOkhBjhfQ2exau3y19mPykoi5xE5N+XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: fix a race condition in security_read_policy()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 9:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Oh, you're right, there is really no race condition thanks to the
> mutex... So this patch isn't necessary then, but the second one should
> still count as a simplification (with an updated commit message). I'm
> fine with merging it into the RCU patch(es) if you want to do it. Or
> I'll just send a rebased version if they get merged in the current
> form.

Yes, I think we can drop this patch, but as you point out, I think
patch 2/2 would still be nice to have even if it isn't strictly
necessary.  If you rebase the patch on top of selinux/next and update
the description I'll happily merge it.

-- 
paul moore
www.paul-moore.com
