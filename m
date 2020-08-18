Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C761C433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 12:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C0320706
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 12:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiBlNRbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRMOF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgHRMOE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Aug 2020 08:14:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D8C061389;
        Tue, 18 Aug 2020 05:14:04 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t7so16086729otp.0;
        Tue, 18 Aug 2020 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZLZsGwOqStOAc9UT8FnnDHlpy2hAXWka2kZ2YYDGBlk=;
        b=oiBlNRbK57yHRqnpn43uvu7E8Mbnk5pt39udjQjm/kND3+la42YY+8bkFeOF1Zbm35
         +vT+skBjb/iJ6wAtITvzbGvTmVBpvfdf5PhQ5b8RSGJj0nd/5JyevjaI6pPpK7F/fpgi
         cOljBBQVbJXDgvRV0XlUQ2BALS1zBx1lBhb08sorqkY22rjJFnQA/i0n6DLXHWhOAhGF
         syAzm/s8ZxJM+qJtIwGcMTTDjTJi95HT9TtbE14JJD42I4f1EdXkTXFtuzbegGd+40ge
         AuIxWOqKkUpftZoNeS6YkCakIBptW6r6DhfDaT57k19CzPnm7Dx6cgvbvcabkWhxU1g9
         Oy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZLZsGwOqStOAc9UT8FnnDHlpy2hAXWka2kZ2YYDGBlk=;
        b=nB//SronFShfmoakiqwpNW74AQ7i+x2juxr+7tYT0khXq396+Y08CrUUFweCneATIW
         4RKGJ20mPGMmGrjUFoe9IAfP+1cGlwoBobtWt0Wlmo9c38r99SnNwSMxlH+29GuUbCuT
         w89Rvqn+2ZB2GBuZcjO6CZ11xAWf1cRAHTTgSRgB8293mza5whmHsJvZmDGLefr1gi2X
         pGStVdYr/Bv36oJNzXZ+YFwndE0siJzBeq9lb+obfo+Nf4VjXp6H2oL6BBnhCs1V15KN
         EHtzGZfEqGxyHLeeSrwD1dhd+I666wXBdxm0KKzPBMra1if4YRCeaLpvof/kOPtA3eXx
         Um6g==
X-Gm-Message-State: AOAM533JCLLjY9wNmRDBxSAbmVqrP9gy9tHiB07QUjCXnkELfLsp8eKD
        EhVvWhgs+UDjL+NEpgqEvx/i45sMWR4+XgHfgn0=
X-Google-Smtp-Source: ABdhPJxlNVOi9BDD1UMHiTz172Iz+TbCUaDI3/SA1o9z3Uj7F2KtOr0Xi8xZjuf0yRgF0xpkeN7X7s3jQTkDrqlVFtM=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr14025157otr.89.1597752843678;
 Tue, 18 Aug 2020 05:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com> <20200817170729.2605279-4-tweek@google.com>
 <d8b1d7a2-2b8e-c714-77b6-d4e7f3fedf08@gmail.com> <6730ec4a-d11b-5c05-b64f-380104a86dab@sony.com>
In-Reply-To: <6730ec4a-d11b-5c05-b64f-380104a86dab@sony.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 18 Aug 2020 08:13:53 -0400
Message-ID: <CAEjxPJ7k648nQxCDzcHc0h1vEfNhAJShG5iKmD52nuO5s9phsQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 4:11 AM peter enderborg
<peter.enderborg@sony.com> wrote:
>
> On 8/17/20 10:16 PM, Stephen Smalley wrote:
> > On 8/17/20 1:07 PM, Thi=C3=A9baud Weksteen wrote:
> >
> >> From: Peter Enderborg <peter.enderborg@sony.com>
> >>
> >> In the print out add permissions, it will look like:
> >>      <...>-1042  [007] ....   201.965142: selinux_audited:
> >>      requested=3D0x4000000 denied=3D0x4000000 audited=3D0x4000000
> >>      result=3D-13
> >>      scontext=3Dsystem_u:system_r:cupsd_t:s0-s0:c0.c1023
> >>      tcontext=3Dsystem_u:object_r:bin_t:s0
> >>      tclass=3Dfile permissions=3D{ !entrypoint }
> >>
> >> This patch is adding the "permissions=3D{ !entrypoint }".
> >> The permissions preceded by "!" have been denied and the permissions
> >> without have been accepted.
> >>
> >> Note that permission filtering is done on the audited, denied or
> >> requested attributes.
> >>
> >> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> >> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >> Reviewed-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> >> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> >> ---
> >>   include/trace/events/avc.h | 11 +++++++++--
> >>   security/selinux/avc.c     | 36 ++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 45 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> >> index 7de5cc5169af..d585b68c2a50 100644
> >> --- a/security/selinux/avc.c
> >> +++ b/security/selinux/avc.c
> >> @@ -695,6 +695,7 @@ static void avc_audit_pre_callback(struct audit_bu=
ffer *ab, void *a)
> >>       audit_log_format(ab, " } for ");
> >>   }
> >>   +
> >>   /**
> >>    * avc_audit_post_callback - SELinux specific information
> >>    * will be called by generic audit code
> >
> > Also, drop the spurious whitespace change above.
> >
> >
> Is there any other things we need to fix? A part 1&2 now OK?

They looked ok to me, but Paul should review them.
