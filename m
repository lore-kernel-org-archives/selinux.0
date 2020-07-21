Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD60C433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1296207DD
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBNG4Fri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGURpB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGURpA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 13:45:00 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B05C061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 10:45:00 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id t18so15689807otq.5
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YuAAlnNhRGV+P6l4VUxLpPCp0GIlLGowIXk9koP3xv0=;
        b=TBNG4FriZwEJBEBaIfdWX2kWnNBwK5nF+rrZJXyuEd4DeXbsdTOWHBqrWcUYkxlIgz
         63QjCbLJXxzcrhnvLQT9zDOSziMFtoulDroaVJ7/Ox/1VLsAeDx9Z8hpNBrk5eycBTnI
         sQR3SFY2pigNEPv22mNUu7uVWHGrUa5PoCqd2IZiuwZhf/Zu7yYToLrS5A76F5n3SFR/
         yAuRx8uoW6fHm1eU6dmpTT6fPd3+itvijYNylQ8j5/YGV1XUl1hHOrfuxV+SKy5B2d1W
         fCH0zrh04hJLKJiM2blJjtQyyUCidbJjt8b8GETrMrm266jw4NU9kNr8etGKUCxAt3IF
         uqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YuAAlnNhRGV+P6l4VUxLpPCp0GIlLGowIXk9koP3xv0=;
        b=hOMnzmMscoITA0GRQtE0ol239rZ0KQLQTm19N28zNd/WtYGEnmxYJaMEn8GvhDqTKN
         e7JnCRuHbLM2kJkTy8wQ5aK2gOcSTN1AldPNKUKvCWiUzTvJLAlkzu9mIy85hySsUStZ
         EXu/cOUZn9PvZxx2ZKrYj8CaL4sPTsBNaGGXZspo23LI0nMu0Dd532YpXfXjQRSCrvDd
         Na+JQJKc03QlMC9k5TqxxNdXEgkyHnzXfr638vW4Gq9MyYIW23JjY/uaGgTe2Q+j0+EW
         iwhXC2i9sTSXYOkbGNfKHLsCmXQck5vIrewPcEbQUjM+z0z02Frd1wTV9sMxNRXf0G9S
         BEEA==
X-Gm-Message-State: AOAM533NtfCb+fggYsb7IrUUUoP2R7O+03VqbqhBbXEjpsreoVXBOU08
        atAyoQmb18aoT0LF6pQbKHmZVH7AZ0iR86Hbq6c=
X-Google-Smtp-Source: ABdhPJyDOKWJ73qB55/8r9YoJUY5ziOcelWk/513dUnF8QThibhxNTkILmWccJ4wCmyF76UNgkPja+TP5YtzSxyqffI=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr25749061oti.162.1595353500083;
 Tue, 21 Jul 2020 10:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1d_=gotE6eau2hmxM+OjujY=u8sMQE10gNKOJ1z87dQ@mail.gmail.com>
 <20200719094420.1515976-1-dominick.grift@defensec.nl>
In-Reply-To: <20200719094420.1515976-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Jul 2020 13:44:49 -0400
Message-ID: <CAEjxPJ4azq2sfyXG4wq8OVbkqcFa3c_UW4HZC1D7TmNa7Eaf9w@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v6] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 19, 2020 at 5:45 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Elaborate on labeling. Touch on the significance of the default statement=
, on various av permissions related to labeling using the libselinux API, a=
nd on how the kernel and unlabeled initial security identifiers are used to=
 address labeling challenges in special cases such as initialization and fa=
ilover respectively.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---

> diff --git a/src/objects.md b/src/objects.md
> index 58664ef..d27f881 100644
> --- a/src/objects.md
> +++ b/src/objects.md
> +    policy's approval of course) using the **libselinux** API
> +    functions. The `process setfscreate` access vector can be used to

process setfscreate is a permission.  An access vector is a set of
permissions. The access vector definitions in the policy specify the
set of permissions associated with each class.

> @@ -269,6 +275,23 @@ and manage their transition:
>
>  `type_transition`, `role_transition` and `range_transition`
>
> +SELinux-aware applications can enforce a new label (with the policy's

I don't think you originated this language but technically it should
be "can assign a new label"
or "specify a particular label" or similar, not "enforce a new label".

> +The `kernel` **initial security identifier** is used to associate
> +specified a label with subjects that were left unlabeled due to
> +system initialization, for example kernel threads.

The kernel SID is used for kernel objects, including kernel threads
(both those that are created during initialization but also kernel
threads created later), kernel-private sockets, synthetic objects
representing kernel resources (e.g. the "system" class), etc.  It is
true that processes created prior to initial policy load will also be
in the kernel SID until/unless there is a policy loaded and either a
policy-defined transition or an explicit setcon or setexeccon+execve,
but that's just the typical default inheritance from creating task
behavior for processes.

> +
> +The `unlabeled` **initial security identifier** is used
> +to associate a specified label with subjects that had their label
> +invalidated due to policy changes at runtime.

It is also assigned as the initial state for various objects e.g.
inodes, superblocks, etc until they reach a point where a more
specific label can be determined e.g. from an xattr or from policy.
The context associated with the unlabeled SID is used as the fallback
context for both subjects and objects when their label is invalidated
by a policy reload (their SID is unchanged but the SID is
transparently remapped to the unlabeled context).
