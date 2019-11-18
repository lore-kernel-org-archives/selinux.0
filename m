Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBEEC432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 16:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A332621844
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 16:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdvbL4Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKRQPn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:15:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59484 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726423AbfKRQPn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 11:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574093742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/JBkIAUaLNyA1dTvSwh7KYASr3OU6X9Wwuk7QmZbF4=;
        b=EdvbL4ZkD4b33Np8ecjfQf+bAVB5ItxRH1uGC9S2WSQ15Wm6cfmutJK7SZQezBfCDZ4Cpf
        d/sL0k/SdQcllrIa0vLgQ2XqzUfWIv+kaS7TQqpIuGhpanaCsA7VDK4DEpGtNPLRCTbD1W
        W5fmPdROHgoUFgp831VhJ6agMtSf3Wo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-9lOfz_dNMLiyHxTc_WDovw-1; Mon, 18 Nov 2019 11:15:40 -0500
Received: by mail-oi1-f197.google.com with SMTP id l67so8956204oih.4
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 08:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tmwvUvqOR1DzWUNViZpQgRZ2jDXruON43u9SDwCyFA=;
        b=s+HO0xEbohmaF9lCPmQBg1n5zLdi/CYFpc3Rqxh24jqHuPuvZByp680ItijjH92Ttg
         KoB9mAPdKrOYYotUP4G8iIbGJQpx+wHxMd5fqCKysjJgmJXYAWzyPP2JYpT0YFETRNjf
         z/LaXqxTQ87Vec6jTtSxFfiofksOXNNcepRXjUxHK+63BSPks1E46L5rh9FqNHzTxQ9A
         SpziSY95kbY+1ppQ7zzL+blhz9LNjlAbSJ5TG0bFfnsR62GPEQC9XYLeyJICecxXWNDN
         xKZeSiTSitZQY/qlFMkOf+YTLLweDWymeOUR0nh/N1dYWfNBlfLDnydcwl6bmb9ydBTv
         dVzQ==
X-Gm-Message-State: APjAAAXkA8KFEo+7cQmmWRweWC7GsQKgxWOegJRiH3A07Ji57Zpbjx+y
        tHyTu7MI/VXpIMFHIC8OsMoCQUdxNMHqI5u+7yAD0jC/NVX85x0s63UUfgKvTmD32cpt0pbvCvR
        4usUfKv2gbw30N8UToNwRJlVgK0GfbVyyCg==
X-Received: by 2002:aca:da87:: with SMTP id r129mr14804707oig.26.1574093739520;
        Mon, 18 Nov 2019 08:15:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvOZZcPtFGQ7xxngCCXGsE+4++ch5EBsdz2Y+ka54PReENZ6+RYm0nSBDL+t5NB1jmW7v0FDmrAdpGMr2Iutk=
X-Received: by 2002:aca:da87:: with SMTP id r129mr14804688oig.26.1574093739191;
 Mon, 18 Nov 2019 08:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20191115114429.18566-1-richard_c_haines@btinternet.com>
 <CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo78s+geSsBok8=Q@mail.gmail.com> <068a7a76-02c8-a30f-18ec-2a692e3e157b@tycho.nsa.gov>
In-Reply-To: <068a7a76-02c8-a30f-18ec-2a692e3e157b@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 18 Nov 2019 17:15:30 +0100
Message-ID: <CAFqZXNv=qQAzLMXfVPwef6_xdRFgohup1ueiv2+=jvsEDHmz4g@mail.gmail.com>
Subject: Re: [PATCH V2] selinux-testsuite: Add kernel module tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 9lOfz_dNMLiyHxTc_WDovw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 18, 2019 at 4:51 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/18/19 4:10 AM, Ondrej Mosnacek wrote:
> > A couple comments below...
> >
> > On Fri, Nov 15, 2019 at 12:44 PM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> <snip>
> >> +########### Allow these domains to be entered from sysadm domain ####=
########
> >> +#
> >> +miscfiles_domain_entry_test_files(finitmoddomain)
> >> +userdom_sysadm_entry_spec_domtrans_to(finitmoddomain)
> >> +miscfiles_domain_entry_test_files(initmoddomain)
> >> +userdom_sysadm_entry_spec_domtrans_to(initmoddomain)
> >
> > It seems that the finitmoddomain and initmoddomain type sets are
> > exactly the same except for names - can they be merged into just one
> > set of types? The AVC denials should be still easily distinguishable
> > by the comm=3D field if that's the intended purpose of the separation.
>
> Do you just mean coalesce the type attributes together or coalesce the
> individual types to which they refer?

I meant the latter.

>
> If the former, then the denials will still be distinguishable based on
> individual types; the attribute names are only used in policy not
> denials.  Coalescing the attributes makes sense to me too.
>
> If the latter, the individual types differ in that test_finitmod_t is
> only allowed module_load to a specific file type (test_file_t), i.e. it
> can only load modules from files with that type via the finit_module(2),
> whereas test_initmod_t is allowed module_load to self as the fallback
> when using init_module(2) and hence can load a module content at all.
> So coalescing those would detract from testing.

Ah, so there was a difference between them that I was missing :) In
that case please disregard my comment.

I don't have an opinion on whether to coalesce the attributes. It can
stay as it is as far as I'm concerned.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

