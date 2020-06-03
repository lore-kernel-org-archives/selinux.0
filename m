Return-Path: <SRS0=TAN+=7Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A7C433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B8820738
	for <selinux@archiver.kernel.org>; Wed,  3 Jun 2020 13:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv5QIXAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgFCNMW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCNMW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jun 2020 09:12:22 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E94C08C5C0
        for <selinux@vger.kernel.org>; Wed,  3 Jun 2020 06:12:22 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id v1so494681ooh.0
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2020 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LV2XA5j5bMuZltpR3BtOflo2QyqKkBipbO+iQaEevoc=;
        b=qv5QIXAC1bCwKfSA1hwtKAMLzrAOVtB6vcRKxgu1+qgHI4Ifsj8Uw0jmG36pmtJ1Z6
         pcEqFwc2hcC0xyCALcUprQan6lX1oS0AB2KTbo2BDD10DxWQiJsrekoxgMxWLkeWiYys
         di8Y7xXz2l8VIqgK7d+ior7NYuz2cYkIJFyoUsUlaEjiRefyMvvZ9PZ30kbk2Nsd0yWu
         cysl3MFtO6DlPgt9VSXcOP46bNnc2IjNFKlK1cKf3M9IP38I8GZSrNCmcZlu/OPRwyVA
         T8Ig5yFek8OiksLzhU4hWL0VF7NE1FRrVVB24bTAIjo7kdXf8RwboQTzi2xMOm4pF2fd
         w5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LV2XA5j5bMuZltpR3BtOflo2QyqKkBipbO+iQaEevoc=;
        b=Fkql0S8H3aSbfmHF/1kztPqyoNEmBrFYVnMe3W/6hcZkTp/l4NQ4B+o78ZO1uLdXqE
         0PHoNbfB3U3QFUaihGJGLNjCJgU4arFYnBiC7NM/jqO4Cpi1ShIt6ljyy52rqynldTI3
         33G56ympdhBlKVOVPhxWgDkrT+RSo57hdrKqkSmRiQa8k1CNyLGSoefb7XSLJ1xRda3z
         QvhM/w7TDrgMKZ+Q2RglL2io1OzE10Kg1dJIFCpO4QAXy19TwRB6rIWI1mDKgqk8bgAm
         8J31GIk643c254jC0rfWQk03dMeeTS8b4x41fRpFUEeKy0xstcQ3yL4znFeEnvOnh7FE
         SB7g==
X-Gm-Message-State: AOAM533wZRq9qukjzFjrHHaszMhS0C8a5sqPvWZzhuTu7mIuZVw9E8EB
        jvzh4LYIL47EZviX+WurfjN2dCUVE2YozDy4C/Eg0Baw
X-Google-Smtp-Source: ABdhPJxel0W6FuNC8u15woVUnslE8bjS6mBYVycWwrAlVO7rOtJUfHtpzCrAbxafUu9bKDT0jIPwkODk4e/cL+kfAMU=
X-Received: by 2002:a4a:ca03:: with SMTP id w3mr14684562ooq.13.1591189941299;
 Wed, 03 Jun 2020 06:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200602174220.10210-1-stephen.smalley.work@gmail.com> <CAFqZXNuaqfko_PSzdw8Nwp4hEfYKmQY0ycTopuDwDPK1b2pzeg@mail.gmail.com>
In-Reply-To: <CAFqZXNuaqfko_PSzdw8Nwp4hEfYKmQY0ycTopuDwDPK1b2pzeg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 3 Jun 2020 09:12:10 -0400
Message-ID: <CAEjxPJ7GDEr95Trh4WsSu1pXqJ_nWDW9V93isd4rmxkLN6y0=g@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy/test_overlayfs.te: allow mounter to
 create whiteouts
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 3, 2020 at 4:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Jun 2, 2020 at 7:42 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > This is required to pass the tests for kernels that include
> > commit a3c751a50fe6 ("vfs: allow unprivileged whiteout creation"),
> > which changed vfs_mknod() to permit whiteout creation without
> > requiring CAP_MKNOD and then switched vfs_whiteout() to use vfs_mknod()
> > rather than calling i_op->mknod() directly, which was originally done
> > to avoid such checking.  However, vfs_mknod() still calls the LSM hook
> > and therefore applies SELinux checks on whiteout creation.  Since
> > vfs_whiteout() now calls vfs_mknod(), SELinux :chr_file create permission
> > is now required for such whiteout creation by overlayfs.  Skipping the LSM
> > hook call or SELinux check entirely seems unsafe since we otherwise would
> > never check whether the process was allowed to create a file in that label;
> > even though the whiteout device cannot be read/written, it can be used as
> > a channel wrt its existence and attributes.
> >
> > See the discussion in:
> > https://lore.kernel.org/linux-fsdevel/20200409212859.GH28467@miu.piliscsaba.redhat.com/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  policy/test_overlayfs.te | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks, this looks good and fixes the failure for me.
>
> >
> > diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> > index b29621e..c844b82 100644
> > --- a/policy/test_overlayfs.te
> > +++ b/policy/test_overlayfs.te
> > @@ -88,7 +88,7 @@ manage_dirs_pattern(test_overlay_mounter_t, test_overlay_mounter_files_t, test_o
> >  #
> >  # Needed to remove a transition file
>
> Just please also update this comment ("...to create and remove..." or similar).

That wouldn't be correct.  The additional :chr_file create permission
is needed to remove the transition file because removing a file from
overlayfs creates a whiteout device file.  It isn't to create the
transition file.
