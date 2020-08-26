Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C3C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75E0207BC
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 18:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoNePJUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHZS7D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgHZS7C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 14:59:02 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD37C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:59:02 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id a6so673723oog.9
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lkg9HcOON00aX97na8HU/xnmyrRhn20y+9bMEPhcLwU=;
        b=JoNePJUE3Hd4LP1Pv8w8awp9KgfXHN5Ydt5l4wCCjsZtSFekHxuWqCBDFu3Du8jiCV
         fVVBPpt5yLMuVGxeWi0DgU8AaJOHslLWLkdgXU7Px4nPXNMEF+M9Ho8sUBYnJHzqf/vX
         lah/tL3JtqUn1pVf0Kw0G3ro9gWf3C9mVp2dzAiUEQZZqqOl2lWsr0lqotoczxtBXOeK
         qzOd1gmtIugrgbiKzRQH4HnPTE7rgqrrjtcUH1xNxFi4YsMhG+59o4Q9FPHO0WQFU8vK
         9FoV0NbF7jkoARuA5W0MNEQroz8psiH6NFImvvdKms2gbuhQxXF+ZzjjdWyyzIStfiFP
         /1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkg9HcOON00aX97na8HU/xnmyrRhn20y+9bMEPhcLwU=;
        b=gYwGMl5SWKqfc5zUBIce4HUGeOlMxaGpI+SoSCmZdeyzXoPkLsDGi2y1UbhbYLfF79
         9KeGOxez9pTaDKKXvApNkK8vKdjC34LrFrU2zfNynaHEzVQSyBvdrRsP1QSf8TQmBNxi
         pXuzNtPvIPwQ6CGkZe/IpWH7mgk4bGqBoAM+7GMoRv5ykkIM/MYIncuNywKdb/Z6J/tV
         Xtb2oE/E0rG1ze73upou/puqcTtj3GgfDvRaFo3QwgS7CcuftD9hHbIZmD6Pv6ApXfDw
         8LzDBJcKNV9/90YwBnPKY9P3USe7Fg1H9Cvic35dghTKc4REk+mFXLXufIGDNX3GvAer
         zjoA==
X-Gm-Message-State: AOAM533WL7+SeXetWrbmAniSMsSUzEECixaPua3GUVOvptYP+5Lkx/cv
        2mjULSVrKvLjNwN2I8QTvZO47X0Fj8YuhA1H2vE=
X-Google-Smtp-Source: ABdhPJw3pQk0a7io+jWOw028CVJNWmoNd82w02U+G88yEoL79dzfkYaw2Wg5gGO77ibhtUKnm8xvykVSbNsBINPzZho=
X-Received: by 2002:a4a:b80b:: with SMTP id g11mr11585169oop.13.1598468341056;
 Wed, 26 Aug 2020 11:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200712160020.17385-1-richard_c_haines@btinternet.com>
 <CAFqZXNuDF=NYjoc_KF39C9nyR27y=nj1BhCyz1oWJ_BmrFu1ZQ@mail.gmail.com> <CAFqZXNsU_dM43Enh27MmC5MO8vfZhnAn7OhHc7nwDVwC5STNFw@mail.gmail.com>
In-Reply-To: <CAFqZXNsU_dM43Enh27MmC5MO8vfZhnAn7OhHc7nwDVwC5STNFw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 14:58:50 -0400
Message-ID: <CAEjxPJ7LA6ek+sAgzma6ACat4gcuV9j5Bi-yMKF5JgDHP=Hsgg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Review and update SCTP tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 9:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Jul 28, 2020 at 10:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Sun, Jul 12, 2020 at 6:00 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > > Reviewed the tests using kernel tree: Documentation/security/SCTP.rst
> > >
> > > Added tests and policy for connectx(3) handling deny and
> > > SCTP_SENDMSG_CONNECT
> > > Added test and policy for bindx(3) deny
> > > Clarified the server test for ports < 1024
> > > Added comments regarding kernel net/sctp code locations to relevant tests
> > > Corrected policy for test_sctp_deny_peer_client_t
> > > Corrected ip/nf tables comment to deny read packet { recv }
> > > Added MCS-constrained type as suggested in [1]
> > >
> > > [1] https://lore.kernel.org/selinux/20200508154138.24217-7-stephen.smalley.work@gmail.com/
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > >  policy/test_sctp.te        | 43 +++++++++++++++++++++-----
> > >  tests/sctp/sctp_bindx.c    |  8 ++---
> > >  tests/sctp/sctp_connectx.c | 47 +++++++++++++++++++++--------
> > >  tests/sctp/test            | 62 +++++++++++++++++++++++++++++++-------
> > >  4 files changed, 126 insertions(+), 34 deletions(-)
> >
> > Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Now applied, thanks!

Seems to have broken the testsuite on travis-ci for userspace testing,
https://travis-ci.org/github/SELinuxProject/selinux/jobs/721441713#L4656
