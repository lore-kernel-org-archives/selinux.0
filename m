Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2EBC433FE
	for <selinux@archiver.kernel.org>; Fri, 25 Feb 2022 20:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiBYUzg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiBYUzf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Feb 2022 15:55:35 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C01D793B
        for <selinux@vger.kernel.org>; Fri, 25 Feb 2022 12:54:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so13069641ejb.13
        for <selinux@vger.kernel.org>; Fri, 25 Feb 2022 12:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uRsrBukF/OaHklKeUPxgxH16ty4e2SknPEAhNIbuzI=;
        b=Oj2UeHh27U1O4N7l5DBWuAtV67Ay3IpEleEp+o54d3CxEXDSMdqy6DaeA+FVZB28VP
         wIIn8hgELwuOTwz6hOaeVZtlebfiuq3gyTf4EaQ6Ptcgp36l3GNy4BKzj98oUPVXqbOH
         gElIpqL5novCm4oHdfP/9MAthJ3028EkXQoYQhUxfrXY0LYmRD4bIlikE4dSBajq45EX
         dVAVsJS2CRwsKGD6LJW4W2dl/l5Jh4mRy2v+obEo3Dwi1agtVRiunAVTbAg1P6EPHGZZ
         O+Bq6Nnjd3C4m0q/YAKHsgvk6yajs4u7OTkygvn5yYQB0CV3QVVbUQ5prDm2Lyoc50HM
         HAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uRsrBukF/OaHklKeUPxgxH16ty4e2SknPEAhNIbuzI=;
        b=R0dkq1qTWXdsdTzqgse8iB5Vd68StRBSTpI8GvnEDFuxkLX25gvu9H5qr2P/d5EJmG
         LB4/RGoqTlN1Gxvwk667mb5YQNlcks1CTNwyS7IHP5G/HrQq81jNDnReuTiShQ9HLYJS
         Uurc2O+xQM+P7Pw/yZkLGmR3NH0+9yrMAJ7JVbjHyKMg8XxsfbAVW1cy1sjAhLgOquFc
         Och5zZoQcMaox492SLiGu7na3YaJz0mq3UELdSGqpSLKm/dXasnyPcGc3y1eq3X+q+7c
         qfDUUCbYhchT4xbsW43jUTyxfWaI1B71rarCmivKQDaQuj4EwxFZd8b0VZR1yQcUFdWE
         nTXA==
X-Gm-Message-State: AOAM530ThG9OD1MkfHchQqtTZJstG7PhMs1srrN6Q7TyI9tHxSRIB8B5
        cXPACi4n/bUkKElqmEb87jBVv5LSnIFOWZJr6XT4
X-Google-Smtp-Source: ABdhPJy6ikiiG5Pgs8lsfgZefLhFTNca6qzZhUMHty1h0zpae8r/I4ovX2ynJs0741nV5ruzT5/eOwQ1CLGrCli+a3s=
X-Received: by 2002:a17:907:2a54:b0:6d5:879d:aca4 with SMTP id
 fe20-20020a1709072a5400b006d5879daca4mr7473197ejc.29.1645822497528; Fri, 25
 Feb 2022 12:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20220224102417.42268-1-richard_c_haines@btinternet.com>
 <CAHC9VhT4V=d8LtNT2mbiB6m1eUypi5WxPdRux_YNJ9iCV=WjWg@mail.gmail.com> <CAFqZXNtLw_c1V7MvQ=uVO9da1LH0dP64Vy3eEvL8Por_o6NQ5A@mail.gmail.com>
In-Reply-To: <CAFqZXNtLw_c1V7MvQ=uVO9da1LH0dP64Vy3eEvL8Por_o6NQ5A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Feb 2022 15:54:46 -0500
Message-ID: <CAHC9VhTW+zZQb6a2QE2iRYfyyUxjMphRYfSWt6bgp2JvodrTgQ@mail.gmail.com>
Subject: Re: [PATCH V3] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 25, 2022 at 5:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> (IMHO the POLICYDB_CAPABILITY_ prefix is ridiculously long for no
> reason and we should simply shorten it (just POLCAP_ would be
> perfectly fine, IMHO) instead of trying to abbreviate the rest. Of
> course, this doesn't have to be done now - I'm taking a note to myself
> to splice in such rename next time I add a new capability, if not
> earlier.)

Yeah, that prefix is probably longer than it needs to be.  Since we're
at -rc5 right now, with -rc6 just a few days away, I'll go ahead and
toss out a patch to shorten the names next week.  While I have very
mixed feelings on style/formatting-only patches, things like this
should go into selinux/next at the end of the -rcX cycle so as not to
cause unnecessary conflicts for people making "real" changes :)

-- 
paul-moore.com
