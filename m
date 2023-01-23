Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E3CC05027
	for <selinux@archiver.kernel.org>; Mon, 23 Jan 2023 21:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAWVgr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Jan 2023 16:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjAWVgq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Jan 2023 16:36:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC330285
        for <selinux@vger.kernel.org>; Mon, 23 Jan 2023 13:36:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lp10so9507118pjb.4
        for <selinux@vger.kernel.org>; Mon, 23 Jan 2023 13:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGXvyQjwLmOy53oIzm1ZLaTMK3/o09Vv8V+chgSLdeY=;
        b=CcWptSLeFIccOdIwrrQruiIQVbfQw+qTyjT3yv+7o4oiOdtJnaGwyxjNF8KqV8JCPb
         EtEuwCUakT7bXDWuTHstKBBxFfx/NFD6nI++Zxx33wEt2LsDHWWFbVo+nWs5aJpvgbDt
         bcNjHlr2/smIeZ2DgR6hyv29jjDSqQQI+8Qj+9AAlhetLTyxbKX75Vw/uzLti5pjdjDD
         1gqqU5UtNkfvmUk9ZygMGK8+1jwTN9eFYCq597DzigUSvomN5c9XhKqAjmlcR+BL0bRb
         fkuAUTdTl6ZIMoENwrU3bfv6UbzvTXWAqgAlNJDWfnVuL4Hhf5bRgdVGoARAYxrNCCDe
         ljRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGXvyQjwLmOy53oIzm1ZLaTMK3/o09Vv8V+chgSLdeY=;
        b=fRhXq7ZLHVeYqgOmJD5UdKv8vaqARErqXPjDpnKFCcp8aP8uGjf1d3nOVfo3MFWG8k
         8W6b9ZSGzw2a21o8bD/9/qlQzolKXkIjIFunw3R2PenkyK9SfxLi52+dCZcSCxR4A86E
         ybkAran0+6aLC547WiR5iH735EvpJSelCdwsgbF2IPl3cVqfon5ck9BoC8nUoTwH8UkJ
         o+yRkcfwdnvMLRBgqR9KLcK8piooxGKsyzNLQoU9lz5wPzR3s4nW/74x/eou3LmmOGKC
         +JXBDo50d1QqhTaFxq/xR/ZFlrGVeIUUhO+CiD9EvcrtvMjri5qfis+wxoJ1/JsXDkAo
         9PqA==
X-Gm-Message-State: AFqh2kqnrfQ5F4d6PBzeITggmLj9Z2Bc0p0VOVC0StRwdbfVA1HecSsH
        RS9cDwQ0JNg2yIuA4f70Q0k7OoK3aB/MMW4azm8K
X-Google-Smtp-Source: AMrXdXsTqILQIvoKLSzn2vsOwuLpTkEPmSgexyL8bv143mvjcjNDhObnaFgjhL7UQHe0gGX5etBgH6e4mhBUZDn4fO0=
X-Received: by 2002:a17:90a:c784:b0:227:202b:8eaa with SMTP id
 gn4-20020a17090ac78400b00227202b8eaamr2957806pjb.147.1674509804015; Mon, 23
 Jan 2023 13:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com> <20230123191728.2928839-5-tjmercier@google.com>
In-Reply-To: <20230123191728.2928839-5-tjmercier@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Jan 2023 16:36:32 -0500
Message-ID: <CAHC9VhQtbTWXXy8mNxNDdukaAp6YB4CX5Xa6dvSZ_r4DhM2EXg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] security: binder: Add binder object flags to selinux_binder_transfer_file
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        jeffv@google.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 23, 2023 at 2:18 PM T.J. Mercier <tjmercier@google.com> wrote:
>
> Any process can cause a memory charge transfer to occur to any other
> process when transmitting a file descriptor through binder. This should
> only be possible for central allocator processes, so the binder object
> flags are added to the security_binder_transfer_file hook so that LSMs
> can enforce restrictions on charge transfers.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  drivers/android/binder.c            |  2 +-
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/lsm_hooks.h           |  5 ++++-
>  include/linux/security.h            |  6 ++++--
>  security/security.c                 |  4 ++--
>  security/selinux/hooks.c            | 13 ++++++++++++-
>  security/selinux/include/classmap.h |  2 +-
>  7 files changed, 25 insertions(+), 9 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3c5be76a9199..d4cfca3c9a3b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -88,6 +88,7 @@
>  #include <linux/bpf.h>
>  #include <linux/kernfs.h>
>  #include <linux/stringhash.h>  /* for hashlen_string() */
> +#include <uapi/linux/android/binder.h>
>  #include <uapi/linux/mount.h>
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
> @@ -2029,7 +2030,8 @@ static int selinux_binder_transfer_binder(const struct cred *from,
>
>  static int selinux_binder_transfer_file(const struct cred *from,
>                                         const struct cred *to,
> -                                       struct file *file)
> +                                       struct file *file,
> +                                       u32 binder_object_flags)
>  {
>         u32 sid = cred_sid(to);
>         struct file_security_struct *fsec = selinux_file(file);
> @@ -2038,6 +2040,15 @@ static int selinux_binder_transfer_file(const struct cred *from,
>         struct common_audit_data ad;
>         int rc;
>
> +       if (binder_object_flags & BINDER_FD_FLAG_XFER_CHARGE) {
> +               rc = avc_has_perm(&selinux_state,
> +                           cred_sid(from), sid,
> +                           SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
> +                           NULL);
> +               if (rc)
> +                       return rc;
> +       }
> +
>         ad.type = LSM_AUDIT_DATA_PATH;
>         ad.u.path = file->f_path;
>
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..2eef180d10d7 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
>         { "tun_socket",
>           { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>         { "binder", { "impersonate", "call", "set_context_mgr", "transfer",
> -                     NULL } },
> +                     "transfer_charge", NULL } },
>         { "cap_userns",
>           { COMMON_CAP_PERMS, NULL } },
>         { "cap2_userns",

My first take on reading these changes above is that you've completely
ignored my previous comments about SELinux access controls around
resource management.  You've leveraged the existing LSM/SELinux hook
as we discussed previously, that's good, but can you explain what
changes you've made to address my concerns about one-off resource
management controls?

-- 
paul-moore.com
