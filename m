Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4B0C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 17:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63752080D
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 17:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="n7a5YaFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAJR2N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:28:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37684 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgAJR2N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 12:28:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id o13so2938137ljg.4
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 09:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fO/zHhLtVtUlIHmIjtuQ9nbQ4mmcwTIMVM7ePkzHwg=;
        b=n7a5YaFAvhuTi96JOqSYnup2HZhUy0tzxzRDoVnZy/Ui3iuvykr7aSth3QV5yfFd6y
         1XYhwJrw7yLyzQD8OXJ1XdjLRDLOSPBizKA6Jhdl63vXfPeAQWjjeVKQFFErDAsvoJfx
         pUV7e6/8xQZxkY+kKdZVhmIPG+i5mnVDSNBNLOLG+jK3NT9ygIIki5usKtW6+LKnm0d6
         Lk6SlECa/GaA9mdJfKsTAMQoMK/yALDC4aKL+o13WVLmCua1EW2Dys/YtQFEuDLs7xwF
         zY/TEIgurYPYZi3FgccrmcOlVm3+6CLXOTJcTse7G8qKwuMTfSQunW+VjpFxz+ZVDdPK
         r+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fO/zHhLtVtUlIHmIjtuQ9nbQ4mmcwTIMVM7ePkzHwg=;
        b=maPf3ZHPIfMqQoDzu3u/KFZFWCpO1n5+1KRzGM2P1ACYjpxeUU00qsDAaOow1ys5JF
         +EjQ7VFa64E3ve003xA0RtCPll3NYrTIDjf5EsvRfsuFl4xBbSP/WZrrEc06Qk10pzxP
         moAyHRUZLHZdtkmxEPfOQIQkz1IiOyOAQI6+GBUvJIG5Y0MvklG1A1OMck5vG6mg0pH3
         lKPaQ8i6+QWzK92r1tZqudwYE0paGsxcxZKa1YXEGIplmdjmW02qlQJKNiKIaI0FWxI9
         5WXrDOMAwtG08yNOFh+FCVo+LOV1NEZed7IsZWmJ8Y+9p5RbCVyEoRRWMI3O3AoDBz++
         JMOg==
X-Gm-Message-State: APjAAAWCdWfQLuhLWxCRakj2MZNfmottdtpRB7I5i3vyTN+vhgNjmNV6
        PT9wyn16t152dh1z/OSi87+4JQ/oHorFNvbohSHU
X-Google-Smtp-Source: APXvYqwTA5JOsBbxekQwE/1nJBUs9BEmWBZD/vDNh26dykOlW5EbntzWiLwD+QOpXKI34OHeQRy1WbIY8vsYQYpZMuI=
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr3310483ljc.84.1578677291053;
 Fri, 10 Jan 2020 09:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20200108172356.35193-1-sds@tycho.nsa.gov>
In-Reply-To: <20200108172356.35193-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 12:28:00 -0500
Message-ID: <CAHC9VhTN8g_Ca8mg60uxzXuMGhYdkXj-qDJaZHoTB4ouxrr_rw@mail.gmail.com>
Subject: Re: [PATCH] selinux: make default_noexec read-only after init
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 8, 2020 at 12:23 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> SELinux checks whether VM_EXEC is set in the VM_DATA_DEFAULT_FLAGS
> during initialization and saves the result in default_noexec for use
> in its mmap and mprotect hook function implementations to decide
> whether to apply EXECMEM, EXECHEAP, EXECSTACK, and EXECMOD checks.
> Mark default_noexec as ro_after_init to prevent later clearing it
> and thereby disabling these checks.  It is only set legitimately from
> init code.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
