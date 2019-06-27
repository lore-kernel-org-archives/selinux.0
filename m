Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D0C48BD3
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 03:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3CE216E3
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 03:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hvAbLQyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfF0D2W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:28:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44541 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfF0D2W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 23:28:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so463968pfe.11
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 20:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AJcOSikj55pyAZmz8QMWOU11RheeXmlXy+E8z7yvWs0=;
        b=hvAbLQyocIbxyNU5ZFgGkQWtCAH0u5k4almdJAXx3ARrzKk3Klh41muKuOBaei81A/
         dr9XnOfwmiv61PHDAm5sUXh3dSawGVgIDJzbQZCxuRLARLJOwa6121+NMvaduHtzTkhr
         /y/4GuXMmxgvyxp61vRXshkUoxj5dfyjqySu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AJcOSikj55pyAZmz8QMWOU11RheeXmlXy+E8z7yvWs0=;
        b=M6qmIFq5iMPDeKEi+qePsfSbi+CHEfp/642rBGbThXW6ePexvGiODx67thsin0CuiE
         hQCNnyI7b8dX1qE8iphH6BD+AyUxjDI2ojfnVrF8tD4DhxUdiNG2lMMian/LdZasHKOx
         rNRIlYVCVIJajWMjyFDeBGn6Q3RzgvCm+R0lJy3/mUvNBrKUOLMqs8/VgdjKeILMUpxI
         fUWp3+RWNaU/Fzr0h9nvvnS0JsokLWVZtmTZB1TmYoeOL5CRpBd94V0gs1Wk2KxgTw+4
         FXrACBKTVhOiogZ75tUfIaXC/ImxDlq+ij+04qZUjjV8tnnTPZVpQEi+Kc9x3RA5kpxt
         oiCg==
X-Gm-Message-State: APjAAAWG9gLSVEzuehvAkg7ogzfd6+xGq0MdOjp8ZeDICk3tb48O5fRG
        Z313RkRMyTn/Yo1Fhdltwi8CXw==
X-Google-Smtp-Source: APXvYqwF1R1LURWstNvfQgyGXp4qSQgnnRjenc3s0CUZYJd3VbZ/aZWcB4Wo3rQv2YE2ks+bYhYeyw==
X-Received: by 2002:a63:c03:: with SMTP id b3mr1535164pgl.68.1561606101474;
        Wed, 26 Jun 2019 20:28:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b17sm470630pgk.85.2019.06.26.20.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 20:28:20 -0700 (PDT)
Date:   Wed, 26 Jun 2019 20:28:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v4 23/23] AppArmor: Remove the exclusive flag
Message-ID: <201906262027.26233016DB@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-24-casey@schaufler-ca.com>
 <alpine.LRH.2.21.1906271219450.12379@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1906271219450.12379@namei.org>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 27, 2019 at 12:22:13PM +1000, James Morris wrote:
> On Wed, 26 Jun 2019, Casey Schaufler wrote:
> 
> > With the inclusion of the "display" process attribute
> > mechanism AppArmor no longer needs to be treated as an
> > "exclusive" security module. Remove the flag that indicates
> > it is exclusive. Remove the stub getpeersec_dgram AppArmor
> > hook as it has no effect in the single LSM case and
> > interferes in the multiple LSM case.
> 
> So now if I build a kernel with SELinux and AppArmor selected, with 
> SELinux registered first, I now need to use apparmor=0 at the kernel 
> command line to preserve existing behavior (just SELinux running).
> 
> This should at least be documented.
> 
> I wonder if this will break existing users, though.  Who has both 
> currently selected and depends on only one of them being active?

I don't think this will change a system using SELinux, right? There
would be no policy loaded for AppArmor so its hooks would be no-op.

But maybe I'm not thinking hard enough?

-- 
Kees Cook
