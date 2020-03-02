Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE1FC3F2D2
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 12:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209BA21739
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 12:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMUgpIyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCBMua (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:50:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38676 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727484AbgCBMua (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 07:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583153429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMDkjnys4DRu20XEQeEziR8HSEYWiutGkqmInOzSMCI=;
        b=UMUgpIyx6e/m+N3rpdXShsZ/iYOec0gMDF2puK4iJF+NpM928MsJauz3y2E/qqwN00GsIn
        NwUsOfKCTnM5a85nas1MhtEHvuOr2sj84JSpphGRgaDMEZYoimfMAGPgH2qGOfrdp6fauM
        ytkHSve70vzzi1hoeLLXbc8BQfZbNdY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-784T10P2Mnez1ecu0Ywl2A-1; Mon, 02 Mar 2020 07:50:28 -0500
X-MC-Unique: 784T10P2Mnez1ecu0Ywl2A-1
Received: by mail-ot1-f72.google.com with SMTP id s11so4579934otq.22
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 04:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMDkjnys4DRu20XEQeEziR8HSEYWiutGkqmInOzSMCI=;
        b=tjDAuP99yrpT+w0UP25UP+pXMlBNTbA77FpWtoWpZ9p8BiNo1d6mCUDkB2AQW1plBt
         FRuDjdtD1oGgJGJQP0bkIKHwkVav2kPwFVKmcJMPwinR4X9V3i1vVjY11Ur8yyC8zRO7
         bbi1xrANWWGUqz4hwuEvXCCD8M85SVBGsKfrwuL0iD1wsxYUSvFvEP/V8AKWxcTS7deB
         A136wsHBz4aA6hYLZIzJ6JPiOvFI+4pI1DTeRVijHyahspXJhLBfSZKJ0l93KuGqgKAh
         /DEJUaBL5vwtIZ5Y90xoOO47Jj2j4QrEvBcDVuL+3TTvzqpeLnXFh0c4AVWsyHBZPW9E
         2XCA==
X-Gm-Message-State: APjAAAV7JuF4HsInEW9gpK3IMEHT8wiNmfsMwYsImBNbU60U8lOvcRQl
        3JKilNnYwynU6U6VZL0U7Mv3hrBGScFjaNNto8lJrtWrT/q09r81s1UW0PydEn7jFh+s7KUqCmG
        q6t1paXw02nHXO7k6IBfyy7EkeusJfy50Iw==
X-Received: by 2002:a9d:4782:: with SMTP id b2mr8738946otf.66.1583153427073;
        Mon, 02 Mar 2020 04:50:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmf2rfbhjlQdOs75fsrNJbmSkCBoLH98fnP39o3Y2WBALh6WyL1EFnr0E5+9bVesalI7NOT7NBWTZ3bzWxyng=
X-Received: by 2002:a9d:4782:: with SMTP id b2mr8738927otf.66.1583153426778;
 Mon, 02 Mar 2020 04:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20200226191659.6552-1-jwcart2@gmail.com> <CAFqZXNukDbprW41R_Hhb2HTXdunDq47eQikBt7FaygFHuz-63w@mail.gmail.com>
In-Reply-To: <CAFqZXNukDbprW41R_Hhb2HTXdunDq47eQikBt7FaygFHuz-63w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 2 Mar 2020 13:50:15 +0100
Message-ID: <CAFqZXNshZCyPE0_i0AMw3NxaufpOsEEZ1fRiYzzhce_XQpFVnQ@mail.gmail.com>
Subject: Re: [PATCH V2] libsepol: Create the macro ebitmap_is_empty() and use
 it where needed
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 9:31 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Feb 26, 2020 at 8:17 PM James Carter <jwcart2@gmail.com> wrote:
> > Create the macro ebitmap_is_empty() to check if an ebitmap is empty.
> > Use ebitmap_is_empty(), instead of ebitmap_cardinality() or
> > ebitmap_length(), to check whether or not an ebitmap is empty.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Thank you!

Applied.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

