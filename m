Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3CFC43603
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 02:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC4921D7D
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 02:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q/KQ9Kgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLSCZ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:25:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46858 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfLSCZ4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 21:25:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so1976979ljc.13
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 18:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjDKQ0r0oJMDSv/W5Rey9Q8zxmFJ01o9ZQB31uqDEZQ=;
        b=Q/KQ9Kgk2J1R3XUcAZ47JaHa6OXAUWJy+w561dRk0gvG9fDuuddwpFSegx3cLA+Y+y
         8FMuToEfomDVkxyhJcHrb6EagfxJagHTQFcud7a7En3ex6lMB4BrnNKz0EQzlMLVOTAI
         a+fAh7ryr7OXczGV7E1blw9dx13IbmyuUHoCS4QtK2AJ1Q4QwBKmOK5QMbYixrILIabN
         F+leNKAHpm60BTQsE2KZGvFc6amrVJlXv2LlcDcOKw5L18q+krXJBkps0vm+MRZ39j7r
         KgSJKid7G17q+Xf9zgo8INmVvrDfNyeDW+Jd4/BDDnuPo6cZqMLX4W2WjZgUtLD/e7ez
         E/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjDKQ0r0oJMDSv/W5Rey9Q8zxmFJ01o9ZQB31uqDEZQ=;
        b=YgF9G/DyPG00MpjPGzCQcP9aTFKYypAnaNdPD+FHHqeON3kpzM9TTlxWfwvg/9cZ3u
         gv+VZMqsWsHCnWKoNMoDT3z2n9KrXM08rK003sSag2fViBnWX9lFA8Lwq7NGE5crfvz7
         bZa+nfRgS9nSo5KZ7am1e3EJhT3npGYISyrSFIQmTYA7qd9NkTbXkPKb4K2SqDQVfmxQ
         q0oAfZBiPjMAg/nVHyojKRnIma0cXJvAl+PxEa/ftv9j6yOMiNkhWDowaySALxZIEb2k
         2q3FJ9O0/wmsev4itPI8PsHVaLuIASU2/0ni5wJsrR7zcgP42HgPE/2IOBzphy9T2Pjh
         U1sw==
X-Gm-Message-State: APjAAAWW8wEGNeHY7bq6eRZUjBoYL08Ki4fFqb0ay2GJu9mJxhBjeT7H
        SMw5HJ6mSmsDcOiQO/3VqylmPow4t9jzAL8KQEnIMhM=
X-Google-Smtp-Source: APXvYqyDQ19EJgnYO5244mLqcv/A+Jdri7XO52L/hdAC67ZuDghnUAu7hhmvck45wN9LQKdouVR1KahhOdX1xnbyaZ8=
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr4173011ljo.54.1576722354119;
 Wed, 18 Dec 2019 18:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20191217141510.10941-1-sds@tycho.nsa.gov>
In-Reply-To: <20191217141510.10941-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Dec 2019 21:25:43 -0500
Message-ID: <CAHC9VhRhb-JmN9wGCLM8wqQkYpYC3qW+U59J5TVBj8EqaV6Leg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: clean up selinux_enabled/disabled/enforcing_boot
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 17, 2019 at 9:15 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Rename selinux_enabled to selinux_enabled_boot to make it clear that
> it only reflects whether SELinux was enabled at boot.  Replace the
> references to it in the MAC_STATUS audit log in sel_write_enforce()
> with hardcoded "1" values because this code is only reachable if SELinux
> is enabled and does not change its value, and update the corresponding
> MAC_STATUS audit log in sel_write_disable().  Stop clearing
> selinux_enabled in selinux_disable() since it is not used outside of
> initialization code that runs before selinux_disable() can be reached.
> Mark both selinux_enabled_boot and selinux_enforcing_boot as __initdata
> since they are only used in initialization code.
>
> Wrap the disabled field in the struct selinux_state with
> CONFIG_SECURITY_SELINUX_DISABLE since it is only used for
> runtime disable.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v2 switches to hardcoded values for enabled/old-enabled in the MAC_STATUS
> audit records, drops selinux_is_enabled() since it is not needed, and
> makes both selinux_enabled_boot and selinux_enforcing_boot __initdata
> since they are unused outside of initialization code.
>  security/selinux/hooks.c            | 12 +++++-------
>  security/selinux/ibpkey.c           |  2 +-
>  security/selinux/include/security.h |  4 +++-
>  security/selinux/netif.c            |  2 +-
>  security/selinux/netnode.c          |  2 +-
>  security/selinux/netport.c          |  2 +-
>  security/selinux/selinuxfs.c        | 11 +++++------
>  7 files changed, 17 insertions(+), 18 deletions(-)

Merged into selinux/next, thanks Stephen.

-- 
paul moore
www.paul-moore.com
