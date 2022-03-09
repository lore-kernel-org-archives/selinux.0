Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA914C433F5
	for <selinux@archiver.kernel.org>; Wed,  9 Mar 2022 21:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiCIVPF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiCIVPE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Mar 2022 16:15:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D128189D
        for <selinux@vger.kernel.org>; Wed,  9 Mar 2022 13:14:04 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g20so4496351edw.6
        for <selinux@vger.kernel.org>; Wed, 09 Mar 2022 13:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f5IgrytsM1z255q0jxMkzG+bK0OqR/xpVoDKIJj7gWE=;
        b=PYjTxrITXZ0P+IIMJ2kYz5DT9QrptbeaV2LKhBofyf71eguq7QgW7V5r55c2zIOHaS
         bdQu7SYcWDdfxmOATNbUyNqofGYjskiLDE5mb5EQytDi7VaPpuH7uhahKYYeBdR6aitf
         6ar3PhX5Q/Abm/7jZDVvuhDmRGNPaSzCbQkH/Eo3n0sjMIr4A/se2Z2gwla0M9UtXZ7y
         YQ6v4zjuFxRqAqbegiErhyofxGDo0Mes3amvz6Vomx6gLQ0lSJFMWAQjL9z2wUKI9ARZ
         UypFFga/ES+fy/rSYHqYGJ/mc76WQ6B3xNGL1rgmmU55h4twBjPewdS5OoV+LHlNDugf
         ebtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f5IgrytsM1z255q0jxMkzG+bK0OqR/xpVoDKIJj7gWE=;
        b=zvULgbihZ4tvSEZ808mvHszDWWFljLhn2wkKAdXB4QINnOxrLw1NUhSvJaOTrdO1AR
         LbSevfVuKXo+nHLF2eHnbhGt0DHYfbOi+EKKZASEGJiKqOtUuu2uuHcmUpdAIMBQkBWD
         KADotpMdO5kRcCd5W/3sMdKuB7EGdzxeCZ+W9vlSahcsYeZIgQQZOwOiHUu1Irqc6nta
         pnzo6sAZ5KMvHYoNVMdow1gBKBm1nOb2pnE14OkHchSrvRN+jsDdumFitLmePj1/lBBw
         vcGOHenQ3/Qc+u3tfH+QVtbE4MQJOREh81UtCcvq1pyQm94vHejvMUEPLxH4goZs9X8d
         vnEg==
X-Gm-Message-State: AOAM531j1jJwEH4X2B/iCH6rHRNAJXfRSghUm2FTbDpQlhYQtDlLpUN9
        L78GikSzc3CIgXPnouMM6dGLnPk35IVKBEttaRNy
X-Google-Smtp-Source: ABdhPJz4X98bQukjGwDFGAtygl26ij7BEag5McvZShhItQgyA0woPa848QS4nTdGZ1blYK7nPYrORSPSOQ3IdP7Aeno=
X-Received: by 2002:aa7:d494:0:b0:415:a309:7815 with SMTP id
 b20-20020aa7d494000000b00415a3097815mr1355507edr.340.1646860443242; Wed, 09
 Mar 2022 13:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com> <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
 <Yao51m9EXszPsxNN@redhat.com> <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com> <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
 <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com>
In-Reply-To: <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Mar 2022 16:13:52 -0500
Message-ID: <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     David Anderson <dvander@google.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 1, 2022 at 12:05 AM David Anderson <dvander@google.com> wrote:
> On Mon, Feb 28, 2022 at 5:09 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> I wanted to try and bring this thread back from the dead (?) as I
>> believe the use-case is still valid and worth supporting.  Some more
>> brief comments below ...
>>
>> On Fri, Dec 3, 2021 at 1:34 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>> > I am not sure. In the early version of patches I think argument was
>> > that do not switch to mounter's creds and use caller's creds on
>> > underlying filesystem as well. And each caller will be privileged
>> > enough to be able to perform the operation.
>
> Indeed that was the argument - though, "userxattr" eliminated the need fo=
r patches 1 & 2 completely for us, which is great. We're no longer carrying=
 those in our 5.15 tree.
>
>> Unfortunately, this idea falls apart when we attempt to use overlayfs
>> due to the clever/usual way it caches the mounting processes
>> credentials and uses that in place of the current process' credentials
>> when accessing certain parts of the underlying filesystems.  The
>> current overlayfs implementation assumes that the mounter will always
>> be more privileged than the processes accessing the filesystem, it
>> would be nice if we could build a mechanism that didn't have this
>> assumption baked into the implementation.
>>
>> This patchset may not have been The Answer, but surely there is
>> something we can do to support this use-case.
>
> Yup exactly, and we still need patches 3 & 4 to deal with this. My curren=
t plan is to try and rework our sepolicy (we have some ideas on how it coul=
d be made compatible with how overlayfs works). If that doesn't pan out we'=
ll revisit these patches and think harder about how to deal with the cohere=
ncy issues.

Can you elaborate a bit more on the coherency issues?  Is this the dir
cache issue that is alluded to in the patchset?  Anything else that
has come up on review?

Before I start looking at the dir cache in any detail, did you have
any thoughts on how to resolve the problems that have arisen?

--=20
paul-moore.com
