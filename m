Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3557DC433EF
	for <selinux@archiver.kernel.org>; Fri,  1 Oct 2021 19:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFD061A7D
	for <selinux@archiver.kernel.org>; Fri,  1 Oct 2021 19:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhJATxL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Oct 2021 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhJATxL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Oct 2021 15:53:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A2C061775
        for <selinux@vger.kernel.org>; Fri,  1 Oct 2021 12:51:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i25so42812978lfg.6
        for <selinux@vger.kernel.org>; Fri, 01 Oct 2021 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OASN1DWXrIyD6gQMB0CvKRtBfiSz7Btq5Vz6GIW00BE=;
        b=pggztfgWW5/r760u67qMKk/gTZdTITQgtnm3gsdGguHjcPYeUrqfnJ1Ts/Q8zWqhwu
         +HBU/MNmhVO8smF7opyPX9VNyK1Fp5kiQMn7GyqBpkTvdPA0ydBPoQSBZtdYo8YURLwl
         3tGka8IMoYW/kKnrhIpQ+1XF1sCw+rvBzldSAyrs8wm/GlQyk6fd5/JFQwk3kiF81KnQ
         onxrXDIA4LOqeSja4oFc4zGKVKfBJvfADJh3c6BplTORvbepH/RZojxT33BqibLljLad
         N/H0dfwVeCeFN3AlCaOG/FyxomgOhHkI7xyAvzbNN+fSW8TAoOKjJ6zy166m0yhWGtIt
         787Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OASN1DWXrIyD6gQMB0CvKRtBfiSz7Btq5Vz6GIW00BE=;
        b=aqVZVwJbFLteCWyAlq+Bfj8toXR7H/GbDPq3MK1U12PfB4GDVIyyU6y78/MY7hX5xj
         LvNGUFU8RTsXLOMssbre54xYR0sV3tjMqHLO9ohwhywW61JrrBRsioCzLCLGnsozyicK
         F2Acb5lNzQEvDjeSjDccZN51bUpZdUFZTAVC3ArHyTabksPsMZvjDRT56K3gpkwUbAXV
         Gtf6Ps/qq4rsNKC1Q4qzKyngKdA9FEnh5SUzwRnfuDZfJ/OxpdpY9UxdMZrs2Cq5J673
         /0Md3bQOUcv8wzrhJrsLrQksGkIhJYZZzC/S+u8Mh+ecH/fkSnOhJPAtIj6DFNpUiVXj
         CQkQ==
X-Gm-Message-State: AOAM530kS8PhkFI7m7bUX3ZIxzRCmAnV1Rre3mEmeStVVOWIT2xyPwTp
        OMzN9XkmvlOo+hGqkD1OSEgaI4pbaw6Tm2L3210Y1Q==
X-Google-Smtp-Source: ABdhPJzyi89yz4Ys7YmWbiYxSX179Y8R/JtbkovCtO5Snt8v5Te8qZFir2+vrfNRPa3XFPVfkfW/5UQtafjENmEXRYo=
X-Received: by 2002:a2e:9243:: with SMTP id v3mr2195425ljg.47.1633117884418;
 Fri, 01 Oct 2021 12:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211001175521.3853257-1-tkjos@google.com> <c6a650e4-15e4-2943-f759-0e9577784c7a@schaufler-ca.com>
 <CAG48ez2tejBUXJGf0R9qpEiauL9-ABgkds6mZTQD7sZKLMdAAQ@mail.gmail.com>
In-Reply-To: <CAG48ez2tejBUXJGf0R9qpEiauL9-ABgkds6mZTQD7sZKLMdAAQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Oct 2021 21:50:58 +0200
Message-ID: <CAG48ez1SRau1Tnge5HVqxCFsNCizmnQLErqnC=eSeERv8jg-zQ@mail.gmail.com>
Subject: Re: [PATCH v2] binder: use cred instead of task for selinux checks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Todd Kjos <tkjos@google.com>, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 1, 2021 at 9:36 PM Jann Horn <jannh@google.com> wrote:
> On Fri, Oct 1, 2021 at 8:46 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 10/1/2021 10:55 AM, Todd Kjos wrote:
> > > Save the struct cred associated with a binder process
> > > at initial open to avoid potential race conditions
> > > when converting to a security ID.
> > >
> > > Since binder was integrated with selinux, it has passed
> > > 'struct task_struct' associated with the binder_proc
> > > to represent the source and target of transactions.
> > > The conversion of task to SID was then done in the hook
> > > implementations. It turns out that there are race conditions
> > > which can result in an incorrect security context being used.
> >
> > In the LSM stacking patch set I've been posting for a while
> > (on version 29 now) I use information from the task structure
> > to ensure that the security information passed via the binder
> > interface is agreeable to both sides. Passing the cred will
> > make it impossible to do this check. The task information
> > required is not appropriate to have in the cred.
>
> Why not? Why can't you put the security identity of the task into the creds?

Ah, I get it now, you're concerned about different processes wanting
to see security contexts formatted differently (e.g. printing the
SELinux label vs printing the AppArmor label), right?

But still, I don't think you can pull that information from the
receiving task. Maybe the easiest solution would be to also store that
in the creds? Or you'd have to manually grab that information when
/dev/binder is opened.
