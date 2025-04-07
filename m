Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628B14AA9
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992560; cv=none; b=elGfzhSBpdozCCV3eslIF9Yz5xp56kKznyXqRV8sN1/1WAbzH0q1svN8kTyFiiPRMAvNgnT0vTZ4dwT4U9zDqkRkCuAmv51vPAbuTGhmlkaOOrST+pef/eoHMfXVFlNVh+oSrLNwREPIS7oyS52+GhhaaFZFsKEPXA76U5omFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992560; c=relaxed/simple;
	bh=tSHT8KUoLeUlLFSPiQ0g4hJWFP0EQ/MvlaLbLj8R5Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt+epd53m1V/n3nMPHtXfkK9Jcgo0fG2Kq5wFFnyoS501Uri36TmRR+mCxG0Q+7IS6MJ5hBYwHtMWyjA78jePv+L2ov3qNoYM/a3yzpzG+/h3x3cCAs59sck+fEQGWoXvIlG3PMp6T93VZSTmhzqYYKXENsMwmkhdgMkWrT4lkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ynv2FtNt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ynv2FtNt"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso7203a12.1
        for <selinux@vger.kernel.org>; Sun, 06 Apr 2025 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743992556; x=1744597356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBYRXc8fqDldEJH9k0jmE4L1SaxupPWSPUICn+VS07o=;
        b=Ynv2FtNtG98lcBOQjnDYAobJ8/bCK3yY5QNgGty0ze9vdTwrwO92GZlrGyTD+LRTyO
         2ApffjHUO65OWM4d0f3l87aAazLJLCVtrZvAOGF0R5G9yYD/SSrg3mpH9Xl6MV2OS+NJ
         i4JtY8mKla1+9/a3mkgsmHfFRvrHTmal8YUQV8c4eb8LZTeMvuShZHOe8wusfqzVKSy5
         29JD8wZKSDlIoLrE3pVyWbfo7jtxCWdIkHg+12U/xV54/Xf3WVBKtr7oU23/A0C4aLPZ
         DXk8lCMmYLajTi6BechFlbj62hwgghSMNCmtUNtTk8cQRCNeL0hqQg9xJ+kN9UM9JOqT
         LWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743992556; x=1744597356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBYRXc8fqDldEJH9k0jmE4L1SaxupPWSPUICn+VS07o=;
        b=t9xfhLL0Qril1ymeQ5CWLBBe6wzFbNC/PWGCCeg3NIahl/A1LtljlYjDLWml9L0CzR
         o+rPCUWjDReNocEMMKrrbiUmm3Rsxi78xf2ztoIjPjRWKnEuONky0v+m1lLHQ8CpT/6n
         nHTUn4C4WY5HovuV6ueO5XsJLZR5rLy6EGta9uINIF+R142Q44dwIPaLTDTA6HPQlXuG
         W5PtOf8dyJdqBxQeCbGWkmzS6qyduoNZvSIeInWtSddYudUdtIr4jUgn3nP3eB3yPRsQ
         YNhsH9YAGgGCXRjSPxQoBpitju4vFJ0ttRWAowpf9XNSSz8lKU6ZKlXjRc99rkjk4OXf
         ybYw==
X-Gm-Message-State: AOJu0YzkNGUrxZhoIiF1364vmS1TUKnPwD/p0nNfP3TE4RlTuNeCkYyi
	8H+yNo49Axu3XLmQM9jDWpzh5b8Oo3OnI3FkdyDfDW+XtIB53BiPLmn7arvIOOfgyxBmWM+/M4C
	lzbDwr62J0SuNAMcoulMXas+wOu3RDhlX+eWAu+EoDNp00+Io+E+c
X-Gm-Gg: ASbGnctg2vdf7sNYToagRLIoZ09GIumAOQgq77ptknEzU2xqoIkKag2EWcTmoKqdj9d
	HLLxPAawK80GdR9wfkqO2sUMcbtWQy+BOt8EF1JmzcqjhwJcoGqyLUQpQydChHkYLADcRIu6SyZ
	rHQ0d10m2eTnfBOUkOuI7BblHEhdOs2T97OQ2mNn64b2NAs00mkvR80A==
X-Google-Smtp-Source: AGHT+IE3YzAEMO47meooa6WCRm+Xecj6glyqSdR+7SC4QgDMlg9Od1fcK5xhyvkxdIAjXqBGyDs62vG4E1X8xsfiQ5w=
X-Received: by 2002:aa7:c2cb:0:b0:5e4:9ee2:afe1 with SMTP id
 4fb4d7f45d1cf-5f0db8a2f79mr93337a12.2.1743992556034; Sun, 06 Apr 2025
 19:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402010058.898417-1-inseob@google.com> <CAP+JOzQ5gvMrFhh65GQPFOQNH5-PHTZwC53MyRf5TAd6tFapkA@mail.gmail.com>
In-Reply-To: <CAP+JOzQ5gvMrFhh65GQPFOQNH5-PHTZwC53MyRf5TAd6tFapkA@mail.gmail.com>
From: Inseob Kim <inseob@google.com>
Date: Mon, 7 Apr 2025 11:22:24 +0900
X-Gm-Features: ATxdqUH5bij9eRRXpjQj3f-hkTApHrSj_Eb14P3ncK4JFQXnAqM8iQV8SI_p9ZE
Message-ID: <CA+QFDKnmv4tE3hAx6sepL9SuMc=4F1RJVOQ6iJ8mMuMszBE_9w@mail.gmail.com>
Subject: Re: [PATCH RESEND] libsepol: Print info nodes at the first child
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 4:26=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Apr 1, 2025 at 9:01=E2=80=AFPM Inseob Kim <inseob@google.com> wro=
te:
> >
> > cil_write_src_info_node has been called with
> > __write_cil_ast_node_helper, but that may break the result CIL file in
> > case there are no children for the info node, because the "lme" marker
> > is printed with __write_cil_ast_last_child_helper.
> >
> > This change moves the cil_write_src_info_node call to
> > __write_cil_ast_first_child_helper, so opening markers and closing
> > markers always match.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
> > ---
> >  libsepol/cil/src/cil_write_ast.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_wr=
ite_ast.c
> > index 15d8bbaf..7f41387f 100644
> > --- a/libsepol/cil/src/cil_write_ast.c
> > +++ b/libsepol/cil/src/cil_write_ast.c
> > @@ -1623,7 +1623,6 @@ static int __write_cil_ast_node_helper(struct cil=
_tree_node *node, uint32_t *fin
> >         struct cil_write_ast_args *args =3D extra_args;
> >
> >         if (node->flavor =3D=3D CIL_SRC_INFO) {
> > -               cil_write_src_info_node(args->out, node);
> >                 return SEPOL_OK;
> >         }
> >
> > @@ -1643,6 +1642,10 @@ static int __write_cil_ast_first_child_helper(st=
ruct cil_tree_node *node, void *
> >         struct cil_write_ast_args *args =3D extra_args;
> >         struct cil_tree_node *parent =3D node->parent;
> >
> > +       if (parent->flavor =3D=3D CIL_SRC_INFO) {
> > +               cil_write_src_info_node(args->out, parent);
> > +       }
> > +
>
> This is not going to work quite right.
>
> if, for example, you have two cil policy files. One with a minimum
> policy and the other with just a comment, then it will currently not
> write the "lme" marker as you note, but with your patch, it will not
> write either the "lms" marker or the "lme" marker.

Actually this is what I wanted, because I thought such "lms" markers
are redundant. But thinking again, it's not necessarily redundant
because it anyway has information about included source files, so...

>
> I think that what you need to do is to instead of removing the
> ci_write_src_info_node() call in __write_cil_ast_node_helper(), you
> should add a check to see if cl_head is NULL and write out the "lme"
> marker if it is.

... this looks fair enough, let me send another patch.

>
> Thanks,
> Jim
>
>
> >         if (parent->flavor !=3D CIL_SRC_INFO && parent->flavor !=3D CIL=
_ROOT) {
> >                 args->depth++;
> >         }
> > --
> > 2.49.0.rc1.451.g8f38331e32-goog
> >
> >



--=20
Inseob Kim | Software Engineer | inseob@google.com
