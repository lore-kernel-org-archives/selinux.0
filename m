Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA9AC433E5
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 15:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7FA2065E
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 15:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="vtd7AX3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgGOP0A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgGOPZ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 11:25:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11EDC061755
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 08:25:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d16so1881704edz.12
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+WUBScE9hxd71hEtR0aRFTyjbxeCy3Wp/WQIR8Nbfs=;
        b=vtd7AX3n2qgBFj/XKrDSOC3zyxuoAfJ6VCNIPsDhYdDJu+YPG143hg+6yHJd8JPUXQ
         194XYc7H+kmB5mjgqRQXNSkhh+pjBk6JQrPd/LgeMJs7k5G2cM3r/KjDMXQO2kPP4eIv
         fjnZuDER68sFgP+P/VdAm1lGWdIzWhfS0safHbBy+9PiLd9pWens4Dw9qAdTTKLU+XrB
         D9e64/CwT8dRiU2NOUf8qrVlAUV4tdDNP24y9DMN0CD3qgmcEWctZVrhuaWVG3STjLwe
         MKSx4Yxdq5YbAr50UlsH6oT8QRpx/dt2H1YLiU5qNepIw9Lpf3JxmKhl7s0U3eeTi71O
         mkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+WUBScE9hxd71hEtR0aRFTyjbxeCy3Wp/WQIR8Nbfs=;
        b=eU7JLDyFQlGZ26o4mLGg2zfQC9ZtsxhWTPfWE7tVLA1FovOBNCG3XWXE5/AxhhKsJe
         sLRgIAud+Pad/4T6ROa2TydKPC6ZxcDQ6j4D+/l59xJI8U2VrdWDpWToXbwnuZv2Ti8a
         eYYlVyp6eD0JwR409bZHL2pTidYbWYc69Y2J6xw+BLjsjkyenpHuOyutOdVUiTROlWPa
         yxFHXmgLrdQXWtEOM1YCbjnGxvH7FuQd43vWCpnXrSXafoV6b5j60n5eJr27bUnQIpGc
         FNA/tI93fBaeffrC41pQCmyHocbS3J6nrkHYduVXptd5Vp07wXqZA88z2M84EscNjl9w
         fzyQ==
X-Gm-Message-State: AOAM532VLWokGGYG0xlPR0PjjsYxOt4eJoynIjTy1eSqrLjkuWbNQTz9
        3XjbnWpHn68txMdkuEod0Gps5LsBQcIDgzaJdBby
X-Google-Smtp-Source: ABdhPJzInukCMcmJ/1oN0mTfiAkIz3r1jo4iK0H9CwgVSsXl5bBXl9EH467SP8G7H6dafKp9Tp6Uov7KcBi1RWJXgMc=
X-Received: by 2002:a50:a881:: with SMTP id k1mr163860edc.12.1594826757138;
 Wed, 15 Jul 2020 08:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAD_biAy5VRxJEqnTj8HkToQQb_9kVytRXeeCp2iR4hpnNUd71A@mail.gmail.com>
 <CAD_biAwttUbrVP=VyVKCAuUHsBn2ZyT8vB76OWfvhC9+tyQuWQ@mail.gmail.com>
In-Reply-To: <CAD_biAwttUbrVP=VyVKCAuUHsBn2ZyT8vB76OWfvhC9+tyQuWQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Jul 2020 11:25:46 -0400
Message-ID: <CAHC9VhTwerXKHCpJ_qO_yJEhK-gP=2Nd3B+AW5RDS8u3yhCO-A@mail.gmail.com>
Subject: Re: RedHat 8 Default Context mismatch
To:     Jason Strauss <jpstrauss1201@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 15, 2020 at 10:09 AM Jason Strauss <jpstrauss1201@gmail.com> wrote:
> I am starting this post to have any confusion I may have as to how a
> context is applied, cleared up. I am currently trying to work off of
> the RHEL 8 selinux source rpm to apply an MLS type policy. I have
> noticed that upon compiling and installing the rpm on a new system
> install there are files that do not get correct syntax. When I look at
> the file_contexts file the context is correctly listed for example
> /usr/bin/sudo, but never correctly applied during a touch
> /.autorelabel on first system boot. However if i do a restorecon -RF
> on /usr/bin/sudo it matches what is in the file_context folder but
> appears to break sudo stating it can't find file libsudo_util.so.0. I
> have noticed this happening with several other files during system
> installation and would like to understand why the system isn't
> properly labeled upon rpm installation and a relabel.

Just a reminder that this mailing list exists primarily for the
development and support of the upstream SELinux components.  While a
number of RH employees participate in discussions on this mailing
list, this is not a Red Hat or RHEL support forum.  I would encourage
you to contact your RH support contact for RHEL specific issues.

-- 
paul moore
www.paul-moore.com
