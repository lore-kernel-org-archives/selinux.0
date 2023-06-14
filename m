Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4157EB64D8
	for <selinux@archiver.kernel.org>; Wed, 14 Jun 2023 18:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjFNSRc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jun 2023 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjFNSRb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jun 2023 14:17:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A98CDF
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 11:17:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso14778721fa.2
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686766648; x=1689358648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aznPAIUqMVs8dWUVY2OnG9DcL+TnTMuE/l720TDfjo=;
        b=Jn+ElyzYUNDwV7C/3PiYHgtw3892tUpTmJixhADEZWL5+yZxz+OvPLP2Mb4KJ+B0T+
         a/ekByMeCVg94eP5jZk1JvVpNmJ4ZespCoRfVtj32qTpHTh/zCPL/7CdeC6Itto6b/LN
         +JYSOrZq7gF8Qvo0B91uGB0OOa3kxbG0BztG8Nk1/umAaCLwVtKKsEHiRuWqwwPdsHNf
         ubK5FRyERI8526IrOYZVJ3+IYbRgriNWKZ1FJ3yeH61WJV2MjiIpqjSsjQoUNWy8JMP7
         lRfRyBv47FBaPIuEMGIS+T/jjaiXFsysiMoWMRH7Oh0lvkm6Z3OU6szOjYF3j1PcNpuc
         lJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686766648; x=1689358648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aznPAIUqMVs8dWUVY2OnG9DcL+TnTMuE/l720TDfjo=;
        b=FYkRdLe0Jm37CXk8UxNATD5Sm3wC4TfkIONYrGR4FsbBqaZlzkiMYwKwBYtVdLplgJ
         RodNnwD6/KLPkjL36G3xV4gJ1ch2tFVYEQVvcOHGqBwLB0JVGgnPwpUYjTRhl+XbGwXt
         Fr6ctxyPS59v9mlSKfOhIes9CPZyngNIjynsPBEMq3O2gLAeuYQJqEggGzH68KrSfhcg
         MfHbVYfJILiXPouWH06rMnZmgqDgYtycMCsSbvmyM875Zf6xIy5cZPGOpRRX8VX0mIWH
         IFEIhyPdwVtpbfXJKy8yW8agM4LHoWOXo+Ed0dy+SXyzHKlq6+qxsZI5atEcnRp3yIqq
         tVdA==
X-Gm-Message-State: AC+VfDw2jgI0B4R4Wieq4jupu9tkd8PHzsgvsYkMRunbqyMMQ5GGs4OS
        QlCL9l4SO6MmWcRi+NLWZBWgvY1CL4C8OI9HPb9Wej+H8tg=
X-Google-Smtp-Source: ACHHUZ6KHaWi34bb762vCVoeQXVQSvYBmzfmULR7nf60bfUmkh+7RFECT6IOfCQLmLU2AuJS7+Cqdgx8F1ubaxMEO7o=
X-Received: by 2002:a2e:9d0f:0:b0:2b3:4b67:8a9d with SMTP id
 t15-20020a2e9d0f000000b002b34b678a9dmr1399272lji.10.1686766647452; Wed, 14
 Jun 2023 11:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230613104439.2985001-1-yamato@redhat.com> <20230613104439.2985001-2-yamato@redhat.com>
In-Reply-To: <20230613104439.2985001-2-yamato@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 14 Jun 2023 14:17:16 -0400
Message-ID: <CAP+JOzQwVEm47xuMiweAyapkegZfbvij1wBWrOd71z=h0xviQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dismod, dispol: reduce the messages in batch mode
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 13, 2023 at 6:52=E2=80=AFAM Masatake YAMATO <yamato@redhat.com>=
 wrote:
>
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  checkpolicy/test/dismod.c | 20 +++++++++++---------
>  checkpolicy/test/dispol.c |  8 +++++---
>  2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index fa729ef2..bd26c302 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -773,7 +773,7 @@ static int display_handle_unknown(policydb_t * p, FIL=
E * out_fp)
>         return 0;
>  }
>
> -static int read_policy(char *filename, policydb_t * policy)
> +static int read_policy(char *filename, policydb_t * policy, int verbose)
>  {
>         FILE *in_fp;
>         struct policy_file f;
> @@ -816,13 +816,13 @@ static int read_policy(char *filename, policydb_t *=
 policy)

You missed converting one function.
sepol_module_package_read() should also pass verbose instead of 1.

Thanks,
Jim

>                         fprintf(stderr, "%s:  Out of memory!\n", __FUNCTI=
ON__);
>                         exit(1);
>                 }
> -               retval =3D policydb_read(policy, &f, 1);
> +               retval =3D policydb_read(policy, &f, verbose);
>         }
>         fclose(in_fp);
>         return retval;
>  }
>
> -static void link_module(policydb_t * base, FILE * out_fp)
> +static void link_module(policydb_t * base, FILE * out_fp, int verbose)
>  {
>         char module_name[80] =3D { 0 };
>         int ret;
> @@ -845,8 +845,9 @@ static void link_module(policydb_t * base, FILE * out=
_fp)
>         }
>
>         /* read the binary policy */
> -       fprintf(out_fp, "Reading module...\n");
> -       if (read_policy(module_name, mods)) {
> +       if (verbose)
> +               fprintf(out_fp, "Reading module...\n");
> +       if (read_policy(module_name, mods, verbose)) {
>                 fprintf(stderr,
>                         "%s:  error(s) encountered while loading policy\n=
",
>                         module_name);
> @@ -937,12 +938,13 @@ int main(int argc, char **argv)
>         }
>
>         /* read the binary policy */
> -       fprintf(out_fp, "Reading policy...\n");
> +       if (!ops)
> +               fprintf(out_fp, "Reading policy...\n");
>         if (policydb_init(&policydb)) {
>                 fprintf(stderr, "%s:  Out of memory!\n", __FUNCTION__);
>                 exit(1);
>         }
> -       if (read_policy(mod, &policydb)) {
> +       if (read_policy(mod, &policydb, ops? 0: 1)) {
>                 fprintf(stderr,
>                         "%s:  error(s) encountered while loading policy\n=
",
>                         argv[0]);
> @@ -961,7 +963,7 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> -       if (policydb_index_others(NULL, &policydb, 1)) {
> +       if (policydb_index_others(NULL, &policydb, ops? 0: 1)) {
>                 fprintf(stderr, "Error indexing others\n");
>                 exit(1);
>         }
> @@ -1074,7 +1076,7 @@ int main(int argc, char **argv)
>                                         &policydb, out_fp);
>                         break;
>                 case 'l':
> -                       link_module(&policydb, out_fp);
> +                       link_module(&policydb, out_fp, ops? 0: 1);
>                         break;
>                 case 'v':
>                         print_version_info(&policydb, out_fp);
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index bee1a660..b567ce77 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -551,7 +551,8 @@ int main(int argc, char **argv)
>         }
>
>         /* read the binary policy */
> -       fprintf(out_fp, "Reading policy...\n");
> +       if (!ops)
> +               fprintf(out_fp, "Reading policy...\n");
>         policy_file_init(&pf);
>         pf.type =3D PF_USE_MEMORY;
>         pf.data =3D map;
> @@ -560,7 +561,7 @@ int main(int argc, char **argv)
>                 fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
>                 exit(1);
>         }
> -       ret =3D policydb_read(&policydb, &pf, 1);
> +       ret =3D policydb_read(&policydb, &pf, ops? 0: 1);
>         if (ret) {
>                 fprintf(stderr,
>                         "%s:  error(s) encountered while parsing configur=
ation\n",
> @@ -568,7 +569,8 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> -       fprintf(stdout, "binary policy file loaded\n\n");
> +       if (!ops)
> +               fprintf(stdout, "binary policy file loaded\n\n");
>         close(fd);
>
>         if (!ops)
> --
> 2.40.1
>
