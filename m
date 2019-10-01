Return-Path: <SRS0=wSC+=X2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C6C352AA
	for <selinux@archiver.kernel.org>; Tue,  1 Oct 2019 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B2E21906
	for <selinux@archiver.kernel.org>; Tue,  1 Oct 2019 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0AgL25m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfJANsv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:48:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37758 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJANsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Oct 2019 09:48:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so9932313lff.4
        for <selinux@vger.kernel.org>; Tue, 01 Oct 2019 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63Z879F0idNmbzQ2MlB9mDeRU9jJ7ZJ117yeozx2VP4=;
        b=0AgL25m2TXRRDaVVqwvwa5mz6c338I4R6zhsuqWSgxyBYqJZf/ENlQzM8YcnXPt0Fa
         ig2YCGxr/9/eVhODhGeRt5Y/zwiuiPsLMO9S9BsmVBeX1gHG9GLHB99SZyHG1kHHD5bj
         nSJ7ERm1TW6dmv8MUqzaGkYFJBtCuWYV+uKraBjQvoW1NOxFEtTyYTCjL4B7i+NLdNKT
         q/quGH0I0+IwHbh95HYMZA/l3pu+UL7i2HfuluUTpjKGcLDFb4/wot3bU1wmy0A6g+Nx
         wD3boQQVKuH0QzBAAISJ7h0U2FB72V5REuRDPjICi4LCSI4Ya6jeph522ZKBGuy9sPVY
         sODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63Z879F0idNmbzQ2MlB9mDeRU9jJ7ZJ117yeozx2VP4=;
        b=ksZ/eC6esV3WLAd5p8njc7G1KO5SW/HKulh5E2PIsPELu0NwTGvL3a5PHWGk7j3MFJ
         bp9gV08qYkIpI56BAvV4G/hIofv4jGXcKAtPsejxo6dKxsaMwFg/hKg3SwpybknO1DhD
         jIswQJby6/eyYLyxt+ybBL9o3I/AZdUce/IOLSNZmpwR0wqLFk/kdLYHYdgmXGOUU/B/
         pF1zj7giX11BuKnPf/VzNMBHlW6klGCAknL9RMmi8zbBl0bJyxpWXw7CwuQxQCWjn0lC
         3vskJVAMUmuJI1cj34QOruQ0yvC0ve0VzeyohrGtYqvPxCKsquc8KT37nUs0Ed5Q8x3o
         R6Xw==
X-Gm-Message-State: APjAAAV4MYyEyCgGz94DHrz679rI7Y7kL4PPQtdx+gcUflAumab8+PjQ
        dd6nl9clybQ82aKcK+Wg7i8yY/TuVk62PRQ91y7KCNc=
X-Google-Smtp-Source: APXvYqyKpLaTHFb0r4VQueDks1DVLdSxHkWqiEqUeBlgCK3Mb0mRJP8slMz6SZ8FgBlHPf3F/Mu4X2MVXfh+qgphmS4=
X-Received: by 2002:a05:6512:202:: with SMTP id a2mr14677811lfo.175.1569937729156;
 Tue, 01 Oct 2019 06:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190912133007.27545-1-jlebon@redhat.com>
In-Reply-To: <20190912133007.27545-1-jlebon@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Oct 2019 09:48:37 -0400
Message-ID: <CAHC9VhS1tML2+cHM5K+ZMQp8ZsbwnbF0jWB_8sO9mTzozGCqnA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: allow labeling before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     selinux@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 12, 2019 at 9:30 AM Jonathan Lebon <jlebon@redhat.com> wrote:
> Currently, the SELinux LSM prevents one from setting the
> `security.selinux` xattr on an inode without a policy first being
> loaded. However, this restriction is problematic: it makes it impossible
> to have newly created files with the correct label before actually
> loading the policy.
>
> This is relevant in distributions like Fedora, where the policy is
> loaded by systemd shortly after pivoting out of the initrd. In such
> instances, all files created prior to pivoting will be unlabeled. One
> then has to relabel them after pivoting, an operation which inherently
> races with other processes trying to access those same files.
>
> Going further, there are use cases for creating the entire root
> filesystem on first boot from the initrd (e.g. Container Linux supports
> this today[1], and we'd like to support it in Fedora CoreOS as well[2]).
> One can imagine doing this in two ways: at the block device level (e.g.
> laying down a disk image), or at the filesystem level. In the former,
> labeling can simply be part of the image. But even in the latter
> scenario, one still really wants to be able to set the right labels when
> populating the new filesystem.
>
> This patch enables this by changing behaviour in the following two ways:
> 1. allow `setxattr` if we're not initialized
> 2. don't try to set the in-core inode SID if we're not initialized;
>    instead leave it as `LABEL_INVALID` so that revalidation may be
>    attempted at a later time
>
> Note the first hunk of this patch is mostly the same as a previously
> discussed one[3], though it was part of a larger series which wasn't
> accepted.
>
> Co-developed-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Victor Kamensky <kamensky@cisco.com>
> Signed-off-by: Jonathan Lebon <jlebon@redhat.com>
>
> [1] https://coreos.com/os/docs/latest/root-filesystem-placement.html
> [2] https://github.com/coreos/fedora-coreos-tracker/issues/94
> [3] https://www.spinics.net/lists/linux-initramfs/msg04593.html
>
> ---
>
> v2:
>   - return early in selinux_inode_setxattr if policy hasn't been loaded
>
> ---
>
>  security/selinux/hooks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
