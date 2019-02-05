Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4790DC282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D54120811
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1IB42K2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfBERpq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:45:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52796 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfBERpq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 12:45:46 -0500
Received: by mail-it1-f193.google.com with SMTP id d11so10513478itf.2
        for <selinux@vger.kernel.org>; Tue, 05 Feb 2019 09:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOrCFx37nF5xUpxn8ZZH6UtsPKM4eznxTRC9/Lni76c=;
        b=1IB42K2OvWFTs3O/0EbyZELsT323wAnOOe8CN6rrWuK+zOvJ+xqMoWwYrnOKUDHckU
         z77DFgZPpeGroanHHM1n7qFYKbWdOSkbhbcc5PTl/qhzcvb8cUQY5+gs/Fazty7UdC0v
         3xDHII3cC1FliRO27QYkuawPQOlkqM9mmCBviLeQPDcM3MosJgjo/qrdZS00i8GarBXe
         tjDIDVq73sm0jQGa1Qw2Udz7iQKZYoPXDBdwadsrHe7J+uWFsT8IQAkCxE5deHG4MC68
         zFUPWzhXBXcVznwQ6KYymrBm3I/qj3Hxsz/Fa/9R3nJotIz1rVtwrlBhz2i49o0cWNv2
         Hplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOrCFx37nF5xUpxn8ZZH6UtsPKM4eznxTRC9/Lni76c=;
        b=LSW6dJkmzCZ4W1ro3UG6JhuTRS0eB1Fehjab+hdtGwBToq45LVnx/Bz/XlDgBwxCjI
         Url6WrLdiS6FZ9gmSNdaYhKvluYWwCM36tpVWoKLGepEkYHooAlnZXUiy2vGAQ68uoJa
         PJtXjs5JHExj48TYqBoSn6XW5pKfjiV7GvGPP8wm4loYOOmM8MVO9x79t75e4vBQaABS
         1x0HZXQrhdjsjfdadtv821Mqm1bg8Y3L6zXVyF4houOj5YGfMFVRAP/UX8YWhnFGnzge
         eeinmCfSDdpiLWgzeSVR535HNWT6eAUwmHsd1ykDZFr7gY1EOpSWngnhoXHFgivmn/G/
         YR/w==
X-Gm-Message-State: AHQUAuZaPZURNP/yUCNB6d9Vr0bHKUlRh/chNHfY7JTztFuBnVfTYmQY
        jtnnuBOkEny0stUxemuGqXA/EFavPPc0jmYfrqwO
X-Google-Smtp-Source: AHgI3IaGTOEVbNkuOhnLxLptb0rRbcqFG+W1pSFrNvOA75PoTFqisWflCDxzhi80oevAdhSPAjbDUy0WRjROxM+eI0k=
X-Received: by 2002:a24:dd8d:: with SMTP id t135mr3042990itf.84.1549388745105;
 Tue, 05 Feb 2019 09:45:45 -0800 (PST)
MIME-Version: 1.0
References: <20190205164932.8472-1-sds@tycho.nsa.gov>
In-Reply-To: <20190205164932.8472-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Feb 2019 12:45:31 -0500
Message-ID: <CAHC9VhQRnXMXt5J-rhDHORVHqq6-Q4TRZ0-Zw7OMnsXAVWzcQw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix avc audit messages
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 5, 2019 at 11:49 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> commit a2c513835bb6c6 ("selinux: inline some AVC functions used only once")
> introduced usage of audit_log_string() in place of audit_log_format()
> for fixed strings.  However, audit_log_string() quotes the string.
> This breaks the avc audit message format and userspace audit parsers.
> Switch back to using audit_log_format().
>
> Fixes: a2c513835bb6c6 ("selinux: inline some AVC functions used only once")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks Stephen, I've been burned on this in the past too, I'm
disappointed that I didn't catch this originally :/

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 33863298a9b5..8346a4f7c5d7 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -674,13 +674,13 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>         audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
>
>         if (av == 0) {
> -               audit_log_string(ab, " null");
> +               audit_log_format(ab, " null");
>                 return;
>         }
>
>         perms = secclass_map[sad->tclass-1].perms;
>
> -       audit_log_string(ab, " {");
> +       audit_log_format(ab, " {");
>         i = 0;
>         perm = 1;
>         while (i < (sizeof(av) * 8)) {
> @@ -695,7 +695,7 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>         if (av)
>                 audit_log_format(ab, " 0x%x", av);
>
> -       audit_log_string(ab, " } for ");
> +       audit_log_format(ab, " } for ");
>  }
>
>  /**
> --
> 2.20.1
>


-- 
paul moore
www.paul-moore.com
