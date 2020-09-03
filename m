Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E4C433E9
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 18:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9753820639
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 18:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqevqgiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgICSPd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgICSPc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 14:15:32 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45634C061244
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 11:15:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a65so3563879otc.8
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Up4WC3WdSU8gb5cbZFe+1ZaHBxaK3l8zCwDtKyCJSrA=;
        b=dqevqgiY7Z4cTfR//BvlunfLZ1YivDg64GGXMkGEy7T7BGR5I3ptdobuMuKr4mARpr
         F6fdH4BEguLbDw/K4nxsB6zf5ZG6VLXHj7+uzIsX1YyqMWJUto3RTIvn6h+fEWFuxGzE
         yS03/sSCFsx2ofXP6nPJOm6Rh9QTjiffNE32o3x4SWK8QN1Rbqoh7tqxQotGKHWm/D7x
         zu8ml7qFLn3Ez8+/S4SSdMOC27qnwaubCPP8ZInJhCD98SxhdksvjnPmGR0D+97/6uaS
         3ixNJfJgrzGqfnmjBQ7xJles/8oINN5BFX8so/zpy4cTeVLS4GTODO/DxQp1LJYwhCHu
         dgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Up4WC3WdSU8gb5cbZFe+1ZaHBxaK3l8zCwDtKyCJSrA=;
        b=jFpjIQSlIOfIdAW4xz7UuLroCvaWdpsC+9kUz8JIxYgWLlY3ZBVrlupg3rMetmyPwe
         LikS5bIl3CrIfXFoBB9SN7s9bs2zE2nynRxtUQYmB7UCUOCQiBQBujJSnY6K6+rrA7Wp
         DQjGmaKxZRhnlFt9vfaZrb3SzCfva7DveZwkvL8gendJuoNckIld6Zw3dFY4LU1kOQZb
         6oUpKqjo7eXms1EmTtjf4tmtSBjFrGM+BexH90fnXNSMffqTqwGjfs6iZu5HEdATgqCN
         e51d/lburEaJOoFK3WkxOijVV32ScHAhSaKKQAZA2vn8A/DlTnHan3JqZ40V89TEO+pu
         m7Rw==
X-Gm-Message-State: AOAM5311mzQpiHInrtFjmgGW4kKmtz5z0Ds0qlnficcLBx0wfNK0AI4C
        2Rf43CI6aZElODFiHQuwrxXPXqWpS4jHLcFBVJs=
X-Google-Smtp-Source: ABdhPJzNKujINH9InXZMYSjObO0qk8mqEAeXhtg1uNKfwXXnqc5cOeAqBKhHv7b5KjG2wuRsUQ5RN/H44OL5gnYN7ts=
X-Received: by 2002:a9d:c64:: with SMTP id 91mr2443576otr.59.1599156927468;
 Thu, 03 Sep 2020 11:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <12fc8da1-4fbd-59f7-08e7-0af9daff118c@gmail.com> <CAP+JOzSHRcBQp_3ntqiKiG_fjx0fab6zGCC8F6j50zkB8ac-Bw@mail.gmail.com>
In-Reply-To: <CAP+JOzSHRcBQp_3ntqiKiG_fjx0fab6zGCC8F6j50zkB8ac-Bw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Sep 2020 14:15:16 -0400
Message-ID: <CAP+JOzQ81pinste0dpC1n93GVzrQNOds+YCEVpqsrJpamPg_mA@mail.gmail.com>
Subject: Re: Invalid output by secilc with constraints containing 4 nested OR
 and a single AND
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 29, 2020 at 5:02 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jul 29, 2020 at 3:06 PM bauen1 <j2468h@googlemail.com> wrote:
> >
> > Hello,
> > I've discovered that a constraint like
> >
> > (constrain (file (open))
> >   (or
> >     (eq t1 exec_t) ; probably doesn't matter
> >     (or
> >       (eq t1 exec_t) ; probably doesn't matter
> >       (or
> >         (eq t1 exec_t) ; probably doesn't matter
> >         (or
> >           ; Making and the first argument to or will produce a valid policy
> >           (eq t1 exec_t)
> >           (and
> >             ; content probably doesn't matter
> >             (eq t1 exec_t)
> >             (eq t1 exec_t)
> >           )
> >         )
> >       )
> >     )
> >   )
> > )
> >
> > allows secilc to finish compilation but generates a policy that is "invalid", file identifies it as an SELinux Binary Policy but seinfo and similiar tools refuse to operate on it.
> >
>
> I can confirm that this does cause secilc to create an invalid policy binary.
>
> I will have to investigate.

So the problem is that this constraint expression exceeds the depth
allowed by libsepol. An error should be given by CIL when the depth
reaches 5, but CIL was not correctly keeping track of the depth. A
patch will be sent shortly.

Thanks for reporting this.
Jim

> Thanks,
> Jim
>
> > For example (using secilc/test/policy.cil):
> > $ file policy.32
> > policy.32: SE Linux policy v32 8 symbols 9 ocons
> > $ seinfo policy.32 -x --constrain
> > Invalid policy: policy.32. A binary policy must be specified. (use e.g. policy.32 or sepolicy) Source policies are not supported.
> >
> > I've tested this with secilc 3.1-1 (debian) and from the current git master (9e2b8c61bfd275d0f007a736721c557755edf4a0)
> >
> > I hope that this is enough information to reproduce the issue.
> >
> > --
> > bauen1
> > https://dn42.bauen1.xyz/
