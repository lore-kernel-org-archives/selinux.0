Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7973D564D
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685649; cv=pass; b=HGnVsLBx1bM20/94GfzONf4qXx2e0QIPdfGQ3CjFIs0D1oGLb4bidi8BPqFRXBX4V1klrm92NRRmzY51h1h3MFE52kr8fXj1XMH1oN3slF8KG5C0yYFt96Z/nCFF9P3R2VBdvJmGsG0+QkYxkPqvPpFe/0nTTOLfMrqH2dD8bgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685649; c=relaxed/simple;
	bh=96QLNpS+eSgrau2dZNQcKZ0MedEUdoTUr50c1iGNq5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAvU+7ykwDSvdU6mMX6KZD9lpNcc8v/WUfk/3earuckHifa73/XMk2MFYMJmyCK8YexSLnmpt9GRTcEiXfv2SMjFo+S6UhLKtyE+EsLV04/IphKOAH+Grcrms8I/j3W32Bps2/jfOuB1GqmVV3X4MFUYOEztlfO1HVe3NIOxco4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oT/aNoxF; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oT/aNoxF"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3967726bc47so21929371fa.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 11:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780685646; cv=none;
        d=google.com; s=arc-20240605;
        b=H/ckhzkSSGRoEHl5QEeJOs+3gpeIqJhdbo7QQk1g8AYbk+eKL3j/qwc3CosoH2UUoP
         vmuryivLOalLfxNrPBciLzdFq9CN1ePa9UPFQXOZh9fpONXOfxLxltVlHzI02IPk4FXj
         YiMCAsLlCW1LSYpkXLqE8CiKDV3BV5b4Ay3b5T7EdoB5jZAtqzABNb3XwOzBmwDD/pJV
         KB3FdHWwFc0ymD9MlZGRzUkAMfqPJRcoBsDB+H5w5mAp785hIADwBT+e7yeDHoDMAmJd
         Y8M65AgH+h1mDTOFQmu5fARnkGh0g/r5jTUjndlrJpSlk/CTsm5U0EZnHMMo0uMBDJs9
         C8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q2Q46xX96/vK+Iq5ZsnVNgAGsmsohlDEOIqIZCqFm8Y=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=f4cMQb8voJzPHWkllwM46TletudAXGRBTAu7lWt/pzrZGGue429OggX2Ry2ON0t3RJ
         371haWSktxhyBENoV08fkq+0scwxxbL7J3lOQK2hXJiksAF1IOxo5i9jmusKWDLrdxgN
         jq/SBvpnmUuwnLQAGVXjsSbZUwYhNmKjJ6R9hXGrCYc2NhyjMm+l7lBvkekPkleAl6oM
         /ZkBU1xw1vR1NQCxAGGgnAciU1QXK2wfvSmmyRSmUZlQwr8XGUFJNNLrPnNoGRMADWdH
         a1hTRWHA4Z/ioKVIGC1W2p75ArTSbl1CT6ntU6Vx7GPuez3LMSwmgSMb5Ouw0EgBP3kv
         ukBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685646; x=1781290446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2Q46xX96/vK+Iq5ZsnVNgAGsmsohlDEOIqIZCqFm8Y=;
        b=oT/aNoxFwkOEWmC7JpQSOK30bsxKW7hlqOf5lU2SQPfNxXO8u5UJ7wkCDO8l1d587i
         +wr4F2Mq0NuRcgvhhnWy+p4LNB6JLmcQjMSRumEUM5aT2T7aGxi5XkX8HerXjGwl6BnP
         eLegaTeLsEc4LCha2eN0os2dy8Ww5k6v1gLXqnLGBGr91ArcFIEhreUoazssmPB9mF5X
         UEO5xtWFQna1Bn7tPnUBxocf3XZ+GdQ6xzYZR+0uKkUdLSRo++v7DNeefutTF81TA0oc
         VmF0zfoeTYuna1QeLkIJvIKX+0jv1CPbY2ZKse2W4Khes9FFUepKORTBkB22o8UQQfzi
         8NsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685646; x=1781290446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q2Q46xX96/vK+Iq5ZsnVNgAGsmsohlDEOIqIZCqFm8Y=;
        b=X2KaSHpkwQn4U2AWooqBQnt49pZ3sXAqzaILhpLgjmCj+AIz7jZXlerDsq3X+U+psJ
         lptInqoqxLaROjeRMbkkYyFnl53/x9h4PpiHPFks/Eyawq6HfzAePWV9N9p4WRxy/BYv
         xkTn00lDxKkPVtA4bC1KWZ98kjJrs7di/IJFsb07ynQqOk9iUCEcEFOlPTNSY/vhwRiN
         D471BU/BPlBionLocrNUyySQDWz4fXoXZnixSGkzEYK8GIO4aZ34SFtxT3Rgd49pPQsH
         L54u/tSt2UIO8wusWrbOyzp5WrTPyUGRvsfGaA3ZUCQoN0MVD4VTw5DA29o8PNyO2HZi
         y6yA==
X-Gm-Message-State: AOJu0YytJ8fjrzMP0ZxBx4RyZqgWCKM3aFCgdjlZTe59WyoT6rlD/ab3
	mCvKgvj9AZvoJzLo7XrkTeaoW4xw3zOsXkgThZ+tZUGGz6SQvQicNm3JD64+25KKID8+34KwGDT
	m7J+Aq7wuTgUr43FwzT66tWlpPmQw21s=
X-Gm-Gg: Acq92OHlR4PaAgq1Z1XiDgYJgi71vhvN9bT+3q85r02ttUBjELn5ArdhZHI1Z7z6BHv
	IXPh5D+d7Qlr9LuIm+hOYBumpJbcMBEkcFaQlS1zJTV9+Vjxx4zkYtxlQ34wlfiMecOtiIQMGLr
	LY/faMPZi4O2bVjRt5jccNJLwYz+2koNPrdim73c8ouP/piOZ687VgnyS8j+JTaPaSVZrlxp3HM
	HeqpU67iO3cyxpxWyJYo/9RTJ0sygXbRB62wK0469EEitpFkNME6/aq4fsTamNB7ZIhMKz6m77C
	o55YiScmQCVFusM=
X-Received: by 2002:a05:651c:144a:b0:38e:9ece:61e9 with SMTP id
 38308e7fff4ca-396d0a8d574mr15096361fa.25.1780685646109; Fri, 05 Jun 2026
 11:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531184111.691569-2-nvraxn@posteo.uk> <CAP+JOzR4feRbvZn7E_YyPypAHZ9r_gJEOo+pENAGJE5oXofBTQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR4feRbvZn7E_YyPypAHZ9r_gJEOo+pENAGJE5oXofBTQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 5 Jun 2026 14:53:54 -0400
X-Gm-Features: AVVi8CfZeP8yGQVigxk_JslTFPg9Gytz5po6QkFBwhwWdp18t79G0DAY--OKZvA
Message-ID: <CAP+JOzQqJ95dAvyFc0s6Krx=LBm5_pB6A+mF5=0MS58HH3_4fQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cil_resolve_ast: add in a CIL_SRC_INFO for the
 copied data
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 2:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Sun, May 31, 2026 at 2:41=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> w=
rote:
> >
> > Ownership of the data copied in from an in statement currently resolves
> > up to the parent block. This is because when looking up a corrosponding
> > path with cil_tree_get_cil_path(), the chain is walked up until a valid
> > match is found from cil_tree_get_next_path(). However, as the content
> > that is inserted into the block does not originate from the same file
> > as the file where the block is instantiated, insert a CIL_SRC_INFO node
> > so that for said content it is a src_info node with the original file
> > attached that is matched.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
>
> Unsurprisingly, the patch did not apply cleanly after the giant
> reformatting, but it was simple enough to make it work.
> I will handle the merge for this patch.
> At any rate:
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

And it has been merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_=
resolve_ast.c
> > index 048b3aaa..af612f63 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -2375,6 +2375,8 @@ int cil_resolve_in(struct cil_tree_node *current,=
 struct cil_db *db)
> >         struct cil_in *in =3D current->data;
> >         struct cil_symtab_datum *block_datum =3D NULL;
> >         struct cil_tree_node *block_node =3D NULL;
> > +       struct cil_tree_node *src_node =3D NULL;
> > +       struct cil_src_info *info =3D NULL;
> >         int rc =3D SEPOL_ERR;
> >
> >         rc =3D cil_resolve_name(current, in->block_str, CIL_SYM_BLOCKS,=
 db, &block_datum);
> > @@ -2395,6 +2397,27 @@ int cil_resolve_in(struct cil_tree_node *current=
, struct cil_db *db)
> >                 }
> >         }
> >
> > +       char *path =3D cil_tree_get_cil_path(current);
> > +       if (path !=3D NULL) {
> > +               cil_src_info_init(&info);
> > +               info->kind =3D CIL_KEY_SRC_CIL;
> > +               info->path =3D path;
> > +
> > +               cil_tree_node_init(&src_node);
> > +               src_node->parent =3D block_node;
> > +               src_node->flavor =3D CIL_SRC_INFO;
> > +               src_node->data =3D info;
> > +
> > +               if (block_node->cl_head =3D=3D NULL) {
> > +                       block_node->cl_head =3D src_node;
> > +               } else {
> > +                       block_node->cl_tail->next =3D src_node;
> > +               }
> > +               block_node->cl_tail =3D src_node;
> > +
> > +               block_node =3D src_node;
> > +       }
> > +
> >         rc =3D cil_copy_ast(db, current, block_node);
> >         if (rc !=3D SEPOL_OK) {
> >                 cil_tree_log(current, CIL_ERR, "Failed to copy in-state=
ment");
> > --
> > 2.54.0
> >
