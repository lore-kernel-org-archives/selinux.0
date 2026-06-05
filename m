Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169544D991E
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676058; cv=pass; b=TDRDYIU0WWt3ezxV7X5gOmepQI0CHQcvtDmUKkWR8brMGBdDgWoBeeeTAqWUG4txs2kmruGsLyQEfxs6Imdlv4fZuWEUsXWiBlPgy3QuBE+vDF2WMRl0MA9Z4tkkhT+BJzWutWge69WlLq/ChNM9hcU1pH/wrvaIXu9ILzFV4qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676058; c=relaxed/simple;
	bh=XVGfcg6R0OyiK5MWeztZl06TXGpKwVf/cay4Kbmzas0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3JIQC69BaY0EjuCp3v9vEvSPCea32vCPCNMacxESfPC0HtiV7k83Wfv9f/tuUyUDu0vjKnvrKHlk/NHjkbwreP7ed72/plaFagzQ7nP9CrCLsMuiP44ohn8ec/8Tg/behyHxdNC+Q5qbcz3c+kMgQqyVpIMiXZvSIKBLeTgqPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9+pG9Ic; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9+pG9Ic"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf114b0cf9so18072625ad.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676054; cv=none;
        d=google.com; s=arc-20240605;
        b=Jd77q5f82/50AJr3LofOp1WOj6MxL6lZLhmv8RWYk/g39LT3qaAgS+s8m94HySIkv5
         5txcFdMSCODioVb/svy7Y50OigdRGTxJxSy3Hsp7oanHq123L0zilBlh4Fl8YAJuMEEa
         MqgBFkW/uLMG/z4XUbq7S3wFjGBbyowA6N8punh7V78wU3EDiACW4xzh0vTINXOsknFn
         S0z9SzHIlfbjeu9C9YFTQfg2mNN/tRpYH8HzlpoPilJWvedEj9qs0nMjc4Ua3sWPafGb
         4DdUTtMrTrw7yTsn9lracTB9amTGog+LAFyrHIJJ4BymtGtkO9MDnGfS25oZqpRvrePQ
         9vgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DXP0dAuftcsxWnBsq+YXRMouh8THrANrR5RtWsVTMMo=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=kkK5BhuD1fibK+HfQoIcFFd7yyjuZIEWdtfdC8xwIebU/YFqNFS9sHptxs+1v7iBS5
         8sSODCYDY3ib/gX20V2Q12LGiMyf4DOEJyI2D8MNpy3njts9BzjhZnA8b5hQTIHYP3YW
         nE2Kql2IVsktIh/nHlPc6GevMqgDnwLKPyyF7JQN24AvbRabbMZw9A1FBP0v63mDGG0Z
         CcuVUK7ZjHZjXZLjMJPv3V5NRudflg19gchHlT89G0Es89f+mQOy6/W/sO99D3YRvj6P
         M0jupSfCQM1lwD/jO9/XZkLl6BoyKYRoqC+VufR/atViC81JLQQRQl1YPGxe+Xn0rZlD
         aNZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676054; x=1781280854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXP0dAuftcsxWnBsq+YXRMouh8THrANrR5RtWsVTMMo=;
        b=j9+pG9Ico7emGTzJzINjRg5418dFMi6KvKGdo/4Q3VLJoQq4iRcRqOfuC/kvIYVqj5
         jOiyRe7DqKHHM+RsJJ/eTIYoCTuJIVBvsXvIZBRnRqdjFcb2L94WKtkqrfArKftZEJuN
         g22AOS3a+5Gpgt527l+DVMdtxdy2IENhX0B+0hXc6rY/cQS6vBw4MPwSpGuWNTJaaRa5
         p5YnKAXK7vKpWnOD42Wsv1bhovl9SP2NWQT1J8oaXThA/yqacxfqFrRJ+nB1KmygsOuU
         JTYRy2eraR/2lXlC0zAs/24MGDAN+DcTCRBmRgxNFD61ofbF7esEkHbv6BsHSZcbekED
         kWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676054; x=1781280854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXP0dAuftcsxWnBsq+YXRMouh8THrANrR5RtWsVTMMo=;
        b=D0c5+lb9JG03eJf4lacJF0+YMGnbGRxz9MCeEdOot6pq8bBByxB2CQcBovuuBUC4vn
         mymyfrMJbbAewq/nYpX8khMGc4mtacZXWVTwlsQU10WxTn8Kxqb2oQvM6B+fXBRveCDZ
         YHPgD0/hRgzOkS8eIV+tMS2jGuffDIbij5Xz32RzzssAHL/gnWcQmSvYtysTO1gaF3nU
         tfObfaxRsuldb6FYsa5EyGlSIWBexfcP5Pz+2WI9gLOYrD+K1gAaIW8Ei0B0hGOhodou
         V1ysY1umSoaEpe6OYdyX8uSAPo3gbRH2uPfws+ED4FR0GPmTn80YbXkQ8JcvR0MW7S9V
         eJ4A==
X-Gm-Message-State: AOJu0YzlQE5rWuWX1Ecyg4betpmqrlJPXM78FqlOUWuE4ZshixcpxghT
	Qg+/k4o19Tag71UyOgPeFJ9sfYdqi75dJjNrC1cqIGLWf87YBwkz6uS1sN/5NTnaxosFOW1biPx
	lhG0usg3GA4ToDBTLX+fMORQ6JneMga0k9g==
X-Gm-Gg: Acq92OH7D6ZW3pyPFwH5C5G4nixbImyXa8R5cOiNysoPcRkEJx7oLtFgzWGe35rh85E
	yDB+AAU67L4I7XKt6rrEtpc25eNKYEL948ECuOjO4E4Igso6j9U1DIzfJmsH27txYevvQGhNZIi
	GN9eq8ezVYOO9xWGbJb+GL78dlJVboJy2P2rXv0oZfZQUj2PQot/3PSWF/ulCSxbdkKV72O/5Jg
	qCavsjCpXIuIfIcAaREM4e/vbvqTckdckF5dvHnivc+xZVgrlWeNZG0MdAeqjBgapftN2tcQqjp
	iN57Z3TMuR8G4J7YBQ==
X-Received: by 2002:a17:902:f611:b0:2c0:bd28:bed5 with SMTP id
 d9443c01a7336-2c1e8214337mr49012325ad.10.1780676054111; Fri, 05 Jun 2026
 09:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605155259.112585-1-jwcart2@gmail.com>
In-Reply-To: <20260605155259.112585-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:14:02 -0400
X-Gm-Features: AVHnY4LWlUNOpiDreNOtNhAVOCABdWHykUwCUs3RJQcVcojFXZ__G7mwsxFfoN0
Message-ID: <CAEjxPJ4z-iLUAC3J5X6_FKNCxfNpG7jHFMDkG3ctdCD9sNPbCw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Need to add to the length rather assigning it
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 12:11=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> When writing a policy.conf constrain expression from a CIL policy
> all user attributes need to be expanded. This includes lists
> containing users and user attributes. When trying to determine the
> length of such a list the calculated length of the users in an
> attribute was being assigned as the length rather than added to the
> length.
>
> Add to the length in this case instead of merely assigning it.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/cil/src/cil_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.=
c
> index 7f20b7b7..85c01050 100644
> --- a/libsepol/cil/src/cil_policy.c
> +++ b/libsepol/cil/src/cil_policy.c
> @@ -384,7 +384,7 @@ static size_t __cil_cons_leaf_operand_len(struct cil_=
db *db,
>                 cil_list_for_each(i1, (struct cil_list *)operand->data) {
>                         struct cil_tree_node *node =3D NODE(i1->data);
>                         if (node->flavor =3D=3D CIL_USERATTRIBUTE) {
> -                               len =3D __cil_userattribute_len(db, node-=
>data);
> +                               len +=3D __cil_userattribute_len(db, node=
->data);
>                         } else {
>                                 len +=3D strlen(DATUM(node->data)->fqn);
>                                 len++; /* " " or "}" */
> --
> 2.54.0
>
>
