Return-Path: <SRS0=0U01=5I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D6C3F2CD
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 15:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C215D20409
	for <selinux@archiver.kernel.org>; Mon, 23 Mar 2020 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaQk0QeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCWPfp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:35:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37762 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCWPfp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Mar 2020 11:35:45 -0400
Received: by mail-io1-f66.google.com with SMTP id q9so14591909iod.4
        for <selinux@vger.kernel.org>; Mon, 23 Mar 2020 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJm5QvJRI/LXqt+oprFqO371ZA0WUhxKq92DJc28RG4=;
        b=VaQk0QeUamYmTnqSIETeLhtaycA/0RBhHped2oEPZxstjRlntc+bZKtUciu6ZzcgF/
         4KpA+hLdYS66kBVJPEOnYUF+d2DGwElVE5Zgu1VPTUSNqy1LOjQ7PGqq5JICssL5LUfN
         R5OgDedctW+fqWnObSAn16x6722T01zeieDePYxQrZ/xF2UDoU9NbJbiLZrqWXzh9CYn
         KES+cCSU36gINhQOavp/E3BplVP8h1IzNytZEemGoMEedDq9krGkzo3S2ZC03j74TfKL
         ZngLsIORHwHfyPVc1mA4UMamMreYq6koXUhbwZD+NMoB7U36DmHeF46dej1WihOgz3KH
         GIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJm5QvJRI/LXqt+oprFqO371ZA0WUhxKq92DJc28RG4=;
        b=OmrQEdaVyYWpEFwnnbqsx4iQphQfJtStnFfSxxGky5ZwbChqPRPvz4mvU5fjKOpXWZ
         zNk+uDuPdMhpV8b1p2B61w8A528mrz4eA21yIBSEXiNjp8mniUFvt6LYHEqraE5ocLJ4
         RKfs6haa1xcfkru+g3sZEZ2Wz3HC0y7xa08tDBq14xcRjez1E5W6aDcOxDBY1bZKuRJd
         RVoLvVVMDJTPXxLxko413vJJB9c7y73XTXL4OTd9EsUOm1/Q2KZJNCVVtmwqmRZlPgeV
         bWHGgqnKaqDirzcvEOsCVib75biNWgQwq/ipLjexno5egpDnqfCoSvcustGM/oOps21B
         MQ3Q==
X-Gm-Message-State: ANhLgQ0up+fRS7pzMaaEDYTAWt5EfdoQTneWrfKfNmHudugBCmCfOZO+
        YkzPDSnXZkF3WBTQUKQ+r47YNvosY2WjlPl21jg=
X-Google-Smtp-Source: ADFU+vvPBs/PgS8JxupAQ7yfxrePtlGUtsT/ymnSccPmFLgiacU7pGvnHqCFVJAAV57PQ5nU8kNiP0mZuJxDYQHpRPs=
X-Received: by 2002:a6b:8d50:: with SMTP id p77mr20009907iod.143.1584977742790;
 Mon, 23 Mar 2020 08:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
 <20200319194853.15709-1-william.c.roberts@intel.com> <CAFqZXNtZLpdtreN1D5=FU+L8Rm10OpUu=jD4nzEqor7g50f3qw@mail.gmail.com>
In-Reply-To: <CAFqZXNtZLpdtreN1D5=FU+L8Rm10OpUu=jD4nzEqor7g50f3qw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 23 Mar 2020 10:35:31 -0500
Message-ID: <CAFftDdoizXnNMOsyPdSeU15VmOgjpeAEU80DLLGSLzgyUC5gpQ@mail.gmail.com>
Subject: Re: [PATCH] cil: drop remaining dso.h include
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 20, 2020 at 3:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Mar 19, 2020 at 8:49 PM <bill.c.roberts@gmail.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libsepol/cil/src/cil.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index c010ca2aeaf4..12cc28eff389 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -50,7 +50,6 @@
> >  #include "cil_binary.h"
> >  #include "cil_policy.h"
> >  #include "cil_strpool.h"
> > -#include "dso.h"
> >
> >  #ifndef DISABLE_SYMVER
> >  asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
> > --
> > 2.17.1
> >
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
Merged: https://github.com/SELinuxProject/selinux/pull/210

Thanks
