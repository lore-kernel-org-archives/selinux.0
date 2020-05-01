Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F39C4724C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 15:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4B1216FD
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 15:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNYIoxD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgEAPs5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbgEAPs5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 11:48:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187CC061A0C
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 08:48:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r2so4809689ilo.6
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AuIO1vrRra0tinGjHyOWtikRHaQFRlZnYUn1iA2M4yU=;
        b=tNYIoxD7hZ2n9aC4W6H90bA6if2SXC2rTZWhDfPmKRtZCKDsOA+1HEMuFrpiLkdfp+
         H212oV/UEgJPlIWiW38X0NK3046wAjjUHEkY++5BRxQ4DDfdZe5xmBRvVvkdIRtdzZUw
         DPh2u5lwV5NzTZ9GIBmkZ5CcoHSKnKpGZ8UUebJOp3AbRZusSI4ZxDmNa6zS9oaha8HV
         oN2X9XvhNJrXfgr1cTK9jTLkho0vUMtb6SJrWDkwpSPlWtDQHutFHC+FFISzLJ1Gwjr8
         Q7uQqNyKIzcMn1GrkWW0mvtEKiXyYi4Tb0dLsciePh69KsC/fFuqOMS1axRjuuzQ1K7N
         UJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AuIO1vrRra0tinGjHyOWtikRHaQFRlZnYUn1iA2M4yU=;
        b=kP5mz1opQfdyKP+HUHhRS+6T2Qugfv8VnA71f2d4Qtf8GHM9zLtgjWTo1LIeOQu/U6
         +Qjxu00jEC5fjPRaZOqcYzXscd97kind0bPwRq3BgqyjTtU3VPmhcXewpGTJdnYcMcCT
         v3wZjRsOxltAWF+LUrH84QpPxAevkzAvWDxAL5BI2AVweWGtEyiA/coyAJR5btFB5ARj
         QAzhBHRC2i1a4IPWYbEWMRsYaVO1wZCKoRPQCLMLpU0n01qVQJKHzSuUd/pW46ONgCpF
         sAKXIy17zC0IbNO6PnIBHPzs4//wc992eHo+cbA/egUUBmVSG8ll7T4liawSjUDmh37f
         tTBw==
X-Gm-Message-State: AGi0PuYbxeCuATEnEQS2D4lAvL3Qsftp3hKLachkUIGh3aUxc2zj3jTN
        tVhE3cm9967DGIjqqVfpNwSRErbCjvkZhf5HCbk699/zM44=
X-Google-Smtp-Source: APiQypJy8paj63U7qnEO9LEUci42vZrRPqHFxExYywY5ztMg+7w1K05kb6eikaoTX9wiTGQYIah3+dgXRttdLlv2ZKo=
X-Received: by 2002:a92:c9c8:: with SMTP id k8mr4262110ilq.141.1588348135794;
 Fri, 01 May 2020 08:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200420114650.19093-1-cgzones@googlemail.com>
 <20200430150318.6406-1-cgzones@googlemail.com> <476DC76E7D1DF2438D32BFADF679FC5649ED8BA3@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649ED8BA3@ORSMSX101.amr.corp.intel.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 1 May 2020 10:48:44 -0500
Message-ID: <CAFftDdr-nL4ydpHQ=8jufrP4CXwCUMSvdkM54Y1v2Y9xMJwwgw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: mark security_context_t typedef as deprecated
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> > -----Original Message-----
> > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.o=
rg]
> > On Behalf Of Christian G=C3=B6ttsche
> > Sent: Thursday, April 30, 2020 10:03 AM
> > To: selinux@vger.kernel.org
> > Subject: [PATCH v2] libselinux: mark security_context_t typedef as depr=
ecated
> >
> > Follow-up of: 9eb9c9327563014ad6a807814e7975424642d5b9 ("Get rid of
> > security_context_t and fix const declarations.")
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2: use the common deprecation style
> >
> >  libselinux/include/selinux/selinux.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/include/selinux/selinux.h
> > b/libselinux/include/selinux/selinux.h
> > index aaf28ffd..c22834e5 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -14,7 +14,11 @@ extern int is_selinux_enabled(void);  extern int
> > is_selinux_mls_enabled(void);
> >
> >  /* No longer used; here for compatibility with legacy callers. */ -typ=
edef char
> > *security_context_t;
> > +typedef char *security_context_t
> > +#ifdef __GNUC__
> > +__attribute__ ((deprecated))
> > +#endif
> > +;
> >
> >  /* Free the memory allocated for a context by any of the below get* ca=
lls. */
> > extern void freecon(char * con);
> > --
> > 2.26.2
>
> Acked-by: William Roberts <william.c.roberts@intel.com>

Merged:
https://github.com/SELinuxProject/selinux/pull/233

Thanks
