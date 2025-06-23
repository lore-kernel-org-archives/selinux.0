Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D646BF
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704448; cv=none; b=edM0xe5j3F0/o2CSFB3t8aW6Bb4IkQtcsAtMsmI2rHD6qlZFpbb3NkcW4QG7jTmWCqwNrqty7NORnCFFgnC8uhJ0YlopTyIZXoS8B2u7+vbV/6M68/CJVyH4f0DGQ6dTIz/yBmXZfSRRfQMm6Hm5ApuBAqd0X7REKD9+/MzRJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704448; c=relaxed/simple;
	bh=601easXTeglc7Ylmdd9vwwfB7o/Golm3j4LTNEKE7kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVz7uPUToJXfOqR+K6w1uxTKH7ljVVv6Lvw08fhV6bl7EIf0RjC+pgLbYyV8tjTedUR5p3nkW/cbe+OWWdvvFjXoUcdgiLD+kLZNG/9CePrZC87GXg2aBcP+1Neis0xCXVMovmxYcJFfluyLnHUZ8QtuQlQhGHk2WWUVZiijHfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWEcijND; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWEcijND"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87f2adec2b7so1475892241.0
        for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750704446; x=1751309246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqKBJlGtQxpuGFZy+rmBHNcmqyutJWhx31Nqv3L5YF8=;
        b=HWEcijNDyvtaT7Q+TfzeMz0yBE+ehEJ0iwz2kTVXT9xaN4Nfiu/gEUPEUtloyX5vOv
         7NcCITHedZpdOzebeIUoTa9CQn9jr/7GMBAAdtMnJrIjbMpoJ8CZRbgUCZ2LM3D1pvUe
         th6dnuCly7t9xsR+TFWasw5SL2vGXjCOO+YJ60ytQnYz2A+tgwmV3WK2olMnXHGLi+nc
         MnO7qxpCix5Z7M+bThDGtdmF4vrjUFf+qD6m+kXTQ5eDZyMc3/e1FObjSIyySj6qspBa
         Vtt9J7FWx82JaNn3uS6aknPR+42SHiz0UIEHFJlUfBNV8isdoH/pToYcSC1zRYjdSTzv
         fO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704446; x=1751309246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqKBJlGtQxpuGFZy+rmBHNcmqyutJWhx31Nqv3L5YF8=;
        b=DNJSw8dsosI+9aP1J9iBFe2iAftLDUb7CtRI52gGtvEldQNn7oiwuhD04uBABFEjy2
         hnIfjF0aMy+/cB6EWg+Mfb9xkwCkH4IJkMBIUUlFofCIcnl5cq9XqLlH7JdFye+n57he
         DpHbJjR7h1GJ0XezP3whYpd95QNYrHIsgR0pF2/Cs7QY4HdG/Hn5Z2iFpgKGDjZzdpRg
         djHJgvJivxmP4T8UQGD70aUTOodQmged/Ilu9qKpBHZUO9u489GS2OAF+sOaghl1GE1F
         zDrwlIpP38wLHfYp+Ije69EZBK3Tdx8Zcad+GQmEoRtptv/I5NBflASTSJGbK4wpL42u
         eqKA==
X-Gm-Message-State: AOJu0YzthQ2SYY3MlgUwGyxOwemWGYviO6Gcv93LSFJUxMhzyotMmgEr
	tjNDh+cJzKlhAcYcVspx9ybg+D2hwjcxfAFnD4y8NPr4tCnZ0vkgFaapYmNAOdYWZqu3HaikuPb
	Tac/bV5ZoviGE9ZqaGcOS+dD+U1Pjq2E=
X-Gm-Gg: ASbGncuwtYVPE2dkISJ75/IJZaAA+CUjdWQR+zne0G921F9eIRzILAy+1hZbcCS6ow0
	47GskSK0Ws33Rh2z6Y/ccbpaL8irREyqWze0wluyXywWcaCAHZP2fQH3fzc5xPuC61JD/fy0zjc
	T4n+DjuBqdIwPVbhBJLtrdX8OiIptuU2QQx6seagCU
X-Google-Smtp-Source: AGHT+IEExAJavkv/9oZBXVXMhdYLqO17n8SctC9O6oYtTWd7o9ycyDjWQpLTo05Jk8Z9a9azLQpar6GyBdnbClohvLU=
X-Received: by 2002:a05:6102:8016:b0:4df:9e8b:8cad with SMTP id
 ada2fe7eead31-4e9c2c6dcb7mr8198418137.22.1750704445927; Mon, 23 Jun 2025
 11:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613042737.485384-1-inseob@google.com> <CAP+JOzTVfGWMhvCCQHp7QXKN=Scq1N8-BeBHVvi4DceAK5aaQg@mail.gmail.com>
In-Reply-To: <CAP+JOzTVfGWMhvCCQHp7QXKN=Scq1N8-BeBHVvi4DceAK5aaQg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 23 Jun 2025 14:47:14 -0400
X-Gm-Features: Ac12FXzrhijm3QwtemVCXZg6-m6887VMUTsYIxAVPtH_JAeqL3F8fWYXDE8WskQ
Message-ID: <CAP+JOzQWD5LggvxKunExGr-aK65kiR5dqi7ost1u24r9H1WPHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] libsepol: Allow multiple policycap statements
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com, 
	stephen.smalley.work@gmail.com, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:05=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, Jun 13, 2025 at 12:28=E2=80=AFAM Inseob Kim <inseob@google.com> w=
rote:
> >
> > Same policycap statements don't conflict each other, so it's fine to
> > allow multiple policycap statements to exist.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
> >
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > Change since v2:
> > - Remove the parent patch adding NETIF_WILDCARD
> > - Follow the pattern of SEPOL_EEXIST check and destroy
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index b1f151e9..53f825ad 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -145,6 +145,9 @@ static int cil_allow_multiple_decls(struct cil_db *=
db, enum cil_flavor f_new, en
> >         case CIL_OPTIONAL:
> >                 return CIL_TRUE;
> >                 break;
> > +       case CIL_POLICYCAP:
> > +               return CIL_TRUE;
> > +               break;
> >         default:
> >                 break;
> >         }
> > @@ -5559,8 +5562,14 @@ int cil_gen_policycap(struct cil_db *db, struct =
cil_tree_node *parse_current, st
> >         key =3D parse_current->next->data;
> >
> >         rc =3D cil_gen_node(db, ast_node, (struct cil_symtab_datum*)pol=
cap, (hashtab_key_t)key, CIL_SYM_POLICYCAPS, CIL_POLICYCAP);
> > -       if (rc !=3D SEPOL_OK)
> > -               goto exit;
> > +       if (rc !=3D SEPOL_OK) {
> > +               if (rc =3D=3D SEPOL_EEXIST) {
> > +                       cil_destroy_policycap(polcap);
> > +                       polcap =3D NULL;
> > +               } else {
> > +                       goto exit;
> > +               }
> > +       }
> >
> >         return SEPOL_OK;
> >
> > --
> > 2.50.0.rc2.692.g299adb8693-goog
> >
> >
