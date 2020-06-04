Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203F4C433DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 12:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00BE3207D8
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 12:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPUH5x7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFDMpr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFDMpr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 08:45:47 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43946C08C5C0;
        Thu,  4 Jun 2020 05:45:46 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b8so4959298oic.1;
        Thu, 04 Jun 2020 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FyB/2FD/Wz2mQVyCXr4z+abWPutppIDhAG7xkBlOto=;
        b=aPUH5x7vYLnuwZPM+GLvDsTg0raj6TtTBQwqXmnV6iE2TVlqx0i7PfPuwCnwNbxgbE
         p3N/ZYPseFZsnYRXSDb+s7RBbYobAZt/8TgjVzNkCIWpRa3rhOmJq0VVMW1zfNWy/HZF
         Puk2Ded4vmnJrYNtUtk8eRuFw5hyxLzOEpCDhVcXAtNpRSyiyNgF7VjJMXTxxJGyFHgY
         bmBmZRcmGs/pV1+7riS4hQ3a/gxwLnJksnB5HWRVesLWCEP/gIW/5qYhLIByFmMDFR8R
         pm43x1jD/BxHoIBF7kaWVtwzutOWi7f8ZDghPBJWDqH3qu7/htVNBzsZyM0CCR45aK5u
         k7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FyB/2FD/Wz2mQVyCXr4z+abWPutppIDhAG7xkBlOto=;
        b=FlF76FH7Gk8fezj5SgpszJNoY3TyL5Iy0pIIQOL/j4GEFhlKXZHXFlN1kAzgBIhD2I
         d6oKaJ2/OfUiBsZfW7nRVOAHSmT6WtPjxvEnLEup6RBEdhDHz7z2Bclx4xgHXogTiOSW
         narv3yyvV5EFdBea0uMn8Pyz+LnO8wikJVLgF9arEYOgRozDo1rmlqYOXUrTzJ6jJt2w
         8ODidT+rdVFLsp4ReexAHFh6exNwoHwj+GN/Lybr7BjA61Fn0rNyRtFFqNbg2n25r/Yn
         Frd4QOSfDTyUlwEzoJNRB4VvKiwbyO4lUFUGK5BzwGHqQ4ue9mq4cQxrwoLuXOTnGAky
         MhkQ==
X-Gm-Message-State: AOAM533g3IUQUKsP+Ko0jUcREEvd+TSDz2OA6VrpupOfBujY/eMbnPeO
        XbV+fQwPeBJ8HX9vJFs9GIfNFAImM72czH6r3gVbbVOW
X-Google-Smtp-Source: ABdhPJwfSS/2FE0F6fA/+WceOtzebYj4zrpQypLEK8cWqk6QR1F5yYab4Yu5K3BvyQiHWxguSs6LIUlLlrihhv3bPAE=
X-Received: by 2002:aca:3d09:: with SMTP id k9mr2786702oia.160.1591274745732;
 Thu, 04 Jun 2020 05:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTX8gkUui6AiTJMJgcohXa=TOqdO==rEDk=Mquz9sCNKA@mail.gmail.com>
 <CAHk-=wiAVfqtJbZ=Ti1oxSvunUvsQ_CsOL5oFJL3mwhqKTeoNw@mail.gmail.com>
 <290017a8-d943-570f-1f90-acecf1c075a1@schaufler-ca.com> <alpine.LRH.2.21.2006040809280.6050@namei.org>
 <761f5d15-3422-1834-7be5-8f3276d10172@schaufler-ca.com>
In-Reply-To: <761f5d15-3422-1834-7be5-8f3276d10172@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 4 Jun 2020 08:45:34 -0400
Message-ID: <CAEjxPJ49ownvc=3OnvkaMD-oYm-aUta98kKs4LDTJTnm65RD=Q@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.8
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 3, 2020 at 6:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/3/2020 3:12 PM, James Morris wrote:
> > On Wed, 3 Jun 2020, Casey Schaufler wrote:
> >
> >> The use of security modules was expected to be rare.
> > This is not correct. Capabilities were ported to LSM and stacked from the
> > beginning, and several major distros worked on LSM so they could ship
> > their own security modules.
>
> Capabilities has always been a special case.
> Until Android adopted SELinux the actual use of LSMs was rare.

I don't think that is correct.  Fedora/RHEL were enabling SELinux by
default since around 2004/2005 and for a while Fedora was tracking
SELinux status as part of their "smolt" hardware profiling project and
SELinux enablement was trending above 80% IIRC before they
de-commissioned smolt. SuSE/SLES and Ubuntu were enabling AppArmor by
default for quite some time too prior to SE Android.  It is certainly
true that Android's adoption of SELinux massively increased the size
of the SELinux install base (and was the first to make SELinux usage
mandatory, not just default-enabled) but I don't think it is accurate
to say that LSM usage was rare prior to that.
