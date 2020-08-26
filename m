Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F9C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF2F207DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3qjcSat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHZUAb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbgHZUAa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 16:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598472029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vK4WuSUlwyqli0Z9fiBXF9VHDWzgMUhM++BUGpca9fs=;
        b=Q3qjcSatG2NjBxxOzZuU3MmjaVWKluf+u03nG6lP6ViQJ29agz89kyadCvZEe4j2lnkSN7
        737n60US4nsRyMn6ejj6x3Zt9Da1YWlHxkTN1H+m8AqCe4d8IxCEDSqmvFHC5o6NibPQaw
        202ln2dJgIHDFwe32Y2dZxxVkiO/zLM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-5CgxpsA2PIe3nhWCG7tzpA-1; Wed, 26 Aug 2020 16:00:26 -0400
X-MC-Unique: 5CgxpsA2PIe3nhWCG7tzpA-1
Received: by mail-lf1-f69.google.com with SMTP id 140so1055530lfb.4
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 13:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vK4WuSUlwyqli0Z9fiBXF9VHDWzgMUhM++BUGpca9fs=;
        b=tygxPQ7+Ka0+/JP5ce2hN579WxSnADO7QyEVpVGa7Rw5bNIXa0WObYFi5F58kHAR7B
         aS7ycFoOOoYuMMk8LuKgCDAQP2BKUBtSUs2Epnyk47CXULJlCOzF7EThOu4YoTwYiqER
         Vu9sCUStN6crMZrJyfImRiG7qNK747uPt7bCSHGo9EJyBCK0GFHj2CPDDkOSe74JdFrq
         zt0kHxTWAGd+StEDycZUR/3Te3SXYnM0DL/PZ/Ifcyl5QIz76leWA2mBnDBXCjswCovP
         fUIdNeGZlFMVe8CZjzlBKzU+qLr+OYf3c2d4ytA6ZoA3VJKGtnteKXYlnEUgCxJ9pWMw
         miBg==
X-Gm-Message-State: AOAM532NNXh/uNr4Fy/c6DQqbPOJAs8sjSGzWGCv/EHyFczYfpeSJMAT
        P/jV92IqrW6tJvZPwYz8lBmLnPhdVyAMU+pW0ztvxQ5TCljWPegrO8CQPxZ6AltoGh5w/dF2qKn
        2k+puT4imR2mscqe+LvveMLbek8xFsYY1sg==
X-Received: by 2002:a05:651c:330:: with SMTP id b16mr8038117ljp.77.1598472024468;
        Wed, 26 Aug 2020 13:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfmg+b73WV8SSAAqHIW98tKyQJvC0t5CynDt5YSV5RUSMdvw41PGqprhCal7HIn9dcVs1YhGMB731bItXe2kk=
X-Received: by 2002:a05:651c:330:: with SMTP id b16mr8038110ljp.77.1598472024186;
 Wed, 26 Aug 2020 13:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200712160020.17385-1-richard_c_haines@btinternet.com>
 <CAFqZXNuDF=NYjoc_KF39C9nyR27y=nj1BhCyz1oWJ_BmrFu1ZQ@mail.gmail.com>
 <CAFqZXNsU_dM43Enh27MmC5MO8vfZhnAn7OhHc7nwDVwC5STNFw@mail.gmail.com>
 <CAEjxPJ7LA6ek+sAgzma6ACat4gcuV9j5Bi-yMKF5JgDHP=Hsgg@mail.gmail.com> <CAEjxPJ6fX5JC5OgbuQKccb-9tUPxxHW1b_BbNrha7nvQRi7nig@mail.gmail.com>
In-Reply-To: <CAEjxPJ6fX5JC5OgbuQKccb-9tUPxxHW1b_BbNrha7nvQRi7nig@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 26 Aug 2020 22:00:13 +0200
Message-ID: <CAFqZXNtcLMqiqaPzs=8y7wjwAiUJ8iH7oCV=OmhO+KXYyUvEOA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Review and update SCTP tests
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 9:16 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Aug 26, 2020 at 2:58 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Aug 24, 2020 at 9:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Tue, Jul 28, 2020 at 10:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > On Sun, Jul 12, 2020 at 6:00 PM Richard Haines
> > > > <richard_c_haines@btinternet.com> wrote:
> > > > > Reviewed the tests using kernel tree: Documentation/security/SCTP.rst
> > > > >
> > > > > Added tests and policy for connectx(3) handling deny and
> > > > > SCTP_SENDMSG_CONNECT
> > > > > Added test and policy for bindx(3) deny
> > > > > Clarified the server test for ports < 1024
> > > > > Added comments regarding kernel net/sctp code locations to relevant tests
> > > > > Corrected policy for test_sctp_deny_peer_client_t
> > > > > Corrected ip/nf tables comment to deny read packet { recv }
> > > > > Added MCS-constrained type as suggested in [1]
> > > > >
> > > > > [1] https://lore.kernel.org/selinux/20200508154138.24217-7-stephen.smalley.work@gmail.com/
> > > > >
> > > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > > ---
> > > > >  policy/test_sctp.te        | 43 +++++++++++++++++++++-----
> > > > >  tests/sctp/sctp_bindx.c    |  8 ++---
> > > > >  tests/sctp/sctp_connectx.c | 47 +++++++++++++++++++++--------
> > > > >  tests/sctp/test            | 62 +++++++++++++++++++++++++++++++-------
> > > > >  4 files changed, 126 insertions(+), 34 deletions(-)
> > > >
> > > > Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > > Now applied, thanks!
> >
> > Seems to have broken the testsuite on travis-ci for userspace testing,
> > https://travis-ci.org/github/SELinuxProject/selinux/jobs/721441713#L4656
>
> Looks like it was transient but I haven't seen that failure prior to
> this testsuite commit.

That has been happening relatively often on slow/unstable machines for
as long as I remember. In our downstream testing I managed to reduce
the occurrence of these failures to an acceptable level by increasing
the timeouts in the SCTP test to 4 seconds. I planned to send a patch
to update the timeout values upstream once I get some time-proven
values from our testing. I guess I waited long enough now :) I'll send
a patch to bump them to 4 secs tomorrow.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

