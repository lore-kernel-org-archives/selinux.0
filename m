Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5B1EB1A1
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309793; cv=none; b=mJBcq2roW4hahAibEX3cBmfAQ7ohU7S18Urld2J2/Fok2Mr6f8SPOICS4VVADeQJ6LyMYF3qvhwnVQ3fStGzA/cFb3fmlynNdoN0XjDRqYItL7i0dB8QlnwdRhMSYv01GE1svSKyXEEYEOjwYCY9YEb63ulIrtUmQDKFlGgaNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309793; c=relaxed/simple;
	bh=rVTyljscFSbmQEGmtfibwYxcLEo5gIWkdLQhMH+3Vq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnCIEqkqV/0+fxgt14+vlMIX6AYK3805luCbVEWcrMVRfFjusLAEJUGAM5wn2v1o5BYXvic1d3qUAOgFgKsVWumFrN7KibFFniPzTWJhpov3Kr/VL2JrairCt92ypZtMfaAUaMzo8gZpq9VpQO3dJ+YCaRRKhAvM3Cbz9fuiEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjIsmBII; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjIsmBII"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d30787263so481150241.1
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744309791; x=1744914591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/cbFCtaMrkjcT+og1iKAW5G7bRdp0rC++LvT3ZkjN4=;
        b=BjIsmBII7B/KNLG3PyflxRMd/qxDuroQi0KzmI5fcyXV0PauXLkS6mImQcFzv2pLNs
         O1vIvPZUSrfm3nlfBVWG3THWkTxrJRB10gIDo48TUixDPbsWsOIpcx7vYSjOMrpzRypA
         DAs6sECeHOV8vOOT34J1qQhaby2hBld7o5oRePy7kuu4eGEans7UQWzlDkE9sgx6cNny
         fx95G1X9IqT8UCgQH/0pzHq7q1yXw9btYpVGXHK0kQ3rAeNRVh5/K462khhResGi7feV
         edZ+iIbFDpFPwARZU3lH4yX44W24evND6ch2yZ+WFR+SlkgNBg7mdbCDJZQ9YropZctf
         +EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744309791; x=1744914591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/cbFCtaMrkjcT+og1iKAW5G7bRdp0rC++LvT3ZkjN4=;
        b=V2TSubVJqq0Da3PaFFX3RzrFMvZGtjYZYe6ixyYRp83nf+5uuoVAtLwae019nNIek7
         BpeV1sjInDsvNZ5RPPz7vfm0GnD+whcNpBf4Poz+SDvV0qCOj6M8GSxUDAovaUWUA6r3
         DuPY9/YRAXuoeilgKLg6pJQwXbcnbYU533dH6yvjbpgDe7dmrDUZX/hkYFXMEB0B5gOr
         spMUIWnjmCgWpUs28NAKHTeRlmCeUe5C/turXrXNWvLLNoh0qZsYHIrxHgrYLV5TJdy2
         FUIWUayuxX7nOQAYgiy2qdJz5x65a0a2agk2S38gQ1pSOk4/xdgcOqcXRMR5bGIKdyYZ
         npmw==
X-Gm-Message-State: AOJu0YzuUFVUjXdiv7kmxqd7cs1WAiP8aBNZTizY7qWKCQWErRLSVC6M
	X9uZgRSZwruurDfsaiSFdKyAHsld77uqra82O/dG9V4CnJeqWBa3q1jVffzghsv1KgeIiMIR+AC
	OX78CFis1AL+Dpz3+422B6jWEt07db9P0
X-Gm-Gg: ASbGncsvBZp88+5+QwXx6zmsbM8w8uAiWXH5vBhDdecD0agSZU3KWOejy3j2L9ni/c7
	hU3JcZre85FYvrXOU4TVOg8jzHKKdQd0peoUB08D9OhxIku26q46dOFWv3wppa8rlr93WFGsyfw
	8s9HUwUrIVvEJsJB8yzR4=
X-Google-Smtp-Source: AGHT+IEZYSf6yKlpNdiC5LIUFq/I7l1wfCDL3C73lUaw2sPgYJuY3ZqnI2y98ria4dIbPyhM0gNME69s0SCkk/f+Pkg=
X-Received: by 2002:a05:6102:2c81:b0:4c1:93df:e838 with SMTP id
 ada2fe7eead31-4c9d361f23fmr4472266137.23.1744309790821; Thu, 10 Apr 2025
 11:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407023757.2183935-1-inseob@google.com>
In-Reply-To: <20250407023757.2183935-1-inseob@google.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 10 Apr 2025 14:29:40 -0400
X-Gm-Features: ATxdqUGEyfUyIcjgdvO6m7VVPHHGWnU2uMCp2_TnzllzNV9aytqAD1JkT8KAL8g
Message-ID: <CAP+JOzS4fo+GNVz7qE=6wbCkLANrkpn9-Vj=wU0s9kSdOZJc1A@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix markers for info nodes w/o children
To: Inseob Kim <inseob@google.com>
Cc: selinux@vger.kernel.org, tweek@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 6, 2025 at 10:38=E2=80=AFPM Inseob Kim <inseob@google.com> wrot=
e:
>
> cil_write_src_info_node has been called with
> __write_cil_ast_node_helper, but that may break the result CIL file in
> case there are no children for the info node, because the "lme" marker
> is printed with __write_cil_ast_last_child_helper.
>
> This change manually prints the "lme" marker in
> __write_cil_ast_node_helper in case there are no children, so opening
> markers and closing markers always match regardless of children.
>
> Signed-off-by: Inseob Kim <inseob@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_write_ast.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
> index 15d8bbaf..f9edadba 100644
> --- a/libsepol/cil/src/cil_write_ast.c
> +++ b/libsepol/cil/src/cil_write_ast.c
> @@ -1624,6 +1624,10 @@ static int __write_cil_ast_node_helper(struct cil_=
tree_node *node, uint32_t *fin
>
>         if (node->flavor =3D=3D CIL_SRC_INFO) {
>                 cil_write_src_info_node(args->out, node);
> +
> +               if (node->cl_head =3D=3D NULL) {
> +                       fprintf(args->out, ";;* lme\n");
> +               }
>                 return SEPOL_OK;
>         }
>
> --
> 2.49.0.504.g3bcea36a83-goog
>
>
