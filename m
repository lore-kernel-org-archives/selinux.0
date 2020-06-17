Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84652C433DF
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D38208B8
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 13:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn/fAVxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFQNfu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgFQNft (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 09:35:49 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478AC06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 06:35:49 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id f2so396417ooo.5
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8pQFzfwLvZutf+b075CecvgC/oFluL6XoqK98u1fbY=;
        b=dn/fAVxV7z1IFUc0YHG0K6qKASvXkpoVWVgAdATQ1uviXNIPQJMFHfAe/sJcrc7P/e
         dgVbExD0HKR/Qb3LgwGAz42NIpuvU2t2WC9oHoPNY8Bd/ZbIzpAfddV/+8O5eT+mu5OY
         sX111gtu+D94c7LrYB0XZ3pbtkbbyy1MCJAFJ9YJ0RJCruqDXFCr6NFTs/SvIbDl3uXD
         +cDAMR0NVT/TicdrnYMiGVjP6ix2uafjYpQ1OY410IBMDjS+19aWzI3V/xtRDSJzj7qx
         g5gVmYKbn7fMGQWUjpwLZ7TJcjxdJNvJa5mJ/nqWe+6uCokbynBTWy6nLC4HSRHxqPmZ
         JuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8pQFzfwLvZutf+b075CecvgC/oFluL6XoqK98u1fbY=;
        b=qQY47PXdAExVV6Ps1K8rP1fLMZKSZOoVxndoS6LZOUE+2Q/955Bsj3IIhgwyemlpHn
         QsgSVBV0vddKDIbeZpZq7n64oF3c52MY4ZOMfLq9rSPm/Oe1MDWcEZnj4/5fFA9oCXdv
         HvP2a7zSIfAZuqv4WpIEEzQ2ntmUo7iVlOxo2mVOj8YJVJHnCyhmki7QbyMlfvy5/DzL
         vOqRO1mCstYG7EJ22JioP1oY2CwfAS3yHxdSe5TQtYF5LaozYKczuKooQVrOP1qQ2Xh4
         279koj3zxCmj8vIMR0/E7lTq8+oYW13uPK4j8c7rJAQOKNPeMRxMOYGQuxXDrh+cjMvz
         I4HQ==
X-Gm-Message-State: AOAM5319W73XqMOmIA3TkLbn5iwotLI3YzneAOUt0pcB2FM6PsNFaFgS
        dG1LodG3Nr5AzAAMTW6T13YwxGxdaj/e28pZseo=
X-Google-Smtp-Source: ABdhPJzO2JdWTEM+H1ODRHERPN3kEpS+7uV+ErTLiK5S++9Ltt9WKQ/xnjYQHATbSZfFs4EBLpZvbGEv5Yy5g5BC5lo=
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr6653051oov.71.1592400948191;
 Wed, 17 Jun 2020 06:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <3a60cdb1-3e30-da2a-8225-abfdc0f6b3d7@gmail.com> <CAEjxPJ4+cVRjWZ3=j7DoOadBarZBteqAsanCTp+fnH+ztpER9g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4+cVRjWZ3=j7DoOadBarZBteqAsanCTp+fnH+ztpER9g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 17 Jun 2020 09:35:35 -0400
Message-ID: <CAEjxPJ7rygAQjqYBiYHRw__cJjO4mJdV_7K38aG=i19s2_-FNg@mail.gmail.com>
Subject: Re: Minimal CIL policy requires process class with transition permission
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 17, 2020 at 9:24 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 17, 2020 at 7:10 AM bauen1 <j2468h@googlemail.com> wrote:
> >
> > Hello,
> >
> > I've recently started playing with CIL and for various reasons I wanted
> > to start with the smallest possible policy.
> >
> > After having some issues with a tiny CIL policy that compiles but does
> > not actually load, I tracked it down to a hard requirement (of the
> > kernel ?) on the permission `transition` of the `process` class.
> > Is there a reason for this or is this a bug ?
>
> Yes, the kernel security server depends on at least this class and
> permission being defined in policy for some of its internal logic;
> otherwise you will get some rather odd behavior.  I suppose we could
> make the kernel handle it more gracefully, or change libsepol to catch
> this and flag it as an error when writing a policy with the target
> platform set to Linux (it wouldn't be an error when writing a Xen
> policy, for example).

By the way, there is a program in the kernel source tree, under
scripts/selinux/mdp, that will generate a fairly minimalist policy for
that kernel with all of its classes/permissions defined, a single
user/role/type, fs_use and genfscon rules for all filesystem types
configured, and allow rules allowing everything.  See
Documentation/admin-guide/LSM/SELinux.rst.  That however generates
policy.conf not CIL currently although adding support for generating
CIL is an open issue in GitHub,
https://github.com/SELinuxProject/selinux-kernel/issues/45
