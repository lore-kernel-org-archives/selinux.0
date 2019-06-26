Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347F7C48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 21:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B322086D
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 21:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NAzw70uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFZVEn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:04:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46658 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZVEn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 17:04:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so37454pfy.13
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yfCTREuQXuRu8QPWjEkWJzqOZ4JMW0iQQ9/V4AAPG3o=;
        b=NAzw70uG0pAkX7k6utXLuWnOdJKwLvAsSJudfJ816eifuqCscDALHSNva6hHXaTchG
         cQhw/nuymlNF31J2w0+G9O9ocm9UVeYPNwtSZf1r7Kv47rwQrcmcw2TheV9qSCZU4nIx
         wxaWlDq2e5q8LJ0zQNiez87vrnH1D5JSezWC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfCTREuQXuRu8QPWjEkWJzqOZ4JMW0iQQ9/V4AAPG3o=;
        b=Xbn0X8hngg9EZ86FN45qbgWR6pYVtDmg41EG6I15igc9xGKLRGmw5+Km8KzvquAhAS
         UIxJOjXjHtrUK58lU9M1eBkLs1EIVOa8QFlavXcqarOLe0RUIC0XwYzqrfUHf0E3R8Ou
         5egGuU7/Dhla8jOlOLS6DknIap99Gsa7T8B52N31WCR90sCc7/jZeoc6alNVhv7CMzKR
         jVDrNotQdg/rD9wo5/Mk/HqOQNxeB1rCBEP4GSnRgK6rp1fgjbo3qAt3yUNH3/9Y7N84
         KUx+gqHiKVcss9Gfi4/XrQpsK8CjGWy73CMPISdcj+Rw8tw/sdPYqDpSD8xy6r3O9PUX
         AhXQ==
X-Gm-Message-State: APjAAAXWCGAKT0I3/DpRojd8o96g7OzdNmWWbWNPbQ58MEVp8b6Twooi
        T+ss8+AxR15oisBfDOujw2sHwg==
X-Google-Smtp-Source: APXvYqwKZB9SyOCwptrQiJgk/7PZu8uHIDEymwG9crwrzlqf3Q6ME6As4Y8TZsU+B4PmX2aQIcaB/A==
X-Received: by 2002:a17:90a:ca0f:: with SMTP id x15mr1331028pjt.82.1561583082896;
        Wed, 26 Jun 2019 14:04:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15sm127486pfd.183.2019.06.26.14.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 14:04:42 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:04:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
Message-ID: <201906261404.451588F@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:11PM -0700, Casey Schaufler wrote:
> This patchset provides the changes required for
> the AppArmor security module to stack safely with any other.
> 
> Because of the changes to slot handling and the rework of
> "display" I have not included the Reviewed-by tags from the
> previous version.
> 
> v4: Incorporate feedback from v3
>     - Mark new lsm_<blob>_alloc functions static
>     - Replace the lsm and slot fields of the security_hook_list
>       with a pointer to a LSM allocated lsm_id structure. The
>       LSM identifies if it needs a slot explicitly. Use the
>       lsm_id rather than make security_add_hooks return the
>       slot value.
>     - Validate slot values used in security.c
>     - Reworked the "display" process attribute handling so that
>       it works right and doesn't use goofy list processing.
>     - fix display value check in dentry_init_security
>     - Replace audit_log of secids with '?' instead of deleting
>       the audit log

I think you missed adding my and John's Reviewed-bys from v3?

-- 
Kees Cook
