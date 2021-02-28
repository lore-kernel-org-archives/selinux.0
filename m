Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58381C433E0
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EE664E4B
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 08:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhB1IeY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Feb 2021 03:34:24 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:47906 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1IeX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Feb 2021 03:34:23 -0500
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id E0B7E564E26
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 09:33:39 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id d11so7696855plo.8
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 00:33:39 -0800 (PST)
X-Gm-Message-State: AOAM5312iHdEXWOajt9xlbstbmXXOYB6b1/Ck1iEK6qRCGUWH4fupgkM
        lDRH8fIf+8oNlr6rCKGJjwMlo5lgPo/HShvxwHI=
X-Google-Smtp-Source: ABdhPJyD7jKCZx+sgDHBpsHOjSrSPpHd7l6EXmSIw0Kt0riqR3Ha7E414yT1d/XhTEjNvJn14Fwe6bflT6HxEvTUQaY=
X-Received: by 2002:a17:90b:3892:: with SMTP id mu18mr11581018pjb.143.1614501218278;
 Sun, 28 Feb 2021 00:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20210223150328.56028-1-plautrba@redhat.com>
In-Reply-To: <20210223150328.56028-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 28 Feb 2021 09:33:27 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nCsJiERjj6khYRfd1PfHwBO_RViZQoix5U6_exDoTsYQ@mail.gmail.com>
Message-ID: <CAJfZ7=nCsJiERjj6khYRfd1PfHwBO_RViZQoix5U6_exDoTsYQ@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: Do not try to load policy on import
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 28 09:33:40 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 23, 2021 at 4:06 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> When a policy is inaccessible, scripts fail right "import sepolicy". With
> this change we let the "sepolicy" module to import and move the policy
> initialization before it's used for the first time.
>
> Fixes:
>     >>> import seobject
>     Traceback (most recent call last):
>       File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 171, in policy
>         _pol = setools.SELinuxPolicy(policy_file)
>       File "setools/policyrep/selinuxpolicy.pxi", line 73, in setools.policyrep.SELinuxPolicy.__cinit__
>       File "setools/policyrep/selinuxpolicy.pxi", line 695, in setools.policyrep.SELinuxPolicy._load_policy
>     PermissionError: [Errno 13] Permission denied: '//etc/selinux/targeted/policy/policy.33'
>
>     During handling of the above exception, another exception occurred:
>
>     Traceback (most recent call last):
>       File "<stdin>", line 1, in <module>
>       File "/usr/lib/python3.9/site-packages/seobject.py", line 33, in <module>
>         import sepolicy
>       File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 186, in <module>
>         raise e
>       File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 183, in <module>
>         policy(policy_file)
>       File "/usr/lib/python3.9/site-packages/sepolicy/__init__.py", line 173, in policy
>         raise ValueError(_("Failed to read %s policy file") % policy_file)
>     ValueError: Failed to read //etc/selinux/targeted/policy/policy.33 policy file
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> It's based on review from https://lore.kernel.org/selinux/CAEjxPJ5gK_DdNxpjMq8tvvhkq1hxsoE5vTNZAa=hiP-6s=an8Q@mail.gmail.com/T/#m88ed2c2522a5b3907b607fdf08fde5dbf8d48571

Many thanks!! I have been thinking about this issue for quite some
time and your patch fixes it nicely :) Actually "global _pol"
statements are not required, because _pol is only read in the modified
functions, but they make the code more readable (in my humble opinion)
so I think it is better to introduce them anyway.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

And I directly merged it. Thanks!
Nicolas

>  python/sepolicy/sepolicy/__init__.py | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index e4540977d042..7309875c7e27 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -178,15 +178,15 @@ def load_store_policy(store):
>          return None
>      policy(policy_file)
>
> -try:
> +def init_policy():
>      policy_file = get_installed_policy()
>      policy(policy_file)
> -except ValueError as e:
> -    if selinux.is_selinux_enabled() == 1:
> -        raise e
> -
>
>  def info(setype, name=None):
> +    global _pol
> +    if not _pol:
> +        init_policy()
> +
>      if setype == TYPE:
>          q = setools.TypeQuery(_pol)
>          q.name = name
> @@ -337,6 +337,9 @@ def _setools_rule_to_dict(rule):
>
>
>  def search(types, seinfo=None):
> +    global _pol
> +    if not _pol:
> +        init_policy()
>      if not seinfo:
>          seinfo = {}
>      valid_types = set([ALLOW, AUDITALLOW, NEVERALLOW, DONTAUDIT, TRANSITION, ROLE_ALLOW])
> @@ -916,6 +919,10 @@ def get_all_roles():
>      if roles:
>          return roles
>
> +    global _pol
> +    if not _pol:
> +        init_policy()
> +
>      q = setools.RoleQuery(_pol)
>      roles = [str(x) for x in q.results() if str(x) != "object_r"]
>      return roles
> --
> 2.30.1
>

