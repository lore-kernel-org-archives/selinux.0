Return-Path: <SRS0=ZqYe=DP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FF7C4363A
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 15:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0CD20782
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 15:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="SbG/uzKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbgJHPPl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgJHPPk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 11:15:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75212C061755;
        Thu,  8 Oct 2020 08:15:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so8587899ejd.13;
        Thu, 08 Oct 2020 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vsBjgNFdboBHSoL5X+Hd60NTY2F5z7IPMm+LsFKnn6c=;
        b=SbG/uzKHWx7JvIZbHbICRUZK/5/GvesfZV6PChp/ktvF6W4ucKKEIVwuhynhHXsRNQ
         If9zbUWwEgbLnxU04h3H+nlciAuXr+WriVqNRymJLNg1Omcgdk51CPqPUZN3o5Hxxelb
         j/6B1FcJt5e9O2FZ8x6a7KkVF/3QB/Vd31vkM+Dqcmba14P4E4QGLLuqysjjWp2+VZAF
         NLOCVl+WgvTqsiAmjuKyeTEJYylbHt9fvLIC/34F/rwkbCjeWHPUjmVYvTybTQjPksmg
         MB2w6/cGxAsgKton4TkJMpnQMt7pl5uHM1ua7kNLxCtxI5d1rSYp5g9PSBisuiOOimIT
         ySxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vsBjgNFdboBHSoL5X+Hd60NTY2F5z7IPMm+LsFKnn6c=;
        b=fuWC69s+Yf8UaX/hvTL0GyqXHhMbZINjhbuXWPbDuhfNPZD/TZDwN0xtVDlwTm3Pnt
         /gxBnqf+RzKNKgazyD/KqxV9yU3gs5PUUiM0WYFXP9wtLU75AJno4An7i5De5A2aqK6R
         G3+dOgt7OZfdfyrkoVcFHrHY4dQx+BKheZvcZluEDmt7YucBPd/xdjRlvcUrls99MKjH
         zcT1xRbh9v8BVCYsAV0lWB69S/08Zk6repuhOBtAtCMXXLz0Ak5HB1zmnYG280CkI/Fg
         NI1FtDdUmUUEmIXv/AKMAuerTu1dnS9WyFJzhpR47elNb81ACafTYEgS991WE2upnZTy
         rtVg==
X-Gm-Message-State: AOAM530PBAYdVQzOnY2Jub5I3kikOD3ZCQpCyprJ4Bnq/Sg7mDiluQi6
        ps85XHLVmewg/3DUAVF5RuYGDdCXvu+9fFrwMQZ5Z+XOlMY=
X-Google-Smtp-Source: ABdhPJypn5I9Bydbc/cDfQ4+OSmKeJZQnrrlcacPn1QTnedw8WySwUoLJx4juxMO/syGTNENaWnw2+TXeO+i0ctG+wg=
X-Received: by 2002:a17:906:bfe2:: with SMTP id vr2mr6352590ejb.248.1602170139096;
 Thu, 08 Oct 2020 08:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com> <CAFqZXNsG+B7OdmQimwNNVYCJM_Dc3jpNUFUpraoCEaicaoi+kQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsG+B7OdmQimwNNVYCJM_Dc3jpNUFUpraoCEaicaoi+kQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 8 Oct 2020 11:15:27 -0400
Message-ID: <CAN-5tyE2ri+SWTQZfZQoV=U__UdMRgB5MR5ma0yQM4Yy03oEZw@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 8, 2020 at 10:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Oct 8, 2020 at 3:50 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > > > Hi folks,
> > > >
> > > > From some linux kernel module, is it possible to query and find out
> > > > whether or not selinux is currently enabled or not?
> > > >
> > > > Thank you.
> > >
> > > [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> > > that the LSM list]
> > >
> > > In general most parts of the kernel shouldn't need to worry about what
> > > LSMs are active and/or enabled; the simply interact with the LSM(s)
> > > via the interfaces defined in include/linux/security.h (there are some
> > > helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> > > bit more on what you are trying to accomplish?
> >
> > Hi Paul,
> >
> > Thank you for the response. What I'm trying to accomplish is the
> > following. Within a file system (NFS), typically any queries for
> > security labels are triggered by the SElinux (or I guess an LSM in
> > general) (thru the xattr_handler hooks). However, when the VFS is
> > calling to get directory entries NFS will always get the labels
> > (baring server not supporting it). However this is useless and affects
> > performance (ie., this makes servers do extra work  and adds to the
> > network traffic) when selinux is disabled. It would be useful if NFS
> > can check if there is anything that requires those labels, if SElinux
> > is enabled or disabled.
>
> Isn't this already accomplished by the security_ismaclabel() checks
> that NFS is already doing?

No it is not (for the readdir). Yes security_ismaclabel() is used
during the calls triggers thru the xattr_handle when a security_label
is queried on a specific file system object (inode).

This is done thru the xattr_handler interface which supplies things
like a "key" (which I'm not exactly sure that is but LSM(selinux)
uses). The only thing that we have in VFS readdir call is a
dentry(inode). (inode)->i_security isn't NULL (I already checked as I
was hoping that would be null when selinux is disabled). So I need
something else to check to see if selinux/LSM is active.

>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
