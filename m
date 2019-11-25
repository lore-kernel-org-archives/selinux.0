Return-Path: <SRS0=nPuh=ZR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01AFC432C0
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E802053B
	for <selinux@archiver.kernel.org>; Mon, 25 Nov 2019 15:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf80QrgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfKYPeC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:34:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34274 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728528AbfKYPeC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Nov 2019 10:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574696041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZmSHb5x670bnjchkfg/8U+bohSaMK1/N6IhZFtuiaE=;
        b=Yf80QrgO2qVtdq1oa1e9sIOmxqvCc6s4NFzKJI468ln1p55uTcWG75tpEJXdSHShBL/t5K
        k8bSEZUiE8zZ9rbmw4Ap224MjPualwfOTxWB6G7z1M/Xb0j22I1/1rDGSO8Q/fMQlCGu3g
        33DVCzol3MwrSJMxhka3S3iIDUTjYnU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-WrmYuBeXO-ugZ6teQDYvkA-1; Mon, 25 Nov 2019 10:33:59 -0500
Received: by mail-ot1-f70.google.com with SMTP id p1so8241345otq.4
        for <selinux@vger.kernel.org>; Mon, 25 Nov 2019 07:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLMQvpMpe0dPcTqd/hMDaUP8Ed0iBPGXTnEnJ3uxkSI=;
        b=mk6bRH+qjW0f0MacE29TpAcBOnNLhlRdgo8E0lOSIZJoYt9Fb/IHgsdv3GNExlR07z
         5n08XlKVTnh88hY0usbSPRckCeqQ4CoRC9hVbqoXxBnzeHaibVVVKZQO0ts6spohb+Db
         wHunBKgljLmo/IMk2VRJd/51r1xn+UbTYjWDYcBlHjYpzbZxEerAQ9nAFp7VtWHc7f3E
         UILso9SWSgRl0RsCECq4BEIGybj0x3hhy0yo/kMT+aJni55ybPPh6RwrVigWzs1qz4Wr
         yErGtE0lXpl3rsLlIPb8paNVld+KciH+lsc1RCZgOVYmDCvgTeDT0mdCwtuahNLi6p1M
         dA8g==
X-Gm-Message-State: APjAAAV0tj1HhfSATz8SsbemUrubBhZtYRxYjHQLDtYNiEB1ijy148zy
        Dez02p7yNDMxSSiCmawuooSZ0Rx/PqQ/IZ07BMc2+bsvCh7sX54YCrx2c6A8Ozao6vNwNoikYMH
        JYxHBozjTxfa5l4gcZ5lvSRNdm9BtFLFF5A==
X-Received: by 2002:a9d:7c83:: with SMTP id q3mr20814512otn.66.1574696038989;
        Mon, 25 Nov 2019 07:33:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqznlIQ+qHUdYqzkdn898c6G52czgJNDktODSL/8OoePDrVk+2p1jRE3ReuBttqZGTfRBJ98VMwZ79aVQfDnX+M=
X-Received: by 2002:a9d:7c83:: with SMTP id q3mr20814493otn.66.1574696038613;
 Mon, 25 Nov 2019 07:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20191125151323.701716-1-omosnace@redhat.com> <1d19a918-9856-751d-495e-6a8bbc751138@tycho.nsa.gov>
In-Reply-To: <1d19a918-9856-751d-495e-6a8bbc751138@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Nov 2019 16:33:59 +0100
Message-ID: <CAFqZXNs7VnzpJf6EFgwuOdP1+_HqCvxmby0cAn-tSCCC3i9ASQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: check for module_request support for key_socket
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: WrmYuBeXO-ugZ6teQDYvkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 25, 2019 at 4:18 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/25/19 10:13 AM, Ondrej Mosnacek wrote:
> > E.g. RHEL-5 has key_socket class in the policy, but not the
> > system::module_request permission.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   policy/Makefile | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/policy/Makefile b/policy/Makefile
> > index 57cc172..7c2d21e 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -94,8 +94,10 @@ TARGETS+=3Dtest_notify.te
> >   endif
> >
> >   ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.=
spt && echo true),true)
> > +ifeq ($(shell grep -q module_request $(POLDEV)/include/support/all_per=
ms.spt && echo true),true)
> >   TARGETS +=3D test_key_socket.te
> >   endif
> > +endif
> >
> >   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> >   TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.=
te, $(TARGETS))
> >
>
> Alternatively, consider wrapping use of module_request in
> test_key_socket.te with a suitable ifdef.  Probably ought to be using
> the policy interface, kernel_request_load_module(), and then we can just
> wrap it with ifdef(`kernel_request_load_module', ...).  Rationale: The
> purpose of this test and its policy is to test the key_socket checks,
> not module_request; allowing module_request is just incidental.

Good point, I'll look into doing it that way in v3. (I posted v2
before spotting your reply.)

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

