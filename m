Return-Path: <SRS0=Veyl=5F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E97C4332B
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7A920739
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 08:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBOFpw/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgCTIIl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:08:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23749 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgCTIIk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Mar 2020 04:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584691719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qgfu2o671JA7x2XmdogaHWG5vDZaNlX2RsMhO2xw4pY=;
        b=VBOFpw/krdc9IYoG+g/3QqA76yyS20NtWlCYGv3vDPbQS6x1uKM40fk3fvLucHz9wg9kYk
        IAIEoWdPoQESr9/fzgMqoYRgdGnJYFpwu6/EVuLUrwwTc/xDmfGMtarLIxIOLkNGhHWmoQ
        vbN0n7adH72TUHLBT7HTwTMpKeGPEmA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-MVm8asH_MmWzE1UnJfXLEA-1; Fri, 20 Mar 2020 04:08:37 -0400
X-MC-Unique: MVm8asH_MmWzE1UnJfXLEA-1
Received: by mail-oi1-f198.google.com with SMTP id i22so3455667oii.12
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2020 01:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qgfu2o671JA7x2XmdogaHWG5vDZaNlX2RsMhO2xw4pY=;
        b=cosj0tveITeuGWpQyM4M4LQSqi4CEWvhldCAgHHrBIT1wB6O73X8485M1UNtsy6aaQ
         VtlgVXGROZiGlYJacKC8Y5hSmQP5tlqrhBBt2gTNlyGDIsF+WSWmnRe0AVPIqv2pmURd
         Vrb39xVDWbMLrddZDAvEtSCak7hP6DhlsELNR6zOTO5ih5SEm5Qeh1LN0yPk4xtnShnx
         hBsdprsdGMXHGVHcdzbHxag9QoNIqsvlGxuWGX0smjhw4h69b55UvcFg0e1Lo/LF//HP
         96ImRYhZtX+yi2iMkv4gZ8hWLnCvL84bLd6IQ/L2VoR1ugi91nd9dV5nH2vNloAHhmlS
         vTgA==
X-Gm-Message-State: ANhLgQ1cw24KR55hMmkRF3xYAEINaxkrIc3/NIIemqC9Fy9sF+h3fvO/
        f94L+vuMm8AzSX98YxiznjCDRt8/PFh6BrAhCW6sc5sr0TZXvOTzjwi8YvIT315UvcxPGw96cUM
        xKJhuyri9g6pIhLjiW+f7JYr7TD/6yx/5Bg==
X-Received: by 2002:a05:6830:60e:: with SMTP id w14mr6067797oti.22.1584691716943;
        Fri, 20 Mar 2020 01:08:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupYD4X/pgbXP8kW+FgP5we3wx2b2Hl/Mgfyg/cJW78qTUNJMXlUNCMCyhlFVrlE3b4s5murarAONekJC5QjaI=
X-Received: by 2002:a05:6830:60e:: with SMTP id w14mr6067786oti.22.1584691716701;
 Fri, 20 Mar 2020 01:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
 <20200319194853.15709-1-william.c.roberts@intel.com>
In-Reply-To: <20200319194853.15709-1-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 20 Mar 2020 09:08:25 +0100
Message-ID: <CAFqZXNtZLpdtreN1D5=FU+L8Rm10OpUu=jD4nzEqor7g50f3qw@mail.gmail.com>
Subject: Re: [PATCH] cil: drop remaining dso.h include
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 19, 2020 at 8:49 PM <bill.c.roberts@gmail.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsepol/cil/src/cil.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index c010ca2aeaf4..12cc28eff389 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -50,7 +50,6 @@
>  #include "cil_binary.h"
>  #include "cil_policy.h"
>  #include "cil_strpool.h"
> -#include "dso.h"
>
>  #ifndef DISABLE_SYMVER
>  asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
> --
> 2.17.1
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

