Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1771C33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7412206D9
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOujkYqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgAPQVw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:21:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41462 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgAPQVw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 11:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579191711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3N7OqoLUmvvlWWKU6tThe0biTBZ6e8LL6Hyc/mDDk1U=;
        b=YOujkYqzAQ2iO1ytOEEJPxXJcC8Xc2o5wYFVmj0KlUPvprqkRTzt1w/OVLbNIVoQgT5uh/
        8d3kM+GJ47R700D4ZWiB3u4bfZbEDPln7HFRRH6Kcb/Qg79HfFblE2/b1SxaUGDF7zRAIr
        D6OZlMQQ4DgWoah4tGgN1fR81zCvjHc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-YBi3hoCeOfuxB0ouO4glOw-1; Thu, 16 Jan 2020 11:21:49 -0500
X-MC-Unique: YBi3hoCeOfuxB0ouO4glOw-1
Received: by mail-oi1-f197.google.com with SMTP id w205so8074593oie.13
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 08:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3N7OqoLUmvvlWWKU6tThe0biTBZ6e8LL6Hyc/mDDk1U=;
        b=cvE4t4i+IcezxE0DiY8s+OopQG+dTdSHo0Qt2VQ1pZQuJl7jbNGDyinfYRtnCgCJMz
         T3nt+GqRlUSr9dyq5jjlcRiZ80MnhXVUNqe853zZpyPI9CEWJK+DsApfGMABFOlAjaAT
         PJ/JUOVuOiyu4nNy5KHxaRu+sZjYCkb8pnmv0paXp/d9Nm5iU6mywbMGVo6EVq9aBTXT
         e3GY96UmIUPbiaHeHI2RNUrtA8OC8IE7pf10lRrvh+yeKDsMa5Dh1kuXMa9LENbhkLdI
         P5+JFv+jhU5/TbSpMsUgHk0MflVwG+jNGBOTj5Rj3brthtUrBg7AGVEC5Y5wOq5p1c6m
         Rm6w==
X-Gm-Message-State: APjAAAUVlhcyOV0G/2cPufLHHbN9Mrs5ijB2C7emwnq2HbE98trjZp68
        HTMDNKtpyYrT/LJH8Qpj3EBsu1S5oueZt3kT+OifnZX9qlKwFGe4uxEd/zgA35vM2QC6OEtXJ+X
        I15KeDodxe2jqQ7ao65H3xu8CsTi+WTgZUg==
X-Received: by 2002:aca:c30d:: with SMTP id t13mr4756167oif.166.1579191708984;
        Thu, 16 Jan 2020 08:21:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtrODb/BN3dEcMHlaUDK0aNakM9ndEuuyM5y/We23o5uSqYfg5zHUpsOsICHWTk+PbWfRSGTqK3O5Magk3MUI=
X-Received: by 2002:aca:c30d:: with SMTP id t13mr4756138oif.166.1579191708668;
 Thu, 16 Jan 2020 08:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20200116131928.315533-1-omosnace@redhat.com> <c26b26d4-9fcd-8802-bf3b-f5e0f75a0730@tycho.nsa.gov>
 <ede9c1eb-2c60-44fd-336d-c8b802833393@tycho.nsa.gov>
In-Reply-To: <ede9c1eb-2c60-44fd-336d-c8b802833393@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Jan 2020 17:21:37 +0100
Message-ID: <CAFqZXNtuq2FYBbQenLpJarckXfmgyGC_f3XgB=d+ye_tSoLuuw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix sparse warnings in policydb.c
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 16, 2020 at 5:10 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/16/20 11:08 AM, Stephen Smalley wrote:
> > On 1/16/20 8:19 AM, Ondrej Mosnacek wrote:
> >> Two places used u32 where there should have been __le32.
> >>
> >> Fixes sparse warnings:
> >>    CHECK   [...]/security/selinux/ss/services.c
> >> [...]/security/selinux/ss/policydb.c:2669:16: warning: incorrect type
> >> in assignment (different base types)
> >> [...]/security/selinux/ss/policydb.c:2669:16:    expected unsigned int
> >> [...]/security/selinux/ss/policydb.c:2669:16:    got restricted __le32
> >> [usertype]
> >> [...]/security/selinux/ss/policydb.c:2674:24: warning: incorrect type
> >> in assignment (different base types)
> >> [...]/security/selinux/ss/policydb.c:2674:24:    expected unsigned int
> >> [...]/security/selinux/ss/policydb.c:2674:24:    got restricted __le32
> >> [usertype]
> >> [...]/security/selinux/ss/policydb.c:2675:24: warning: incorrect type
> >> in assignment (different base types)
> >> [...]/security/selinux/ss/policydb.c:2675:24:    expected unsigned int
> >> [...]/security/selinux/ss/policydb.c:2675:24:    got restricted __le32
> >> [usertype]
> >> [...]/security/selinux/ss/policydb.c:2676:24: warning: incorrect type
> >> in assignment (different base types)
> >> [...]/security/selinux/ss/policydb.c:2676:24:    expected unsigned int
> >> [...]/security/selinux/ss/policydb.c:2676:24:    got restricted __le32
> >> [usertype]
> >> [...]/security/selinux/ss/policydb.c:2681:32: warning: incorrect type
> >> in assignment (different base types)
> >> [...]/security/selinux/ss/policydb.c:2681:32:    expected unsigned int
> >> [...]/security/selinux/ss/policydb.c:2681:32:    got restricted __le32
> >> [usertype]
> >> [...]/security/selinux/ss/policydb.c:2701:16: warning: incorrect type
> >> in assignment (different base types)
> >> [...]/security/selinux/ss/policydb.c:2701:16:    expected unsigned int
> >> [...]/security/selinux/ss/policydb.c:2701:16:    got restricted __le32
> >> [usertype]
> >> [...]/security/selinux/ss/policydb.c:2706:24: warning: incorrect type
> >> in assignment (different base types)
> >> [...]/security/selinux/ss/policydb.c:2706:24:    expected unsigned int
> >> [...]/security/selinux/ss/policydb.c:2706:24:    got restricted __le32
> >> [usertype]
> >> [...]/security/selinux/ss/policydb.c:2707:24: warning: incorrect type
> >> in assignment (different base types)
> >> [...]/security/selinux/ss/policydb.c:2707:24:    expected unsigned int
> >> [...]/security/selinux/ss/policydb.c:2707:24:    got restricted __le32
> >> [usertype]
> >>
> >> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> However, note that checkpatch doesn't like your subject line.
> WARNING: A patch subject line should describe the change not the tool
> that found it

Hm, I run checkpatch.pl from a pre-commit git hook, so it likely only
looks at the diff itself... I'll see if I can tweak the hook to check
a full patch generated from the commit.

It has a good point, though. I'll reword the subject.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

