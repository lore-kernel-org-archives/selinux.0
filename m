Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E9C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1AE22B4B
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LAgBXVVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgH0OYi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0OXN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 10:23:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE1C061233
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 07:23:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b17so7902428ejq.8
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9YEPTpzmo0Hc2q+e5bghuFXDq9VMQBGjmrVOYsHU7U=;
        b=LAgBXVVA/dqClCrJdDRoiXDzUaXWKWXwrdD801bYZX90HT2i5i6CB6wnc9K2gzRWdt
         qWdBv5ljH+04NmjV5/sEFARgAupmo8QC2HQtMKw+8xHWTIJsPafQytZ5+WOegEXMlasP
         HIcqbGkdGkLUDhE717yp7qHMmN+dDQnGCCbO8XSEx2D8YuxgkCafAEMRGt+OKzgl2d5O
         MNChpMM8YWIxD1aNK37qloD0/wNuMqATHWt6/CXZvgdmhOKQ3/TJQCtPHyBX5FqtTTIR
         aB9NLfHwyS9403sJNnAY30Nxv0ohoQLUlryQc1wyJrtXavArkTR26t8K0P/CQ8NAqWhX
         Edgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9YEPTpzmo0Hc2q+e5bghuFXDq9VMQBGjmrVOYsHU7U=;
        b=JXXRV4pXM09T6wzrpFyXtVehdn0rLFzVpM9e7SdRc0eA75O2tWzEi4XqREsc31aRwk
         eRR0+xy0tT8pupuRdPA1yjjB2uYvFmnywpkP42xojVYc06y9ZBAt4mgHJGW/1ufcAdrT
         ABd35PWCLLzdTv1OWYb6IMuHraf9Tq50dlxkDgwzSs9FuuqFiPmzzs6GBeFAwyjuAUYP
         a1N/+gMbaKkcMs8Owr9tTO3RX9F4iDpAl28/7hsIvsLhUHLwjXsa4wVdUDP+PuhFD2BC
         vXyBrpbqA6toPMdEdvIEsPGs3nny0n95i61nIMKCKY7NN/8RFGjSRRyN/baQHVE3wZau
         C6fg==
X-Gm-Message-State: AOAM532b1pYEZ/bdlrodjS11Ki+vGqRveWYBz5kCwpABJ5jUR/QFK+Sb
        7w2Grof52hIv1iAvzPIS+nVNgGYxVhAs4h7l1U5t
X-Google-Smtp-Source: ABdhPJyOwhPUetyVKdEMWG4X1BF6Dsl9mqJHtezUJ2RXzZAw26wUiMapZkFx5f13vPoU3tXaQYscuQOfSZxGTBH9wgA=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr20907323ejn.542.1598538191942;
 Thu, 27 Aug 2020 07:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-4-omosnace@redhat.com>
 <CAEjxPJ5HRQQprNoqe0O7M73Tk3m+kRAqutHY5Ucb-8eH-YUEsQ@mail.gmail.com>
 <CAHC9VhRf7Sb1H8sGrjo6JySegVDQB0_YviLt3NWY84Zw8fec5A@mail.gmail.com> <CAEjxPJ7+b=_koECLecPuku4fJVSZu-tQTnd5HUZRU7ogLwrhJg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7+b=_koECLecPuku4fJVSZu-tQTnd5HUZRU7ogLwrhJg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Aug 2020 10:23:00 -0400
Message-ID: <CAHC9VhQ1+CZ1jan1mGUs5KtVWhg0DmfT9zw9g-Ks0DZgpzhc5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: remove the 'initialized' flag from selinux_state
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 27, 2020 at 10:17 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 27, 2020 at 10:05 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Aug 26, 2020 at 10:15 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > After the RCU conversion, it is possible to simply check the policy
> > > > pointer against NULL instead.
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Looks fine to me as well, but it doesn't merge cleanly and since you
> > are already respinning patch 1/3 I figured I would just bail on this
> > patch and let you take care ot it.
> >
> > I would suggest dropping patch 2/3 from the patchset, respinning
> > patches 1/3 and 3/3, and reposting them for inclusion into
> > selinux/next.  That's likely the quickest way forward on these.
>
> Technically 3/3 isn't safe without 2/3 (or some replacement for it,
> e.g. moving the policycaps array into struct selinux_policy as
> suggested by Ondrej).

Then just respin 1/3 and we'll deal with the other bits later.

-- 
paul moore
www.paul-moore.com
