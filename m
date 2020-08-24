Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B014C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F38C204FD
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0y4Ba2VM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHXNkZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgHXNkV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:40:21 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7DC061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:40:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp2so6669094ejc.4
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lFqzXVui1Cn5nLECvinag9ukMJc6SSggU3UKfE/7q4=;
        b=0y4Ba2VMeQo7JVcVCMql1LzKedF6EQ6WN/zRrvBAEGVLDK+Wtme9uvngOs1jAGaZzu
         pacPo4RmB0SRlUfCFFeZ4JW1nMxhjFnW34Wjfiy7mIRZ9MXwIH9jnMw+WOzadLl1ZmJ2
         Arfya/B7LBLujrLBufS4aYjss7sSEfXS2aq5uLPxqXCy7mxQIUi+U2zEm5mDjr/WdOne
         TvlmUqud5LjDJHuibqAS/6BLc0s2zy7rmqotvjjahLHXCsT0zm8LsNDEzUarXBIyQTra
         NvZ/6jBpWMByEkHMk+SB+MjeOyNIYY9erepeOTKfqvA736qB9n7w8cy30qgEfpRYu8PO
         XIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lFqzXVui1Cn5nLECvinag9ukMJc6SSggU3UKfE/7q4=;
        b=Ph0w36dD5Tu/8/LV+siSduPT9HvwgcN4FNDmhSBAk/MfGOtr9uxABfpBRAwp1rI76Q
         hZjn0E5q0+A5PpW8j1yC1RQ1YVZuQpCq8jIGFhunEuprH55UHzLxfosv7gx23GjWRlcM
         Gu5r19Ru+lEXFd3v//JNgwUYnwxFhZbzr965vaAD/S/97erhRDYHOlvLNOWfYxVTymvK
         o0Z6Id3L8zRKCP4ese/UyJ6OLDfKdfQvwTYaz6O4/pvPG5WAtoRsh5IjtmfYQUgUJ9se
         1U+I6lkMPFjCN49ku/Tl73uyAYeLp5tQbLPd6VIg4ktGnaFc6FzAGwuK/DTMKOimW4al
         xcSQ==
X-Gm-Message-State: AOAM531KpKXDI09Mn7pAu5iCsA46n6UrRBlnvHHYgv70nQDuanwHzcoW
        Qw6omn8Fw0mRvY8dAcvhZIvxaLQgwmqLG8fjm/Ys
X-Google-Smtp-Source: ABdhPJyxxYA7RnmYgRYAJY88ZHhWrIhfoHvYnaRRobxU2CThX5y1E7EKcqGFA0miK8k4VfM+nXrqkOLUPC1IPEyhfug=
X-Received: by 2002:a17:906:7c46:: with SMTP id g6mr5494873ejp.178.1598276418527;
 Mon, 24 Aug 2020 06:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200809162212.193739-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200809162212.193739-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 09:40:07 -0400
Message-ID: <CAHC9VhTP+A3mGO_1nVz4Q-WtEBNubAGO_gysR7L-_OOqFRazZw@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: Convert terminology.md to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 9, 2020 at 12:22 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/terminology.md | 349 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 243 insertions(+), 106 deletions(-)

Merged.

I wasn't sure how I was going to like the changes to the abbreviations
table, but I think it still looks okay and it's more consistent with
the rest of the doc.  Thanks Richard.

-- 
paul moore
www.paul-moore.com
