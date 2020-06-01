Return-Path: <SRS0=O06S=7O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8972C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 12:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF6920679
	for <selinux@archiver.kernel.org>; Mon,  1 Jun 2020 12:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXaGzYec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFAMmj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFAMmj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Jun 2020 08:42:39 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0311BC061A0E
        for <selinux@vger.kernel.org>; Mon,  1 Jun 2020 05:42:39 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d67so3736584oig.6
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2020 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aj+VWnjwh38GDcUZcTkRLkspzAieTabtOmu81pbLJNE=;
        b=LXaGzYecSLTmxA7Rsjbbjh5EIY4bulGDcAncbXRdttfGAL26B/SrtExO1sRfXtw5so
         lTbywwsH3kLHKZiWoClLc2PtkYndDH5/sXu9WFBxNBWY+lbEjRpjkfiHbF2ncegXWHeT
         yBrA2g1IF1Ne03magD6euhqjPVAyr3sURsos/OF14E2yAHbEXefnny3ohg4sUj5/h4dl
         1WrwTqSc4ZPUaODRuK/QeE4N5rdKnrBQcyt5G/fOTMspAg+ifur5/X43iARsI95Sblri
         I0DGXVteIHe6f9CJJulDP72mU/IBFWzqy2QLo/VoNZpljOkQ2O9MLuKgJqzku+BtIleA
         Fx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aj+VWnjwh38GDcUZcTkRLkspzAieTabtOmu81pbLJNE=;
        b=moOFaC4+TMnP+dIt2vuPYeDKPgG++RW7WOOm6mBe5Y88n+JooBFZMMSLmiVA2qtysZ
         CvfpoePdmgHlU7DcyI92j+vhfv3rWC65hUsowCbcr+AwnZ/0DYQ2a0kJq2T1MAImoY7Z
         bmC7pBJXWnJJzUTC777FtnHKfg9usYaTdsEh9oA9+ktF5LXHkzwdrYMPM096Jzau1IXQ
         NOzBjvwsDl4e7qwUslQGH8CCv9+MOFo99T9oJayC3dqcm+XEf7Rb5/2gv4Psjowu+dYy
         oabTLMDjzF06jjVjZ8bUe6cj1BYTyXFYOdTM4TdBU1p7DZu0tNVeSMDG8pUb/K8L1wOs
         8PPg==
X-Gm-Message-State: AOAM533sYxnHGWfpUDgSxi/341d765crBjo8tnMMrpPsV/mxRxMb97tF
        3Hc8ueYp+4DQhC0ysX93UewnV/ydRK7cGopQ7sM=
X-Google-Smtp-Source: ABdhPJyCRm2+Y+Hvlcy/F1zVyjIuzQ9dX9BlPETxBnaM6jw0sBmqJFyo06Jeh2rWBRNPQUT2bdl0GgKl1yEX3qzCqm8=
X-Received: by 2002:aca:a948:: with SMTP id s69mr14133166oie.140.1591015358426;
 Mon, 01 Jun 2020 05:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200601072916.219197-1-chirantan@chromium.org>
In-Reply-To: <20200601072916.219197-1-chirantan@chromium.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 1 Jun 2020 08:42:27 -0400
Message-ID: <CAEjxPJ41UVY7C9HAahsmm5P4babvi+VVDZi6a2Zwf7MopJgbnQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Allow file owner to set "security.sehash"
To:     Chirantan Ekbote <chirantan@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 1, 2020 at 3:29 AM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> Normally a process needs CAP_SYS_ADMIN in the namespace that mounted a
> particular filesystem in order to set a security xattr. However, this
> restriction is relaxed for the security.selinux xattr: the file owner
> or a process with CAP_FOWNER in its namespace may set this attribute.
>
> Apply this relaxed restriction to the security.sehash xattr as well.
> Since this xattr is mainly a performance optimization when labeling
> files recursively it shouldn't have stricter requirements than setting
> the selinux xattr in the first place.

First, setting either security.<non-selinux> or security.selinux has
an additional MAC check beyond the DAC/capability check; in the former
case there is the FILE__SETATTR check and in the latter there are the
FILE__RELABELFROM/TO checks.  We need to preserve some kind of SELinux
permission check here.

Second, security.sehash logic in userspace was introduced by Android
in its libselinux fork and then copied in upstream logic.  I'm not
sure Android wants to relax the current requirement for CAP_SYS_ADMIN
- I have copied them above.  A possible concern is that an
unprivileged process could disable the relabeling of a part of the
tree that it owns upon an upgrade, which could have unexpected
consequences.
