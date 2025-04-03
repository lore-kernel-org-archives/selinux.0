Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC22405F9
	for <selinux@vger.kernel.org>; Thu,  3 Apr 2025 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665388; cv=none; b=pRoauSqbbS4icMbP+ohNr8brrAkRbfo2WKlpZpRv+IGnltx7z2CMcd/6Sou86CBVv6J8K+jHZXu2ptpa80Z0BpbyycsMjRf0qOWWUDs3dymQuVkX0nG40uyFG0582DB0lm5QB4Xf8cK8z+7uzR+HAErmyB/EWI2wMB6skML2/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665388; c=relaxed/simple;
	bh=otyMuGjJvVduAbQ8cjSTlBLTa1rDZqTjV+C26zSneYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GShEw7BzChSWwD5CtrcVOvpJBNpqnXKi+ANRPXrO75OO8UqItoWMy1QWTlvVPgWWvy7uKYXsfBrWmI6XriXOfPlk878bctes11PFfMWz4GYZbI8FXpIwpM+NL8uhZwlhcDpPu3P1P0Knt5Fz5dlOp+NyEnSLXSBdQ14kQIImKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aO1t38sL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aO1t38sL"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso19992a12.1
        for <selinux@vger.kernel.org>; Thu, 03 Apr 2025 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743665384; x=1744270184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eijy7YSXZ9J3kpEYi18QkgbQ+1JxXoteQZrtXiI4CcM=;
        b=aO1t38sLUVirTBwMzDG8foBAuYiMm/CXNuGLuiOfGu0go9KYKAUMGDdJqQKjORmuxm
         xFIaRJJztiP+GnPlqWNrbKo55/rEyGUvIhBPSdd8LiAHOwybAgoDrHePQRkGIbtcq8Z1
         J/7+xD25PPRcTaCkCi4qdkZJaKs0eyXslASZNy4jxxu5m8dz2pK5jl7CfeOwOFN+GepM
         vfb2rFM67O2ukUXXQmuRpIMgnZ0+jbQTUmN/JVlTHSwU30JHokDDoY8hYc3CsVdeZCEV
         18+urg7WR9/AbWQXKjVgUxDphox9jbHjeXhUSYCyD0ygqrw3kjEfpl+GDEZirtuFte0V
         VvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743665384; x=1744270184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eijy7YSXZ9J3kpEYi18QkgbQ+1JxXoteQZrtXiI4CcM=;
        b=LSpVh1T4Wq5RVzjmhTfIUx8u2s7DaML4CH0Twgw2Pwqb7lOnfL6yCYKBz3hgkiMJya
         6ygtfqNJSZNkPNi7G1uzh1eWrSpU2g5dvAiZ/spIaIYaD5xPyoABDMtLoG41Pr0FIJp4
         9HQlvZ6JKD9rPy+NklmSEXmbg/Y5VYrcjmWB3UDTCsBokliBVNrt0YTo0Twj9qPEPQtg
         fZ621CbSJSB5SltSeqwZkdRGxiX2yAwm+euODZuPj2I6yGva2OlB3mJAjisa9XK47UnH
         sSc7hudRgTm55ZwwVQUmeYQxHr99/KEvZbvaQvrRROoceDLLiHhlzoaHDqiq4XqTPdbY
         G7Ig==
X-Gm-Message-State: AOJu0YxnYCjm0be+8s92vAE8fj1I8ZDMqVqgP2//OM2FG3kM+HoJ7xYm
	KTzj7v387YjVKIwahlMYwidmc5HLIQK77uDqP4EC36AFifx8q1j7KenlYN2/67f3rwSDWUx4WYN
	KyMzj/zJ13yGAU/ftVxwP73gTTZ1Z9RSp1zyR
X-Gm-Gg: ASbGnct1Pw5o2Xv2g88wPGuCc7L1GFqK3S0ld6DNs6oEF7h67Fqu0cldiTwbSaoxpoA
	/IIDsVcdnQimYqSlIxQ5KPWNDHImPPC8L7GVsigzI3YxwbILsRseeR9O+LwL1oJj8G7ldJU3Pcc
	FTWY62myTrJY6pSp+ekHX56ZHS9LdEMS/eSD+1BUZ3rG4fECaqgulNRw==
X-Google-Smtp-Source: AGHT+IEFJq9u4lnY69F7QM85yGJruRY+OmGFFNB6AWDGx6Jw6oSZsPRLxoQNbQVi5ZSmT1akry6BtEnPevfW9zGxYF4=
X-Received: by 2002:a50:9e87:0:b0:5dc:5ae8:7e1 with SMTP id
 4fb4d7f45d1cf-5f085193f63mr64182a12.6.1743665384027; Thu, 03 Apr 2025
 00:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402010146.898864-1-inseob@google.com> <CAP+JOzS-ickvHYEPokm3oTSqyEbJrbhZseHPR5N1Oda2po1btw@mail.gmail.com>
In-Reply-To: <CAP+JOzS-ickvHYEPokm3oTSqyEbJrbhZseHPR5N1Oda2po1btw@mail.gmail.com>
From: Inseob Kim <inseob@google.com>
Date: Thu, 3 Apr 2025 16:29:31 +0900
X-Gm-Features: AQ5f1JoJKVJSr4vdjBgJXEJFpe1IRgTNn92DiWO1RZYyGgEWyQKa98kdNgvPcgw
Message-ID: <CA+QFDKn6JdzWX8ROiLmtAM-VnGZC0Mizttj6rXQ3otbjF9i=2Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] libsepol: Print line markers also for allow rules
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 4:43=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Apr 1, 2025 at 9:04=E2=80=AFPM Inseob Kim <inseob@google.com> wro=
te:
> >
> > Currently, only line markers for neverallow rules are printed. This
> > makes people difficult to debug a neverallow failure with cil files
> > generated by checkpolicy.
> >
> > This change additionally prints line markers for allow and allowxperm
> > statements to make debugging easier.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
> > ---
> >  libsepol/src/module_to_cil.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index ae9a2b5d..76fe4739 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1196,7 +1196,7 @@ static int avrule_list_to_cil(int indent, struct =
policydb *pdb, struct avrule *a
> >         struct type_set *ts;
> >
> >         for (avrule =3D avrule_list; avrule !=3D NULL; avrule =3D avrul=
e->next) {
> > -               if ((avrule->specified & (AVRULE_NEVERALLOW|AVRULE_XPER=
MS_NEVERALLOW)) &&
> > +               if ((avrule->specified & (AVRULE_ALLOWED|AVRULE_XPERMS_=
ALLOWED|AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
> >                     avrule->source_filename) {
> >                         cil_println(0, ";;* lmx %lu %s\n",avrule->sourc=
e_line, avrule->source_filename);
> >                 }
>
> The problem is that currently line marks (which are converted to
> <src_info> rules when parsed) cannot be in booleanif statements, but
> allow rules can be, so this can create cil files that will not
> compile.
> I suspect that that restriction was not intentional and can be
> relaxed, but I don't remember.

I tried supporting markers within booleanif statements and it seems to
work with my tiny test.

PoC patch:

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 3d920182..90745110 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2121,6 +2121,7 @@ static int __cil_cond_to_policydb_helper(struct
cil_tree_node *node, __attribute
                break;
        case CIL_CALL:
        case CIL_TUNABLEIF:
+       case CIL_SRC_INFO:
                break;
        default:
                cil_tree_log(node, CIL_ERR, "Invalid statement within
booleanif");
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_=
ast.c
index 19fbb04e..619cd894 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6158,6 +6158,7 @@ static int check_for_illegal_statement(struct
cil_tree_node *parse_current, stru
                        parse_current->data !=3D CIL_KEY_AUDITALLOW &&
                        parse_current->data !=3D CIL_KEY_TYPETRANSITION &&
                        parse_current->data !=3D CIL_KEY_TYPECHANGE &&
+                       parse_current->data !=3D CIL_KEY_SRC_INFO &&
                        parse_current->data !=3D CIL_KEY_TYPEMEMBER) {
                        if (((struct
cil_booleanif*)args->boolif->data)->preserved_tunable) {
                                cil_tree_log(parse_current, CIL_ERR,
"%s is not allowed in tunableif being treated as a booleanif", (char
*)parse_current->data);
diff --git a/libsepol/cil/src/cil_resolve_ast.c
b/libsepol/cil/src/cil_resolve_ast.c
index da8863c4..d0d53b1d 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3848,7 +3848,8 @@ static int __cil_resolve_ast_node_helper(struct
cil_tree_node *node, uint32_t *f
                        node->flavor !=3D CIL_CONDBLOCK &&
                        node->flavor !=3D CIL_AVRULE &&
                        node->flavor !=3D CIL_TYPE_RULE &&
-                       node->flavor !=3D CIL_NAMETYPETRANSITION) {
+                       node->flavor !=3D CIL_NAMETYPETRANSITION &&
+                       node->flavor !=3D CIL_SRC_INFO) {
                        rc =3D SEPOL_ERR;
                } else if (node->flavor =3D=3D CIL_AVRULE) {
                        struct cil_avrule *rule =3D node->data;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 9621a247..0b740c85 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1175,6 +1175,9 @@ static int __cil_verify_booleanif_helper(struct
cil_tree_node *node, __attribute
                   booleanif statements if they don't have "*" as the file.=
 We
                   can't check that here. Or at least we won't right now. *=
/
                break;
+       case CIL_SRC_INFO:
+               //Fall through
+               break;
        default: {
                const char * flavor =3D cil_node_to_string(node);
                if (bif->preserved_tunable) {

Snippet of test cil:

(boolean foobarbaz true)
(booleanif foobarbaz (true

;;* lmx 999 system/sepolicy/private/booleanif.te
(allow domain system_file (file (open)))
;;* lme

))

secilc neverallow check output:

neverallow check failed at plat_sepolicy.cil:15155 from
system/sepolicy/private/domain.te:1237
  (neverallow base_typeattr_430 base_typeattr_438 (...))
    <root>
    booleanif at plat_sepolicy.cil:9105
    true at plat_sepolicy.cil:9105
    allow at plat_sepolicy.cil:9108 from
system/sepolicy/private/booleanif.te:999
      (allow domain system_file (file (open)))

I'll apply this in my next patchset. What do you think?

>
> The other issue is that this will produce a lot of line marks for any
> real policy. A lot of line marks. It would be nice if this behavior
> could be made optional.

Ack, working on it.

>
> Jim
>
>
> > @@ -1264,7 +1264,7 @@ static int avrule_list_to_cil(int indent, struct =
policydb *pdb, struct avrule *a
> >                 names_destroy(&snames, &num_snames);
> >                 names_destroy(&tnames, &num_tnames);
> >
> > -               if ((avrule->specified & (AVRULE_NEVERALLOW|AVRULE_XPER=
MS_NEVERALLOW)) &&
> > +               if ((avrule->specified & (AVRULE_ALLOWED|AVRULE_XPERMS_=
ALLOWED|AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
> >                     avrule->source_filename) {
> >                         cil_println(0, ";;* lme\n");
> >                 }
> > --
> > 2.49.0.rc1.451.g8f38331e32-goog
> >
> >



--
Inseob Kim | Software Engineer | inseob@google.com
