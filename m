Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D02D63F7
	for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011928; cv=none; b=MLEDXFyXt3fuqqw8MBFavhPwxlVtzTxFQ7CXMUwhY1F/XZNck4BBKwHhfRYwD0yTMCcjykUsnqpT7sjz4wJ4s/5T7H1DGY/cOXqWUGHgN7uZus3cpjQDbvcLYV/8qr2TkXYXypJkXmwbhQNAApVv/ilTkaxQ9X1/q0z/H+I6z8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011928; c=relaxed/simple;
	bh=w6JlLBcB/cqn6LOc8/qavDjWlI3i8lN/we/FZIZbeN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxDEGTwElSSVCxH5jlfjbYq4Blhlm1bJsBycldxC9KjbC41d5HAkCfb0ZSXUPty5YQC4BoCFHP0FIYUYBYLCE7mzTbU3iZWIlZBuJUY7WEtiFJ4JGUb+I3XZCvEcgypJ3hr+YG9gefhRe/rN8o2OnfchpN6oLESy1iypum/HgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbGw1UKo; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbGw1UKo"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-88bc71ff9b0so2624165241.1
        for <selinux@vger.kernel.org>; Tue, 12 Aug 2025 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755011926; x=1755616726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WtaxxLbK7p2y3PHa/LD+Y+g4cIn57tdGIvbD5vhxtQ=;
        b=jbGw1UKo7uu411jBQUuP9eHG+qdTij8UF1ngbgLPM6AeOxJ/HnEW2LVKnzddONB7lB
         lHZABMTDuA0urYSN6uyuxGnVbHkZCW1LxovhM7CmqW8RAiIex3sGS1oG2E85SHnQERUk
         0VvoN9mRfcg0KKRF7+4BAy70pEgeDAwIgnL/nS7eWFufkCNzqYXyKWsHW7gV6xXnlRxJ
         p/F5xVQiGaLXTwAOvtntW/34JOnMPs1wLXNGKlu2HfVagFNSTLemX8I80O34ihUB2uE1
         Ki7aA4mzqXTlUl4nF3Q1BVB+0ico6y5BSsiiYLpj618BcSXBsLUWL36oiL30hzx8jzRt
         YblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755011926; x=1755616726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WtaxxLbK7p2y3PHa/LD+Y+g4cIn57tdGIvbD5vhxtQ=;
        b=ifdJcpplqC8lkr57Sxi5W17UqcOn72BaE+CqD11bnz9bos8OlP//L4PPvMQsBYrdV3
         gIrejBmnTbeljD1D1OUv8gu+X207L5KBnS9vm2i0skbDHNU8vPw/Oc0mB3o710B1uut0
         HOmB1fTO8Cjxk20J9n2UbRvUTW8sD6WcOLvm9bZWke1Me5uhlJIZMMpCHB63hBkRKQdR
         TX//lmncK4HEpqe6c7WlKOZc+z1BP4YPM7Bk848v2ty9h+VWd41ACo1a0r+nLgWKBa/g
         wcFLjYrCciyxcVzCRxIPhZiLdJixcjdwvxRogUw+8zwa8k/0Rn9FffQ+jl64l4kT+Zm6
         Yp0w==
X-Gm-Message-State: AOJu0YxerSJ5X+/OjuVO4BI9GlAAsMNcX596Wvs0oNqrm4vXHbAhRAua
	c6ETwwsM+DXPox5TAhA/8AYjBoe1JSsYTQzL2O+J9Jnb8v8b6kiJ57fAtyDLuVP2IatGagw9p0V
	gN2KJnjGVQcmCMOwcqq7yWcNTwUMwS/g=
X-Gm-Gg: ASbGncvMimKLyWpERlXUzc1fNy68tX5gJfDrV6Cp6RdnkZeTCj2HfMaaXtNWEGtmDRZ
	k4v9P//N0VMiP9QAchdt1snyeN86fBN3xcbEl/Qp7W0NY1oQ+EY4q5NhckErUAaoQ38g960Bf+9
	jLn51mFiBfnTzlDJiwCqoalZPzW1VIMYGGsjwKzTBs2UIbo5hYZ9v4+F4mjJCYwKo47rHR+afdP
	loR
X-Google-Smtp-Source: AGHT+IEGfypYog4rmUU4hReRKRqnO6r7jOpIkXn2vb4HzZS7RfD7O6qbVqC8FsLuFcy+yoZsp0DaJhHW1Cao1TH4DWw=
X-Received: by 2002:a05:6102:5a86:b0:4fb:ebe1:7db1 with SMTP id
 ada2fe7eead31-50e21883abbmr113968137.12.1755011926010; Tue, 12 Aug 2025
 08:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731102224.1045166-1-nvraxn@gmail.com>
In-Reply-To: <20250731102224.1045166-1-nvraxn@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 Aug 2025 11:18:34 -0400
X-Gm-Features: Ac12FXygcucO9rOo_d0ZRU4MhX6klYUezyiwmzfetjRYDHQCwZCqO4FDCrKWiMo
Message-ID: <CAP+JOzTBrgKgzf2M4VRXXG_1=wSd-Zf-xGrp7J6w=o34+adGCg@mail.gmail.com>
Subject: Re: [PATCH] python: fix flake8 F824 error
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:34=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> This fixes failing CI[1].  From the flake8 documentation[2]:
>
> > global name / nonlocal name is unused: name is never assigned in scope
>
> Meaning that a global only needs to be defined with the global keyword
> in scope when it's being assigned to; not when it's being read.
>
> [1] https://github.com/SELinuxProject/selinux/actions/runs/16623315767/jo=
b/47032933729
> [2] https://flake8.pycqa.org/en/latest/user/error-codes.html
>
> Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  mcstrans/share/util/mlstrans-test         | 4 ++--
>  python/semanage/seobject.py               | 1 -
>  python/sepolgen/src/sepolgen/refparser.py | 2 +-
>  python/sepolicy/sepolicy/__init__.py      | 3 ---
>  4 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/mcstrans/share/util/mlstrans-test b/mcstrans/share/util/mlst=
rans-test
> index df34e0e6..8fa0c379 100644
> --- a/mcstrans/share/util/mlstrans-test
> +++ b/mcstrans/share/util/mlstrans-test
> @@ -8,7 +8,7 @@ errors =3D 0
>
>
>  def untrans(trans, val):
> -    global errors, verbose
> +    global errors
>      (rc, raw) =3D selinux.selinux_trans_to_raw_context(trans)
>      if raw !=3D val:
>          print("untrans: '%s' -> '%s' !=3D '%s' FAILED" % (trans, raw, va=
l))
> @@ -19,7 +19,7 @@ def untrans(trans, val):
>
>
>  def trans(raw, val):
> -    global errors, verbose
> +    global errors
>      (rc, trans) =3D selinux.selinux_raw_to_trans_context(raw)
>      if trans !=3D val:
>          print("trans: '%s' -> '%s' !=3D '%s' FAILED" % (raw, trans, val)=
)
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 10963e81..b41efd59 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -244,7 +244,6 @@ class semanageRecords:
>      args =3D None
>
>      def __init__(self, args =3D None):
> -        global handle
>          if args:
>              # legacy code - args was store originally
>              if isinstance(args, str):
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/=
src/sepolgen/refparser.py
> index c8a3eb54..01a322ca 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -1038,7 +1038,7 @@ def p_quoted_filename(p):
>  #
>
>  def p_error(tok):
> -    global error, parse_file, success, parser
> +    global error, success
>      error =3D "%s: Syntax error on line %d %s [type=3D%s]" % (parse_file=
, tok.lineno, tok.value, tok.type)
>      print(error)
>      success =3D False
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepol=
icy/__init__.py
> index 2d526c94..3b87a869 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -195,7 +195,6 @@ def init_policy():
>      policy(policy_file)
>
>  def info(setype, name=3DNone):
> -    global _pol
>      if not _pol:
>          init_policy()
>
> @@ -354,7 +353,6 @@ def _setools_rule_to_dict(rule):
>
>
>  def search(types, seinfo=3DNone):
> -    global _pol
>      if not _pol:
>          init_policy()
>      if not seinfo:
> @@ -936,7 +934,6 @@ def get_all_roles():
>      if roles:
>          return roles
>
> -    global _pol
>      if not _pol:
>          init_policy()
>
> --
> 2.50.1
>
>
