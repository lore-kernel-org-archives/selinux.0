Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB937C5519F
	for <selinux@archiver.kernel.org>; Wed, 18 Nov 2020 19:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6726620888
	for <selinux@archiver.kernel.org>; Wed, 18 Nov 2020 19:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="P9f4OnRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgKRTnX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRTnW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Nov 2020 14:43:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA2FC0613D4
        for <selinux@vger.kernel.org>; Wed, 18 Nov 2020 11:43:22 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id s25so4450048ejy.6
        for <selinux@vger.kernel.org>; Wed, 18 Nov 2020 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XrNHAV1ZTKqWTksacaIma7BYDTcxI+biCZbgOxlYg0=;
        b=P9f4OnRYRu7ptNkhmlmIBMa1o/KV5aQwy8wOmYvm5xB/PG668PvwJq0FvxZn+ECBKb
         8Zb6nA967SlX3PPfX8LWfGK1qJV7PKgnHnxodzLAAmaWXPwx42MjMzIl3XqtqCFs2Tvh
         H8FnoJfvTlAIh92i3Yum/Smg9S+Dfc6ecsfFgTzL1iXVpX+G5UVS80GGdLFheZeiw6IM
         Ui8R2Sm4dc6WlPJ2nAVGHRe/UZnKxTWJ+omcTY+muYeZVZlzMktSDUTwtuCnfpuZtyBK
         yhqZJ3DMSfqPhUhTSl2EL0TX2IO1gt/ybsMG8Dj3wN1nyj15RQ6uZUeMm2k7wmpO3/X/
         wlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XrNHAV1ZTKqWTksacaIma7BYDTcxI+biCZbgOxlYg0=;
        b=I192qvjAW2KNyk4V2LtpxOUGhQzo0qBKy4wY0Z+23xmHc/+tJPT7bNO6sjgMV3+W9Z
         KuM1p2plNSuEoDeIPxY82yALrd3rqNSsI67bgT069i+x4xK3oC4s0OOr5FfbKTr2HA1z
         JbkQgud0sS8p6Usm5XDeHnsEgf+puzpKj4tpeohfXhJzoXFZTQatbJ9V49VUhTZ9xg0B
         7B+Cq/lg5S2dnN2IRnV0piZwgNFc6lnFAxO1PxGGHFt86INIqufXUslswRcOGPo0/8ba
         9RbO1qUjMrjGWwURJ1RBrHQpMh/U/Ux861uW6/EpWHwexxkulONaZEhFH+ZnCQoMzO2Q
         t2Tw==
X-Gm-Message-State: AOAM532lKSBr7OA6pW1zp/LxKOlOtpFh4/cV6fO0Cd3d1hRE7m4WhA9a
        dagjTbACeCvMKG2De1nV1u7z0RkUzr/mkjK4LFYA
X-Google-Smtp-Source: ABdhPJzxmhjRvJAmJMWEm9W653GqkvZefXDFYn8tP0yTY7PIaRiWjPxfVJROz08RvnkCy1n1jyizmDFL/+60Z584D1U=
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr24923675ejc.178.1605728600962;
 Wed, 18 Nov 2020 11:43:20 -0800 (PST)
MIME-Version: 1.0
References: <202011171355.YCVKNWtD-lkp@intel.com>
In-Reply-To: <202011171355.YCVKNWtD-lkp@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Nov 2020 14:43:09 -0500
Message-ID: <CAHC9VhT_K2rwo+kvvwtHLr5oxu-2cS=q3MFS1iZ0SnhduD5LCA@mail.gmail.com>
Subject: Re: [pcmoore-selinux:working-selinuxns 7/12] security/selinux/hooks.c:7275:42:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        kbuild-all@lists.01.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 17, 2020 at 12:19 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git working-selinuxns
> head:   7bde0cc97700a0abfbfa0ef5f00f9abb0ec0073c
> commit: e9711bb4912b792b6ec307932cd08329d4a973ff [7/12] selinux: dynamically allocate selinux namespace
> config: x86_64-randconfig-s021-20201116 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-107-gaf3512a6-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=e9711bb4912b792b6ec307932cd08329d4a973ff
>         git remote add pcmoore-selinux https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>         git fetch --no-tags pcmoore-selinux working-selinuxns
>         git checkout e9711bb4912b792b6ec307932cd08329d4a973ff
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> "sparse warnings: (new ones prefixed by >>)"
>    security/selinux/hooks.c:215:30: sparse: sparse: cast removes address space '__rcu' of expression
>    security/selinux/hooks.c:2541:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    security/selinux/hooks.c:2541:39: sparse:     expected struct spinlock [usertype] *lock
>    security/selinux/hooks.c:2541:39: sparse:     got struct spinlock [noderef] __rcu *
>    security/selinux/hooks.c:2549:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>    security/selinux/hooks.c:2549:41: sparse:     expected struct spinlock [usertype] *lock
>    security/selinux/hooks.c:2549:41: sparse:     got struct spinlock [noderef] __rcu *
>    security/selinux/hooks.c:2555:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
>    security/selinux/hooks.c:2555:42: sparse:     expected struct task_struct *parent
>    security/selinux/hooks.c:2555:42: sparse:     got struct task_struct [noderef] __rcu *real_parent
>    security/selinux/hooks.c:5315:22: sparse: sparse: restricted __be16 degrades to integer
>    security/selinux/hooks.c:5316:22: sparse: sparse: restricted __be16 degrades to integer
> >> security/selinux/hooks.c:7275:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct selinux_policy *policy @@     got struct selinux_policy [noderef] __rcu *policy @@
> >> security/selinux/hooks.c:7275:42: sparse:     expected struct selinux_policy *policy
> >> security/selinux/hooks.c:7275:42: sparse:     got struct selinux_policy [noderef] __rcu *policy
>
> vim +7275 security/selinux/hooks.c
>
>   7265
>   7266  static void selinux_state_free(struct work_struct *work)
>   7267  {
>   7268          struct selinux_state *parent, *state =
>   7269                  container_of(work, struct selinux_state, work);
>   7270
>   7271          do {
>   7272                  parent = state->parent;
>   7273                  if (state->status_page)
>   7274                          __free_page(state->status_page);
> > 7275                  selinux_policy_free(state->policy);
>   7276                  selinux_avc_free(state->avc);
>   7277                  kfree(state);
>   7278                  state = parent;
>   7279          } while (state && refcount_dec_and_test(&state->count));
>   7280  }
>   7281

FYI, this should now be fixed in the selinux/working-selinuxns tree.

-- 
paul moore
www.paul-moore.com
