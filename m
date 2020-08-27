Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7AC433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8F322B4B
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZpIcGw/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgH0OFv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgH0OFt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 10:05:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD060C061234
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 07:05:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ba12so3938556edb.2
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQDNjW9+MHKXObFpo97mLZaVQYd1cbljgSEcnZpH9zE=;
        b=ZpIcGw/35ZCkCWPbrcGY41bkJugJ/WcGmCLbPdC+uiAwPZ7Hc0KNvF2ckLkc7kaDvr
         /rCU+ACP7lJFNjEnQ3EEf4zEKLJFGu74JxqwJpDVU2och9yHaBGpJHp5i08nAqokIZRk
         EojAGj/iZAB3zPhoPMdCHiiqY0lZ61fJiNqtKqob1VPaTCn+4YOXVVZIwGsHIRVdbP+q
         9M2yjnfNeozZZjZZU5FSvokwwAiiNMzvOze7BgRCCKS/5HZonXX3SQDOTkl4UnsSssT0
         I2sVxO+1uQ5rWp0LNhbPBz6mcYVgmrU4L8024agIEclMJu1/erWDBCMzWoaQZBpbqlXX
         43LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQDNjW9+MHKXObFpo97mLZaVQYd1cbljgSEcnZpH9zE=;
        b=nOcgGnZnKay/8XFx8XkgiGjL1g+aAp3BcmRaRIK059YiDaZu2LNkG7fmuYwZDsZ+Q2
         pcPN6z7cZi0Qy3ahiZBz+Oo5Wc/t7m8fnvBwOrmarPO1AH0u6Jz+UcRHwAdb9FQqjuZ0
         WnnpDEB8Kpy4o66ECOGNMGcjCwtdRFQc1M/Sh57Wxj2h+cn9Xv+Udk/HP6JKgK9YysJt
         AGb14qEvfHsB2iQMO4BsAwbJK7wAQoq6OhOd0WH4WgLN01vihkcEkI8zMb8vgd97TO86
         h/IFZdPhl9x2MQqqF+CC07ho2DU1EITUCGWvklYdTRnGDM1eo57nUw57kLTH1KgLVmrG
         KHdg==
X-Gm-Message-State: AOAM533IPN+3Nj/00SQcviCbloi9A69HMDKWNZcb8Eh/IotyOrs9dfzF
        Uu3DNSMGhtPWY9R4yzUmF4oem4D9P/aS+4APXw/v
X-Google-Smtp-Source: ABdhPJxpDQLBgkwLTn5w6TyH0SpNQKEifIdVjRRpuZPTUjFcKHCO+zgTAaGhPexuUQsQLSGr8x3iwMkJqfGm1ISkwfk=
X-Received: by 2002:a50:f30e:: with SMTP id p14mr17148753edm.31.1598537147313;
 Thu, 27 Aug 2020 07:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-4-omosnace@redhat.com>
 <CAEjxPJ5HRQQprNoqe0O7M73Tk3m+kRAqutHY5Ucb-8eH-YUEsQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5HRQQprNoqe0O7M73Tk3m+kRAqutHY5Ucb-8eH-YUEsQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Aug 2020 10:05:32 -0400
Message-ID: <CAHC9VhRf7Sb1H8sGrjo6JySegVDQB0_YviLt3NWY84Zw8fec5A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: remove the 'initialized' flag from selinux_state
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 10:15 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > After the RCU conversion, it is possible to simply check the policy
> > pointer against NULL instead.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Looks fine to me as well, but it doesn't merge cleanly and since you
are already respinning patch 1/3 I figured I would just bail on this
patch and let you take care ot it.

I would suggest dropping patch 2/3 from the patchset, respinning
patches 1/3 and 3/3, and reposting them for inclusion into
selinux/next.  That's likely the quickest way forward on these.

-- 
paul moore
www.paul-moore.com
