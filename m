Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BAFC433E2
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 21:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5680C2087C
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 21:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q3C0En1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIDVuO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIDVuO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 17:50:14 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04780C061244
        for <selinux@vger.kernel.org>; Fri,  4 Sep 2020 14:50:14 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b12so7401113edz.11
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2020 14:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVsIwTxyprH6j0iLqP03s7+W2xRaNGWvThLcMex9TBw=;
        b=Q3C0En1hWxNQ5ftbEAiWDoWxxtTq15iMVgEH6UsRYwb1pYHzYmnZgVNH0mzYrqRXzS
         QaqHeY3taIvRFH3KTJM/grQ1hIEsa7ixVT67f8fnUOgMxvtVpMYPZgMoqSt273JWvWz9
         X0J2o5F1aTeernEasDti3I0n9cVcERrIcH5jdx5FUF9z1/4bN0Id3nYxjF/Idehl+ygY
         VldIPmNKlwC1kpjRa8cSV5DayT9JMhzgSH2Uc1GGxsqpn0QKdsnR8hn0tUuhn4fiYBI2
         o1MXq9UXaK9Y4xC+o4YkxxnNVTL54d+QLYH6s1NRphFX9Gwnb+LkCqjoDtRh+X5A/jMZ
         0Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVsIwTxyprH6j0iLqP03s7+W2xRaNGWvThLcMex9TBw=;
        b=dzNbZdjhRjJBLIlx/lV9+9KQBAUAeD/3WL0NpdqpeA3eEv3T0tzqBpfOkL7VpE2Vge
         Wv481JsVrgRl1tSICYfmLf5BBoiS+kbyHNStJdHCg9FMzUhN+wGYXy/LmWHp8QaZScsL
         2d+8bFYpyms2D703FDef5Z8rPhPIELwIjUrZngTc0vMQ0JZRxubOONTxhdJCm4zWSlRw
         VfhXWjINGKRjaUY9yXXFPV4s1preb9LW6n+ZWwSPTzbUKWgGf85YHADN71fR6S5EKZ7h
         Xbr3Kc7U0BBjjVPkdKu21ufzh1CsFgFU/NvZm1LwdOVaFnIHAHGtmWeR5t0itMzm9PCU
         iqjg==
X-Gm-Message-State: AOAM531FmrkzCi0uzcUX3JdEoy82KEoUdZ5mTWIhmuWLCu8D7K/VsZbr
        +2HQYg2DMVQluV3z3uUsMOA/B33BBrVvATzvyWLASjX4HA==
X-Google-Smtp-Source: ABdhPJzhUBLxP35s807gL5ypn/M5pmLMf342joKY10Hwhdd8e/DwkuxN+uaYGkhHZ2cdEuWatntsasFKkCAUM04c8d8=
X-Received: by 2002:a50:8e17:: with SMTP id 23mr10683869edw.31.1599256212457;
 Fri, 04 Sep 2020 14:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-3-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-3-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Sep 2020 17:50:01 -0400
Message-ID: <CAHC9VhQQh5q86Xki8vevDnHyhRRy8Jigxc_CCEOwcDvvFdnC6w@mail.gmail.com>
Subject: Re: [PATCH v20 02/23] LSM: Create and manage the lsmblob data structure.
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:03 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
>
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
>
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
>
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> Because IMA uses the audit rule functions it is
> affected as well.
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h               |  4 +-
>  include/linux/lsm_hooks.h           | 12 ++++-
>  include/linux/security.h            | 67 +++++++++++++++++++++++++--
>  kernel/auditfilter.c                | 24 +++++-----
>  kernel/auditsc.c                    | 12 ++---
>  security/apparmor/lsm.c             |  7 ++-
>  security/bpf/hooks.c                | 12 ++++-
>  security/commoncap.c                |  7 ++-
>  security/integrity/ima/ima_policy.c | 40 +++++++++++-----
>  security/loadpin/loadpin.c          |  8 +++-
>  security/lockdown/lockdown.c        |  7 ++-
>  security/safesetid/lsm.c            |  8 +++-
>  security/security.c                 | 72 ++++++++++++++++++++++++-----
>  security/selinux/hooks.c            |  8 +++-
>  security/smack/smack_lsm.c          |  7 ++-
>  security/tomoyo/tomoyo.c            |  8 +++-
>  security/yama/yama_lsm.c            |  7 ++-
>  17 files changed, 254 insertions(+), 56 deletions(-)

...

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 0a0a03b36a3b..c91389d7aebc 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -131,6 +131,65 @@ enum lockdown_reason {
>
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>
> +/*
> + * Data exported by the security modules
> + *
> + * Any LSM that provides secid or secctx based hooks must be included.
> + */
> +#define LSMBLOB_ENTRIES ( \
> +       (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
> +
> +struct lsmblob {
> +       u32     secid[LSMBLOB_ENTRIES];
> +};
> +
> +#define LSMBLOB_INVALID                -1      /* Not a valid LSM slot number */
> +#define LSMBLOB_NEEDED         -2      /* Slot requested on initialization */
> +#define LSMBLOB_NOT_NEEDED     -3      /* Slot not requested */
> +
> +/**
> + * lsmblob_init - initialize an lsmblob structure.
> + * @blob: Pointer to the data to initialize
> + * @secid: The initial secid value
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
> +{
> +       int i;
> +
> +       for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +               blob->secid[i] = secid;
> +}

As I'm going through the v20 draft of these patches it occurs to me,
at least in the intermediate patches, that there is a pretty common
pattern involving lsmblob_init():

  lsmblob_init(blob, secid);
  func(blob, ...);

... would it make sense to have lsmblob_init() return *blob instead of
void?  It doesn't really matter too much, but it seems like it could
help cleanup some of the code:

  func(lsmblob_init(blob, secid), ...);

-- 
paul moore
www.paul-moore.com
