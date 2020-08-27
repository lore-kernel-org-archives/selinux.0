Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860A0C433DF
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 07:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B91B20738
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 07:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXFDqSFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgH0Hko (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbgH0Hkn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 03:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598514042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOlybJI+gZeXIBGy69vhC/mB6fchbn0JCMCMLtd7/BU=;
        b=YXFDqSFzeou2EaFZ2i16MrqEhNHwO35r+FnoFQOr3ujiPtBEK04WYCzNzpATPUzJKY6EX5
        ouMi57ZOIZwFGkKFKj6k+tJ6aEvkLInmhQ56+votVu857g/DEoSJ+sEHYB4zQV8HCG8ajS
        Ch8OQxVp9+xbNIq1EunEoh6rh5WliTM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-5Rd_kaz2M6ufb51Fu6LhBw-1; Thu, 27 Aug 2020 03:40:40 -0400
X-MC-Unique: 5Rd_kaz2M6ufb51Fu6LhBw-1
Received: by mail-lf1-f70.google.com with SMTP id a13so1260130lfo.21
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 00:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOlybJI+gZeXIBGy69vhC/mB6fchbn0JCMCMLtd7/BU=;
        b=FRex88jblghwy+5vCtfJrBOTALdjtpNzD5CGIgZ8bw+8x4h3nlQ/XuNVuVV7wJakBl
         as+emyBvpkVSZG2g5Yy1nnu9OUbQDZkDp/I6XcG0kaA52E+gjyLcDMuU93gUw+iYwojm
         hKUwt4BC5+YEjYL7TpXAlfORzX9m0wMBwffOEZVt30EkClmRhyB8eSzofWuYNoThgmZ+
         22rXyaZrSXatK1sFPqkkUp3Mfg6KZWT4xwnHYmeDjsJJlsQvI2Y+Oog08og8rM1gzhy1
         QgZ7LC7B2zd9DFCM3Qw47DnSy85UX8AZP3aU1nrYxCA5sa+fxlE2h7PipwuadnWBWsSQ
         JVmQ==
X-Gm-Message-State: AOAM531NQNqHPTD8XlGDTfz4Nah2ebVxd0mMXEOXvPkNuDQM9GSRiOgO
        2QweGWSfBBiXDOTrFwsXb92SnWHW9jGeXqEO3HbFkkLZ0sz85GAoBfrx2Gv6nGuZRM7P0yjWVJT
        t2Baethnxq97TD2K35YvsQOtwu34w/5yjKQ==
X-Received: by 2002:ac2:5b0b:: with SMTP id v11mr9155104lfn.3.1598514038968;
        Thu, 27 Aug 2020 00:40:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKaOSf5fhXYr4pRUblrCXXlx/6t7sT59Yk185l3b3QHr5lxRTw43me2pvNV2xm9GhBexUJgH/hktH4s5Jd450=
X-Received: by 2002:ac2:5b0b:: with SMTP id v11mr9155093lfn.3.1598514038658;
 Thu, 27 Aug 2020 00:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-3-omosnace@redhat.com>
 <CAEjxPJ7V3XW+wCVpNUitD_cc2GoVjM0mm-zWrDWcxLd7wcv_Eg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7V3XW+wCVpNUitD_cc2GoVjM0mm-zWrDWcxLd7wcv_Eg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Aug 2020 09:40:27 +0200
Message-ID: <CAFqZXNvQdzPCrPSd+eO9FS0iBy9DaA6QS=DVDGVCStSYeGzOUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selinux: eliminate the redundant policycap array
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 4:12 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The policycap array in struct selinux_state is redundant and can be
> > substituted by calling security_policycap_supported().
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 7cc2f7486c18f..e82a2cfe171f3 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2113,30 +2113,6 @@ bad:
> >         return 0;
> >  }
> >
> > -static void security_load_policycaps(struct selinux_state *state,
> > -                               struct selinux_policy *policy)
> > -{
> > -       struct policydb *p;
> > -       unsigned int i;
> > -       struct ebitmap_node *node;
> > -
> > -       p = &policy->policydb;
> > -
> > -       for (i = 0; i < ARRAY_SIZE(state->policycap); i++)
> > -               state->policycap[i] = ebitmap_get_bit(&p->policycaps, i);
> > -
> > -       for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
> > -               pr_info("SELinux:  policy capability %s=%d\n",
> > -                       selinux_policycap_names[i],
> > -                       ebitmap_get_bit(&p->policycaps, i));
> > -
> > -       ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
> > -               if (i >= ARRAY_SIZE(selinux_policycap_names))
> > -                       pr_info("SELinux:  unknown policy capability %u\n",
> > -                               i);
> > -       }
> > -}
> > -
>
> Two requests:
> 1. Can you do a little benchmarking to confirm that calling
> security_policycap_supported() each time doesn't cause any significant
> overheads?  Networking benchmark might be of interest.

I tried to sample a simple `ping -f -i 0 -c 5000000 127.0.0.1` with
perf and indeed security_policycap_supported() now makes up about half
the time spent in some hooks (selinux_socket_sock_rcv_skb(),
selinux_ip_postroute()), mainly because of ebitmap_get_bit() it seems.
I'll try moving the array to policydb and using it in
security_policycap_supported() instead of the bitmap.

>
> 2. Can you retain the logging of the policy capability values?  Just
> drop the first part of the function and rename it e.g.
> security_log_policycaps().

Sure, somehow I failed to notice those prints...

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

