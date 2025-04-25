Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32491922D3
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601955; cv=none; b=PSLQq5kgxKSCZUY/5dpLqwGEgQKCSNBONXps6Aef2b6E+gcJBE8M0UVso4C2+wbd+RuK2prWpqHVcH6xOdT7Wo9msQnX7/H3SNDka8suavkAXPeDsp9ZfskLtRxJjHxNMZtLNXiIFB3qwJ+oD726RPNH1dIWkGdJGGf99nK5TmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601955; c=relaxed/simple;
	bh=gGhzBroK6s2vkKkmlSNiMAmHp8FAIAUr35F0w4M+oL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJghCP2ofF2olcj+UiKoynGYeZ+/fwBVaZuepX3IfcOvcbCm/qpVCP4+8MeJLWGMcQHV7859ks8f3X8ic0QFJmqpNy5D97SdTe82GWyIoSPhMmv1WYp16/pvxl3q1mVVdLfCdMTylYD63/nD0hcVEgmKXPxnGgEAhkkJfimMkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlVgaCtb; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlVgaCtb"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-877c497dc23so55618241.2
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745601953; x=1746206753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fNRJto5FwOTT5usSK5436hUhDLMkI6qyW7axOlHDoY=;
        b=jlVgaCtbwCDHVCE24Zc+vPgkPIuSBnyhrnaU4rT3ZuzQ6MmDKzeGtwYJYOmMfI1UDi
         OkJFmG1wdgbzI4EvgaHJQAY/pQogZnwSVkJRaXS8dsFt2YNLPqzg19fL8nY5SPahT/mh
         8Snr031T0Xouk0ORa/rkpiqe3e+4prafWEbFJWlUQKRCjZNhkRJ7stajvnq71PhqYgyY
         ouYMZ7R+CW/3aeUY+nqceU8QsDHvOewlB4kNpUO81JJCPMvLkqWbfIwAooThBJRnh4Cm
         xlT+fVgLED2oMUOqgPoIC/OFWm5/DpZm/6+Ad+xVtYNfm72b/A1DCgFg2wuNNxiW66fG
         1efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745601953; x=1746206753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fNRJto5FwOTT5usSK5436hUhDLMkI6qyW7axOlHDoY=;
        b=TE5TGeb6NAJJpNh/07hr3FwI5F5ru4KDSAMsqS9k20AW1ahDDpNeIwgo2RCvdGIzs+
         G30aTwrq9gNcAFLCydhha+aa2KQYRBCbMbc9Ww/O2ZYZ/xHtWK0rgzAclsSXGGMjtdtD
         JZ0PH3yq8UwhdBNd5u1ez1JshWy7tyQjAnIucERntkPSk2ZP3ChjYOhon/xokuEKDzvK
         DyKQnRwMPumgv5o9k2DWLutEHYEvj+TMsbDLYBIZtzahz2da4LDK9eAEGme04Xn87Y9x
         p6dz679ly82/AUooBtMd2qQAolKot29EQEYaPfBrtZL/8Uz8PRZEQX+oc6K/l/bGQKAk
         at8Q==
X-Gm-Message-State: AOJu0Yza9WsUYJ1h4lGuKtQeXUNbQ3ggHaBt6ysig51Nn9JHzv5gqc9B
	qhYqeqbSx31qkee1pm74Yegflkt2k58NKFqxhkhKEjqajvk0i72kH18y09OfCMywokKJVGbAIuw
	vxRIp3HmEC/q80PhAYlM74fYPJuTdHQ==
X-Gm-Gg: ASbGncus/2P4EWqjo+K4CAIRt/JOEzvboTHoJu1Eadp+/fw20l3seUeXYulMHuAnfLA
	jETQv2nINfiQiI33oroLmLZWRB/vl4txe2ZfU6Bm3VnimJ4BPyD5VPGB2R69GdatYiPdD30ywC1
	a2xMlYZ35w6IpVYYYvgqLWlxw9kycj0w==
X-Google-Smtp-Source: AGHT+IGmxq0gHjsUWCGtQrFZnFXfm75WpiOdYG1CYamecfxopLeUJiNLPJzZdwTko1Jskc3GY/gLr5T5oktr+Ab0Edg=
X-Received: by 2002:a05:6102:4688:b0:4c6:d008:7349 with SMTP id
 ada2fe7eead31-4d54574b608mr1779821137.21.1745601952546; Fri, 25 Apr 2025
 10:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411010549.1688614-1-inseob@google.com> <CAP+JOzQ2aPJjodpMTHdtoY0N-fUCyAV8Rt5NA8tu1mNLadJUCQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQ2aPJjodpMTHdtoY0N-fUCyAV8Rt5NA8tu1mNLadJUCQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 25 Apr 2025 13:25:41 -0400
X-Gm-Features: ATxdqUHPRh2W3RBDFqgcRG_wJ6sgLOaT2ke4rkk8Qw0FReVwq8XO6sQMRns0ymA
Message-ID: <CAP+JOzRrk_YRBodoUwPL_CuuMgSMfMKefjmoZzvt8+Ge4a7khQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] libsepol: Allow booleanif to have info nodes
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 1:15=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Apr 10, 2025 at 9:06=E2=80=AFPM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > Allowing more info nodes helps debuggability, especially neverallow
> > failure reports.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_binary.c      | 1 +
> >  libsepol/cil/src/cil_build_ast.c   | 1 +
> >  libsepol/cil/src/cil_resolve_ast.c | 1 +
> >  libsepol/cil/src/cil_verify.c      | 3 +++
> >  4 files changed, 6 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index e84188a0..b0befda3 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -2153,6 +2153,7 @@ static int __cil_cond_to_policydb_helper(struct c=
il_tree_node *node, __attribute
> >
> >         case CIL_CALL:
> >         case CIL_TUNABLEIF:
> > +       case CIL_SRC_INFO:
> >                 break;
> >         default:
> >                 cil_tree_log(node, CIL_ERR, "Invalid statement within b=
ooleanif");
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index 072d2622..fc11758d 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -6164,6 +6164,7 @@ static int check_for_illegal_statement(struct cil=
_tree_node *parse_current, stru
> >                         parse_current->data !=3D CIL_KEY_AUDITALLOW &&
> >                         parse_current->data !=3D CIL_KEY_TYPETRANSITION=
 &&
> >                         parse_current->data !=3D CIL_KEY_TYPECHANGE &&
> > +                       parse_current->data !=3D CIL_KEY_SRC_INFO &&
> >                         parse_current->data !=3D CIL_KEY_TYPEMEMBER &&
> >                         ((args->db->policy_version < POLICYDB_VERSION_C=
OND_XPERMS) ||
> >                           (parse_current->data !=3D CIL_KEY_ALLOWX &&
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_=
resolve_ast.c
> > index a8fa89df..392f03c7 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -3849,6 +3849,7 @@ static int __cil_resolve_ast_node_helper(struct c=
il_tree_node *node, uint32_t *f
> >                         node->flavor !=3D CIL_AVRULE &&
> >                         node->flavor !=3D CIL_TYPE_RULE &&
> >                         node->flavor !=3D CIL_NAMETYPETRANSITION &&
> > +                       node->flavor !=3D CIL_SRC_INFO &&
> >                         ((args->db->policy_version < POLICYDB_VERSION_C=
OND_XPERMS) ||
> >                          (node->flavor !=3D CIL_AVRULEX))) {
> >                         rc =3D SEPOL_ERR;
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verif=
y.c
> > index 550b4542..cde9dd41 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -1176,6 +1176,9 @@ static int __cil_verify_booleanif_helper(struct c=
il_tree_node *node, __attribute
> >                    booleanif statements if they don't have "*" as the f=
ile. We
> >                    can't check that here. Or at least we won't right no=
w. */
> >                 break;
> > +       case CIL_SRC_INFO:
> > +               //Fall through
> > +               break;
> >         default: {
> >                 const char * flavor =3D cil_node_to_string(node);
> >                 if (bif->preserved_tunable) {
> > --
> > 2.49.0.604.gff1f9ca942-goog
> >
> >
