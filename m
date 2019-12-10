Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A5C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DE620828
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LyKla2v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLJTQI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:16:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36356 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfLJTQI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 14:16:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so14660257lfe.3
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2019 11:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7Ly+kFcY9v41W0Yea6eldt67FJ9rQnUT+trJTG6+Xc=;
        b=LyKla2v+ft5Potq4hfBOyqRFw/cMaj4PcpgLni4B1h2XGMuwdiIcgEBJVer+fW8JTw
         HlS9Jacjm4c9JF4zRDK4+Smjj6jl6XYyoADKrz7o6sFvE4rfNfxlYDIzouy+sBgM9O9k
         AomjW/lGgjAyjzhIDXIFQe1+e8daEft3o9x3NSsj9c5Y3toSpTnLsYtRVTNEYI/7ExD/
         j5sO1wp9msJ8fqjpbV+cWh2d5KIVmeGa/3ctA/4PuRHCDhch29FSvQXAaf2CCgYso7Gg
         gFXKFXV1PnFLBLyKRg8Kruz6KTfNrQU6L8Vgwa0B9b4GQ/eUddi35/fqgcc2frFAp9q+
         rhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7Ly+kFcY9v41W0Yea6eldt67FJ9rQnUT+trJTG6+Xc=;
        b=OZIvVbHBamf3clUYMrxrdgNsgDljdhYm7DYEmG9Cdtm+a7T6H3mUo0AuLHAwK8uX1X
         vDwQmNcXNhW7G4yB9vY0xfdGzhBmJqZDYhdnSAALIYT/aDW9/Kp1aS8gWv1oTFB+t+g+
         A7iU2gBHfKfVwtIBvJgRSuZrYMIBsDjHErMWDfkZb6We86ACP8s2KEW2xpr+gzaV74nr
         5XnH/l3qejVXjEn2QD/T2SDWybFHRwatv8gqiheDXclBtFLpenM63hL2+vYScbufflqe
         kR38CZxZfgMVkFFM74UEY6juiXYMZ+NCkV8q43Eh1oB3tFEaUdIJQTYvZO8ryijBJ1wm
         gQmA==
X-Gm-Message-State: APjAAAVrnnajI9XPAmKIg04uyMtM/WHqxgFYPqwphL0ArmbZFyzh51cP
        HmwEjVyGWW8gdvB9SrKro6lrMpr1/aBBTkjb/CSu
X-Google-Smtp-Source: APXvYqzeIvo9MtJbPbux8OasVwNKp66VtrSv68Mg4neHZLu1UIs3yW5CziyvWWX7G8TYK5FShvquGUXIbancx+AALC4=
X-Received: by 2002:a19:f514:: with SMTP id j20mr18471703lfb.31.1576005365522;
 Tue, 10 Dec 2019 11:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20191210165541.85245-1-sds@tycho.nsa.gov>
In-Reply-To: <20191210165541.85245-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 14:15:54 -0500
Message-ID: <CAHC9VhRnqfuVUTDZA+8G-_OTqqN8M7XJhOpiO1m3t0XhY584Xw@mail.gmail.com>
Subject: Re: [PATCH] security: only build lsm_audit if CONFIG_SECURITY=y
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-next@vger.kernel.org, jamorris@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 10, 2019 at 11:55 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> The lsm_audit code is only required when CONFIG_SECURITY is enabled.
> It does not have a build dependency on CONFIG_AUDIT since audit.h
> provides trivial static inlines for audit_log*() when CONFIG_AUDIT
> is disabled.  Hence, the Makefile should only add lsm_audit to the
> obj lists based on CONFIG_SECURITY, not CONFIG_AUDIT.
>
> Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next in order to fix the linux-next build
breakage.  James, if you would prefer a different fix, let us know.

> diff --git a/security/Makefile b/security/Makefile
> index be1dd9d2cb2f..746438499029 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -22,7 +22,7 @@ obj-$(CONFIG_SECURITY)                        += security.o
>  obj-$(CONFIG_SECURITYFS)               += inode.o
>  obj-$(CONFIG_SECURITY_SELINUX)         += selinux/
>  obj-$(CONFIG_SECURITY_SMACK)           += smack/
> -obj-$(CONFIG_AUDIT)                    += lsm_audit.o
> +obj-$(CONFIG_SECURITY)                 += lsm_audit.o
>  obj-$(CONFIG_SECURITY_TOMOYO)          += tomoyo/
>  obj-$(CONFIG_SECURITY_APPARMOR)                += apparmor/
>  obj-$(CONFIG_SECURITY_YAMA)            += yama/
> --
> 2.23.0

-- 
paul moore
www.paul-moore.com
