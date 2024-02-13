Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4F612D1
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856654; cv=none; b=SvG882319xee+INJI7Mt8DFHA+LMubQi6SRvbygKH+5pdquEQC5Rm6W5Ds559Tg12VdDeI9O+0R6jjqSqGxNXdH9DQqk5CfddAwsPisXdGHhjP/hmbsUMEjl9e5GxIqjAlgXMc5htMCCo3ezBJ30Ivu8Fc6PqWIy4OJUO16MiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856654; c=relaxed/simple;
	bh=p71qLQ6Q0+zm6eqlm5fehIyJhRWXubuN4hP6iNlyZH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2dpQ6tL/+8aV6Z03iWKMu6TnuGIa9phApb2Iig8uIpZALxVtEsY1+BFJQD4L/AB6NQB6d5zm0rDm+KqOgFEJUG1QpkkODkifO4Y2fL0Jzh9N5S3dIT5ELku0ugjQ/GEaYyUbrDUYSHN78M3rvKipbDvD5UbQnw7g9aVYQ3Ntpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjjNY6Y0; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjjNY6Y0"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4c01c53efe5so1308219e0c.2
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856652; x=1708461452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3ojeDUAFGNngpcqa1oUWbGVz6751N6hnRMQXLQCtpc=;
        b=JjjNY6Y0WymUKQ6zp6o3zUy/7En1TfH88M30gLp+2EspOqgA5lP8BfCIYn2km1Nmou
         LEEY+uytVVLIfqGnR+FbE1fb1XD5QBhJ1gEl3PV1cvf29wgIvoGe5JvFGIUyjkLzeTDz
         gkhc8Cd0xwYmHsuaBqzl+HgilTP1KvhQAWfJOr0EOBN+mQD0UeX/MCPrcw3GxoFNTM/q
         ZeWDOknAeoxIXKB0ezHpsTVrQefHoH4rhElsL3wTFj7X6l8P+cqkTtplaK5wHT03JZls
         cCr3YAQCS6CB822On0LCi0MGWiS+3e+pPfLvS2t6hCgiGKppKITXjN+TdDq9KccJk1UN
         6rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856652; x=1708461452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3ojeDUAFGNngpcqa1oUWbGVz6751N6hnRMQXLQCtpc=;
        b=G2xgAPIA7wYsqPg8wzCPCBnew3hPailLIf9e4hGBR9HpFrsEyQbSeRNWa/Mbri9Mgo
         rO+30zjVZhgmJWoTv0e0zi5cf4dikatA8laFPT2gddj47F+YycdM29iEbC7LKx4G/e7h
         aF3MOTG6+q5MB4hRLr26D8pVohBc47qM0LdlazPOnXDR2w+S0KU0l7vq0/BuddNfPxzC
         rujk+Ao89Hki4vs4UjQrzVu0nsSThKlwzE5PU6MIhcmPftGqxmhJaGxFl9JMWhqWuba+
         C+GROm68bVkSqwXsKxjtXC5lEMY3NFcLJdohpr50jvof6SYLh1RskUs3VtBWJ0EokXeJ
         PnXA==
X-Gm-Message-State: AOJu0YwRbAgPzeJVXICVGo2PmSSClRCqG+x3xVGhks+Gd/S8OlTWPSsN
	EYm7E/PFNVosL9pelK5hyHnysj4R6vQgGKIYsLKU9rhm4UIPpCxy34sTgW1zOsCZYwo+J43tki4
	KxcjqRarYFwtslQpnn17NNrpPRlk=
X-Google-Smtp-Source: AGHT+IFtTCRUbv81g6TjnXxUy7xAc/8c+XeHpjF0bk5sd/THUlosWV3sVvFVqzqpSrgv5mxoIFMjNGiJABUCsoOFvyc=
X-Received: by 2002:a67:eb41:0:b0:46d:3597:9f9e with SMTP id
 x1-20020a67eb41000000b0046d35979f9emr754044vso.31.1707856652221; Tue, 13 Feb
 2024 12:37:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-9-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-9-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:37:21 -0500
Message-ID: <CAP+JOzQP+SmXvGvUmyEFgD995QSABc3MBrP2tCJZA-ZKfbBYtg@mail.gmail.com>
Subject: Re: [PATCH 09/15] libsepol: use typedef
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Convert the only usage of the raw type struct level_datum to use the
> typedef.  Simplifies refactorizations on the type.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/module_to_cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index ee22dbbd..417c5307 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2390,7 +2390,7 @@ static int boolean_to_cil(int indent, struct policy=
db *UNUSED(pdb), struct avrul
>
>  static int sens_to_cil(int indent, struct policydb *pdb, struct avrule_b=
lock *UNUSED(block), struct stack *UNUSED(decl_stack), char *key, void *dat=
um, int scope)
>  {
> -       struct level_datum *level =3D datum;
> +       level_datum_t *level =3D datum;
>
>         if (scope =3D=3D SCOPE_DECL) {
>                 if (!level->isalias) {
> --
> 2.43.0
>
>
