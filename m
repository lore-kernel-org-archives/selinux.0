Return-Path: <SRS0=2ovD=6Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED334C38A2A
	for <selinux@archiver.kernel.org>; Sun, 10 May 2020 17:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE1E207DD
	for <selinux@archiver.kernel.org>; Sun, 10 May 2020 17:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgEJRZ7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 10 May 2020 13:25:59 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49272 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgEJRZ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 10 May 2020 13:25:59 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id CD9CA564CFC
        for <selinux@vger.kernel.org>; Sun, 10 May 2020 19:25:55 +0200 (CEST)
Received: by mail-oi1-f173.google.com with SMTP id c124so12936616oib.13
        for <selinux@vger.kernel.org>; Sun, 10 May 2020 10:25:55 -0700 (PDT)
X-Gm-Message-State: AGi0PuawJLbxEamjY5L7FpmU6NadgBgoDHw2kWe7J2GkZfSbQOKz71Uk
        MYy0wHqmBoFw9uj2Tl4ehljjoJoFgpNrWo2ksWc=
X-Google-Smtp-Source: APiQypKdxDC4WPFCin+ASRpl/dJhcvLcf7WY78tcSk7CgEqdr0sKrjPXAVLXBSZXkQRP4b90luRfWS5yzuORGgI+hao=
X-Received: by 2002:aca:480b:: with SMTP id v11mr16460391oia.20.1589131554646;
 Sun, 10 May 2020 10:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <d204aaea-ca46-49c2-f7cd-6f20889cecbf@gmail.com>
In-Reply-To: <d204aaea-ca46-49c2-f7cd-6f20889cecbf@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 10 May 2020 19:25:43 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kn951BnLbJKKLKkzXaeGEnME1P=rBsczFumf3S7=3MjA@mail.gmail.com>
Message-ID: <CAJfZ7=kn951BnLbJKKLKkzXaeGEnME1P=rBsczFumf3S7=3MjA@mail.gmail.com>
Subject: Re: [PATCH] chcat: don't crash if access to binary policy is prohibited
To:     bauen1 <j2468h@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun May 10 19:25:56 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 9, 2020 at 4:06 PM bauen1 <j2468h@googlemail.com> wrote:
>
> sobject will crash if access to the binary policy is prohibited by
> selinux, e.g. refpolicy
> this also breaks file operations that don't require seobject.
>
> Signed-off-by: bauen1 <j2468h@gmail.com>

Hello,
This patch looks very hackish. In fact, an underlying issue that
exists with seobject is that "import seobject" raises an exception
when it is used from an environment that is not allowed to read the
policy:

>>> import seobject
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/usr/lib/python3.8/site-packages/seobject.py", line 33, in <module>
    import sepolicy
  File "/usr/lib/python3.8/site-packages/sepolicy/__init__.py", line
186, in <module>
    raise e
  File "/usr/lib/python3.8/site-packages/sepolicy/__init__.py", line
182, in <module>
    policy_file = get_installed_policy()
  File "/usr/lib/python3.8/site-packages/sepolicy/__init__.py", line
137, in get_installed_policy
    raise ValueError(_("No SELinux Policy installed"))
ValueError: No SELinux Policy installed

Is this the issue you encountered when you write "seobject will crash"?

In my humble opinion, trying to hide such an issue by moving "import
seobject" makes maintaining the project more difficult. I would prefer
seeing a way to allow using "import seobject" without raising
exceptions, but working on this is unfortunately quite time-consuming
(I have not seen a straightforward way to deal with this, and there
exist several ways to solve this in not-very-direct ways, for example
with lazy loading of the policy when needed or with replacing some API
with stub functions if the policy cannot be loaded).

Therefore I will not ack this patch, but I will not block ("Nack") it
if another maintainer wants to include it.

Thanks,
Nicolas

> ---
>  python/chcat/chcat | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/python/chcat/chcat b/python/chcat/chcat
> index fdd2e46e..55408577 100755
> --- a/python/chcat/chcat
> +++ b/python/chcat/chcat
> @@ -28,7 +28,6 @@ import os
>  import pwd
>  import getopt
>  import selinux
> -import seobject
>
>  PROGNAME = "policycoreutils"
>  try:
> @@ -65,6 +64,7 @@ def verify_users(users):
>
>
>  def chcat_user_add(newcat, users):
> +    import seobject
>      errors = 0
>      logins = seobject.loginRecords()
>      seusers = logins.get_all()
> @@ -144,6 +144,7 @@ def chcat_add(orig, newcat, objects, login_ind):
>
>
>  def chcat_user_remove(newcat, users):
> +    import seobject
>      errors = 0
>      logins = seobject.loginRecords()
>      seusers = logins.get_all()
> @@ -233,6 +234,7 @@ def chcat_remove(orig, newcat, objects, login_ind):
>
>
>  def chcat_user_replace(newcat, users):
> +    import seobject
>      errors = 0
>      logins = seobject.loginRecords()
>      seusers = logins.get_all()
> @@ -376,6 +378,7 @@ def listcats():
>
>
>  def listusercats(users):
> +    import seobject
>      if len(users) == 0:
>          try:
>              users.append(os.getlogin())
> --
> 2.26.2
>

