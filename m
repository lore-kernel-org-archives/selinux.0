Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF878C77B75
	for <selinux@archiver.kernel.org>; Sun,  7 May 2023 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjEGTyp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 May 2023 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEGTyo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 May 2023 15:54:44 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CBA11562
        for <selinux@vger.kernel.org>; Sun,  7 May 2023 12:54:43 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-55a8019379fso33411747b3.0
        for <selinux@vger.kernel.org>; Sun, 07 May 2023 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683489282; x=1686081282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbhikCr/N+ze/SXedo6WriweuMFTiLE+tzWurqBHcO0=;
        b=cL7H/EzE5QriRdZZbTPJwx9BKhzNjIvYcdFN1n7qr63MTLUnMg9qP6fpD/Dd9Fl9qM
         yJSfWcxN/zzLmH4nckYxIaoiqp+Ra6/tpIJ4io5bLk/4ZAdTKfiaPdKQXKo2Qiy/xf64
         OPMDWPosQx/6kSdTG6au/ROT1cRC/pKfSuU3VJSa66mH40Jtl+IGNtSnSoUzdgs8dYBu
         rMe9bmMiWZIFtkWb0XStkiTTvY1zqZ6fAeAZADWd4vEZJfB0Zg/xYsxon2uQl4qFtpOw
         tt7FQ8+f9mD5jgr6ZfH8NQCeW2Z1k21JGWvB5aBAVB4qDzndas1onIuC1Qx65DqBoSNn
         nNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683489282; x=1686081282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbhikCr/N+ze/SXedo6WriweuMFTiLE+tzWurqBHcO0=;
        b=JcLkI0WvC3VrswdVruSnV+ncdrMBZMyaw5GtCTuYB4Zk9z634YA0nRdVuu0bHN2JSI
         3xNkWibpoh9jl7aVLBYmYRRqIcs53Z7R78dj0/BJ0HaecOLti8OMldHtDnPtjZAhRfHv
         6PS4yeI4gHUvb5J3cn8xw0sBLHwbKyuyB8h5FmNnDdo8/AU7bzP6lluySfjf5bt/nPBo
         v/VxksEKdo1wo/TE/LiTcB6uB/NvF9vYR+QH5bkr85BfeS1T85dzCx6OObSmqVfN9Ndb
         K5OKFphTlLaRmRKhn5+nAAPGfVnB5gOLIyv89RM7h7iowrWLTiy7nIewSvjBXKsO5gDB
         Pf2A==
X-Gm-Message-State: AC+VfDwYqkXtAGTB3fBQ4jty7WZmkY1PoH6OqYTm6Bx8YedyZDFzOSxy
        vhdwR21jQYnwS4uehBYvfVkgJGCy71vizyhTrgfHcd2fmiQWIVg=
X-Google-Smtp-Source: ACHHUZ5xhvuMTXMk1TxOcWqTz32NZUA3qLmUqyIWICkgO7Spa+FkUzi905LHuXUJqasn1P9rxPzrBA6XKTWfHykq3UA=
X-Received: by 2002:a25:24cc:0:b0:b99:f09f:ec78 with SMTP id
 k195-20020a2524cc000000b00b99f09fec78mr8706007ybk.4.1683489282576; Sun, 07
 May 2023 12:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230505224934.645040-1-paul@paul-moore.com> <CAFqZXNuuH44-o0O37v8ENDi1cykv-de1KwOeYieis8DgsXXjkg@mail.gmail.com>
In-Reply-To: <CAFqZXNuuH44-o0O37v8ENDi1cykv-de1KwOeYieis8DgsXXjkg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 7 May 2023 15:54:31 -0400
Message-ID: <CAHC9VhSBZ1=exXHKO0K8sDHkNA29ZFF1Qb_4OgW+RvgZ9EhKSw@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove avc_disable() as it is no longer used
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 6, 2023 at 5:16=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
> On Sat, May 6, 2023 at 12:51=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > With the removal of the runtime disable functionality we no longer
> > have any callers of the avc_disable() function, remove it.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/avc.c         | 19 -------------------
> >  security/selinux/include/avc.h |  3 ---
> >  2 files changed, 22 deletions(-)

..

> The same patch (modulo subject & description) has already been posted
> by Christian:
> https://lore.kernel.org/selinux/20230420150503.22227-3-cgzones@googlemail=
.com/

Ah ... huh, odd.  It looks like the patchset from Christian was
incorrectly assigned (probably by me, oops) so I missed it.

Anyway, consider this patch dropped in favor of Christian's.

--=20
paul-moore.com
