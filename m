Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B93C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 23:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6057924673
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 23:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BMvtQdbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLPXjc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:39:32 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38340 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLPXjb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 18:39:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so8740389ljh.5
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2019 15:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTAhM9qvrWzZl1ZQnDoOUwuUrWCg/TYk4xAG/Y5t+4M=;
        b=BMvtQdbfW8AmZksHpS0HH4va/otDIpkSk0rBmZWmwPWtPOpJsvj/yNbzP23du8FdXI
         LXmB0Jz85hF9GXyN4eL8YPRZVMk73vQ4UZvSz6OgglBrQkJRLv+JvSxynQIOgfwXHeNH
         EJe4CCsKzXGyA9eKvXGFNMFbn2mKxDst0ybAvgsIxPaoN8HUpvzWAgyvjZnGOIhud6e9
         dthKPT7n1LpB6jLRwnljnXjYxxmhfrlw2R2eUPPdklwCV71gRjAhwlOd7xbfRQoBGTpK
         z77vwVsRGjbysgtPcRvHFRhNvWjj1PB5cI8S9j3hO1CGKWZl2CKwYbPCgvYnfg5go/7q
         5QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTAhM9qvrWzZl1ZQnDoOUwuUrWCg/TYk4xAG/Y5t+4M=;
        b=a3HwXqt0zknnGciBIU1cS3n1DsPyeHjp2uylHyxIfaGIXtHGDH/aNHUbe5sBe0KBgS
         Ml1qe74S/knCzDKLLN88tA3fuJp0Fl4P3aKQcR0XVpt5g7+uG+4raZ4SG0wK7U8Nx6Q4
         stNfKlRVQlrb8NIdQGWE9lxsLba2RuxyndjuT1ucziFeKYx7gTfi3JRAt4pFxr47BcUW
         djsgYc9nMnAIO5g6pCfqnch/Ydbzphc4dGbCJIyMCWb1FtwiaR4NoIozoWZGZGr7gj/z
         k0WLZxPorPWN6iR4kV8hShD6JxseD294WOPfDbM8uvkM/PhRZGsZ/Uqlu/Gj8JSb2bnk
         XM1g==
X-Gm-Message-State: APjAAAX4QwcZ1erGbOiNBpr2Jjfkwk3GzJEpMQ73Z88QApqUHbsJcQ5c
        /VA8s/gLQm0OR5GWVkJtF57dsR7XoW2ELv6xhhI67YQ=
X-Google-Smtp-Source: APXvYqwRU8Xe9kg2FkC/3KE+nlwYoRh8BI9MFs+WxrxS0TYslb5/GK+yBNubhSPNAozp+4RbutKipCGgjLJ9/1WSkm4=
X-Received: by 2002:a2e:3207:: with SMTP id y7mr1091291ljy.57.1576539569454;
 Mon, 16 Dec 2019 15:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20191213143218.149544-1-sds@tycho.nsa.gov> <7e45e92b-0883-c65e-3809-ecdc8148127b@tycho.nsa.gov>
In-Reply-To: <7e45e92b-0883-c65e-3809-ecdc8148127b@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 Dec 2019 18:39:18 -0500
Message-ID: <CAHC9VhSqMbNgWD+R4zBxqUm=vhKPF=-v9CyQQyvRepodCDMV+A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: clean up selinux_enabled/disabled
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 13, 2019 at 9:44 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/13/19 9:32 AM, Stephen Smalley wrote:
> > Rename selinux_enabled to selinux_enabled_boot to make it clear that
> > it only reflects whether SELinux was enabled at boot.  Further make it
> > unconditionally read-only-after-init and stop needlessly clearing it
> > in selinux_disable() since it is only used to skip other SELinux
> > initialization code.
> >
> > Wrap the disabled field in the struct selinux_state with
> > CONFIG_SECURITY_SELINUX_DISABLE since it is only used for
> > runtime disable.
> >
> > Introduce a selinux_is_enabled() static inline that tests both
> > selinux_enabled_boot and selinux_state.disabled as appropriate
> > to determine whether SELinux is in an enabled state.  Use this function
> > in the MAC_STATUS audit log message in place of selinux_enabled(_boot).
> > It is unclear why this information is included in that audit record
> > since selinuxfs is never registered at all if !selinux_enabled_boot
> > and is unregistered in the runtime disable case, so this code should never
> > be reached if SELinux is disabled.  It is also unclear why it is logged
> > twice under enabled/old-enabled since setenforce does not change its
> > value. Regardless, we leave it as is for compatibility.
>
> Just noticed that there is another AUDIT_MAC_STATUS audit log in
> sel_write_disable() that uses hardcoded 0, 1 for enabled and old-enabled
> values in the audit record.  Don't know if it should also use
> selinux_is_enabled(), or if we should likewise just hardcode the values
> used in the sel_write_enforce() case (to 1, 1, since this code shouldn't
> be reachable if SELinux were disabled).  If the latter, we don't need
> selinux_is_enabled() at all.

I see no reason why we can't hardcode the enabled/old-enabled values
as they are always going to be "1" here.  As for why the values are
being logged there at all, it has to do with a desire to have a
consistent format for each record type; in sel_write_enforce() we log
the enabled/old-enabled values for the MAC_STATUS record, so we need
to ensure we log the values in sel_write_disable() as well.

Looks fine to me otherwise.

-- 
paul moore
www.paul-moore.com
