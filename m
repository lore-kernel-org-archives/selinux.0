Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D61CC33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 20:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258920663
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 20:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PE1pkDEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbgAPUPl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:15:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35429 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAPUPl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 15:15:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so23990752lja.2
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 12:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=TY3z42Qo9nt6JE8zMG1wmEpmiBdOFuqQ/0DOEEjOlGk=;
        b=PE1pkDEVXfHWQCtrcpA+74ys3e8VxMIQ5FSyuK3UNVwKb+W1Bfky+DwT9tKkUlr51z
         bdKkarvtacrZ2SXlGn+dDLQFBRN6j9jrTbH3aimXIJ42fEWutjHBZVSY7WvWuAZeQ0GF
         M2qpoDQCwU9aTFJDH0zWG+kxRgljCGAk4/c4dLxy+8DxDHPzbiO51khB+QO7Yv7ZIn1m
         BTUEsd4ti3AhJH0meiAz2NazT814kR30BihvSO07rKhA17/ojbmt6aDBSaJj6YgZ/JL1
         iv8WzFP9S2AD6tBYI7Y+j4wcZNupRYhUQarsEFRyET1JRrZRHQH0/y/33J+kDZ5yP9j0
         MLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=TY3z42Qo9nt6JE8zMG1wmEpmiBdOFuqQ/0DOEEjOlGk=;
        b=b3ICwPxigpwXAMu4P/0SEFrN+D8ypCfaHGqEMJhmzja6PIGOCuQgoQGqvLNs3AcEOZ
         xyKsAP4UKCeTmkbaBvIhairJeCOFe0eEGaBdLSnERw2W8DHT8Ir8UeH1bTJB12h93VaF
         YqgxK2GtvyZn/fi323AD5SbfWjBFjq2L8tPujrBpmPhbM/SwOwmdpvd0XGK0ZFuHBI35
         qakgN18p3WCpHD5jgGDEki6KDlQzCZeOe+Nf+GP/gda3w3JG0lhSI6Q9APNahbIGnl4J
         MYtbCZ+i7EC4ljLNjNSFrVwJL/WwA9PAwe8DsM+iWdyE/XKbdz8XDsxJjDx8k/YVLbqR
         RjqQ==
X-Gm-Message-State: APjAAAV/sMLn1eOdZ9I/B+032xiJBmbKrU9hhNLvAHsK8hpTDEdzzpA3
        SPc+THDehiEwfaThP9y7rDqTABkxVZEIimI5y65+Z1c=
X-Google-Smtp-Source: APXvYqyGLbYsA0kTQdAB4yD1Nad4wKX6JLrSbd09+WCj2FupKBf8qdVjUYCrijl+BfU87HxQ5wljplCc47hhBZQPslA=
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr3505716lja.81.1579205739075;
 Thu, 16 Jan 2020 12:15:39 -0800 (PST)
MIME-Version: 1.0
References: <157869192997.484726.14884768578207909170.stgit@chester>
In-Reply-To: <157869192997.484726.14884768578207909170.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 15:15:28 -0500
Message-ID: <CAHC9VhSREpGFTj-EwUqmLNBB9NN3py+nyOCfXM=sn2jKmzwj7A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: remove redundant allocation and helper functions
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 10, 2020 at 4:32 PM Paul Moore <paul@paul-moore.com> wrote:
>
> This patch removes the inode, file, and superblock security blob
> allocation functions and moves the associated code into the
> respective LSM hooks.  This patch also removes the inode_doinit()
> function as it was a trivial wrapper around
> inode_doinit_with_dentry() and called from one location in the code.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |   94 ++++++++++++++++++----------------------------
>  1 file changed, 36 insertions(+), 58 deletions(-)

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
