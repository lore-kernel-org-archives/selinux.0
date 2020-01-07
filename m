Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2BC33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 16:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38102087F
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 16:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="2RGxK9qM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgAGQTi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:19:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41762 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgAGQTi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 11:19:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so124123lfp.8
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 08:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlkrwFqED7pMrQb49gzw5+Pcei+fviLJ/6UXdqNltuU=;
        b=2RGxK9qM7X3ZNB4KelVkMCRG4AtVYMoXFwxkwMei8hSByrJEmk769cZidi1czj3aiF
         NP9xwus9XxEQBz2TwbSsJcSAJtU0dkU40H+9WMNuyeMQ4BAHu4fzRyhN32K/ThnFqd+q
         XCkn82cs9JkSz/4Q9t4uoeP6dvEdUHy6SFWQaSWzkj7hC1DCIQUIZIxhl+1VJMmZ6kn/
         LfVR55Y8nouRMAbHJJfrkGEWoYY9NR9H6EalVAx8dUrDNxi1tRuha6jFm5n84UrZazNx
         D5BiG1Br4K0mIkoSdi76B41ooiMTHHzuQiU8/xn9vUTIqRIvY7bgL7ZX0fX+LonBtcZg
         qJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlkrwFqED7pMrQb49gzw5+Pcei+fviLJ/6UXdqNltuU=;
        b=GodhR49V1bhXy7rIsnkWBczAvpNDg3R/VVUiBNBHCt0NhWDjW96DEiSI6raI6d+qPw
         CAedwJ5rIvtzqPwvnL6xMQzJPRRycxrRxldJbAwT9vslsTUScvTTHpPcVSPr9BYZk8+C
         OI93KLUeDQQHiB43TSmBWimCcz4kK+6YbaSjDeuqUSDOFDo9zatOuJ4fqf8nWBCy9dRb
         k2jWnk999VjcfaBvynAt8BsehjhWzhr1al/iYpnPMJB19zPeAoz9uX2x9QTBMBFI9fgC
         1/Xh+pxHwmyv8seGMTrGD2IEaCwHehVpYmPPb+n8v95+Rgf5PhfudEoIoVvjWur7Gsm6
         O42Q==
X-Gm-Message-State: APjAAAWP4jpXX4cB5JARh++MD7534e5JqA5Ikvaxu/bAjG5r/SbIfRXJ
        7zGL1Q0dkk4RlWz4uTyu0/yCXtbDqF91xYa/wErHJVo=
X-Google-Smtp-Source: APXvYqwwLLlaRcKtnPvlxeANcUn53e+GedCMWyI/1a08vxXU8sm0uHdLXMmN1DyyEtWlPJf7J7iL0oor8fJ3LkcLYDM=
X-Received: by 2002:ac2:5983:: with SMTP id w3mr138735lfn.137.1578413976257;
 Tue, 07 Jan 2020 08:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20200107154450.25961-1-sds@tycho.nsa.gov>
In-Reply-To: <20200107154450.25961-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jan 2020 11:19:25 -0500
Message-ID: <CAHC9VhQKZGa_g7Eq97WnUmzUAJDZoO5-sDhu1Qrxo7XRLjTPeA@mail.gmail.com>
Subject: Re: [PATCH] Documentation,selinux: fix references to old selinuxfs
 mount point
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 7, 2020 at 10:44 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> selinuxfs was originally mounted on /selinux, and various docs and
> kconfig help texts referred to nodes under it.  In Linux 3.0,
> /sys/fs/selinux was introduced as the preferred mount point for selinuxfs.
> Fix all the old references to /selinux/ to /sys/fs/selinux/.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
>  security/selinux/Kconfig                        | 7 ++++---
>  2 files changed, 9 insertions(+), 7 deletions(-)

...

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..565d84760e48 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4349,8 +4350,8 @@
>                         0 -- disable.
>                         1 -- enable.
>                         Default value is set via kernel config option.
> -                       If enabled at boot time, /selinux/disable can be used
> -                       later to disable prior to initial policy load.
> +                       If enabled at boot time, /sys/fs/selinux/disable can
> +                       be used later to disable prior to initial policy load.

While we are modifying this, I would suggest adding a note about
/sys/fs/selinux/disable being deprecated, or simply remove mention of
/sys/fs/selinux/disable.  The latter option is probably the better
choice.

-- 
paul moore
www.paul-moore.com
