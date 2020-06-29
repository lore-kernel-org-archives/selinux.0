Return-Path: <SRS0=DMlc=AK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD53C433E1
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 21:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E1420656
	for <selinux@archiver.kernel.org>; Mon, 29 Jun 2020 21:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHInT9fC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgF2Vlx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:41:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726560AbgF2SjU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jun 2020 14:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593455959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gu279wuxQ+5mqY38We44kKjpbnmRFaU4VOfe0z0EkIw=;
        b=OHInT9fC9PXcxmUGFIohzRV+6fXoH0XPxvvo/uBcKffesJpOhpl5szQ70RpfL3JWcETVoe
        H9uw9r/BsvFUdmXtbvnSfBYGzkQBm9Lodlkp4x+BWe5qFf78V2qdPV5fD1y5tJGbmQ3S0a
        b2ZDB7OV3XXQLE+S6zH7W2g5phZWIhs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-oUQtGrX8MT6FFC9JcYgeIg-1; Mon, 29 Jun 2020 08:38:01 -0400
X-MC-Unique: oUQtGrX8MT6FFC9JcYgeIg-1
Received: by mail-lf1-f71.google.com with SMTP id t184so9760945lff.13
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2020 05:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gu279wuxQ+5mqY38We44kKjpbnmRFaU4VOfe0z0EkIw=;
        b=ZfO/g5t4aDVuO+Tz4PiG+6L4j5+lVbQKQCBwNoj4FDrTQgufJU3tbWO0oArMMAnpDJ
         pUooguLHpFDcvbeU6FVDoLq3mhXj57H/wGoOtvbTPC7FvN39+20rjJHNdZaYxKotzdLQ
         9dL2m4BnsamRo9tNnvESTMKlQAKb+nlsNiv2fbUF4yfWYbr/mvfYDHcbpNBIAEYvicvT
         vNjEx1O+GE26Ez7oL3e5aom30t3dsaEEIzwEoY+w7TL2qiDtTV/Hr10a65HuopVGRUfG
         m43iu09+VCFYxuLl/b6dVJMoVReDXUZSvet6Rc+YVBjzBmqE++7BohmZi+x5JhA0/vc6
         IBwg==
X-Gm-Message-State: AOAM532cmVvSu4xXxDfQGhw/0z9piSRIlBGdWjFkeLRmGRADga50bB5t
        HpefIBcZZ0qBZkho+0EJK9bN3nV2Cy1iTeIwfkDc5Rfep86MTb0LNAbbg/qSFQQu4LuYhEEc7l2
        cNfw8ee/tyr85TqkT7tlTi5wCQK8Il8JHoQ==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr1144855ljn.38.1593434279660;
        Mon, 29 Jun 2020 05:37:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6Iyjxkbn+6HN4nTwcz6bwk0M4+wMs8KpTjyGs7yCoOMCADjJtrmxOS/Jxf6d1aehOJ1n/ljMZOx8/BLEWBrc=
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr1144848ljn.38.1593434279371;
 Mon, 29 Jun 2020 05:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200626114359.80134-1-omosnace@redhat.com> <CAEjxPJ5+FhHLp01JWaALV6TCwkFP4PO=Y9KrjhKJCS-potV1TQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5+FhHLp01JWaALV6TCwkFP4PO=Y9KrjhKJCS-potV1TQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 29 Jun 2020 14:37:48 +0200
Message-ID: <CAFqZXNuDuj2VVpWiUp5FbFtEVRpK0n=_KqdZmBkx2kwV-t0_9w@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: fix `make conf` invocation
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 26, 2020 at 2:49 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jun 26, 2020 at 7:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > In refpolicy when a module is added/removed, the policy build config
> > may need to be rebuilt. Currently we run `make conf` just once and then
> > reuse it via cache. Instead, we need to run it unconditionally, since
> > the other targets won't trigger that implictly.
> >
> > In Fedora policy the default module config is included and maintained in
> > git, so we don't need to (and must not) call make conf at all.
> >
> > Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Feel free to apply whenever; I will not be around next week to do so.

(Take 2, since the vger server seems to have been down when I sent the reply...)

Thanks, it is applied now and the Travis build passed:
https://travis-ci.org/github/SELinuxProject/selinux-testsuite/builds/703080617

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

