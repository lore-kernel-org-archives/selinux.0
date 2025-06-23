Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E526F45A
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691157; cv=none; b=hfWzGQckvzAzfAe0KqziPvMkvzHpMeDd8PS0qhs9tWmA5FjN6Gj+XTwYdHqMCbUlhL/xqb3f+KoqRFpozYmZLk3q+84fGAKUSpNXkfUuOgKR5I4uIGcKMFDE6Dp126FLKcQcIhy3BlKeIDseuwFlTCkMOCt+q6Ehg2JUJHoL9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691157; c=relaxed/simple;
	bh=Z7d50j/qFB+K/6ROi74zUdP7dIE30zD90dpx5HnDrAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6kk7kTLYSN/GTMgmKh1pAJQW80ZexEOWMWzrHu7RrxNaUVE8o+AprUaA429z9+nqwWb/wF1XKXAV5KlYuuY3vGmZis8YcGQoYMJ/Rn5aB2J5fZDmUOPx8uaB8DF+Aq+wZHA/i4uwdjxp894tptMPgt0EgBYOUxIfRlNH9XHad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNOZf3+0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNOZf3+0"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6faf66905baso65627566d6.2
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750691155; x=1751295955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nnh4e9la+YeEKHOfXZvpncBELWXvr79RC6dKaUMpUfg=;
        b=eNOZf3+0nRbjntA5PBJiJSnfyPeif8uNDpF5VUi2B2qAS5ajZPB81esdVZWbgVevH8
         C6HAgUIgLumOOUGW9s429a70JUtnjvWWZQOfFlFYE6KhwsYt37M7Tg6U814PlC1OMxjI
         uiAhT5YYc496Ruytq8FdaO/5MM5lBwV5MY7C4duWVYwP308+2gJ/3FAa+ySAtmjA2mfN
         uOJGVkr1RI8XxDx7Uv1qKH3mXuJRSvHBqsBpBdyhKqaaKmVvNlbuDxlpPAeP1IiQ6a3W
         iTYD6MpyMKzVckMgsDT44u5IXxIZwWSJKRsXw0Xw/OkHJZNJSjTlxgbxsyswFWKvvkBt
         3EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691155; x=1751295955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nnh4e9la+YeEKHOfXZvpncBELWXvr79RC6dKaUMpUfg=;
        b=AHqWy8p7dQIUvHev/9W3MYsF8XUg6yZtjYu2JicsRe/bEwxS+aQT4TcPOppAPDaxTc
         eku4Nb+YS6OxibZyUOKGySSSpwMc6gOuo17qIGf7VrYHVvcPy02TggsDPEHT0PbIqhuA
         CVRRKTznbRVhvZNFyI7duWTX46lT39PNuGqa30B7Df6mGCy745InbXkdywKf63grBy0y
         KY8spUIb7EmUYfMSTZjnkvdpObX+zTc3zgLPvlTooQd04OTP9tp6cYL5I1AyLmxA4OKZ
         AMKwE2iZ9kUGE2Mn9IcPZf/MTFjcmZy3npxn9zRnPnJ4OTANdOPqUyzzvDGOJqB+71KI
         GK5w==
X-Gm-Message-State: AOJu0YyBbaF/CA8dC0w8/D9hWD2lkjC7G5mLRRhRIb/50NlQi+xaFknY
	ydBECgftQMozLNhmesc9pN6JO3JuuqwF4J8d9OrF4kEzPd44tGQIoWcJbVScm1crdwXsacui7ks
	sU3qMDmwNYKUehV8Jtl7O3B9FOHgoxCmpCZiA
X-Gm-Gg: ASbGncvK1KJkmOoVfSErLCO59z6RNmirCyt4MGd8YxXCba+vSeklwg63exMXVQYKyGF
	JxVBgB+EV9eZyrzdg4ZGjDH5+lpiIsvyUeUm+anUnVXvfWUkruVmY2D+TIY14/xaCP5zkn1kQPS
	1nDepz1PTfWGZBVD+xCyo1FiwDVqIri56h90d99C/6YlHEGxZiEkfxUA==
X-Google-Smtp-Source: AGHT+IHc07x7XRnbZNiDmTTzofgYd+CdmDUSU7bP6pQdxDQzoOKFPNDBoUX2MUcDF9/YDr6iFA9uf2ecA5GASU5rnHM=
X-Received: by 2002:a05:620a:6891:b0:7d3:9012:75d7 with SMTP id
 af79cd13be357-7d3f9946a0dmr2188549985a.43.1750691154944; Mon, 23 Jun 2025
 08:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613042737.485384-1-inseob@google.com>
In-Reply-To: <20250613042737.485384-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 11:05:44 -0400
X-Gm-Features: Ac12FXwatEqpHBQLJfLhefkQZhP1XsdgLzm6i6e_DxFBXxl3p4JfM6X2k0n1SJ0
Message-ID: <CAP+JOzTVfGWMhvCCQHp7QXKN=Scq1N8-BeBHVvi4DceAK5aaQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libsepol: Allow multiple policycap statements
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com, 
	stephen.smalley.work@gmail.com, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 12:28=E2=80=AFAM Inseob Kim <inseob@google.com> wro=
te:
>
> Same policycap statements don't conflict each other, so it's fine to
> allow multiple policycap statements to exist.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> Change since v2:
> - Remove the parent patch adding NETIF_WILDCARD
> - Follow the pattern of SEPOL_EEXIST check and destroy
> ---
>  libsepol/cil/src/cil_build_ast.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index b1f151e9..53f825ad 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -145,6 +145,9 @@ static int cil_allow_multiple_decls(struct cil_db *db=
, enum cil_flavor f_new, en
>         case CIL_OPTIONAL:
>                 return CIL_TRUE;
>                 break;
> +       case CIL_POLICYCAP:
> +               return CIL_TRUE;
> +               break;
>         default:
>                 break;
>         }
> @@ -5559,8 +5562,14 @@ int cil_gen_policycap(struct cil_db *db, struct ci=
l_tree_node *parse_current, st
>         key =3D parse_current->next->data;
>
>         rc =3D cil_gen_node(db, ast_node, (struct cil_symtab_datum*)polca=
p, (hashtab_key_t)key, CIL_SYM_POLICYCAPS, CIL_POLICYCAP);
> -       if (rc !=3D SEPOL_OK)
> -               goto exit;
> +       if (rc !=3D SEPOL_OK) {
> +               if (rc =3D=3D SEPOL_EEXIST) {
> +                       cil_destroy_policycap(polcap);
> +                       polcap =3D NULL;
> +               } else {
> +                       goto exit;
> +               }
> +       }
>
>         return SEPOL_OK;
>
> --
> 2.50.0.rc2.692.g299adb8693-goog
>
>
