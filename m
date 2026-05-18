Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43873391828
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134350; cv=pass; b=S3G3vXMyV/h9BryMwLq54q9W8G6LLKI/Br54n4crr2r2060XDPaaqmOeIArkqpXadDpYkQp4HQpWQKHflq+I+Ze5FaBQScibEBRG/116FL+17Sg9sBXjAS6qgQ5auFJxZOPksYlj6cN/2avVp1UCJjKmzzABlp0jUF8dv9nDlvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134350; c=relaxed/simple;
	bh=/1N5smC1WLQdhyaeG0EFbAbdDTVQXras1mlOnvYCo3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgKV706e5bmWtQIBQDooJkJDpz9+rUQKKEtOMclwqp/gqIXH4sgnEOouDzT00Rokjw/tC5kYqBnRVDzOukkFal25GoUvcqEphSKsZkH/IkNmkPd8qHa2wyGs/xbXXIW3Chr1LM+i4nZ+CTY//UWzWdtRxAPK13KUoIrELV/9KPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXk67egW; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXk67egW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba21d32776so19435505ad.2
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134348; cv=none;
        d=google.com; s=arc-20240605;
        b=IeWarzOMVuIxOKYVBPAi9oMC1jTereJPIrci7LjLQpxucMREaK6IHzyY6pWP0h01fy
         fjJj60fTk9B0ztFlZfZ4x12Xgd8uLQuNjwStD6ZR3MvpufoThGk2QlDiLv3ifaPgiTeJ
         C7MFj2Fiw5ajLe7cs036s/VxnacVqDoV82NdESJq29DJjnxWV7lLNp0rAwvoYMM+ZJvV
         6N+uqKQUNoXPGHGKyDEo0YJ9pTy7IcHH4i4b+s47k/FkJ9fKJAHMWsdUY3aTpRbKdGV1
         i6LmHuCtkB+q5kjXr6OP8azOX+M7+U+rfp1u993Eg9Tc90nGRKkLhP5Lj6ikgpEdDJKx
         up3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JuxO2Lql7WOYtQqTYsPDr6cFUc5aNGEjSHX7X/kREas=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=LUOOXzJLb0hFnYopm9LZ/vIB7HdiBF8EbkD/87ee6AyCuWT7pau/FBw7XP5RMDWuR7
         rW9LiTXJrf6SQSgbVrt8Cv9K/wLdwXHzx5Fkl86SBGXiKtqPYlM2A5T30u9ArA8vC5Z2
         py7V463Jv3GLsG1gkUOwK4bKu1Klo76QIF+S88CyLEKMq2rhMMhmgIcuu40AX9NVSG7t
         BATuMBuUCE5dbcOsvvHuI6AV9zruK1iEk7hxJKwI87vNxVkb7dv4em/6mifuS9OSdhBo
         NX8DW0XbpRfwBj+8ugxphUaS1SOCDsGtrO1+JElgevq9mYQ1LC24zXItEPXOGSrv4xSo
         On8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134348; x=1779739148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuxO2Lql7WOYtQqTYsPDr6cFUc5aNGEjSHX7X/kREas=;
        b=EXk67egWQU7NdLmLPBoWqDUXnS8Dib/msr+qoxDFh5N6mKtqYkoFkEXRLzthiJOslF
         1NSFTmjH2qGDur4eP9kelByqesqL/3u+d8uI+gnJ6uwW0NxaCDDSd+VI4lRs7LN50dLb
         Y5CF43gvsmnl5yjc82jDXC1vNsZn45qvtxEeo5sfLsHeg6KreKXdfw0TrM9XvOmT/KYd
         XDkz+vhDWAxql8v1ytLU+G39uZdNe5cUVooq/0uNdr4HfBLCS8aKH0iAYrevuu/oU47P
         0N0fpKdRTeVUuIBYpbzbIe3doD0ou61DppPhUbhhKxXbzqH3LGEhiBw8W42ft2U7inpD
         LhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134348; x=1779739148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JuxO2Lql7WOYtQqTYsPDr6cFUc5aNGEjSHX7X/kREas=;
        b=aChDpotyau8UnTDg1Y0ZOBZlmLUlcR8oZcsiVq5GlXMkmzfzjKKOGFFdev5Z8uS+nR
         jKl80jV9xUQypZNJyg1/WbbwoubE039pp0xWZSqzbHsebk4zr2z91hAGzmCaF0xR3Wva
         KMZp3UdIsK31PumD/ePUc3bc5byy2kS/g7wyjqYO0Ma+cLbyK33j612IA8Jj+O+eUDzl
         3w7v8FEeQASx11a6XbHm1JeWWe8PGk5CafxhnpTM+DPqIj8zpNVtoF3jb83KfSRFqhvr
         jm7iNEHYQgJpkSib7SiO6qZ+2+FT+uN3my4Qmh2dIasMoxh2V40Gnd2uFU8tsZo9YVg6
         dJeQ==
X-Gm-Message-State: AOJu0Yx/p894rWlV8y66AX5KQLIXI41Yj/uunCUMQFbaGXvRySrt1uqo
	DVeI4WVZrxoyivDXoNd29RD7Z6mR1lHj48FI++yb2nEle+47XiaoumsfxbsypfjnI+w00h4JIOV
	73LS2h8C0hRrNQDTFXmbfO5W6PngyLtJwjw==
X-Gm-Gg: Acq92OHtlQ6282o1SDsWL+YQoU8n8KLrHdCQwt9J8d7QnYPKqFwocLM5o1EOQZRO9IS
	cY0SGFQQrQ/PJV/Z+S+PGU6NX0klBy5rn04elDqyctgKgg/IqFgSj9o+CS9eyDp2JQ5+d3hHPxt
	3kpSf4Xjdf7Tyc2hfjJSUjJSNweQuR25j7ha77bu6UdbqqWnDP9fwc2tOPlloG7msinWvXe9ZFP
	4645KMG/RltoiUGfDU2yQ6C2dR5qZ9HdaEnfAntxtyiuMjthSUskp1LwepfUjDJNnrNOjGoch9F
	Y9x8rJo2XgtExLS9bg==
X-Received: by 2002:a17:902:f788:b0:2b0:61c2:8e83 with SMTP id
 d9443c01a7336-2bd7e88f4a9mr179255995ad.20.1779134348467; Mon, 18 May 2026
 12:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513141316.38335-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260513141316.38335-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 15:58:57 -0400
X-Gm-Features: AVHnY4IMJARZoENUV2JQL5N1kASQE63-s-ljmIHLk53bU0ukE1zdzMleKR5FQAM
Message-ID: <CAEjxPJ5FDTvpAndCVFLamowNTON3ooudKX3fCyQnBBYouFDoOA@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: prevent path traversal via -W/-P
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:13=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The -W/-P options specify the wayland or pipewire socket name respectivel=
y.
> The option argument is then concatenated with the runuserdir to create
> a pathname. We don't want to allow it to be used to construct arbitrary
> paths outside of the runuserdir. Also, check and handle
> errors when bind mounting the pipewire socket file.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  sandbox/seunshare.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Merged.
