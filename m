Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A941CC433E6
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798CA22BEF
	for <selinux@archiver.kernel.org>; Thu, 21 Jan 2021 21:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbhAUVSl convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:18:41 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:41650 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbhAUVSY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Jan 2021 16:18:24 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C9A75564857
        for <selinux@vger.kernel.org>; Thu, 21 Jan 2021 22:17:30 +0100 (CET)
Received: by mail-oi1-f172.google.com with SMTP id g69so2949798oib.12
        for <selinux@vger.kernel.org>; Thu, 21 Jan 2021 13:17:30 -0800 (PST)
X-Gm-Message-State: AOAM532qFyFBRZXUzaxzXMj8mU9zNlTjPSJ8g1fHS9ZPyPVIZvKuCMPO
        gae6aN9U+9E1vo9bd0Ss4vM/kAxxDd6F/UwvNW8=
X-Google-Smtp-Source: ABdhPJxQInUKeEYKfvvecphqOAYQ2wIkLpasGGTNR8L7zyqSSfPvYnBUx+4YVIh0TDDMQNAweVvFwu+lOg3QrHoxjS4=
X-Received: by 2002:a05:6808:99a:: with SMTP id a26mr1139007oic.40.1611263849641;
 Thu, 21 Jan 2021 13:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20210106133449.193940-1-cgzones@googlemail.com>
In-Reply-To: <20210106133449.193940-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 21 Jan 2021 22:17:18 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kvVcix_qbTywWAF8v3HHrRx13qeAaW9GQrLHR83cDaow@mail.gmail.com>
Message-ID: <CAJfZ7=kvVcix_qbTywWAF8v3HHrRx13qeAaW9GQrLHR83cDaow@mail.gmail.com>
Subject: Re: [PATCH] newrole: preserve environment variable XDG_RUNTIME_DIR
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 21 22:17:31 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 2:36 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> XDG_RUNTIME_DIR is required for systemctl --user to work.
> See https://github.com/systemd/systemd/issues/15231
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  policycoreutils/newrole/newrole.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
> index 36e2ba9c..500969e0 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -466,7 +466,7 @@ static int extract_pw_data(struct passwd *pw_copy)
>   * Either restore the original environment, or set up a minimal one.
>   *
>   * The minimal environment contains:
> - * TERM, DISPLAY and XAUTHORITY - if they are set, preserve values
> + * TERM, DISPLAY, XAUTHORITY and XDG_RUNTIME_DIR - if they are set, preserve values
>   * HOME, SHELL, USER and LOGNAME - set to contents of /etc/passwd
>   * PATH - set to default value DEFAULT_PATH
>   *
> @@ -478,9 +478,11 @@ static int restore_environment(int preserve_environment,
>         char const *term_env;
>         char const *display_env;
>         char const *xauthority_env;
> -       char *term = NULL;      /* temporary container */
> -       char *display = NULL;   /* temporary container */
> +       char const *xdg_runtime_dir_env;
> +       char *term = NULL;              /* temporary container */
> +       char *display = NULL;           /* temporary container */
>         char *xauthority = NULL;        /* temporary container */
> +       char *xdg_runtime_dir = NULL;   /* temporary container */
>         int rc;
>
>         environ = old_environ;
> @@ -491,6 +493,7 @@ static int restore_environment(int preserve_environment,
>         term_env = getenv("TERM");
>         display_env = getenv("DISPLAY");
>         xauthority_env = getenv("XAUTHORITY");
> +       xdg_runtime_dir_env = getenv("XDG_RUNTIME_DIR");        /* needed for `systemd --user` operations */
>
>         /* Save the variable values we want */
>         if (term_env)
> @@ -499,8 +502,12 @@ static int restore_environment(int preserve_environment,
>                 display = strdup(display_env);
>         if (xauthority_env)
>                 xauthority = strdup(xauthority_env);
> -       if ((term_env && !term) || (display_env && !display) ||
> -           (xauthority_env && !xauthority)) {
> +       if (xdg_runtime_dir_env)
> +               xdg_runtime_dir = strdup(xdg_runtime_dir_env);
> +       if ((term_env && !term) ||
> +           (display_env && !display) ||
> +           (xauthority_env && !xauthority) ||
> +           (xdg_runtime_dir_env && !xdg_runtime_dir)) {
>                 rc = -1;
>                 goto out;
>         }
> @@ -518,6 +525,8 @@ static int restore_environment(int preserve_environment,
>                 rc |= setenv("DISPLAY", display, 1);
>         if (xauthority)
>                 rc |= setenv("XAUTHORITY", xauthority, 1);
> +       if (xdg_runtime_dir)
> +               rc |= setenv("XDG_RUNTIME_DIR", xdg_runtime_dir, 1);
>         rc |= setenv("HOME", pw->pw_dir, 1);
>         rc |= setenv("SHELL", pw->pw_shell, 1);
>         rc |= setenv("USER", pw->pw_name, 1);
> @@ -527,6 +536,7 @@ static int restore_environment(int preserve_environment,
>         free(term);
>         free(display);
>         free(xauthority);
> +       free(xdg_runtime_dir);
>         return rc;
>  }

Hello,
I am quite uncomfortable with this approach of keeping only one more
variable: why is only XDG_RUNTIME_DIR added, and not also
XDG_DATA_DIRS, XDG_SESSION_ID, XDG_SESSION_PATH, etc.? For example
someone pointed out in
https://github.com/systemd/systemd/issues/18301#issuecomment-763933678
that DBUS_SESSION_BUS_ADDRESS could also need to be preserved, so
there seem to be a long list of items.

Moreover I am wondering whether this would be fine to keep such
environment variables while newrole uses the information from another
user (i.e. when newrole is built with USE_AUDIT and
audit_getloginuid() != getuid() because the user changed their UID ;
in such a situation newrole resets $HOME and $SHELL to the HOME of
audit_getloginuid()).

In my humble opinion, I also do not understand why TERM, DISPLAY and
XAUTHORITY are kept but not LANG, LC_ALL, and all other LC_...
variables. I understand that there exist dangerous environment
variables (LD_LIBRARY_PATH, LD_PRELOAD, ...), that resetting the
environment to a minimal one is nice, and that using "newrole
--preserve-environment" could seem dangerous. For information, sudo
has been maintaining a list of "bad" variables, of variables with
potential dangerous values and of variables preserved by default, in
https://github.com/sudo-project/sudo/blob/SUDO_1_9_5p1/plugins/sudoers/env.c#L134-L228.

This being said, I have never really used newrole but to expose a bug
in "sudo -r" a few years ago
(https://bugzilla.sudo.ws/show_bug.cgi?id=611 "root user can change
its SELinux context without password"). Since then I have always used
sudo to change role, with the advantage that it can be configured to
keep some environment variables, so I am not really the best reviewer
for such a patch (and also I am a little bit confused about the
"isolation guarantees" that newrole implements, and I am not sure
whether keeping XDG_RUNTIME_DIR would not break such guarantees).

TL;DR: can another maintainer more familiar with newrole review this
patch, please?

Thanks,
Nicolas

