Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221AC433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 00:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD6420789
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 00:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Mnpy/k74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHRArF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRArD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 20:47:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E00C061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 17:47:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cq28so13875761edb.10
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKXVzagpTSzr/+kMog+4S90lFYs3KmZKSvHQ0ANuY30=;
        b=Mnpy/k743ZSY+FZOi35YzmZphNANsjkynEVdMlYn9gYAR3pO5UpwMYfMT8E1GDz9Su
         zPWh6cmhxvZBnyd7/qBi5qURGsgHq2UrA29O6OLr3DphTP2pJtMNQDN3+/KpVvPUZ0GE
         4L7nCll85qC93H7+nPB4fgRxEHEqIDvtHSyLu9MZfzE/0vdbh+VI64uR+9AIwiNqLAG6
         5XBbUH4Z9+WNFn3xVcC+a948oQgdK+7NK+44nc0g3hapIfYAoDDEVEVx2V6nhlcdqlNT
         1TO6iAno2DcL45vZVrd+r3xeJqbqF1K0rltD2Dmfh72FsCJ/FRBeXkS4qoohb9flCJSm
         Yfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKXVzagpTSzr/+kMog+4S90lFYs3KmZKSvHQ0ANuY30=;
        b=tHl8ZoX0S2O6G7NJIISfISZUwsf3zApuMM1q8ZFdvgnGPACLVElwJBYFrknh7Vvbb4
         w4BlwmRrfPC4g+Ci23/WyhHVA6n72Iy2oeY1et40/05IEqtDbMBxhWPkP5yaV3W9AjYU
         iRke6oNOLHXw1lhXBlhZH+O1w7k0DuIo6jnLBrgt9EC7IHhDTbrvghNk3hFib1zxgDEA
         cJgssmirU38+PlwgztD/xlUdrjc6Ybkq3YJRgNHoFkUWK18/dEYoBWG81m+h+hHFD5Vi
         T0bjHbRaeHRxMlYtxKtCu8rkexcbEDChN7Id6q+qCilHgl/l6wpUqPyth4TKBHUv+lhY
         jwnw==
X-Gm-Message-State: AOAM5327fbg0NwO/syUSYqfLMSs1JHCI1jxImBIGzVFomqxoVBnNCtcB
        g0iYwjm+zTQocHY0GgsXGxnDd879/eY4574tDzKV
X-Google-Smtp-Source: ABdhPJwlRCtlWn4Z3DlCFlBqWFS+TnZOh9HxjJ+/+PkW3w/GJSuaKFzOcddN0Mh6eIM7fZvbNznqQ3PhcNKSvB+ZBTs=
X-Received: by 2002:a05:6402:3070:: with SMTP id bs16mr17221237edb.269.1597711621941;
 Mon, 17 Aug 2020 17:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200806183418.50128-1-stephen.smalley.work@gmail.com> <CAHC9VhS3Kp0c+gJrrg_U5dTKmx7XJoVsWOgY+J5p97UzepgC2g@mail.gmail.com>
In-Reply-To: <CAHC9VhS3Kp0c+gJrrg_U5dTKmx7XJoVsWOgY+J5p97UzepgC2g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 20:46:51 -0400
Message-ID: <CAHC9VhQoqv=N0S1fYGJEO50RTY3YrcZ++eRWym-t9enK_jfj7A@mail.gmail.com>
Subject: Re: [PATCH] scripts/selinux,selinux: update mdp to enable policy capabilities
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 6, 2020 at 11:46 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Aug 6, 2020 at 2:34 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Presently mdp does not enable any SELinux policy capabilities
> > in the dummy policy it generates. Thus, policies derived from
> > it will by default lack various features commonly used in modern
> > policies such as open permission, extended socket classes, network
> > peer controls, etc.  Split the policy capability definitions out into
> > their own headers so that we can include them into mdp without pulling in
> > other kernel headers and extend mdp generate policycap statements for the
> > policy capabilities known to the kernel.  Policy authors may wish to
> > selectively remove some of these from the generated policy.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  scripts/selinux/mdp/mdp.c                  |  7 +++++++
> >  security/selinux/include/policycap.h       | 20 ++++++++++++++++++++
> >  security/selinux/include/policycap_names.h | 18 ++++++++++++++++++
> >  security/selinux/include/security.h        | 16 +---------------
> >  security/selinux/ss/services.c             | 12 +-----------
> >  5 files changed, 47 insertions(+), 26 deletions(-)
> >  create mode 100644 security/selinux/include/policycap.h
> >  create mode 100644 security/selinux/include/policycap_names.h
>
> Seems reasonable to me, but obviously needs to wait until the merge
> window closes.

I just merged this into selinux/next, thanks Stephen.

-- 
paul moore
www.paul-moore.com
