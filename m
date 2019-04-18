Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BBFC10F0E
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 15:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2899A205F4
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 15:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIB+UH3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbfDRPLm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:11:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37374 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRPLm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 11:11:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id c16so1998855otn.4
        for <selinux@vger.kernel.org>; Thu, 18 Apr 2019 08:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJxhg+MNg6rao6Fp6FMw9bHd11bGDzY52YeIOcRudW8=;
        b=YIB+UH3ZhBhcUv8sPbuE8LUW+t0xvBv5OL0xo64z5Q0m/2T6WcnkkcxVoZqGvY51wW
         zV78MdLL7CLBz/v3buGLu3AeA54In/Up75yb1VbuJUyTWjjluBHQpLKvTiL4HP7bul0h
         fKCFxzlzlWKbvjcZyE98C1eQMe24IKOgozsZjGegszGnREtJbR07Bbfj57eWZDo4dqji
         CmdAZnbBRo4Wh+7n2zYdhvhjmubljH62H0jeRAbvdPt7VD7YxXS4V2Z7HtjK9QY/nGLD
         KK132agRAzJLtcAQPZ1N53g9adDM45qTVzMn19suNEVz0MIOwbgCDHY8ofr0aH5Lh+of
         Dj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJxhg+MNg6rao6Fp6FMw9bHd11bGDzY52YeIOcRudW8=;
        b=adq+FC35xfSi5S4cr462uItjSGWM8I5/JzDjdZ4whJpmV/CSFMIzIwpsJGAnBJXyro
         XS5qbmgX7g2C5fl30cVNf34sKSlSok+rr/NbU+Zkxt2sita8c8VVj9RGs6D1pZqED/am
         bokw53Fh1zHStfsNY/UKCEilHfubH/kmhGRUgnJdpZCeNw+IRiZgRcbT53L99YK8wsdX
         QRLn3v+8S3y2jBtFaYS0MfvYp+Q1lhZerbfQxswz7FSKWFGVbhfVoeGzVAHLOaf3aUWu
         uAjCJ/mEEgczs3pXEF4FtcX23+gOBCuD/kqW8sWsqdRjFjyQsT3Jv8MiyGb/De09T9jF
         LJ6Q==
X-Gm-Message-State: APjAAAXsZV4uDpcdQnEDhENFZJaEcgESiE1/F61LLb9kezQUhwYYIEKb
        DYo+qR+eZjW42OnB4ZiNZ/KBRGStVQbiSVUvtPKUKV39
X-Google-Smtp-Source: APXvYqzwoBRt7ubziDhbq3kkft1qI/UTZ28WGLi2tLWotQcs46Z2NMnsLl9/BtzXG6WlFMCMTodSoq9vFg6rIyg5Ahs=
X-Received: by 2002:a05:6830:2009:: with SMTP id e9mr61156466otp.142.1555600300906;
 Thu, 18 Apr 2019 08:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190417163731.3434-1-gary.tierney@fastmail.com> <20190417163731.3434-2-gary.tierney@fastmail.com>
In-Reply-To: <20190417163731.3434-2-gary.tierney@fastmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 18 Apr 2019 08:11:29 -0700
Message-ID: <CAFftDdrYssqXxp7MA9jn7UeYAAEqEbxSEPFT-Ej6yK7neQDG9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkmodule: add support for specifying module policy version
To:     Gary Tierney <gary.tierney@fastmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 17, 2019 at 9:37 AM Gary Tierney <gary.tierney@fastmail.com> wrote:
>
> Currently checkpolicy can produce binary policies for earlier policy versions
> to provide support for building policies on one machine and loading/analyzing
> them on another machine with an earlier version of the kernel or libsepol,
> respectively. However, checkmodule was lacking this capability.
>
> This commit adds an identical `-c` flag that can be passed to checkmodule that
> will build a modular policy file of the specified version.
>
> Signed-off-by: Gary Tierney <gary.tierney@fastmail.com>
> ---
>  checkpolicy/checkmodule.8 |  5 ++++-
>  checkpolicy/checkmodule.c | 29 +++++++++++++++++++++++++++--
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
> index cf76591c24d0..e55582f30ec0 100644
> --- a/checkpolicy/checkmodule.8
> +++ b/checkpolicy/checkmodule.8
> @@ -38,7 +38,7 @@ Generate a non-base policy module.
>  Enable the MLS/MCS support when checking and compiling the policy module.
>  .TP
>  .B \-V,\-\-version
> - Show policy versions created by this program.  Note that you cannot currently build older versions.
> +Show policy versions created by this program.
>  .TP
>  .B \-o,\-\-output filename
>  Write a binary policy module file to the specified filename.
> @@ -47,6 +47,9 @@ and will not generate a binary module at all.
>  .TP
>  .B \-U,\-\-handle-unknown <action>
>  Specify how the kernel should handle unknown classes or permissions (deny, allow or reject).
> +.TP
> +.B \-c policyvers
> +Specify the policy version, defaults to the latest.
>
>  .SH EXAMPLE
>  .nf
> diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
> index 8edc1f8c7bbd..3bb9e5a4a6b3 100644
> --- a/checkpolicy/checkmodule.c
> +++ b/checkpolicy/checkmodule.c
> @@ -142,6 +142,8 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
>         printf("  -m         build a policy module instead of a base module\n");
>         printf("  -M         enable MLS policy\n");
>         printf("  -o FILE    write module to FILE (else just check syntax)\n");
> +       printf("  -c VERSION build a policy module targeting a modular policy version (%d-%d)\n",
> +              MOD_POLICYDB_VERSION_MIN, MOD_POLICYDB_VERSION_MAX);
>         exit(1);
>  }
>
> @@ -163,7 +165,7 @@ int main(int argc, char **argv)
>                 {NULL, 0, NULL, 0}
>         };
>
> -       while ((ch = getopt_long(argc, argv, "ho:bVU:mMC", long_options, NULL)) != -1) {
> +       while ((ch = getopt_long(argc, argv, "ho:bVU:mMCc:", long_options, NULL)) != -1) {
>                 switch (ch) {
>                 case 'h':
>                         usage(argv[0]);
> @@ -194,7 +196,6 @@ int main(int argc, char **argv)
>                         usage(argv[0]);
>                 case 'm':
>                         policy_type = POLICY_MOD;
> -                       policyvers = MOD_POLICYDB_VERSION_MAX;
>                         break;
>                 case 'M':
>                         mlspol = 1;
> @@ -202,6 +203,30 @@ int main(int argc, char **argv)
>                 case 'C':
>                         cil = 1;
>                         break;
> +               case 'c': {
> +                       long int n;
> +                       errno = 0;
> +                       n = strtol(optarg, NULL, 10);
> +
> +                       if (errno) {

Get rid of this newline between the strtol() and errno.

> +                               fprintf(stderr,
> +                                       "Invalid policyvers specified: %s\n",
> +                                       optarg);
> +                               usage(argv[0]);
> +                       }
> +
> +                       if (n < MOD_POLICYDB_VERSION_MIN
> +                           || n > MOD_POLICYDB_VERSION_MAX) {
> +                               fprintf(stderr,
> +                                       "policyvers value %ld not in range %d-%d\n",
> +                                       n, MOD_POLICYDB_VERSION_MIN,
> +                                       MOD_POLICYDB_VERSION_MAX);
> +                               usage(argv[0]);
> +                       }
> +
> +                       policyvers = n;
> +                       break;
> +               }
>                 default:
>                         usage(argv[0]);
>                 }
> --
> 2.17.2
>
