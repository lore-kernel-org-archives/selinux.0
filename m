Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34C1C433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 01:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707A82053B
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 01:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="X38ae9ZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHRBCq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHRBCp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 21:02:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10238C061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 18:02:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p24so20002766ejf.13
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 18:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oH08Ya/I4bqwCMcaDjx9guNUtFkNqSkw9jZqbGBVS74=;
        b=X38ae9ZN0BkMco72v1r2/SliX2yvbhEhvskFEQEvdeV81JCPlPd7+KwugcQCVecpUR
         Mtlb3gUiGD33Ry5upn/9QHjR+5dFiTxvrkJYgFlCWViPQNOah14fj3+hsYbdoXEwwldW
         LlTsLw5FnseiZU3U5n61oB/WrLOq0DZnCtTaNgK0xyHM49fsG3fpal/ihekftpkYqTg+
         FJOj9AyC3f2vYFfOnNkR5IhU+O0hux7KYHUP6P23vRk78QqPsEMCt5vlMK5XXZx7UUQQ
         XpccpeQhcK+gphCZUyApsSyy0qIbUrRn+SzK0ssVjFSDcqFhBzEfwr7Cl9exSYmDIA3W
         wfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oH08Ya/I4bqwCMcaDjx9guNUtFkNqSkw9jZqbGBVS74=;
        b=Um347vaM/Nn/4hfC8mEWdSeL4lguyb7d3+auHw+rvzNWNikVmTid2jlAxGK6ZCtcl3
         LT+U7+7f92PXkUkaTaFINj4QEj4qi0Ypwx3lhUdSz1Bycj6MfxVVhOrSaa2WapyiIHIl
         AKMiR9TSZ563AVB/TmtgohgaZ8+Lzs0gLmmd/msXhgP+Skjc1UmX2pDAaIaECWGSekzt
         wi7ylM/pmQ4QkyMBL48dZ7xb09nED5iqNk/8I0BRnRpVBXRMLq1IpQniuT/TYNxftXyp
         HiqheWzsqE4Bi/v/1hfSjsF8q91jgZTwrYlpov4G3uaZnwcfadgOk06l8QiXObhDC3KX
         +OVg==
X-Gm-Message-State: AOAM532WGXT/q1joJvEc7GPz7QVMezxH6CbAEIREEG4gYtcHps8OgDs+
        eGBmYfDQxNUY36pDvy7xICiiIqKN6LDPpN3WZfI/
X-Google-Smtp-Source: ABdhPJxWd62VuqVjnXetJ292GyzUBIbmaejdyUKh+oEn/zWw01Dru/e4wFa6KtygN9q+Ws4KuDY8z6bMamOIQ1xLvJQ=
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr17597465ejn.542.1597712563524;
 Mon, 17 Aug 2020 18:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200811190156.31193-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200811190156.31193-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 21:02:32 -0400
Message-ID: <CAHC9VhRFVCCv0_NBXh5h-rj9B5Q20EuJeGE94h_JXtq_qtzPqw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: refactor changing booleans
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        peter.enderborg@sony.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 3:02 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Refactor the logic for changing SELinux policy booleans in a similar
> manner to the refactoring of policy load, thereby reducing the
> size of the critical section when the policy write-lock is held
> and making it easier to convert the policy rwlock to RCU in the
> future.  Instead of directly modifying the policydb in place, modify
> a copy and then swap it into place through a single pointer update.
> Only fully copy the portions of the policydb that are affected by
> boolean changes to avoid the full cost of a deep policydb copy.
> Introduce another level of indirection for the sidtab since changing
> booleans does not require updating the sidtab, unlike policy load.
> While we are here, create a common helper for notifying
> other kernel components and userspace of a policy change and call it
> from both security_set_bools() and selinux_policy_commit().
>
> Based on an old (2004) patch by Kaigai Kohei [1] to convert the policy
> rwlock to RCU that was deferred at the time since it did not
> significantly improve performance and introduced complexity. Peter
> Enderborg later submitted a patch series to convert to RCU [2] that
> would have made changing booleans a much more expensive operation
> by requiring a full policydb_write();policydb_read(); sequence to
> deep copy the entire policydb and also had concerns regarding
> atomic allocations.
>
> This change is now simplified by the earlier work to encapsulate
> policy state in the selinux_policy struct and to refactor
> policy load.  After this change, the last major obstacle to
> converting the policy rwlock to RCU is likely the sidtab live
> convert support.
>
> [1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
> [2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a memory leak of the oldpolicy structure in security_set_bools().
> Thanks, kmemleak!
>
>  security/selinux/ss/avtab.c       |  49 ++++++++-
>  security/selinux/ss/avtab.h       |   1 +
>  security/selinux/ss/conditional.c | 156 ++++++++++++++++++++++++++++
>  security/selinux/ss/conditional.h |   2 +
>  security/selinux/ss/hashtab.c     |  53 ++++++++++
>  security/selinux/ss/hashtab.h     |   6 ++
>  security/selinux/ss/services.c    | 163 ++++++++++++++++++------------
>  security/selinux/ss/services.h    |   2 +-
>  8 files changed, 368 insertions(+), 64 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
