Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3DCC64EC4
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 20:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCIUtA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 15:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCIUsZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 15:48:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC847436
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 12:48:23 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s17so1851501pgv.4
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678394903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUEbEU4G4H8wKLIvZAfH1aq0nEMsCPIHK81mKcys8rE=;
        b=a4qq1jFU22llyteaADnX9/iU9+zG36e3V+J7vPtgwhb9qnRA2Ib38RO4oyUnP8r1VU
         bfQy+menJ3rZKNx+yy3Vkpsk8SA/kbptzzrmTdqWAHJOryCEe9SC/aGUdQYEpBIX+J9W
         LHCy1HAs6CDlzCDSvp4aECzWt45hmriS5LGmdyq3utGRTxpTv1TqVHLl+MbKMYL2zTDo
         CBensyaY2dEjWbVf4vnoLF3IaEBFAAT23MxLzIR9VgdBylW0SH2ec6FegVbtGH0wT3sD
         Gga9Kd0NHT0Uz62nwv8oP6qjy7we8YYsGoZKSuYbtmTtyTseSV6T6I0PngGGWdo9Sh2d
         qpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678394903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUEbEU4G4H8wKLIvZAfH1aq0nEMsCPIHK81mKcys8rE=;
        b=PG9xuWvGUY4qA7pJIymSbO58UoP24m3tp1iANfC9JKD38R8OMBOHlhDjlc+XVnSXmv
         /3eC+Lek8+hDuI/7Cb6qD7CDWsTgT+QX+Y2dkdhjZfRnV6vvvqBDKaFm1dRooPSQ3gq4
         K6p/1n7qQGWyZYR13dR1/Uj82wgds79KwwhC8ahoTGY5eFDit8yrBCsSnSaOyiVRvSo0
         MfaTwyUQneIPUDXfF0HAOV2f152C029F8u9uCHrz4J/KBSFzNj405t6zbtqYA7BD60GE
         JiBW8MzsBotp+Y+pIuS1LlSuKHayWX8vE1KEz0ljhau7p9slT63lQ9s1yUeV8hGO1UVy
         O83A==
X-Gm-Message-State: AO0yUKVthIAiicz4JzE0hqAT8X2sLang2QFjCzU/6pU+o3ybC3rPTh2t
        qcKeOz5Cyn0ZM6tNvUCrwzU82aS7r55J1f229SMn
X-Google-Smtp-Source: AK7set/Uj7pQzfR/UPyYDgzNNjZV1VMMH+T1ahA45q76W9lSmt/X42qQ8AVlBfYpOQ4K8jpkqgG5KlazWzYuiFI5Szg=
X-Received: by 2002:a65:66c6:0:b0:4fc:d6df:85a0 with SMTP id
 c6-20020a6566c6000000b004fcd6df85a0mr8023799pgw.1.1678394902912; Thu, 09 Mar
 2023 12:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20230309191741.15063-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230309191741.15063-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Mar 2023 15:48:11 -0500
Message-ID: <CAHC9VhTCScrPmzrzSVPqF0G==4+qxd=KSeBw7s3T_46rDgKoXQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: stop passing selinux_state pointers and their offspring
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, torvalds@linux-foundation.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 9, 2023 at 2:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Linus observed that the pervasive passing of selinux_state pointers
> introduced by me in commit aa8e712cee93 ("selinux: wrap global selinux
> state") adds overhead and complexity without providing any
> benefit. The original idea was to pave the way for SELinux namespaces
> but those have not yet been implemented and there isn't currently
> a concrete plan to do so. Remove the passing of the selinux_state
> pointers, reverting to direct use of the single global selinux_state,
> and likewise remove passing of child pointers like the selinux_avc.
> The selinux_policy pointer remains as it is needed for atomic switching
> of policies.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c                 | 197 ++++-----
>  security/selinux/hooks.c               | 549 ++++++++++---------------
>  security/selinux/ibpkey.c              |   2 +-
>  security/selinux/ima.c                 |  37 +-
>  security/selinux/include/avc.h         |  29 +-
>  security/selinux/include/avc_ss.h      |   3 +-
>  security/selinux/include/conditional.h |   4 +-
>  security/selinux/include/ima.h         |  10 +-
>  security/selinux/include/security.h    | 171 +++-----
>  security/selinux/netif.c               |   2 +-
>  security/selinux/netlabel.c            |  17 +-
>  security/selinux/netnode.c             |   4 +-
>  security/selinux/netport.c             |   2 +-
>  security/selinux/selinuxfs.c           | 208 ++++------
>  security/selinux/ss/services.c         | 346 +++++++---------
>  security/selinux/ss/services.h         |   1 -
>  security/selinux/status.c              |  44 +-
>  security/selinux/xfrm.c                |  20 +-
>  18 files changed, 651 insertions(+), 995 deletions(-)

It looks like this patch was a bit too big for the mailing list; I'm
trimming my reply to get this discussion on the list.

I strongly dislike merging patches that haven't hit the list, but I do
recognize that this is a bit of an unusual case.  Have you tried
breaking this up into two (three?) patches?  I imagine that should be
possible, although I worry that the time required to do that would be
prohibitive given the change itself.

If that doesn't work, an alternative might be to file a PR against our
kernel subsystem mirror on GitHub and posting a link to the PR here.
I don't want to encourage this as a general way of submitting SELinux
kernel patches, but I could make an exception here.

https://github.com/SELinuxProject/selinux-kernel

--=20
paul-moore.com
