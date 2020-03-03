Return-Path: <SRS0=zB1t=4U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B6CC3F2D1
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 18:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8383D20842
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 18:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti/mj37o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgCCS5F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:57:05 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35262 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgCCS5E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Mar 2020 13:57:04 -0500
Received: by mail-ot1-f44.google.com with SMTP id v10so4144666otp.2
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2020 10:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhYH2TNsDo2hRzFIc+Qbsi0Tmug2AaniGWh1Jx0sQRk=;
        b=ti/mj37oScvcracsqzRP5HzLKwB+cnMnIJydt+Y/idkYlsQPTOToqxbCiLax1raWpM
         ZhEPzxNfDfD04mBf6JZ5cAbFWINGJr/3L+baL7w2OHVD5Udei7CrOtPRzOWOS6dltyCr
         0s2+GTwfpdJpBFuSwikrq0U9BvNgTuN/O+STl64y3yVY24ZLosnpA9Gci8ZbCEqRmuzS
         P4UjsdpPkfBDWXdo8bt83mEg/OtCAjdg2zZ4hwidYuxwciwlti1HFBLH0xhmChitEmUM
         HMayh3U0vfVGLXL5Tb2Qz+02uq2TD/gdyHZPvGRRn58ij8eTeFjKxp9YmCE1Aiw/DNIS
         hmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhYH2TNsDo2hRzFIc+Qbsi0Tmug2AaniGWh1Jx0sQRk=;
        b=szmiX81kZvfaxc2ArX/xuK4WfHG3Jrunsxk85FV4teI/9wLPphCjzvykEL5lOWmdTm
         pSYzjy0ZOGGtp0EXhoCdLS4m3SsAWJFcafZS8sZ923+fJCXfOCNe2RKV/YRT63W1KI+z
         VuGAoByGiibqVCWkZyhXHe3Fou2IlLjwihpgpN2DLIJPKaQel6G0r4MeaU6MjK09LOBh
         fltpDRhWjkprdXaBjoTJKTjKxM/G+OpxdxTc5H3emuLw+qY5WANgaYgg8FVGFryJ8G6r
         MiFUYSGpwHisV425V8v7avLAdsGn41wgCevlD+YuSmXggCtTibYwwcgvFpnb0Fa0snYz
         9/xQ==
X-Gm-Message-State: ANhLgQ2iJ566psgtD1vofv5HGN/26cDwQ5Oax1U75iIz6FhUYnN1rQXW
        t4H/20WQebfLr7Q4PhMgKVYID+oI0GOLUV2kwiA=
X-Google-Smtp-Source: ADFU+vtv5p3wOF7sKyHlnqRdRZz10a7XNp6zReR5mOWCvzHyaTV2pM9EepM4YfQ5AZA7JaOmEAJPOT2976l9RMS1hrQ=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr4580817otl.162.1583261823921;
 Tue, 03 Mar 2020 10:57:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7==wU4R7VG3=gKpEoWKFKpP6tHiwN-0_O89-vp0w-ByPRw@mail.gmail.com>
 <20200302164112.10669-1-william.c.roberts@intel.com>
In-Reply-To: <20200302164112.10669-1-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 3 Mar 2020 13:58:59 -0500
Message-ID: <CAEjxPJ4sURPgJuTzGX_MBu-nThwn9NCWDKj0z39Pum8Mhh3axg@mail.gmail.com>
Subject: Re: [V4] libselinux: drop dso.h
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 11:41 AM <bill.c.roberts@gmail.com> wrote:
>
> Version 4:
>   - Fix linker option warnings.
>   - Move map file to begining of options.
>
> Version 3:
>   - Add more symbols that should be dropped from the dso:
>     - map_class;
>     - map_decision;
>     - map_perm;
>
> Version 2:
>   - adds a version to the linker script LIBSELINUX_1.0
>   - Adds a patch to drop some additional symbols from the dso:
>     - dir_xattr_list
>     - myprintf_compat
>     - unmap_class
>     - unmap_perm
>
> This four part patch series drops the dso.h and hidden_*
> macros.
>
> The old dso.h functionality provided libselinux with both control over
> external exported symbols as well as ensuring internal callers call into
> libselinux and not a symbol with the same name loaded by the linker
> earlier in the library list.
>
> The functionality is replaced by a linker script that requires public
> API to explicitly be opt-in. The old method required that internal API
> be explicitly annotated, and everything else is public. This should help
> make it easier to control libselinux DSO hygene going forward.
>
> The second functionality is replaced by compiler option
> -fno-semantic-interposition
>
> Note that clang has this enabled by default, and thus doesn't need it.
>
> See:
>   - https://stackoverflow.com/questions/35745543/new-option-in-gcc-5-3-fno-semantic-interposition
>
> [PATCH v4 1/4] dso: drop hidden_proto and hidden_def
> [PATCH v4 2/4] Makefile: add -fno-semantic-interposition
> [PATCH v4 3/4] Makefile: add linker script to minimize exports
> [PATCH v4 4/4] libselinux: drop symbols from map

This looks fine to me but I'd like at least one of the distro
maintainers to ack it (especially the last one).
