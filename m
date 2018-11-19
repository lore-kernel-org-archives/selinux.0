Return-Path: <SRS0=oFG+=N6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD189C43441
	for <selinux@archiver.kernel.org>; Mon, 19 Nov 2018 17:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E02145D
	for <selinux@archiver.kernel.org>; Mon, 19 Nov 2018 17:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="fVfooWYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2E02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbeKTEGs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:06:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36586 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389109AbeKTEGs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Nov 2018 23:06:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so14242081ljk.3
        for <selinux@vger.kernel.org>; Mon, 19 Nov 2018 09:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxOh/Kq2LudQsweFavbueZSYEY11oSWsDa2eTaGXTOI=;
        b=fVfooWYdDwBxBEu4Np5t3noyx9cB8EA97Kw8aLUInj6qGZ/K9KIzaXWnr2fBjSx28M
         5xjgd4+mJW+ooR9CvIRVxS70mYNBAV3m5qoYV4ERqNtMwIvPsVejExp0tDBOPJv13h8h
         6czDAnE9SsMX+Fo2FPTpiUHDlrgNfDkicxFsKAJawON48fikZiKKsCw3+uTCvYJGoubi
         Z/n2rkLreU6MKUXuDo1Brgs+V4O+yVnDNc/U6vAoZHcg2By8np6dV7FPjvA+Ya+SmNa5
         KVIAd/JftNMSxB90PFq8OtDf22Ixy4nH98KWungdSzTwO6IJs/6pWOsy9fiprXXaf+WR
         SBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxOh/Kq2LudQsweFavbueZSYEY11oSWsDa2eTaGXTOI=;
        b=ujUylHMe+OS1B93phZV9IY1r7jTsx7BdeizouIE6hebBAL5BRenTDdDGnHsax5KbM6
         8EX3ig6IWst82Fbji33SUZAcS7hTEUFI2jt7USDQTOuOB45bYQi/qPQapGE0xBjtusX2
         C151Hpnec/yqCDTyHQn1Fbl0aGSXvraFKSpBqsLQYgeua5HQ9K/Tc9nMQv3UA6zKDSc9
         xsWIx5HU9I9vkLgFYNAl2rnqj5A63ffjkG10fW3B5JzVGUbVBSa8s5GhNmMi0w5NIDPF
         kk7Xe8N5KHCwvPZ77Z8wLhAsm4MYAtt/U5kUVTauJYliWvWrj5HQyWdL000/YQ2/DfKJ
         v07Q==
X-Gm-Message-State: AGRZ1gKfLb9AJgAsf8KMuVb/Hp0ADXoO7YsgTE2SA1pF7Rz4zMbZCiwv
        Ngknds+WMxqpqMH4nhlml++VCELyv4Q5dCIztLfn
X-Google-Smtp-Source: AJdET5db0SW0heggfNgseRNGu0W2bLcRsb1TjTtzvlDyGNrZP6zw1szVqoBeN+7/SJdIHdzc0wrmcgMa7wO+595lWIw=
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr10163923ljc.77.1542649337810;
 Mon, 19 Nov 2018 09:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20181117062555.11962-1-pvorel@suse.cz>
In-Reply-To: <20181117062555.11962-1-pvorel@suse.cz>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Nov 2018 12:42:06 -0500
Message-ID: <CAHC9VhRDuxs6bYVYBf0o4KkwrLUwzApGofWi8=gpzaJzE9H=CQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: Update SELinux reference policy URL
To:     pvorel@suse.cz
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 17, 2018 at 1:26 AM Petr Vorel <pvorel@suse.cz> wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  Documentation/admin-guide/LSM/SELinux.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks!

> diff --git a/Documentation/admin-guide/LSM/SELinux.rst b/Documentation/admin-guide/LSM/SELinux.rst
> index f722c9b4173a..520a1c2c6fd2 100644
> --- a/Documentation/admin-guide/LSM/SELinux.rst
> +++ b/Documentation/admin-guide/LSM/SELinux.rst
> @@ -6,7 +6,7 @@ If you want to use SELinux, chances are you will want
>  to use the distro-provided policies, or install the
>  latest reference policy release from
>
> -       http://oss.tresys.com/projects/refpolicy
> +       https://github.com/SELinuxProject/refpolicy
>
>  However, if you want to install a dummy policy for
>  testing, you can do using ``mdp`` provided under
> --
> 2.19.1

-- 
paul moore
www.paul-moore.com
