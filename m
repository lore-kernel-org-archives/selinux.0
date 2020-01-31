Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19145C33CB7
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D830820CC7
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 13:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qym8plBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgAaNaV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:30:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42459 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgAaNaS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jan 2020 08:30:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so7742764edv.9
        for <selinux@vger.kernel.org>; Fri, 31 Jan 2020 05:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TlGGw4278SFcconiBmLZdSBNPZa1KSN3iJIFQUl5hLA=;
        b=qym8plBw+kdHrBllsZAmZ/QoEsMSwhYzlb75JK1mc7ICFOjq3qeBUi8SToOM+0isjM
         z+l3xHLUpl50XdtF+tUl1y8McmyEnQ9L0BWdpc0y66Tk/AipOtUd30dZEF+XaTIQpH+7
         YcvoJQt4U5DWhBfNIPhQN+sdY0LYdZGytZjaU4Qz8BggyBHWoNdcJra9MWy7oPZ+iGri
         Acdw7KP1DoX7ryjwFY37pH8618kQoTkX1HXCAFRiiODt9YffCUoa01wDZ707bPqwOmy3
         dvM8ll6dD6Mwavlo6XHSeNYSIhfsqUCqNRf5FDAxf3QT0hb4AbCv25ETdsNIOWWwObwJ
         bTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TlGGw4278SFcconiBmLZdSBNPZa1KSN3iJIFQUl5hLA=;
        b=RSbA/gxmZqH0NzG+J2jA/sLzhXyGlZBnfPqwvQDA+kBKqWpvV0vbb5tdIGZiwTyuM1
         G08tKLNcAyQrC1XbQuQdoC4eBX7Zpl7gntHTYNxgdyrbXsXkn1mTBc4esGOoq1KHV/ZE
         zZFZUwTmy4yOBbLH9w6SNba1CCEFJ2xH3qCas4FL8VYo0CZJN2R6Ws2X3uLnzR4dnfWj
         DADAAIR4oKCR4fVyECNBTnQ5fBgwr1GG9p2FEGpbIxDaiaSF6yDD4L+jqAdh5koncJLS
         a/0oNP/482uy1V2Mt/6HKDqz6F7XGBaX1W6DY2KGQSTiSc4N32whO+zoeHNytMl3Z40W
         f3Aw==
X-Gm-Message-State: APjAAAVq5KnQOS2p4f/MHASed+rH88K+qV3KQaB7PALgkTPNKq/K+A1D
        5vgHsgACCuNpS5p/2seCdaAY+u83z1Rr1nKSYcfW
X-Google-Smtp-Source: APXvYqz9SY/gcvqPHhn5eQuuldHWQZxjN07zvMk8f/HGgnFHVMRvzsl3MHF/fl7S6vLwtbmgntEimbfS7NhCRvihU/U=
X-Received: by 2002:a50:a7a5:: with SMTP id i34mr263607edc.128.1580477415938;
 Fri, 31 Jan 2020 05:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20200124184221.322248-1-cgzones@googlemail.com>
 <20200128191656.111902-1-cgzones@googlemail.com> <fea9b8ba-c95b-3629-fcc8-6f6d7a345b71@tycho.nsa.gov>
 <CAJ2a_DdWRL+rpAJc4z9dwJoPFQ8NKtqaiQ052KdQYBS_B4O16Q@mail.gmail.com>
In-Reply-To: <CAJ2a_DdWRL+rpAJc4z9dwJoPFQ8NKtqaiQ052KdQYBS_B4O16Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 31 Jan 2020 08:30:04 -0500
Message-ID: <CAHC9VhRXtTW_iG4mNbE3bjFqbjpAc+3+hqMfpHNJqEU2vcxhig@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow kernfs symlinks to inherit parent
 directory context
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 29, 2020 at 11:45 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Am Mi., 29. Jan. 2020 um 14:34 Uhr schrieb Stephen Smalley <sds@tycho.nsa=
.gov>:
> > This looks fine to me code-wise.  Have you tried enabling this new
> > policy capability in policy and seeing the effects of it?  I remember a
> > problem in the way-back time that motivated adding the S_ISLNK()
> > exception for proc.  IIRC, the issue was that policies specified
> > "genfscon proc /net system_u:object_r:proc_net_t:s0" to label everythin=
g
> > under /proc/net with proc_net_t by default, and when /proc/net was
> > changed to be a symlink to /proc/self/net as part of the network
> > namespaces work, this caused the symlink to be labeled proc_net_t, but
> > since previously there were no symlinks labeled proc_net_t, no processe=
s
> > were allowed to read/follow the symlink and existing systems broke.
> > Exempting symlinks caused the /proc/net symlink to be labeled proc_t
> > instead, which was already widely allowed.  To avoid this problem when
> > enabling this capability, you will either need to allow
> > proc_net_t:lnk_file read widely or you will need to change the genfscon
> > statement to avoid labeling the symlink (there is an optional file mode
> > field in genfscon statements similar to that of file_contexts, e.g.
> >   genfscon proc /net -d system_u:object_r:proc_net_t:s0
> >   genfscon proc /net -- system_u:object_r:proc_net_t:s0
> > would only label directories and regular files with proc_net_t.
>
> I tested it with a refpolicy alike policy, where
> kernel_read_network_state() allows access to symlinks [1].
> Just systemd pid 1 wants to read the symlink only without reading any
> files, so I added kernel_search_network_state(systemd_t).
>
> [1]: https://github.com/SELinuxProject/refpolicy/blob/7e191b008e70ca535ce=
ca2405967ddddd2ed975d/policy/modules/kernel/kernel.if#L1437

Thanks.  FWIW, I think the netns procfs case is a little different
simply because it was a change in the core kernel behavior and not a
change in the access controls.  While we have tricks, e.g. policy
capabilities, to help with migrating users/admins to new access
control changes, we don't always have the same abilities when the core
kernel changes.

One could make the argument that the netns procfs change was a "break
userspace" type of change, but I doubt you would have gotten far with
that because well ... containers.

Anyway, I've gone ahead and queued the patch up in selinux/next, you
should see it in the tree once the merge window closes.

--=20
paul moore
www.paul-moore.com
