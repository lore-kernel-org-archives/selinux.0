Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B09BC433ED
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 14:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8DF61433
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhD1O2a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhD1O2a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 10:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619620065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZ9YPVDmnzNgB13RkB7XvgXIuC+t25XF/qjM/sXwn2E=;
        b=PXbBMx2LQtLA3DohYacMPouQCz0LWfmsQl5ObteUG7xHrHERVzZ2uDw1/SRfaaO+YDXJSe
        UwBUCYBprCwfQ6owiB4gHyaKHd2/0Xmb+we1/UMoniWZ1hMFyJE39q7CEUb5hEMbbEZPZf
        MdwLhGNJopFnRXAYynDlaaNDNFfww+M=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-gDtiPZ7hMSWxu61cpGrKsg-1; Wed, 28 Apr 2021 10:27:42 -0400
X-MC-Unique: gDtiPZ7hMSWxu61cpGrKsg-1
Received: by mail-yb1-f199.google.com with SMTP id i8-20020a0569020688b02904ef3bd00ce7so1670218ybt.7
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 07:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZ9YPVDmnzNgB13RkB7XvgXIuC+t25XF/qjM/sXwn2E=;
        b=FijX+JbefQmq+szisoK54dBX0c2jqCVZi1Onp+Nv9nP98Y7NsfSHHqzMWBGzx9ZX6o
         Uom2QdDMBM44cuo3EzPK3z6phD20tSJU0/3nI92aB+Gy5kLdbylKGotxvbAnROpOG9ZV
         wjRPQ3FAfOGueZMHiaI7qOjue9tMq//r2HxCC+HQFmFFUk2d/s3X4OlidDinuBe98Y88
         A0ZEwDNMaQQBJaNWFa0BYmNRt0gXIlh6P50FD5OxHjPrMGOQY9cuUXUWrHBxxMFL4pqX
         S3fv/CPXZ+ryth0BBK+MeDaSduN1MWh838EZPSNozFfMHKnUucGsoMyzAbQC0sEgCYmO
         UY5Q==
X-Gm-Message-State: AOAM533zsbdp41W+TwmkR67FtnDTV2Uy5ZN/7rUPNLuuKAkqamwpOpVc
        upVNbPNKXQ4lBBT1swv85lQG3NgBbi9lilUJTz9rx3fnODGfQvPpph+vNovw6Cir8f1+XrNurmd
        Ga0h4KSO8GbV03ERZb3jOE5B6i2iWoZeieQ==
X-Received: by 2002:a25:cccd:: with SMTP id l196mr2838737ybf.26.1619620060394;
        Wed, 28 Apr 2021 07:27:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBtMoEKIyr1Bo7m89rYmGo4Gr0LyFXf237e6FyvRznXGAWhtgZggtBY96zNOmsBJYdqE/g/XrH+tkpYpIIMi0=
X-Received: by 2002:a25:cccd:: with SMTP id l196mr2838706ybf.26.1619620060171;
 Wed, 28 Apr 2021 07:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <161955450031.8261.16400002795828868356.stgit@olly>
 <CAFqZXNtwXv8zydfY=oZLD4Ca5m26Ci9MKmRa184GCLpx919zZQ@mail.gmail.com> <CAHC9VhR3HSjQH1DJ=uHr9JPG=iF6LcvZAq3dD6eFF=8dJfiXhA@mail.gmail.com>
In-Reply-To: <CAHC9VhR3HSjQH1DJ=uHr9JPG=iF6LcvZAq3dD6eFF=8dJfiXhA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 28 Apr 2021 16:27:29 +0200
Message-ID: <CAFqZXNumw9=xU9aTUsYUnDQ55bdgtYYwhkLFMy6DiF_Q-LqVtQ@mail.gmail.com>
Subject: Re: [PATCH 2] testsuite: fix cap_userns for kernels >= v5.12
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 28, 2021 at 4:11 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Apr 28, 2021 at 6:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Apr 27, 2021 at 10:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > > Starting with Linux v5.12 CAP_SETFCAP is required to map UID 0/root.
> > > This is due to kernel commit db2e718a4798 ("capabilities: require
> > > CAP_SETFCAP to map uid 0").  In order to resolve this in the test
> > > suite allow the cap_userns test domains to exercise the setfcap
> > > capability.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  policy/test_cap_userns.te |    3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
> > > index ab74325..9683870 100644
> > > --- a/policy/test_cap_userns.te
> > > +++ b/policy/test_cap_userns.te
> > > @@ -12,6 +12,9 @@ unconfined_runs_test(test_cap_userns_t)
> > >  typeattribute test_cap_userns_t testdomain;
> > >  typeattribute test_cap_userns_t capusernsdomain;
> > >
> > > +# linux >= v5.12 needs setfcap to map UID 0
> > > +allow capusernsdomain self:capability setfcap;
> > > +
> > >  # This domain is allowed sys_admin on non-init userns for mount.
> > >  allow test_cap_userns_t self:cap_userns sys_admin;
> >
> > Thanks! Would you mind if I move the new rule to the end of the file
> > (where other rules for the attribute live) and tweak the subject line?
> > The final commit is available for preview here:
> > https://github.com/WOnder93/selinux-testsuite/commit/fd4254f09316f6db0410a9187cb8866571f109b5
>
> Sure, do whatever you think is best; you can even replace my little
> patch with another that you like better.  My main concern is just
> making sure the test suite is fixed and working :)

Ok, I have just pushed it:
https://github.com/SELinuxProject/selinux-testsuite/commit/fd4254f09316f6db0410a9187cb8866571f109b5

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

