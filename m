Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E45C433DB
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 15:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9CC235FA
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 15:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbhAMPAF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAMPAE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 10:00:04 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3947DC061575
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 06:59:24 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f11so2859445ljm.8
        for <selinux@vger.kernel.org>; Wed, 13 Jan 2021 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uv6QpP0+/Hr80Ldu+eWADqzc0WQm3zMW2M7TK0ZKWw=;
        b=VHoJVzk/+NmdhxhhU3OjCClvZ0u3oRtxGszhhYNmTWxDO99VQANZLdnZLafhZfMRgx
         Uq0QqSmCMic06xvwhrvwN6op3Un8GbLp5F+JWfbrcbaxh7bGfhZBwiaNuOe/uj/uVyAZ
         SwqkAyW6LVJvJowG1IVnau2gOMkb5F/Pk0kvew2SQIlovDodg8RGSXU3q73g7eGUhmLz
         Wc5c+gcE2aCRMcnRXV+cbhMSkgdsSdBV1+GUEmD8+bkLCl+01AxWG6LVLZCKhgNZNH6b
         93DRVsgFYFhpWH4TUpxSTjBem1yLVFweMAoQ4Ujky3SvDTTHX2I5SoNO4zV35s/qEIiq
         ViQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uv6QpP0+/Hr80Ldu+eWADqzc0WQm3zMW2M7TK0ZKWw=;
        b=ouT52Kw0/07NfkZRb4IRmicsXG8ZT9yO/39SnrdH8ubK0U4ymEdUCZYrrouoUvS5xW
         cpSCWcUH9kptBEOV+TjkmkcJd4G9JTdG69Na5waG4Ql5hZF9SfEz4ZGFUUDF2L3YsLn0
         r1Jos8pLpw4oRnpSXbDQP4IZ7YbzD3+Ng9vq581qrIyuGqPvc8vmEfMFEPSStWnhqlya
         x3cmbGsPI7AcXdYgVErT/ff3WdYBwDpg/jS6Pde56ZQA30vWCMM3s0F8tTn15mnctK9p
         xdUUIs9HkbKirVUzGOWq1ihsYf0nfis6CWX47rcE4l9pQVgJOY07WbjJbDzFPnIDLnj2
         VzAw==
X-Gm-Message-State: AOAM530qyPqqpeFLxKLSVz1swWKGJ1VVvRAkT6GAgPsfHkoWXyJov9ap
        9h8A8ljQorEv2RQz7v8Un/UJwMIpT472+mCsz6ryHyX7
X-Google-Smtp-Source: ABdhPJxzX7NKjTq4Y12hgeCliTZcKUR1Yj7RqMBpBdY0LRzFxCsHWE7gie3m6PKkEEnxlWp/iI4Qstbf05wz4jwuBBo=
X-Received: by 2002:a05:651c:1192:: with SMTP id w18mr1095471ljo.40.1610549962745;
 Wed, 13 Jan 2021 06:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20210113121120.164565-1-plautrba@redhat.com>
In-Reply-To: <20210113121120.164565-1-plautrba@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 13 Jan 2021 09:59:11 -0500
Message-ID: <CAEjxPJ527_NmMn+_gpKMHrq4iDtB2T4UPMEtsBtfzfD6YYF+Vg@mail.gmail.com>
Subject: Re: [PATCH] setfiles: Do not abort on labeling error
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 13, 2021 at 7:15 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Commit 602347c7422e ("policycoreutils: setfiles - Modify to use
> selinux_restorecon") changed behavior of setfiles. Original
> implementation skipped files which it couldn't set context to while the
> new implementation aborts on them. setfiles should abort only if it
> can't validate 10 contexts from spec_file.
>
> Reproducer:
>
>     # mkdir -p r/1 r/2 r/3
>     # touch r/1/1 r/2/1
>     # chattr +i r/2/1
>     # touch r/3/1
>     # setfiles -r r -v /etc/selinux/targeted/contexts/files/file_contexts r
>     Relabeled r from unconfined_u:object_r:mnt_t:s0 to unconfined_u:object_r:root_t:s0
>     Relabeled r/2 from unconfined_u:object_r:mnt_t:s0 to unconfined_u:object_r:default_t:s0
>     setfiles: Could not set context for r/2/1:  Operation not permitted
>
> r/3 and r/1 are not relabeled.
>
> Also drop some old unused code in order to prevent future confusion.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  policycoreutils/setfiles/setfiles.c | 49 +----------------------------
>  1 file changed, 1 insertion(+), 48 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> index 422c3767b845..b96ee814bad2 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -23,14 +23,6 @@ static int nerr;
>
>  #define STAT_BLOCK_SIZE 1
>
> -/* setfiles will abort its operation after reaching the
> - * following number of errors (e.g. invalid contexts),
> - * unless it is used in "debug" mode (-d option).
> - */
> -#ifndef ABORT_ON_ERRORS
> -#define ABORT_ON_ERRORS        10
> -#endif
> -
>  #define SETFILES "setfiles"
>  #define RESTORECON "restorecon"
>  static int iamrestorecon;
> @@ -56,15 +48,6 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
>         exit(-1);
>  }
>
> -void inc_err(void)
> -{
> -       nerr++;
> -       if (nerr > ABORT_ON_ERRORS - 1 && !r_opts.debug) {
> -               fprintf(stderr, "Exiting after %d errors.\n", ABORT_ON_ERRORS);
> -               exit(-1);
> -       }
> -}
> -
>  void set_rootpath(const char *arg)
>  {
>         if (strlen(arg) == 1 && strncmp(arg, "/", 1) == 0) {
> @@ -82,27 +65,6 @@ void set_rootpath(const char *arg)
>         }
>  }
>
> -int canoncon(char **contextp)
> -{
> -       char *context = *contextp, *tmpcon;
> -       int rc = 0;
> -
> -       if (policyfile) {
> -               if (sepol_check_context(context) < 0) {
> -                       fprintf(stderr, "invalid context %s\n", context);
> -                       exit(-1);
> -               }
> -       } else if (security_canonicalize_context_raw(context, &tmpcon) == 0) {
> -               free(context);
> -               *contextp = tmpcon;
> -       } else if (errno != ENOENT) {
> -               rc = -1;
> -               inc_err();
> -       }
> -
> -       return rc;
> -}
> -
>  #ifndef USE_AUDIT
>  static void maybe_audit_mass_relabel(int mass_relabel __attribute__((unused)),
>                                 int mass_relabel_errs __attribute__((unused)))
> @@ -181,6 +143,7 @@ int main(int argc, char **argv)
>         policyfile = NULL;
>         nerr = 0;
>
> +       r_opts.abort_on_error = 0;
>         r_opts.progname = strdup(argv[0]);
>         if (!r_opts.progname) {
>                 fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
> @@ -193,7 +156,6 @@ int main(int argc, char **argv)
>                  * setfiles:
>                  * Recursive descent,
>                  * Does not expand paths via realpath,
> -                * Aborts on errors during the file tree walk,
>                  * Try to track inode associations for conflict detection,
>                  * Does not follow mounts (sets SELINUX_RESTORECON_XDEV),
>                  * Validates all file contexts at init time.
> @@ -201,7 +163,6 @@ int main(int argc, char **argv)
>                 iamrestorecon = 0;
>                 r_opts.recurse = SELINUX_RESTORECON_RECURSE;
>                 r_opts.userealpath = 0; /* SELINUX_RESTORECON_REALPATH */
> -               r_opts.abort_on_error = SELINUX_RESTORECON_ABORT_ON_ERROR;
>                 r_opts.add_assoc = SELINUX_RESTORECON_ADD_ASSOC;
>                 /* FTS_PHYSICAL and FTS_NOCHDIR are always set by selinux_restorecon(3) */
>                 r_opts.xdev = SELINUX_RESTORECON_XDEV;
> @@ -225,7 +186,6 @@ int main(int argc, char **argv)
>                 iamrestorecon = 1;
>                 r_opts.recurse = 0;
>                 r_opts.userealpath = SELINUX_RESTORECON_REALPATH;
> -               r_opts.abort_on_error = 0;
>                 r_opts.add_assoc = 0;
>                 r_opts.xdev = 0;
>                 r_opts.ignore_mounts = 0;
> @@ -420,13 +380,6 @@ int main(int argc, char **argv)
>                                 usage(argv[0]);
>                 }
>
> -               /* Use our own invalid context checking function so that
> -                * we can support either checking against the active policy or
> -                * checking against a binary policy file.
> -                */
> -               cb.func_validate = canoncon;
> -               selinux_set_callback(SELINUX_CB_VALIDATE, cb);
> -

I could be wrong but I think we still need this for setfiles -c.
