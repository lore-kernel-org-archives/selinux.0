Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0125C433EF
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbiEPRJX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiEPRJW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:09:22 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289622B24C
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:09:20 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-edeb6c3642so20994645fac.3
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lpm2c1AsD6vUi3R23wfrZfUR/yMgrDkRCrIkIp+GZAc=;
        b=TuXOR3H/HyRPxB1bBlxNgXEdweVILO9KcUHkA1Qm1U2R1YqYo0JYCaYfrmD9gzrVM9
         Mebw8+A02gSmDebNIlIiqQ6A3DQmLzil88c2EkmY3vMzwfBKnyRXDsO9Sif2sJk4Fn8a
         v7E2+lFHXw2k1gFRr1chwG2TSz3LtiCH341S5q/Bhr3LDVrn8EbZBtTPEZwQFaNMwZUa
         QnJLzn/vQpyte0wQFtsd1EYtPKDWZHBES+og2ndgBMdzz8dwVthDafNSzZu3pfXoU4v3
         VTUU8S0qK9cquFrNdKjzSKozZoZ9SIFps6XFxfjn+pDrFaCHneCRkK312YxKHhjM0wf6
         oW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lpm2c1AsD6vUi3R23wfrZfUR/yMgrDkRCrIkIp+GZAc=;
        b=G21xui/NXUgW7ndVXgqXy7ykFf0vJGGDgMvVANb89jzFBroqiJUNCeHjd92iEFFfCq
         a4nnPygJJnj6tRbzNABvNoLJ9i5gjXkl9fHwS4yUXGCNmNrFLZQ6nsLrCMuCtw+oAdvi
         L8cet8n83g+yZw9rJnKFBQwDsivaAgqkqOLLsUciWhCl67TWqEKaxeHExSshEeRzInek
         7hY3ao0d8h25ZQ96TgxXPbag75I81l5awPWuru/RdwRJlRfr5ypjDIEIUOuLO6D1jc3G
         3Lmtyw7pq6VxntfZFp+vpaLqMw29HRqj9mb2zICuFMV+sdWDJyHaiP1X2sNtv+98Nr4K
         3chw==
X-Gm-Message-State: AOAM533AmAwSV0NgcKqP5VHHH6djtVtyNlPOOYUjZ7w+gl+4/G20Jwte
        rXllwpdhUvXjx+//MEWq3CI0+3Xfv0gGJNleDlc=
X-Google-Smtp-Source: ABdhPJyyqYouyUZCQMMH1X3rvRhbX2XeFoUZiboPAnc0kkAxjbtu85feJ+/oGx03GYJ8xh0vjTGU0DPFlkJE4XPL5o8=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr15732446oap.156.1652720959562; Mon, 16
 May 2022 10:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220513095628.154274-1-omosnace@redhat.com> <CAP+JOzSCWVAqfurogeSRV9G7Jc21pY2_co7csEcNU1_=bGzPFA@mail.gmail.com>
In-Reply-To: <CAP+JOzSCWVAqfurogeSRV9G7Jc21pY2_co7csEcNU1_=bGzPFA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:09:08 -0400
Message-ID: <CAP+JOzT=nbGgkB7wrJSBOccYMtFrZTsNGKDKNO=YGwXm0ZN_qA@mail.gmail.com>
Subject: Re: [PATCH userspace v4 0/2] Support the 'self' keyword in type transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 13, 2022 at 12:39 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, May 13, 2022 at 5:56 AM Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
> >
> > With the addition of the anon_inode class in the kernel, 'self'
> > transition rules became useful, but haven't been implemented.
> >
> > This series implements the self keyword support in the CIL & TE
> > languages and the module policydb format. The kernel policydb format
> > doesn't need any changes, as type transitions are always expanded in th=
e
> > kernel policydb. Since type_change and type_member rules are handled by
> > the same common code, these are extended with self keyword support as
> > well.
> >
> > The patches have been tested using the following WIP beakerlib/tmt test=
:
> > https://src.fedoraproject.org/fork/omos/tests/selinux/blob/self-in-tt/f=
/libsepol/self-keyword-in-type-rules
> >
> > Changes in v4:
> > - fix module_to_cil.c behavior for rules with the including self + othe=
r
> >   types/attributes (James Carter)
> > - update the test to verify the above + also type_change and type_membe=
r
> >
> > Changes in v3:
> > - update commit messages and cover letter to state that other type rule=
s
> >   also gain self keyword support with these patches (James Carter)
> > - error out in case a policy module containing the newly supported rule=
s
> >   is downgraded to an earlier module policy version (James Carter)
> >
> > Changes in v2:
> > - validate the flags member of filename_trans_rule_t in
> >   policy_validate.c (Christian G=C3=B6ttsche)
> > - add missing error check in filename_trans_rule_write()
> >   (Christian G=C3=B6ttsche)
> >
> > Ondrej Mosnacek (2):
> >   libsepol/cil: add support for self keyword in type transitions
> >   libsepol,checkpolicy: add support for self keyword in type transition=
s
> >
> >  checkpolicy/policy_define.c                |  42 +++++-
> >  libsepol/cil/src/cil_binary.c              | 168 +++++++++++++++------
> >  libsepol/cil/src/cil_resolve_ast.c         |  25 ++-
> >  libsepol/include/sepol/policydb/policydb.h |   4 +-
> >  libsepol/src/expand.c                      |  69 ++++++---
> >  libsepol/src/link.c                        |   1 +
> >  libsepol/src/module_to_cil.c               |   7 +
> >  libsepol/src/policydb.c                    |  33 +++-
> >  libsepol/src/policydb_validate.c           |   4 +
> >  libsepol/src/write.c                       |  32 +++-
> >  secilc/test/policy.cil                     |   7 +
> >  11 files changed, 302 insertions(+), 90 deletions(-)
> >
> > --
> > 2.36.1
> >
>
> For the series:
> Acked-by: James Carter <jwcart2@gmail.com>

This series has been merged.
Thanks,
Jim
