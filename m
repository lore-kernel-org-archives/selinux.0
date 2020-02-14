Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D09C35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6D22314
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/qfZtUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgBNTwM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:52:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54173 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387964AbgBNTwM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 14:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581709932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAlzorbxNonsjEr9LR/UOiUi+R+X0nMERyXckw0tops=;
        b=c/qfZtUzH5iZi+iPjjQs4z+Mc++QraMMMrMQzvuVJm8A5p3S5cwHlebEnkrFLM78g10lmu
        ZWMK/nxvc2LHQopI5pHnuTR7ydhvs41uAd/dz542wvmgKQA0xphj+SRTMJGmNkm00+m9cp
        pq3EVHFZf9FX2zlYGul//ZNPBm/H3Y4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-WDkWK13iMNKJXv0UlnTLNw-1; Fri, 14 Feb 2020 14:52:10 -0500
X-MC-Unique: WDkWK13iMNKJXv0UlnTLNw-1
Received: by mail-oi1-f197.google.com with SMTP id 16so5189821oii.18
        for <selinux@vger.kernel.org>; Fri, 14 Feb 2020 11:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LAlzorbxNonsjEr9LR/UOiUi+R+X0nMERyXckw0tops=;
        b=SaoyRMeb8b2b383uz+rMajKLPvvzku6W4CEcWdi6PEvUQWWSqRXnrCGNqnIcJHodBx
         lXNCOWFLXjcB96VaBqYZcKefWbGPmqFIuHLKXxX46zeU7+8HdjDWf4dMPOtvXk3szc5o
         9EUSds20xlnzySPOBnuX/WPMCVpU16Ja0YUAp7AaQni1eDCmN3Hds1V8+9T+v+O0g6D0
         wS6WVAH2LtZLjUDUJAqhY6gfVmiNEJBwdYeFyM31KumH+IXYnn/PLTvUZnmEo92vG3F/
         SYy1SEjHZjWXF7/0Uu+JthQiM46KM4Hhq9kirHspw9RXJZ/tUgeS90AK60QrYjA7QEoh
         OyOw==
X-Gm-Message-State: APjAAAWxG0r4ZwtJ12/4FDGsyRVtN3Mp+ksaEjlKGQoFVBKornAA1wjx
        4MxTQ5Z7RHJF7c/mxNMykfYouxbvoB+mIsZGBlT1qqFsobmVNe9okLsGL5zm01Qyj/CUk8AB3yw
        UPokwkTW9vva3aUKVpOSM29hKLe4baZt2Zw==
X-Received: by 2002:aca:514e:: with SMTP id f75mr3115376oib.103.1581709929396;
        Fri, 14 Feb 2020 11:52:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLtPMdQlLScTrOTetPgaT6kdd8p1AxvVs24h10x7/BTWbS10x7a12ohDAeYuzWzJ9HJkB2NZ/ir4O5R3Dq3Qw=
X-Received: by 2002:aca:514e:: with SMTP id f75mr3115369oib.103.1581709929140;
 Fri, 14 Feb 2020 11:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20200213133959.14217-1-omosnace@redhat.com> <1a11d058-eee1-41c5-9686-da01ecf6ea33@tycho.nsa.gov>
In-Reply-To: <1a11d058-eee1-41c5-9686-da01ecf6ea33@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 14 Feb 2020 20:51:57 +0100
Message-ID: <CAFqZXNtpqOszQ5a2s86TTHtQGK_c+vqmtaRPBv04+vFAqExEmg@mail.gmail.com>
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 6:37 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/13/20 8:39 AM, Ondrej Mosnacek wrote:
> > According to profiling of semodule -BN, ebitmap_cardinality() is called
> > quite often and contributes a lot to the total runtime. Cache its result
> > in the ebitmap struct to reduce this overhead. The cached value is
> > invalidated on most modifying operations, but ebitmap_cardinality() is
> > usually called once the ebitmap doesn't change any more.
> >
> > After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
> > decreased from ~14.6s to ~12.4s (2.2s saved).
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> This seems fine but I was wondering how many of the callers of
> ebitmap_cardinality() actually need anything more than ebitmap_length()?

The caller that calls it the most (>99%) during a 'semodule -B' is
__cil_should_expand_attribute(), which logically needs the actual
cardinality. It might be possible to cache the decision directly in
'struct cil_typeattribute', but I don't know the CIL code well enough
to attempt that...

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

