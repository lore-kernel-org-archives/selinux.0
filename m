Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193C4C433FF
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 17:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74EC206E0
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 17:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D/nyhGGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfG2RFD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:05:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35593 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfG2RFD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 13:05:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so27747000plp.2
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T0irySBTgZ2yXply6I5PieqBgSXD7raAHIcMDZbw1ww=;
        b=D/nyhGGp2VsM/R1Jy4byBjUW8TE4IegAMll6MajAH0+fCIRfGYjnA5+lU1uwmYaPNX
         t4siWjjT2O2X5ADbTG+PvQnP8QmsWLzXboXgHKWISDb25bw5vTWsn6JLXq0LDEqCxWuC
         HETkeA0vT1OsCaoPwxxnxjwbqbQS2szyagBOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0irySBTgZ2yXply6I5PieqBgSXD7raAHIcMDZbw1ww=;
        b=AANXxm1FJigQ/EpZMTkizVFhQx2V769hxxApdpLF7bWP8ZrAmRTJTJCpdhyJOW9fUo
         O2+2YKoI9uvGBKfQIj0555L5dJPZeJlFSf9s5C2pj5BWG6Y+XbfLVUpk6VbhQiqa+89Q
         ijgDujw8KphWEUzKMIb22n41xOD1evP0F4P8hvE9B7jUaGgZnyX8ytM27y/7sOsDZYu0
         6BP5dgTekMV5oE9H/22oNRxQNfn0YVDj/kSSDeDPDcB7VsOZzXwVxjkEGW/FD4B+KVyj
         U+RX96b0ky1dp8ltIr7kWCHxSn5WwEkoAKNpdwz+UO2n99jFhzQxrPvwVZLRcq+0W9am
         kL/g==
X-Gm-Message-State: APjAAAXzMqEeL6WIfCce4CoIMRprDdbaEStJFZLGmdBwtCzijDc98Fpy
        dSMCWDx8ERF931Yu1qvEP4racA==
X-Google-Smtp-Source: APXvYqzw1XIGfrYY7jFB2VlflwHsCIpi2Ip1JX5s7R0uRj4XNLOAYDdolj1hRbxVDVp/z1glEvOWEw==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33mr110535231pld.174.1564419902756;
        Mon, 29 Jul 2019 10:05:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i74sm121948392pje.16.2019.07.29.10.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 10:05:01 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:05:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 14/27] LSM: Specify which LSM to display
Message-ID: <201907290959.747536016E@keescook>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
 <20190726233923.2570-15-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726233923.2570-15-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 26, 2019 at 04:39:10PM -0700, Casey Schaufler wrote:
> When a program is executed in a way that changes its privilege
> the display is reset to the initial state to prevent unprivileged
> programs from tricking it into setting an unexpected display.
> [...]
> diff --git a/security/security.c b/security/security.c
> index 8927508b2142..4dd4ebeda18d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -835,7 +857,18 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  
>  int security_bprm_set_creds(struct linux_binprm *bprm)
>  {
> -	return call_int_hook(bprm_set_creds, 0, bprm);
> +	int *disp = current->security;
> +	int rc;
> +
> +	rc = call_int_hook(bprm_set_creds, 0, bprm);
> +
> +	/*
> +	 * Reset the "display" LSM if privilege has been elevated.
> +	 */
> +	if (bprm->cap_elevated && disp)
> +		*disp = LSMBLOB_INVALID;
> +
> +	return rc;
>  }

I think this is the wrong place to check this. This is called in
prepare_binprm(), which is very early in the execve() process. By my
reading this will change the forked process's display first before the
exec happens (which may potentially fail) -- this needs to be changing
the final state once exec is under way (past the "point of no return" in
flush_old_exec()).

Also, the consolidation of privilege information happens into
bprm->secureexec in setup_new_exec(), so I think you want to test
secureexec not just cap_elevated.

So the test/clear should likely happen in finalize_exec() since it's a
runtime state, not a memory layout-changing state (which would need to
happen earlier).

-- 
Kees Cook
