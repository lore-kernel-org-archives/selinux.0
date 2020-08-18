Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6CDC433E1
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 00:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6632078D
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 00:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZomwOJLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHRAzC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRAy7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 20:54:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1072C061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 17:54:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ba10so13884943edb.3
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 17:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vY3OPjexIW34NRO7InX1GnhK4jfBNsha/VlFKma3KZ8=;
        b=ZomwOJLAtvWVw6q8+BKYylvAhH0I4U0op0LNZRZPEjN/PfG1C7cZAZjvEjDV96KBxZ
         u87NbnCYR809vKlUsvtfU7lqqEu9tef/v5ivtUZzpBVeg8pmLWn7XS2Iga8LGdg2Fz7u
         ZrlhUmq3HyN9LR+lMpOL1yFdPrc3nn+pmFFT5qJoUrZQbI0aZfewPJTmMdEEAfuf0UBc
         WxBEfPv2YRUmajpd71YnXpaKxnTz++8lohFXuD+SQfwbJm6N92MArVFMsvi2qhC22LLD
         VDWDJWjDPSQo6ZWJdrUls3InGfSZevhLLN/KP/jI5zpZk4TiSD4W0ugIz6KQ7+QOJuXs
         ZQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vY3OPjexIW34NRO7InX1GnhK4jfBNsha/VlFKma3KZ8=;
        b=VCf/f6YgHB4YSLnqMtcfwlLuvMOM1+oB42JuWD8V/LBtCPsT3b0Dbev70M2/RzvosY
         L0XL8Aa8n9bbrVet9fUiifAYIPQBnT/h+aGuCYL9CcgS4o9u/XtvoOoqcNiFLqHDE8mZ
         Ye7cQQkITASQtCcTmA0YrMcq3GfOKcfOmqXV1/zTatgQ24yTVMYfO5vUda9ITZn3eXBR
         7eqoddIoY1C7tcWMDwpz3Ln4W9uzbFqYVIWgEDgR0BSuGFBcNuvJz2Mun5c7mZFV1kTj
         Ya5Gco7VQtOb4vNmHS/buRaegbpLtgy2Z1KoKm/RlPb8VordYhJltNCxGICw42zBmDoX
         ZcuA==
X-Gm-Message-State: AOAM533TLvlo0FudC9Bbtt00toKYNpZEpvNE18CLHMkjcpKDszKOKxy4
        cxJ0BOpdEw/1j7jA93CHCi5hsYGYUNp6ckWUlB6D
X-Google-Smtp-Source: ABdhPJxlimiZrV0D46uvbnbGkzhrvUHSWJ3rPZk9AluBeIJFR8x5VaGsvCCvIZHZbsAGHFxSvc+iLyczUOlBy6/oRcM=
X-Received: by 2002:aa7:c383:: with SMTP id k3mr17088902edq.164.1597712097166;
 Mon, 17 Aug 2020 17:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200807132934.61002-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200807132934.61002-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 20:54:46 -0400
Message-ID: <CAHC9VhSnAcDWBgrKCyvBH69GFR2bk_r5teETBwpr=FLKNC+_Mg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] selinux: encapsulate policy state, refactor policy load
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 9:30 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Encapsulate the policy state in its own structure (struct
> selinux_policy) that is separately allocated but referenced from the
> selinux_ss structure.  The policy state includes the SID table
> (particularly the context structures), the policy database, and the
> mapping between the kernel classes/permissions and the policy values.
> Refactor the security server portion of the policy load logic to
> cleanly separate loading of the new structures from committing the new
> policy.  Unify the initial policy load and reload code paths as much
> as possible, avoiding duplicated code.  Make sure we are taking the
> policy read-lock prior to any dereferencing of the policy.  Move the
> copying of the policy capability booleans into the state structure
> outside of the policy write-lock because they are separate from the
> policy and are read outside of any policy lock; possibly they should
> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
>
> These changes simplify the policy loading logic, reduce the size of
> the critical section while holding the policy write-lock, and should
> facilitate future changes to e.g. refactor the entire policy reload
> logic including the selinuxfs code to make the updating of the policy
> and the selinuxfs directory tree atomic and/or to convert the policy
> read-write lock to RCU.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v5 drops the load_mutex and adds a comment about why we do not need
> to take the policy read-lock in the security_load_policy() and
> selinux_policy_commit() code that dereferences state->ss->policy due
> to the selinuxfs fsi->mutex providing exclusion around the entire policy
> reload. I am also dropping RFC from the subject line because I consider
> these patches ready to be merged now.
>
>  security/selinux/ss/services.c | 403 +++++++++++++++++----------------
>  security/selinux/ss/services.h |  10 +-
>  2 files changed, 221 insertions(+), 192 deletions(-)

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
