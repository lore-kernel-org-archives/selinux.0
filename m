Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6CC433E0
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 15:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156232071B
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 15:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD1Yssjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgGOPak (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOPak (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 11:30:40 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D96C061755
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 08:30:40 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id h18so744862uao.6
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BdVwkAlUW1p7VhiCe+b3Ku1rafZbjRctj6QmLvuTaSs=;
        b=oD1YssjxT0wSTzAz4U+bFbW6K0n+zHtujfs5dONcw5/kUNr9H/JKTyV83E6XttN1c7
         uMMWGYn3Gb7hKcKNj5HGMRfcL7s+9loPkOMgLRsAFsUPppB2kD/xZIruTkShwbodqd+5
         IGuBymLEXjlAnd4gHMZU4mHEhptEueUwZ6L4U45VBXifXJxVtBjGilMbVIsWIEhtkyfl
         qSI82/ViVg6y5CMw9MDeUmtVX3injiPqVGqge5NdXA1RykHnOtjpGM4QoMgWWwndAbX0
         0OgYvEFHsbaIIsevPONf6eBo0x2xpdTK7xvi75ipN2TBKm1Vz8itl7H5GT24H5Noy8F5
         Fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BdVwkAlUW1p7VhiCe+b3Ku1rafZbjRctj6QmLvuTaSs=;
        b=svZlfY1jPyDLdr4ji9iWuf/jKVjEclnUbEtNFo0Mq0ksCYzcrI9bgS3ZIkY0oyLZ/6
         uikr8X1xodApChkyPFsFY3+bO+FoN0e7lbQap3unUzc0EQKofVwNZjIHARlFRIPxVl4N
         aVjg83xSwDG+3i5emwQbB9XLSICEf/Eet3s2DK/2PIGR2faSk6szmUp83E16Xa2Hir66
         R1ga5JBa9WzGJtanW9K+7V/PTDVnNyoVAnG8LUitg/xw6jfzBUugwwOy/GiYEGsylwxj
         ocB1p9kiMvfcEOpzCe5mB5/bNZY1x/nyMkpNVC3Vv8tR8Y0wufFywm2+wVChZzlLVT1o
         gXZw==
X-Gm-Message-State: AOAM531j1eApAYVUN/bjtdS8WyTQ2IahxQtojJA9Qfq8mKncJaxWgwXU
        eak2spTUwym7AD0H4C5QEf6K2H1mFh6KitcNMAVY
X-Google-Smtp-Source: ABdhPJzx/uUStPvJzB/mAlIDLgCQX/I3Gnhd6zJfKW+PIdkfG5UxJpvIWx14bWhRm650rPI21pJejV6A7v1vFblskiA=
X-Received: by 2002:ab0:45ea:: with SMTP id u97mr7723314uau.54.1594827039438;
 Wed, 15 Jul 2020 08:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_biAy5VRxJEqnTj8HkToQQb_9kVytRXeeCp2iR4hpnNUd71A@mail.gmail.com>
 <CAD_biAwttUbrVP=VyVKCAuUHsBn2ZyT8vB76OWfvhC9+tyQuWQ@mail.gmail.com> <CAHC9VhTwerXKHCpJ_qO_yJEhK-gP=2Nd3B+AW5RDS8u3yhCO-A@mail.gmail.com>
In-Reply-To: <CAHC9VhTwerXKHCpJ_qO_yJEhK-gP=2Nd3B+AW5RDS8u3yhCO-A@mail.gmail.com>
From:   Jason Strauss <jpstrauss1201@gmail.com>
Date:   Wed, 15 Jul 2020 11:30:28 -0400
Message-ID: <CAD_biAxmdvsHLaysByg4a9RnSanhXvqre_h0VOyR=d-Jv34bWQ@mail.gmail.com>
Subject: Re: RedHat 8 Default Context mismatch
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks, I will do that. I apologize for the mispost

On Wed, Jul 15, 2020 at 11:25 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jul 15, 2020 at 10:09 AM Jason Strauss <jpstrauss1201@gmail.com> wrote:
> > I am starting this post to have any confusion I may have as to how a
> > context is applied, cleared up. I am currently trying to work off of
> > the RHEL 8 selinux source rpm to apply an MLS type policy. I have
> > noticed that upon compiling and installing the rpm on a new system
> > install there are files that do not get correct syntax. When I look at
> > the file_contexts file the context is correctly listed for example
> > /usr/bin/sudo, but never correctly applied during a touch
> > /.autorelabel on first system boot. However if i do a restorecon -RF
> > on /usr/bin/sudo it matches what is in the file_context folder but
> > appears to break sudo stating it can't find file libsudo_util.so.0. I
> > have noticed this happening with several other files during system
> > installation and would like to understand why the system isn't
> > properly labeled upon rpm installation and a relabel.
>
> Just a reminder that this mailing list exists primarily for the
> development and support of the upstream SELinux components.  While a
> number of RH employees participate in discussions on this mailing
> list, this is not a Red Hat or RHEL support forum.  I would encourage
> you to contact your RH support contact for RHEL specific issues.
>
> --
> paul moore
> www.paul-moore.com
