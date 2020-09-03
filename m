Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4B8C433E9
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 15:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A642072A
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 15:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgvQl0x0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgICPOS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729556AbgICPON (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 11:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599146052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qFq6/aguPsg1ldOdmu6bHRIc5zIyfBv18Os+HnwnkME=;
        b=NgvQl0x0Ii6TjmSHUw5JxsmLlmK80j6dBZFjAiG+Vs2srcay4EjLOVW52mkPSgjChJtZT2
        ymHudivIP2Utt1Y1zLOdQ9y9K/4HXZYtVURb5RlryHJx45Y/zYl0TmOuTl+Xk1fm8HBU5/
        1izBvZWhIvftbn/q4WzhIUExZWEhT8I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-u0q5v2u6PXO9O4_xtRww2g-1; Thu, 03 Sep 2020 11:14:10 -0400
X-MC-Unique: u0q5v2u6PXO9O4_xtRww2g-1
Received: by mail-lj1-f198.google.com with SMTP id s11so782474ljh.8
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 08:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qFq6/aguPsg1ldOdmu6bHRIc5zIyfBv18Os+HnwnkME=;
        b=F6nt2fOXc7rQnw/5Sir8a0qA2rZUEFT10v+z+BxIqhiR5PpiXmEDj1a3kWnmIw4wMG
         qw1YqNFR4Le4Qk2Hn4lTOIAiXltCjohfgLtyBgGxeBXHLkkXEr9l/tslR8JevgbTMdKa
         xIwU6jeYXyELyEWuGDLKYaey6aR33h5Xw1EGe+dK9EMrkKZvr12bJg4VbRpkp15Z0YOV
         VMkc+yuMD62T/7O+IOFj4E48JAZreYHT5CyAJ9y254uMd4F/R7kgtIxsLgHeS5OgiPKO
         ht70thCqKfCh98P+5O5Utl6Qczx19ZmFG/zZs1n+8nlL2u1brUqMbrI6Iv8TWRXkxMjF
         CeiQ==
X-Gm-Message-State: AOAM531LuaA8IXA4IgrMkhnG1pJzzxQohQ71e9BkG5oy4qqFhMVhyAl/
        R4azKSssQHprZYUXDC8SYYY2BvqUYsa02QfDO49ZSlia/hFTBe+Xd8gM2u0/oLfYoDQyLa2yxjd
        TYqvYH9RPPX1pCuYsNsGYjwr4DusAudXCKQ==
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr1578778ljh.311.1599146048339;
        Thu, 03 Sep 2020 08:14:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySGKf8miL8rIiTqSgWpC4Dyr4nnQKCvbyMfKvhp0Lrfqc1b6yW3xvZwwUg1eBTSTWP2DeIXkB1rhkAtSFYScs=
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr1578769ljh.311.1599146048135;
 Thu, 03 Sep 2020 08:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200827083017.1956255-1-omosnace@redhat.com> <CAEjxPJ60A==2EgwsiyrbtgBSRQ4G25HWyax+gfdfEsmm+kU0Mg@mail.gmail.com>
In-Reply-To: <CAEjxPJ60A==2EgwsiyrbtgBSRQ4G25HWyax+gfdfEsmm+kU0Mg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 3 Sep 2020 17:13:57 +0200
Message-ID: <CAFqZXNunGnuFrn5xOmACkW3-nnhiH_p-_11G86-Qas3rEk1PZg@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: add nftables to dependencies to run
 more tests
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 31, 2020 at 4:14 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Aug 27, 2020 at 4:30 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > It is omitted from the official dependency list since it's optional, but
> > we want to (try to) install it in CI.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by:  Stephen Smalley <stephen.smalley.work@gmail.com>
> (likewise, feel free to merge yourself)

Thanks, merged.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

