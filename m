Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23927C6FA8B
	for <selinux@archiver.kernel.org>; Fri, 23 Sep 2022 14:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIWO1Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiIWO0t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Sep 2022 10:26:49 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E2139F54
        for <selinux@vger.kernel.org>; Fri, 23 Sep 2022 07:26:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m81so60485oia.1
        for <selinux@vger.kernel.org>; Fri, 23 Sep 2022 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hD02gfgJ/qWSS3EkhoA6drXQajCJVbBQ6k/Vx/E2/30=;
        b=GdgV59MmX6vS2XQhzUDNik7edXa5o5JdqAoxYgV5uT9nDpCSzuXJDsSDbSMweJiMFg
         SXHaB94wD0PoSsXXWgeo/PR6vGDM2C+aUyw92yzSA9NqV7oPSCLV9RGfvSdelir1Fvri
         ftuK20KqejohHx+u8NoiLnEthSBXbNHdCBlXR2FTYlZyTgTy5mW3oLVwioIaDnaprhBg
         lKX9E42SiMRrzUfWgW0ectGGftX0gELqdpxNfKxULgFmpDAAxsN/AI6fy/NuGT+zvimr
         Uzsi7bSuBk4ll5AVw0ChXfmA/LMkBYM4CHpPhicNp4Xjwf1T8r98BthgrCaxBoju8nDh
         CPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hD02gfgJ/qWSS3EkhoA6drXQajCJVbBQ6k/Vx/E2/30=;
        b=QoiSY4LWZNWILmUKcwoz/T1DOIcUpepfdPH8iMY/cXrNCVdE347veHV5X6a5y8MtBN
         WLRCAr4P7JLyOrAszdMccXNXdME6kBaF6yNThezIFdPSdwvErLomFGdDKt19x9P3r+9l
         6Zp9ofGHP/NBiHeMViTIOHj0vWIZsGl7sBIsVsvz/esSMQof45SwwUFy2jEgsIah0xmC
         ktzGOfXcyJkLrC4xI8QULSDC6Qq52shVisTOZ+1bZBLR/2fSdcS37YgbHCvwVmgZNjom
         vs+Kikr5ivYUhPDIqLFDSzmP+3NY1DTer4JTC8fuVXA36bcu+lNfwt3DMO9lqh6TWY18
         EaKQ==
X-Gm-Message-State: ACrzQf3dMRsQ3iCpET2g+9obrC26jV41Hld5yCrnZX7gKIDwJlPIig/S
        nVpSSbpb6ATnV14r2osnjDGo45ABbx+eXhlleeOr
X-Google-Smtp-Source: AMsMyM4xRXt9QXQbneaCb4NqZTTgEOsPgSrDxYM2+RxUrKP0GrDbLB2HDGYI1LB9nFEPn90dVFI+rFA2FPl6st0ZEA8=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr9063888oiv.51.1663943206402; Fri, 23
 Sep 2022 07:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-11-brauner@kernel.org>
 <CAHC9VhS7gEbngqYPMya52EMS5iZYQ_7pPgQiEfRqwPCgzhDbwA@mail.gmail.com>
 <20220923064707.GD16489@lst.de> <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
In-Reply-To: <20220923075752.nmloqf2aj5yhoe34@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Sep 2022 10:26:35 -0400
Message-ID: <CAHC9VhS3NWfMk3uHxZSZMtDay4FqOYzTf9mKCy1=Rb22r-2P4A@mail.gmail.com>
Subject: Re: [PATCH 10/29] selinux: implement set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 23, 2022 at 3:57 AM Christian Brauner <brauner@kernel.org> wrote:
> On Fri, Sep 23, 2022 at 08:47:07AM +0200, Christoph Hellwig wrote:
> > On Thu, Sep 22, 2022 at 01:16:57PM -0400, Paul Moore wrote:
> > > properly review the changes, but one thing immediately jumped out at
> > > me when looking at this: why is the LSM hook
> > > "security_inode_set_acl()" when we are passing a dentry instead of an
> > > inode?  We don't have a lot of them, but there are
> > > `security_dentry_*()` LSM hooks in the existing kernel code.
> >
> > I'm no LSM expert, but isn't the inode vs dentry for if it is
> > related to an inode operation or dentry operation, not about that
> > the first argument is?
>
> Indeed. For example ...

If the goal is for this LSM hook to operate on an inode and not a
dentry, let's pass it an inode instead.  This should help prevent
misuse and I suspect the individual implementations will be quicker
for it anyway (it should be the case for SELinux, and while I'm not a
Smack expert it looks to be true for Smack as well).  There is the
potential for some additional work in the case where the inode needs
to be revalidated (I believe this is only a SELinux issue at the
moment) as well as if an audit event needs to be generated, but these
should both happen infrequently enough that I don't believe they are a
real concern.

-- 
paul-moore.com
