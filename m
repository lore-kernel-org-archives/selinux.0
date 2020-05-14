Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A11C433E0
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6D7205CB
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 14:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6XkDAwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgENOuR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgENOuR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 10:50:17 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76DC061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 07:50:17 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d26so2535442otc.7
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmfbJz0lr5kfrtO9b8JIBOjpSHq4kdxyAcyn5d8F8gA=;
        b=c6XkDAwxJvU597LuvqYrJyl0tO1/Zfbem7As4LIU/0laMMH5vg+441UkYrGEbocVr+
         86wotKcn3nXI1djQwEbmwIi1ZGbFu/lai9ubQKkcZrCKZFznMvZrTwJwLWSeEAisfE2j
         riUzO5KMD0Vqsvc+AuzDR5VydWNbBi4U9f5sgl+IIIU//If21xkGPC1A32QIWDkKPt4L
         DJNzsio13R2dJk7vU6AIVB9zdOXZQU9Ars/WgKONkAWWu3LLTz56jolyiYY0dlB2tA90
         APyVmPKHYq4s030rpA4pzdMN6xSbTs6nV9f8S21bgnaOYRamGMD4yM1BaHR3Qb5dLjw/
         9WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmfbJz0lr5kfrtO9b8JIBOjpSHq4kdxyAcyn5d8F8gA=;
        b=AygaTNVvmci3FfggCTvL3YF3Y9cyZHy4GYcQ776F8HzhSIEALkTKMIrpZuIcCFlz9o
         VTgKEJxYbKs3BuuUlbY0R2KMf4BMv079pbXFmlf/P27boZRB3UlChXY27Ik6hZ6Mi18V
         JAWOUVibE6K44gk8rxehdwMDrJGPB1NtB5j5favCxAuwaYG/9cU5g83spco4hoOAsyt6
         BbFs1l/aVMO4pV0oAm6vNUJgZ7yutnH8FsVurzGqDPRrlD/Pl3+RQ1UoC2xRUIO66BpV
         AZVlNyE6OFZ8Qu9NzAfr9NzGKy8b2UVB0BjiXOjZy0PJKwn9JVHtZUNlhDCwlcjbmwBP
         hpOA==
X-Gm-Message-State: AOAM530mz7zWKVT8b0GC5nQwqwYvsjOUHbyg7Zfee+VGaG73zPxkO4Oq
        tAz3EZJ5ka1/3zaUi12FZ0q210I6ScXZcxjvaPD/TRAW
X-Google-Smtp-Source: ABdhPJy6otBQCHRKoD3u0m+1tLoCqIgqsI96z0fda4vuEC4vx85Rd0f+eJUWQoJt5PIDDH7RqNCPOueGlURixU/VJRU=
X-Received: by 2002:a05:6830:186:: with SMTP id q6mr3882229ota.162.1589467816815;
 Thu, 14 May 2020 07:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQRFBmUdjpz0GudUxyACjveCWg0yyGzz_6_5YnUQ4fLBQ@mail.gmail.com>
 <CAMN686H5K6Ohzd297giboVoD=Jud+k9tRvvCtJJZ8jvNmv_=HA@mail.gmail.com> <CAO6P2QS78aTzCvMHgUWmgmkVjEN9v0Wq0Lgys2puL6eRW+CLjg@mail.gmail.com>
In-Reply-To: <CAO6P2QS78aTzCvMHgUWmgmkVjEN9v0Wq0Lgys2puL6eRW+CLjg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 14 May 2020 10:50:05 -0400
Message-ID: <CAEjxPJ4ePzeuhiRdLndM3U7sybjG8QUO8xhd5RuFNH-YB8NB1w@mail.gmail.com>
Subject: Re: Configuring MLS with a daemon operating at multiple sensitivities
To:     Paul Tagliamonte <paultag@debian.org>
Cc:     Mike Palmiotto <mike.palmiotto@crunchydata.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 10:01 AM Paul Tagliamonte <paultag@debian.org> wrote:
>
> Hey there Mike,
>
> Incredible! This is very helpful, thank you very much! I think this is
> the missing building block I need.
>
> Have a great day, and thank you to Josh!

Was computing the MLS label the only part you needed?  With respect to
having the daemon run in the same label as the peer (or the label
derived from the intersection of the peer and the daemon), you may
wish to have a look at mod_selinux for Apache and/or the old xinetd
LABELED option, although neither of those would have included the new
glblub support so you'll have to integrate that yourself.  Or your
daemon can just use setcon(3) directly if allowed by policy.
