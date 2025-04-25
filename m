Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A11F76A8
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601898; cv=none; b=VIOsoLZQfgLh4Ff4gkPPsAD1I+TwCWBwqIV8Bh0xpUMnKFjJcA/jrJ7xBXW+NmrxDbiyheYtW/K3MbmJtWJD6HH74Y5It52VBfvHSSFLqVaHQ8EthXWARkZZ+2Hc2MC2xFjUtg1m35c1T63XA+R0ZXGkfVQsT9DagssiAIdjS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601898; c=relaxed/simple;
	bh=KtG8ctDHSxgqQ17mrWe66nWC6Z/3OIcm/eF8ZEY97CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l19rmhlkQprFll4miEqMh7hgOphDPNnhLbQD3vYQmr5qyyAVp9LK9FnIfBuTCDYge+zOtqaGqilzsbzNdLO7ToY9PFY58EvfGYV0iOPWN0JKY0kasoulEVJKk2YXLJX8qqJN4SwTMExjr9222i+SeN/uoVSoAlHIZTO8HRFyrg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOiAqzb/; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOiAqzb/"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so973833241.0
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745601896; x=1746206696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5ZtzF1OWYveUu/RnWT0aBKv/YuqmLbFgLr7cOkIldY=;
        b=LOiAqzb/Gyr+hHOvQrXBCgkzrLlPOkyRm/JmZf+9bd0dK9dQE12zFWgh7dTF8tQCGt
         fs6WGWjdCcuAK+b9C7vNjvFl/wgYdslIeooT60KhQWEmSIwqhdAJon3w/n5WoGRv64ab
         L1jG/Zf0nGmE/eucSvaHuQGwfnz+HeZZEnpdjWYc16mpBWaoY2qVCYJVC2xqcOmKZu1F
         xEF7tKS02OdZ5WsXeoYFMpWFso6T2fPM6H2iE/67AUW+JY5U+19O9I42N9etl3ftU+jY
         lhVgXKyMz7fnFXNkrAdmW8FPGPZjzVews9IHEodv3UfC6JPgjJ/X0sms8CghgsV/bp07
         SZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745601896; x=1746206696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5ZtzF1OWYveUu/RnWT0aBKv/YuqmLbFgLr7cOkIldY=;
        b=fwIc8XikSq6elx1YxK9J9IQJuvLiDzasadQovAVGSqNjiH2AHtmBKRb93J7Vs1QaXd
         /Qv0iW28KPyMyKUOY/rZhGiNtdWV4jDk48ojCWaj3ODYzJtuucXfbgLWc3oBDdUlhq9J
         UdocAmWQPhc7jYIRl4tCxyit2ap3WcHvnwM6Ib6pUPNLoVHmwVnd5seTnmcHwQKMBYxE
         sNfbEO4iUGnqwOKJqZyZvbx7jZMl4Q21kAvJeNejeTuhhKdgSG+DCWOBDj3GFbi0oLLe
         /cimhyoAKW5UcGWzskvlffwCITMQahwzEA4rdK32uKFWWK3WYQag7RPST98ZU9oJZ3y6
         SPHw==
X-Gm-Message-State: AOJu0YwQp5AVxz0ayc6ocUzOefuVK0yHjpt8VwSXT3pEYLMITZBKyuta
	ok41dRXbMXE/py7394zzOt5G9srwb+b1BjBRfjCIR009PwdcKnxvrfV/OszsdGfgrI47XEK0K56
	Eu6mcZUZZAyZriF276opvn6mksqXLKQ==
X-Gm-Gg: ASbGnct9NPT9RNaZ+TPjgZohQnqBVNcY+UgqV1ivOa9uz5hmp10OTORsI8O2bpmv7nR
	EbM2hxCaK+Oi5LLTZ9C0QZ06+/zn44wLFynMgav4LpdLHAGBy7TLDD0j/oZ9B8ZvIl79y274tEH
	PweIrkDHjKBNMSHpkaoho=
X-Google-Smtp-Source: AGHT+IHQFBsvMUe85l2vAr/FDvkJ7EzZNFAe4vNq93Y5JADgAiSonKf3tyeeY35hD5vT/7NLMS3A2ZDIiLHhVz5uEwQ=
X-Received: by 2002:a05:6102:c01:b0:4bd:3519:44be with SMTP id
 ada2fe7eead31-4d543ebd480mr2306408137.15.1745601896117; Fri, 25 Apr 2025
 10:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzQtrLx8bS6_jb7pRaFzm=PXr9hm=Quy15qCMTFyHd8j9w@mail.gmail.com>
 <20250417020959.43450-2-tristan.ross@midstall.com> <CAP+JOzRJp=tZr-_aa9Gr1+2ZZa+rYiK1G3GzOmz6TpRunettew@mail.gmail.com>
In-Reply-To: <CAP+JOzRJp=tZr-_aa9Gr1+2ZZa+rYiK1G3GzOmz6TpRunettew@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 25 Apr 2025 13:24:45 -0400
X-Gm-Features: ATxdqUGuJu54u_GiFeJcrUJW1Qph8_JtQM97u5RlZQb-8tUZbcjLwUSo2bwFkHs
Message-ID: <CAP+JOzR0EcqOoURsr8RKvn-uFN6RSVbfpeGUAwLnyT9-im+B_A@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: add relabel_store config option
To: Tristan Ross <tristan.ross@midstall.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 10:06=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Apr 16, 2025 at 10:10=E2=80=AFPM Tristan Ross <tristan.ross@midst=
all.com> wrote:
> >
> > This flag allows for enabling or disabling automatic restorecon that
> > semodule invokes. By default, we have it enabled to produce the same
> > behavior as before. On NixOS, we need this as we're "baking" the module
> > installation into a squashfs image and we cannot run restorecon inside
> > the builder.
> >
> > Signed-off-by: Tristan Ross <tristan.ross@midstall.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/conf-parse.y     | 15 ++++++++++++++-
> >  libsemanage/src/conf-scan.l      |  1 +
> >  libsemanage/src/semanage_conf.h  |  1 +
> >  libsemanage/src/semanage_store.c |  7 +++++--
> >  4 files changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.=
y
> > index e1fc9f4f..b69ac75b 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -63,7 +63,7 @@ static int parse_errors;
> >
> >  %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_=
LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE=
_POLICY MULTIPLE_DECLS
> >  %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISAB=
LE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
> > -%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
> > +%token BZIP_BLOCKSIZE BZIP_SMALL RELABEL_STORE REMOVE_HLL
> >  %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_=
END
> >  %token PROG_PATH PROG_ARGS
> >  %token <s> ARG
> > @@ -97,6 +97,7 @@ single_opt:     module_store
> >         |       bzip_blocksize
> >         |       bzip_small
> >         |       remove_hll
> > +       |       relabel_store
> >         |       optimize_policy
> >         |       multiple_decls
> >          ;
> > @@ -291,6 +292,17 @@ remove_hll:  REMOVE_HLL'=3D' ARG {
> >         free($3);
> >  }
> >
> > +relabel_store:  RELABEL_STORE'=3D' ARG {
> > +       if (strcasecmp($3, "false") =3D=3D 0) {
> > +               current_conf->relabel_store =3D 0;
> > +       } else if (strcasecmp($3, "true") =3D=3D 0) {
> > +               current_conf->relabel_store =3D 1;
> > +       } else {
> > +               yyerror("relabel_store can only be 'true' or 'false'");
> > +       }
> > +       free($3);
> > +}
> > +
> >  optimize_policy:  OPTIMIZE_POLICY '=3D' ARG {
> >         if (strcasecmp($3, "false") =3D=3D 0) {
> >                 current_conf->optimize_policy =3D 0;
> > @@ -400,6 +412,7 @@ static int semanage_conf_init(semanage_conf_t * con=
f)
> >         conf->bzip_small =3D 0;
> >         conf->ignore_module_cache =3D 0;
> >         conf->remove_hll =3D 0;
> > +       conf->relabel_store =3D 1;
> >         conf->optimize_policy =3D 1;
> >         conf->multiple_decls =3D 1;
> >
> > diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
> > index 64433f7b..c592fb63 100644
> > --- a/libsemanage/src/conf-scan.l
> > +++ b/libsemanage/src/conf-scan.l
> > @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
> >  bzip-blocksize return BZIP_BLOCKSIZE;
> >  bzip-small     return BZIP_SMALL;
> >  remove-hll     return REMOVE_HLL;
> > +relabel_store  return RELABEL_STORE;
> >  optimize-policy return OPTIMIZE_POLICY;
> >  multiple-decls return MULTIPLE_DECLS;
> >  "[load_policy]"   return LOAD_POLICY_START;
> > diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage=
_conf.h
> > index 5db08f0c..2388faad 100644
> > --- a/libsemanage/src/semanage_conf.h
> > +++ b/libsemanage/src/semanage_conf.h
> > @@ -49,6 +49,7 @@ typedef struct semanage_conf {
> >         int ignore_module_cache;
> >         int optimize_policy;
> >         int multiple_decls;
> > +       int relabel_store;
> >         char *ignoredirs;       /* ";" separated of list for genhomedir=
con to ignore */
> >         struct external_prog *load_policy;
> >         struct external_prog *setfiles;
> > diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanag=
e_store.c
> > index 307f27f9..1731c5e8 100644
> > --- a/libsemanage/src/semanage_store.c
> > +++ b/libsemanage/src/semanage_store.c
> > @@ -1823,8 +1823,11 @@ static int semanage_commit_sandbox(semanage_hand=
le_t * sh)
> >
> >        cleanup:
> >         semanage_release_active_lock(sh);
> > -       sehandle =3D selinux_restorecon_default_handle();
> > -       selinux_restorecon_set_sehandle(sehandle);
> > +
> > +       if (sh->conf->relabel_store) {
> > +               sehandle =3D selinux_restorecon_default_handle();
> > +               selinux_restorecon_set_sehandle(sehandle);
> > +       }
> >         return retval;
> >  }
> >
> > --
> > 2.47.2
> >
> >
