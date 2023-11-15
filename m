Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE9C2BB3F
	for <selinux@archiver.kernel.org>; Wed, 15 Nov 2023 17:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjKORVp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Nov 2023 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKORVm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Nov 2023 12:21:42 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F9FB6
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 09:21:39 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so7627600276.1
        for <selinux@vger.kernel.org>; Wed, 15 Nov 2023 09:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700068898; x=1700673698; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfMyR18hgDvp14r8RW3NISABZjIuZV+B19A7yvvFKxM=;
        b=Gu08lX77K2vXQ+29JHUVvn/lNuAoKbPRe+I19/f3llD5ZWijyqkZiXCIMt8aM02DZC
         surqtAHpJsxcH0mWjgQuew+auK5cGPgS5Pxs+8tu2pd2elXublnZvA3/5VyxLP1IFBmk
         lxepk+iiiWCoqhikCPVra3MNjqEmR/4ROGBXqE15++nlekQK6JSAo1GqGLATn3iN/7iW
         Ce44SAkWtKY6sOjNxQTKBHxc79/x+j2YsYer87i+a1jHw2/H4wvLz6P8YIAK9ay7yG16
         AsWzIgvjMsxznrgAAvsrj/KKPnIYHrbXmX1+8x0EvG4ty4H/dKTt/Yrm45NLIQem7b1D
         tv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068898; x=1700673698;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfMyR18hgDvp14r8RW3NISABZjIuZV+B19A7yvvFKxM=;
        b=pAZEPQechWKAhM079DkWxhU93GjmB/xu5sms3uhlzvlksWf36IYZcwYN8gxBq4ZQ5g
         uNMhmSqSk360SbQwJVTbhSdP0DKbNO5bDw/gQu8XiWKQ8OCmv1fvyNty5HFriy7YIFJg
         vQQY3LoSODBqxAuCVDanHUnuBMKgDH1vvDa8aTOpViDsVWxbTHej9sFYSmqMAp7gSHmd
         EKesbMrvntXKXg8wrGqmHIKtMBou3G4fHS6upN4RJ64HvrEw7ZfkEPpLajqwqSo3IB/T
         agdOx0lmz5p4QC+2p6A/ztvSQs2H25oGkz1zQyxlZH0Y0iTIQK9e6vb8lH7Ed15yrLZk
         06ag==
X-Gm-Message-State: AOJu0Yw9g5LYx06kp46TpQ7oSK/L6BKND7Kqu/Ae01Nt6/lLlD5lqqKI
        8Qa2GdfnOHII3O3tXeLbmS7TCjNvyPmz0jn0/Q4i2lk7h3T1NWkaZA==
X-Google-Smtp-Source: AGHT+IGliUw2/5ZyZau5ihwwt4nefUQvSeWvkm9HR7x+37DzuF7NT3RE0ag8axk7lcXtco5Z7KsEcgYPVXdGfBL5ZiU=
X-Received: by 2002:a25:2684:0:b0:da0:b36c:1af1 with SMTP id
 m126-20020a252684000000b00da0b36c1af1mr12810642ybm.62.1700068898508; Wed, 15
 Nov 2023 09:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20231115170405.113117-2-paul@paul-moore.com>
In-Reply-To: <20231115170405.113117-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Nov 2023 12:21:27 -0500
Message-ID: <CAHC9VhSnpjTBdDvJuF9cH6_s+AtOYStrvqaXTRpbDBSPSpvAyQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the SELinux entry
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 15, 2023 at 12:04=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Bring the SELinux entry up to date with the following changes:
>
> * Remove the selinuxproject.org link.  The wiki located there is in
> read-only mode and exists primarily for historical reasons.
>
> * Add our patchwork link.  I'm not sure this is of much use for
> anyone but the maintainer, but there is a provision for including it
> here so we might as well include it.
>
> * Add a bug report URI.  I suspect most everyone knows to send mail
> to the mailing list if they hit a bug, but let's make it official.
>
> * Add a link to the SELinux tree process/management documentation.
> While the doc exists both in the canonical kernel.org location and
> the GitHub mirror, provide a link to the mirror as GitHub does a
> better job rendering the Markdown.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..e5d289eaba83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19520,8 +19520,10 @@ M:     Stephen Smalley <stephen.smalley.work@gma=
il.com>
>  M:     Eric Paris <eparis@parisplace.org>
>  L:     selinux@vger.kernel.org
>  S:     Supported
> -W:     https://selinuxproject.org
>  W:     https://github.com/SELinuxProject
> +Q:     https://patchwork.kernel.org/project/selinux/list
> +B:     mailto:selinux@vger.kernel.org
> +P:     https://github.com/SELinuxProject/selinux-kernel/blob/main/README=
.md
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux=
.git

Unfortunately I didn't realize this until the patch hit my inbox, but
I should also update the tree location to use https instead of git.
I'll fix that when I merge the patch.

>  F:     Documentation/ABI/removed/sysfs-selinux-checkreqprot
>  F:     Documentation/ABI/removed/sysfs-selinux-disable
> --
> 2.42.1

--=20
paul-moore.com
