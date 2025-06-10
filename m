Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7551247295
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749578581; cv=none; b=H0ggJNhllN5urlb+IE7LTP+MuW2VK9wbv27grx/FPKtNBzvXPNTBWWMRoeWNEJE6+cbXsmv81xnARnXu5c/FYotb6MGI6uYQ473hJu9v6dj8udE2tZrIQi3U9vfuMN/XZL/IIrCuz/UFQZ7eJJhk586TW5ipiWsnNA9IpFaPqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749578581; c=relaxed/simple;
	bh=BsAvJr7LYGU7JxHRUudH0nlnE6Et+nKJlKvxLIOOHL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfJHRGjDVXafpz+ecBOZdic5sjPDeOMOvV952NaRL1n+ELBwV1WFajEbO8wzmJuqqsaQm2HJI2P5ayuqRjnvjzUBEun+/dk1bNbYmO4W4j3bBpllDoWQG7qofjgAL88zIeNyZBFm83yVGObi7/q9Hc/T8tgHlvnn5Gd9qPwftQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcZ6DZxH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcZ6DZxH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d09b0a5050so351664785a.3
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749578578; x=1750183378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYxxaWxzpRD6w/4uFHzngLM813QxioeMGR3DbeMLr1w=;
        b=QcZ6DZxHBI74z+loddKOTnHRYydV4STbn/v+o5y9kLGcbtrShspoIRffwxQ2wdPPuE
         RRSZiXqhar4OH+YRboRRRcSAvT5QdPOSL3y783WHl9pB7bV4pyMMByzu1+G7xBlfir8s
         CJf1hUhbM6kLt3ke9Mil6dEuGj9VHcyIGKLdl51N6Dbd21uDlYn8MokKRh2dyZZFDP+4
         SiJBeoAJwxjl6eTQ9uNRNeisy6cwnN+EkvitD9TLGzYiDDhqWO7CsU+8U5I1FJgqVuCR
         v7h5Hkhk5VcRr62aabjhMxRR8KpdDirAuEuceBCEVxQRnkhInBLk2fxk4DeS/FFpa+Je
         vUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749578578; x=1750183378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYxxaWxzpRD6w/4uFHzngLM813QxioeMGR3DbeMLr1w=;
        b=j+HVMUwsYMygcmzWYz8F0N8O165NUEKUBEOhhhTlIACa+vqnZTVEwQ1xo7TXBBqaba
         RcZh2VYk32+5VqPXxzFrpWKLeohtYbVpMxjGc0hkNQHWcEb2ot6mMLyO/UYYh2WkzCkJ
         Y4WUWaeBF0drOUw85JrJg51DbbZiAYkfY7SQCcmxks3MjzV3koRTy5YfycQurWR46nmi
         7WNoj2Nwl5M1FYjqrOJTpQ23nK1UmSRpykpkm/PHrEMfZz8gbW52qDXfYrQA+ys0gFBs
         OfizqZ1neCOlCNFs9pUXZ7EpuOGPvBQhi/DUDqmNKsdIHBYNdCQvlWXPEXEeNIoGkWgX
         okFQ==
X-Gm-Message-State: AOJu0YzCamay+112F220yYw05xFQRiFfg0qhLVLNy0QFSK//zN5OdtZO
	zzZtyQNOadDc65Bthq6H3nqyn9Mp6IhdQhk2CGqBt1NX42zNt8fbXv9oglVx9ww/diLEqQna849
	loTtHo/+pD7Qoj9SxN8lFzub6RtMFbIY=
X-Gm-Gg: ASbGncu9J747Py+OzNocs/1CPDLQUQE+tL+BvJDIHeYMVoN/4S8KGoN2Bjgz5VT4Hbu
	j/rEcnd81af7W4zIA3OD6RZ7W2GeGUjDNV4PHVS/d9RTICG+tp0vvNqzo6hb6AKmIC2ZGdspoJK
	/pPjxA+W53PGMsn+Bj7XWUUbCzSpSvWEH9hgdsNpB7ahU=
X-Google-Smtp-Source: AGHT+IE+nztrZdWKTcOLuyxWnL6QG+f1UEsUdYAXX2nwjtFrUU8CKp79iaeV5jNmrcoTDxhDxBzDee0zpn5iCmSYKis=
X-Received: by 2002:a05:620a:2956:b0:7d0:4615:1ffb with SMTP id
 af79cd13be357-7d3a8836074mr48375485a.23.1749578578401; Tue, 10 Jun 2025
 11:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530051322.1678251-1-inseob@google.com> <20250530051322.1678251-2-inseob@google.com>
In-Reply-To: <20250530051322.1678251-2-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 10 Jun 2025 14:02:47 -0400
X-Gm-Features: AX0GCFuDMnnVIYZLuvw8KmQrElutpRZOi4IUMX4CQYwbBU2GV_4SwKakSdiTFPA
Message-ID: <CAP+JOzSt20YXS1jk_Z2p36jeLodYqkhL+g6m6ihwgA2c4MiiPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] libsepol: Allow multiple policycap statements
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, takayas@google.com, tweek@google.com, 
	stephen.smalley.work@gmail.com, cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 1:13=E2=80=AFAM Inseob Kim <inseob@google.com> wrot=
e:
>
> Same policycap statements don't conflict each other, so it's fine to
> allow multiple policycap statements to exist.
>
> Signed-off-by: Inseob Kim <inseob@google.com>
> ---
>  libsepol/cil/src/cil_build_ast.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index fc11758d..4e9ecbd8 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -145,6 +145,9 @@ static int cil_allow_multiple_decls(struct cil_db *db=
, enum cil_flavor f_new, en
>         case CIL_OPTIONAL:
>                 return CIL_TRUE;
>                 break;
> +       case CIL_POLICYCAP:
> +               return CIL_TRUE;
> +               break;
>         default:
>                 break;
>         }
> @@ -205,7 +208,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_n=
ode *ast_node, struct cil_s
>         ast_node->flavor =3D nflavor;
>
>         rc =3D cil_add_decl_to_symtab(db, symtab, key, datum, ast_node);
> -       if (rc !=3D SEPOL_OK) {
> +       if (rc !=3D SEPOL_OK && rc !=3D SEPOL_EEXIST) {
>                 goto exit;
>         }
>

Take a look at how role, type, and optional handle this. You need to
pass SEPOL_EEXIST back, so the duplicate is destroyed. We allow
duplicates, but only want the first one.

They all follow this pattern (from cil_gen_role())
    rc =3D cil_gen_node(db, ast_node, (struct cil_symtab_datum*)role,
(hashtab_key_t)key, CIL_SYM_ROLES, CIL_ROLE);
    if (rc !=3D SEPOL_OK) {
        if (rc =3D=3D SEPOL_EEXIST) {
            cil_destroy_role(role);
            role =3D NULL;
        } else {
            goto exit;
        }
    }

I am still looking at the last patch.
Thanks,
Jim

> --
> 2.49.0.1238.gf8c92423fb-goog
>
>
