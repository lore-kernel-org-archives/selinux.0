Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E541C4332F
	for <selinux@archiver.kernel.org>; Wed,  1 Nov 2023 13:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjKANvz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Nov 2023 09:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjKANvz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Nov 2023 09:51:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECAB11B
        for <selinux@vger.kernel.org>; Wed,  1 Nov 2023 06:51:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso95141791fa.0
        for <selinux@vger.kernel.org>; Wed, 01 Nov 2023 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698846710; x=1699451510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toeUGJQ79nA7gU4/KJ36LUGOMQaBhM0lqI1Tp5SptqE=;
        b=CMwZMMmJGvcVjwtWX92/UhW9ZkGsenxl7EqtTUfB8YZzixasYfVUz2MBXVdXEXh039
         IQ2UyiitFNA0s5VwD5tDxGc4v1pq2iLetqN2qd0FWXU7ApWN2H3bFAEE+/cd8FeBx6SX
         vUxShdho0yWU9YRziZbRMmNnAAlBP6LXZxAsbPkBLBxfJGCvuqivZBG37Ifejlx9c07x
         vHbUQ3/84gHRrqHRQr6OBrOfYopXg6SMulWVC8y/SnBTTN+wOt8EdRNbFAa6AzO7xTsm
         6xHrSlHUs4tdGe+lJwsNDJfISpNNvIAbYOclWVr4T1jwxwxdzMR39JC1qmZ3kj+Qe7Fh
         keMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698846710; x=1699451510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toeUGJQ79nA7gU4/KJ36LUGOMQaBhM0lqI1Tp5SptqE=;
        b=eYBi8yvexbYbG5/faLvhpKmsDAVt0fnYT1vmStISZ1L9S+ZyETJ2hOnne6JgK1MhM1
         Z8a1r1xANjwt2aqjxIVaEt6JxFUec3OuwoygLdXRYr88mqLG3IYsS6uHAKVFPSr+sgiD
         SR3hgDo9TmiAX3w/PE48uWmQEIiIIwBPjJVGipQyuoEPfQPf4pw6R/ncDybTMzn6L/Kv
         IE2NYYlVyTQbcNoeYbTQXmzF7ZOXn/HDJHwzg1oKTG/2aamlQc0P8+3sqMW0cv60EJ8S
         87BCZd5FedutvaXD0GhbFdaBAeLpltBU9lnrlxvz52cg3qxa2uAnjqwtX7VIJHnKxZYS
         Ftew==
X-Gm-Message-State: AOJu0YzP1P3aZi3Kuy+5EtsD8+BVcirff+6mhHcLWWm0s69cE6z4Xp+q
        /v+eGH5Vl8qfyGk7MPtYMNBSodky79Zpkdsp1wZ28Hvo
X-Google-Smtp-Source: AGHT+IET9mqVRCG8MFayIxbRcwakNZoK4H2NClkU/OiRiyfrIwvRJLpM+7+UQazTMk+bZq8nMq8RkSbbNE1DAikR1eQ=
X-Received: by 2002:a05:6512:3995:b0:509:43cc:18b with SMTP id
 j21-20020a056512399500b0050943cc018bmr649512lfu.30.1698846709504; Wed, 01 Nov
 2023 06:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <f56796460aeb726520d0d954b94683c4.plautrba@redhat.com>
In-Reply-To: <f56796460aeb726520d0d954b94683c4.plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Nov 2023 09:51:38 -0400
Message-ID: <CAP+JOzTwFoRkevmohFs4gtZnaPPUcOQ3PdkkG0QF8D1tDbO3_g@mail.gmail.com>
Subject: Re: SELinux userspace 3.6 release - the current status and plan
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 8:39=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Hello,
>
> it's been some time [1] since we released 3.5 so it's time to start with
> 3.6
>
> [1] https://lore.kernel.org/selinux/87v8auhbr6.fsf@redhat.com/T/#t
>
> Currently we have about 153 merged changes and about 39 changes waiting
> for review or to be merged.
>
> You can see waiting queue at
>
> https://patchwork.kernel.org/project/selinux/list/?series=3D&submitter=3D=
&state=3D&q=3D&archive=3D&delegate=3D82149
>
> # Series:
>
> ## [RFC,1/9] libselinux: annotate interfaces with compiler attributes
>
> https://patchwork.kernel.org/project/selinux/list/?series=3D747047&submit=
ter=3D&state=3D*&q=3D&archive=3D&delegate=3D
>
> Given that some patches were already rejected, I guess that the whole set=
 could be considered as rejected as well.
>

Yes.

> ## [1/5] libsepol: free memory on str_read() failures
>
> https://patchwork.kernel.org/project/selinux/list/?series=3D765423&submit=
ter=3D&state=3D*&q=3D&archive=3D&delegate=3D
>
> Based on https://lore.kernel.org/all/CAP+JOzQ-AuM9M3c4ehKYca-eUAOy0wbVGky=
gkpPkhhSTNaVC-Q@mail.gmail.com/ I've marked them as "not applicable"
>

Yes, nothing necessarily wrong with the patches, but they would need
to be updated and resubmitted.

> ## libselinux: rework selabel_file(5) database
>
> https://patchwork.kernel.org/project/selinux/list/?series=3D775966&submit=
ter=3D&state=3D*&q=3D&archive=3D&delegate=3D
>
> Given that the majority was already accepted/merged, the rest could be co=
nsidered as rejected.
> If there's no objection I'll mark them before the release.
>

I am very hesitant about the selabel patches. I have never been
involved with the selablel code before and I am very worried about
potential ordering changes leading to labeling problems.
I would be ok with Christian updating them and resubmitting them after
this release. I am willing to review the code, but I really need some
other people to test them before I would be ready to merge them.

> ## [1/5] libsepol: include length squared in hashtab_hash_eval()
>
> https://patchwork.kernel.org/project/selinux/list/?series=3D776635
>
> no response yet
>

I never saw this patch series. I got kicked off the mailing list at
one point and had to resubscribe. I went through the archives, but
must have missed this series.
I'll take a look at it.

> ## CIL Cleanups and Improved Argument handling
>
> https://patchwork.kernel.org/project/selinux/list/?series=3D788225
>
> There's Reviewed-by and Acked-by attached to the first patch but I guess =
that it applies to the whole serie.
> If it's not merged before the release and there's no other objection, I'l=
l merge it.
>

Sounds good to me.

Thanks,
Jim

>
>
> The rest are individual patches which are already acked or waiting for re=
view.
>
>
> # Plan
>
> During this week, I'll prepare update of translations from fedora weblate=
 and I'll prepare pre-release list of highlights for this release.
>
> I'd like to start with rc1 during next week and then do rc releases every=
 other week (14 days)
>
>
> Please let me know if there's any objection or if you think that we shoul=
d wait for somethig or if you want to have seomthing in release notes.
>
>
> Thanks,
>
> Petr
>
>
>
>
>
>
