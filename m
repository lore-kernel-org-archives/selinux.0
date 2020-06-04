Return-Path: <SRS0=LEY+=7R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C2C433DF
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83D5206C3
	for <selinux@archiver.kernel.org>; Thu,  4 Jun 2020 18:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTKzwSti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgFDSRm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:17:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20955 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729856AbgFDSRl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Jun 2020 14:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591294659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0PLzsexih27i4xJTJYXpnV4R4NJ5DzN708+YOElis7o=;
        b=dTKzwStid9QIYXeMBCAiJV7gCfJJYURP4pndk84hSYuOTTz+jowhA54IwU9E2otT74mKpt
        krZ+E3N9W3uhR9JwrbZrIFTAHFGFR499ZASc00Ry7y0Qk3H8UpBLkIZqioWnXZlsj/2Ns1
        8tdUIRiNBWWwqW6/2OmihxQuV84Soh4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-5a7zDxUbNPieg0KoR5CYBA-1; Thu, 04 Jun 2020 14:17:38 -0400
X-MC-Unique: 5a7zDxUbNPieg0KoR5CYBA-1
Received: by mail-oo1-f70.google.com with SMTP id n15so3781666oov.22
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2020 11:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PLzsexih27i4xJTJYXpnV4R4NJ5DzN708+YOElis7o=;
        b=czLQvuHeCSCENf5vVVHY9QHMLpuQx+Xd8FMpI9In+Mo7vo3X9Cqd3mp8YZdYOv2s3h
         Rt8e1sdgxWw0TTfzwpQUGr7tLgXn+PT8KtJpwx+QjQzlDVnB+AzTDfVcrYiY7sMfESj8
         QDQjqrAP8l/9f0wypE6GnPedZJauXFiY/WnNcr6ORbIbvGKUca4vkTQMg6EmMa++fjYu
         4m0FESG0501gKLKeqemVAegECJcwCAFxtBHyvi+gnnI0tuAZd5zo8yAflOoCEJz5iGW9
         Fmr9DXllFYGLunxWQU4EbbV7l1wAuJ47+GmosMQEtBj4ardaI9INxFM8bq/EsWxA4gQC
         lCQA==
X-Gm-Message-State: AOAM533XHvXa8CVaHKA6GsIxu88TjjQX3pZiNFCrEM7OauKU4kgJAzrw
        fF5eQcSVj5FmZRloJxNi631fhmmNwd7f5UnEsBJw8Z3T8MyMI1hZ7p9aL55SO8SDP8get74igeG
        ASjKftsFuiO681IggYxB92b3kiBHidnZFFA==
X-Received: by 2002:a4a:abcb:: with SMTP id o11mr2010055oon.58.1591294657273;
        Thu, 04 Jun 2020 11:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbZaZ7m/c6hbrhxnOdCLete4j1UoG6ZMn2WC9twRsjaGP+opouPeoJ/t7HskTkbSMnejmFRnmYhog3IqsNsq0=
X-Received: by 2002:a4a:abcb:: with SMTP id o11mr2010029oon.58.1591294656964;
 Thu, 04 Jun 2020 11:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200602174220.10210-1-stephen.smalley.work@gmail.com>
 <CAFqZXNuaqfko_PSzdw8Nwp4hEfYKmQY0ycTopuDwDPK1b2pzeg@mail.gmail.com>
 <CAEjxPJ7GDEr95Trh4WsSu1pXqJ_nWDW9V93isd4rmxkLN6y0=g@mail.gmail.com> <CAFqZXNvxjtEinBgCvd=1k-gKVrbKQ20pdx15L3bJ3KmSgVXrNQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvxjtEinBgCvd=1k-gKVrbKQ20pdx15L3bJ3KmSgVXrNQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 4 Jun 2020 20:17:25 +0200
Message-ID: <CAFqZXNtwXNUbRTAvWnfbUO4inXa0WB2EDPq3GOtZ1wGqwO+d2A@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy/test_overlayfs.te: allow mounter to
 create whiteouts
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 3, 2020 at 3:20 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Jun 3, 2020 at 3:12 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jun 3, 2020 at 4:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Tue, Jun 2, 2020 at 7:42 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > This is required to pass the tests for kernels that include
> > > > commit a3c751a50fe6 ("vfs: allow unprivileged whiteout creation"),
> > > > which changed vfs_mknod() to permit whiteout creation without
> > > > requiring CAP_MKNOD and then switched vfs_whiteout() to use vfs_mknod()
> > > > rather than calling i_op->mknod() directly, which was originally done
> > > > to avoid such checking.  However, vfs_mknod() still calls the LSM hook
> > > > and therefore applies SELinux checks on whiteout creation.  Since
> > > > vfs_whiteout() now calls vfs_mknod(), SELinux :chr_file create permission
> > > > is now required for such whiteout creation by overlayfs.  Skipping the LSM
> > > > hook call or SELinux check entirely seems unsafe since we otherwise would
> > > > never check whether the process was allowed to create a file in that label;
> > > > even though the whiteout device cannot be read/written, it can be used as
> > > > a channel wrt its existence and attributes.
> > > >
> > > > See the discussion in:
> > > > https://lore.kernel.org/linux-fsdevel/20200409212859.GH28467@miu.piliscsaba.redhat.com/
> > > >
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > >  policy/test_overlayfs.te | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Thanks, this looks good and fixes the failure for me.
> > >
> > > >
> > > > diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> > > > index b29621e..c844b82 100644
> > > > --- a/policy/test_overlayfs.te
> > > > +++ b/policy/test_overlayfs.te
> > > > @@ -88,7 +88,7 @@ manage_dirs_pattern(test_overlay_mounter_t, test_overlay_mounter_files_t, test_o
> > > >  #
> > > >  # Needed to remove a transition file
> > >
> > > Just please also update this comment ("...to create and remove..." or similar).
> >
> > That wouldn't be correct.  The additional :chr_file create permission
> > is needed to remove the transition file because removing a file from
> > overlayfs creates a whiteout device file.  It isn't to create the
> > transition file.
>
> Ah, I see... In that case the patch is fine as-is, so:
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

This patch is now applied.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

