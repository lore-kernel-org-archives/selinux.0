Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB34AEF7
	for <selinux@vger.kernel.org>; Wed, 15 May 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715804217; cv=none; b=o9hZwD7zr4x/9+a2NSrVIiAfLhTN1KL3/3dD26JJpD4+kdCL7poGubvdzAcfpNA90y5LGZRUooo2bfUmcZFVWb7LDxnMsy3dgj8xxJEZYiedYLpcete3KwT2OV9CfpYxYYsvkk+gX/WHfEq7MiqjoWF0LsFXVC1YvGx8YYip2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715804217; c=relaxed/simple;
	bh=5Xy9YZ/ViKzMIATDCQV7uTKq7RowBL7+HNXgin2CdwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=csSqnZF5LvDIDR5oEf3cZSb/14Q7U7ylbK4Tnnpy0SVgf2r66mQ3vn3xduFXjpU+iCg/9hEkcd03XnmflmZXrq5cSZqG7WsWlnlLtTM5QGyemdNIcoZ8LFBTaD3gLwKYswJHdZP0sorbXXkV5Wu6QVlMy18UUpjKpXWEvfoA6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9T57Ooy; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9T57Ooy"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7f8df927790so2425309241.3
        for <selinux@vger.kernel.org>; Wed, 15 May 2024 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715804215; x=1716409015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpZu23BHhywxjL/yzhis/IMDICTIkTlNybqTlGS4Xns=;
        b=c9T57OoyayA1pveG/ad1z3e+2IPRpnaXJtuPJDlKKTpqpmANgEwTldl9UbpQXRHChf
         pFIdfk++Xb3WR/V3vgYQpa0Unob7duikMFCXotZiSby4ACvknBXnv8Fm3ZtPSh/xj7lm
         K1Cs/dnx/3Ju+/F8d6M7+pLsmCxngcsz2H2z39q1NeqpT50iviIfwNjx9bURS9SRCprS
         5KEdDDbJLjboYh2QkYKN1k9nfha32fjY6Y4GILMunoKTKtYOaE0J24skk8nXeSGwL6NU
         HOxzlJ13kmBVbsEen4xnIqtX8e3+2iW2oF/J8xwDDMhPZnZOHMUVIzVfTfFaw5iQ7HPi
         fN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715804215; x=1716409015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpZu23BHhywxjL/yzhis/IMDICTIkTlNybqTlGS4Xns=;
        b=kLA5A+Rl7xnzyOAvBJ7NbRSA4QS8Efwh7BBUod9hbIsBedozt31Qbw3Hv257wziBe7
         xlFwPKipBocVVK7vc2/6Dzi+YTRnnfK1Gxjp7SHyFEdCAWA8Q/KKu3l3m1WhfUDwDMma
         oJ+hHHmi9MurK1f/aC/FbHBbP6h9c9HVGcV+XX0/HrbADK3HyfvEfT7W4p/s5HhHCObY
         E64dH8am0W+3TLzi5GcuoDjZ2243iy8nyp1Z28LmqhgVWqO+r3qqsl+8njtGaZTkSs2U
         OjvxMT4YCruyUGWvFF+PCkIL/spmie/w0RKY5Ws4n1ddtVidGq4PRTiqEa/g82NOmMOy
         6ETw==
X-Gm-Message-State: AOJu0YzCOIUEqmb0zg7voXltTGoc+XNXQc7rUmyUmElVpL2Baoy34Vhf
	Da/cnPOMpGbpU0h80Ag0E+d77ItTg7qPHGyPq+ctWYmUDyk5l5PXnocl8Sr/z6/KjGI1ZEiW3K5
	XG+Uf4DlQRWH4vSwPbsytPDlRlcI=
X-Google-Smtp-Source: AGHT+IHEWzBefe1BCv2vI3INgkbhP8ijjY4rZcF2IVx4MJHdft8M5iQjtjwDMTC0/4Y2/mrq3VLdq2Tll5pM+kH4suo=
X-Received: by 2002:a05:6102:3f4c:b0:47a:40f9:5bb5 with SMTP id
 ada2fe7eead31-48077e79c94mr17758629137.22.1715804215081; Wed, 15 May 2024
 13:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508170422.1396740-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240508170422.1396740-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 May 2024 16:16:44 -0400
Message-ID: <CAP+JOzT-5hq2bx-XbXWMsFORY2FX7jAO5Lae=87+pRqZza1bXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpolicy: perform contiguous check in host byte order
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 1:04=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The contiguous check for network masks requires host byte order on the
> underlying integers.
> Convert from network byte order to avoid wrong warnings.
>
> Fixes: 01b88ac3 ("checkpolicy: warn on bogus IP address or netmask in nod=
econ statement")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these two patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index aa2ac2e6..9671906f 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5292,7 +5292,7 @@ int define_ipv4_node_context(void)
>
>         free(id);
>
> -       if (mask.s_addr !=3D 0 && ((~mask.s_addr + 1) & ~mask.s_addr) !=
=3D 0) {
> +       if (mask.s_addr !=3D 0 && ((~be32toh(mask.s_addr) + 1) & ~be32toh=
(mask.s_addr)) !=3D 0) {
>                 yywarn("ipv4 mask is not contiguous");
>         }
>
> --
> 2.43.0
>
>
