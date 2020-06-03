Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E49FC433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 13:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4A520678
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 13:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZCrAcFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgFCNUj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:20:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27567 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725971AbgFCNUg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 09:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591190434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KfblRtw8zCifDQNYfRDtZSR839mX5LW25fRcG8o2JJc=;
        b=MZCrAcFA2G4A1JDnr4+9ofTKyeyvN/UsRLVpH9l0G15saLqgvtpeg+u+5gZenOixKZNlPG
        fnQ2D/wFzIhkuZCdDv/CfhsL6wLehFBLVD5pv/qG6HlStPmu3EYtZ1t6vsXkuPuRZyHUOj
        Tb823Hny0d9kyHIgv6DztajUbxGvoow=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-NDVUahOEPS-E3wJa4Pz8SQ-1; Wed, 03 Jun 2020 09:20:32 -0400
X-MC-Unique: NDVUahOEPS-E3wJa4Pz8SQ-1
Received: by mail-oo1-f70.google.com with SMTP id u4so1570586ood.6
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2020 06:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfblRtw8zCifDQNYfRDtZSR839mX5LW25fRcG8o2JJc=;
        b=QxURtwPn1kSPlNGvcwaCRJj70OOFfs4NuVSQNcJe7YK3fwHR+dyBJQQmEHrOfRAB3T
         JQokH2VPUWny2AKxreWe123oKytfComOlPf0H9MV+XTB9ZmfHKxgSiNTY7TmMR7JujSB
         7EavJBDyVWWLN4VmDGxw42Y11DfPrcGh3+wJ9dThxwMtr76pp0wXRMJ0FCtDBpGjORWE
         4a4F/iGgc85gtY1Gcb2iw+lPj2lM9G6gtdGPmIcBOGILk6CAil8mrwlTaMb/0ehk8slV
         W8ucx5JGKb9L0fjxKC6nPsIz63lTuKXjb3d8a5qcAm71LYDFVtbrpQGprp0mJzs0PX9Z
         PfdQ==
X-Gm-Message-State: AOAM532/XbvZgekVA2rcm/HDx7GLJVF6r++Ge5OApKj4hYgIJ9SL69+x
        puddH9GlL+HQrsHgxKnk3GZKZMklkoZv1DIaHaZCWh/gXkE7LgbScS42rq+kArJhSJOGCO2hZJv
        XyZobc11hD3Sm4ZlRonEWeiOIrksR2QQq6g==
X-Received: by 2002:aca:488c:: with SMTP id v134mr6479297oia.103.1591190431457;
        Wed, 03 Jun 2020 06:20:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXSmwf6nfHo5GnbtTDZSDxTECfZe/0zEI83gp10aVtG5EqMqnBb+X0cly958ecbahEenuKad1xx06cJGVL7zc=
X-Received: by 2002:aca:488c:: with SMTP id v134mr6479260oia.103.1591190431093;
 Wed, 03 Jun 2020 06:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200602174220.10210-1-stephen.smalley.work@gmail.com>
 <CAFqZXNuaqfko_PSzdw8Nwp4hEfYKmQY0ycTopuDwDPK1b2pzeg@mail.gmail.com> <CAEjxPJ7GDEr95Trh4WsSu1pXqJ_nWDW9V93isd4rmxkLN6y0=g@mail.gmail.com>
In-Reply-To: <CAEjxPJ7GDEr95Trh4WsSu1pXqJ_nWDW9V93isd4rmxkLN6y0=g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Jun 2020 15:20:19 +0200
Message-ID: <CAFqZXNvxjtEinBgCvd=1k-gKVrbKQ20pdx15L3bJ3KmSgVXrNQ@mail.gmail.com>
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

On Wed, Jun 3, 2020 at 3:12 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jun 3, 2020 at 4:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Tue, Jun 2, 2020 at 7:42 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > This is required to pass the tests for kernels that include
> > > commit a3c751a50fe6 ("vfs: allow unprivileged whiteout creation"),
> > > which changed vfs_mknod() to permit whiteout creation without
> > > requiring CAP_MKNOD and then switched vfs_whiteout() to use vfs_mknod()
> > > rather than calling i_op->mknod() directly, which was originally done
> > > to avoid such checking.  However, vfs_mknod() still calls the LSM hook
> > > and therefore applies SELinux checks on whiteout creation.  Since
> > > vfs_whiteout() now calls vfs_mknod(), SELinux :chr_file create permission
> > > is now required for such whiteout creation by overlayfs.  Skipping the LSM
> > > hook call or SELinux check entirely seems unsafe since we otherwise would
> > > never check whether the process was allowed to create a file in that label;
> > > even though the whiteout device cannot be read/written, it can be used as
> > > a channel wrt its existence and attributes.
> > >
> > > See the discussion in:
> > > https://lore.kernel.org/linux-fsdevel/20200409212859.GH28467@miu.piliscsaba.redhat.com/
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  policy/test_overlayfs.te | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Thanks, this looks good and fixes the failure for me.
> >
> > >
> > > diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> > > index b29621e..c844b82 100644
> > > --- a/policy/test_overlayfs.te
> > > +++ b/policy/test_overlayfs.te
> > > @@ -88,7 +88,7 @@ manage_dirs_pattern(test_overlay_mounter_t, test_overlay_mounter_files_t, test_o
> > >  #
> > >  # Needed to remove a transition file
> >
> > Just please also update this comment ("...to create and remove..." or similar).
>
> That wouldn't be correct.  The additional :chr_file create permission
> is needed to remove the transition file because removing a file from
> overlayfs creates a whiteout device file.  It isn't to create the
> transition file.

Ah, I see... In that case the patch is fine as-is, so:

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

