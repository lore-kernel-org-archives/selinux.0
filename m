Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA1DC433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA0464F01
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCROtz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhCROtt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 10:49:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09CEC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:49:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j3so6970878edp.11
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oE5uyfmrko08DmAeHbb/S3y9wtlUwPAKh1h0OcpebRA=;
        b=OpKrJzNuwY86JtyVimcQVLv7ErYFcCx0XnzNss3f630/phieL8xW94frdV8ZdUFUDu
         +i5fHbV6x03aYaBIPdsLjBcblv9PhIuxcZr5jVoacCI0jV+z0Z6sofaXjFTZahHVN25C
         99glXNnGc0a38ISP4UwiEy6hqFwYEdP7FHWOosva44JRW8bNhBL6jT/opT+Zg5oJUQq5
         /dO5LZ5F+nz0lb8yXk0e4phYLPUqSuIs2VgGdDUNhjq6WkATG8N4YVeDd3dlOTB7EeOz
         BvL6XYi07uXLCMLLYPJfZzPT9PdbXjvPHH/iQK9qb/2zYE7eo15E6TpuU8SPsr+MZ5zn
         jiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oE5uyfmrko08DmAeHbb/S3y9wtlUwPAKh1h0OcpebRA=;
        b=C0muf/cD8pUxMDLKf2nKgY9Bo+jIWMF2s8ijFPz5okBd3NnUNlY9EG/HBx1YO311w7
         mHBQvFjxmwFe2hD9FksXD/hSqb5qcQDNZYBakWAVXJxy9OMn7t4LSQjeDgQ/7av4b65t
         9giN5XqOzxxAJDzqtbUG7o7GzUK5avWUAuUHfig2325/MgFfX2Xo0ExwBJ0PUN5Ljanw
         p8c7s0GdDq6UimB/f7Rrbo3lVgRgL6oMdXmaRytc8vwJVkKorf+0rO6L1Bx64QVTYjpI
         jzh5mVlbq74jurUl+i2jbhOU36z1c8phinBuuYJSAjzUCilz94Y+lDC7dw9eWiVVD+KA
         AKnw==
X-Gm-Message-State: AOAM5308MkVVsEcigSWfZsj/nJIJS45LrhFgzyGmRLUFKO0eXvHDoMm1
        bHLzCsOYYHZ4JriHJta8HdP8VlKW/0fKgwAd/6nK
X-Google-Smtp-Source: ABdhPJwiEIABBd8KQlYSB6H074dZfwokcaA571e4mNhQOql+j3NWMIJwv2jNT14IjZuCwZUld360WeIWpAZXa6yhg9o=
X-Received: by 2002:aa7:c7c5:: with SMTP id o5mr4095814eds.31.1616078987645;
 Thu, 18 Mar 2021 07:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-3-omosnace@redhat.com>
 <20210303025730.GI6000@sequoia> <CAFqZXNtTV0PS26MYXO3urLvNYiaV9mG2kNqU9+syAnJCPhZ2jA@mail.gmail.com>
 <CAEjxPJ43MY28wXbQrXNZSaAQ-OaLa6q4VRje61WSUXjWfmOimQ@mail.gmail.com> <CAFqZXNs9U30ydS76Gw7A2m9v6F6XdPgc2F8HmOyHfOhFt+w1JA@mail.gmail.com>
In-Reply-To: <CAFqZXNs9U30ydS76Gw7A2m9v6F6XdPgc2F8HmOyHfOhFt+w1JA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 10:49:36 -0400
Message-ID: <CAHC9VhQK8=RbJJv3ADRmajNzmpHcK53mkN3vnmMjrwKVMn2jVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix variable scope issue in live sidtab conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 7:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> No, I've been waiting for a reply regarding pr_warn() vs. pr_err(),
> etc. on patch 1/2 (and then it slipped off my mind, so I didn't follow
> up...)

Sorry about that, it looks like it was a casualty of my inbox.  I just
replied back on that thread.

-- 
paul moore
www.paul-moore.com
