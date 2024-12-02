Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2A205AB5
	for <selinux@vger.kernel.org>; Mon,  2 Dec 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149583; cv=none; b=NHC9URXt4flyf6KgeNFEHyTzSNCMJRQkripcb/gnnjsOwfpmaJ4vFQBPgIVX4Y8sZPexKkETC0+9XZAlb8vncp9LUyrbrZQ/yXvCvmrLRmoNkPLLQahlt+ZQjMwKxhzyjdMLwg6TXVnDYm6uDI79QhK7AUf1CprtkJwbbAbAucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149583; c=relaxed/simple;
	bh=hoia0AmDathe03QU4aEknxt6J2S/cQBp93mBAlbaczQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/f6Y9zh0+/ExtTUNbPFdrKNVu+Ik/0C+3J7lE73qYbBnmRq4aPDWQn1EX11tlfRIHT0518kFGbGlARgiEeArM+65MsEDZL+Z5hK86E3DtlMKXAlWY4S6L+eA+SRBm0uXTgAIy6dlBDIoOsU2LUawXPbywEwl3XFrZG8c3iAnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwz2Ugrs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwz2Ugrs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215810fff52so13836015ad.1
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2024 06:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733149580; x=1733754380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrDx7sNYeIA5Ti/fCw7/xwR76t/hSlKQGJGcH7p1KLc=;
        b=gwz2UgrsE2cHA8M23fklrLrt4iQDi65SVXNjtUcJtiwQLS8k5XaR/WdGp4SN+ovCYd
         QDv32qEZEKWW9LrFQUebGHifUvQDAW0lu3rb/EkwROsfVrVO/PBAr+fG6XzCmCQTK3qS
         n4eihkLF+qoD1F/hUY5/kfRwfcHLjcptZO4ZnTM5Yp3DCgex6FATlzP4ABvgEhtNpkjS
         XAKYhlgMwF5Kp9V208yiom/RFpKxz17WzPBt5Gcm6B3qJhKoSUviBeVpys4pYOddsHZI
         /yYnNzBAvSB8qMs8yLqcWLXfMXBLcGjGdGe85/zmka2ERV1vy8wz1tzLmMfERCkNrKLQ
         tlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149580; x=1733754380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrDx7sNYeIA5Ti/fCw7/xwR76t/hSlKQGJGcH7p1KLc=;
        b=e1vVLQ93EW0Rn6e62dL2JJgdum4FNAFhyihZO2o8POo/Uxt0sbbm/8oqfOzMwLqD5H
         ZVqc5EVTor2Zu3085I82n+fua0LsrHTq2DNMYYYWVVuD1tKeamglDNizYYBpNBn/6I4G
         igo8d0jW5evGkC+NUmUfHCL0za35bmlbFoc7l+yA3xlVz6PUFHoOQjJoT3mxSuIPOXmM
         TprivLN3N8ksr059ktZbBpb5WJxNpEHZIEh054Vjc/dba6nm8zozCQl7yOGtDAVOGEoS
         Adr8sliIT3u54/41DQQ5QHdv5dfCV7glZBauJKCCZTF8WlY9SfC4DmaF8dQeqEMVdMZY
         GQkg==
X-Gm-Message-State: AOJu0Yzn62w2k+P4f0vc80JDOzAm3Og9zM08WYhEvjyzjCB4W3CrwwMS
	C4qKoUpyWKNycTYk9D76aE3ZxXaGA+aoFvDlMLgxJYPKa5A6HlVjXt11ubFSxqobP2fqWrIrr1z
	DPSOoU6dchhHR9qWGM0AZdfcapOg=
X-Gm-Gg: ASbGncvF2d5cYgC4ctGvqdagcwsdNMr67p9h1UKCarPsfSwBQ+do6Vw+31SCd70wuwZ
	KcFABPHKuA9lUm0w26Rb8dgfncXzFFtA=
X-Google-Smtp-Source: AGHT+IGvHKznHv9dIKMSxYjT+MxnSE4gWhT8qMR2mIPJMIAL+PncYvrK1hfhEtZ+cLijBqtJS2qIUqPVuhvTTxdeFTU=
X-Received: by 2002:a17:903:1c3:b0:215:94b0:9df4 with SMTP id
 d9443c01a7336-21594b0a0ccmr60861565ad.54.1733149579323; Mon, 02 Dec 2024
 06:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202113816.55299-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241202113816.55299-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 2 Dec 2024 09:26:06 -0500
Message-ID: <CAEjxPJ7=7X7qaUq87Bc=q7Ft0tWu4fvuAT4jL_BLivoRAJ1N1w@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce POLICYDB_VERSION_KERNEL_MAX
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 6:38=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> SELinux userspace currently (and importantly in 3.8-rc1) supports
> extended permissions in conditional blocks, while the kernel does not
> and support will earliest arrive in 6.14.
> Introduce a new version macro defining the maximum policy the current
> stable kernel (at the time of the expected next userspace release)
> supports, which then all tools can use as the default output policy
> version.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> This is an alternative to reverting the support.
>
> I bundled all changes into one patch for this draft, but I can split it
> in further revisions.

Apologies if you explained elsewhere, but I don't understand why this
is necessary or desirable.
The way things are supposed to work is that the policy compiler
toolchain builds the latest version it supports, then
libselinux/libsepol downgrade if necessary to the kernel-supported
version at load time.
At least that is how it has worked in the past.
And it is already possible to select a specific target version if
desired through libsemanage configuration or checkpolicy/secilc
command-line options as appropriate.

> ---
>  checkpolicy/checkpolicy.c                  | 8 ++++----
>  checkpolicy/tests/test_roundtrip.sh        | 4 ++--
>  libsemanage/man/man5/semanage.conf.5       | 2 +-
>  libsemanage/src/semanage.conf              | 2 +-
>  libsepol/cil/src/cil.c                     | 2 +-
>  libsepol/include/sepol/policydb/policydb.h | 3 +++
>  libsepol/src/expand.c                      | 2 +-
>  libsepol/src/policydb_public.c             | 4 ++--
>  secilc/Makefile                            | 6 +++---
>  secilc/secilc.c                            | 4 ++--
>  10 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index ede2b6ad..34e51312 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -514,7 +514,7 @@ int main(int argc, char **argv)
>
>         if (show_version) {
>                 printf("%d (compatibility range %d-%d)\n",
> -                          policyvers ? policyvers : POLICYDB_VERSION_MAX=
 ,
> +                          policyvers ? policyvers : POLICYDB_VERSION_KER=
NEL_MAX ,
>                        POLICYDB_VERSION_MAX, POLICYDB_VERSION_MIN);
>                 exit(0);
>         }
> @@ -595,7 +595,7 @@ int main(int argc, char **argv)
>                                 policydbp->policyvers =3D policyvers;
>                         }
>                 } else {
> -                       policydbp->policyvers =3D policyvers ? policyvers=
 : POLICYDB_VERSION_MAX;
> +                       policydbp->policyvers =3D policyvers ? policyvers=
 : POLICYDB_VERSION_KERNEL_MAX;
>                 }
>         } else {
>                 if (conf) {
> @@ -611,7 +611,7 @@ int main(int argc, char **argv)
>                 /* Let sepol know if we are dealing with MLS support */
>                 parse_policy.mls =3D mlspol;
>                 parse_policy.handle_unknown =3D handle_unknown;
> -               parse_policy.policyvers =3D policyvers ? policyvers : POL=
ICYDB_VERSION_MAX;
> +               parse_policy.policyvers =3D policyvers ? policyvers : POL=
ICYDB_VERSION_KERNEL_MAX;
>
>                 policydbp =3D &parse_policy;
>
> @@ -636,7 +636,7 @@ int main(int argc, char **argv)
>                                 fprintf(stderr, "Error while expanding po=
licy\n");
>                                 exit(1);
>                         }
> -                       policydb.policyvers =3D policyvers ? policyvers :=
 POLICYDB_VERSION_MAX;
> +                       policydb.policyvers =3D policyvers ? policyvers :=
 POLICYDB_VERSION_KERNEL_MAX;
>                         policydb_destroy(policydbp);
>                         policydbp =3D &policydb;
>                 }
> diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/test=
_roundtrip.sh
> index d05b36bb..f2c7702f 100755
> --- a/checkpolicy/tests/test_roundtrip.sh
> +++ b/checkpolicy/tests/test_roundtrip.sh
> @@ -31,8 +31,8 @@ check_policy  policy_minimal.conf      policy_minimal.c=
onf                   '-E
>  check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf          =
     '-M -E'
>  check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf          =
     '-M -E -S -O'
>
> -check_policy  policy_allonce.conf      policy_allonce.expected.conf     =
     ''
> -check_policy  policy_allonce.conf      policy_allonce.expected_opt.conf =
     '-S -O'
> +check_policy  policy_allonce.conf      policy_allonce.expected.conf     =
     '-c 34'
> +check_policy  policy_allonce.conf      policy_allonce.expected_opt.conf =
     '-c 34 -S -O'
>
>  check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected.conf =
     '-M'
>  check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected_opt.c=
onf  '-M -S -O'
> diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/=
semanage.conf.5
> index b22e65bd..ea2292c8 100644
> --- a/libsemanage/man/man5/semanage.conf.5
> +++ b/libsemanage/man/man5/semanage.conf.5
> @@ -48,7 +48,7 @@ If the cache is ignored, then all CIL modules are recom=
piled from their HLL modu
>  .B policy-version
>  When generating the policy, by default
>  .BR semanage
> -will set the policy version to POLICYDB_VERSION_MAX, as defined in <sepo=
l/policydb/policydb.h>. Change this setting if a different
> +will set the policy version to POLICYDB_VERSION_KERNEL_MAX, as defined i=
n <sepol/policydb/policydb.h>. Change this setting if a different
>  version needs to be set for the policy.
>
>  .TP
> diff --git a/libsemanage/src/semanage.conf b/libsemanage/src/semanage.con=
f
> index 98d769b5..674c0550 100644
> --- a/libsemanage/src/semanage.conf
> +++ b/libsemanage/src/semanage.conf
> @@ -32,7 +32,7 @@
>  module-store =3D direct
>
>  # When generating the final linked and expanded policy, by default
> -# semanage will set the policy version to POLICYDB_VERSION_MAX, as
> +# semanage will set the policy version to POLICYDB_VERSION_KERNEL_MAX, a=
s
>  # given in <sepol/policydb.h>.  Change this setting if a different
>  # version is necessary.
>  #policy-version =3D 19
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 5521c7ea..b4063515 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -464,7 +464,7 @@ void cil_db_init(struct cil_db **db)
>         (*db)->multiple_decls =3D CIL_FALSE;
>         (*db)->qualified_names =3D CIL_FALSE;
>         (*db)->target_platform =3D SEPOL_TARGET_SELINUX;
> -       (*db)->policy_version =3D POLICYDB_VERSION_MAX;
> +       (*db)->policy_version =3D POLICYDB_VERSION_KERNEL_MAX;
>  }
>
>  static void cil_declared_strings_list_destroy(struct cil_list **strings)
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index f833354b..73520b61 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -765,6 +765,9 @@ extern int policydb_set_target_platform(policydb_t *p=
, int platform);
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>  #define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COND_XPERMS
>
> +/* Policy version stable Linux kernel understands */
> +#define POLICYDB_VERSION_KERNEL_MAX    POLICYDB_VERSION_COMP_FTRANS
> +
>  /* Module versions and specific changes*/
>  #define MOD_POLICYDB_VERSION_BASE              4
>  #define MOD_POLICYDB_VERSION_VALIDATETRANS     5
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 7032a83f..8bb9fda9 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2993,7 +2993,7 @@ int expand_module(sepol_handle_t * handle,
>         }
>
>         state.out->policy_type =3D POLICY_KERN;
> -       state.out->policyvers =3D POLICYDB_VERSION_MAX;
> +       state.out->policyvers =3D POLICYDB_VERSION_KERNEL_MAX;
>         if (state.base->name) {
>                 state.out->name =3D strdup(state.base->name);
>                 if (!state.out->name) {
> diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_publi=
c.c
> index 0218c940..a102c954 100644
> --- a/libsepol/src/policydb_public.c
> +++ b/libsepol/src/policydb_public.c
> @@ -91,7 +91,7 @@ int sepol_policy_kern_vers_min(void)
>
>  int sepol_policy_kern_vers_max(void)
>  {
> -       return POLICYDB_VERSION_MAX;
> +       return POLICYDB_VERSION_KERNEL_MAX;
>  }
>
>  int sepol_policydb_set_typevers(sepol_policydb_t * sp, unsigned int type=
)
> @@ -99,7 +99,7 @@ int sepol_policydb_set_typevers(sepol_policydb_t * sp, =
unsigned int type)
>         struct policydb *p =3D &sp->p;
>         switch (type) {
>         case POLICY_KERN:
> -               p->policyvers =3D POLICYDB_VERSION_MAX;
> +               p->policyvers =3D POLICYDB_VERSION_KERNEL_MAX;
>                 break;
>         case POLICY_BASE:
>         case POLICY_MOD:
> diff --git a/secilc/Makefile b/secilc/Makefile
> index ef7bc8cd..78b9ad73 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -21,7 +21,7 @@ XMLTO =3D xmlto
>  DIFF =3D diff
>
>  CHECKPOLICY =3D checkpolicy
> -POL_VERS =3D $(shell $(CHECKPOLICY) -V | cut -f 1 -d ' ')
> +MAX_POL_VERS =3D $(shell $(CHECKPOLICY) -V | cut -f 4 -d ' ' | cut -f 1 =
-d '-')
>
>  CFLAGS ?=3D -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute -W=
cast-align -Wstrict-prototypes -Wpointer-arith -Wunused
>
> @@ -34,8 +34,8 @@ $(SECILC): $(SECILC_OBJS)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>
>  test: $(SECILC)
> -       ./$(SECILC) test/policy.cil
> -       ./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin=
 test/opt-input.cil
> +       ./$(SECILC) -c $(MAX_POL_VERS) test/policy.cil
> +       ./$(SECILC) -c $(MAX_POL_VERS) -O -M 1 -f /dev/null -o opt-actual=
.bin test/opt-input.cil
>         $(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/nu=
ll
>         $(DIFF) test/opt-expected.cil opt-actual.cil
>
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index f3102ca9..83639c2f 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -56,7 +56,7 @@ static __attribute__((__noreturn__)) void usage(const c=
har *prog)
>         printf("                                 This will override the (=
mls boolean) statement\n");
>         printf("                                 if present in the policy=
\n");
>         printf("  -c, --policyvers=3D<version>     build a binary policy =
with a given <version>\n");
> -       printf("                                 (default: %i)\n", POLICY=
DB_VERSION_MAX);
> +       printf("                                 (default: %i)\n", POLICY=
DB_VERSION_KERNEL_MAX);
>         printf("  -U, --handle-unknown=3D<action>  how to handle unknown =
classes or permissions.\n");
>         printf("                                 may be deny, allow, or r=
eject. (default: deny)\n");
>         printf("                                 This will override the (=
handleunknown action)\n");
> @@ -99,7 +99,7 @@ int main(int argc, char *argv[])
>         int preserve_tunables =3D 0;
>         int qualified_names =3D 0;
>         int handle_unknown =3D -1;
> -       int policyvers =3D POLICYDB_VERSION_MAX;
> +       int policyvers =3D POLICYDB_VERSION_KERNEL_MAX;
>         int attrs_expand_generated =3D 0;
>         int attrs_expand_size =3D -1;
>         int optimize =3D 0;
> --
> 2.45.2
>
>
