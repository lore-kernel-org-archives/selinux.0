Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90FC433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 01:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FED207FB
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 01:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BuxExy8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHTB2V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHTB2R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 21:28:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F83C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 18:28:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id t10so669572ejs.8
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 18:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNDIxwQJGjqcWm6fUat3pUhzu+PCRgyrBkqnSyNPvHY=;
        b=BuxExy8FKg5pQmT+mdbfRvRB2oUREZ19ePl09lMEyvc9xSemdW6tb79vTEX64c7Pvx
         OehhKdAVzFgGU/+NJZkb/itBhBJGX9mpR1Cm5XQkHU/4iCEEtDK8x5D7JFDYt0LkZUkv
         4elnZrIlXQKThW6N9BofzaOLojEd6wv55WZTxU6hYp+4+lKWkM84wFRm3PAt8NPMvHGj
         edzSJPihD0MEWMb61camgAtlEv/aBp7DaOQj8GFsMn14N3wmrMjTQZVZkd+3vGQiXQuT
         JlXcCEQLJ/9prbbQO6/UhkwbYuVlovWzyIw03PmCpU3gwwEgmegjWid1DlkY2Ey9PoQd
         dRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNDIxwQJGjqcWm6fUat3pUhzu+PCRgyrBkqnSyNPvHY=;
        b=V3HvnKltZbyNm26QuXiv7GdHkQKSSUgv9n7RzGRsRnOmO36zVjHActaRmQ13/6s05t
         8Es8c6AJ8XY3oR1csKLds7a/mikTMhAWmCJrcNWOvs/0NgmXVvb2sjIbCn09EFKlKq1M
         4k3AP/sjgSlwA/CxT4xxAjCLXhvsV+SiAnKM3ogA8TKYY9DVkkQtQjdVckDZqwHdMJCK
         mjkQjyiEUHmIfhr2zy8pSBlte6GrXW3/8gYJJpqYN+sk/DjggGIbeq/SZ6Re/kGkLAlM
         YhLOQCvkd7EJeyfSpxVlyv9CGWQvYs+ksLHLv9YdO6dupweLUtk+TcAMSQTPFaK6Y6uq
         mLHw==
X-Gm-Message-State: AOAM533BItFGJNSydD4wM2eAFA+wteXV9pEPy/aJBP92tKjwe+sbAnWG
        S5p7RfrqUHwDXp/iXB0/omZ9rDULN5Im7X7i6eD2AegQhmV/
X-Google-Smtp-Source: ABdhPJwq71I3WwoAZ1XBcHD1M3rsernoz8NYxrQLGCPxoT6Ooj/+m9NPxJ1HalhJe0iUXqfbPIUUDNQYtbnm+VkozAI=
X-Received: by 2002:a17:906:3390:: with SMTP id v16mr1023937eja.106.1597886895654;
 Wed, 19 Aug 2020 18:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Aug 2020 21:28:03 -0400
Message-ID: <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com>
Subject: Re: working-selinuxns rebase
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 18, 2020 at 9:37 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> I did a re-base of the working-selinuxns branch on top of latest next;
> this required manual conflict fixes due to the encapsulation of the
> policy state and refactoring of policy reload.  The rebase can be
> found at:
> https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns-rebase
>
> It boots, passes the selinux-testsuite, and passes the following
> trivial exercising of the unshare mechanism:
> $ sudo bash
> # echo 1 > /sys/fs/selinux/unshare
> # unshare -m -n
> # umount /sys/fs/selinux
> # mount -t selinuxfs none /sys/fs/selinux
> # id
> uid=0(root) gid=0(root) groups=0(root) context=kernel
> # getenforce
> Permissive
> # load_policy
> # id
> uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:kernel_t:s0
>
> All the same caveats apply - this is still not safe to use and has
> many unresolved issues as noted in the patch descriptions.

Thanks Stephen, do you mind if I pull that into the working-selinuxns
branch in the main SELinux repo?

-- 
paul moore
www.paul-moore.com
