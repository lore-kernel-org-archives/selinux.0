Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF241C83F01
	for <selinux@archiver.kernel.org>; Thu, 31 Aug 2023 14:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjHaOiY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Aug 2023 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHaOiX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Aug 2023 10:38:23 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012C3CD6
        for <selinux@vger.kernel.org>; Thu, 31 Aug 2023 07:38:20 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58d9ba95c78so10500537b3.1
        for <selinux@vger.kernel.org>; Thu, 31 Aug 2023 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693492700; x=1694097500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcyVkDYCOI2rKfi2M1vEAgKLKKC7urxEAXKeaIUF3H0=;
        b=BsJfr8Po2W4Q0oITn/AxhrKvoSDQYl52mw+vfBS/nBAhKOMYInXEQ6mUHJ4L2ur+D6
         V/Qnl8Ujq6rzjh4VD+1dGNetsiHVwhjnM9YH1r1iCwn2DYAaxGvwRLgvdSMa/l0vC0TF
         J/Mzo2cVVhDmiyCcXbHH8IBY8gfSPCAIcmxBvGc7n6gZUbtWlKwNHl1vcYY3EqUGyawK
         CX7XqAy1OJlLWhMw6PyFNxOuN3Coqfy2NFuvqovOc/dX1j0LTVsjnl1yguHwPiJwWHmi
         kCfj9Z7mr0YlecP/2VZcLKdT5dD3LTRP2NzVpWf0Qg+3fcPXoZ3XzJfzaVLw6jr+KzMO
         PS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693492700; x=1694097500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcyVkDYCOI2rKfi2M1vEAgKLKKC7urxEAXKeaIUF3H0=;
        b=NoYoonRH3An3P5ZblVOvHV9YWpEfvIVR1w1PAvbwrI/0bM2GsUMgQDA+JcTP/u2aPN
         xMZfuzs9VcsqD25C5wxwktttajhlugC/vtd80HLFWkauiZP4FRNoPVeBK+yECuDb1zYb
         6Mgmf97kGqVRjTlTSEVZElELw5Tm/Gx3TqJBbfu+belo5Mv/vfbu6d53q0vOgPgg+umv
         g5RVjBMNZZI3fcsKheK8HrxiySv6LGT4d6aa57Xl3Qb2cYFkUMasRZ7BkfxnzipA/GQS
         Cf3gLB1MaSJsgPdbqbiuDrd88tYBovORf1PTDYdy4iPEOGvEejZueIjyj+NsNsQ3P6qc
         Cdmw==
X-Gm-Message-State: AOJu0Yz6hdBlLElgIybddAClmehLYjR9j50psWhz31ZJoJRgFSDjapLy
        hxHGkz4humoCOsZK5r9X6FXaQ8GlZpY9eAMjyAbt
X-Google-Smtp-Source: AGHT+IEhc4F4zDBy+s8wPqwmbXTXjZ7v64ZTtBzO6nl3pNFJdZqDUxKDrhawZgrMFHACatuTCnjz16v02RldI/XZMYQ=
X-Received: by 2002:a81:84c4:0:b0:58c:54f8:bd45 with SMTP id
 u187-20020a8184c4000000b0058c54f8bd45mr5270617ywf.44.1693492700172; Thu, 31
 Aug 2023 07:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230831053157.256319-1-hch@lst.de> <20230831-dazulernen-gepflanzt-8a64056bf362@brauner>
 <20230831-tiefbau-freuden-3e8225acc81d@brauner> <20230831123619.GB11156@lst.de>
 <20230831-wohlig-lehrveranstaltung-7c27e05dc9ae@brauner>
In-Reply-To: <20230831-wohlig-lehrveranstaltung-7c27e05dc9ae@brauner>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Aug 2023 10:38:09 -0400
Message-ID: <CAHC9VhQOpy=rLNmirT7afkEdf5_PRnLVsdPJQvxqaF0G4JrCgQ@mail.gmail.com>
Subject: Re: sb->s_fs_info freeing fixes
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 31, 2023 at 9:11=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> > > If that is good enough for people then I can grab it.
> >
> > Fine with me.  And yes, I'd rather not have private data freed before
> > SB_ACTIVE is cleared even if it is fine right now.  It's just a bug
> > waiting to happen.
>
> Applied to the vfs.super branch of the vfs/vfs.git tree.
> Patches in the vfs.super branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.super
>
> [1/4] ramfs: free sb->s_fs_info after shutting down the super block
>       https://git.kernel.org/vfs/vfs/c/c5725dff056d
> [2/4] devpts: free sb->s_fs_info after shutting down the super block
>       https://git.kernel.org/vfs/vfs/c/fee7516be512
> [3/4] selinuxfs: free sb->s_fs_info after shutting down the super block
>       https://git.kernel.org/vfs/vfs/c/3105b94e7d62
> [4/4] hypfs: free sb->s_fs_info after shutting down the super block
>       https://git.kernel.org/vfs/vfs/c/993d214eb394

No need to change anything in this case, but in the future if there
are no patch dependency or ordering issues can you let me take the
SELinux patches via the SELinux tree?  It helps prevent merge
conflicts during the next merge window and quiets the daily automated
checks I have in place to detect SELinux changes outside of the
SELinux tree.

Thanks.

--=20
paul-moore.com
