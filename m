Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41175C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEB92074D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA/Cu20B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHXNHh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:07:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52277 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725926AbgHXNHg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598274455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IYHAWpAE33Ovh93/43nuPNxKDGKH+ndcE3g3roGExYg=;
        b=YA/Cu20BO7jNNjmwPeXN8BrUMBI+dP80QRM7QkBrAgZ7golj4kRSSmd9R/5QpE1gcRaVTV
        19SkeHhdrcQh6J8PD0hbISFFyI3T/96pbSs+pCEVCy0Kiab6oX1CWIWV8Tr3+h7WzXZJOw
        13DW6N0lBXTGuYb8Axx3wD+J+R7ZTKs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-Qnd1X3RfOMyi0MRPZSibUA-1; Mon, 24 Aug 2020 09:07:33 -0400
X-MC-Unique: Qnd1X3RfOMyi0MRPZSibUA-1
Received: by mail-lj1-f200.google.com with SMTP id t9so2766177ljt.13
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYHAWpAE33Ovh93/43nuPNxKDGKH+ndcE3g3roGExYg=;
        b=L6LydA/38VfVmqAtf+JmTz1rWoZWFJMB+BuztD21bsyeVh0hoiF0Heh3irvHKN+pSO
         sHsBfqkEbVOB4AM8eGRbViwPqhK9TzyyZHUJnfEQGYiJwUrHKV5d0B9inzq5BX1UHyRH
         hfIuRMDT/zIU7og4Io0vAr++08UBglzmoanIgaIi62vo9CHHEesgf8NKsB3OIplAGr9X
         xBk8Os9p0N7AA25k5Uv+PE2OumdXd2SsijHvz3V5VTnJowOHU0zxHKHccWS6SWceJ1Kg
         jX7Vtk7UoY8drElfWqB4Hy5PgomYKC31iNIkVorUIP5AGjQXAXqsdihkN/aQNm4YWilT
         mD3g==
X-Gm-Message-State: AOAM531qxHG50yqJfp4La6A/TmnfdY63sIgUBptBDzUFzZoIXX+ttdEY
        3Xx/noJkgfBplMUam0THxC5kejh6qlwdXc6H2KOuUU3SoWpfz95m4xwzukMhb0eX+xwmLepRfkR
        c9NuYgNNVaqcfmOpONwfwzNl8l2jhftogTg==
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr2491796ljn.123.1598274451862;
        Mon, 24 Aug 2020 06:07:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9TZNTEANQ3MZMvznG9Hti7sELZJu1AjtLVy6guLtl8l4kMUuBdeBJroUL4gdyDrpkQ9ARebAbnUkE6AfgwIg=
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr2491790ljn.123.1598274451668;
 Mon, 24 Aug 2020 06:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200712160020.17385-1-richard_c_haines@btinternet.com> <CAFqZXNuDF=NYjoc_KF39C9nyR27y=nj1BhCyz1oWJ_BmrFu1ZQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuDF=NYjoc_KF39C9nyR27y=nj1BhCyz1oWJ_BmrFu1ZQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Aug 2020 15:07:20 +0200
Message-ID: <CAFqZXNsU_dM43Enh27MmC5MO8vfZhnAn7OhHc7nwDVwC5STNFw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Review and update SCTP tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 28, 2020 at 10:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sun, Jul 12, 2020 at 6:00 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Reviewed the tests using kernel tree: Documentation/security/SCTP.rst
> >
> > Added tests and policy for connectx(3) handling deny and
> > SCTP_SENDMSG_CONNECT
> > Added test and policy for bindx(3) deny
> > Clarified the server test for ports < 1024
> > Added comments regarding kernel net/sctp code locations to relevant tests
> > Corrected policy for test_sctp_deny_peer_client_t
> > Corrected ip/nf tables comment to deny read packet { recv }
> > Added MCS-constrained type as suggested in [1]
> >
> > [1] https://lore.kernel.org/selinux/20200508154138.24217-7-stephen.smalley.work@gmail.com/
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  policy/test_sctp.te        | 43 +++++++++++++++++++++-----
> >  tests/sctp/sctp_bindx.c    |  8 ++---
> >  tests/sctp/sctp_connectx.c | 47 +++++++++++++++++++++--------
> >  tests/sctp/test            | 62 +++++++++++++++++++++++++++++++-------
> >  4 files changed, 126 insertions(+), 34 deletions(-)
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Now applied, thanks!

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

