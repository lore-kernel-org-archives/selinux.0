Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B84BC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 12:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A9C2065D
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 12:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhRHSFan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgENMDA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgENMDA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 08:03:00 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60311C061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 05:03:00 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w22so1927434otp.5
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wf3Bf3zIaw22WLjU5Nxdsqwww3msKSxV48zJ1TfThHs=;
        b=HhRHSFanE8rMPB7IQet32CGvHqcEYl6MmGPwsqvj4ewFZERLvA4V35LJf3ghRDivKN
         dL9R4G1xmK6L8LKOYkncL4evJAbxZ6jf0KeakSiIRcBcsxzg/Wjw9ypVpizuDf/cIn2P
         J0diQrLgd+6zM9eyBQJFm3eENrRLaNxrkn0T/dkfeH7AHxQtTd8LYN0lODCNfPMVUEZC
         WEMmJRL6IrM7SPgP4MdysH+7krn77oNQ/diXPxQx2DGVdeTXqWaULBvonleoWwqCr7oc
         bPo8Q2TqD1XoVxPIMV87Nm6nswdNaP1bqJ/XV8BJL/NR9OAd2Dr1cp97AUUYfyRodY9M
         Fp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wf3Bf3zIaw22WLjU5Nxdsqwww3msKSxV48zJ1TfThHs=;
        b=idYA4loKY1e2fvxIJNSMffnslnSO2pEc56AZYhDli5Pdud996FcTrpUkgPjAmUdVZt
         0zF3BI5XrF8KOzFe6Qx/ELdLGieXHopl0UL+3le+MMGpfl4RTMZoRpC2QT/449cEoOZ8
         zrOBuFop3UXAFfRHeoKS+XIBp2UhPDdSa84iCUfl6srmoQutVir4lHRcQ2OmIzxXSxSi
         WVhyJk2uo+3Xut1yyV1Y4tbfCVOgW1MG5SZOLvHoRf8c6vqwlu5i7fRAcAAijTwI6lQ/
         Y6P9j8vwGVAO6HcHr5PqgdCKQ1fzAL9QA9f4z+3F1T8g6Umnwf51F1pJMzuGw05NfgcZ
         rrdQ==
X-Gm-Message-State: AOAM5317omhf/EGrV9tQSePou2NQZ8gQCqENtBg0J/f6DVCSuqfoxf9S
        eFW2XQ/NJP6qm3H7aFT+REb+vKRaawrfV0RbcwYsBMst
X-Google-Smtp-Source: ABdhPJwvWEA7SOC26J/NnVMU5rFCLjOH7gaItY428S+WZtZkzda4OlwflS5R9iF/eB7iIM5R6FET/qyAnv+OC0Z/jTA=
X-Received: by 2002:a05:6830:186:: with SMTP id q6mr3279930ota.162.1589457778194;
 Thu, 14 May 2020 05:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200513211508.4477-1-stephen.smalley.work@gmail.com> <CAFqZXNtNSH8_8ow-ZkAMK=UXvs_rCieUr3xgn6pqrpb-Xvnbtw@mail.gmail.com>
In-Reply-To: <CAFqZXNtNSH8_8ow-ZkAMK=UXvs_rCieUr3xgn6pqrpb-Xvnbtw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 14 May 2020 08:02:47 -0400
Message-ID: <CAEjxPJ4g5+erpnA-ikj6RjZ0KL2v5jd6mENcX1Ahtk2-7=s0bw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: drop broken warning on duplicate filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 4:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, May 13, 2020 at 11:16 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > As per the issue below, libsepol segfaults on loading old kernel policies
> > that contain duplicate filename transition rules.  The segfault is due to
> > the fact that the val_to_name arrays have not yet been populated at this
> > point in the policydb_read() processing.  Since this warning apparently
> > never worked since it was first introduced, drop it and just silently
> > discard the duplicate like the kernel does.  I was not able to produce a
> > policy with such duplicates using the current policy toolchain, either
> > via CIL or via binary modules with manual semodule_link/expand.
> >
> > Fixes: https://github.com/SELinuxProject/selinux/issues/239
> > Fixes: 8fdb2255215a1f14 ("libsepol,checkpolicy: convert rangetrans and filenametrans to hashtabs")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  libsepol/src/policydb.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 5b289a52..3992ea56 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -2655,15 +2655,8 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
> >                          * Some old policies were wrongly generated with
> >                          * duplicate filename transition rules.  For backward
> >                          * compatibility, do not reject such policies, just
> > -                        * issue a warning and ignore the duplicate.
> > +                        * ignore the duplicate.
> >                          */
> > -                       WARN(fp->handle,
> > -                            "Duplicate name-based type_transition %s %s:%s \"%s\":  %s, ignoring",
> > -                            p->p_type_val_to_name[ft->stype - 1],
> > -                            p->p_type_val_to_name[ft->ttype - 1],
> > -                            p->p_class_val_to_name[ft->tclass - 1],
> > -                            ft->name,
> > -                            p->p_type_val_to_name[otype->otype - 1]);
>
> Not sure if it's the same situation, but should we also do something
> about a similar pattern in checkpolicy/policy_define.c?
>
> https://github.com/SELinuxProject/selinux/blob/63bf6afe5ed20e1d62f966de65882dc327fb2915/checkpolicy/policy_define.c#L3408

No, in that case we are compiling source policy and we want to warn on
it to encourage removal of duplicates (and we have populated the
val_to_name arrays there so the warning works).
