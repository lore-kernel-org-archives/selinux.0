Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C69C43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC692074D
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhdwkH61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgCZQtL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:49:11 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43519 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZQtL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 12:49:11 -0400
Received: by mail-ot1-f44.google.com with SMTP id a6so6509496otb.10
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OqKRn46bX+412dzFONjcakrLEdQ/9tJIw2Ax1RHxTwQ=;
        b=mhdwkH61KvTMQHwwGQt9G7M7YLSa2PgHgshlVK0ntiCi34YVx1fmGzE076JUn1OXP3
         J2WIpf8Lo9dtZHFxN3PKUuD8ZW3SeTf3jUYo8aYRWGSrbDxIGj97FCdiqzv13ZZ7U/1R
         Vj1/sy/L3YeUCk500z4SMv7/tj2EFX10ylvWAy4G3elHaNUKsskzxdNfJZiPvzt8BCu2
         RNhfk3fKKf8qvcSck4LES2/m1e+bhtZhcJ53XoHRokEVcG4DlI9FunIKD5Uz7OQt5Q5r
         PwxxdwSODeA3FHs3rD3S/iJhAw2z9lUVCfzoJ1gyQc8rCigtxp6/oUv2DaDL0cZbgX/U
         /49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OqKRn46bX+412dzFONjcakrLEdQ/9tJIw2Ax1RHxTwQ=;
        b=INUx8taTcCTdmECV5p7otZOIfPqK5oh96tTBpPudpYqasIB3uxrRSqGMiPEeslkdXs
         tfGge5ShA+aizxJ8STDP/nxQHhIWtxHlEViDyyg2WkxLATycWmm5gJfEHwGbbhDopr9M
         H41a3TCQEavUoSL3JPCm7iYKElO4YfMEVre35k3vfBqv85Cs0K/Vghxjmk6PN3YhIcdp
         98mhEGYIwVQqk9ReyIHO1zWJctFgcUnlD8zZD7lDKnTuoBxYDEYVFVSMAhMBy8DhZkmY
         XIVvMovJRpL/devGYki0n28ykXOO/UEShLFSZuVfONq0ofkjt+abTfp2PvAhH7uSPfUt
         k4ww==
X-Gm-Message-State: ANhLgQ1/Cym8kKL4UeyGAoFkqAB0wc5jmPRKBOiOj8K3BEa5C0Uvlw5A
        /KigP/jQDnxLgyMuDLDIMWbbohLmTCHgWUTA3AA=
X-Google-Smtp-Source: ADFU+vstgyRqkvyphBPe/FMCobBoAhrcgcX7p0EDo76BwUXI3cjiRhi+qVzOOyoMQCWhZ/Sv9SG0M+NEFtAFTOLa7j0=
X-Received: by 2002:a05:6830:1dfb:: with SMTP id b27mr29973otj.89.1585241349975;
 Thu, 26 Mar 2020 09:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
 <20200319194853.15709-1-william.c.roberts@intel.com> <CAFqZXNtZLpdtreN1D5=FU+L8Rm10OpUu=jD4nzEqor7g50f3qw@mail.gmail.com>
 <CAFftDdoizXnNMOsyPdSeU15VmOgjpeAEU80DLLGSLzgyUC5gpQ@mail.gmail.com> <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
In-Reply-To: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 26 Mar 2020 12:50:12 -0400
Message-ID: <CAEjxPJ4R_oxqTkVFcHRyWVC3_Sn9zVuPZbvJbcW1iuf7uskkqw@mail.gmail.com>
Subject: Re: [PATCH] cil: drop remaining dso.h include
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 11:17 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> It looks like this change broke building on MacOS:
>
> <inline asm>:1:1: error: unknown directive
> .symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0
> ^
>
> (on all of them).
>
> Previously dso.h defined DISABLE_SYMVER for Android and Apple, is
> support for those intended to go away?

Maybe we should add an osx build to our .travis.yml file and just test
building libsepol/checkpolicy/secilc?
