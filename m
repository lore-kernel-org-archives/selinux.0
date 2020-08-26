Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAB7C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3C82078D
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOGtsbGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHZOFo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgHZOFn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:05:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CAAC061370
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:05:43 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b9so1619852oiy.3
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoMQsABQYvZW8MkmKp+Lw7RmQTwsG2ci/iUF86nWlNk=;
        b=aOGtsbGzXtZnRK3sEBhEK1NP5BbcFs00XmIBiMpMlsQ+nvBdXBTsRg5sNDmCk+INNJ
         X/J5gzrBmV8m/mNwVgJPRGV6XObYWCKeW7eJtDG9tIEdXcAXdm52noGUJ6eA9EZ/UfyS
         Arr2pUO3qCqOx/10hwbyFTGlFW0xQCK/TdQV3Y6ihE/73UxmGDORnmW2qz71Uda3j4+1
         eLBHYc9XONHglnyxQD/N/1GyWgqc4ZqZEdiYmEph5OtnhqVh/StEdwHLWfDiGm+7kQOq
         0hO9mbnU+Ojw1qIfXw98xP1hB9urT7fbTFxqClqOjxeBK6FjlLt9rqi/B9VZt8ubAXzU
         zTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoMQsABQYvZW8MkmKp+Lw7RmQTwsG2ci/iUF86nWlNk=;
        b=lF+UHfBf4a4dKe8cIo2+K9K8b/9nRpLEEhpeP2R5BnNwooprS9JYjoYqD7vDQyT0mO
         5JYYDOZ0e8OaiVyMPrqjwBkiwCC+EGXDgWoGf/Odl2eM38vAiVIr/B92kIH8KYfsQE5t
         24XSHDQAD9Lenzz5FWoFq6KeAOnN61SLWe1h/5RRC5hbbXUTqfDeTtZREgKT4d7Eltgg
         u7jS9X5n+CyjmmOVkv62F7l0Pznf13Bu4o2ig3AKsSBlQtUk0ZzQwFUgxWonpeM1Q7p3
         isg/XrT5sh3R16fsbxHBqAZS/tUiDZAheCDoSllakgACZH2W1sWvJwa/Ag8yKni/MvxT
         cMzg==
X-Gm-Message-State: AOAM5300LLG4vS14J/d9f5gU7tYl5RYCrpkxMj9YHlVFwfIiiI/mV+Do
        PfVaoG6hUgup94Od/l0uzVqqget3l2vmXMcjKcq/h/il
X-Google-Smtp-Source: ABdhPJxhsfgJJQyfGzr3U0aPXxGsLbmbSyDu0x7la+EqLZPZnpePbnCBdha3LQY/tz0m0zO8v+KRjey3iFRM1/QhyKQ=
X-Received: by 2002:a54:4817:: with SMTP id j23mr4009858oij.140.1598450742612;
 Wed, 26 Aug 2020 07:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-2-omosnace@redhat.com>
In-Reply-To: <20200826135906.1912186-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 10:05:31 -0400
Message-ID: <CAEjxPJ4LL022dtKyqs+YB-gKVuJqRNQu0dafjgzZLqStqn-zSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: simplify away security_policydb_len()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Remove the security_policydb_len() calls from sel_open_policy() and
> instead update the inode size from the size returned from
> security_read_policy().
>
> Since after this change security_policydb_len() is only called from
> security_load_policy(), remove it entirely and just open-code it there.
>
> Also, since security_load_policy() is always called with fsi->mutex
> held, make it dereference the policy pointer directly and drop the
> unnecessary RCU locking.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

One comment below but nonetheless:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 8381614627569..7cc2f7486c18f 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3912,11 +3896,17 @@ int security_read_policy(struct selinux_state *state,
>         int rc;
>         struct policy_file fp;
>
> -       if (!selinux_initialized(state))
> +       /*
> +        * NOTE: We do not need to take the rcu read lock
> +        * around the code below because other policy-modifying
> +        * operations are already excluded by selinuxfs via
> +        * fsi->mutex.
> +        */
> +       policy = rcu_dereference_check(state->policy, 1);
> +       if (!policy)
>                 return -EINVAL;

If/when my patch to move the mutex to selinux_state and use it in
rcu_dereference_protected() lands, we'll want to change this one over
too.
