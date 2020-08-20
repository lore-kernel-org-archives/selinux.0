Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D8C433E3
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 12:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1E9207BB
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 12:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzZoppGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgHTMLY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbgHTMK2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 08:10:28 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0FC061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 05:10:21 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e6so1641326oii.4
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uo2MVj/pHJrZf0KnwauNw9rSaAoS/3J2uU0g1z4hAt8=;
        b=HzZoppGZpL7G04wugq/MZEb21oXReKvDCTqsFVLcGmjK+3XodDYYJ1aCK4AIY7V5dO
         fo+BVp+h6K8RT0gs9UhZmKcMY9R0WzvrBBeLGt+voDtwBOezjAFwA3k4Lv6MezhXV7GB
         lIXXUnjwOzQX6bCGIWldjF2APrV0u4dU2Qldpe4hjHxGmWSMlD/aH0fzUI/eQFd+aVPk
         iBt8W9+rlDWvUoktJmDaic1sTdfvAiHWIKLCJmSaY9G9KWML22zvmTtz7mVkmfdy0C0i
         IkTqUg1F53BqUOW7kIsfBp6kjOjY5YmYU3lRbblsN3kkOGqR4HttoKjkNi21utBG4+ut
         v0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uo2MVj/pHJrZf0KnwauNw9rSaAoS/3J2uU0g1z4hAt8=;
        b=T+fF+YO0QCdF+Ym4VyjfcBed5FqcD/4ATMA6Yapq3HX0te4I8Wkrte9LpR3ssqP9Jz
         okY/7veWMHEb8ge2vDmJr9oBgf1WNJM5SrNLo+T2PNXfWW3p28NM3jRQSsj9u9yilH3p
         e4Jz2diCRVwblzALHx/CfBGruLmIcxvLuDtemIBCVW5UrCeaWmyVxVzzXwR/WZzUpmAJ
         4j3pr/HLlF4E6okj5utRie55wm/sHCGUGCNZ2qnnMeoj1eZzvxOq/iAuNsIU3QnSlR4I
         NaOenvdTsYcIlXn047ME2ftM9bRh8mZ+kfW3QtV12MVFBQeoXqXUWIveWF1fM+WsaAMb
         e/+w==
X-Gm-Message-State: AOAM533AjCuoAk4+r+96ilGXL7zLzFkyPQXwPBT5ssUe2jseeqFcxfBi
        5swV8xNshHTo9cL5kF/tkUNDelefQf4IR9Vekwb8q+vM/98=
X-Google-Smtp-Source: ABdhPJzYsp3vjL7q1MVfaA3LoRmS6IhDuEulCNAYkfL5uNJoqUPF9e98GmpXeOpKYoFdloyk9cFn+DENJVv2LVlWEUU=
X-Received: by 2002:aca:fd44:: with SMTP id b65mr1416759oii.160.1597925419039;
 Thu, 20 Aug 2020 05:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
 <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com>
In-Reply-To: <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 20 Aug 2020 08:10:08 -0400
Message-ID: <CAEjxPJ5cRbCogQ17aakpnMp_0nwDHbMQTqC69SXBA3JcmP1nuQ@mail.gmail.com>
Subject: Re: working-selinuxns rebase
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 9:28 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Aug 18, 2020 at 9:37 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > I did a re-base of the working-selinuxns branch on top of latest next;
> > this required manual conflict fixes due to the encapsulation of the
> > policy state and refactoring of policy reload.  The rebase can be
> > found at:
> > https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns-rebase
> >
> > It boots, passes the selinux-testsuite, and passes the following
> > trivial exercising of the unshare mechanism:
> > $ sudo bash
> > # echo 1 > /sys/fs/selinux/unshare
> > # unshare -m -n
> > # umount /sys/fs/selinux
> > # mount -t selinuxfs none /sys/fs/selinux
> > # id
> > uid=0(root) gid=0(root) groups=0(root) context=kernel
> > # getenforce
> > Permissive
> > # load_policy
> > # id
> > uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:kernel_t:s0
> >
> > All the same caveats apply - this is still not safe to use and has
> > many unresolved issues as noted in the patch descriptions.
>
> Thanks Stephen, do you mind if I pull that into the working-selinuxns
> branch in the main SELinux repo?

Unfortunately I need to re-base it again and manually fix conflicts
with my patch to avoid deferencing the policy prior to initialization.
And I'll need to do it again when/if the patch to convert the policy
rwlock to rcu lands.  So you might want to wait. I'm starting to
wonder if the first patch in the series to rename selinux_state/state
to selinux_ns/ns throughout is a mistake because it produces a lot of
unnecessary conflicts.  Originally I did it because that was the
original naming since the encapsulation started to support namespacing
and then I did a mass rename to selinux_state/state for upstreaming
since I wasn't yet upstreaming the actual namespace support. Renaming
it back again reduces conflicts in the later patches but makes the
first one a pain.  But if I just do a mass rename on all the later
patches then I can drop the first one and avoid these unnecessary
conflicts.  Thoughts?
