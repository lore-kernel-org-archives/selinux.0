Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CE5C41513
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjHINxu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHINxr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 09:53:47 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11929268D
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 06:53:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9c0391749so110149951fa.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691589222; x=1692194022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W2oFszVRVibOiM+5bfcoEc4saydzkw1Ci0MfY3LUcs=;
        b=I9WYmb7zA/BC9yNcWdVVyKwbzdADiG48IdSK2X726WoSzK/vPRwbHZf636b3EOQ2Ma
         0Ld+eTh1xRY+ldrtMZNDrWMrN1zrGp9A8zZ12A8B0dFX32ELdCtzucMOZd04+Ka+gwhc
         oIkJ2Ase/pA91jnqC7AsQgfa/LCwnpnkJML7CkdE71bb3KKg8ByUpGhSMs+4nl9MKy4O
         KdIMzomdTFw4hIbnUKuOKWtX8M4VEIxUvXNT1/0LFB+Q1+OTin1SINCN1GiCpCsbMO7z
         FAwaKjCfyo7W/oXkOzPVJK5OH+0goNavryBYPiIDqyItl9Xt7tfqXcteldZvBrpnck6l
         Hsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589222; x=1692194022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W2oFszVRVibOiM+5bfcoEc4saydzkw1Ci0MfY3LUcs=;
        b=FH00ovRCFR6q0s77OALurflu4TFPRA2kq6vTcsvbW6KJvJDtSt5OUUk2amavi7cQoa
         jJge8gmiMg+dywmmF5q5d/X3ADsOB8VVSQaIBPiYrc313xf/pneNTQDqV8IyjdXezdp/
         onp91LY7m2fcVkqvfupYhsexyHFIFZEjYN+Ocu6R9zpgaAP6eNBeqJuFVvbzNgWXW1/I
         uqq8OWsBj9D/Q9Vi31K37WN9ky6l83zXBkULOFCx9EFFSOl3gwnnpoItP2FoouBKSBgu
         1z965E09sclWcSR4aqRpd9h/2NhoaGwQXoKhPIXOj1mxsDJQHM5GSTGVFNrHDWBpvcib
         bC8w==
X-Gm-Message-State: AOJu0Yw8Bwi0+MghZD3vUMFCfvaaKADK4N8ABd3DWwSLI7qu1RF4mHSZ
        5YsDixjS0e5DqqMLFFegz8VJvdYgd4cvs0shX0OvrcdN
X-Google-Smtp-Source: AGHT+IE4E8uTX9UVQKytkixAqwcYXmk1cHpzrM+reI3YdiStNlKLEo55Y+C+v/4ymWVs3uu6jFS+b7Ve/56UGwUhrNU=
X-Received: by 2002:a2e:870d:0:b0:2b6:cb0d:56ae with SMTP id
 m13-20020a2e870d000000b002b6cb0d56aemr1773666lji.11.1691589221856; Wed, 09
 Aug 2023 06:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230808155010.76584-2-paul@paul-moore.com> <CAFqZXNvMLBrkTy1PAUGGATq+AO_wo3tr6-7ysjLzqK1qgJ2Vfw@mail.gmail.com>
In-Reply-To: <CAFqZXNvMLBrkTy1PAUGGATq+AO_wo3tr6-7ysjLzqK1qgJ2Vfw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Aug 2023 09:53:30 -0400
Message-ID: <CAP+JOzTKCgq2MXN8oWj8dXfDLZeZpWUid4OUtxq2mgsM3iAnUg@mail.gmail.com>
Subject: Re: [PATCH] selinux: revert SECINITSID_INIT support
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 9, 2023 at 5:30=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> On Tue, Aug 8, 2023 at 6:27=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > This commit reverts 5b0eea835d4e ("selinux: introduce an initial SID
> > for early boot processes") as it was found to cause problems on
> > distros with old SELinux userspace tools/libraries, specifically
> > Ubuntu 16.04.
> >
> > Hopefully we will be able to re-add this functionality at a later
> > date, but let's revert this for now to help ensure a stable and
> > backwards compatible SELinux tree.
> >
> > Link: https://lore.kernel.org/selinux/87edkseqf8.fsf@mail.lhotse
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/hooks.c                      | 28 -------------------
> >  .../selinux/include/initial_sid_to_string.h   |  2 +-
> >  security/selinux/include/policycap.h          |  1 -
> >  security/selinux/include/policycap_names.h    |  1 -
> >  security/selinux/include/security.h           |  6 ----
> >  security/selinux/ss/policydb.c                | 27 ------------------
> >  6 files changed, 1 insertion(+), 64 deletions(-)
>
> I don't think I'm able to post a fix for this quickly enough, so:
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>

Should we revert the userspace patch as well (just the policy capability on=
e)?
Or is a fix expected soon enough to not worry about it?
Jim


> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
