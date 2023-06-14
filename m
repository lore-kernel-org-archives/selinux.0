Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55429EB64D8
	for <selinux@archiver.kernel.org>; Wed, 14 Jun 2023 19:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjFNTy4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbjFNTyw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jun 2023 15:54:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6395
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 12:54:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b4420a8c44so1798401fa.2
        for <selinux@vger.kernel.org>; Wed, 14 Jun 2023 12:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686772489; x=1689364489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdSLfV2N5Cu9p5Ql+sv3if5NncBehzjcHIQOu6CwXO0=;
        b=i4g9ImJWYYBk60Y5i8vhKW5omRK1QdyBVJkF8j78ytg/m2oqZaTw8T7CaJ32Ku3d4X
         UBu/ACRmyxOTwNCZDadpjRBXlauFezZGWREEicGCY7OBlfkeZpJM/IqVZg26sUnRjk+/
         8cmUUjQq9Y22xGqFyPbgvpo/pXly4rlJmJEUUKD8wdmUOjl0aazmJxt6ZLlZtfLxza9G
         KElVLq8NkLkeFZ1ARP47x8psJmS6Qie8gL9di0mqwZa/mub/dEw1VGTyHSujo8yVdQfz
         BtP75Kbv0ilOPhlO5ROLRGjSiC+a8cr4goWGhAgmFBhqr9syKobjmyjH43jh0Psjghf0
         WGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686772489; x=1689364489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdSLfV2N5Cu9p5Ql+sv3if5NncBehzjcHIQOu6CwXO0=;
        b=bltq+FKXRXbkiTS6TKpOsnqTxLkv07O/75tvnl8c0ImSijKRYxkeEVP9JjmrK8fz/s
         aLk5R1cFBh5oN1yKMjq2kEUvOphKVIlwH7kUBN4SG5w5U48wK9YRcIHnQPpE8GyByky/
         mVa5WGUjpKO+1npfvfc8EgRyPhsETt8MCl8VpTMw5czmGNbvhS3Htvmg2DdeF53Kjzdk
         9Zc4eqC5UDyXD3HJbm7ZQk20Z/pjNZO1iqjHMWSEqGPFm8aViVQXKF54i0ZPMtsBBpzP
         HxDp3qD+SgyisfuNh4ULkgMYtZKYm+vqznG2FnFf750s9gSFqTpQPB6aeSY5R0Py4dnq
         /2zA==
X-Gm-Message-State: AC+VfDw5Tsl/NswqLt5HVfIa7PvKAZnh5TW9Yo5+kbVRsKRMIA7eOc5U
        ryb67drJ25gO8M0cN3nyEFflzWylXD7bjSwWfMmidC51mOQ=
X-Google-Smtp-Source: ACHHUZ6HzJMXTPHNVW23OMUyWAv4SGD9qMzAlbXMFxegnN3I3M11MjHQbkHJWDJSRxG4qaLgXvJGN437cj68jj6W3to=
X-Received: by 2002:a2e:3c08:0:b0:2b3:4891:eb01 with SMTP id
 j8-20020a2e3c08000000b002b34891eb01mr2183813lja.20.1686772488885; Wed, 14 Jun
 2023 12:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230614191658.3356192-1-yamato@redhat.com>
In-Reply-To: <20230614191658.3356192-1-yamato@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 14 Jun 2023 15:54:37 -0400
Message-ID: <CAP+JOzQXyjmqh65=uXi18Z7_yNAg0ne0cPhxyXs7miqfb5F0Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dismod: print the policy version only in
 interactive mode
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 14, 2023 at 3:23=E2=80=AFPM Masatake YAMATO <yamato@redhat.com>=
 wrote:
>
> Instead, a new action, 'v' for printing the policy (and/or
> module) version in batch mode is added.
>
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>

For both patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/test/dismod.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 515fc9a5..fa729ef2 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -91,6 +91,7 @@ static struct command {
>         {CMD|NOOPT, 'l', "Link in a module"},
>         {CMD,       'u', "Display the unknown handling setting"},
>         {CMD,       'F', "Display filename_trans rules"},
> +       {CMD,       'v', "display the version of policy and/or module"},
>         {HEADER, 0, ""},
>         {CMD|NOOPT, 'f',  "set output file"},
>         {CMD|NOOPT, 'm',  "display menu"},
> @@ -899,6 +900,19 @@ static int menu(void)
>         return 0;
>  }
>
> +static void print_version_info(policydb_t * p, FILE * fp)
> +{
> +       if (p->policy_type =3D=3D POLICY_BASE) {
> +               fprintf(fp, "Binary base policy file loaded.\n");
> +       } else {
> +               fprintf(fp, "Binary policy module file loaded.\n");
> +               fprintf(fp, "Module name: %s\n", p->name);
> +               fprintf(fp, "Module version: %s\n", p->version);
> +       }
> +
> +       fprintf(fp, "Policy version: %d\n\n", p->policyvers);
> +}
> +
>  int main(int argc, char **argv)
>  {
>         char *ops =3D NULL;
> @@ -952,17 +966,10 @@ int main(int argc, char **argv)
>                 exit(1);
>         }
>
> -       if (policydb.policy_type =3D=3D POLICY_BASE) {
> -               printf("Binary base policy file loaded.\n");
> -       } else {
> -               printf("Binary policy module file loaded.\n");
> -               printf("Module name: %s\n", policydb.name);
> -               printf("Module version: %s\n", policydb.version);
> -       }
> -
> -       printf("Policy version: %d\n\n", policydb.policyvers);
> -       if (!ops)
> +       if (!ops) {
> +               print_version_info(&policydb, stdout);
>                 menu();
> +       }
>         for (;;) {
>                 if (ops) {
>                         puts("");
> @@ -1069,6 +1076,9 @@ int main(int argc, char **argv)
>                 case 'l':
>                         link_module(&policydb, out_fp);
>                         break;
> +               case 'v':
> +                       print_version_info(&policydb, out_fp);
> +                       break;
>                 case 'q':
>                         policydb_destroy(&policydb);
>                         exit(0);
> --
> 2.40.1
>
