Return-Path: <SRS0=JMXr=6K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C1C54FCB
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F8D2071C
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgDZNeO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:34:14 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57600 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZNeO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Apr 2020 09:34:14 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D65F55649DE
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 15:34:10 +0200 (CEST)
Received: by mail-oo1-f47.google.com with SMTP id r1so3240314oog.7
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 06:34:10 -0700 (PDT)
X-Gm-Message-State: AGi0PuY9z3rLpeqwd9UNWhmzDCrxuC+l0r2N30wHIbFzBv6PDHvLkZFB
        wQYEXvM0Zigu60+6KT1r8rYZzCRRje6+t1Ozt6w=
X-Google-Smtp-Source: APiQypJukKziOcyIdIk8YcPsyhCm4VTW12fTSaV8RUtAy9OR5XTU2QcoMQPZaRIftp4ryHq6hrnN06DePwjQPtbDuPs=
X-Received: by 2002:a4a:b38d:: with SMTP id p13mr15329927ooo.22.1587908049754;
 Sun, 26 Apr 2020 06:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com> <20200420154537.30879-14-william.c.roberts@intel.com>
In-Reply-To: <20200420154537.30879-14-william.c.roberts@intel.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 26 Apr 2020 15:33:58 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nueDv_WihZu9oV9Qx+kq+cwK=ovD9jSm9rhMvDJS+01g@mail.gmail.com>
Message-ID: <CAJfZ7=nueDv_WihZu9oV9Qx+kq+cwK=ovD9jSm9rhMvDJS+01g@mail.gmail.com>
Subject: Re: [PATCH v3 13/19] avc: create internal avc_init interface
To:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <bill.c.roberts@gmail.com>
Cc:     William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 26 15:34:11 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 20, 2020 at 5:46 PM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> Now that avc_init is marked deprecated, create an avc_init2 interface
> for internal users.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libselinux/src/avc.c          | 11 ++++++++++-
>  libselinux/src/avc_internal.h |  5 +++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index ab10b0f9f1cb..505641406995 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -157,7 +157,7 @@ int avc_open(struct selinux_opt *opts, unsigned nopts)
>                         break;
>                 }
>
> -       return avc_init("avc", NULL, NULL, NULL, NULL);
> +       return avc_init2("avc", NULL, NULL, NULL, NULL);
>  }
>
>  int avc_init(const char *prefix,
> @@ -165,6 +165,15 @@ int avc_init(const char *prefix,
>              const struct avc_log_callback *log_cb,
>              const struct avc_thread_callback *thread_cb,
>              const struct avc_lock_callback *lock_cb)
> +{
> +       return avc_init2(prefix, mem_cb, log_cb, thread_cb, lock_cb);
> +}
> +
> +int avc_init2(const char *prefix,
> +            const struct avc_memory_callback *mem_cb,
> +            const struct avc_log_callback *log_cb,
> +            const struct avc_thread_callback *thread_cb,
> +            const struct avc_lock_callback *lock_cb)
>  {
>         struct avc_node *new;
>         int i, rc = 0;
> diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
> index 3f8a6bb1cf84..c8d26a8ae254 100644
> --- a/libselinux/src/avc_internal.h
> +++ b/libselinux/src/avc_internal.h
> @@ -173,4 +173,9 @@ int avc_ss_set_auditdeny(security_id_t ssid, security_id_t tsid,
>  /* netlink kernel message code */
>  extern int avc_netlink_trouble ;
>
> +extern int avc_init2(const char *msgprefix,
> +                   const struct avc_memory_callback *mem_callbacks,
> +                   const struct avc_log_callback *log_callbacks,
> +                   const struct avc_thread_callback *thread_callbacks,
> +                   const struct avc_lock_callback *lock_callbacks);
>  #endif                         /* _SELINUX_AVC_INTERNAL_H_ */
> --
> 2.17.1

Hello,
I do not see the point of having a new avc_init2() "internal
interface". I get that avc_init() is deprecated, that avc_open()
should be used, and that internally a new function (named avc_init2)
is created to make the transition easier. But why is adding
avc_init2() to avc_internal.h necessary? Which internal code is
expected to use it?
If none, I would prefer to make avc_init2() static (changing this
patch to "static init avc_init2(const char*msgprefix,", with a
declaration before avc_open() if you do not want to move the function
in the file).

I have the same question for matchpathcon_fini2(), matchpathcon2(), etc.

Moreover, I do not really like the "...2" naming (this is my own point
of view and I won't block the patch because of it), because it seems
to carry the meaning of "please now use this inferface", which is
untrue. I suggest using avc_init_internal(),
matchpathcon_fini_internal()... that do not carry such a meaning.

Thanks,
Nicolas

