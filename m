Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE6C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 15:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AADA207DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 15:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W92gUPYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGIPXk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:23:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727925AbgGIPXk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 11:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594308218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/mVkyQihVFxEajhn9MuaV2bhN4qp9z0yPeYW33Ro080=;
        b=W92gUPYlatQ3Ga0ljYdDc9Rk5Wv/1ZcOG/pxvGJ2w7srgwuoaWm4tTpP8YlZq26RaD3oiS
        02XZk5CYmUr0WL06R3j8rZLCYLnFbi1IMAGIMgZrLRhzqD2I56wOsQBHMMQJdTJ95j/cpv
        rfGEnjY+Gs4vUtW33dlvSfn0sq5oWBQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-LFtbuo1QPGG_lQyduhz3lA-1; Thu, 09 Jul 2020 11:23:27 -0400
X-MC-Unique: LFtbuo1QPGG_lQyduhz3lA-1
Received: by mail-lj1-f200.google.com with SMTP id e3so1712315ljp.14
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 08:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mVkyQihVFxEajhn9MuaV2bhN4qp9z0yPeYW33Ro080=;
        b=DTNHugu13CVrmV1VSAQBvROBXlOdvMvj/eJL1upB0UNTwmwB95RDeUHfwfaVNfYnAS
         8ReWvzxNWGqKs76DCyqkcN5i27QSE0VgkRIF/AtptxDrJPcbSbJLPVDFvrCQIXulOENv
         z5VKO+9W5kN1/tqehg6oAInLucSUADHg+NSFenn34n30P69wkL9nxlt2dph5if+8aT4U
         hD0EzppGK9wPNRRXEwDU8zE9c15y6c/fEbmrLJ5iEJCpqP/v2hiNOEeslBsGJxR2+zaT
         eKjBg9AmtM61dCyiJQXERn8FFF8IPtabmDkGnQNAbDdFPRclv01t6CgAWBNRfTfyFUQ6
         j4wA==
X-Gm-Message-State: AOAM532GZaPPpydOotppHA1xFdrTjIMI2xFIFcog6j9bqj9OexKNpZGG
        3ze5XVi2gYwo0/pG55qRUm0WXCLgvFR8LPeevJzVe7UouvLnlBEk95ojmJPf1qP/ooxzXPcf2y+
        5/9/BCtwL/7u8EXPo9A6rdETYAQkbqSCMOw==
X-Received: by 2002:a19:8806:: with SMTP id k6mr39779582lfd.189.1594308205459;
        Thu, 09 Jul 2020 08:23:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4n32lWThDv6IG9FbIQoJT9kPIwiWxAsZpe0BktJFcK56iIiwlKMjernLZsUaZpe0BDC4HnSWO8CCBxLabz8o=
X-Received: by 2002:a19:8806:: with SMTP id k6mr39779549lfd.189.1594308204728;
 Thu, 09 Jul 2020 08:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200709094509.1620563-1-plautrba@redhat.com>
In-Reply-To: <20200709094509.1620563-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 9 Jul 2020 17:23:13 +0200
Message-ID: <CAFqZXNs4UD-wb7fM3Vmh9DEhjQHhZnL+JGBomswuwyZQT=f-ug@mail.gmail.com>
Subject: Re: 3.1 release notes draft
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

a couple nits below...

On Thu, Jul 9, 2020 at 11:45 AM Petr Lautrbach <plautrba@redhat.com> wrote:
[...]
>
> * Support for new polcap genfs_seclabel_symlinks

s/polcap/policy capability/ ?

>
> * New `setfiles -E` option - treat conflicting specifications as errors, such
> as where two hardlinks for the same inode have different contexts.
>
> * `restorecond_user.service` - new systemd user service which runs `restorecond -u`
>
> * `setsebool -V` reports errors from commit phase
>
> * Improved man pages
>
> * `semanage` uses ipaddress Python module instead of IPy
>
> * matchpathcon related interfaces are deprecated
>
> * selinuxfs is mounted with noexec and nosuid
>
> * Improved README which was renamed to README.md and converted to markdown.

This is more of a developer/packager/builder visible change rather
than user visible IMHO. Maybe move it to a "Development-related
changes" section?

>
> * `setup.py` builds can be customized using PYTHON_SETUP_ARGS, e.g. to for
>   Debian Python layout use: `make PYTHON_SETUP_ARGS=--install-layout=deb ...`

Ditto. Maybe the "Packaging-relevant changes" would fit better for this one?

>
> * the dso wrappers for internal calls were removed and it is now strongly recommended to CFLAGS with
>   `-fno-semantic-interposition`
>
> * `security_compute_user()` was deprecated - usage of /sys/fs/selinux/user { security:compute_user } might be revisited
>
> * checkpolicy treats invalid characters as an error - it might break (but intentional) rare use cases

I'd reword this to "might break rare use cases (intentionally)".

>
> * New `restorecon -x` option - prevent `restorecon` from crossing file system
>   boundaries.

"New `restorecon -x` option, which prevents it from crossing file
system boundaries"?

>
> * Handle `semanage module` in semanage bash completion
>
> * Added section about CFLAGS to README.md, see Packaging-relevant changes

Also mainly devel/packager-related.

>
> * Improved man pages

This one is already listed further above .

>
> * Add Travis CI job to run SELinux kernel testsuite on latest Fedora cloud image

Another purely development-related change.

>
> * `sepolgen-ifgen` parses a gen_tunable statement as bool
>
> * `semanage` handles getprotobyname() failure case on Debian where /etc/protocols does not contain an entry for "ipv4"
>
> Packaging-relevant changes:
[...]

Thank you for working on the release!

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

