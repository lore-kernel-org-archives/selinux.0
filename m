Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890E293478
	for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745435034; cv=none; b=bekyZ2SQNOPJBlTDHLFWVHOdo9thIJMy0HYWe2p9oJVdY3S85C0Q9ZuGWLUdFI1TzMhaDb5YbRvBKzEq2GjBq/vdm1k1A5AdyVeZ04Ue1azetgrU1aYxmtmv3O8TI9QT0PIHXc4ujmipRqIssTl1xoTzZoV6LKbK+kHp4CCYVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745435034; c=relaxed/simple;
	bh=SXaDJqpj8L5UsuCo8I6Rc4DMs0rKnxskuDNrbWrJzmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSN4Y9RFAHbqgVMSXq5XAyWGakZRgvJ4VSfE9ovGjnQb8dQjJGfKt6eo6BIasF0kGwuSgMfQtTxV2N0Pfr6OuMWUf+Pbtxjz5uvvxOAxl8M77UPcaSNSm3ao1VA81+/sQa7reYagSREGDOyekWCcT/QHNEMRlB4Tx+aXm35XOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Knyr6ioI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Knyr6ioI"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c3b863b8eso188802a34.2
        for <selinux@vger.kernel.org>; Wed, 23 Apr 2025 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745435031; x=1746039831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jis6YmnRrPqxKrkT+UWpZflLJvAtZ4uzw7vNZWFstc=;
        b=Knyr6ioIoLhe2j0UTMxf/XUPwRuptpdqIpCCpbHB18cJsINzm+JJBNMASm6NgqWbVx
         COAlkVZncE+yN8PtmGYboZDyLgkEapJBBKJr2rwBp23XcuNOOu6zBzMT76v7XI3Vl2rK
         /m9XuvBGhG4tPFyHJx7mn/uhORs/tjJXAw3+SZ5F3HXSyZMH3lMMzhqFKfItVuEJUsd/
         pKgmIKasa1cKwupM2BjfCCiniwr9AqugE1CDXbf7hMejTUVWDnyzZPN6CYGk1l4pbbOZ
         ZEe3P5XXuWIykJ2n59FtFOjzjtSbGtZfKpyXePvOgKRePwasD6rJ72k73et2xuPLANWC
         19Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745435031; x=1746039831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jis6YmnRrPqxKrkT+UWpZflLJvAtZ4uzw7vNZWFstc=;
        b=FkgD0pBwhnS4+JMySmBfJpa4PmT/gHPpYBaUkD55uiOfw2Dcilvam1ocNk5fuLcK4J
         LuVcS/9MgtrCKbrlsdpU8ISRU+qu0WHV2CIJWkoiqY4Wj0VVtfNJb+k/aQvIh0az/m84
         E0yTbVSeCPuCb0RpojZC0VTJILC9/he04Q/23UusYrUwbL4zqReBShwLr67KyiXeCAY8
         mauKPCAkoOv8u1gX7EptfPuaAJ9qKmt52ad3gr/Zp6JbAG+FPeytOOG54BgBKVJXbaaO
         hnC97boGc0B9VPle8/u9W5WJKzIFgzmR1a04lK/B8x1WMm5qK8RGz/6Hm7N3nR+ge+4Z
         vZtw==
X-Gm-Message-State: AOJu0YxK60z6nhcJVF2pCBsy7XTTYqJiV7mbHJPqpaKdaVSOEccoPI0l
	vqdqaPiKRFLLUuicjCxVZv89rwdiUjc/+wX6ow6abu4CMdIgIw6gAqJ2lZvHA1ZqbxxSggOfowb
	4D914tEzQAOXdO1O8xk1m8qg68pLKEg==
X-Gm-Gg: ASbGncsdVF0SzWNIPXxJqJ212jNVg36Gyw5vpb800xkcYTt1X6UJFzXg6QvpCxlEV+V
	vzqWRhRMz5seky/NUTaMngQfXvtz7gFtFwCWZZE7OC9O3LbHquADEhsRpGPjjyiMuirEz8ugZTR
	UnQ75fL3EIS8iqekERgTo=
X-Google-Smtp-Source: AGHT+IHowoXb16KP+DJAnYLIIeuBlD0oc3JfQjpdimiYVdGw1+JJdLiTD5UyPTah4mUYeOxoZFAsPIT3tmrDt1q3BBo=
X-Received: by 2002:a05:6830:368c:b0:72b:7d52:85b with SMTP id
 46e09a7af769-7304da9c51dmr43355a34.16.1745435031263; Wed, 23 Apr 2025
 12:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87bjsvzy6k.fsf@redhat.com> <20250418181256.98701-1-tristan.ross@midstall.com>
 <20250418181256.98701-2-tristan.ross@midstall.com>
In-Reply-To: <20250418181256.98701-2-tristan.ross@midstall.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 23 Apr 2025 15:03:40 -0400
X-Gm-Features: ATxdqUHSj_yGLzSw7qydz65SuniO7GnLrsBhrRFQoUXITnKrCwAlrPGGAopzp1E
Message-ID: <CAP+JOzSG74saeVmTz5kdX_Lj3B+5BO-5MbKtxU7VLBOhp-h8Vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] semodule: add config argument
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 2:13=E2=80=AFPM Tristan Ross <tristan.ross@midstall=
.com> wrote:
>
> Use "semanage_handle_create_with_path" and implement a new flag for
> handling semanage config files at specific paths.
>
> Signed-off-by: Tristan Ross <tristan.ross@midstall.com>
> ---
>  policycoreutils/semodule/semodule.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodu=
le/semodule.c
> index ebe062bf..80fd0451 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -145,6 +145,7 @@ static void usage(char *progname)
>         printf("  -v,--verbose     be verbose\n");
>         printf("  -P,--preserve_tunables        Preserve tunables in poli=
cy\n");
>         printf("  -C,--ignore-module-cache      Rebuild CIL modules compi=
led from HLL files\n");
> +       printf("  -o,--config=3DPATH use an alternate path for the semana=
ge config\n");

I know that all of the obvious letters have already been used, but I
really don't want to use "o" for this.
I think I would prefer "g" to be used.

Also, the man page needs to be updated as well.

Functionally, everything looks good to me.

Thanks,
Jim

>         printf("  -p,--path        use an alternate path for the policy r=
oot\n");
>         printf("  -S,--store-path  use an alternate path for the policy s=
tore root\n");
>         printf("  -c, --cil extract module as cil. This only affects modu=
le extraction.\n");
> @@ -210,6 +211,7 @@ static void parse_command_line(int argc, char **argv)
>                 {"enable", required_argument, NULL, 'e'},
>                 {"disable", required_argument, NULL, 'd'},
>                 {"path", required_argument, NULL, 'p'},
> +               {"config", required_argument, NULL, 'o'},
>                 {"store-path", required_argument, NULL, 'S'},
>                 {"checksum", 0, NULL, 'm'},
>                 {NULL, 0, NULL, 0}
> @@ -223,7 +225,7 @@ static void parse_command_line(int argc, char **argv)
>         check_ext_changes =3D 0;
>         priority =3D 400;
>         while ((i =3D
> -               getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:=
E:cHm",
> +               getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:o:=
S:E:cHm",
>                             opts, &longind)) !=3D -1) {
>                 switch (i) {
>                 case '\0':
> @@ -304,6 +306,14 @@ static void parse_command_line(int argc, char **argv=
)
>                 case 'C':
>                         ignore_module_cache =3D 1;
>                         break;
> +               case 'o':
> +                       sh =3D semanage_handle_create_with_path(optarg);
> +                       if (!sh) {
> +                               fprintf(stderr, "%s:  Could not create se=
manage handle\n",
> +                                       argv[0]);
> +                               exit(1);
> +                       }
> +                       break;
>                 case 'X':
>                         set_mode(PRIORITY_M, optarg);
>                         break;
> @@ -421,11 +431,13 @@ int main(int argc, char *argv[])
>         if (build || check_ext_changes)
>                 commit =3D 1;
>
> -       sh =3D semanage_handle_create();
>         if (!sh) {
> -               fprintf(stderr, "%s:  Could not create semanage handle\n"=
,
> -                       argv[0]);
> -               goto cleanup_nohandle;
> +               sh =3D semanage_handle_create();
> +               if (!sh) {
> +                       fprintf(stderr, "%s:  Could not create semanage h=
andle\n",
> +                               argv[0]);
> +                       goto cleanup_nohandle;
> +               }
>         }
>
>         if (store) {
> --
> 2.47.2
>
>
