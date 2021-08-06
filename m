Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B159C4320A
	for <selinux@archiver.kernel.org>; Fri,  6 Aug 2021 19:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D3F61131
	for <selinux@archiver.kernel.org>; Fri,  6 Aug 2021 19:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbhHFT7g (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhHFT7g (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Aug 2021 15:59:36 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02341C0613CF
        for <selinux@vger.kernel.org>; Fri,  6 Aug 2021 12:59:20 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r5so3158131oiw.7
        for <selinux@vger.kernel.org>; Fri, 06 Aug 2021 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5GR8Kcw4vSeUnf+jSEP8da5U92QaTOXrVNe6uJv9YY=;
        b=lWx3H/XAPEQDbGipyLdE3RZtDSaNOvQx9Wt6xC7fmT9DfPAWtgz4VtKVKKGuaAd5Rr
         umjlvxvLxnsFgQc4dkH9n9quX6Xa0x2R5sY245gGbBvSh4LCVd8dVFPWos7/8RXA8at1
         tS2uM48ia4hVoVfpU0+Sy6J6R8L7ji9tXL5jGxRF9wqmAzQdbj0njyQ2L4yNzWVcaRJq
         XZJOpxKzJGuAtF/huNmUM7wjJtSiaM1iwQglcnJv35RPIDxsxG3pvEx28e2HoAmctMUS
         YybuQbsVO9tVGMhoQhTX0PA1pvLuYtJ9/UCsvzM7WJ8hv8Yi9vXVYxeCLEhNvWqL+Vj5
         QmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5GR8Kcw4vSeUnf+jSEP8da5U92QaTOXrVNe6uJv9YY=;
        b=bYmimZLZs9X/MOfJN5M8TRfncwq8kNDyy6l1pCsXEEF2uDdrHIcbmujtLodTH3T3LI
         kd0TUuDN3LMEyxeIo2QAIIDhLwEYPmF21MUC0r8ePLbufpCIKgSFtOhRz5+KPYb5X/vH
         Qb0mVMERjhm8/j1j3+wUt/wEL6lNLKqMhYwmLAS6ak/94If9mRLEuAY8R4+qcJi01EJ2
         0cRTr4hanE8FAF32wL+W30US6Uertb1IfQ3lAFipJuz29LCRAAEZVNunbnF5SDhN7Dq/
         lR8N2orbd65lTCCdWfeJhBOaFi3OfsfEfs/TrKOOpVLNpNDXNhCrMMVjC+dCo+0ZY4J2
         NoQg==
X-Gm-Message-State: AOAM530yDo2NwxVbZmsekA5sJ8FFxTCDCluAETi1hdQ3MJh5aFwBLmgI
        ksttEVSctK3gnWlkcMuYc4xHsQdHOqJzxmBG8mE=
X-Google-Smtp-Source: ABdhPJw1Cr9Qkzoh5We1XzD3kzAbS+Ho2fvrorr+9bAnwRmh1YESEhhhX27UpzmbpqWTv3b14IieZtGjzFD40lSPTuY=
X-Received: by 2002:a05:6808:13c7:: with SMTP id d7mr12412606oiw.138.1628279959432;
 Fri, 06 Aug 2021 12:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210806083340.160333-1-plautrba@redhat.com>
In-Reply-To: <20210806083340.160333-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 6 Aug 2021 16:06:32 -0400
Message-ID: <CAP+JOzR3twm0Jg5EFsRP=2mzEdthUnwVv=8WKcXV=3zVzz+c1w@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: Improve mlstrans-test output
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 6, 2021 at 4:34 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Fixes:
>     trans: a:b:c:s9 -> a:b:c:TOP SECRET != a:b:c:TOP SECRET SUCCESS
>     untrans: a:b:c:T O P S E C R E T -> a:b:c:s9 != a:b:c:s9 SUCCESS
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  mcstrans/share/util/mlstrans-test | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlstrans-test
> index 085fa82ddd25..df34e0e67c84 100644
> --- a/mcstrans/share/util/mlstrans-test
> +++ b/mcstrans/share/util/mlstrans-test
> @@ -15,7 +15,7 @@ def untrans(trans, val):
>          errors += 1
>      else:
>          if verbose:
> -            print("untrans: %s -> %s != %s SUCCESS" % (trans, raw, val))
> +            print("untrans: '%s' -> '%s' == '%s' SUCCESS" % (trans, raw, val))
>
>
>  def trans(raw, val):
> @@ -26,7 +26,7 @@ def trans(raw, val):
>          errors += 1
>      else:
>          if verbose:
> -            print("trans: %s -> %s != %s SUCCESS" % (raw, trans, val))
> +            print("trans: '%s' -> '%s' == '%s' SUCCESS" % (raw, trans, val))
>
>
>  if len(sys.argv) > 1 and sys.argv[1] == "-v":
> --
> 2.32.0
>
