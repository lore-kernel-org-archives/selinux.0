Return-Path: <SRS0=Dm73=EB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF1C4363A
	for <selinux@archiver.kernel.org>; Mon, 26 Oct 2020 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C11223EA
	for <selinux@archiver.kernel.org>; Mon, 26 Oct 2020 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqvJP/Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768310AbgJZJpy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Oct 2020 05:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1768278AbgJZJpx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Oct 2020 05:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603705552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oc/wcO07uacg+Y2P1HuGNYY0LuHkvIC/CjyLFx2HegM=;
        b=ZqvJP/DxmK6myWMEJrZ/1hc0DJhaCDZvYMB3FAsQBBoBIkpBXeo5VIBnYni05HjBUrbcV6
        CzdKLK7zZuZceDflhif24iwkinbki3NZQJlJWphx0J85zqzerDddxmFAYCuboQ+gmlnZbE
        elw+8lIElESe64GkdXir8Ul/4DeqLYI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268--U2Rki9iOwuMpLrwgCf6Nw-1; Mon, 26 Oct 2020 05:45:49 -0400
X-MC-Unique: -U2Rki9iOwuMpLrwgCf6Nw-1
Received: by mail-lf1-f71.google.com with SMTP id e29so2176569lfb.5
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2020 02:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oc/wcO07uacg+Y2P1HuGNYY0LuHkvIC/CjyLFx2HegM=;
        b=DIu17cjNOOPsCxhvMLEofNl6vTx03X/LXXCUT5+U+7xCAxesqitCh4K/uXMFkaSGMt
         mf3SU32rK7KB20JxktMiQhu8AmJv9WJRW3Z4JVw3TtQTrEeWCpDHlimwudNxye+mDwas
         MwomXK/Vmvq+mcgjnCIfw9VUxk/lEHJHW0dxIpoEUwGCtR1YaLS878qjcgbkaOoui3m9
         /t0A6jZHsL7HsfBrlK2TwBx3ww1NhU7Vq7V/VrdB/QAx189arTRD/hRkaIqk4YibLIEs
         H9dD5y540ArlmeBCIAf9NBMAX9CUJ4AatXkmhyOE3Wmrnp/eOsptShPEpyAK5yEzF1d6
         zOyQ==
X-Gm-Message-State: AOAM532A8d9Y0X5Z5DB0SsltDptDRaTchdik+ET3Hpd3CSMMX1g0Op2q
        M/FzKA/1R59yObaiIEFXxjRRFnVsqZBz1E/TRO0kH9RHMEXRl1x8vQDYLYou1DBv/2uELQW184L
        mkye0qklAthKpbRi/Imlrsu8+6sjUv9wwww==
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr5624448ljn.77.1603705547227;
        Mon, 26 Oct 2020 02:45:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLdMvFyfww3yA2NUH2Ca8HhP96GKmyiw/Y4HvkxJaZQcJHlE1M+uJi3OCVQXV7N+TTb2Lk8+o7Zh+m5/4Ph2g=
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr5624442ljn.77.1603705547028;
 Mon, 26 Oct 2020 02:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201020132856.689870-1-jwcart2@gmail.com> <CAFqZXNt2h_Bp2piOvimndrQLW6si4s_AczGhe_YNFo8F2mFv=Q@mail.gmail.com>
In-Reply-To: <CAFqZXNt2h_Bp2piOvimndrQLW6si4s_AczGhe_YNFo8F2mFv=Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 26 Oct 2020 10:45:36 +0100
Message-ID: <CAFqZXNsVu6=pn6u568ZaT3vAxfWmmuTL6cwYkqu1epQtFBOBfw@mail.gmail.com>
Subject: Re: [PATCH V2] libsepol/cil: Give error for more than one true or
 false block
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 20, 2020 at 3:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Oct 20, 2020 at 3:29 PM James Carter <jwcart2@gmail.com> wrote:
> > Both tunableif and booleanif use conditional blocks (either true or
> > false). No ordering is imposed, so a false block can be first (or even
> > the only) block. Checks are made to ensure that the first and second
> > (if it exists) blocks are either true or false, but no checks are made
> > to ensure that there is only one true and/or one false block. If there
> > are more than one true or false block, only the first will be used and
> > the other will be ignored.
> >
> > Create a function, cil_verify_conditional_blocks(), that gives an error
> > along with a message if more than one true or false block is specified
> > and call that function when building tunableif and booleanif blocks in
> > the AST.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> > V2: Put spaces between items in argument list
> >
> >  libsepol/cil/src/cil_build_ast.c | 44 +++++---------------------------
> >  libsepol/cil/src/cil_verify.c    | 35 +++++++++++++++++++++++++
> >  libsepol/cil/src/cil_verify.h    |  1 +
> >  3 files changed, 42 insertions(+), 38 deletions(-)
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Now applied:
https://github.com/SELinuxProject/selinux/commit/2d353bd5850a4b3fc8480806010e08b59f4a4835

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

