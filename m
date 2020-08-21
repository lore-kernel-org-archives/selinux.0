Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F5BC433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99425207DA
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 13:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DC/fjH5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgHUNT2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgHUNT0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 09:19:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4571CC061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:19:26 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w17so1377275edt.8
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVL+YBSTW0gTGAsJy7eQf6mIthH46kkGl4RlwWjQRJQ=;
        b=DC/fjH5uZhwsjMMnPsqy+Jzu9rgTcgAcImUv+ERIfaEdocpnRMpQq9pzp7JiZOxnC6
         fyJ6crrJO0uxSv4D3YFWY6jmxhCEpV1yJ4H8U//Ic4uP8piMXL460DJw/YP9s8zrBXTg
         OyW4HfFUXAMHbqukuHlvcqIE46xNX4dWinKEfpefDrfNQnHDJ/xz+EQyMmNcz0stVtm6
         Y3G8ZWQJQKUDn8vBvGMRQ2vxkDpxbcLC1tg29Rt1WCt/+FEYUoKZMdYQ4BHnsIGai+9+
         MlY/+ehzJhto9kj6DICRKPfSQEeV3ZbN0YVOPmKVklhr4ugn1lbnvqrrEAIzjwoZ8+Eb
         4lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVL+YBSTW0gTGAsJy7eQf6mIthH46kkGl4RlwWjQRJQ=;
        b=ljMAPGtbHWQ/xRKMAMaYneT+4j6n3l4OmTLy1C2y7PgaOMyw87PgUwAFUNFIDkaRPQ
         5g24FdtEVdItyC89XSLKrnxEeqXEZ3ILTsXiht2jp8VnXj+GL6ZC8YRyj6V9XfpoOCJ0
         TiA6ezCnr9vE336yz05IUkvo2ntBH01DW72dwrgWsZ9mjsory3dzRUWrQMdTQ3W/ESxM
         FMdOPlYPXCy0SXqBu86mH/KVwUBeR6mRvhm5b1XL80CKl3oUGCXaTWm56vo5yXmtccw3
         VjY3hP5183s3iYpgo62csXV/yChQdQ3Spr7Gk3BgfKSAyf0in5e612h3YzSrCdg4H2So
         z9xQ==
X-Gm-Message-State: AOAM531arJV7Br3vCqk48A0zIdcfPIiXRmiIL356vjyJ1GLd/BviZCqS
        M8n/64wt5p7YH72Se3g4nI3RUbusie0obJixangE
X-Google-Smtp-Source: ABdhPJzG03pebCY0niDV20+IKZGbnL7dEkRnJ6bTurjAX+jgrwZs7v+tAcTHRYjwUJHe4/r8DTWAqykpByUe6WpYbpc=
X-Received: by 2002:aa7:c383:: with SMTP id k3mr2713274edq.164.1598015964731;
 Fri, 21 Aug 2020 06:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com> <20200817170729.2605279-4-tweek@google.com>
 <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com> <20200817162933.79f69c66@oasis.local.home>
 <20200818120948.1a428da9@oasis.local.home> <66e6d84e-20b5-1bd3-e107-322f42ce35d3@gmail.com>
 <20200820223136.162850ce@oasis.local.home> <CAEjxPJ7-6PaHjPzB7vN=nh+VMNV-T2bnKM-YrXdQwOzNtG+9zg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7-6PaHjPzB7vN=nh+VMNV-T2bnKM-YrXdQwOzNtG+9zg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 09:19:13 -0400
Message-ID: <CAHC9VhTLOWsD9LbVGBj=o3N3SPe-uJDvrdQAySy6MmE4uyuzng@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 21, 2020 at 8:29 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Aug 20, 2020 at 10:31 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 19 Aug 2020 09:11:08 -0400
> > Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > > So we'll need to update this plugin whenever we modify
> > > security/selinux/include/classmap.h to keep them in sync.  Is that a
> > > concern?  I don't suppose the plugin could directly include classmap.h?
> > > I guess we'd have to export it as a public header. It isn't considered
> > > to be part of the kernel API/ABI and can change anytime (but in practice
> > > changes are not that frequent, and usually just additive in nature).
> >
> > Yes, it would require some stability between userspace and the plugin.
> > If the value indexes don't change then that would work fine. If you add
> > new ones, that too should be OK, just have a way to state "unknown" in
> > the plugin.
>
> Since we introduced the dynamic class/perm mapping support, it has
> been possible for the values of existing classes/permissions to
> change, and that has happened at time, e.g. when we added watch
> permissions to the common file perms, that shifted the values of the
> class file perms like entrypoint, when we added the process2 class
> right after the process class, it shifted the values of all the
> subsequent classes in the classmap.h.  So you can't rely on those
> values remaining stable across kernel versions.

I think it is becoming increasingly clear that generating the
permission set string in userspace isn't really workable without
breaking the dynamic class/permission mapping to some degree.
Unfortunately I don't see these perf changes as a big enough "win" to
offset the loss of the dynamic mapping loss.

I'm okay with merging patches 1/3 and 2/3 wth the changes Stephen
suggested, but I think we will need to leave patch 3/3 out of this for
now.

-- 
paul moore
www.paul-moore.com
