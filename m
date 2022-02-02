Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD5C433EF
	for <selinux@archiver.kernel.org>; Wed,  2 Feb 2022 16:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbiBBQE5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Feb 2022 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbiBBQEz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Feb 2022 11:04:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D3C06173D
        for <selinux@vger.kernel.org>; Wed,  2 Feb 2022 08:04:55 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c24so43529341edy.4
        for <selinux@vger.kernel.org>; Wed, 02 Feb 2022 08:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8XDJWaf+HoqlQNAE1r2JlUclS76hjxcv6QG3k0ojVY=;
        b=aewIzRW3bYO9Qtvi7ydqWjuFPI08RZUw1/OybUT1wYKGO2mJlxKzTiBSYhgcPlpEpT
         xDF8igGtowMtCHME+9TAmdAfBfOmPykesYpCGZ1qLXrvJeumxlSiokQVowqKEZKEZU3v
         oB/4cMClDgQxpya/m9MRTkK1GFvVLEVB0p6GqQaPyIePmHPm9WKyHjGW53qG1S7XhDSW
         ejZblN14eIi0NTJK9eU/LnPnZDGIfoGcH4Uz65H7hWeaheeHcmIHPV2rGEmfFU/3BxUC
         +0L6GUNohQi9mvCDHqn9pDCsUfXQcPOXU2/m/egCWB9u1qD8WYbHFmmxh4Jt01BC1gaY
         Az0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8XDJWaf+HoqlQNAE1r2JlUclS76hjxcv6QG3k0ojVY=;
        b=FqHwv4razY+yLbyWDO3sV0mzld8riwNvL/N0SQe+lgDgiOUUX41NDtAdzaCST/UBnO
         Zhl4wpthrBgaINl26+c7KeNWXaWmTH5MDUuyDo6Eg0uHVHqFCHMpilBHhk4OjYHMCxr6
         GyyCj0AHI173ckEhJcXwcNQ48LHdBGezE3BLRr0OJ4ScLOMgj6rK9bBiNJG09KGHea2G
         3swAWp34D2g0JbmwRPtowIaRmqvp2EblI5wVM5odfz1Gv5v+G1QCOEo3fLXuYhMiyszB
         drvkdHAyPb5oB0/7pnc86EGackt7sKqnQpKbJDhANVEkR8pkZ/J3Kdo0ilzwoHo7agDa
         H0Ng==
X-Gm-Message-State: AOAM532eL1eMutTBPWN0MT0HKUkzC7xR1gbqKqAuKCj+VIlwyxKfnNty
        iA3U2WpXNJN/e0oACVMYPg8KqRch1HugXwR+CEDj85AcKzrr
X-Google-Smtp-Source: ABdhPJzIYm4R3hFxsLqXy5P6CnVCHdTDObqlpa9JdFdXHJwMMuF58QjL3ONLdVHQwGsYwm2ftdw32L2jtgeJM+Mbxzs=
X-Received: by 2002:a05:6402:345:: with SMTP id r5mr31399867edw.269.1643817893533;
 Wed, 02 Feb 2022 08:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20220202112511.18010-1-vbendel@redhat.com>
In-Reply-To: <20220202112511.18010-1-vbendel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Feb 2022 11:04:42 -0500
Message-ID: <CAHC9VhR4eTEOO2m=HXYdG89mDBOPnd5BcWLwMCO-qZ8BWNMd9Q@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix double free of cond_list on error paths
To:     vbendel@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 2, 2022 at 6:25 AM <vbendel@redhat.com> wrote:
>
> From: Vratislav Bendel <vbendel@redhat.com>
>
> On error path from cond_read_list() and duplicate_policydb_cond_list()
> the cond_list_destroy() gets called a second time in caller functions,
> resulting in NULL pointer deref.
> Fix this by resetting the cond_list_len to 0 in cond_list_destroy(),
> making subsequent calls a noop.
>
> Also consistently reset the cond_list pointer to NULL after freeing.
>
> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I just merged this into selinux/stable-5.17 and I'll plan on sending
this up to Linus tomorrow, thanks Vratislav.

-- 
paul-moore.com
