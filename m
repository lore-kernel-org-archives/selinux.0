Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE25C433EF
	for <selinux@archiver.kernel.org>; Tue, 25 Jan 2022 22:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiAYW1P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiAYW1P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 17:27:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB2EC061744
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 14:27:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r10so34889447edt.1
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1BiB0LlRhrBnkIdJld33ntWmu5J0JJj0Fcrw4TDuSI=;
        b=codcubGyPRRa9Co1DwYI2ifTPo2sxWpxhfC162hwvfv0Dvj34aQMGqFZRV+Fb2oImP
         YpQ02SJTC8gYN4g1JmYjUiqx+ZGdRf3JxCvvepEPZ3YpTdzCmnsRqP74xG00slnsfB+u
         4xuSx8u/lS9VDpfe9MwjJKJneITNky/Le68TZyQyLDyUH4T+w+PWeJ8Igu2HT5b6VpEl
         cfIkvq3BZdEDsTfy/SW7uKUQAsA5A7Q0VdZ8kkr4a+Yp8jpTMnbe+KebgjevbzkM5X3l
         qpJbeaR8+ZXrHfrkX8i4u7kjQOIV0mBbZjfbgS5QSZSt7U+d7952i/y2bjS3bwCWniS9
         NqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1BiB0LlRhrBnkIdJld33ntWmu5J0JJj0Fcrw4TDuSI=;
        b=Hkzh9Djg8AgJEPiVLa8RhsXQRfI3i27xQnUaINQ6wuhz1YMWKQwCH+uYifAATfxtgV
         3Tx6kN0LXy7KS7/JHI5+ZRDBvNnmvwpujRO0P5E7Zd9OiYXeDzgu9ZOf/DXOUQqzdjcA
         Ml3SQV9GfodGEH81RM7iEbzEWBb8LQ7Rvq39uGC0+UVssNO2HMV0B4ivhDvhPjSCgvJN
         Uja74OTOQqhW2UhJeHlezoP/qVLt7qEK/EdBevvzu4xfwoBGzjSdnEcM0pnra4gb87xA
         yke+IS8pRWX2JZ5YqOI3XXmuOX18LaFpmMIoEUuWQULlnYUM+QgjPKD/Hmh1n3aUkhQ/
         wKlw==
X-Gm-Message-State: AOAM532I3jMUyWTeb2drxAlj1Y088RiC27iOoFUCrrfMbaQ03qMJVHFs
        Oqo6zJxKowTtQVkO9/1tkAGPZu65K8vkpo1hjl43
X-Google-Smtp-Source: ABdhPJyMnhB7AjQM90R3rAyHkw09pciULNZQsSRVFJsPjgGXkMK5fv7dlJ9igPXCWWBfuR6Qb8adl5BW2dDLMR1lkNk=
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr21939603edf.343.1643149633597;
 Tue, 25 Jan 2022 14:27:13 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
In-Reply-To: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 17:27:02 -0500
Message-ID: <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Demi Marie Obenour <demiobenour@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
<demiobenour@gmail.com> wrote:
>
> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> descriptor being leaked to a process that should not have access to it.
>
> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> ---
>  security/selinux/hooks.c | 5 +++++
>  1 file changed, 5 insertions(+)

I'm not convinced that these two ioctls should be exempt from SELinux
policy control, can you explain why allowing these ioctls with the
file:ioctl permission is not sufficient for your use case?  Is it a
matter of granularity?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4fc29..8f3b2f15c1f3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3728,6 +3728,11 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>                 error = file_has_perm(cred, file, FILE__GETATTR);
>                 break;
>
> +       /* must always succeed */
> +       case FIOCLEX:
> +       case FIONCLEX:
> +               break;
> +
>         case FS_IOC_SETFLAGS:
>         case FS_IOC_SETVERSION:
>                 error = file_has_perm(cred, file, FILE__SETATTR);

--
paul-moore.com
