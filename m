Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2024CC4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F115A61214
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 14:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhHXOr2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbhHXOr2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 10:47:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF1C061757
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 07:46:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n27so12941901eja.5
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIny/2XICcZOy9+/It3NCvu/RbXYv1VpP1UfIOelqj8=;
        b=eORvwxytiEn3npkHgQ7aJgxdcXk4YBzH3LVD52Yk372cD9MczuNNJUEEu22Ye69KGM
         hBgwAz4e7R1fvDmOGHc2FgPvNz5VcSrWh/OlYYfaCG+TaknZ0LlSB9rUPRISlhkgVy2O
         +Wl3H32GHR5g5KobNlJJIW9q0x3otVYUbO0PuRyVy4d5ujRHE0mobZ6yJp1UL/NfZMUn
         K6GiKDTKbgCM/tqna24eOtDMIqubsdRbSunfKpVsAY6PoIzMpEjwSeyIfx5xs+hXptgf
         KCU5ugL/jLEpjnj/k5LNuUDGZLF0nj6OksHEwhMi7HfhUqKdO5roB2uhy/sf5jV7CAl3
         c3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIny/2XICcZOy9+/It3NCvu/RbXYv1VpP1UfIOelqj8=;
        b=UgSFdCzJSJ7kFkMK9i2GuHq8hxyl4ZiRlGi+roQy1KIEqaCQLRctYpVLCnMu614b+I
         3FCblRvO2GZvk2p2U/NBP3w93B67CXWDFz+H8bCq9RWE6zZHrDGOe+0nUUkBsaLA66UW
         vy8Gdf61zu4lFLz31ipufjQsiiP6IiKM8arIkwztXARYq/ZmjIhqFgqfxTsyTPJalY+4
         arDFbuTjv2XZ8JSut++jvu+pU0Si8w5rX9novOFKZUrzQ5LQP0W53ERX/Q8wBKjzKdwe
         MMC3zZCysCHb13B7tHP3F181r6igbTFuIY6YjzhA3LB6sCBVpN2y/HG1X2zFKHGcHymm
         68sA==
X-Gm-Message-State: AOAM5304WepmoMapHfV31aXg0pJC3Mj8ohymS6TghoEdPY2vp0iEqBHI
        H2wcWIbXbpSyGxnZIkEDj1vv0FaQvcvFlagw+Rwu
X-Google-Smtp-Source: ABdhPJxHY1BXJtysnDWWYVN5F+p1XnYFcZCzBbZCk3J14JGdG7JGGOiKkYOVFxCU1B21Tnz+buLko3irsMOZW7fwelk=
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr8733409ejr.398.1629816402264;
 Tue, 24 Aug 2021 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210824022247.GA22908@raspberrypi>
In-Reply-To: <20210824022247.GA22908@raspberrypi>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Aug 2021 10:46:31 -0400
Message-ID: <CAHC9VhTgeSbRDrK-HHaZLxyR7ezFrW-0TbGRfutF1NwXVHnXWg@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove duplicated initialization of 'i' for clean-up
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        austin.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 23, 2021 at 10:22 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> From: Austin Kim <austin.kim@lge.com>
>
> The local variable 'i' is used to be incremented inside while loop
> within sidtab_convert_tree(). Before while loop, 'i' is set to 0
> inside if/else statement.
>
> Since there is no 'goto' statement within sidtab_convert_tree(),
> it had better initialize 'i' as 0 once before if/else statement.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/selinux/ss/sidtab.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Let's leave the existing code as-is for now.

-- 
paul moore
www.paul-moore.com
