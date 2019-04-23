Return-Path: <SRS0=RjX6=SZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7DDC10F14
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3168821773
	for <selinux@archiver.kernel.org>; Tue, 23 Apr 2019 13:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="D8AQUfJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfDWNnW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:43:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34722 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfDWNnW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Apr 2019 09:43:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id y16so2751810ljg.1
        for <selinux@vger.kernel.org>; Tue, 23 Apr 2019 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85v3Amjq2HXZ2KZeuvLNC2xFUYG/wf0ssengDeUmeks=;
        b=D8AQUfJbGAnfWvJbXUH2psBcRW17OaO4AiqjiWGDnclviZ0Kdu4KX0z1h8ySXiiGX6
         7Yio3C1VPN4zBcwVLWEK3PRfNYysKcvlr4FsxgRFrHTsG5ZWOiQBu8gQUc+nx5b1YiXD
         lA9a4nsj3/bR1XUSENekssx3j6bdXJwYN75+yof+sJCF4xEZ9KNhTJObYrw/XDYxvlCw
         gbaPedZqXK2n2csLLe4OttXxd0UPSgFEU5y/mzx5z/0ggGCA7kCoNm0QdEkvmPHkJxPG
         lP7o7CwOlP1rtFtOwIeIU5vgG2yAjP0daD23p7BXGVdB746yWUXK5F+SOypQ+WIcUnvJ
         Z0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85v3Amjq2HXZ2KZeuvLNC2xFUYG/wf0ssengDeUmeks=;
        b=daHLag3Dt8JJkXblbp2kjmhC5eb/xx17T+tgcDaDxNa+Mz2Ji0RJTUOZV7O9BzhpAL
         oZhvQb3/lDa0zEQlzNv5IPC9klxtSkYn/SZWoTZ14hpiF0iO9TgQVCEaJvmPGWvnHQvD
         31TOPNA1wCx/IS2ZrHOQWhy33pVnYPf0OiM6caT3xetR6LcNm9EVNmxs7PznMSNkcsyz
         jNLb/8Ab2bczq+3BmtPS2FNBU7ZOE5cyEt6N6Dz4uenyCi8F8UbEYUuo6r5gV1N9CVy5
         sMBwZ5BIeV+ddo2Qv8iLbHZYPsMtJXLJVM4SaF7gfb6XUOFxwQ3d/BWb1dpSfC6VUEPb
         TJiQ==
X-Gm-Message-State: APjAAAU3pGuRQHlzeXeKTFCJehbrtQijdWqsTOi7e1hwuccIkNAasabb
        ZdHff3jvgfSepujRXyiml8Tx5TVmGilpKm1vsmgc
X-Google-Smtp-Source: APXvYqzYl/3ecbLLgku7EVW7oSq3VXHocfIn6AhYhdSz0o1SClaJaGwVRAkCSWyVhN8J0OwI1xgCm+bdLgVoR/1HIFk=
X-Received: by 2002:a2e:5301:: with SMTP id h1mr13429199ljb.196.1556027000274;
 Tue, 23 Apr 2019 06:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190422210041.GA21711@archlinux-i9> <CAHC9VhTtz3OA3EchaZaAeg=DxoGoz_WFdj+Mi9nd9i+cmjmuJA@mail.gmail.com>
 <20190423132926.GK17719@sasha-vm>
In-Reply-To: <20190423132926.GK17719@sasha-vm>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Apr 2019 09:43:09 -0400
Message-ID: <CAHC9VhRcdY7G_ES2VqNVpkoU=CRJkJySb3m1sFdgKJwh3JQ2oA@mail.gmail.com>
Subject: Re: scripts/selinux build error in 4.14 after glibc update
To:     Sasha Levin <sashal@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 23, 2019 at 9:29 AM Sasha Levin <sashal@kernel.org> wrote:
> On Mon, Apr 22, 2019 at 09:59:47PM -0400, Paul Moore wrote:
> >On Mon, Apr 22, 2019 at 5:00 PM Nathan Chancellor
> ><natechancellor@gmail.com> wrote:
> >> Hi all,
> >>
> >> After a glibc update to 2.29, my 4.14 builds started failing like so:
> >
> >...
> >
> >>   HOSTCC  scripts/selinux/genheaders/genheaders
> >> In file included from scripts/selinux/genheaders/genheaders.c:19:
> >> ./security/selinux/include/classmap.h:245:2: error: #error New address family defined, please update secclass_map.
> >>  #error New address family defined, please update secclass_map.
> >>   ^~~~~
> >
> >This is a known problem that has a fix in the selinux/next branch and
> >will be going up to Linus during the next merge window.  The fix is
> >quite small and should be relatively easy for you to backport to your
> >kernel build if you are interested; the patch can be found at the
> >archive link below:
> >
> >https://lore.kernel.org/selinux/20190225005528.28371-1-paulo@paulo.ac
>
> Why is it waiting for the next merge window? It fixes a build bug that
> people hit.

I place a reasonably high bar on patches that I send up to Linus
outside of the merge window and I didn't feel this patch met that
criteria.  Nathan is only the second person I've seen who has
encountered this problem, the first being the original patch author.
As far as I've seen, the problem is only seen by users building older
kernels on very new userspaces (e.g. glibc v2.29 was released in
February 2019, Linux v4.14 was released in 2017); this doesn't appear
to be a large group of people and I didn't want to risk breaking the
main kernel tree during the -rcX phase for such a small group.

-- 
paul moore
www.paul-moore.com
