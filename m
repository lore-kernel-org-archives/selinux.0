Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37B1DDA09
	for <selinux@vger.kernel.org>; Mon, 10 Mar 2025 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637322; cv=none; b=JFby8NBViIemKZXD/Ekc6PSg8fC/ZnTMQZEIXE/OvXC+S1ehkyIDz61e5LE4G3I5nCul6kyYFjMZn1Z9gs1z5uz6livS77PlehGjZbq/EpWOTxj8kOt9EhgwIdwiPe1Nfv5ag7U95+I6GIu6ygYbYjivkiUAQotic43JjNQwPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637322; c=relaxed/simple;
	bh=60peOmmBBj7w1CkQZweTbj0V7SH70KRjA7q90nSw2GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feRDljJFMhgDyu3glk9oKB8IaCQkgleexuZGGdk6haEyMMeN5nOC+PcRnzfBfa6GUv6nUIJghkcgBWB8aXJAPF6VYZv8k8DEQJdfQGxxN3DL2tNvVtBlrupYByTzq8vdkU2jS9/KE/0AXEswLVcG+eT4iMHQFU2YnalRUjbpAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TyHO0lSo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TyHO0lSo"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fef1d35589so13624167b3.0
        for <selinux@vger.kernel.org>; Mon, 10 Mar 2025 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741637319; x=1742242119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgerTX3WdgiK8GtAEC0gKD4oCmg2BHhmtdrqlR+3kQM=;
        b=TyHO0lSofRquXDSPQXLicU2cWV70SnQvWg/lKmi1/rUmKTahRXdR31Tx83/2I6Ykgp
         ZV1b2cmgHTxrBvEY/KGwli1v5O32Tg9Tn3XUeMdrk1uwa5iY2QeGcfENAWKVb2vi8pqx
         QYKSuHNOh0/cb21RrE+vkOMMx5Zym5U+807KUa0XKvMb1TBYWxMJYjXNS/1gl9vgk+W4
         4wfvIZr60ebi1NtPamq8zHp+8LavmzFsTWibLn//EBg9Qh71eQcXoH4m5yiAEaDQ+4yc
         BQC3o3vXX1G9CovalWEqtLEZGJYoqfWLdslENHTjwNbrhiFZtLJjgwKcXqAiuogiRGUU
         UCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637319; x=1742242119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgerTX3WdgiK8GtAEC0gKD4oCmg2BHhmtdrqlR+3kQM=;
        b=rEMC9No4jaJrPYj3k7HUJaNN9tmo6wkPG4mPyH0QdXwM4p9obyloKHwfnwvqPBm2YL
         i8hvCbUEQRERGIxlSPw84kN1CkwH6iJbBADWypW5VnhZPcfNauYUkpuOBWjXXpeOZuyh
         5ZPi3dCuF7U3gBZy1tQNnf8mnoS/QFsoO6Q2yIzIesyv/pLOpCJyQJGW8SCZCdATXhaO
         ik+kGy9ypCdxSYjhyhvLwRlh++hY98xDTYy24UIiOUNZNq1U8EdmhG14PQk6GJoEH2pY
         KN0/V3VpKLqy9H/cgfz1t1A1DQmh0PqSSbqm3WlgzLtsf436Gvp6y2z9wmaCt5Ze9I+J
         K64A==
X-Gm-Message-State: AOJu0Yz1vNBNmHpaUpPnHO4klsG9HKeiP7jkOsRQOKFPXeWy9p51bzuJ
	qRJ/DdCeqZ2wYYS1u2iv68mQfniXtdz4LFZNIXXpZJCjoT5BHUcppoMqzzQAsNCbZe8OeWdUQpA
	cZsJ8aMWjjDC1k7hKziZ+nclGRCe3j9AJm5H3
X-Gm-Gg: ASbGncuuA/+7GG10xJSlb7xfWHAxSUfJxoiWYxZy9dvm74adn2ZeSEvrc9STG8ofGt9
	N3iEF6Vj1UfKHtdjNWM4uuSZsAT4cG+nNGH4ZdjwNs2vkIJ9z8bK+nlbnJZC10GZMcFIkDBgNyZ
	+cAz6KTcjd0QhO/lMLI5kutfV2lNiO6ugfLqRL
X-Google-Smtp-Source: AGHT+IHUjHWRMkMB5pC0rbjyVxQ7ztNxFVAyHVaAABnD1q7imiwwPZbq/35DMolSyj83ZUIfBTKBeqMLBc0WtAi/+34=
X-Received: by 2002:a05:690c:6e0c:b0:6fd:63e9:a441 with SMTP id
 00721157ae682-6febf39bff7mr196627267b3.28.1741637318999; Mon, 10 Mar 2025
 13:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310135404.22385-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20250310135404.22385-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Mar 2025 16:08:28 -0400
X-Gm-Features: AQ5f1JqSxhBarBDLcda6XgeAb7H8zF6ASTx7BVIneybmmX-NB6f_Ye9b0VXDMbI
Message-ID: <CAHC9VhTKubg8BpVVgZb_d=cu=zWY4E2Ax_typmL3NPR8kkNsFA@mail.gmail.com>
Subject: Re: [PATCH] mailmap: map my old email addresses
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Map old email addresses that are no longer in use to my current
> email address.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  .mailmap | 2 ++
>  1 file changed, 2 insertions(+)

Merged via lsm/dev and not selinux/dev so it goes up to Linus in the
same tree as your other email deprecation patch.  Regardless, thanks
for the update, hopefully this should cut down on the mail bounces.

--=20
paul-moore.com
