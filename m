Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E55C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C6A20665
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ClKEuBXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfFZXEq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:04:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39895 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfFZXEq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:04:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so195009pfe.6
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O+unN2ppMz+Lxz0HqVzJ4qMUjsNDCJD0N+sZPuyGAeU=;
        b=ClKEuBXTKkr+Kl9RmNFHiZKM8QoJsIpNT9BZJOhNj1AHqMy77A+RHPqGWLdSzNtyl0
         OSz8308toD2AtG3OTLcA/MxuvwQpFlucPmojP8d6UP4FAr/5bSr1qwIWhc8fA0LC03vu
         ta+j2JRkx7kvMUOwcGM3y+THWoOJscgF89Zn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+unN2ppMz+Lxz0HqVzJ4qMUjsNDCJD0N+sZPuyGAeU=;
        b=gDBcq3hMbcgjb/SIOStPTuFnm72oIDSHted5TUeYn4FeKyGA81N0/8rtUh63o7Jmbi
         WHHHOY78SUuJrrCnmMtfTd47d1y94KJ4wO/MFLj323ptRacNQPQ769zzjaqKuiNRwhyI
         XLw5+waZCY66WUkPJqaL4PAu111x+nVoomPiUhI4oJqWrs0li8KBiMbxj3GpZi8V4nJN
         nW2O7J6Db8JXrcc2vDaOX2B+VfDJ6FuBxmjXjvaH+JW6ZfxfpsvEAhlMWLXBaxNDGgJP
         qJGMASeUAFs+GK+Z0ewfIxUO6DbVMnYF7kMRGa31HvKbIJ4W5fcepHmGZQvM4kMYDQKD
         3spw==
X-Gm-Message-State: APjAAAXpll89n6FrPsxme8gPwsU/NM+7MVuYp/27ziMb6LTbX+p7+atZ
        KwStB63mjkpFeP7GsoBgzXT4uw==
X-Google-Smtp-Source: APXvYqwuKLw0kIc4ha14kbUR8ZRJlKwgNAQr626qa5CZ7lf898izd/gUEOhmfp2Ok5FMpPuxbKtXzA==
X-Received: by 2002:a17:90a:3590:: with SMTP id r16mr1944100pjb.44.1561590285922;
        Wed, 26 Jun 2019 16:04:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 125sm325062pfg.23.2019.06.26.16.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:04:44 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:04:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
Message-ID: <201906261604.C387F7D7A@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <201906261404.451588F@keescook>
 <47abf84c-208e-3a08-d50b-5d3f51aee271@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47abf84c-208e-3a08-d50b-5d3f51aee271@canonical.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 02:11:23PM -0700, John Johansen wrote:
> On 6/26/19 2:04 PM, Kees Cook wrote:
> > On Wed, Jun 26, 2019 at 12:22:11PM -0700, Casey Schaufler wrote:
> >> This patchset provides the changes required for
> >> the AppArmor security module to stack safely with any other.
> >>
> 
> 
> here v
> 
> >> Because of the changes to slot handling and the rework of
> >> "display" I have not included the Reviewed-by tags from the
> >> previous version.
> 
> 
> >>
> >> v4: Incorporate feedback from v3
> >>     - Mark new lsm_<blob>_alloc functions static
> >>     - Replace the lsm and slot fields of the security_hook_list
> >>       with a pointer to a LSM allocated lsm_id structure. The
> >>       LSM identifies if it needs a slot explicitly. Use the
> >>       lsm_id rather than make security_add_hooks return the
> >>       slot value.
> >>     - Validate slot values used in security.c
> >>     - Reworked the "display" process attribute handling so that
> >>       it works right and doesn't use goofy list processing.
> >>     - fix display value check in dentry_init_security
> >>     - Replace audit_log of secids with '?' instead of deleting
> >>       the audit log
> > 
> > I think you missed adding my and John's Reviewed-bys from v3?
> > 
> Casey stated why above

Oops! Thanks! I skimmed too fast and only read the "v4" log. :P

-- 
Kees Cook
