Return-Path: <SRS0=8IdP=EM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3980C5517A
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 08:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE4D208B3
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 08:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsA+VOH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKFIsN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Nov 2020 03:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbgKFIsM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Nov 2020 03:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604652490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=akNSdNvLPnnajx6jK7BPQwI/2jOuawxzop+hGDzWRkM=;
        b=KsA+VOH9Bgsscgx7m+f6splc3YR4vpTxzBmyYx4WGEKGBpEj8rt3RR9VtFBQefq8XATYjj
        PXEYapJWxPCEQXgJ9r/go8rJIfcVeOvYaN1fhpEsEIphDxZ9JCmNytdw3FzD4iR0RU3tTh
        j8dzy5m1USNXfoHOpwU3klo29YadVxw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-HSEZkaG-N_2WInldSjp7Ow-1; Fri, 06 Nov 2020 03:48:05 -0500
X-MC-Unique: HSEZkaG-N_2WInldSjp7Ow-1
Received: by mail-lj1-f197.google.com with SMTP id m11so156537ljp.21
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2020 00:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akNSdNvLPnnajx6jK7BPQwI/2jOuawxzop+hGDzWRkM=;
        b=lZ4Yq7v1FRUjQSp6SwbH218lTs0Ps1M/qI3DZFdB/aWBNIAmlqV5zhOS9skMQogsm1
         BFoHLgyZKvJDq6Fx9dIENPNsT7PJZf4qjhMnTYoJou1AQDp3iS/7g9Xe95+q5ri3993U
         +9Wmz2WYpI2wd1FHphoLOYPXyVhRFWWst8G0TsBWY81mkAuUg6aqLxd4A8R4Mhv76nDU
         4LwDtwlM+t+x/d/bsRqEVgVae8qaHmxCuWwu8S3ETGwAMPFZ2X5HehQhPvTc8HaPpRgU
         hSQLx68rc/RqwnmTpxpQV1rDk4+BScJtdmVRWTKu0yFv6m2jSbIPs9Vd6/FEjm3yGXGK
         5jtw==
X-Gm-Message-State: AOAM5324SILG8QpZgM46Hq/pou4MBouFmKT10I43Zm6tE+2DaXdDPg0D
        XKzaifKEcZyMTi9vZDVwaVZWNpLd+VtShgwfYzCZ8ekNuj7xg4v4WVTA32IudA9ShreFEK9wnol
        8vvUthWt7d7lsPiKe3tW37hNVRvKk7XEJJA==
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr507822lff.9.1604652483636;
        Fri, 06 Nov 2020 00:48:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUGOpMljmh9ttPjJshD7XF2AeyO2HqMimeS7o20BfFzJyAmw5u7Z8/Y7W1f0mR/F+EyQw5J0yQx+O1gryn/Bw=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr507813lff.9.1604652483406;
 Fri, 06 Nov 2020 00:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com>
 <20201105173328.2539-2-olga.kornievskaia@gmail.com> <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
 <CAN-5tyF+cLpmT=rwAYvQQ445tjFKZtGq+Qzf6rDGg8COPpFRwA@mail.gmail.com>
 <a96c14c0f86ec274d5bdc255050ae71238bb43fe.camel@hammerspace.com> <CAN-5tyHc_fjDXwUngqVshB0Z7SzhAqjkXP7E=-k4sAPbfRwMmQ@mail.gmail.com>
In-Reply-To: <CAN-5tyHc_fjDXwUngqVshB0Z7SzhAqjkXP7E=-k4sAPbfRwMmQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 6 Nov 2020 09:47:52 +0100
Message-ID: <CAFqZXNu2cGC0Ub6E_b7cSY+JDk38hZt2mn7995S-1zA4Am62BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 10:43 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
> On Thu, Nov 5, 2020 at 4:18 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
> >
> > On Thu, 2020-11-05 at 14:51 -0500, Olga Kornievskaia wrote:
> > > On Thu, Nov 5, 2020 at 1:55 PM Ondrej Mosnacek <omosnace@redhat.com>
> > > wrote:
> > > >
> > > > On Thu, Nov 5, 2020 at 6:33 PM Olga Kornievskaia
> > > > <olga.kornievskaia@gmail.com> wrote:
> > > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > > >
> > > > > Currently, the client will always ask for security_labels if the
> > > > > server
> > > > > returns that it supports that feature regardless of any LSM
> > > > > modules
> > > > > (such as Selinux) enforcing security policy. This adds
> > > > > performance
> > > > > penalty to the READDIR operation.
> > > > >
> > > > > Instead, query the LSM module to find if anything is enabled and
> > > > > if not, then remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.
> > > >
> > > > Having spent some time staring at some of the NFS code very
> > > > recently,
> > > > I can't help but suggest: Would it perhaps be enough to decide
> > > > whether
> > > > to ask for labels based on (NFS_SB(dentry->d_sb)->caps &
> > > > NFS_CAP_SECURITY_LABEL)? It is set when mounting the FS iff some
> > > > LSM
> > > > confirms via the security_sb_*_mnt_opts() hook that it wants the
> > > > filesystem to give it labels (or at least that's how I interpret
> > > > the
> > > > cryptic name) [1]. It's just a shot in the dark, but it seems to
> > > > fit
> > > > this use case.
> > > >
> > > > [1]
> > > > https://elixir.bootlin.com/linux/v5.10-rc2/source/fs/nfs/getroot.c#L148
> > >
> > > Very interesting. I was not aware of something like that nor was it
> > > mentioned when I asked on the selinux mailing list. I wonder if this
> > > is a supported feature that will always stay? In that case, NFS
> > > wouldn't need the extra hook that was added for this series. I will
> > > try this out and report back.
> >
> > NFS_CAP_SECURITY_LABEL is just the NFS server capability flag. It tells
> > you whether or not the client believes that the server might support
> > NFSv4.2 requests for labelled NFS metadata.
> >
> > My understanding of Olga's requirement is that she needs to be able to
> > ignore that flag and simply not query for labelled NFS metadata if the
> > NFS client is not configured to enforce the LSM policy. The objective
> > is to avoid unnecessary RPC traffic to the server to query for data
> > that is unused.
>
> Actually that seems to be working. I think it's because while the
> server returns that it supports sec_labels, after calling
> security_sb_set_mnt_opts() the kflags_out don't have this
> SECURITY_LSM_NATIVE_LABELS set (assuming this happens because selinux
> isn't enabled) then we turned server's sec_labl cap off.
>
> I'm about to send v2 without relying on modifications to selinux.

Just to keep the LSM and SELinux lists in the loop: a v2 has been
posted to linux-nfs that uses NFS_CAP_SECURITY_LABEL instead of adding
a new hook:
https://lore.kernel.org/linux-nfs/CAFqZXNtJ2fkae7Xt-+nDR79kVs=yY=9vSoZaS-V-5UKSk22s4A@mail.gmail.com/T/

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

