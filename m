Return-Path: <SRS0=MPXq=TJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120BEC04AB1
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 21:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16A120850
	for <selinux@archiver.kernel.org>; Thu,  9 May 2019 21:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mo66SbpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfEIVrn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 May 2019 17:47:43 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:50642 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfEIVrn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 May 2019 17:47:43 -0400
Received: by mail-it1-f172.google.com with SMTP id i10so2310937ite.0
        for <selinux@vger.kernel.org>; Thu, 09 May 2019 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wA9+QzhSTliAc0wVHyPKHA8qyLaNKaUaT3pxDQZRotQ=;
        b=Mo66SbpWJV7Gdi+WHZ3JYfURLTbveb8/oYb+W9jPAk7m1ny83pFCcNNHSh2w3RTWC7
         yorWAb56rzPmJZ5E0hVWrwTfaGT/W+V02RXYuZEDP5KackrHoMmk3kfMyDEsWdMe/+Ak
         GSmGLmS5h7BpgXsLSS8OIIL1Wxp4YwaYlkuHq0VRd2t9vjJwVAtauAek9l3Uz9j/C8ju
         T092vfHaf4B9ymH2JEl7uSJtuQEb+FYArcM5U38HKo9Yr7b50geqCQ2K9cvc/0VtBUau
         K71xr+xYpLspqcjDmqpmSbmDLU5oo730dJAxNJnYG14WU5C02a8b+ol6zox5uzbRe/Hb
         dvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wA9+QzhSTliAc0wVHyPKHA8qyLaNKaUaT3pxDQZRotQ=;
        b=gmrhhP5pqypGyvdel0Vl/sFryQk8Gmv202k1AIow6OAideSIS7aR0H63BYAcR+qFME
         OTVN4+eZP/YkdBIgsEj8dr1jhmgacjAT3zY3BAhZ2I/ufTTGIEpIo4y8fqlnsYtyRcWd
         6JDslILPHcmNKHg58+AZem64sBGcDBTl6HFVcQ0INqgKkhv7Xj8KgFnBguVzJk/EJSRN
         GJrcAUmLzobdnQulLE/DohSGTlO+ESEQmrJ1l7CeXbk5OEJKgRbc+QWxpDhTHnBo1+vS
         m8gcVgCd/u8cXcXuFsONl2nPvCpgEgMFrrtBxT3mDkmCPJZY9aZnkRpEMaaLWTUhTLRU
         p4Tw==
X-Gm-Message-State: APjAAAUyNW0jlMHWqUcCicMD1vpZcivL5EOkeOzFa7yC2dOk37+Dxz39
        fjWlECoGM0BdJvQC+4c9kwSN1kG+mqvfouXcwhMLZ9fG
X-Google-Smtp-Source: APXvYqwfcGD40wGxBTZYbC2IuRnoq37TJgOtS+H+PVSDzsAZcdcMBPf6WwqInAs+oHtS4PB7i6vWFt5TgPqLmifEaN4=
X-Received: by 2002:a05:660c:18d:: with SMTP id v13mr4597697itj.75.1557438462115;
 Thu, 09 May 2019 14:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABXk95D-4v2aT=sZk9NoeGJBGTy=7NTQ8+yKv5E4RvaODJgWLA@mail.gmail.com>
 <fdcf1946-2151-4502-9755-3a10d0646399@tycho.nsa.gov>
In-Reply-To: <fdcf1946-2151-4502-9755-3a10d0646399@tycho.nsa.gov>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Thu, 9 May 2019 14:47:30 -0700
Message-ID: <CABXk95Au_UVdghpHGuu39mHJkSYA2=7YS__vtx8sxGEH4CuSgg@mail.gmail.com>
Subject: Re: Mislabeled /proc/<pid>/ns/mnt files?
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Joel Galenson <jgalenson@google.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, May 9, 2019 at 2:17 PM
To: Jeffrey Vander Stoep, <selinux@vger.kernel.org>, Joel Galenson,
Petr Lautrbach

> On 5/9/19 3:56 PM, Jeffrey Vander Stoep wrote:
> > I expected files here would have the process's context, but they
> > don't. The files are actually all symlinks so it's entirely possible
> > that the they shouldn't have the process's context. If that's the
> > case, how can I provide different labels for them? Neither "proc" nor
> > "unlabeled" are appropriate.
> >
> > On a device with a 3.18 kernel they have the "proc" context:
> > sailfish:/ # ls -LZ1 /proc/1/ns
> > u:object_r:proc:s0 mnt
> > u:object_r:proc:s0 net
> >
> > On a device with the 4.9 kernel the have the "unlabeled" context:
> > blueline:/ # ls -LZ1 /proc/1/ns
> > u:object_r:unlabeled:s0 cgroup
> > u:object_r:unlabeled:s0 mnt
> > u:object_r:unlabeled:s0 net
>
> First, ls -L dereferences symlinks so you are going to get the context
> of the object referenced by the symlink, not the context of the symlink
> itself.

I'm seeing a denial on the object not the symlink, so -L is what I want.

>
> Second, the task context is only assigned to proc inodes created via
> proc_pid_make_inode(), which has never been the case of /proc/pid/ns
> inodes - those have their own implementations and operations.
>
> Third, /proc/pid/ns migrated from proc to its own pseudo filesystem,
> nsfs, which requires a corresponding fs_use or genfscon rule in policy
> or they will be unlabeled.  refpolicy has a genfscon rule. Confusingly
> there appears to be both in Fedora policy, a fs_use_task and a genfscon
> rule, and it appears that fs_use_task is being applied here.  I don't
> know why or what exactly that means.  It won't be the task context for
> the task associated with that /proc/pid directory but instead would be
> whichever task context instantiates the inode.
>

So, how do I label these files in genfs_contexts?

"mount | grep nsfs" returns nothing.
