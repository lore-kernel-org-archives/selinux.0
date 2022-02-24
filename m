Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A4C433F5
	for <selinux@archiver.kernel.org>; Thu, 24 Feb 2022 23:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiBXXeR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiBXXeQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 18:34:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E9D27908D
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 15:33:44 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i11so5039751eda.9
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 15:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zlVVn1FvzI9fVMJ/ULKjM5eo1r9K3khrlchsQzBiq4=;
        b=2t+4EaxmTXfzoipF3A4U+dDBpoI2cFF+xE0/XxRA8F862ofUE1+hkB2T4sjVbScq1z
         J2zvrAduLb8EHD6eMepD0opZ0h3DLqLfCvzZelg3KoH/UiTQc8EoMNcmoPsOSijQl0Cn
         +/69/naaj/FK08PArkzIz6aUl6Pb+8U6y8sg7OwWd2jXncVOO8PFZ8GBUpFe5NmbFTbQ
         4ZKXGnyEuSyqZZfRdu0wiuVlsU2C1TTWwxDBzSfWEWryva3jmVFa1K/BJvwGXgjzKNf1
         irAO5+x5oCr6dq6IOaWUn32YYxJnMSVvekC1/ro09o8nnu1bBpnTAcSfCMv/KCAfnM9T
         8X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zlVVn1FvzI9fVMJ/ULKjM5eo1r9K3khrlchsQzBiq4=;
        b=chtETPFT7uFcgiE4LAzoKjxeY6zpN4CnDdV9ML6msJ3koB3tv5gONw96KTv0/2xWdn
         0tINdJaLM2wijjC59f70JTQPTYJsTnZBy1KZ7stqsrH5IirgV+w8S2c9FTNw4hfsIyVJ
         QYBcBVChLrSSp7ALxzKJ9l1gjAJVpAjKwrg2NV8Nb3tA8N+/+/9ax405IGBxILJkMVpC
         dgVLJeuz3/kD79JdTn2czD5RX/wqxEtnCvYGohy8TLrWQhdOlwOJBwyvgJ3jIU3jBYCW
         9b+Sf9JoPVbL4Ygs55Ub+ztPXdzX7aEbeIi34i0r8YJHzpKBeL7Ya0SYGfzSQBwE8J3e
         PCqg==
X-Gm-Message-State: AOAM530tA/sfjKHjp2bucCAlErjDj8uO+ecWK6YNZHzvNb++k9VM4HoZ
        vtt9YaHtq2fp6fvf7nYZNvRO4Gp0k+Z5Cc1qOhVVwjFdzQ==
X-Google-Smtp-Source: ABdhPJwAr0DiU3nXupWOAbgpQyLWsVczrAy8qg6L6H73dZV1dJM0ObBHQivDXIX1Ve+rZnfkUKBF50ixT7d0bTYBXYc=
X-Received: by 2002:a05:6402:354c:b0:412:b2f2:f8e4 with SMTP id
 f12-20020a056402354c00b00412b2f2f8e4mr4565055edd.269.1645745622484; Thu, 24
 Feb 2022 15:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20220224130719.44424-1-richard_c_haines@btinternet.com>
In-Reply-To: <20220224130719.44424-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Feb 2022 18:33:31 -0500
Message-ID: <CAHC9VhRmqeMM3ruPM1-SwTzxB_i4Nez7HNmxNG4hZ8L3Cwq=bg@mail.gmail.com>
Subject: Re: [PATCH Notebook] policy_config_statements.md: How to add a new capability
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 24, 2022 at 8:07 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Describes the steps required to add a new policy capability to the:
> kernel, libsepol, and policy.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks Richard.  I saw the Markdown in your reply to Demi and was
going to ask you about adding it to The Notebook; happily you beat me
to it.

> Paul: Please note the use of the 'Oxford comma' above.

Appreciated, thank you :)

> ... Did you know there
> is the "Oxford Comma" song by Vampire Weekend (if you are of a sensitive
> disposition, don't listen).

Oh, no, I did not know that!  I'm currently "in a meeting" so I can't
listen to it, but I've got the song/video queued up for later :)

> diff --git a/src/policy_config_statements.md b/src/policy_config_statements.md
> index d4eee48..1ae7f64 100644
> --- a/src/policy_config_statements.md
> +++ b/src/policy_config_statements.md
> @@ -1,5 +1,12 @@
>  # Policy Configuration Statements
>
> +- [*policycap*](#policycap)
> +  - [Adding A New Policy Capability](#adding-a-new-policy-capability)
> +    - [Kernel Updates](#kernel-updates)
> +    - [*libsepol* Library Updates](#libsepol-library-updates)
> +    - [Reference Policy Updates](#reference-policy-updates)
> +    - [CIL Policy Updates](#cil-policy-updates)
> +
>  ## *policycap*
>
>  Policy version 22 introduced the *policycap* statement to allow new
> @@ -47,6 +54,124 @@ Conditional Policy Statements
>  policycap network_peer_controls;
>  ```
>
> +## Adding A New Policy Capability
> +
> +### Kernel Updates
> +
> +In kernel source update the following three files with the new capability:
> +
> +***security/selinux/include/policycap_names.h***
> +
> +Add new entry at end of this list:
> +
> +```
> +/* Policy capability names */
> +const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
> +       ...
> +       "genfs_seclabel_symlinks",
> +       "new_polcap_name"
> +};
> +```
> +
> +***security/selinux/include/policycap.h***
> +
> +Add new entry at end of this list:
> +
> +```
> +/* Policy capabilities */
> +enum {
> +       ...
> +       POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> +       POLICYDB_CAPABILITY_NEW_POLCAP_NAME,
> +       __POLICYDB_CAPABILITY_MAX
> +};
> +```

I worry that "adding a new entry to the end of the list" could be
interpreted as this:

 enum {
   ...
   __POLICYDB_CAPABILITY_MAX,
   POLICYDB_CAPABILITY_MY_NEW_POLCAP
 };

It might be good to specify that new entries should be added
immediately before the CAPABILITY_MAX sentinel.

> +***security/selinux/include/security.h***
> +
> +Add a new call to retrieve the loaded policy capability state:
> +
> +```
> +static inline bool selinux_policycap_new_name(void)
> +{
> +       struct selinux_state *state = &selinux_state;
> +
> +       return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_NEW_POLCAP_NAME]);
> +}
> +```

Instead of providing a code snippet, which will surely become outdated
at some point, perhaps it would be better to simply reference the
existing getter functions in the header file as a copy-n-paste target?

> +Finally in the updated code that utilises the new policy capability do
> +something like this:
> +
> +```
> +if (selinux_policycap_new_name())
> +       do this;
> +else
> +       do that;
> +```
> +
> +### *libsepol* Library Updates
> +
> +In selinux userspace source update the following two files with the new
> +capability:
> +
> +***selinux/libsepol/src/polcaps.c***
> +
> +Add new entry at end of this list:
> +
> +```
> +static const char * const polcap_names[] = {
> +       ...
> +       "genfs_seclabel_symlinks",      /* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
> +       "new_polcap_name",              /* POLICYDB_CAPABILITY_NEW_POLCAP_NAME */
> +       NULL
> +};
> +```

See above worry, but substitute the NULL sentinel value.

> +***selinux/libsepol/include/sepol/policydb/polcaps.h***
> +
> +Add new entry at end of this list:
> +
> +```
> +/* Policy capabilities */
> +enum {
> +       ...
> +       POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> +       POLICYDB_CAPABILITY_NEW_POLCAP_NAME,
> +       __POLICYDB_CAPABILITY_MAX
> +};
> +```

Same.

-- 
paul-moore.com
