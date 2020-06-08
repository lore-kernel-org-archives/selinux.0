Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E62C433DF
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 21:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE27A2074B
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 21:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d/NLD/36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFHVRK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgFHVRJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 17:17:09 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64330C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 14:17:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gl26so19958921ejb.11
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 14:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2/+edZUQhHg8Fj56JiClX6MIXc0Afdutzb+4JBzHBk=;
        b=d/NLD/36SugS1SW9Jc7V33C4fPj+QUsgp/gP7Ej92sU4f1fvRDOFL5IYJnP7Cu59LD
         p3k1rF/ytV/2UWpRpVmLDHIDnrFDSI9iDUIdkze4kRkVLBBXQkmzwTEa/2xvMpW7WEj3
         kCdHyG4IA4OT9B8d58K9WGhHoVhbaqnNkh2mrLwQJ2gbPHjYa2Xv64lcRwTs3Wo0dnlC
         +42TPRn1FNsWc1WIDecR7SE05hhKFKIdnnkGRcnWAKUYkqnljfrXCeg20fXaUgbYiXd6
         XRRKcRo8fxXTluwOp9dV+R8oHH5vzj1EX8XT7fE+wCUwXsGZwBWz9egBM6V6TW6IaQd+
         tQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2/+edZUQhHg8Fj56JiClX6MIXc0Afdutzb+4JBzHBk=;
        b=HKasdbHk4vWCGPePMqhxM7YQoAJ2fO3+wVpdT7NhOU7mldXgur6IJcJ34agk6fXNoq
         1EDN0QoPtiMNvO0c9T0YgfNo/j+xvNOEMjw/ygpPsNzqpczM8A05/yT6T8cDpqyAoSHX
         QpIOc8rNBPDOGJIk5+inc9ZVsGjTKi8F7lBqtIZkNOMOBgBsHSEmnEY+6rD9CdhguTsv
         FREKzJBccC8lU4bM8D5A0NRu5rBTh65/27PvHkutlpyZd51wpQ8Pnxw/DGEyA5D8HEql
         O+zbkDkxIziw3X+rqtHiFM85QuHKhc+83VG+flfu/5XPsoFMIdXMnqHAyjYW0HR9It7E
         XOGg==
X-Gm-Message-State: AOAM531NFDjv9RLdzMIsPLq0jEJl/EqyWGC7Ztc1nWZgR/hYYikLYr+V
        y+mdAtWaeGBSfi4iEtjkYrux285OKZEPGY4iNGIxidA=
X-Google-Smtp-Source: ABdhPJxRPhcimTvpfzn2Ef9NTG99nExhTcMCJkgZKhwh9EC9cPkX1fazOoR8V875TzGMt1Skcm67S+2wAwJAAAZzyHo=
X-Received: by 2002:a17:906:2b81:: with SMTP id m1mr21733798ejg.488.1591651027883;
 Mon, 08 Jun 2020 14:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
In-Reply-To: <06f4b748-470d-8774-ffbb-5e342f6fcba8@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Jun 2020 17:16:56 -0400
Message-ID: <CAHC9VhSjPqsb9ZCWKchhN2ParSR6XH+57jzc7fQ0FjxK28tZOA@mail.gmail.com>
Subject: Re: Better management of dynamic networks?
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 6, 2020 at 8:27 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> Hi,
>
> I have a SELinux setup for networks, where packets, nodes, interfaces
> and peers are labeled and subject to TE rules. In general the system
> works very well and I'm thankful to be able to control network access
> for each individual application in great detail.
>
> I'm still learning SELinux, so maybe I have missed something, but it
> seems to me that these systems have been designed with rather static
> network configuration in mind ...

Yes, historically the SELinux users who cared about labeled networking
have typically had a stable network configuration.  Or at the very
least they haven't discussed problems with a dynamic network
configuration.

> The interfaces and peers are labeled with netlabelctl, but the
> interfaces change when kernel modules are loaded and removed for
> interfaces and it's also possible to plug in a USB network adapter any
> time. With Netlabel it's possible to label peers without modifying the
> policy (for example during boot), but `semanage node` and `semanage
> interface` require writable policy. Netlabelctl can't label an interface
> if the interface does not exist yet, but I've opened a PR for a possible
> workaround.
>
> The tools don't support for example pattern matching for interfaces. It
> would be nice to assign SELinux labels based on various properties of
> the interface and network, for example with udevd, systemd-networkd or
> NetworkManager, without requiring policy rebuild.

I can't say I'm an expert on all the various userspace device
managers, network or otherwise, but so long as they can execute an
arbitrary command then one should be able to use them to label the
device when it is added to the system.  Although perhaps we could make
this easier with docs and/or tools.

I would be curious to hear what the SELinux userspace folks think about this.

-- 
paul moore
www.paul-moore.com
