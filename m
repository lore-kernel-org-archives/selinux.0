Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87520C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F792078B
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWpYlXWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZTPb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgHZTP0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 15:15:26 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56455C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 12:15:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id x24so2447714otp.3
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn7WFktBuhTr1lS7pqRbQpT+/PL6Owp/5vquZUPLCXA=;
        b=QWpYlXWnkAgDY1n4eeymwfY3CgJh535w/luRqg9RTRzWi5UmuIKR/RQLo7xtsJLa77
         gbHz3FQKNWpAK09yi8I51ZNGl5o64IAG6XaITSddYr9g0wVcOItFuJvWyCLKUIa2Cl7E
         HRxOmWPtwAVpXhv9nuE1S5VopyLhYlhO528yejiBjHMSEmokeM70loXKOw7HiFVwksnR
         0P6UTIaR7nckNjgLaEMRHE/4hxFnhK5eRhIfPvTemU/cmainNEpFPqegb1QIHKSDqytY
         Af+0/mxS2n0/0cNi0tdTdrdm3dinLEAtLTh/jI8p+z5E3ClMhDbm6+NhygVOD1KcGffm
         gyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn7WFktBuhTr1lS7pqRbQpT+/PL6Owp/5vquZUPLCXA=;
        b=ehAfLnElvtv+LEoTTQJXK+QSLuHbJTpDhgEaZTcyxwERODSXSRw1hOCUlAzqqegLpc
         lGzPOB+IFWJhyplZuT+YNs2Yi9VVzxUOfwIwnh45hMn2z1W7SyqoE55qywydj9LdDU0H
         7EwnhHuJA1KjtJenw900438qtfVbzax+f1/KpRjPo64gB/cDvAOKEeMkktxuSqLEomt1
         XteRauHJH8qfVtxQGoY61B2IAmeMMfiG6R+0tHvVdqo/2ciXAf77jxllI/OfSPHAkfwB
         LOpy/yhSauy5bK4s8qDxx0iS5ECnevwJsA8of38bHOKuaLZ1OeP4W6Q4dBUQH/GPUS8g
         nuYw==
X-Gm-Message-State: AOAM533/A3ge71Oovz65AQbWqBBQ0OIQcEAPI/YTeVWnkC6Sw4juXH1k
        5gKPT4FjCytQSWmHJFfSd3WQBVdCyW7y8T22qk0=
X-Google-Smtp-Source: ABdhPJxm/P9P+ScRMIQDRXneBCwqtcMYyc1bdv/Qvsc8Q2Okn7iILbn4TizdRUlCHHBTO42tc8cbXC6r1R1miWAi3s8=
X-Received: by 2002:a9d:25:: with SMTP id 34mr8925541ota.135.1598469324781;
 Wed, 26 Aug 2020 12:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200712160020.17385-1-richard_c_haines@btinternet.com>
 <CAFqZXNuDF=NYjoc_KF39C9nyR27y=nj1BhCyz1oWJ_BmrFu1ZQ@mail.gmail.com>
 <CAFqZXNsU_dM43Enh27MmC5MO8vfZhnAn7OhHc7nwDVwC5STNFw@mail.gmail.com> <CAEjxPJ7LA6ek+sAgzma6ACat4gcuV9j5Bi-yMKF5JgDHP=Hsgg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7LA6ek+sAgzma6ACat4gcuV9j5Bi-yMKF5JgDHP=Hsgg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 15:15:14 -0400
Message-ID: <CAEjxPJ6fX5JC5OgbuQKccb-9tUPxxHW1b_BbNrha7nvQRi7nig@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Review and update SCTP tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 2:58 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 24, 2020 at 9:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 10:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Sun, Jul 12, 2020 at 6:00 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > Reviewed the tests using kernel tree: Documentation/security/SCTP.rst
> > > >
> > > > Added tests and policy for connectx(3) handling deny and
> > > > SCTP_SENDMSG_CONNECT
> > > > Added test and policy for bindx(3) deny
> > > > Clarified the server test for ports < 1024
> > > > Added comments regarding kernel net/sctp code locations to relevant tests
> > > > Corrected policy for test_sctp_deny_peer_client_t
> > > > Corrected ip/nf tables comment to deny read packet { recv }
> > > > Added MCS-constrained type as suggested in [1]
> > > >
> > > > [1] https://lore.kernel.org/selinux/20200508154138.24217-7-stephen.smalley.work@gmail.com/
> > > >
> > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > ---
> > > >  policy/test_sctp.te        | 43 +++++++++++++++++++++-----
> > > >  tests/sctp/sctp_bindx.c    |  8 ++---
> > > >  tests/sctp/sctp_connectx.c | 47 +++++++++++++++++++++--------
> > > >  tests/sctp/test            | 62 +++++++++++++++++++++++++++++++-------
> > > >  4 files changed, 126 insertions(+), 34 deletions(-)
> > >
> > > Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Now applied, thanks!
>
> Seems to have broken the testsuite on travis-ci for userspace testing,
> https://travis-ci.org/github/SELinuxProject/selinux/jobs/721441713#L4656

Looks like it was transient but I haven't seen that failure prior to
this testsuite commit.
