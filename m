Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68CC61D9B
	for <selinux@archiver.kernel.org>; Wed, 22 Nov 2023 13:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbjKVNvt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Nov 2023 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbjKVNvs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Nov 2023 08:51:48 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8A619D
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 05:51:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507c5249d55so9936123e87.3
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 05:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700661099; x=1701265899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4CJzom1cypymR59f4AmVShmtfs03iug80FoT2cN73yA=;
        b=WpRzF56S1o3E4l/pqwXdW2J5lz1kUTDV4G1d+iEo5OxY5DYoSWahyUrw8L2azRHZK9
         U2mBYty8JTDHnGGldMCPGpBYySX2CPas4zpjC/Lns12Sev+A7mL2LpN75fIURJpEvSir
         CWJ9vdxOlC0e6KdH+nUuTM+mmbreusRmVEnvdEsDH8HX5FzsTGoGI1ohFKpfP6ps8jxo
         8h10idpWjhKXiwYjfDeZHjgYStzU8ndXgTRVG/CUkIylzl+G29htCOStCPXOv5z6tfx2
         /8rBZlCfpHqx8oRmid9TPBaE0RcZvwwe78F87I963Xqxl/HMeQJaMbCJR3rx9XxUN2bJ
         Ll+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661099; x=1701265899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CJzom1cypymR59f4AmVShmtfs03iug80FoT2cN73yA=;
        b=d+nP/mpsDEOGz1vAlyDaAsFOJcNnYIsg6U3IaMd9sQYYJHyNb5jmfGXHTT/g/b33VS
         4ft03cb9Kv7TiRXrmpoxXQIvuOETwm1O3JqDZ93slNAgOc/VUqhqKOt7mwy8F2mXc+jx
         lKdXFtUhHuwOezWkr+pOCaW9aca2/Ida+2VmkeqMbSks8OLO1XD2ZYeJ12qAc9r2Phwe
         EMa0f94CGbDn9VPynWXKfVfLrQJGNJm/LHaWKyt53D+qXnZ2ONuRiUR47UnNZQ6fea2P
         P9ZgXmY6AnUCAObTVkw/jJC/nsgkEyZGTTjU7EHAT29QUbpy9sYgCrIqqha7leMKfved
         gFKw==
X-Gm-Message-State: AOJu0Yw7KLWrqKpqwZFhIposOyLAxPJ0edIDOggNhYp0Gfp8qe7m2f9O
        hKGi/uWULnYzZ91gZZYnV3FDXWZSF85H6w/OF9w=
X-Google-Smtp-Source: AGHT+IEjbBA3ENSRa1bz8ne37PtVNoQhEhumvp7XZjSo3vN6jJQc+kjAy/kCIw6mko0us4Mw+Ba55Vvy5Uhf3SeBWXA=
X-Received: by 2002:ac2:5057:0:b0:500:cb2b:8678 with SMTP id
 a23-20020ac25057000000b00500cb2b8678mr322853lfm.40.1700661098129; Wed, 22 Nov
 2023 05:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20231121123348.2489134-1-juraj@jurajmarcin.com>
In-Reply-To: <20231121123348.2489134-1-juraj@jurajmarcin.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 22 Nov 2023 08:51:26 -0500
Message-ID: <CAP+JOzR_746qHKFTvYU=TrOuTtSM+wYwTPPMzq3qYq2fUB7jOA@mail.gmail.com>
Subject: Re: [PATCH v4] checkpolicy,libsepol: add prefix/suffix matching to
 filename type transitions
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000a34e0a060abe046b"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--000000000000a34e0a060abe046b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 7:34=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> Currently, filename transitions are stored separately from other type
> enforcement rules and only support exact name matching. However, in
> practice, the names contain variable parts. This leads to many
> duplicated rules in the policy that differ only in the part of the name,
> or it is even impossible to cover all possible combinations.
>
> This patch implements the equivalent changes made by this kernel
> patch [1].
>
> This patch updates the policydb structure to contain prefix and suffix
> filename transition tables along normal filename transitions table and
> updates the code that accesses those tables. Furthermore, it adds
> match_type attribute to module and CIL structures that store filename
> transitions and updates functions that parse conf and CIL policy files.
>
> This patch does not significantly change the binary policy size when
> prefix/suffix rules are not used. In addition, with prefix/suffix rules,
> the number of filename transitions can be reduced, and therefore also
> binary policy size can be reduced.
>
> Syntax of the new prefix/suffix filename transition rule:
>
>     type_transition source_type target_type : class default_type object_n=
ame match_type;
>
>     (typetransition source_type_id target_type_id class_id object_name ma=
tch_type default_type_id)
>
> where match_type is either keyword "prefix" or "suffix"
>
> Examples:
>
>     type_transition ta tb:CLASS01 tc "file01" prefix;
>     type_transition td te:CLASS01 tf "file02" suffix;
>
>     (typetransition ta tb CLASS01 "file01" prefix td)
>     (typetransition td te CLASS01 "file02" suffix tf)
>
> In the kernel, the rules have the following order of priority, if no
> matching rule is found, the code moves on to the next category:
> - exact filename transitions,
> - prefix filename transitions in the order of the longest prefix match,
> - suffix filename transitions in the order of the longest suffix match.
> This ensures the compatibility with older policies.
>
> [1]: https://lore.kernel.org/selinux/20231121122719.2332137-1-juraj@juraj=
marcin.com/
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>

Unfortunately, some of the recent CIL updates I just merged breaks this pat=
ch.
I've attached a patch that is the result of removing the bad chunks
from this, applying it and then manually adding the parts that needed
to be changed.

I don't have time to do a complete review until next week, but it does
pass the testing that was failing earlier.
Thanks,
Jim


> ---
> v4:
> - rebased to the latest main, fixed conflicts in policydb_validate.c
> - added syntax tests to checkpolicy and secilc as proposed by Christian
> - retested with more test cases
>
> v3:
> - reworked the solution from scratch, this time only adding the
>   prefix/suffix matching feature without moving filename transition
>   rules to the avtab
> ---
>  checkpolicy/policy_define.c                   |   7 +-
>  checkpolicy/policy_define.h                   |   2 +-
>  checkpolicy/policy_parse.y                    |  13 ++-
>  checkpolicy/policy_scan.l                     |   4 +
>  checkpolicy/test/dismod.c                     |  14 ++-
>  checkpolicy/test/dispol.c                     |  26 ++++-
>  checkpolicy/tests/policy_allonce.conf         |   2 +
>  .../tests/policy_allonce.expected.conf        |   8 ++
>  .../tests/policy_allonce.expected_opt.conf    |   8 ++
>  checkpolicy/tests/policy_allonce_mls.conf     |   2 +
>  .../tests/policy_allonce_mls.expected.conf    |   8 ++
>  .../policy_allonce_mls.expected_opt.conf      |   8 ++
>  libsepol/cil/src/cil.c                        |   6 ++
>  libsepol/cil/src/cil_binary.c                 |   8 +-
>  libsepol/cil/src/cil_build_ast.c              |  26 ++++-
>  libsepol/cil/src/cil_copy_ast.c               |   1 +
>  libsepol/cil/src/cil_internal.h               |   4 +
>  libsepol/cil/src/cil_policy.c                 |  17 ++-
>  libsepol/cil/src/cil_resolve_ast.c            |  12 +++
>  libsepol/cil/src/cil_write_ast.c              |   2 +
>  libsepol/include/sepol/policydb/policydb.h    |  23 +++-
>  libsepol/src/expand.c                         |  17 ++-
>  libsepol/src/kernel_to_cil.c                  |  36 ++++++-
>  libsepol/src/kernel_to_conf.c                 |  36 ++++++-
>  libsepol/src/link.c                           |   1 +
>  libsepol/src/module_to_cil.c                  |  21 +++-
>  libsepol/src/policydb.c                       | 100 ++++++++++++++----
>  libsepol/src/policydb_validate.c              |  26 ++++-
>  libsepol/src/write.c                          |  67 +++++++++---
>  secilc/test/policy.cil                        |   4 +
>  30 files changed, 439 insertions(+), 70 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 260e609d..fb8325ee 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3159,7 +3159,7 @@ avrule_t *define_cond_filename_trans(void)
>         return COND_ERR;
>  }
>
> -int define_filename_trans(void)
> +int define_filename_trans(uint32_t match_type)
>  {
>         char *id, *name =3D NULL;
>         type_set_t stypes, ttypes;
> @@ -3261,7 +3261,7 @@ int define_filename_trans(void)
>                         ebitmap_for_each_positive_bit(&e_ttypes, tnode, t=
) {
>                                 rc =3D policydb_filetrans_insert(
>                                         policydbp, s+1, t+1, c+1, name,
> -                                       NULL, otype, NULL
> +                                       NULL, otype, match_type, NULL
>                                 );
>                                 if (rc !=3D SEPOL_OK) {
>                                         if (rc =3D=3D SEPOL_EEXIST) {
> @@ -3279,7 +3279,7 @@ int define_filename_trans(void)
>                         if (self) {
>                                 rc =3D policydb_filetrans_insert(
>                                         policydbp, s+1, s+1, c+1, name,
> -                                       NULL, otype, NULL
> +                                       NULL, otype, match_type, NULL
>                                 );
>                                 if (rc !=3D SEPOL_OK) {
>                                         if (rc =3D=3D SEPOL_EEXIST) {
> @@ -3317,6 +3317,7 @@ int define_filename_trans(void)
>                 ftr->tclass =3D c + 1;
>                 ftr->otype =3D otype;
>                 ftr->flags =3D self ? RULE_SELF : 0;
> +               ftr->match_type =3D match_type;
>         }
>
>         free(name);
> diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> index 075b048d..05869346 100644
> --- a/checkpolicy/policy_define.h
> +++ b/checkpolicy/policy_define.h
> @@ -57,7 +57,7 @@ int define_role_trans(int class_specified);
>  int define_role_types(void);
>  int define_role_attr(void);
>  int define_roleattribute(void);
> -int define_filename_trans(void);
> +int define_filename_trans(uint32_t match_type);
>  int define_sens(void);
>  int define_te_avtab(int which);
>  int define_te_avtab_extended_perms(int which);
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 356626e2..ee4be4ea 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -153,6 +153,7 @@ typedef int (* require_func_t)(int pass);
>  %token FILESYSTEM
>  %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
>  %token LOW_HIGH LOW HIGH GLBLUB
> +%token PREFIX SUFFIX
>
>  %left OR
>  %left XOR
> @@ -410,6 +411,12 @@ cond_rule_def           : cond_transition_def
>                         { $$ =3D NULL; }
>                          ;
>  cond_transition_def    : TYPE_TRANSITION names names ':' names identifie=
r filename ';'
> +                        { $$ =3D define_cond_filename_trans() ;
> +                          if ($$ =3D=3D COND_ERR) return -1;}
> +                       | TYPE_TRANSITION names names ':' names identifie=
r filename PREFIX ';'
> +                        { $$ =3D define_cond_filename_trans() ;
> +                          if ($$ =3D=3D COND_ERR) return -1;}
> +                       | TYPE_TRANSITION names names ':' names identifie=
r filename SUFFIX ';'
>                          { $$ =3D define_cond_filename_trans() ;
>                            if ($$ =3D=3D COND_ERR) return -1;}
>                         | TYPE_TRANSITION names names ':' names identifie=
r ';'
> @@ -449,7 +456,11 @@ cond_dontaudit_def : DONTAUDIT names names ':' names=
 names ';'
>                         ;
>                         ;
>  transition_def         : TYPE_TRANSITION  names names ':' names identifi=
er filename ';'
> -                       {if (define_filename_trans()) return -1; }
> +                       {if (define_filename_trans(FILENAME_TRANS_MATCH_E=
XACT)) return -1; }
> +                       | TYPE_TRANSITION  names names ':' names identifi=
er filename PREFIX ';'
> +                       {if (define_filename_trans(FILENAME_TRANS_MATCH_P=
REFIX)) return -1; }
> +                       | TYPE_TRANSITION  names names ':' names identifi=
er filename SUFFIX ';'
> +                       {if (define_filename_trans(FILENAME_TRANS_MATCH_S=
UFFIX)) return -1; }
>                         | TYPE_TRANSITION names names ':' names identifie=
r ';'
>                          {if (define_compute_type(AVRULE_TRANSITION)) ret=
urn -1;}
>                          | TYPE_MEMBER names names ':' names identifier '=
;'
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index c998ff8b..0780ef15 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -270,6 +270,10 @@ low |
>  LOW                            { return(LOW); }
>  glblub |
>  GLBLUB                         { return(GLBLUB); }
> +PREFIX |
> +prefix                         { return(PREFIX); }
> +SUFFIX |
> +suffix                         { return(SUFFIX); }
>  "/"[^ \n\r\t\f]*               { return(PATH); }
>  \""/"[^\"\n]*\"                { return(QPATH); }
>  \"[^"/"\"\n]+\"        { return(FILENAME); }
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index fa7117f5..5995e135 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -564,13 +564,25 @@ static void display_role_allow(role_allow_rule_t * =
ra, policydb_t * p, FILE * fp
>
>  static void display_filename_trans(filename_trans_rule_t * tr, policydb_=
t * p, FILE * fp)
>  {
> +       const char *match_str =3D "";
>         fprintf(fp, "filename transition");
>         for (; tr; tr =3D tr->next) {
>                 display_type_set(&tr->stypes, 0, p, fp);
>                 display_type_set(&tr->ttypes, 0, p, fp);
>                 display_id(p, fp, SYM_CLASSES, tr->tclass - 1, ":");
>                 display_id(p, fp, SYM_TYPES, tr->otype - 1, "");
> -               fprintf(fp, " %s\n", tr->name);
> +               switch (tr->match_type) {
> +               case FILENAME_TRANS_MATCH_EXACT:
> +                       match_str =3D "";
> +                       break;
> +               case FILENAME_TRANS_MATCH_PREFIX:
> +                       match_str =3D " prefix";
> +                       break;
> +               case FILENAME_TRANS_MATCH_SUFFIX:
> +                       match_str =3D " suffix";
> +                       break;
> +               }
> +               fprintf(fp, " %s%s\n", tr->name, match_str);
>         }
>  }
>
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index b567ce77..4426b844 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -450,6 +450,7 @@ static void display_role_trans(policydb_t *p, FILE *f=
p)
>
>  struct filenametr_display_args {
>         policydb_t *p;
> +       uint32_t match_type;
>         FILE *fp;
>  };
>
> @@ -464,6 +465,19 @@ static int filenametr_display(hashtab_key_t key,
>         FILE *fp =3D args->fp;
>         ebitmap_node_t *node;
>         uint32_t bit;
> +       const char *match_str =3D "";
> +
> +       switch (args->match_type) {
> +       case FILENAME_TRANS_MATCH_EXACT:
> +               match_str =3D "";
> +               break;
> +       case FILENAME_TRANS_MATCH_PREFIX:
> +               match_str =3D " prefix";
> +               break;
> +       case FILENAME_TRANS_MATCH_SUFFIX:
> +               match_str =3D " suffix";
> +               break;
> +       }
>
>         do {
>                 ebitmap_for_each_positive_bit(&ftdatum->stypes, node, bit=
) {
> @@ -471,7 +485,7 @@ static int filenametr_display(hashtab_key_t key,
>                         display_id(p, fp, SYM_TYPES, ft->ttype - 1, "");
>                         display_id(p, fp, SYM_CLASSES, ft->tclass - 1, ":=
");
>                         display_id(p, fp, SYM_TYPES, ftdatum->otype - 1, =
"");
> -                       fprintf(fp, " %s\n", ft->name);
> +                       fprintf(fp, " %s%s\n", ft->name, match_str);
>                 }
>                 ftdatum =3D ftdatum->next;
>         } while (ftdatum);
> @@ -487,7 +501,15 @@ static void display_filename_trans(policydb_t *p, FI=
LE *fp)
>         fprintf(fp, "filename_trans rules:\n");
>         args.p =3D p;
>         args.fp =3D fp;
> -       hashtab_map(p->filename_trans, filenametr_display, &args);
> +       args.match_type =3D FILENAME_TRANS_MATCH_EXACT;
> +       hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_EXACT],
> +                   filenametr_display, &args);
> +       args.match_type =3D FILENAME_TRANS_MATCH_PREFIX;
> +       hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_PREFIX],
> +                   filenametr_display, &args);
> +       args.match_type =3D FILENAME_TRANS_MATCH_SUFFIX;
> +       hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_SUFFIX],
> +                   filenametr_display, &args);
>  }
>
>  static int menu(void)
> diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/po=
licy_allonce.conf
> index 34e6402d..fb0a0172 100644
> --- a/checkpolicy/tests/policy_allonce.conf
> +++ b/checkpolicy/tests/policy_allonce.conf
> @@ -30,6 +30,8 @@ tunable TUNABLE1 false;
>  tunable TUNABLE2 true;
>  type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
>  type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
";
> +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
" prefix;
> +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
" suffix;
>  type_member TYPE1 TYPE2 : CLASS1 TYPE2;
>  type_change TYPE1 TYPE2 : CLASS1 TYPE3;
>  allow TYPE1 self : CLASS1 { PERM1 };
> diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy=
/tests/policy_allonce.expected.conf
> index 63739e1f..e3db7593 100644
> --- a/checkpolicy/tests/policy_allonce.expected.conf
> +++ b/checkpolicy/tests/policy_allonce.expected.conf
> @@ -40,9 +40,17 @@ dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
>  type_transition TYPE1 TYPE2:CLASS1 TYPE3;
>  type_member TYPE1 TYPE2:CLASS1 TYPE2;
>  type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
>  if (BOOL1) {
>  } else {
> diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpo=
licy/tests/policy_allonce.expected_opt.conf
> index 1c969961..94eaf37a 100644
> --- a/checkpolicy/tests/policy_allonce.expected_opt.conf
> +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> @@ -40,9 +40,17 @@ dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
>  type_transition TYPE1 TYPE2:CLASS1 TYPE3;
>  type_member TYPE1 TYPE2:CLASS1 TYPE2;
>  type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
>  if (BOOL1) {
>  } else {
> diff --git a/checkpolicy/tests/policy_allonce_mls.conf b/checkpolicy/test=
s/policy_allonce_mls.conf
> index c88616b3..2ba88a00 100644
> --- a/checkpolicy/tests/policy_allonce_mls.conf
> +++ b/checkpolicy/tests/policy_allonce_mls.conf
> @@ -41,6 +41,8 @@ tunable TUNABLE1 false;
>  tunable TUNABLE2 true;
>  type_transition TYPE1 TYPE2 : CLASS1 TYPE3;
>  type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
";
> +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
" prefix;
> +type_transition { TYPE1 TYPE2 } { TYPE3 TYPE4 } : CLASS1 TYPE1 "FILENAME=
" suffix;
>  type_member TYPE1 TYPE2 : CLASS1 TYPE2;
>  type_change TYPE1 TYPE2 : CLASS1 TYPE3;
>  range_transition TYPE1 TYPE2 : CLASS1 s1:c0.c1;
> diff --git a/checkpolicy/tests/policy_allonce_mls.expected.conf b/checkpo=
licy/tests/policy_allonce_mls.expected.conf
> index 87c36f92..d390aac0 100644
> --- a/checkpolicy/tests/policy_allonce_mls.expected.conf
> +++ b/checkpolicy/tests/policy_allonce_mls.expected.conf
> @@ -51,9 +51,17 @@ dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
>  type_transition TYPE1 TYPE2:CLASS1 TYPE3;
>  type_member TYPE1 TYPE2:CLASS1 TYPE2;
>  type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
>  range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
>  if (BOOL1) {
> diff --git a/checkpolicy/tests/policy_allonce_mls.expected_opt.conf b/che=
ckpolicy/tests/policy_allonce_mls.expected_opt.conf
> index 38176166..ef683070 100644
> --- a/checkpolicy/tests/policy_allonce_mls.expected_opt.conf
> +++ b/checkpolicy/tests/policy_allonce_mls.expected_opt.conf
> @@ -51,9 +51,17 @@ dontauditxperm TYPE1 TYPE2:CLASS1 ioctl { 0x3 };
>  type_transition TYPE1 TYPE2:CLASS1 TYPE3;
>  type_member TYPE1 TYPE2:CLASS1 TYPE2;
>  type_change TYPE1 TYPE2:CLASS1 TYPE3;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE1 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE1 TYPE4:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE2 TYPE3:CLASS1 TYPE1 "FILENAME";
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" prefix;
> +type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME" suffix;
>  type_transition TYPE2 TYPE4:CLASS1 TYPE1 "FILENAME";
>  range_transition TYPE1 TYPE2:CLASS1 s1:c0,c1 - s1:c0,c1;
>  if (BOOL1) {
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 2021187d..37769fc4 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -97,6 +97,8 @@ char *CIL_KEY_TUNABLEIF;
>  char *CIL_KEY_ALLOW;
>  char *CIL_KEY_DONTAUDIT;
>  char *CIL_KEY_TYPETRANSITION;
> +char *CIL_KEY_PREFIX;
> +char *CIL_KEY_SUFFIX;
>  char *CIL_KEY_TYPECHANGE;
>  char *CIL_KEY_CALL;
>  char *CIL_KEY_TUNABLE;
> @@ -269,6 +271,8 @@ static void cil_init_keys(void)
>         CIL_KEY_ALLOW =3D cil_strpool_add("allow");
>         CIL_KEY_DONTAUDIT =3D cil_strpool_add("dontaudit");
>         CIL_KEY_TYPETRANSITION =3D cil_strpool_add("typetransition");
> +       CIL_KEY_PREFIX =3D cil_strpool_add("prefix");
> +       CIL_KEY_SUFFIX =3D cil_strpool_add("suffix");
>         CIL_KEY_TYPECHANGE =3D cil_strpool_add("typechange");
>         CIL_KEY_CALL =3D cil_strpool_add("call");
>         CIL_KEY_TUNABLE =3D cil_strpool_add("tunable");
> @@ -2456,6 +2460,8 @@ void cil_nametypetransition_init(struct cil_nametyp=
etransition **nametypetrans)
>         (*nametypetrans)->obj =3D NULL;
>         (*nametypetrans)->name_str =3D NULL;
>         (*nametypetrans)->name =3D NULL;
> +       (*nametypetrans)->match_type_str =3D NULL;
> +       (*nametypetrans)->match_type =3D FILENAME_TRANS_MATCH_EXACT;
>         (*nametypetrans)->result_str =3D NULL;
>         (*nametypetrans)->result =3D NULL;
>  }
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index a8e3616a..75a9e064 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1168,7 +1168,7 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
>                                                 type_datum_t *sepol_src,
>                                                 type_datum_t *sepol_tgt,
>                                                 struct cil_list *class_li=
st,
> -                                               char *name,
> +                                               char *name, uint32_t matc=
h_type,
>                                                 type_datum_t *sepol_resul=
t)
>  {
>         int rc;
> @@ -1183,7 +1183,7 @@ static int __cil_typetransition_to_avtab_helper(pol=
icydb_t *pdb,
>                 rc =3D policydb_filetrans_insert(
>                         pdb, sepol_src->s.value, sepol_tgt->s.value,
>                         sepol_obj->s.value, name, NULL,
> -                       sepol_result->s.value, &otype
> +                       sepol_result->s.value, match_type, &otype
>                 );
>                 if (rc !=3D SEPOL_OK) {
>                         if (rc =3D=3D SEPOL_EEXIST) {
> @@ -1252,7 +1252,7 @@ static int __cil_typetransition_to_avtab(policydb_t=
 *pdb, const struct cil_db *d
>
>                         rc =3D __cil_typetransition_to_avtab_helper(
>                                 pdb, sepol_src, sepol_src, class_list,
> -                               name, sepol_result
> +                               name, typetrans->match_type, sepol_result
>                         );
>                         if (rc !=3D SEPOL_OK) goto exit;
>                 }
> @@ -1270,7 +1270,7 @@ static int __cil_typetransition_to_avtab(policydb_t=
 *pdb, const struct cil_db *d
>
>                                 rc =3D __cil_typetransition_to_avtab_help=
er(
>                                         pdb, sepol_src, sepol_tgt, class_=
list,
> -                                       name, sepol_result
> +                                       name, typetrans->match_type, sepo=
l_result
>                                 );
>                                 if (rc !=3D SEPOL_OK) goto exit;
>                         }
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 8976c254..94dadef8 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -3392,10 +3392,11 @@ int cil_gen_typetransition(struct cil_db *db, str=
uct cil_tree_node *parse_curren
>                 CIL_SYN_STRING,
>                 CIL_SYN_STRING,
>                 CIL_SYN_STRING | CIL_SYN_END,
> -               CIL_SYN_END
> +               CIL_SYN_STRING | CIL_SYN_END,
> +               CIL_SYN_END,
>         };
>         size_t syntax_len =3D sizeof(syntax)/sizeof(*syntax);
> -       char *s1, *s2, *s3, *s4, *s5;
> +       char *s1, *s2, *s3, *s4, *s5, *s6;
>
>         if (db =3D=3D NULL || parse_current =3D=3D NULL || ast_node =3D=
=3D NULL ) {
>                 goto exit;
> @@ -3411,12 +3412,22 @@ int cil_gen_typetransition(struct cil_db *db, str=
uct cil_tree_node *parse_curren
>         s3 =3D parse_current->next->next->next->data;
>         s4 =3D parse_current->next->next->next->next->data;
>         s5 =3D NULL;
> +       s6 =3D NULL;
>
>         if (parse_current->next->next->next->next->next) {
>                 if (s4 =3D=3D CIL_KEY_STAR) {
> -                       s4 =3D parse_current->next->next->next->next->nex=
t->data;
> +                       if (parse_current->next->next->next->next->next->=
next) {
> +                               s4 =3D parse_current->next->next->next->n=
ext->next->next->data;
> +                       } else {
> +                               s4 =3D parse_current->next->next->next->n=
ext->next->data;
> +                       }
>                 } else {
> -                       s5 =3D parse_current->next->next->next->next->nex=
t->data;
> +                       if (parse_current->next->next->next->next->next->=
next) {
> +                               s5 =3D parse_current->next->next->next->n=
ext->next->data;
> +                               s6 =3D parse_current->next->next->next->n=
ext->next->next->data;
> +                       } else {
> +                               s5 =3D parse_current->next->next->next->n=
ext->next->data;
> +                       }
>                 }
>         }
>
> @@ -3428,8 +3439,13 @@ int cil_gen_typetransition(struct cil_db *db, stru=
ct cil_tree_node *parse_curren
>                 nametypetrans->src_str =3D s1;
>                 nametypetrans->tgt_str =3D s2;
>                 nametypetrans->obj_str =3D s3;
> -               nametypetrans->result_str =3D s5;
>                 nametypetrans->name_str =3D s4;
> +               if (s6) {
> +                       nametypetrans->match_type_str =3D s5;
> +                       nametypetrans->result_str =3D s6;
> +               } else {
> +                       nametypetrans->result_str =3D s5;
> +               }
>
>                 ast_node->data =3D nametypetrans;
>                 ast_node->flavor =3D CIL_NAMETYPETRANSITION;
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_=
ast.c
> index bc972f03..300390ec 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -726,6 +726,7 @@ int cil_copy_nametypetransition(__attribute__((unused=
)) struct cil_db *db, void
>         new->tgt_str =3D orig->tgt_str;
>         new->obj_str =3D orig->obj_str;
>         new->name_str =3D orig->name_str;
> +       new->match_type_str =3D orig->match_type_str;
>         new->result_str =3D orig->result_str;
>
>
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_inter=
nal.h
> index 9e492cb9..7f0be652 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -114,6 +114,8 @@ extern char *CIL_KEY_TUNABLEIF;
>  extern char *CIL_KEY_ALLOW;
>  extern char *CIL_KEY_DONTAUDIT;
>  extern char *CIL_KEY_TYPETRANSITION;
> +extern char *CIL_KEY_PREFIX;
> +extern char *CIL_KEY_SUFFIX;
>  extern char *CIL_KEY_TYPECHANGE;
>  extern char *CIL_KEY_CALL;
>  extern char *CIL_KEY_TUNABLE;
> @@ -580,6 +582,8 @@ struct cil_nametypetransition {
>         struct cil_class *obj;
>         char *name_str;
>         struct cil_name *name;
> +       char *match_type_str;
> +       uint32_t match_type;
>         char *result_str;
>         void *result; /* type or alias */
>
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
> index feb97868..9776dfd3 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -1260,6 +1260,7 @@ static void cil_nametypetransition_to_policy(FILE *=
out, struct cil_nametypetrans
>         struct cil_name *name;
>         struct cil_list *class_list;
>         struct cil_list_item *i1;
> +       const char *match_type_str =3D "";
>
>         src =3D trans->src;
>         tgt =3D trans->tgt;
> @@ -1268,7 +1269,21 @@ static void cil_nametypetransition_to_policy(FILE =
*out, struct cil_nametypetrans
>
>         class_list =3D cil_expand_class(trans->obj);
>         cil_list_for_each(i1, class_list) {
> -               fprintf(out, "type_transition %s %s : %s %s \"%s\";\n", s=
rc->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn);
> +               switch (trans->match_type) {
> +               case FILENAME_TRANS_MATCH_EXACT:
> +                       match_type_str =3D "";
> +                       break;
> +               case FILENAME_TRANS_MATCH_PREFIX:
> +                       match_type_str =3D " prefix";
> +                       break;
> +               case FILENAME_TRANS_MATCH_SUFFIX:
> +                       match_type_str =3D " suffix";
> +                       break;
> +               default:
> +                       match_type_str =3D "???";
> +                       break;
> +               }
> +               fprintf(out, "type_transition %s %s : %s %s \"%s\"%s;\n",=
 src->fqn, tgt->fqn, DATUM(i1->data)->fqn, res->fqn, name->datum.fqn, match=
_type_str);
>         }
>         cil_list_destroy(&class_list, CIL_FALSE);
>  }
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index 33b9d321..3b00f065 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -717,6 +717,18 @@ int cil_resolve_nametypetransition(struct cil_tree_n=
ode *current, void *extra_ar
>                 nametypetrans->name =3D (struct cil_name *)name_datum;
>         }
>
> +       if (nametypetrans->match_type_str =3D=3D NULL) {
> +               nametypetrans->match_type =3D FILENAME_TRANS_MATCH_EXACT;
> +       } else if (nametypetrans->match_type_str =3D=3D CIL_KEY_PREFIX) {
> +               nametypetrans->match_type =3D FILENAME_TRANS_MATCH_PREFIX=
;
> +       } else if (nametypetrans->match_type_str =3D=3D CIL_KEY_SUFFIX) {
> +               nametypetrans->match_type =3D FILENAME_TRANS_MATCH_SUFFIX=
;
> +       } else {
> +               cil_tree_log(current, CIL_ERR, "Invalid name match type \=
"%s\"", nametypetrans->match_type_str);
> +               rc =3D SEPOL_ERR;
> +               goto exit;
> +       }
> +
>         rc =3D cil_resolve_name(current, nametypetrans->result_str, CIL_S=
YM_TYPES, extra_args, &result_datum);
>         if (rc !=3D SEPOL_OK) {
>                 goto exit;
> diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
> index 4da7a77c..99c82292 100644
> --- a/libsepol/cil/src/cil_write_ast.c
> +++ b/libsepol/cil/src/cil_write_ast.c
> @@ -1178,6 +1178,8 @@ void cil_write_ast_node(FILE *out, struct cil_tree_=
node *node)
>                 fprintf(out, "%s ", datum_or_str(DATUM(rule->tgt), rule->=
tgt_str));
>                 fprintf(out, "%s ", datum_or_str(DATUM(rule->obj), rule->=
obj_str));
>                 fprintf(out, "\"%s\" ", datum_or_str(DATUM(rule->name), r=
ule->name_str));
> +               if (rule->match_type !=3D FILENAME_TRANS_MATCH_EXACT)
> +                       fprintf(out, "%s ", rule->match_type_str);
>                 fprintf(out, "%s", datum_or_str(DATUM(rule->result), rule=
->result_str));
>                 fprintf(out, ")\n");
>                 break;
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 6682069e..5ee0fa16 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -321,6 +321,8 @@ typedef struct filename_trans_rule {
>         uint32_t tclass;
>         char *name;
>         uint32_t otype; /* new type */
> +       /* name match type, values from enum filename_trans_match_type */
> +       uint32_t match_type;
>         struct filename_trans_rule *next;
>  } filename_trans_rule_t;
>
> @@ -423,6 +425,14 @@ typedef struct genfs {
>  /* OCON_NUM needs to be the largest index in any platform's ocontext arr=
ay */
>  #define OCON_NUM   9
>
> +/* filename transitions table array indices */
> +enum filename_trans_match_type {
> +       FILENAME_TRANS_MATCH_EXACT,
> +       FILENAME_TRANS_MATCH_PREFIX,
> +       FILENAME_TRANS_MATCH_SUFFIX,
> +       FILENAME_TRANS_MATCH_NUM,
> +};
> +
>  /* section: module information */
>
>  /* scope_index_t holds all of the symbols that are in scope in a
> @@ -593,8 +603,8 @@ typedef struct policydb {
>         hashtab_t range_tr;
>
>         /* file transitions with the last path component */
> -       hashtab_t filename_trans;
> -       uint32_t filename_trans_count;
> +       hashtab_t filename_trans[FILENAME_TRANS_MATCH_NUM];
> +       uint32_t filename_trans_exact_count;
>
>         ebitmap_t *type_attr_map;
>
> @@ -657,7 +667,8 @@ extern int policydb_sort_ocontexts(policydb_t *p);
>  extern int policydb_filetrans_insert(policydb_t *p, uint32_t stype,
>                                      uint32_t ttype, uint32_t tclass,
>                                      const char *name, char **name_alloc,
> -                                    uint32_t otype, uint32_t *present_ot=
ype);
> +                                    uint32_t otype, uint32_t match_type,
> +                                    uint32_t *present_otype);
>
>  /* Deprecated */
>  extern int policydb_context_isvalid(const policydb_t * p,
> @@ -758,10 +769,11 @@ extern int policydb_set_target_platform(policydb_t =
*p, int platform);
>  #define POLICYDB_VERSION_INFINIBAND            31 /* Linux-specific */
>  #define POLICYDB_VERSION_GLBLUB                32
>  #define POLICYDB_VERSION_COMP_FTRANS   33 /* compressed filename transit=
ions */
> +#define POLICYDB_VERSION_PREFIX_SUFFIX 34 /* prefix and suffix filename =
transitions */
>
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
> +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_PREFIX_SUFFIX
>
>  /* Module versions and specific changes*/
>  #define MOD_POLICYDB_VERSION_BASE              4
> @@ -784,9 +796,10 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
>  #define MOD_POLICYDB_VERSION_INFINIBAND                19
>  #define MOD_POLICYDB_VERSION_GLBLUB            20
>  #define MOD_POLICYDB_VERSION_SELF_TYPETRANS    21
> +#define MOD_POLICYDB_VERSION_PREFIX_SUFFIX     22
>
>  #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
> -#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SELF_TYPETRANS
> +#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_PREFIX_SUFFIX
>
>  #define POLICYDB_CONFIG_MLS    1
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index ee5f9185..4df9521a 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1419,18 +1419,31 @@ static int expand_filename_trans_helper(expand_st=
ate_t *state,
>         rc =3D policydb_filetrans_insert(
>                 state->out, s + 1, t + 1,
>                 rule->tclass, rule->name,
> -               NULL, mapped_otype, &present_otype
> +               NULL, mapped_otype, rule->match_type, &present_otype
>         );
>         if (rc =3D=3D SEPOL_EEXIST) {
>                 /* duplicate rule, ignore */
>                 if (present_otype =3D=3D mapped_otype)
>                         return 0;
>
> -               ERR(state->handle, "Conflicting name-based type_transitio=
n %s %s:%s \"%s\":  %s vs %s",
> +               const char *match_str =3D "";
> +               switch (rule->match_type) {
> +               case FILENAME_TRANS_MATCH_EXACT:
> +                       match_str =3D "";
> +                       break;
> +               case FILENAME_TRANS_MATCH_PREFIX:
> +                       match_str =3D " prefix";
> +                       break;
> +               case FILENAME_TRANS_MATCH_SUFFIX:
> +                       match_str =3D " suffix";
> +                       break;
> +               }
> +               ERR(state->handle, "Conflicting name-based type_transitio=
n %s %s:%s \"%s\"%s:  %s vs %s",
>                     state->out->p_type_val_to_name[s],
>                     state->out->p_type_val_to_name[t],
>                     state->out->p_class_val_to_name[rule->tclass - 1],
>                     rule->name,
> +                   match_str,
>                     state->out->p_type_val_to_name[present_otype - 1],
>                     state->out->p_type_val_to_name[mapped_otype - 1]);
>                 return -1;
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 8fcc385d..44a82604 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1869,6 +1869,7 @@ exit:
>
>  struct map_filename_trans_args {
>         struct policydb *pdb;
> +       uint32_t match_type;
>         struct strs *strs;
>  };
>
> @@ -1883,6 +1884,19 @@ static int map_filename_trans_to_str(hashtab_key_t=
 key, void *data, void *arg)
>         struct ebitmap_node *node;
>         uint32_t bit;
>         int rc;
> +       const char *match_str =3D "";
> +
> +       switch (map_args->match_type) {
> +       case FILENAME_TRANS_MATCH_EXACT:
> +               match_str =3D "";
> +               break;
> +       case FILENAME_TRANS_MATCH_PREFIX:
> +               match_str =3D " prefix";
> +               break;
> +       case FILENAME_TRANS_MATCH_SUFFIX:
> +               match_str =3D " suffix";
> +               break;
> +       }
>
>         tgt =3D pdb->p_type_val_to_name[ft->ttype - 1];
>         class =3D pdb->p_class_val_to_name[ft->tclass - 1];
> @@ -1893,8 +1907,8 @@ static int map_filename_trans_to_str(hashtab_key_t =
key, void *data, void *arg)
>                 ebitmap_for_each_positive_bit(&datum->stypes, node, bit) =
{
>                         src =3D pdb->p_type_val_to_name[bit];
>                         rc =3D strs_create_and_add(strs,
> -                                                "(typetransition %s %s %=
s \"%s\" %s)",
> -                                                5, src, tgt, class, file=
name, new);
> +                                                "(typetransition %s %s %=
s \"%s\"%s %s)",
> +                                                6, src, tgt, class, file=
name, match_str, new);
>                         if (rc)
>                                 return rc;
>                 }
> @@ -1919,7 +1933,23 @@ static int write_filename_trans_rules_to_cil(FILE =
*out, struct policydb *pdb)
>         args.pdb =3D pdb;
>         args.strs =3D strs;
>
> -       rc =3D hashtab_map(pdb->filename_trans, map_filename_trans_to_str=
, &args);
> +       args.match_type =3D FILENAME_TRANS_MATCH_EXACT;
> +       rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_EXACT=
],
> +                        map_filename_trans_to_str, &args);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       args.match_type =3D FILENAME_TRANS_MATCH_PREFIX;
> +       rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_PREFI=
X],
> +                        map_filename_trans_to_str, &args);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       args.match_type =3D FILENAME_TRANS_MATCH_SUFFIX;
> +       rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_SUFFI=
X],
> +                        map_filename_trans_to_str, &args);
>         if (rc !=3D 0) {
>                 goto exit;
>         }
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index b0ae16d9..99bef76e 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1845,6 +1845,7 @@ exit:
>
>  struct map_filename_trans_args {
>         struct policydb *pdb;
> +       uint32_t match_type;
>         struct strs *strs;
>  };
>
> @@ -1859,6 +1860,19 @@ static int map_filename_trans_to_str(hashtab_key_t=
 key, void *data, void *arg)
>         struct ebitmap_node *node;
>         uint32_t bit;
>         int rc;
> +       const char *match_str =3D "";
> +
> +       switch (map_args->match_type) {
> +       case FILENAME_TRANS_MATCH_EXACT:
> +               match_str =3D "";
> +               break;
> +       case FILENAME_TRANS_MATCH_PREFIX:
> +               match_str =3D " prefix";
> +               break;
> +       case FILENAME_TRANS_MATCH_SUFFIX:
> +               match_str =3D " suffix";
> +               break;
> +       }
>
>         tgt =3D pdb->p_type_val_to_name[ft->ttype - 1];
>         class =3D pdb->p_class_val_to_name[ft->tclass - 1];
> @@ -1869,8 +1883,8 @@ static int map_filename_trans_to_str(hashtab_key_t =
key, void *data, void *arg)
>                 ebitmap_for_each_positive_bit(&datum->stypes, node, bit) =
{
>                         src =3D pdb->p_type_val_to_name[bit];
>                         rc =3D strs_create_and_add(strs,
> -                                                "type_transition %s %s:%=
s %s \"%s\";",
> -                                                5, src, tgt, class, new,=
 filename);
> +                                                "type_transition %s %s:%=
s %s \"%s\"%s;",
> +                                                6, src, tgt, class, new,=
 filename, match_str);
>                         if (rc)
>                                 return rc;
>                 }
> @@ -1895,7 +1909,23 @@ static int write_filename_trans_rules_to_conf(FILE=
 *out, struct policydb *pdb)
>         args.pdb =3D pdb;
>         args.strs =3D strs;
>
> -       rc =3D hashtab_map(pdb->filename_trans, map_filename_trans_to_str=
, &args);
> +       args.match_type =3D FILENAME_TRANS_MATCH_EXACT;
> +       rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_EXACT=
],
> +                        map_filename_trans_to_str, &args);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       args.match_type =3D FILENAME_TRANS_MATCH_PREFIX;
> +       rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_PREFI=
X],
> +                        map_filename_trans_to_str, &args);
> +       if (rc !=3D 0) {
> +               goto exit;
> +       }
> +
> +       args.match_type =3D FILENAME_TRANS_MATCH_SUFFIX;
> +       rc =3D hashtab_map(pdb->filename_trans[FILENAME_TRANS_MATCH_SUFFI=
X],
> +                        map_filename_trans_to_str, &args);
>         if (rc !=3D 0) {
>                 goto exit;
>         }
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index 3b7742bc..f432087f 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -1440,6 +1440,7 @@ static int copy_filename_trans_list(filename_trans_=
rule_t * list,
>                 new_rule->name =3D strdup(cur->name);
>                 if (!new_rule->name)
>                         goto err;
> +               new_rule->match_type =3D cur->match_type;
>
>                 if (type_set_or_convert(&cur->stypes, &new_rule->stypes, =
module) ||
>                     type_set_or_convert(&cur->ttypes, &new_rule->ttypes, =
module))
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index ee22dbbd..a90ee85d 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1611,6 +1611,7 @@ static int filename_trans_to_cil(int indent, struct=
 policydb *pdb, struct filena
>         unsigned int ttype;
>         struct type_set *ts;
>         struct filename_trans_rule *rule;
> +       const char *match_str =3D "";
>
>         for (rule =3D rules; rule !=3D NULL; rule =3D rule->next) {
>                 ts =3D &rule->stypes;
> @@ -1625,19 +1626,31 @@ static int filename_trans_to_cil(int indent, stru=
ct policydb *pdb, struct filena
>                         goto exit;
>                 }
>
> +               switch (rule->match_type) {
> +               case FILENAME_TRANS_MATCH_EXACT:
> +                       match_str =3D "";
> +                       break;
> +               case FILENAME_TRANS_MATCH_PREFIX:
> +                       match_str =3D " prefix";
> +                       break;
> +               case FILENAME_TRANS_MATCH_SUFFIX:
> +                       match_str =3D " suffix";
> +                       break;
> +               }
> +
>                 for (stype =3D 0; stype < num_stypes; stype++) {
>                         for (ttype =3D 0; ttype < num_ttypes; ttype++) {
> -                               cil_println(indent, "(typetransition %s %=
s %s \"%s\" %s)",
> +                               cil_println(indent, "(typetransition %s %=
s %s \"%s\"%s %s)",
>                                             stypes[stype], ttypes[ttype],
>                                             pdb->p_class_val_to_name[rule=
->tclass - 1],
> -                                           rule->name,
> +                                           rule->name, match_str,
>                                             pdb->p_type_val_to_name[rule-=
>otype - 1]);
>                         }
>                         if (rule->flags & RULE_SELF) {
> -                               cil_println(indent, "(typetransition %s s=
elf %s \"%s\" %s)",
> +                               cil_println(indent, "(typetransition %s s=
elf %s \"%s\"%s %s)",
>                                             stypes[stype],
>                                             pdb->p_class_val_to_name[rule=
->tclass - 1],
> -                                           rule->name,
> +                                           rule->name, match_str,
>                                             pdb->p_type_val_to_name[rule-=
>otype - 1]);
>                         }
>                 }
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 6ba4f916..a1796844 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -208,6 +208,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>          .ocon_num =3D OCON_IBENDPORT + 1,
>          .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type =3D POLICY_KERN,
> +        .version =3D POLICYDB_VERSION_PREFIX_SUFFIX,
> +        .sym_num =3D SYM_NUM,
> +        .ocon_num =3D OCON_IBENDPORT + 1,
> +        .target_platform =3D SEPOL_TARGET_SELINUX,
> +       },
>         {
>          .type =3D POLICY_BASE,
>          .version =3D MOD_POLICYDB_VERSION_BASE,
> @@ -334,6 +341,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>          .ocon_num =3D OCON_IBENDPORT + 1,
>          .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type =3D POLICY_BASE,
> +        .version =3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX,
> +        .sym_num =3D SYM_NUM,
> +        .ocon_num =3D OCON_IBENDPORT + 1,
> +        .target_platform =3D SEPOL_TARGET_SELINUX,
> +       },
>         {
>          .type =3D POLICY_MOD,
>          .version =3D MOD_POLICYDB_VERSION_BASE,
> @@ -460,6 +474,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
>          .ocon_num =3D 0,
>          .target_platform =3D SEPOL_TARGET_SELINUX,
>         },
> +       {
> +        .type =3D POLICY_MOD,
> +        .version =3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX,
> +        .sym_num =3D SYM_NUM,
> +        .ocon_num =3D 0,
> +        .target_platform =3D SEPOL_TARGET_SELINUX,
> +       },
>  };
>
>  #if 0
> @@ -909,10 +930,14 @@ int policydb_init(policydb_t * p)
>         if (rc)
>                 goto err;
>
> -       p->filename_trans =3D hashtab_create(filenametr_hash, filenametr_=
cmp, (1 << 10));
> -       if (!p->filename_trans) {
> -               rc =3D -ENOMEM;
> -               goto err;
> +       for (i =3D 0; i < FILENAME_TRANS_MATCH_NUM; i++) {
> +               p->filename_trans[i] =3D hashtab_create(filenametr_hash,
> +                                                     filenametr_cmp,
> +                                                     (1 << 10));
> +               if (!p->filename_trans[i]) {
> +                       rc =3D -ENOMEM;
> +                       goto err;
> +               }
>         }
>
>         p->range_tr =3D hashtab_create(rangetr_hash, rangetr_cmp, 256);
> @@ -926,7 +951,9 @@ int policydb_init(policydb_t * p)
>
>         return 0;
>  err:
> -       hashtab_destroy(p->filename_trans);
> +       for (i =3D 0; i < FILENAME_TRANS_MATCH_NUM; i++) {
> +               hashtab_destroy(p->filename_trans[i]);
> +       }
>         hashtab_destroy(p->range_tr);
>         for (i =3D 0; i < SYM_NUM; i++) {
>                 hashtab_destroy(p->symtab[i].table);
> @@ -1564,8 +1591,10 @@ void policydb_destroy(policydb_t * p)
>         if (lra)
>                 free(lra);
>
> -       hashtab_map(p->filename_trans, filenametr_destroy, NULL);
> -       hashtab_destroy(p->filename_trans);
> +       for (i =3D 0; i < FILENAME_TRANS_MATCH_NUM; i++) {
> +               hashtab_map(p->filename_trans[i], filenametr_destroy, NUL=
L);
> +               hashtab_destroy(p->filename_trans[i]);
> +       }
>
>         hashtab_map(p->range_tr, range_tr_destroy, NULL);
>         hashtab_destroy(p->range_tr);
> @@ -2566,7 +2595,7 @@ static int role_allow_read(role_allow_t ** r, struc=
t policy_file *fp)
>  int policydb_filetrans_insert(policydb_t *p, uint32_t stype, uint32_t tt=
ype,
>                               uint32_t tclass, const char *name,
>                               char **name_alloc, uint32_t otype,
> -                             uint32_t *present_otype)
> +                             uint32_t match_type, uint32_t *present_otyp=
e)
>  {
>         filename_trans_key_t *ft, key;
>         filename_trans_datum_t *datum, *last;
> @@ -2576,7 +2605,8 @@ int policydb_filetrans_insert(policydb_t *p, uint32=
_t stype, uint32_t ttype,
>         key.name =3D (char *)name;
>
>         last =3D NULL;
> -       datum =3D hashtab_search(p->filename_trans, (hashtab_key_t)&key);
> +       datum =3D hashtab_search(p->filename_trans[match_type],
> +                              (hashtab_key_t)&key);
>         while (datum) {
>                 if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
>                         if (present_otype)
> @@ -2624,7 +2654,8 @@ int policydb_filetrans_insert(policydb_t *p, uint32=
_t stype, uint32_t ttype,
>                         ft->tclass =3D tclass;
>                         ft->name =3D name_dup;
>
> -                       if (hashtab_insert(p->filename_trans, (hashtab_ke=
y_t)ft,
> +                       if (hashtab_insert(p->filename_trans[match_type],
> +                                          (hashtab_key_t)ft,
>                                            (hashtab_datum_t)datum)) {
>                                 free(name_dup);
>                                 free(datum);
> @@ -2634,7 +2665,14 @@ int policydb_filetrans_insert(policydb_t *p, uint3=
2_t stype, uint32_t ttype,
>                 }
>         }
>
> -       p->filename_trans_count++;
> +        /*
> +         * We need to keep track of the number of exact match filename
> +        * transitions for writing them in uncompressed format in older b=
inary
> +        * policy versions. Other match types were not supported back the=
n, so
> +        * it is not needed.
> +         */
> +        if (match_type =3D=3D FILENAME_TRANS_MATCH_EXACT)
> +               p->filename_trans_exact_count++;
>         return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
>  }
>
> @@ -2665,8 +2703,9 @@ static int filename_trans_read_one_compat(policydb_=
t *p, struct policy_file *fp)
>         tclass =3D le32_to_cpu(buf[2]);
>         otype  =3D le32_to_cpu(buf[3]);
>
> +       // This version does not contain other than exact filename transi=
tions
>         rc =3D policydb_filetrans_insert(p, stype, ttype, tclass, name, &=
name,
> -                                      otype, NULL);
> +                                      otype, FILENAME_TRANS_MATCH_EXACT,=
 NULL);
>         if (rc) {
>                 if (rc !=3D SEPOL_EEXIST)
>                         goto err;
> @@ -2714,7 +2753,8 @@ out:
>         return rc;
>  }
>
> -static int filename_trans_read_one(policydb_t *p, struct policy_file *fp=
)
> +static int filename_trans_read_one(policydb_t *p, uint32_t match_type,
> +                                  struct policy_file *fp)
>  {
>         filename_trans_key_t *ft =3D NULL;
>         filename_trans_datum_t **dst, *datum, *first =3D NULL;
> @@ -2762,7 +2802,14 @@ static int filename_trans_read_one(policydb_t *p, =
struct policy_file *fp)
>
>                 datum->otype =3D le32_to_cpu(buf[0]);
>
> -               p->filename_trans_count +=3D ebitmap_cardinality(&datum->=
stypes);
> +               /*
> +                * We need to keep track of the number of exact match fil=
ename
> +                * transitions for writing them in uncompressed format in=
 older
> +                * binary policy versions. Other match types were not sup=
ported
> +                * back then, so it is not needed
> +                */
> +               if (match_type =3D=3D FILENAME_TRANS_MATCH_EXACT)
> +                       p->filename_trans_exact_count +=3D ebitmap_cardin=
ality(&datum->stypes);
>
>                 dst =3D &datum->next;
>         }
> @@ -2778,7 +2825,7 @@ static int filename_trans_read_one(policydb_t *p, s=
truct policy_file *fp)
>         ft->tclass =3D tclass;
>         ft->name =3D name;
>
> -       rc =3D hashtab_insert(p->filename_trans, (hashtab_key_t)ft,
> +       rc =3D hashtab_insert(p->filename_trans[match_type], (hashtab_key=
_t)ft,
>                             (hashtab_datum_t)first);
>         if (rc)
>                 goto err;
> @@ -2797,7 +2844,8 @@ err:
>         return -1;
>  }
>
> -static int filename_trans_read(policydb_t *p, struct policy_file *fp)
> +static int filename_trans_read(policydb_t *p, struct policy_file *fp,
> +                              uint32_t match_type)
>  {
>         unsigned int i;
>         uint32_t buf[1], nel;
> @@ -2810,13 +2858,17 @@ static int filename_trans_read(policydb_t *p, str=
uct policy_file *fp)
>
>         if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
>                 for (i =3D 0; i < nel; i++) {
> +                       /*
> +                        * this version does not have other than exact ma=
tch
> +                        * transitions
> +                        */
>                         rc =3D filename_trans_read_one_compat(p, fp);
>                         if (rc < 0)
>                                 return -1;
>                 }
>         } else {
>                 for (i =3D 0; i < nel; i++) {
> -                       rc =3D filename_trans_read_one(p, fp);
> +                       rc =3D filename_trans_read_one(p, match_type, fp)=
;
>                         if (rc < 0)
>                                 return -1;
>                 }
> @@ -3743,7 +3795,7 @@ static int role_allow_rule_read(role_allow_rule_t *=
* r, struct policy_file *fp)
>  static int filename_trans_rule_read(policydb_t *p, filename_trans_rule_t=
 **r,
>                                     struct policy_file *fp)
>  {
> -       uint32_t buf[3], nel, i, len;
> +       uint32_t buf[4], nel, i, len;
>         unsigned int entries;
>         filename_trans_rule_t *ftr, *lftr;
>         int rc;
> @@ -3782,7 +3834,9 @@ static int filename_trans_rule_read(policydb_t *p, =
filename_trans_rule_t **r,
>                 if (type_set_read(&ftr->ttypes, fp))
>                         return -1;
>
> -               if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRAN=
S)
> +               if (p->policyvers >=3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX=
)
> +                       entries =3D 4;
> +               else if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYP=
ETRANS)
>                         entries =3D 3;
>                 else
>                         entries =3D 2;
> @@ -3794,6 +3848,8 @@ static int filename_trans_rule_read(policydb_t *p, =
filename_trans_rule_t **r,
>                 ftr->otype =3D le32_to_cpu(buf[1]);
>                 if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRAN=
S)
>                         ftr->flags =3D le32_to_cpu(buf[2]);
> +               if (p->policyvers >=3D  MOD_POLICYDB_VERSION_PREFIX_SUFFI=
X)
> +                       ftr->match_type =3D le32_to_cpu(buf[3]);
>         }
>
>         return 0;
> @@ -4356,7 +4412,11 @@ int policydb_read(policydb_t * p, struct policy_fi=
le *fp, unsigned verbose)
>                 if (role_allow_read(&p->role_allow, fp))
>                         goto bad;
>                 if (r_policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS &&
> -                   filename_trans_read(p, fp))
> +                   filename_trans_read(p, fp, FILENAME_TRANS_MATCH_EXACT=
))
> +                       goto bad;
> +               if (r_policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX &&
> +                   (filename_trans_read(p, fp, FILENAME_TRANS_MATCH_PREF=
IX) ||
> +                    filename_trans_read(p, fp, FILENAME_TRANS_MATCH_SUFF=
IX)))
>                         goto bad;
>         } else {
>                 /* first read the AV rule blocks, then the scope tables *=
/
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 8b87675f..d94f49aa 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1147,12 +1147,23 @@ static int validate_filename_trans_hashtab(sepol_=
handle_t *handle, const policyd
>  {
>         map_arg_t margs =3D { flavors, handle, p };
>
> -       if (hashtab_map(p->filename_trans, validate_filename_trans, &marg=
s)) {
> -               ERR(handle, "Invalid filename trans");
> -               return -1;
> +       if (hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_EXACT],
> +                       validate_filename_trans, &margs))
> +               goto bad;
> +
> +       if (p->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
> +               if (hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_PR=
EFIX],
> +                               validate_filename_trans, &margs))
> +                       goto bad;
> +               if (hashtab_map(p->filename_trans[FILENAME_TRANS_MATCH_SU=
FFIX],
> +                               validate_filename_trans, &margs))
> +                       goto bad;
>         }
>
>         return 0;
> +bad:
> +       ERR(handle, "Invalid filename trans");
> +       return -1;
>  }
>
>  static int validate_context(const context_struct_t *con, validate_t flav=
ors[], int mls)
> @@ -1374,6 +1385,15 @@ static int validate_filename_trans_rules(sepol_han=
dle_t *handle, const filename_
>                 if (validate_simpletype(filename_trans->otype, p, flavors=
))
>                         goto bad;
>
> +               switch (filename_trans->match_type) {
> +               case FILENAME_TRANS_MATCH_EXACT:
> +               case FILENAME_TRANS_MATCH_PREFIX:
> +               case FILENAME_TRANS_MATCH_SUFFIX:
> +                       break;
> +               default:
> +                       goto bad;
> +               }
> +
>                 /* currently only the RULE_SELF flag can be set */
>                 if ((filename_trans->flags & ~RULE_SELF) !=3D 0)
>                         goto bad;
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 283d11c8..6bcd7535 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -653,7 +653,8 @@ static int filename_write_one(hashtab_key_t key, void=
 *data, void *ptr)
>         return 0;
>  }
>
> -static int filename_trans_write(struct policydb *p, void *fp)
> +static int filename_trans_write(struct policydb *p, uint32_t match_type,
> +                               void *fp)
>  {
>         size_t items;
>         uint32_t buf[1];
> @@ -663,20 +664,25 @@ static int filename_trans_write(struct policydb *p,=
 void *fp)
>                 return 0;
>
>         if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
> -               buf[0] =3D cpu_to_le32(p->filename_trans_count);
> +               /*
> +                * This version does not have other than exact match
> +                * transitions, there is no need to count other ones.
> +                */
> +               buf[0] =3D cpu_to_le32(p->filename_trans_exact_count);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>                 if (items !=3D 1)
>                         return POLICYDB_ERROR;
>
> -               rc =3D hashtab_map(p->filename_trans, filename_write_one_=
compat,
> -                                fp);
> +               rc =3D hashtab_map(p->filename_trans[match_type],
> +                                filename_write_one_compat, fp);
>         } else {
> -               buf[0] =3D cpu_to_le32(p->filename_trans->nel);
> +               buf[0] =3D cpu_to_le32(p->filename_trans[match_type]->nel=
);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
>                 if (items !=3D 1)
>                         return POLICYDB_ERROR;
>
> -               rc =3D hashtab_map(p->filename_trans, filename_write_one,=
 fp);
> +               rc =3D hashtab_map(p->filename_trans[match_type],
> +                                filename_write_one, fp);
>         }
>         return rc;
>  }
> @@ -1944,11 +1950,25 @@ static int filename_trans_rule_write(policydb_t *=
p, filename_trans_rule_t *t,
>  {
>         int nel =3D 0;
>         size_t items, entries;
> -       uint32_t buf[3], len;
> +       uint32_t buf[4], len;
>         filename_trans_rule_t *ftr;
> +       int discarding =3D 0;
>
> -       for (ftr =3D t; ftr; ftr =3D ftr->next)
> -               nel++;
> +       if (p->policyvers >=3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX) {
> +               for (ftr =3D t; ftr; ftr =3D ftr->next)
> +                       nel++;
> +       } else {
> +               for (ftr =3D t; ftr; ftr =3D ftr->next) {
> +                       if (ftr->match_type =3D=3D FILENAME_TRANS_MATCH_E=
XACT)
> +                               nel++;
> +                       else
> +                               discarding =3D 1;
> +               }
> +               if (discarding) {
> +                       WARN(fp->handle,
> +                            "Discarding prefix/suffix filename type tran=
sition rules");
> +               }
> +       }
>
>         buf[0] =3D cpu_to_le32(nel);
>         items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
> @@ -1956,6 +1976,9 @@ static int filename_trans_rule_write(policydb_t *p,=
 filename_trans_rule_t *t,
>                 return POLICYDB_ERROR;
>
>         for (ftr =3D t; ftr; ftr =3D ftr->next) {
> +               if (p->policyvers < MOD_POLICYDB_VERSION_PREFIX_SUFFIX &&
> +                   ftr->match_type !=3D FILENAME_TRANS_MATCH_EXACT)
> +                       continue;
>                 len =3D strlen(ftr->name);
>                 buf[0] =3D cpu_to_le32(len);
>                 items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
> @@ -1974,8 +1997,11 @@ static int filename_trans_rule_write(policydb_t *p=
, filename_trans_rule_t *t,
>                 buf[0] =3D cpu_to_le32(ftr->tclass);
>                 buf[1] =3D cpu_to_le32(ftr->otype);
>                 buf[2] =3D cpu_to_le32(ftr->flags);
> +               buf[3] =3D cpu_to_le32(ftr->match_type);
>
> -               if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETRAN=
S) {
> +               if (p->policyvers >=3D MOD_POLICYDB_VERSION_PREFIX_SUFFIX=
) {
> +                       entries =3D 4;
> +               } else if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_T=
YPETRANS) {
>                         entries =3D 3;
>                 } else if (!(ftr->flags & RULE_SELF)) {
>                         entries =3D 2;
> @@ -2370,12 +2396,29 @@ int policydb_write(policydb_t * p, struct policy_=
file *fp)
>                 if (role_allow_write(p->role_allow, fp))
>                         return POLICYDB_ERROR;
>                 if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS) {
> -                       if (filename_trans_write(p, fp))
> +                       if (filename_trans_write(p, FILENAME_TRANS_MATCH_=
EXACT,
> +                                                fp))
>                                 return POLICYDB_ERROR;
>                 } else {
> -                       if (p->filename_trans)
> +                       if (p->filename_trans[FILENAME_TRANS_MATCH_EXACT]=
)
>                                 WARN(fp->handle, "Discarding filename typ=
e transition rules");
>                 }
> +               if (p->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
> +                       if (filename_trans_write(p, FILENAME_TRANS_MATCH_=
PREFIX,
> +                                                fp) ||
> +                           filename_trans_write(p, FILENAME_TRANS_MATCH_=
SUFFIX,
> +                                                fp))
> +                               return POLICYDB_ERROR;
> +               } else {
> +                       if (p->filename_trans[FILENAME_TRANS_MATCH_PREFIX=
] &&
> +                           p->filename_trans[FILENAME_TRANS_MATCH_PREFIX=
]->nel)
> +                               WARN(fp->handle,
> +                                    "Discarding prefix filename type tra=
nsition rules");
> +                       if (p->filename_trans[FILENAME_TRANS_MATCH_SUFFIX=
] &&
> +                           p->filename_trans[FILENAME_TRANS_MATCH_SUFFIX=
]->nel)
> +                               WARN(fp->handle,
> +                                    "Discarding suffix filename type tra=
nsition rules");
> +               }
>         } else {
>                 if (avrule_block_write(p->global, num_syms, p, fp) =3D=3D=
 -1) {
>                         return POLICYDB_ERROR;
> diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
> index e6b78618..73e678a7 100644
> --- a/secilc/test/policy.cil
> +++ b/secilc/test/policy.cil
> @@ -134,6 +134,8 @@
>         (typetransition device_t exec_type files console_device_t)
>         (typetransition exec_type self files console_device_t)
>         (typetransition exec_type self files "filename" console_device_t)
> +       (typetransition exec_type self files "filename" prefix console_de=
vice_t)
> +       (typetransition exec_type self files "filename" suffix console_de=
vice_t)
>         (typechange console_device_t device_t file user_tty_device_t)
>         (typechange exec_type device_t file user_tty_device_t)
>         (typechange exec_type self file console_device_t)
> @@ -153,6 +155,8 @@
>         (rangetransition device_t kernel_t file ((s0) (s3 (not c3))))
>
>         (typetransition device_t console_t file "some_file" getty_t)
> +       (typetransition device_t console_t file "some_file" prefix getty_=
t)
> +       (typetransition device_t console_t file "some_file" suffix getty_=
t)
>
>         (allow foo_type self (file (execute)))
>         (allow bin_t device_t (file (execute)))
> --
> 2.42.0
>

--000000000000a34e0a060abe046b
Content-Type: text/x-patch; charset="US-ASCII"; name="prefix_fixes.patch"
Content-Disposition: attachment; filename="prefix_fixes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lp9tocsx0>
X-Attachment-Id: f_lp9tocsx0

ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL2NpbC9zcmMvY2lsX2J1aWxkX2FzdC5jIGIvbGlic2Vwb2wv
Y2lsL3NyYy9jaWxfYnVpbGRfYXN0LmMKaW5kZXggNTllOGM2Y2IuLjBlNDhiNTUxIDEwMDY0NAot
LS0gYS9saWJzZXBvbC9jaWwvc3JjL2NpbF9idWlsZF9hc3QuYworKysgYi9saWJzZXBvbC9jaWwv
c3JjL2NpbF9idWlsZF9hc3QuYwpAQCAtMzQzNyw3ICszNDM3LDEyIEBAIGludCBjaWxfZ2VuX3R5
cGV0cmFuc2l0aW9uKHN0cnVjdCBjaWxfZGIgKmRiLCBzdHJ1Y3QgY2lsX3RyZWVfbm9kZSAqcGFy
c2VfY3VycmVuCiAJCW5hbWV0eXBldHJhbnMtPm9ial9zdHIgPSBzMzsKIAkJbmFtZXR5cGV0cmFu
cy0+bmFtZV9zdHIgPSBzNDsKIAkJbmFtZXR5cGV0cmFucy0+bmFtZSA9IGNpbF9nZW5fZGVjbGFy
ZWRfc3RyaW5nKGRiLCBzNCwgYXN0X25vZGUpOwotCQluYW1ldHlwZXRyYW5zLT5yZXN1bHRfc3Ry
ID0gczU7CisJCWlmIChzNikgeworCQkJbmFtZXR5cGV0cmFucy0+bWF0Y2hfdHlwZV9zdHIgPSBz
NTsKKwkJCW5hbWV0eXBldHJhbnMtPnJlc3VsdF9zdHIgPSBzNjsKKwkJfSBlbHNlIHsKKwkJCW5h
bWV0eXBldHJhbnMtPnJlc3VsdF9zdHIgPSBzNTsKKwkJfQogCX0gZWxzZSB7CiAJCXN0cnVjdCBj
aWxfdHlwZV9ydWxlICpydWxlID0gTlVMTDsKIAkJY2lsX3R5cGVfcnVsZV9pbml0KCZydWxlKTsK
ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL2NpbC9zcmMvY2lsX2NvcHlfYXN0LmMgYi9saWJzZXBvbC9j
aWwvc3JjL2NpbF9jb3B5X2FzdC5jCmluZGV4IDE1MDdlZGI0Li41MWE0NGNkYiAxMDA2NDQKLS0t
IGEvbGlic2Vwb2wvY2lsL3NyYy9jaWxfY29weV9hc3QuYworKysgYi9saWJzZXBvbC9jaWwvc3Jj
L2NpbF9jb3B5X2FzdC5jCkBAIC03MjMsOSArNzIzLDkgQEAgaW50IGNpbF9jb3B5X25hbWV0eXBl
dHJhbnNpdGlvbihfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSBzdHJ1Y3QgY2lsX2RiICpkYiwgdm9p
ZAogCW5ldy0+b2JqX3N0ciA9IG9yaWctPm9ial9zdHI7CiAJbmV3LT5uYW1lX3N0ciA9IG9yaWct
Pm5hbWVfc3RyOwogCW5ldy0+bmFtZSA9IG9yaWctPm5hbWU7CisJbmV3LT5tYXRjaF90eXBlX3N0
ciA9IG9yaWctPm1hdGNoX3R5cGVfc3RyOwogCW5ldy0+cmVzdWx0X3N0ciA9IG9yaWctPnJlc3Vs
dF9zdHI7CiAKLQogCSpjb3B5ID0gbmV3OwogCiAJcmV0dXJuIFNFUE9MX09LOwpkaWZmIC0tZ2l0
IGEvbGlic2Vwb2wvY2lsL3NyYy9jaWxfaW50ZXJuYWwuaCBiL2xpYnNlcG9sL2NpbC9zcmMvY2ls
X2ludGVybmFsLmgKaW5kZXggNmVmZDIyNmEuLjlkMTc3ZmEwIDEwMDY0NAotLS0gYS9saWJzZXBv
bC9jaWwvc3JjL2NpbF9pbnRlcm5hbC5oCisrKyBiL2xpYnNlcG9sL2NpbC9zcmMvY2lsX2ludGVy
bmFsLmgKQEAgLTU5MCw2ICs1OTAsOCBAQCBzdHJ1Y3QgY2lsX25hbWV0eXBldHJhbnNpdGlvbiB7
CiAJc3RydWN0IGNpbF9jbGFzcyAqb2JqOwogCWNoYXIgKm5hbWVfc3RyOwogCXN0cnVjdCBjaWxf
c3ltdGFiX2RhdHVtICpuYW1lOworCWNoYXIgKm1hdGNoX3R5cGVfc3RyOworCXVpbnQzMl90IG1h
dGNoX3R5cGU7IAogCWNoYXIgKnJlc3VsdF9zdHI7CiAJdm9pZCAqcmVzdWx0OyAvKiB0eXBlIG9y
IGFsaWFzICovCiAKZGlmZiAtLWdpdCBhL2xpYnNlcG9sL2NpbC9zcmMvY2lsX3BvbGljeS5jIGIv
bGlic2Vwb2wvY2lsL3NyYy9jaWxfcG9saWN5LmMKaW5kZXggZTlhOGY3NWQuLjk1MTdlODcxIDEw
MDY0NAotLS0gYS9saWJzZXBvbC9jaWwvc3JjL2NpbF9wb2xpY3kuYworKysgYi9saWJzZXBvbC9j
aWwvc3JjL2NpbF9wb2xpY3kuYwpAQCAtMTI1OSw2ICsxMjU5LDcgQEAgc3RhdGljIHZvaWQgY2ls
X25hbWV0eXBldHJhbnNpdGlvbl90b19wb2xpY3koRklMRSAqb3V0LCBzdHJ1Y3QgY2lsX25hbWV0
eXBldHJhbnMKIAlzdHJ1Y3QgY2lsX3N5bXRhYl9kYXR1bSAqc3JjLCAqdGd0LCAqbmFtZSwgKnJl
czsKIAlzdHJ1Y3QgY2lsX2xpc3QgKmNsYXNzX2xpc3Q7CiAJc3RydWN0IGNpbF9saXN0X2l0ZW0g
KmkxOworCWNvbnN0IGNoYXIgKm1hdGNoX3R5cGVfc3RyID0gIiI7CiAKIAlzcmMgPSB0cmFucy0+
c3JjOwogCXRndCA9IHRyYW5zLT50Z3Q7CkBAIC0xMjY3LDcgKzEyNjgsMjEgQEAgc3RhdGljIHZv
aWQgY2lsX25hbWV0eXBldHJhbnNpdGlvbl90b19wb2xpY3koRklMRSAqb3V0LCBzdHJ1Y3QgY2ls
X25hbWV0eXBldHJhbnMKIAogCWNsYXNzX2xpc3QgPSBjaWxfZXhwYW5kX2NsYXNzKHRyYW5zLT5v
YmopOwogCWNpbF9saXN0X2Zvcl9lYWNoKGkxLCBjbGFzc19saXN0KSB7Ci0JCWZwcmludGYob3V0
LCAidHlwZV90cmFuc2l0aW9uICVzICVzIDogJXMgJXMgXCIlc1wiO1xuIiwgc3JjLT5mcW4sIHRn
dC0+ZnFuLCBEQVRVTShpMS0+ZGF0YSktPmZxbiwgcmVzLT5mcW4sIG5hbWUtPmZxbik7CisJCXN3
aXRjaCAodHJhbnMtPm1hdGNoX3R5cGUpIHsKKwkJY2FzZSBGSUxFTkFNRV9UUkFOU19NQVRDSF9F
WEFDVDoKKwkJCW1hdGNoX3R5cGVfc3RyID0gIiI7CisJCQlicmVhazsKKwkJY2FzZSBGSUxFTkFN
RV9UUkFOU19NQVRDSF9QUkVGSVg6CisJCQltYXRjaF90eXBlX3N0ciA9ICIgcHJlZml4IjsKKwkJ
CWJyZWFrOworCQljYXNlIEZJTEVOQU1FX1RSQU5TX01BVENIX1NVRkZJWDoKKwkJCW1hdGNoX3R5
cGVfc3RyID0gIiBzdWZmaXgiOworCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQltYXRjaF90eXBl
X3N0ciA9ICI/Pz8iOworCQkJYnJlYWs7CisJCX0KKwkJZnByaW50ZihvdXQsICJ0eXBlX3RyYW5z
aXRpb24gJXMgJXMgOiAlcyAlcyBcIiVzXCIlcztcbiIsIHNyYy0+ZnFuLCB0Z3QtPmZxbiwgREFU
VU0oaTEtPmRhdGEpLT5mcW4sIHJlcy0+ZnFuLCBuYW1lLT5mcW4sIG1hdGNoX3R5cGVfc3RyKTsK
IAl9CiAJY2lsX2xpc3RfZGVzdHJveSgmY2xhc3NfbGlzdCwgQ0lMX0ZBTFNFKTsKIH0KZGlmZiAt
LWdpdCBhL2xpYnNlcG9sL2NpbC9zcmMvY2lsX3Jlc29sdmVfYXN0LmMgYi9saWJzZXBvbC9jaWwv
c3JjL2NpbF9yZXNvbHZlX2FzdC5jCmluZGV4IDQyN2EzMjBjLi4xZTY5MmJkMyAxMDA2NDQKLS0t
IGEvbGlic2Vwb2wvY2lsL3NyYy9jaWxfcmVzb2x2ZV9hc3QuYworKysgYi9saWJzZXBvbC9jaWwv
c3JjL2NpbF9yZXNvbHZlX2FzdC5jCkBAIC02NjUsNiArNjY1LDE4IEBAIGludCBjaWxfcmVzb2x2
ZV9uYW1ldHlwZXRyYW5zaXRpb24oc3RydWN0IGNpbF90cmVlX25vZGUgKmN1cnJlbnQsIHN0cnVj
dCBjaWxfZGIKIAkJbmFtZXR5cGV0cmFucy0+bmFtZSA9IG5hbWVfZGF0dW07CiAJfQogCisJaWYg
KG5hbWV0eXBldHJhbnMtPm1hdGNoX3R5cGVfc3RyID09IE5VTEwpIHsKKwkJbmFtZXR5cGV0cmFu
cy0+bWF0Y2hfdHlwZSA9IEZJTEVOQU1FX1RSQU5TX01BVENIX0VYQUNUOworCX0gZWxzZSBpZiAo
bmFtZXR5cGV0cmFucy0+bWF0Y2hfdHlwZV9zdHIgPT0gQ0lMX0tFWV9QUkVGSVgpIHsKKwkJbmFt
ZXR5cGV0cmFucy0+bWF0Y2hfdHlwZSA9IEZJTEVOQU1FX1RSQU5TX01BVENIX1BSRUZJWDsKKwl9
IGVsc2UgaWYgKG5hbWV0eXBldHJhbnMtPm1hdGNoX3R5cGVfc3RyID09IENJTF9LRVlfU1VGRklY
KSB7CisJCW5hbWV0eXBldHJhbnMtPm1hdGNoX3R5cGUgPSBGSUxFTkFNRV9UUkFOU19NQVRDSF9T
VUZGSVg7CisJfSBlbHNlIHsKKwkJY2lsX3RyZWVfbG9nKGN1cnJlbnQsIENJTF9FUlIsICJJbnZh
bGlkIG5hbWUgbWF0Y2ggdHlwZSBcIiVzXCIiLCBuYW1ldHlwZXRyYW5zLT5tYXRjaF90eXBlX3N0
cik7CisJCXJjID0gU0VQT0xfRVJSOworCQlnb3RvIGV4aXQ7CisJfQorCiAJcmMgPSBjaWxfcmVz
b2x2ZV9uYW1lKGN1cnJlbnQsIG5hbWV0eXBldHJhbnMtPnJlc3VsdF9zdHIsIENJTF9TWU1fVFlQ
RVMsIGRiLCAmcmVzdWx0X2RhdHVtKTsKIAlpZiAocmMgIT0gU0VQT0xfT0spIHsKIAkJZ290byBl
eGl0OwpkaWZmIC0tZ2l0IGEvbGlic2Vwb2wvY2lsL3NyYy9jaWxfd3JpdGVfYXN0LmMgYi9saWJz
ZXBvbC9jaWwvc3JjL2NpbF93cml0ZV9hc3QuYwppbmRleCBmNGY5ZjE2Ny4uZDZjNmI4ZjEgMTAw
NjQ0Ci0tLSBhL2xpYnNlcG9sL2NpbC9zcmMvY2lsX3dyaXRlX2FzdC5jCisrKyBiL2xpYnNlcG9s
L2NpbC9zcmMvY2lsX3dyaXRlX2FzdC5jCkBAIC0xMjE3LDYgKzEyMTcsOCBAQCB2b2lkIGNpbF93
cml0ZV9hc3Rfbm9kZShGSUxFICpvdXQsIHN0cnVjdCBjaWxfdHJlZV9ub2RlICpub2RlKQogCQl9
IGVsc2UgewogCQkJZnByaW50ZihvdXQsICIlcyAiLCBydWxlLT5uYW1lX3N0cik7CiAJCX0KKwkJ
aWYgKHJ1bGUtPm1hdGNoX3R5cGUgIT0gRklMRU5BTUVfVFJBTlNfTUFUQ0hfRVhBQ1QpCisJCQlm
cHJpbnRmKG91dCwgIiVzICIsIHJ1bGUtPm1hdGNoX3R5cGVfc3RyKTsKIAkJZnByaW50ZihvdXQs
ICIlcyIsIGRhdHVtX29yX3N0cihEQVRVTShydWxlLT5yZXN1bHQpLCBydWxlLT5yZXN1bHRfc3Ry
KSk7CiAJCWZwcmludGYob3V0LCAiKVxuIik7CiAJCWJyZWFrOwo=
--000000000000a34e0a060abe046b--
