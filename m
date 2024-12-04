Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1F1E0B62
	for <selinux@vger.kernel.org>; Wed,  4 Dec 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320898; cv=none; b=f7TvtbF4I37UuxEox6b001t1fh1JEFpRaxIyipQ3tTv9qLwtbE1agtnZ3EcqCxdssybiNbqUlCKmkfSFjgmWLvDMambM92NvwbnNSskymZOalojaCYQrP1TGWG4snt7ft/dOo7cD2Twfj6qBTUn7hr6U7fAQ8iaN+DCtIr5pHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320898; c=relaxed/simple;
	bh=ixdHRg9NZ6X70iO87IB1JgHj+otJHWKq9sflZjnRqnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4SJGvTwwWKAdUGQrHqmOrUe6lIAe6O33AO8ecEpSXK1hc12bWEiH6gYBHXVOZ+LDkSzli5Lw+OviSDIHOBQ7mv1DbHxHLuKLzd9hIzilZUp6xQWHRep+367XcQF7KYFYlNmbskLE4tfs54TNqzuqqSI4+qWj0Vo5jtw3IsMyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=f9C+ubvu; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f9C+ubvu"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef6a67834fso45375417b3.2
        for <selinux@vger.kernel.org>; Wed, 04 Dec 2024 06:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1733320895; x=1733925695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2TkcSQ6Y7xKoraUJIBxNEb6S6PxCsDp162bUeNZIBc=;
        b=f9C+ubvuqcok1J/KFJ7TvT8KNjchoXAwlsoMxp4VKjRo4fveFo/gsUgB3wlgUlSXIi
         RigY48wWyxucRpP6Ljx+p+vMJwv+nVsDMFGryXshq4KOKt8PCV445ddPx6XQbSIApI1i
         BWB+iMkUtj5mRH5MPmWlTbI+vqYxVANQaq7UUcLVXdCD4wH5O3ZMb1q3kY57bKgH0dkv
         uXTbgxDIoKJxMYyDRI7w8MCGXyLX6RjKgE96KsFyBpSZRBEgzHyRq7NrKc06lu1SXQa0
         3RwEXAIDRBUZQrPIGJR6Bg7ujhClC/fNvBW0yOmsbGZRvVDnZa2zzR1evIToEzKvVPDQ
         x2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320895; x=1733925695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2TkcSQ6Y7xKoraUJIBxNEb6S6PxCsDp162bUeNZIBc=;
        b=LF1ObzagP+erGQtWInMQJB/rhjfYNqvv8Kx/R82zJr+JlE/v/cDJ4MCoBFHZ8FlZ+w
         dQVqoX7mxZhODN93GiNLcC2xV1TDmDQrRNySaBrJ6wfmcdYIuXg6srLgsGAOjnbnwUUe
         npvNd1YyBik1uJVd6g1z8oXVU5Zn75UxpwKujZmKRTN7vTnqGXkKGP4uudXdUtk7lJn2
         iTQUHPTHjMfxMHAtSQaPEMYcwuJ4a3U4YsrModJG4NPWfEmjhTXn1o9f11FUis0aaeqc
         d2vwoceVwlndcizp4/nVOTE7cbBpnCZuH2ki+4bzMf1XZQOTh9NTrJQdWxnRG3ps2xoE
         D85g==
X-Gm-Message-State: AOJu0YyKDooCLsZCvKYfCtEpqJv0QA8/zidRZ2i56sfa+bJLM8l2L7cs
	DCItLnnrWlXdEYfVwcNYzHyAlDJt6ir7Pj/t4xgniD6pwZvzYZXbXqJ4IVWRWNdVsJrmtfOZ3DF
	OpBYF20gGGu5IJoCXfGoqgRmHNYs=
X-Gm-Gg: ASbGncumaT0EszTGIggAC4/YVKquFjQtZauDF7SZWNwNlCGm/nsC2OwQZMH2uJV9l6b
	cQF4pugiKK0AruRm7XMi+DS8YxdzQow==
X-Google-Smtp-Source: AGHT+IF/sBOpR080qVgmwxfBzf52FQwbcXgE6F9sP48hca6/Cr1DGOk5sSO6GRTN+X9Y3jgqNKEedATKQHRY0gs2RNY=
X-Received: by 2002:a05:6902:2b88:b0:e30:e1a5:27bc with SMTP id
 3f1490d57ef6-e39d436c937mr7659290276.37.1733320894591; Wed, 04 Dec 2024
 06:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202113816.55299-1-cgoettsche@seltendoof.de> <CAEjxPJ7=7X7qaUq87Bc=q7Ft0tWu4fvuAT4jL_BLivoRAJ1N1w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7=7X7qaUq87Bc=q7Ft0tWu4fvuAT4jL_BLivoRAJ1N1w@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 4 Dec 2024 15:01:21 +0100
Message-ID: <CAJ2a_Df3xEWw52M5Bq=KFSkPAEK+ibAR3HFYBSbKVCg=esVB4g@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce POLICYDB_VERSION_KERNEL_MAX
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 at 15:26, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Dec 2, 2024 at 6:38=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > SELinux userspace currently (and importantly in 3.8-rc1) supports
> > extended permissions in conditional blocks, while the kernel does not
> > and support will earliest arrive in 6.14.
> > Introduce a new version macro defining the maximum policy the current
> > stable kernel (at the time of the expected next userspace release)
> > supports, which then all tools can use as the default output policy
> > version.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > This is an alternative to reverting the support.
> >
> > I bundled all changes into one patch for this draft, but I can split it
> > in further revisions.
>
> Apologies if you explained elsewhere, but I don't understand why this
> is necessary or desirable.
> The way things are supposed to work is that the policy compiler
> toolchain builds the latest version it supports, then
> libselinux/libsepol downgrade if necessary to the kernel-supported
> version at load time.
> At least that is how it has worked in the past.

You're right, and it seems to work. Adding a conditional xperm rule
and trying to load fails with:

Loading configured modules.
libsepol.avtab_write_item: policy version 33 does not support
extendedpermissions rules in conditional policies and one was
specified
libsepol.policydb_to_image: could not compute policy length
libsepol.policydb_to_image: could not create policy image
SELinux:  Could not downgrade policy file
/etc/selinux/refpolicy/policy/policy.34, searching for an older
version.
SELinux:  Could not open policy file <=3D
/etc/selinux/refpolicy/policy/policy.34:  No such file or directory
/sbin/load_policy:  Can't load policy:  No such file or directory
libsemanage.semanage_reload_policy: load_policy returned error code 2.
(No such file or directory).
libsepol.avtab_write_item: policy version 33 does not support
extendedpermissions rules in conditional policies and one was
specified
libsepol.policydb_to_image: could not compute policy length
libsepol.policydb_to_image: could not create policy image
SELinux:  Could not downgrade policy file
/etc/selinux/refpolicy/policy/policy.34, searching for an older
version.
SELinux:  Could not open policy file <=3D
/etc/selinux/refpolicy/policy/policy.34:  No such file or directory
/sbin/load_policy:  Can't load policy:  No such file or directory
libsemanage.semanage_reload_policy: load_policy returned error code 2.
(No such file or directory).
/usr/sbin/semodule:  Failed!

Without such a rule the policy is successfully downgraded.

I am withdrawing this patch.

> And it is already possible to select a specific target version if
> desired through libsemanage configuration or checkpolicy/secilc
> command-line options as appropriate.
>
> > ---
> >  checkpolicy/checkpolicy.c                  | 8 ++++----
> >  checkpolicy/tests/test_roundtrip.sh        | 4 ++--
> >  libsemanage/man/man5/semanage.conf.5       | 2 +-
> >  libsemanage/src/semanage.conf              | 2 +-
> >  libsepol/cil/src/cil.c                     | 2 +-
> >  libsepol/include/sepol/policydb/policydb.h | 3 +++
> >  libsepol/src/expand.c                      | 2 +-
> >  libsepol/src/policydb_public.c             | 4 ++--
> >  secilc/Makefile                            | 6 +++---
> >  secilc/secilc.c                            | 4 ++--
> >  10 files changed, 20 insertions(+), 17 deletions(-)
> >
> > diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> > index ede2b6ad..34e51312 100644
> > --- a/checkpolicy/checkpolicy.c
> > +++ b/checkpolicy/checkpolicy.c
> > @@ -514,7 +514,7 @@ int main(int argc, char **argv)
> >
> >         if (show_version) {
> >                 printf("%d (compatibility range %d-%d)\n",
> > -                          policyvers ? policyvers : POLICYDB_VERSION_M=
AX ,
> > +                          policyvers ? policyvers : POLICYDB_VERSION_K=
ERNEL_MAX ,
> >                        POLICYDB_VERSION_MAX, POLICYDB_VERSION_MIN);
> >                 exit(0);
> >         }
> > @@ -595,7 +595,7 @@ int main(int argc, char **argv)
> >                                 policydbp->policyvers =3D policyvers;
> >                         }
> >                 } else {
> > -                       policydbp->policyvers =3D policyvers ? policyve=
rs : POLICYDB_VERSION_MAX;
> > +                       policydbp->policyvers =3D policyvers ? policyve=
rs : POLICYDB_VERSION_KERNEL_MAX;
> >                 }
> >         } else {
> >                 if (conf) {
> > @@ -611,7 +611,7 @@ int main(int argc, char **argv)
> >                 /* Let sepol know if we are dealing with MLS support */
> >                 parse_policy.mls =3D mlspol;
> >                 parse_policy.handle_unknown =3D handle_unknown;
> > -               parse_policy.policyvers =3D policyvers ? policyvers : P=
OLICYDB_VERSION_MAX;
> > +               parse_policy.policyvers =3D policyvers ? policyvers : P=
OLICYDB_VERSION_KERNEL_MAX;
> >
> >                 policydbp =3D &parse_policy;
> >
> > @@ -636,7 +636,7 @@ int main(int argc, char **argv)
> >                                 fprintf(stderr, "Error while expanding =
policy\n");
> >                                 exit(1);
> >                         }
> > -                       policydb.policyvers =3D policyvers ? policyvers=
 : POLICYDB_VERSION_MAX;
> > +                       policydb.policyvers =3D policyvers ? policyvers=
 : POLICYDB_VERSION_KERNEL_MAX;
> >                         policydb_destroy(policydbp);
> >                         policydbp =3D &policydb;
> >                 }
> > diff --git a/checkpolicy/tests/test_roundtrip.sh b/checkpolicy/tests/te=
st_roundtrip.sh
> > index d05b36bb..f2c7702f 100755
> > --- a/checkpolicy/tests/test_roundtrip.sh
> > +++ b/checkpolicy/tests/test_roundtrip.sh
> > @@ -31,8 +31,8 @@ check_policy  policy_minimal.conf      policy_minimal=
.conf                   '-E
> >  check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf        =
       '-M -E'
> >  check_policy  policy_minimal_mls.conf  policy_minimal_mls.conf        =
       '-M -E -S -O'
> >
> > -check_policy  policy_allonce.conf      policy_allonce.expected.conf   =
       ''
> > -check_policy  policy_allonce.conf      policy_allonce.expected_opt.con=
f      '-S -O'
> > +check_policy  policy_allonce.conf      policy_allonce.expected.conf   =
       '-c 34'
> > +check_policy  policy_allonce.conf      policy_allonce.expected_opt.con=
f      '-c 34 -S -O'
> >
> >  check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected.con=
f      '-M'
> >  check_policy  policy_allonce_mls.conf  policy_allonce_mls.expected_opt=
.conf  '-M -S -O'
> > diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man=
5/semanage.conf.5
> > index b22e65bd..ea2292c8 100644
> > --- a/libsemanage/man/man5/semanage.conf.5
> > +++ b/libsemanage/man/man5/semanage.conf.5
> > @@ -48,7 +48,7 @@ If the cache is ignored, then all CIL modules are rec=
ompiled from their HLL modu
> >  .B policy-version
> >  When generating the policy, by default
> >  .BR semanage
> > -will set the policy version to POLICYDB_VERSION_MAX, as defined in <se=
pol/policydb/policydb.h>. Change this setting if a different
> > +will set the policy version to POLICYDB_VERSION_KERNEL_MAX, as defined=
 in <sepol/policydb/policydb.h>. Change this setting if a different
> >  version needs to be set for the policy.
> >
> >  .TP
> > diff --git a/libsemanage/src/semanage.conf b/libsemanage/src/semanage.c=
onf
> > index 98d769b5..674c0550 100644
> > --- a/libsemanage/src/semanage.conf
> > +++ b/libsemanage/src/semanage.conf
> > @@ -32,7 +32,7 @@
> >  module-store =3D direct
> >
> >  # When generating the final linked and expanded policy, by default
> > -# semanage will set the policy version to POLICYDB_VERSION_MAX, as
> > +# semanage will set the policy version to POLICYDB_VERSION_KERNEL_MAX,=
 as
> >  # given in <sepol/policydb.h>.  Change this setting if a different
> >  # version is necessary.
> >  #policy-version =3D 19
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index 5521c7ea..b4063515 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -464,7 +464,7 @@ void cil_db_init(struct cil_db **db)
> >         (*db)->multiple_decls =3D CIL_FALSE;
> >         (*db)->qualified_names =3D CIL_FALSE;
> >         (*db)->target_platform =3D SEPOL_TARGET_SELINUX;
> > -       (*db)->policy_version =3D POLICYDB_VERSION_MAX;
> > +       (*db)->policy_version =3D POLICYDB_VERSION_KERNEL_MAX;
> >  }
> >
> >  static void cil_declared_strings_list_destroy(struct cil_list **string=
s)
> > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/incl=
ude/sepol/policydb/policydb.h
> > index f833354b..73520b61 100644
> > --- a/libsepol/include/sepol/policydb/policydb.h
> > +++ b/libsepol/include/sepol/policydb/policydb.h
> > @@ -765,6 +765,9 @@ extern int policydb_set_target_platform(policydb_t =
*p, int platform);
> >  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> >  #define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COND_XPERMS
> >
> > +/* Policy version stable Linux kernel understands */
> > +#define POLICYDB_VERSION_KERNEL_MAX    POLICYDB_VERSION_COMP_FTRANS
> > +
> >  /* Module versions and specific changes*/
> >  #define MOD_POLICYDB_VERSION_BASE              4
> >  #define MOD_POLICYDB_VERSION_VALIDATETRANS     5
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 7032a83f..8bb9fda9 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -2993,7 +2993,7 @@ int expand_module(sepol_handle_t * handle,
> >         }
> >
> >         state.out->policy_type =3D POLICY_KERN;
> > -       state.out->policyvers =3D POLICYDB_VERSION_MAX;
> > +       state.out->policyvers =3D POLICYDB_VERSION_KERNEL_MAX;
> >         if (state.base->name) {
> >                 state.out->name =3D strdup(state.base->name);
> >                 if (!state.out->name) {
> > diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_pub=
lic.c
> > index 0218c940..a102c954 100644
> > --- a/libsepol/src/policydb_public.c
> > +++ b/libsepol/src/policydb_public.c
> > @@ -91,7 +91,7 @@ int sepol_policy_kern_vers_min(void)
> >
> >  int sepol_policy_kern_vers_max(void)
> >  {
> > -       return POLICYDB_VERSION_MAX;
> > +       return POLICYDB_VERSION_KERNEL_MAX;
> >  }
> >
> >  int sepol_policydb_set_typevers(sepol_policydb_t * sp, unsigned int ty=
pe)
> > @@ -99,7 +99,7 @@ int sepol_policydb_set_typevers(sepol_policydb_t * sp=
, unsigned int type)
> >         struct policydb *p =3D &sp->p;
> >         switch (type) {
> >         case POLICY_KERN:
> > -               p->policyvers =3D POLICYDB_VERSION_MAX;
> > +               p->policyvers =3D POLICYDB_VERSION_KERNEL_MAX;
> >                 break;
> >         case POLICY_BASE:
> >         case POLICY_MOD:
> > diff --git a/secilc/Makefile b/secilc/Makefile
> > index ef7bc8cd..78b9ad73 100644
> > --- a/secilc/Makefile
> > +++ b/secilc/Makefile
> > @@ -21,7 +21,7 @@ XMLTO =3D xmlto
> >  DIFF =3D diff
> >
> >  CHECKPOLICY =3D checkpolicy
> > -POL_VERS =3D $(shell $(CHECKPOLICY) -V | cut -f 1 -d ' ')
> > +MAX_POL_VERS =3D $(shell $(CHECKPOLICY) -V | cut -f 4 -d ' ' | cut -f =
1 -d '-')
> >
> >  CFLAGS ?=3D -Wall -Wshadow -Wextra -Wundef -Wmissing-format-attribute =
-Wcast-align -Wstrict-prototypes -Wpointer-arith -Wunused
> >
> > @@ -34,8 +34,8 @@ $(SECILC): $(SECILC_OBJS)
> >         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
> >
> >  test: $(SECILC)
> > -       ./$(SECILC) test/policy.cil
> > -       ./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.b=
in test/opt-input.cil
> > +       ./$(SECILC) -c $(MAX_POL_VERS) test/policy.cil
> > +       ./$(SECILC) -c $(MAX_POL_VERS) -O -M 1 -f /dev/null -o opt-actu=
al.bin test/opt-input.cil
> >         $(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/=
null
> >         $(DIFF) test/opt-expected.cil opt-actual.cil
> >
> > diff --git a/secilc/secilc.c b/secilc/secilc.c
> > index f3102ca9..83639c2f 100644
> > --- a/secilc/secilc.c
> > +++ b/secilc/secilc.c
> > @@ -56,7 +56,7 @@ static __attribute__((__noreturn__)) void usage(const=
 char *prog)
> >         printf("                                 This will override the=
 (mls boolean) statement\n");
> >         printf("                                 if present in the poli=
cy\n");
> >         printf("  -c, --policyvers=3D<version>     build a binary polic=
y with a given <version>\n");
> > -       printf("                                 (default: %i)\n", POLI=
CYDB_VERSION_MAX);
> > +       printf("                                 (default: %i)\n", POLI=
CYDB_VERSION_KERNEL_MAX);
> >         printf("  -U, --handle-unknown=3D<action>  how to handle unknow=
n classes or permissions.\n");
> >         printf("                                 may be deny, allow, or=
 reject. (default: deny)\n");
> >         printf("                                 This will override the=
 (handleunknown action)\n");
> > @@ -99,7 +99,7 @@ int main(int argc, char *argv[])
> >         int preserve_tunables =3D 0;
> >         int qualified_names =3D 0;
> >         int handle_unknown =3D -1;
> > -       int policyvers =3D POLICYDB_VERSION_MAX;
> > +       int policyvers =3D POLICYDB_VERSION_KERNEL_MAX;
> >         int attrs_expand_generated =3D 0;
> >         int attrs_expand_size =3D -1;
> >         int optimize =3D 0;
> > --
> > 2.45.2
> >
> >
