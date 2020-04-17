Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EFAC2BB1D
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 20:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651C3221EC
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 20:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Is9tZ6Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgDQUod (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgDQUob (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 16:44:31 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B7C061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 13:44:31 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s10so2449577edy.9
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6AuQdqYUKYqxX80Yvnj1E7DzF5xtQ/B37Pv5YeoYXbg=;
        b=Is9tZ6FjqINjPIcWbpqrUQIlfACdE9wMHdfDo8vYYvwTiwuzlEvid42kH+22yXVOIE
         NZ0VTcz7aXGp8qRe+8xuIYbXQJuCszBwXyxnlAGOrKGuNO9Px91cPYYkMRsaNQVUy451
         rfwFkqt6yUFFuutWVWWxSdozgy7vDCoEbuNd4cwzyj83QA+Q5iTx8MK8oAM0vHyCl6lA
         20Gvhob8bbzPfJjTjWZg6ntua0DajzJTvnmMDVGTvTrjERvu6iiZ7n7n/Y1oAEEzEbLF
         z4ZhY/gliWDwpttxJkTuPbAyUhSSBV2a53K9UtgY9oO8QVxPzCNqNikig6hoZsVwgijX
         MH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AuQdqYUKYqxX80Yvnj1E7DzF5xtQ/B37Pv5YeoYXbg=;
        b=dl/BKRckcq/FhwYWDCzsRpaP/EEdgEi7pADv/7IoidFSIq6t7l2UMr4konIb8JzdTw
         bxnhbyBVZde7p5yyjtwzhW0wRTPVcLQLzMpRMx+XUgKZbs4iXCDyAySCYhOggoafFclj
         ZbHKkYuaEkpC/e7V5ddjw02nRjX4XPtV+xl7LN8pjSYmKyZpUoEua1eR9oQfr3ZI+5bu
         WJhwP6rYLcbM4avvZy3KWyEFNB3K2Aq+N19PosdzO2/GoHMydLojDXIdKuZQasyzBpUH
         AScdd41BYLG0rhJllRT+vzwY6wMQqBYBZL3i4R/zLCkrp2vzlST5lCjiKSxFpgDtZpvF
         NLpQ==
X-Gm-Message-State: AGi0Pub8au4fvnhtsDbY6B+pxZG5dul+K9wknACsFovH0d+aoQWFdBms
        NhezhLHpLAxD/q/XSN6hhoQPuZoOMBXmlKC0+siq
X-Google-Smtp-Source: APiQypLZcMuPKXSfit9ap3cPX9eRKB2IBd4dtM9vDAwhgi7owSuk2LRVzH8wXHAOx7whZf/MFerUJnexwl7rqYopmRo=
X-Received: by 2002:a05:6402:1b0b:: with SMTP id by11mr4817446edb.269.1587156269676;
 Fri, 17 Apr 2020 13:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200416171355.560244-1-omosnace@redhat.com>
In-Reply-To: <20200416171355.560244-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 16:44:18 -0400
Message-ID: <CAHC9VhRESpKxZ=9j1q7B347LrLMdD6aWycq7_NT36nSYtrEbLw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: implement new format of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 16, 2020 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Implement a new, more space-efficient way of storing filename
> transitions in the binary policy. The internal structures have already
> been converted to this new representation; this patch just implements
> reading/writing an equivalent represntation from/to the binary policy.
>
> This new format reduces the size of Fedora policy from 7.6 MB to only
> 3.3 MB (with policy optimization enabled in both cases). With the
> unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
>
> The time to load policy into kernel is also shorter with the new format.
> On Fedora Rawhide x86_64 it dropped from 157 ms to 106 ms; without the
> unconfined module from 115 ms to 105 ms.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> Changes in v2:
>  - rename the read/write helpers
>  - move update of filename_trans_ttypes in filename_trans_read_helper()
>    to later in the function
>  - make filename_trans_read_helper() count filename_trans_count
>    correctly
>
>  security/selinux/include/security.h |   3 +-
>  security/selinux/ss/policydb.c      | 212 ++++++++++++++++++++++++----
>  2 files changed, 189 insertions(+), 26 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
