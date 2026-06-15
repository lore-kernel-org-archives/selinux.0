Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D23FDC12
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535323; cv=pass; b=Yp++q6ZcHUeeJUwZBiO4GcMjZY0Lk7+BSCxEcenfrok9Cpr2PmF/jmFBSlt83K2iWJil23mB7rAOtE5s8wL8eUdj+6nx8WpISiyeKAKUWBUVxqKHi4zlKSwRD/24F3p5ysVS/mVuyAgevX4DzIz1fJ9/H4xNSCR8K7qTo+EPVKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535323; c=relaxed/simple;
	bh=0vnWaQhuYrKtnWkvdnOt3P2J+AvcCvPBT1rplyvkmxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt8Qb24J0Q8dZpxkgoxujU2zq3T4vhXk8cd9tfaivCr2iURbONJwGx2D4eRWhDqNXZHgVhG3+MS9KFkXoryh1TRI5C64UMfQvnjl+2oBrUkuKI8FcEWxPXgGbQwjIskOgncWPySo02SaMQU4uNNXKFVJPYX5stpSz0JWq1/RpC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfQAcOX5; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfQAcOX5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85893bce34so1433955a12.1
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 07:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535321; cv=none;
        d=google.com; s=arc-20240605;
        b=CIoxGYmtTJHDBdm+QPwN0O7HuXFn1Gq2kW8hX5WczgFoqNnD/HhQFNgLe4sxyaDRZ0
         knUuweOKbOF7LoDtWST/ZQExi9pf5feUq07wsKFsOGID8UW2oJKOAz83DdcbIm4tocKx
         aT3D3Ha9BptZu1R5jkAi8lCdyesH2O6N5tHcloz81ySuzbOvpWD8qX/9H92VRWiW7Eo1
         qD/RkfsLuk7OPmYxPeX8rcHQMxfXj54p3jLnIoaZB1FqBO1nz+8r7f5g2CfpW4HdpY78
         cyASJ0LBU54F9bhQBJyoRZJBGE7u6K5rW/SlTz2QeofgDXg+CEulPAvDKIjJMfAveWYw
         veYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z5cCVE4JWsjEotN4b1Xw4F6jG+VP2v2QCIg9wo3qt4Q=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=C8VRNvBRD9FCqmwllZt6bODLvPdRD9BroXasPwwh3R5jmo/sl7fVcDdI5zDjfjCy0M
         SZgD1f9rKLobjfemI/PafAnMQSyFPlcKDgTMKfFkWuX48IgFdwulObsPfu7Yf7EaL3sq
         WK4ZLqvvN66scrnGM6014xr02nHbwDLmcwbOqJNCwaXokmhN/IQwZko7rMNhe403TPD/
         DG2k84Fr/JvVQTzoAOTwjgh6dofa9z1IXotnl5qF46RM76PAywYOf9dr7dmvsn/R+B5E
         ObwKy0Pt18d8gQFYDqei45N9gEffRHid2EIASKUomQs4m8vqKwmzK5ikYEUNZsTGguCH
         cB7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535321; x=1782140121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5cCVE4JWsjEotN4b1Xw4F6jG+VP2v2QCIg9wo3qt4Q=;
        b=cfQAcOX5x3JiFx/Pnj3avKnVXC9cq9IXwWtowQRFWcVhvJ5MHXwtuufpzGkS85w4SW
         IXq7NFAcrJ3bVFTdIva23DSYZgubd3JixPgKN8C84ySOnhj6B9YW0BNV1eN31b+NNoks
         AnuDNlUqy4c/GcPLkxAg3Sv3DPjhZW/9ea873kmSJxqYC0gqjQorjetzhniuhEaE8Zpw
         xYulN1BGSbn3kovFlk2Hi++AbuZs1sL6Yk4b2YbtOMfubSgizD7rOdhQ3cXw2RBDS24/
         7Sr04f+rPximRe38w4MlKoR2rntggOIznQNrGq4l05qCgvx42Kupd8kbd/upJZKl+zCN
         wO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535321; x=1782140121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5cCVE4JWsjEotN4b1Xw4F6jG+VP2v2QCIg9wo3qt4Q=;
        b=W0H/WGicBXihriD/+01u0q1iVugbxHf33av0rt1DIzSMyVYDOx5CT7YiS/Bnpcowch
         JmZwuaVhLl9GGNc1G2df4hywG7eL9mh6v6xHGPQHrAYuo1fhc+69PbyWl9FaffHbHSlL
         x0ORaGGp09CfxM26KqyExssv2LpLl445AeOhi5s7BLoeHTOKMNxvFLwehDTPogriA2vx
         Iuds6rqWYqTRWXAtWoUKqMcWkcAbWg9cyRohXUbAScafPXbhHbIbT7Po+qKTjvHJXgWp
         Gsho5OBVv2Um/fdrz4m0JJsg35e7d6LHIsn3k+eaXbH/gF1ZfiCgIYw68Ec0NEbuhLFc
         Nyfw==
X-Gm-Message-State: AOJu0Yw30l0QDLEejM5uNIMLA6EmW9Ve+Z1Ahx+5GK9FllYNlGSIkKaL
	VBYJbEUnsQWfNmSwk/rZ6fvN5xRC00XHLLwuOpm75PM0FdVZEV4Vsdz1mMAh3f6fw/90tpY5dEA
	bNurOL27JKpA2v8a2JbU0U7GtJ0LMqJcVIA==
X-Gm-Gg: Acq92OHpsPe5Tjr5bVGQ3U3vvoGBEJWaj28/esqssRgBqwPwHyDM8D6JYtb1jEgNdAk
	vdRWiCJFQ+kvrHv37nK6zi/cuQy5j1fpx1oNg6++fh3q4xkwEyicxaio1kPv2PTBvC4rPYu+kbz
	YEbFXvg/2L2gAXg2otIl8k5+i4kvqlW6meHl+kYjnc0DUeJYqkzOJfx5QO1JhrbC5EwDQGFw10M
	9PKr9xY6SeXe9Xilxch7vt3M8ZdXRBcsmyzVXPVwUV44HNjmWg9H6T4bOfI9Qa/lHgM46rvrEOr
	/MBq8PE=
X-Received: by 2002:a05:6a20:c89b:b0:3b4:9027:712 with SMTP id
 adf61e73a8af0-3b7962d8e57mr12943936637.20.1781535320874; Mon, 15 Jun 2026
 07:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614122904.29873-1-kalevi@kolttonen.fi> <20260614122904.29873-2-kalevi@kolttonen.fi>
In-Reply-To: <20260614122904.29873-2-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 10:55:09 -0400
X-Gm-Features: AVVi8CcoYhMEmt2ZBDYI5H9owkBzNYLqh05Nw1YORDybCrbhdWcKCkHtwg1jWMM
Message-ID: <CAEjxPJ4rnyoM+nV-oTtG3ULVKKMKvSkYPR9_W5AvZF+ffYn5rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] policycoreutils: use stderr for error messages
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 8:29=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/sestatus/sestatus.c | 50 ++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestat=
us/sestatus.c
> index 637f26eb..0effc4ad 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -100,7 +100,7 @@ static void load_checks(char *pc[], int *npc, char *f=
c[], int *nfc)
>         int filelen =3D strlen(FILES);
>
>         if (fp =3D=3D NULL) {
> -               printf("\nUnable to open %s.\n", CONF);
> +               fprintf(stderr, "\nUnable to open %s.\n", CONF);
>                 return;
>         }
>
> @@ -158,8 +158,9 @@ static void load_checks(char *pc[], int *npc, char *f=
c[], int *nfc)
>                                         break;
>                                 default:
>                                         /* ignore lines before a section =
*/
> -                                       printf("Line not in a section: %s=
.\n",
> -                                              buf);
> +                                       fprintf(stderr,
> +                                               "Line not in a section: %=
s.\n",
> +                                               buf);
>                                         break;
>                                 }
>                         }
> @@ -234,7 +235,7 @@ int main(int argc, char **argv)
>                 return 0;
>                 break;
>         default:
> -               printf("unknown (%s)\n", strerror(errno));
> +               fprintf(stderr, "unknown (%s)\n", strerror(errno));
>                 return 0;
>                 break;
>         }
> @@ -251,13 +252,13 @@ int main(int argc, char **argv)
>         printf_tab("SELinux root directory:");
>         root_dir =3D selinux_path();
>         if (root_dir =3D=3D NULL) {
> -               printf("error (%s)\n", strerror(errno));
> +               fprintf(stderr, "error (%s)\n", strerror(errno));
>                 return -1;
>         }
>         /* The path has a trailing '/' so duplicate to edit */
>         root_path =3D strdup(root_dir);
>         if (!root_path) {
> -               printf("malloc error (%s)\n", strerror(errno));
> +               fprintf(stderr, "malloc error (%s)\n", strerror(errno));
>                 return -1;
>         }
>         /* actually blank the '/' */
> @@ -273,7 +274,7 @@ int main(int argc, char **argv)
>                 puts(pol_name);
>                 free(pol_path);
>         } else {
> -               printf("error (%s)\n", strerror(errno));
> +               fprintf(stderr, "error (%s)\n", strerror(errno));
>         }
>
>         printf_tab("Current mode:");
> @@ -286,7 +287,7 @@ int main(int argc, char **argv)
>                 printf("permissive\n");
>                 break;
>         default:
> -               printf("unknown (%s)\n", strerror(errno));
> +               fprintf(stderr, "unknown (%s)\n", strerror(errno));
>                 break;
>         }
>
> @@ -304,7 +305,7 @@ int main(int argc, char **argv)
>                         break;
>                 }
>         } else {
> -               printf("error (%s)\n", strerror(errno));
> +               fprintf(stderr, "error (%s)\n", strerror(errno));
>         }
>
>         printf_tab("Policy MLS status:");
> @@ -317,7 +318,7 @@ int main(int argc, char **argv)
>                 printf("enabled\n");
>                 break;
>         default:
> -               printf("error (%s)\n", strerror(errno));
> +               fprintf(stderr, "error (%s)\n", strerror(errno));
>                 break;
>         }
>
> @@ -331,7 +332,7 @@ int main(int argc, char **argv)
>                 printf("denied\n");
>                 break;
>         default:
> -               printf("error (%s)\n", strerror(errno));
> +               fprintf(stderr, "error (%s)\n", strerror(errno));
>                 break;
>         }
>
> @@ -345,14 +346,14 @@ int main(int argc, char **argv)
>                 printf("requested (insecure)\n");
>                 break;
>         default:
> -               printf("error (%s)\n", strerror(errno));
> +               fprintf(stderr, "error (%s)\n", strerror(errno));
>                 break;
>         }
>
>         rc =3D security_policyvers();
>         printf_tab("Max kernel policy version:");
>         if (rc < 0)
> -               printf("unknown (%s)\n", strerror(errno));
> +               fprintf(stderr, "unknown (%s)\n", strerror(errno));
>         else
>                 printf("%d\n", rc);
>
> @@ -377,7 +378,8 @@ int main(int argc, char **argv)
>                                         printf("off");
>                                         break;
>                                 default:
> -                                       printf("unknown (%s)", strerror(e=
rrno));
> +                                       fprintf(stderr, "unknown (%s)",
> +                                               strerror(errno));
>                                         break;
>                                 }
>                                 c =3D security_get_boolean_pending(bools[=
i]);
> @@ -390,8 +392,9 @@ int main(int argc, char **argv)
>                                                 printf(" (inactivate pend=
ing)");
>                                                 break;
>                                         default:
> -                                               printf(" (pending error: =
%s)",
> -                                                      strerror(errno));
> +                                               fprintf(stderr,
> +                                                       " (pending error:=
 %s)",
> +                                                       strerror(errno));
>                                                 break;
>                                         }
>                                 printf("\n");
> @@ -415,14 +418,14 @@ int main(int argc, char **argv)
>                 printf("%s\n", context);
>                 freecon(context);
>         } else
> -               printf("unknown (%s)\n", strerror(errno));
> +               fprintf(stderr, "unknown (%s)\n", strerror(errno));
>
>         printf_tab("Init context:");
>         if (getpidcon(1, &context) >=3D 0) {
>                 printf("%s\n", context);
>                 freecon(context);
>         } else
> -               printf("unknown (%s)\n", strerror(errno));
> +               fprintf(stderr, "unknown (%s)\n", strerror(errno));
>
>         for (i =3D 0; i < npc; i++) {
>                 rc =3D pidof(pc[i]);
> @@ -445,7 +448,7 @@ int main(int argc, char **argv)
>                 printf("%s\n", context);
>                 freecon(context);
>         } else {
> -               printf("unknown (%s)\n", strerror(errno));
> +               fprintf(stderr, "unknown (%s)\n", strerror(errno));
>         }
>
>         for (i =3D 0; i < nfc; i++) {
> @@ -454,8 +457,9 @@ int main(int argc, char **argv)
>
>                         /* check if this is a symlink */
>                         if (lstat(fc[i], &m)) {
> -                               printf("%s (could not check link status (=
%s)!)\n",
> -                                      context, strerror(errno));
> +                               fprintf(stderr,
> +                                       "%s (could not check link status =
(%s)!)\n",
> +                                       context, strerror(errno));
>                                 freecon(context);
>                                 free(fc[i]);
>                                 continue;
> @@ -469,8 +473,8 @@ int main(int argc, char **argv)
>                                         printf("%s\n", context);
>                                         freecon(context);
>                                 } else {
> -                                       printf("unknown (%s)\n",
> -                                              strerror(errno));
> +                                       fprintf(stderr, "unknown (%s)\n",
> +                                               strerror(errno));
>                                 }
>                         } else {
>                                 printf("%s\n", context);
> --
> 2.54.0
>
>
