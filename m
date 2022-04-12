Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F5C433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Apr 2022 18:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiDLSKP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351068AbiDLSKP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Apr 2022 14:10:15 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C535A0A6
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:07:54 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so13885106otj.10
        for <selinux@vger.kernel.org>; Tue, 12 Apr 2022 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E3o+FwDiR7aS7ptFRfCyIqOE0pU3Bh0pYXR9douOlLI=;
        b=gk4j4fawaFuec6dYh9ElGtBwQoR1DV06+m9TrZ53ctc6TOx2s5mdKxP8aZ9yAYYWNz
         4ZAXJUXd9Yl55m8+Pr6fQbqzW92P6ZBinV67Yprb2V8i7v2yoouUVGwzsMtquG9GuBTt
         Cs16oB5cPrW36DmpibxU6zJJoDs3co7auVigy0VGPZz6H5E339UdSCHj0q/IHRZS4M8a
         BeGi83RarJo6s/zE2+GhkVGyglOI9ttSIhW/cY6KpLpTY1k0ZLplntya/QCxIZbUso8R
         I1sKoUJPRCMMqmq9d9VQinHsAPGxuUB6uux1PlP70+jkHW4+qNbztx/fb74j+L1WHrE+
         uDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E3o+FwDiR7aS7ptFRfCyIqOE0pU3Bh0pYXR9douOlLI=;
        b=SvDX3dD+tJaMfdcv3e5cz8Ax24ln8yS6Pnw17snNTCJiYi40JyIKyyvlzMBrYfLOja
         ybh/JKjAdND0JKG0ZfrERz9PJailQJTgS6f3RFzE+1K+c3g4JMgXgfBnu/Bx0tt9okOY
         mfm7OorrWlW7jS0N850G8SOz3diTZiUYwB5LKElcu97AsY0F22siXQFJKYKeEkBlxsJ9
         P5roUafvglQpF48RmnU98mwyM6Sma1IptqH4faRoN1BuPJoNfhCFZevh4B9QZBO2Jgd9
         xeED9aTdAbgDQ2HAjGN9BRpjchcFgx8a2x8qsHnmlXyWOGIpXYfx10cvYB3GtsOmBTv1
         uthQ==
X-Gm-Message-State: AOAM531UrgcWFSJg8GcesueiQOTb3+Xrms5P98HK74jiJXjEIMAoc1ID
        0WfEwRpSfyWbMCbv4o1Yx5CsSFsWEon1eVOerUgAZcnU
X-Google-Smtp-Source: ABdhPJxm8VvJJUzmhrWSgrcntfa1MDsw/lxXNHiklCOskowy8lET1Sp17hrkY9hOJ3AT1bTYNjUVmfEvhDr2TwGV2dU=
X-Received: by 2002:a9d:7842:0:b0:5b2:4dee:79c2 with SMTP id
 c2-20020a9d7842000000b005b24dee79c2mr13547914otm.53.1649786874067; Tue, 12
 Apr 2022 11:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220204133507.26977-1-cgzones@googlemail.com>
 <20220222135435.31216-1-cgzones@googlemail.com> <CAP+JOzQrheKCHkqWtx8n_rJe2ziK7rKD-G5EGO4n5iEqO=jHOw@mail.gmail.com>
In-Reply-To: <CAP+JOzQrheKCHkqWtx8n_rJe2ziK7rKD-G5EGO4n5iEqO=jHOw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Apr 2022 14:07:43 -0400
Message-ID: <CAP+JOzR_EqZODh6faY=zh=cpn4PK6JyDoKo4mbKFbT6h0hFucQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] libsepol: add sepol_av_perm_to_string
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 7, 2022 at 10:54 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Feb 22, 2022 at 9:05 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add a wrapper around the utility function sepol_av_to_string() on the
> > service internal policy.  This allows callers to convert a permission
> > bit set into a string representation without access to the internal
> > policy structure.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> After thinking about it, I am ok with this series. All of the
> functions that are being exported are used by checkpolicy or audit2why
> and are from services.c.
>
> So for these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/include/sepol/policydb/services.h | 9 +++++++++
> >  libsepol/src/services.c                    | 6 ++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/incl=
ude/sepol/policydb/services.h
> > index 048f8a5a..44de3863 100644
> > --- a/libsepol/include/sepol/policydb/services.h
> > +++ b/libsepol/include/sepol/policydb/services.h
> > @@ -103,6 +103,15 @@ extern int sepol_string_to_av_perm(sepol_security_=
class_t tclass,
> >                                         const char *perm_name,
> >                                         sepol_access_vector_t *av);
> >
> > +/*
> > + * Return a string representation of the permission av bit associated =
with
> > + * tclass.
> > + * Returns a pointer to an internal buffer, overridden by the next cal=
l to
> > + * this function or sepol_av_to_string().
> > + */
> > + extern const char *sepol_av_perm_to_string(sepol_security_class_t tcl=
ass,
> > +                                       sepol_access_vector_t av);
> > +
> >  /*
> >   * Compute a SID to use for labeling a new object in the
> >   * class `tclass' based on a SID pair.
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index 7becfd1b..b2fb804e 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -1233,6 +1233,12 @@ out:
> >         return STATUS_ERR;
> >  }
> >
> > + const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
> > +                                       sepol_access_vector_t av)
> > +{
> > +       return sepol_av_to_string(policydb, tclass, av);
> > +}
> > +
> >  /*
> >   * Write the security context string representation of
> >   * the context associated with `sid' into a dynamically
> > --
> > 2.35.1
> >
