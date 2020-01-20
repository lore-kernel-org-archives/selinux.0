Return-Path: <SRS0=4oDv=3J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A141C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 15:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BA0217F4
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 15:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXVvF87A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATPuK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:50:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35016 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPuK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jan 2020 10:50:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so95924wmb.0
        for <selinux@vger.kernel.org>; Mon, 20 Jan 2020 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4iJPyqPFmm3if9D4Zcmoglena7vVReRL4G1xXMDjcs=;
        b=WXVvF87A1dZEn73yXYK1hbuVjlFi0aDkUPBZX/2FFU3vOeLeKWfhkONhmPCHw61NeB
         actxmhzPc5EGzYseyT5b6+7MN1cc4CBlyEtHMZmsFRxXj4R362NcWNPAnO4F0RoCHxMq
         ZAT4SfEJ0PPD0H4jW3AryqfJuwY4aBcDJgxjwBJQ5pmgeEkigQ1w5YmlBf0HIaD8OFeb
         UAYe5tAi5TAyvAfVAfJHBpKTZVqumPDOALCNiEqa7aK6YyjQocQ56kZp1zaR2eYel0Sv
         3XRtuB6QOVxZx4uZeA8pkfa6K3I1SZXGgdHlXFB9tCqcn3sLlyOKHa2I/2BX2aSJVubN
         pBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4iJPyqPFmm3if9D4Zcmoglena7vVReRL4G1xXMDjcs=;
        b=nhAo8O3Cn4urbWwJO0DT8QS8L5xZn5gnjFbvREDtG3Cdk/mIZ0Dfn/WvFkadILlzJU
         rrm0U7hjPgnTlQqye/+8SI9qsoOTkEgLUhwpZbCkeqq45CvPXDV7I11D3pANH7N7FKpW
         OOr6K3nYkIQHo0oRmXGw70KcL1rPV2IjBeTBDympQ8XgF2EIahIRfaIooQ3w4YZ+Xush
         tKc38d9bWpRy/qvQjVy/9SRyzczZcs7WVS3ngI/RKpXBlxinJsxK633Cz2NESDTmcojm
         /w9C4TDLkHQad3a0O3qPX/1TE6xhi98h0ZhDovTOybLm+caTzcaWLFuF2TXajNtJrwf/
         O6Hg==
X-Gm-Message-State: APjAAAVnhq6Z7YhzqDBk397HL/L7B2S5E9QuLr9xY4PKBc2EwGW2BnWZ
        +CKoHRbaG4rcvOlAdjNdMXQmwpbnqqNsTEyjvfU=
X-Google-Smtp-Source: APXvYqwhn62QrVxWk9UmMuONV7M1skhMOfgWtV2L5STABy9EJi1Cf0DHtgXGXRy24A62KcE8yiizB3gsJ/Kl9oJvL0I=
X-Received: by 2002:a1c:6389:: with SMTP id x131mr20049705wmb.155.1579535409036;
 Mon, 20 Jan 2020 07:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20200117202407.12344-1-sds@tycho.nsa.gov> <CAHC9VhS+YxOEsfDRjiiwkT9PdAdFLigG-n7cyLHL1ykBQED-Hw@mail.gmail.com>
 <CAB9W1A16ixsXmMkfbD7Z0WrXK+B0xWfNpBbOe+jOb6krOWrogw@mail.gmail.com> <CAB9W1A3G-23EYDOp0YvCXuQNq3N_XH64s53SyqacYCbnqupcQQ@mail.gmail.com>
In-Reply-To: <CAB9W1A3G-23EYDOp0YvCXuQNq3N_XH64s53SyqacYCbnqupcQQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Mon, 20 Jan 2020 10:49:58 -0500
Message-ID: <CAB9W1A3USsWW=pbdK8WjZdKpPLQSJ=TaxZE4Yzf0VYYdot+DfQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix regression introduced by move_mount(2) syscall
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        omosnace@redhat.com, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 20, 2020 at 10:43 AM Stephen Smalley
<stephen.smalley@gmail.com> wrote:
>
> On Mon, Jan 20, 2020 at 10:40 AM Stephen Smalley
> <stephen.smalley@gmail.com> wrote:
> >
> > On Mon, Jan 20, 2020 at 7:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > > It also looks like the fs tests Richard is working on includes tests
> > > for the move_mount() so I think we are covered as far as the
> > > selinux-testsuite is concerned.
> >
> > Not sure since those tests were just added in the latest version of
> > his patches and at this point he would
> > be running on kernels that lack this permission check.
>
> Ah, never mind - I see that he mentioned that he applied my move_mount
> patch before performing those tests.
> That means that there should be a test failure on kernels >= 5.2 (i.e.
> that have move_mount(2)) that lack this
> patch IIUC.

Never mind again; he has the move_mount test under a conditional that
will get updated to be specific to a kernel version if/when my patch
lands.
