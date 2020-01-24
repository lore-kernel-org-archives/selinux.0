Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF844C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755D32072C
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bLsgAV7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgAXVTQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37476 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387394AbgAXVTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 16:19:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so4086596edb.4
        for <selinux@vger.kernel.org>; Fri, 24 Jan 2020 13:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vsqs0fWIDBB8ThjhRkCXrEX4Hjmrg22RNTgM1A3c9c4=;
        b=bLsgAV7ya3bYncqjLyPPekJFbgnXb+6oRjUbJGAT+ffcLAoZ4/l6Dje3unUx3Izomk
         HQzBJRGy5x7Lw7VfesNcJi26J/hihTPSGd8e/PbViZcJE6w7zNFde9uvMOLnnkb+77IC
         xgatK3VGPSoVahWikeGi5xbzGvhYNgS/bgajP7urU09XTEBTgSltInoZT9b+V87J9qzT
         OEZ9+OHYsZE1fe/6bMpOyI+AVpAnPOP9b45scGI5WnFLXtjZueQKDTIJSzzJzfmXdhp+
         tPwkwAyk5qWoeCNJt0cONiHqoVJhsv+2IR0sWgqLlIk2oUpcyrJzAX+3fgmnFS2WODsh
         29LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vsqs0fWIDBB8ThjhRkCXrEX4Hjmrg22RNTgM1A3c9c4=;
        b=dHNOdn/6pxshxW03JkJqHfidv3rdbnwMS2mh5nwAKA1xdVEPK6r4Qtz6ns9/OUujIE
         LeiCyMQvXluHkpHWlpF47vGTwNWCWxikTAW1EBltAN0B2IkRcIpDTBVsfSkMdm8MjsHT
         p78aoL5oTHvXNayJBLY4VJNirk3WK3vtQOvRHD61maRIEgabQtc4X/omVK4kj8fyJxa4
         jzGV/bnW7IOdorolL4WnyVoSlgqf2z1/hT2kthnzwqjF9o2rt7+Xn7sDvoBRTnU6nA2t
         PT0tHRpIygSCKAfOZDnAGEAY1WsSre0U9l0YqmcAIGp2MKBTizlLH3q2919vzKpaLZS7
         lrXQ==
X-Gm-Message-State: APjAAAW20F8uAPq3UjZnWhE/YEWLeGqlQjfuFvn8HoHMLR2M7bpLitJX
        gtBl+WqWn76jY/AmvTE9+UdHfApeCmZ0TbELcwUqWfSe4w==
X-Google-Smtp-Source: APXvYqwG0oFFgKyxl5ldzKbiqMrQbyXWodlACJdYhtkQmuf9G8JbZFJwb6wOF5V4lrBMSE6I3xHjVxMcbFXbxIv9IyI=
X-Received: by 2002:aa7:cd49:: with SMTP id v9mr4416202edw.269.1579900753545;
 Fri, 24 Jan 2020 13:19:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhR=SFfWz6OC72fBw=Y9+6LpkZg-ZY=2iZzF-0-QLAedhA@mail.gmail.com>
 <CAHC9VhS3D+nr=Fsnn06m8ts=aVxSPRPbPQ=ce8NWnOnf-0eG9Q@mail.gmail.com>
In-Reply-To: <CAHC9VhS3D+nr=Fsnn06m8ts=aVxSPRPbPQ=ce8NWnOnf-0eG9Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Jan 2020 16:19:02 -0500
Message-ID: <CAHC9VhTw2cZQEt+HJcSNa6wo4NKdmc_zJxbMH5O9OPM3Qi1HWg@mail.gmail.com>
Subject: Re: Problems with the selinux-testsuite and GCC v10?
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 23, 2020 at 5:10 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Jan 23, 2020 at 5:08 PM Paul Moore <paul@paul-moore.com> wrote:
> > Is anyone else seeing the failure below?  I haven't dug into it too
> > much, but I believe it happened when my test system was updated to GCC
> > v10 (Fedora Rawhide).
>
> Aaaaand nevermind.  It appears to be a legitimate problem with the
> test suite, expect a patch shortly.

I was just bit again by this bug while trying to build a test kernel.
For those who are interested, it appears that GCC v10 changed it's
defaults and it is breaking a number of existing applications,
although it should be noted that these were existing problems that GCC
wasn't flagging as errors.

* https://gcc.gnu.org/gcc-10/porting_to.html#common

-- 
paul moore
www.paul-moore.com
