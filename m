Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5FBC3F68F
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 18:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45675206DA
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 18:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1t/J2mZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAGSAb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:00:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36680 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgAGSAb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 13:00:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so528889ljg.3
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJmb1LPtGlsUIbaPpyHrumTKVXFFE8HlB/tf6eTEZcU=;
        b=1t/J2mZzafDYbWuTv41UUD5NfzZLBqOZbagzyGc06XsuE1sAIjDK7M3C+rVJAx4JhN
         XWEhBwoO5zpxAGdKSXr2psmV4XjOy3dlh4oBM/Wuj7VPHQ5kaDOBKMaPcjlZmTMtCKVy
         NRdf5i2NvgPqIVJJ5tvExbOLDVRsyZShGvI4PrbZWceAyK08o85Pi79LymfyWj6figtG
         5QYJrjjlsxvExtR1uZRbUepiHGkPNFgMKJMZ3C6H8dT1XnkXtcu5zZAvQDPLb0hZy+ae
         GamdWoRMtg+GvSt50q/WoT04cobzNe3l5kihnyDSRge38IkgkGn4H1lHKNqNWqFMBFGu
         /x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJmb1LPtGlsUIbaPpyHrumTKVXFFE8HlB/tf6eTEZcU=;
        b=sPW+itl+Zkv/e75Xyf3D1DMyxnksOZA7Rfa70yE8jhqTFJMXJRpaDyeNNcd+Ohi58c
         a0BIr1cFqhoqlQA/kHPOrMlwLvtjfGTz0BMmWAYPu2F6Z47Bzj8gzIYROK414aUei50o
         cD0d7UvAX6rVighM/GFyS3nX3CQoagU60v0j97C8u4VhAqtCb8eUBFe9o4xWvMQ8JkgS
         Gtxmu9eMMYiKJhSVXVb8dBm//sa2Mv9v1ey6ei5aZGXeQ/TWUkCeD++qY5wSnnBR7u+k
         0Al7aFoBuVLOoSQs682Y6yA0TNwp+loXcFdW0I8oqE7jt//nQ0TSzq7Qk1DatNq2JIgu
         sXQg==
X-Gm-Message-State: APjAAAXlnLU23Pd5Lyn1B+AbRBarnkYdNSOfmHCI3KGq+0v8IlIz47Vi
        ikACmqw/GulA7fur9cXXXxUgJ4vSaBKQKE1CrrUubiI=
X-Google-Smtp-Source: APXvYqz/AHViVwt1HtM3LgJ7uTjgXPG6t8RJmQgcPQu/FxhT5MudxLwLxoFROgyW/yHVOUZNkQFw4uaWkDvw7IfWWlk=
X-Received: by 2002:a2e:800b:: with SMTP id j11mr389528ljg.126.1578420029415;
 Tue, 07 Jan 2020 10:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20200107163504.29769-1-sds@tycho.nsa.gov>
In-Reply-To: <20200107163504.29769-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jan 2020 13:00:17 -0500
Message-ID: <CAHC9VhSyKAunHH3EhgjBpkahrwh=a5W_TJFmJY3p=pigwENOkg@mail.gmail.com>
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

On Tue, Jan 7, 2020 at 11:34 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> selinuxfs was originally mounted on /selinux, and various docs and
> kconfig help texts referred to nodes under it.  In Linux 3.0,
> /sys/fs/selinux was introduced as the preferred mount point for selinuxfs.
> Fix all the old references to /selinux/ to /sys/fs/selinux/.
> While we are there, update the description of the selinux boot parameter
> to reflect the fact that the default value is always 1 since
> commit be6ec88f41ba94 ("selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE")
> and drop discussion of runtime disable since it is deprecated.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 ++++-----
>  security/selinux/Kconfig                        | 7 ++++---
>  2 files changed, 8 insertions(+), 8 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
