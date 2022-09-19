Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE889C54EE9
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 15:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiISPoz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiISPow (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Sep 2022 11:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D909583
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663602291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mC09G9/j8b/gYn9TWKQkeE3yR261c2iiE535sONBicM=;
        b=PtK+kTm6Wwm/1Y+bgUZ0YwpxXIky/jPqIfwFb1RvUzsZJt3IMeB4IKV17TTaIizLMDAK8F
        zBLMLOiBHA55pSKRyxIoESkOC+koXxg5RuNJH3EtG5OCYknHPpKZS0wxmjRiSLGt56ldad
        A2pv6AdrdziLSY4RgVJDxs8RqUTjyLE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-7MmAMnuzMuGLYPUbFQH7Og-1; Mon, 19 Sep 2022 11:44:49 -0400
X-MC-Unique: 7MmAMnuzMuGLYPUbFQH7Og-1
Received: by mail-pl1-f200.google.com with SMTP id z7-20020a170903018700b0017835863686so15582271plg.11
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 08:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mC09G9/j8b/gYn9TWKQkeE3yR261c2iiE535sONBicM=;
        b=gAjotHO4WHcmct4fQ2CLD8jLgVw1YjXjxCceFCK3ekYQiu77wbuJCe5N6kGds49JVn
         zTWTol4fYbrdfHdxkWvAn43d9eFrRih9VLs6DQgR7r2p2/qp9bMZHtP+4EUQHEBS2mMW
         3VXTdAR9eX07y/7j2MBA3T3Rcc6tnAdJ6lGiTkPo/BL/86aArIcJxZdu78Ti26Aa9ouc
         d5Rzh1htl4P/5b4zdRKcDXRi0SRKpdTCSKwan0SnWIv3ihBNxH0Mqb4wP/sJdxCdv1Mm
         H9+oz/TxNn2M2XXkOht0nS9uAUgDMdYi8jI79XRIo9/So6gts+2KlsGFY6rAaZC35VOK
         +rvw==
X-Gm-Message-State: ACrzQf1GZQXx1i38YYQKndEqLMxNMrlGsIZaA0rI7d2afeDpORt1NWnG
        q7kj84Pufsm3FvHemXxuRylc3ejpilwB4am9/VrQySCur09DRtoGBZJNXwC4H+N62x/RnrEM1S8
        twMhi1cdSPqUl3ngAD2UEsaVrkfy70nR8uA==
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id om14-20020a17090b3a8e00b0020055854099mr32499279pjb.70.1663602288922;
        Mon, 19 Sep 2022 08:44:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66u6c43kUMu1KfsAdon/TryY3tzJNpSbQM52vM4g/ymEiKzBro7UI/kowHjPtHUhVSiWM7DJyHHsiD2zeRqPM=
X-Received: by 2002:a17:90b:3a8e:b0:200:5585:4099 with SMTP id
 om14-20020a17090b3a8e00b0020055854099mr32499254pjb.70.1663602288601; Mon, 19
 Sep 2022 08:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220919112901.1127409-1-omosnace@redhat.com> <CAJ2a_DcJkATZNBKH8Ua9_Wa1KKL16K-TopHQVW2hYOavPMjgWQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DcJkATZNBKH8Ua9_Wa1KKL16K-TopHQVW2hYOavPMjgWQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 19 Sep 2022 17:44:37 +0200
Message-ID: <CAFqZXNvp3hLUbR=0t7vfD1oQmL1mdKOpXRyfgWOoeZCv9UU5tw@mail.gmail.com>
Subject: Re: [PATCH userspace] fixfiles: do not cross mounts when traversing directories
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 19, 2022 at 1:35 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 19 Sept 2022 at 13:29, Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
> >
> > Always run find with -xdev to avoid unintended deleting/relabeling.
> > While this may sometimes skip subdirectories that should be relabeled,
> > the danger of crossing into random mounts is greater than leaving behin=
d
> > some unlabeled files. The find commands are just best-effort attempts t=
o
> > fix the labels anyway.
>
> The xdev option does not work for bind mounts (they are still followed).

Hm... it does not if the bind mounted dir is on the same filesystem
(superblock), so in the case where /tmp is a plain directory on the
root filesystem it will allow traversing to other directories directly
on the root filesystem. I guess that's still better than nothing,
though...

An alternative (at least for the more dangerous -delete part) could be
to change the prompt to suggest switching to do the equivalent of
`fixfiles -F onboot` + reboot. The current prompt instructs the user
to reboot the machine anyway, so it wouldn't really make things more
complicated for the user. Maybe I'll draft a patch for this...

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

