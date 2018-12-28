Return-Path: <SRS0=b3nl=PF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17E3C43387
	for <selinux@archiver.kernel.org>; Fri, 28 Dec 2018 15:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8D32146F
	for <selinux@archiver.kernel.org>; Fri, 28 Dec 2018 15:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeL1POF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:14:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43620 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeL1POF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Dec 2018 10:14:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so17499208oie.10
        for <selinux@vger.kernel.org>; Fri, 28 Dec 2018 07:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltPj4YhW7DEBnjmPZP4DoyqURAmAy0Wzh1TFSF4f/yI=;
        b=ulSzc0/yaHwLfohY2jviM+LhD4dgp/q+jI2fg7ZuTOLIG5Oh3cZF71AqRJ1bk8y+gB
         Hx7des2v49ZqAoBfk7JMBGoaUp1kkiNxkhE6CmOChyzi0Xi6v6fd2XZ+o65zOcaEZwoE
         2yF/AKHN8SanMT2bUoOjgXbk7Z3foQndRm2glLOwy2t/z/oiTp3HN2S34vvf3rB8xhSq
         TzsnBG/21PeLbl2Ni4brqSneYcO1DlSxLUMuy+N8me6mCOOPaMV3VejXq+CGgNtso+FD
         ZReqp/9DgwnHvuoHDhnd98J/O0QLOpcJrUnuXI/p0Tp0idqSE7VTzNGUna1Myvk56aeC
         5bnQ==
X-Gm-Message-State: AA+aEWZ4kO1DC6J8Ec9Uws7SbxNPCLWX6IN35NvxxSneVWOE/lEgFnX5
        aNvLqmBwOg7NA2JcYMPdC0ZmKL7T5xVRtoSRSHbHFA==
X-Google-Smtp-Source: AFSGD/XTNFlPFN6sYndJR4lOXmzoX9O3SC0V6ksN22CK6A3Ww49y5Wla6GndgMyjf8HTMT/iK33qCeF2+1K3mR2NyoU=
X-Received: by 2002:a54:440d:: with SMTP id k13mr19040947oiw.263.1546010044287;
 Fri, 28 Dec 2018 07:14:04 -0800 (PST)
MIME-Version: 1.0
References: <20181213141739.8534-1-omosnace@redhat.com> <20181213141739.8534-2-omosnace@redhat.com>
 <20181213160309.GT2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20181213160309.GT2509588@devbig004.ftw2.facebook.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 28 Dec 2018 16:14:01 +0100
Message-ID: <CAFqZXNs+Zi0-6Syj9Uy4TajOQkukngafyUp_VW+VStzgorVYOw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] cgroup: fix parsing empty mount option string
To:     Tejun Heo <tj@kernel.org>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Tejun,

On Thu, Dec 13, 2018 at 5:03 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Dec 13, 2018 at 03:17:37PM +0100, Ondrej Mosnacek wrote:
> > This fixes the case where all mount options specified are consumed by an
> > LSM and all that's left is an empty string. In this case cgroupfs should
> > accept the string and not fail.
> >
> > How to reproduce (with SELinux enabled):
> >
> >     # umount /sys/fs/cgroup/unified
> >     # mount -o context=system_u:object_r:cgroup_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
> >     mount: /sys/fs/cgroup/unified: wrong fs type, bad option, bad superblock on cgroup2, missing codepage or helper program, or other error.
> >     # dmesg | tail -n 1
> >     [   31.575952] cgroup: cgroup2: unknown option ""
> >
> > Fixes: 67e9c74b8a87 ("cgroup: replace __DEVEL__sane_behavior with cgroup2 fs type")
> > [NOTE: should apply on top of commit 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option"), older versions need manual rebase]
> > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Applied to cgroup/for-4.21.

I still can't see the patch in your for-4.21 branch [1] (and it
doesn't seem to be included in your 4.21-rc1 pull request either [2]).
Did you perhaps forget to apply it?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/log/?h=for-4.21
[2] https://lore.kernel.org/lkml/20181228021605.GI2509588@devbig004.ftw2.facebook.com/

Cheers,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
