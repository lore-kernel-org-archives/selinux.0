Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF27521B9D8
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743794810; cv=none; b=EjYGoJiZVSP5sIKPp1LU9jHb92wZcEBkJpSFH/CI97OhvfPpcNu9OnG3XIvHvDUnhn6EC9BMSp7Ml7nlHJPfybV8VVIi4i2DyF45a8evfYsojjRWv8gD7C+LoL7SXBKmEMecWcV0coN35kSjToA1qYwEGXh9iKVU6Bb4bkEy6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743794810; c=relaxed/simple;
	bh=UDUS9WsOjgm05AeDi1SP/VeFgV7eRn7tV11PJRZBc+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzQskC+Q9GhjrlnKKNbc6lbLr9xzatXpeHPMgHQyVvlDkwxIsv56WONrvvK5o68X4e4LjKt+14c32zLWTzrOap7HXK3ulPoRKh6oKA36VPlJVMcKJmdRYkkHmqwcVlkyur7VAM+Z9m1zArEN/ToqXGFsOqV8kEqq2KP22EEIku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHxPLVGE; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHxPLVGE"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86d6ac4d5a9so1201913241.1
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743794804; x=1744399604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozn60NYqT7qK5Fx6TUjkDMJmNaNM/I4iFjj8wrIFnPw=;
        b=KHxPLVGEfIahTDv0dtMxthmj8Q5JEMyFC88R3QzYa66yHQNHUWteqzK1ZlnBXIZ2+L
         ZcjX/8dylFAyMrIZPJ1Xyv+VJ3ArSSaxesf/Tav/Cram+p+Hexule46r2hK/Xq333OVd
         DemhmJWt4DTJFGLU6WfadAzsDLwACasV6Db7kOwsN+7bVjVOY1SJm3Sov/eACku1d6jA
         mc7VSrfj6ANl6kvdILMTSersIWqSz9F+YkDRm4P94zGeUq1eDBI/sa2I9DsfviHsaZuh
         g5kJJgVFbodUzpoy1nCvpKNyOWMmBjGqMXysmQOSMc/NpZtiEL80M1n2ucN7lCZA4255
         Fhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743794804; x=1744399604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozn60NYqT7qK5Fx6TUjkDMJmNaNM/I4iFjj8wrIFnPw=;
        b=fVoTHlBXhWseD0a3g3jRK4Vxk8y0mFRDyAxPh6/2XuYmBPn/QiG1Tso5h+nrqFRt1M
         lF6piBDbsx1qlsDGgTPyoxwJX3blApvhj2+rVSuCDsAn+II8kV3TBYKXjMl9eWqbPzGb
         BRUUWofdX677esMpJmW9UrLXqVxxqFwop3FKJ8KvjZEWQ8g7jEi+RgbOWGUT6GU5VOz1
         oy+vOOT3YV9K5EoViCkvV3mKxyHvb6695VTo5RN2KY37/m7JieDxIiw6INWI/URHLnZg
         aRXUgCTjC4PnDWyLLvZUe1/lYHd2NDpqtUUvXM3YcSCZa89krpQv5wIuWvISEnAjp0JB
         wiPw==
X-Gm-Message-State: AOJu0YxYImA/pKjwCpZwRKFTBHLll7CxhBgeJim8tiW4l9qpkDa9t41e
	WUNHxYy/zgjnnMS3ozvRIThPTY/Ylqra9+99tYrv9IEHXUpfxQ7/8OG+sc0kJezjYg45VtT9zxr
	pqVLFzU1+dfsFvNTwAUj0cO3gygshbA==
X-Gm-Gg: ASbGncuWVQFtdtGKDwerV0DQ03xfk0x7QQ0d1xifl+Y+ShYA+ZjKpbaIwb4VgGvrxO4
	MvnsF2bgBuH6Gtjh1iB3ea5mQFjb7nNElZtvc7CPL8HClAjnscVDW0w0L1c2z62Cwl3J2LXGzrN
	VE7MpH0yQZtyZHvpm4TGul8tQ=
X-Google-Smtp-Source: AGHT+IG6CiUOWzkVd1o5BSBcF+4mxjRya6GmHDP5ifniNDqZ5V9WbWg4miEeuiDuV5xxI7s836IZJIdKefh4NbQYxtc=
X-Received: by 2002:a05:6102:5043:b0:4af:fca2:1b7 with SMTP id
 ada2fe7eead31-4c8568f0040mr3537993137.14.1743794804527; Fri, 04 Apr 2025
 12:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402010058.898417-1-inseob@google.com>
In-Reply-To: <20250402010058.898417-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 4 Apr 2025 15:26:33 -0400
X-Gm-Features: ATxdqUEIxDdkozR2bjYmwbPXbvHTGjJYbK4X6cFg5A-CVgrgkvK7UWKXB_wMLYA
Message-ID: <CAP+JOzQ5gvMrFhh65GQPFOQNH5-PHTZwC53MyRf5TAd6tFapkA@mail.gmail.com>
Subject: Re: [PATCH RESEND] libsepol: Print info nodes at the first child
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:01=E2=80=AFPM Inseob Kim <inseob@google.com> wrote=
:
>
> cil_write_src_info_node has been called with
> __write_cil_ast_node_helper, but that may break the result CIL file in
> case there are no children for the info node, because the "lme" marker
> is printed with __write_cil_ast_last_child_helper.
>
> This change moves the cil_write_src_info_node call to
> __write_cil_ast_first_child_helper, so opening markers and closing
> markers always match.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---
>  libsepol/cil/src/cil_write_ast.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
> index 15d8bbaf..7f41387f 100644
> --- a/libsepol/cil/src/cil_write_ast.c
> +++ b/libsepol/cil/src/cil_write_ast.c
> @@ -1623,7 +1623,6 @@ static int __write_cil_ast_node_helper(struct cil_t=
ree_node *node, uint32_t *fin
>         struct cil_write_ast_args *args =3D extra_args;
>
>         if (node->flavor =3D=3D CIL_SRC_INFO) {
> -               cil_write_src_info_node(args->out, node);
>                 return SEPOL_OK;
>         }
>
> @@ -1643,6 +1642,10 @@ static int __write_cil_ast_first_child_helper(stru=
ct cil_tree_node *node, void *
>         struct cil_write_ast_args *args =3D extra_args;
>         struct cil_tree_node *parent =3D node->parent;
>
> +       if (parent->flavor =3D=3D CIL_SRC_INFO) {
> +               cil_write_src_info_node(args->out, parent);
> +       }
> +

This is not going to work quite right.

if, for example, you have two cil policy files. One with a minimum
policy and the other with just a comment, then it will currently not
write the "lme" marker as you note, but with your patch, it will not
write either the "lms" marker or the "lme" marker.

I think that what you need to do is to instead of removing the
ci_write_src_info_node() call in __write_cil_ast_node_helper(), you
should add a check to see if cl_head is NULL and write out the "lme"
marker if it is.

Thanks,
Jim


>         if (parent->flavor !=3D CIL_SRC_INFO && parent->flavor !=3D CIL_R=
OOT) {
>                 args->depth++;
>         }
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>
>
