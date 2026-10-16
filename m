Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F930C161
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161957; cv=pass; b=jtunTStaERIn7kg0txahA8F23jw4Pvg7m4vl6i7svS3vsaRoRvumY+vsvmxfGAPMVGx5IRd/O9MbF2rvkPt7HUGgv02EpHiu7wHXrYEnet04KG4d8gl2XfuYebK0f06kf9DAkDvrNLLSV6CFYUECOgppBGEU+iSiu/GpTqtlovI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161957; c=relaxed/simple;
	bh=Az9XPecRd4laWLd+j4GUWF90IMFrh0YBqZqi1hb628E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojjZ4vFyENlvIVtSgONFB44KMx8qJS7BQ6x6CVoKYa8DQTcZIFY7O5Iw0A65MsON2MBvh2yeRjYBqxCCeXJpV/eoK+xj71TKWLc67hh7pgRpX8rQjRPpF3N2DQ0/4cEliDFvboxh42Qpxznd4+eOrBFZe9LSDu0lagAAkj9FmcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAQI6d5M; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAQI6d5M"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6714595153cso1031180d50.0
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 07:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792161954; cv=none;
        d=google.com; s=arc-20260327;
        b=aWDumXHAcjMfVHCT0KYtWK+f+2x8c8pEJsrI29gnlzvIOgsdJ76bcnmmqpvSoLisDg
         ux5XwhDXtdx6Qu9OOLQ+D7Ryyzq58AhsBhFNt7eueGenx2SlQh9rq9ScqM7WODkiQIfU
         fl8SULszf8R9QBgEVaxbS7YK9x1NfToQ+o+ZYU+CIZJZUffbiQqf7su1cuqlZO3nlC9T
         ZKM9TGW1jSDOlbsSgHTzgrUhwjdlgleFTSBYypTHmEM/eUtL+XhhitGkIW5a5fFJ4DGf
         7DGxT0iPSrPazf83CUuYLPe26mt2Qwf8UOOt+jPrVFS+JzyKD83r7ryfRvi2iYA6jq27
         xIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Az9XPecRd4laWLd+j4GUWF90IMFrh0YBqZqi1hb628E=;
        fh=gBydrNMvjriJbd9HrIy1Xz3jsVrETImIXW7v+LTQWN8=;
        b=U88oTVjD/LrjjCTfxXTW8sYOQPfTCaN6WBktUD798EOnTehMoHk3z/RnLCdrAlj5sx
         eOMs87fYNf0+rNBnQINfI5Hhfc/nJMMtMHqEUHSIYw/+QRNqR4vhWNOzSdeJjKthcMPT
         cH4f7lDZRKT/ZV4PW/ZlW77NwToNZS3UvD6YRFT7ETAO6OeTwIuVjEvL74c/RylcVCJY
         5u4rlUxYuEKmq7V99R7QV0xjv7OoUzwVOIajMdqqjZNEhb+e4X3jiJQEPaC9+DZlka5K
         1NTdKNRQAS8kNOK1g/bMVrthX2vbkM8QKQeBk3/O0r+IHA9N7B0oPYuctYcp8L+CDuxy
         O1jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161954; x=1792766754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Az9XPecRd4laWLd+j4GUWF90IMFrh0YBqZqi1hb628E=;
        b=jAQI6d5MJz6GmSW3xkmz0VKjewNylOCXNrtqmH8iC0muIm0rKL1TiAbNGr5ms9wcBP
         7JbjXpUTJWALb/t7Hu531hhBg2dH6tFKJWKWYPQfQ+f7k2Eq/QNBPdnu5L31LP1N23cV
         1JFq/sC8eUdC8Mc8IPk2vUDhx1I29hLYCzPRvsuokV8Pdp0DeLr4kl96wA0gW0mBfqTy
         gPkiN0GSVfD41ptHvv9uBxkYL+9o4mgkqtl6/5B4/3dxYaJ8jUqZjSK7yf/Vcw41BkdH
         +JJjhgKMZ0qKZQrh1lEDjCTiKgxieljoSrUKcPH7BV2MrLj6URylnImRwG6jEMJ8/woR
         B77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161954; x=1792766754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Az9XPecRd4laWLd+j4GUWF90IMFrh0YBqZqi1hb628E=;
        b=iZpYYab/lkZ9HFoV0kFSIxR7CHvX0VLGunbuMbl1mU6NtwwpZtNz+BRUMMqrH4cn/Z
         hP5owjB1UeLm1wYIlTbtp6SJgdMwKPDOXOYLENKTfBmmD/scFAQKQZjPqzzNyq5AJdJL
         OArTIDY3uBN8pr8cWrw/066YhmGUlhheYnwhNh9/oV8ac7ATw4lyKP1E5yquD6/6chMr
         GPozEbfL7qpP0+pZYPzl1uPi17Ziy3K1F0kGq9ZogCGpmgM/nMqY6ehZn5DbOF3fFkaE
         NwAacvo7kWnZzXppAuu59mieFzB0c+BiDLv9Rj9gq/bqs5UDbpR+YcQGESxBvIlZDUfN
         Cuyg==
X-Gm-Message-State: AFq9FYJ9Bd+5aFd3014a/+KVGmy/FnQdMc69LdaXMQwDw8Kw0W6uzG9y
	BkTTpsSVZJi5Ef4VqzX6W9rzKVJUm/nOW9C6YkbfUTSB0zOtBv3OR465vQm+zyDcYEpP1vzTx21
	rehSj3DT396J32JY/BId+sfqRWs/HVmXiKA78ZnY=
X-Gm-Gg: AYBFou1OecCZen0sW5ggQFv093taRYta+y4TvHyJWVEru6w4ZNlVH+IyofmhP9h3VsC
	BZ/5tH535EnP4fa0HseVNK1ifUBo8PVXsUZDS6F2pQWR3IxCycxoTNdwCHkQvtNOE8k8cMQADHk
	nFfIYMqdvkD5riSaUi4d1djvfk6RGdROscOGlCBaj8E+3JNpTYqUNl309mx6dbpdWhcUcrNCW+y
	CvB9vr+/H6q1rk0aXLfnM1IKnejlYnv7SCrF8w3X0WtMEz/A6HNlvFHK0dt6dGk1Lo61Jp4J8tw
	DfHlO0bOmMIga4ISNqVNPuT6s8c2jKnSdsUC1iVgNpIcqWQdynXDD6w=
X-Received: by 2002:a05:690e:168c:b0:675:6330:caa3 with SMTP id
 956f58d0204a3-679b1094123mr1152361d50.42.1792161953742; Fri, 16 Oct 2026
 07:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015014457.877322-1-tmz@pobox.com> <20261015151422.1057210-3-tmz@pobox.com>
In-Reply-To: <20261015151422.1057210-3-tmz@pobox.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Oct 2026 10:45:42 -0400
X-Gm-Features: AclHuK_Up8fEC5DLZM8gONONJ86vCwjErmd7TxUNr2Jep-KNLhE2xS5Y35NpvI0
Message-ID: <CAEjxPJ5UbCRi3p57i=mRssKD8Et4uyBYQEiX0tY+1TN37mNyWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] libselinux: add -i option to sefcontext_compile.8
To: Todd Zullinger <tmz@pobox.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 11:51=E2=80=AFAM Todd Zullinger <tmz@pobox.com> wro=
te:
>
> The -i option was added in 487d652e (libselinux: sefcontext_compile: Add
> "-i" flag, 2016-09-28) but the man page was not updated accordingly.
>
> Correct 'info end exit' to 'info and exit' in the usage string.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
