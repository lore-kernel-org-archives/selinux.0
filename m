Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1169C433E3
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1AD2177B
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+AJ0km5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgH0OTN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgH0OR7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 10:17:59 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEE7C061232
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 07:17:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n23so4483066otq.11
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWcw1B4eNgxoWY3cv6SJu4bbCpzNhmCiXWTVE6GEeSA=;
        b=r+AJ0km5jkNFb4Si9/6XbYLElN5J3RZl1XyleEBkO1UtRp4nERpXSD1gx8EzGSHtoY
         LPL2MJauscTyqBupaIkXlDUX2uZITYFZ5tPvXb4OmQcrm1MuiNZdLgKW8WsBGoZbwUCY
         6lav2dE8QZdgWURQ/cE/3GFE6HT7kGFtE96fBOImAxleqxZkXdRq2wdt31NeLCakZ/UO
         ySWL250xNjspdwfSMoxcoQMHcmx9OFZ4v2McaLojGmRGkwetPMaMNtKfRd1vWnVvjPD1
         Zl52ZTsVbGHgknGbMYZr3mH8ml3VsSIszLdV/60SS1/I14B5ZPpM2v02iKCIiiEOOH1A
         zF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWcw1B4eNgxoWY3cv6SJu4bbCpzNhmCiXWTVE6GEeSA=;
        b=p4v0oStfDTVxDdWNQ1wGXFcpM0ShSY2zidh+xMjaFXovR+8NAPMtUHQ+UVwwPMHleL
         ikITE7j82wK+8bxeHtyGUYWtl2I8aQ/OEr1Hvlam8vluFrxRS9n3YHX2CekNQysAQgWb
         UPtKMLIRmwuvpnuVs2v02J26fCoK2KHJRzajvkkDAMWTy5pVS35CbTMzd8lXHyEKmMHZ
         srlf4ODcU/qUkSpNFHWOs6/XFHON4nViUOkIrvShDL23EYfmcOnx+QKw9ed4HlAafIyK
         bMwqEPrbjyPpfs+km6LU3FmbzhcY+/Itt/d+Uln59zMmzToPmmgs0hFijtIn9wfuSoqW
         /Mdw==
X-Gm-Message-State: AOAM532Ix1UVzAQMsOysrs4el7mPEXhU7rAPHv0VhTJnQKo1vt+Et9Ul
        00oVl4Ncvt7OfrPxUh6aSNn2UXZ+67WxsrXdnxs=
X-Google-Smtp-Source: ABdhPJyHXe9dE1qEKOxmLeaQUbb6LlpaVeVuL3pEL5dbFa8X2I7vVkz3XqF6GZOVaQ0qDkCl17hfGnwsbkM0pxH6xA8=
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr4845767otp.162.1598537845728;
 Thu, 27 Aug 2020 07:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-4-omosnace@redhat.com>
 <CAEjxPJ5HRQQprNoqe0O7M73Tk3m+kRAqutHY5Ucb-8eH-YUEsQ@mail.gmail.com> <CAHC9VhRf7Sb1H8sGrjo6JySegVDQB0_YviLt3NWY84Zw8fec5A@mail.gmail.com>
In-Reply-To: <CAHC9VhRf7Sb1H8sGrjo6JySegVDQB0_YviLt3NWY84Zw8fec5A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 27 Aug 2020 10:16:16 -0400
Message-ID: <CAEjxPJ7+b=_koECLecPuku4fJVSZu-tQTnd5HUZRU7ogLwrhJg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: remove the 'initialized' flag from selinux_state
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 27, 2020 at 10:05 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Aug 26, 2020 at 10:15 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > After the RCU conversion, it is possible to simply check the policy
> > > pointer against NULL instead.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Looks fine to me as well, but it doesn't merge cleanly and since you
> are already respinning patch 1/3 I figured I would just bail on this
> patch and let you take care ot it.
>
> I would suggest dropping patch 2/3 from the patchset, respinning
> patches 1/3 and 3/3, and reposting them for inclusion into
> selinux/next.  That's likely the quickest way forward on these.

Technically 3/3 isn't safe without 2/3 (or some replacement for it,
e.g. moving the policycaps array into struct selinux_policy as
suggested by Ondrej).
