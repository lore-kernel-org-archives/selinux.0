Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9698EC31E5B
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA892187F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 16:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDHf2G//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfFSQE2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:04:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35241 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfFSQE2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 12:04:28 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so39466052ioo.2
        for <selinux@vger.kernel.org>; Wed, 19 Jun 2019 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTYdxecLIgo8tdbyhfMUHkzgYN7tnF/cmbuUZRiH0IU=;
        b=SDHf2G//qgKWQlXxKiTERkofjrPdfkDToW9FnGuxEwNnmsII6yYcjTCePIj5Z6mVaQ
         kEE38IFzQqPZiqaUU7TGEkqUctnTIL1z6dL4B1NGxq3eqr/bsjbJq62Puq0SfbhKiRnP
         UXsCGNlU7FXx4EiK5xY4P07xn3LH9ewj8BDJRlwBpEwbiaV3YBZ1Aym1RoifP+dtQzyU
         2nFVv1Ox7sqKBDhHnhswtxIwvpFmLiMHjNE6G6FA1qWNm4Bve82LHf8UeDwZoO4DNOSf
         cqDGMBA8XVQl9nMwh+zdAWIuTOYSMlDjLlTJ++BEQZfIpYfURJYzw/tSg5ubYXe4OoxI
         o95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTYdxecLIgo8tdbyhfMUHkzgYN7tnF/cmbuUZRiH0IU=;
        b=revKloJZOkpUz77KZALiy6s+61pNdPeP9vFfuD9yIYRfGWpWHmtB8hfU2Li8aG3zho
         wgc/VCmy8YUOdSNxTTtS24ujQqHPmdDXaCbKD6HrCZfZAF8WUiqcf6naHYGQvjRoPHF9
         yr13ISXO862AJtmQivslLHhIqDiI8XqeXO33AThA/W8ugYUa4xk4etRpo3PhowgzwyE3
         q3AgrwGrnUXSs043hYPJY7ETer2RZ/VgjQ3yZ28r6cFBdpnz5TplgeJIpw8SbFm89zpz
         eNu2ZWf/Vc76onMOiWZaYy/FFp4+dkNOYBdcPwzXq+cU5sFteYuoVK7To5hO6KOCdBI9
         l4Gw==
X-Gm-Message-State: APjAAAUNtqzsBkiLpkoUhr25lXDyGqKn9sLB0a+D1wD4HZsmwKQ6hSSF
        vfBjDM9Qqb1A+4Rsg7ykHxG+6oPp59H/xSkK+AEtLdy6
X-Google-Smtp-Source: APXvYqyTRnhMFvOcMVLPaLWafqR/jZLzRQVWoaU9D2CHHuzCITQrQme2+5vc0+FnokdVJGD4flq/Zp5z1N4iIWKO9cM=
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr13136266iop.293.1560960267168;
 Wed, 19 Jun 2019 09:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190617151512.2209-1-mike.palmiotto@crunchydata.com> <CAFftDdodVXDdgMyTSV5188W5HcSrJu4pvpsufQPcf5U1Bw3WJQ@mail.gmail.com>
In-Reply-To: <CAFftDdodVXDdgMyTSV5188W5HcSrJu4pvpsufQPcf5U1Bw3WJQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 19 Jun 2019 09:04:52 -0700
Message-ID: <CAFftDdpJHqUyrqW1Jju8ZeBye6bLg8GK7_SLKvu9t6vKcCqR1w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix mlsconstrain segfault
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

merged

On Mon, Jun 17, 2019 at 11:01 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> ack and staged: https://github.com/SELinuxProject/selinux/pull/164
>
> On Mon, Jun 17, 2019 at 8:16 AM <mike.palmiotto@crunchydata.com> wrote:
> >
> > From: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> >
> > Installing a cil module with invalid mlsconstrain syntax currently
> > results in a segfault. In the following module, the right-hand side of
> > the second operand of the OR is a list (mlstrustedobject):
> >
> > $ cat test.cil
> > (class test (foo) )
> > (classorder (unordered test))
> >
> > (mlsconstrain (test (foo))
> >         (or
> >                 (dom h1 h2)
> >                 (eq t2 (mlstrustedobject))
> >         )
> > )
> >
> > $ sudo semodule -i test.cil
> > zsh: segmentation fault  sudo semodule -i test.cil
> >
> > This syntax is invalid and should error accordingly, rather than
> > segfaulting. This patch provides this syntax error for the same module:
> >
> > $ sudo semodule -i test.cil
> > t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side
> > Bad expression tree for constraint
> > Bad constrain declaration at /var/lib/selinux/mls/tmp/modules/400/test/cil:4
> > semodule:  Failed!
> >
> > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> > ---
> >  libsepol/cil/src/cil_verify.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> > index 1036d73c..346fbac9 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -225,6 +225,9 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
> >                                 cil_log(CIL_ERR, "u3, r3, and t3 can only be used with mlsvalidatetrans rules\n");
> >                                 goto exit;
> >                         }
> > +               } else if (r_flavor == CIL_LIST) {
> > +                       cil_log(CIL_ERR, "t1, t2, r1, r2, u1, u2 cannot be used on the left side with a list on the right side\n");
> > +                       goto exit;
> >                 }
> >         } else {
> >                 if (r_flavor == CIL_CONS_U2) {
> > --
> > 2.21.0
> >
