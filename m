Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv5CujQP"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EDA8
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:45:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso3348691e87.2
        for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 08:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702399556; x=1703004356; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGxgE94VZGor4PxXE1SIXC+UHLFW7bJXIEtyE56PEgA=;
        b=Vv5CujQPOB2Qf2rYolqU1fypgjvb5S5R6gT2Oc1GVfQxw5X+Wv17xJDpdvjuIVznMa
         /RyghySJltruXikxDkdJkTVOleq6hdxfeSUDtJYbW1i012BKyl+fbD1a7cJMJwHXLCCz
         Pyr53W9djBwMpjeeEQ44A/n6FOVWKkVGeoJafdzfX/cYmeCKo7vQeamHQ7njtYWKUuP1
         1hu8fvilKY+GSwe0qc3Hb6Y9K8u62wNudAEKllm1aCOeKkGAchbIckFFktkl+IeTyzdM
         ksemds666SepC8p05MwhaGIy7KM50AhzPpVAOhwLyuseWzzRoCNLJj/WRsR0ZczlWXUN
         Rk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399556; x=1703004356;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGxgE94VZGor4PxXE1SIXC+UHLFW7bJXIEtyE56PEgA=;
        b=fLnXZj+FfgM5Cq1cqJMDPO0GmcdBMmEUk2Mq8ETLvP47o5Vi1NIhO44c7Avorb8+yr
         VprlXoMev7CPd+YrhzL9JQjp6Oc7Kl+EYY8GK0IJUeWG8La/XB0CeO3CXJkChyDNND+P
         N+bvaUbMId92iYTcUC5sRSxJ8PcPYNVrctTKJgYH3WTz5+01l6OvTIS6Z0M2GWpSvjQo
         qybbTmy+Ww5so9uKlcsY0QR/oVIm/i7UydvbHl9OJHpbIfB1JiBr0W7CFM+u6fw4eCQ8
         egP1U/lvWQ7IDIh9UQRRinc1gUBNqM0VSz+00uUZccviqRZLYp07iZPq/FtVXpipLIlt
         y1iA==
X-Gm-Message-State: AOJu0Yx1fS4Es6mi3JjZyrbiDl0moWhPYtSeW8N13aQKN/B/CqN2O+R4
	EATN3qCZU4D1v4cqnx/BOkk66bOXhVJc1SBYYuc+jyY7
X-Google-Smtp-Source: AGHT+IGyW1F0kWkOOTq6d8S0RN57LjMBn65cMWuJy/3IKkCF+iQB3x0qJPmMXLBklnyrv5wMeHB+hMJQ8CJSSzpqks8=
X-Received: by 2002:a05:6512:2098:b0:50b:f2e0:4997 with SMTP id
 t24-20020a056512209800b0050bf2e04997mr2865019lfr.103.1702399555826; Tue, 12
 Dec 2023 08:45:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129174246.188157-1-jwcart2@gmail.com> <CAP+JOzSvpCNHPJm7Jg1xpVwiTmynddHS+k+FybVO8ywTo+cD+Q@mail.gmail.com>
In-Reply-To: <CAP+JOzSvpCNHPJm7Jg1xpVwiTmynddHS+k+FybVO8ywTo+cD+Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 Dec 2023 11:45:44 -0500
Message-ID: <CAP+JOzSf6KS5zUQr2HQuaQ1o+0j=w6WickmPUWEYf5JqZR=kcw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Clear AST node after destroying bad filecon rule
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:11=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Nov 29, 2023 at 12:42=E2=80=AFPM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > Commit fb0a4ce1 (libsepol/cil: Allow paths in filecon rules to be
> > passed as arguments) changed when the new AST node data would be set
> > to point to the new filecon struct when creating a filecon rule.
> > This causes cil_destroy_filecon() to be called twice on the filecon
> > struct if there is an error when creating the filecon rule.
> >
> > If there is an error when creating a filecon rule, call
> > cil_clear_node() after destroying the filecon struct.
> >
> > Reported-by: oss-fuzz (issue 64385)
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> I plan on merging this patch soon, unless there are any objections.
> Jim
>
This has been merged.
Jim

> > ---
> >  libsepol/cil/src/cil_build_ast.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index be260a31..56dac891 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -4197,6 +4197,7 @@ int cil_gen_filecon(struct cil_db *db, struct cil=
_tree_node *parse_current, stru
> >  exit:
> >         cil_tree_log(parse_current, CIL_ERR, "Bad filecon declaration")=
;
> >         cil_destroy_filecon(filecon);
> > +       cil_clear_node(ast_node);
> >         return rc;
> >  }
> >
> > --
> > 2.43.0
> >
