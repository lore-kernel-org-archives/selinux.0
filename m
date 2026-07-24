Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601243F8CB
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903989; cv=pass; b=HVmpPFLiqzVVcSPa8/bjQ3ctk3v9NAYvEg/1CLv6X9/TAW6Ke9ubc0xpssNfQkl9zdjjmHvrug57MQ9HSmZYk9txKTiRju/FJTOsX2MazEcoO8pIC4FiB8kfXVZnDJ95yNzoiXpCH3eNqVg0oBzqShRHzsQUWEle8ZiZ9oAPrRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903989; c=relaxed/simple;
	bh=ZbqkJ6fHx5CRLzmoGYs6bPuhkv01gAwccRcrBK0J5GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7fIneFCGEhHT0rvqVSbDjKvpIxSW9dn2h6DxlwRHRvu3MAycUMsKceHFZgekV6yPvck+3fk0ciRXa1Oj5aA2nAvko/dzkiteXvcMWKch7Dcv0X6IDduWjKVaDagLT79OGPk+HE95wX5U5AhArMtdwVaHICpr+B4Wfc1VNpvk5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFxX9OSx; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFxX9OSx"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0c68aa31so4671521cf.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784903984; cv=none;
        d=google.com; s=arc-20260327;
        b=h0sKY2fSJnN9P+ecSD5x3hZPN4rFCvaKCsFWwjL11tUNwpsmvAsKhJ4VaRHc56PkMj
         l5aqWXRb1QvjxTf7XDQ1fSX8/MMI64AH824Y9P85Cjlut2P85RQYkm1cjbxgiY2CbQBb
         s4s8KBt5iGaZrK+B4KDLTznghbIvTQepzbGItWq1/avLdn/Vjcvz7U4fSxHZBw33ldPs
         ozqirHMi4wU7uijomh2+VsTRWukFlfuMveoXovHCG4mH/fT9DPRYMCmG+6mG7m2bmBw5
         waCZw33j3DPQNy01TftH9cvKjeGjXQa1eNlQVt8taYeeIhOhyXPZ25KPvXXK0cobtWKL
         J57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zD188ymA960g7BTHvocGFsQ3qlqeXsqi6nKn6VlqU4=;
        fh=oc+ZWjIKTLBECfFhcL70UkWnmvkI+a+RZx6RWyD9DFg=;
        b=LvmDdGT573wV7ziMN7VNMjy7WXIwmk+fkHd9m5Q72zG6Ebk2d/RYb5iTf5pVToGG4D
         iR/D5RouoswfJjpCM69rA0DZuHML4C4qIQaHrK/4tfaucvVzjOToNmCQkhKbEll1DbgX
         rAAYDLZQLJBZZuRcXIdDqh47yNTv+nsmiZt6WUjJZF0l8b0BB9ISw8iNJyqrreuR7SXA
         qEWNsu+GtZKAm18EmjFyK0hR90zNlVk2KMx9PkDGwQfSWqMCUJsPVvEdvbeUnP+ypyRq
         LtG9X8m3l/SHNP6jBH3WSlwwE6lL0ZQYJHjPiOVQ/ThwWxhn9NaQDDnqRQP2apmJg/in
         QTGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903984; x=1785508784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7zD188ymA960g7BTHvocGFsQ3qlqeXsqi6nKn6VlqU4=;
        b=cFxX9OSx40+NmkeX81j0axCYjzQZh+D0HgP5YNZFwUQFsLGNb85sma6QDio0+bZP7c
         +ZhcxKPyrjjL2HhMLIaaOzeBcyCVjwDFbVjbNbJQpDBAq0clZbKCFAKfpx4oqy9pTy7e
         +9oZxilQywpIXQoeY6bGcFBio7g/5BoFpHyp90H0UDtv3bmxDsouBemfYrnnxYJvxPYf
         LR22JeSI1s6hWpiNTMz38REuTzA7OgZNx8257cEIuzWlChMKMAth9c0R0W9wTKDujD5S
         cpeE/q2/nzBrH1IljG/baJEZ/CgQT2MpamfAJnm0gz/gYL9rBB2iKa2oF1QFpFq+7eYn
         h0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903984; x=1785508784;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zD188ymA960g7BTHvocGFsQ3qlqeXsqi6nKn6VlqU4=;
        b=JfawT5Ahjt8mUH0LYnbRWT7wC/NdXYKys7aLnKuHXLfaA3N9JzpJRfpNesZnkXe3uA
         koZNQFlCXjHsArY7/AnKN2sane5ll1W2DOibe+4d2pJA3hn3a140VaLtamYuosIv0DXn
         ETZPJHrsaPfK/29CEI5wioIxj88TqUxzxEa00eM7U5YELAl/Cg1234Bd38PgEQi7e3nv
         gwvzH0+hvGk7FIdJA5+6MW+8F2D1HGAoYzsNZSlPc09iFABH0t0R6QA2Qcuvt+xY5sGt
         RSCforZ4Pv+SkwX7d71Gkud6sktlEY7A6uHC+hbHDl1GeJbUs2q1uvMECedRXQP7TrS8
         vGFA==
X-Gm-Message-State: AOJu0YwG1e3Pie8n+rPw1Se1js7oH8MQzgFYzYBApiDazavgMjbsT9dr
	2nUlZKFIT0cib9XndHI4J9LkyzBe0/pUGj4fL2E9wXOTFMb4SrDZJ5JnKOkBCV7Ncb+NL2ZFwF8
	UekGInvBL6wQ32kf4HnhBhxCJ2QVzKMCtHa+b
X-Gm-Gg: AR+sD10NbL59oNzYPadbhkBROCvXjdiWfC+lAaa9+AC+wJH47g50dEusU+A2B9vCksi
	68zXgmaCtImaNUyTJuOZ+FOCFLRfl/rp7Q6LDYleF9bexndV9GRKCkDCD4ZZpAY/3aeLPjEf/fA
	oWStQihxt7mdKSq8zBJ1+yhaYmnB8dMjiY06+YMRUrWU9aTe3poYO+dWQ+y6bNXyqpTdJl0Pwlr
	dAmWM0G5sM46aHZAQ8YwdC5wyB8TzDR8cZY4Lwcr/eZlUO/07enjQlQv0zlIQ==
X-Received: by 2002:a05:622a:c09:b0:51a:7d43:9392 with SMTP id
 d75a77b69052e-5283ddb0700mr72683461cf.8.1784903983894; Fri, 24 Jul 2026
 07:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260721185357.64896-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:39:32 -0400
X-Gm-Features: AUfX_mxO4tLjkb65JXBUvHFQDaaZL4DovnpGxmwabtxYSBKzTy-2MrZrvRoHYEQ
Message-ID: <CAEjxPJ7i9BjvZrvrEwuTLX+wuQ0cz9uC_so7xNsN777TU1EB_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: add pyproject.toml file
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, cahu@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 2:55=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add a pyproject.toml file for the libselinux python bindings.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/505
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>
> NB I don't understand this sufficiently to fully migrate setup.py but
> hopefully this addresses the issue?

Evidently I didn't test sufficiently. Reverted since it broke the
testfarm build,
https://github.com/SELinuxProject/selinux/actions/runs/30099962012/job/8950=
3238013

>
>  libselinux/src/pyproject.toml | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 libselinux/src/pyproject.toml
>
> diff --git a/libselinux/src/pyproject.toml b/libselinux/src/pyproject.tom=
l
> new file mode 100644
> index 00000000..dfc44e81
> --- /dev/null
> +++ b/libselinux/src/pyproject.toml
> @@ -0,0 +1,24 @@
> +[build-system]
> +requires =3D ["setuptools", "wheel"]
> +build-backend =3D "setuptools.build_meta"
> +
> +[project]
> +name =3D "selinux"
> +version =3D "3.11"
> +description =3D "Python bindings for libselinux (SELinux userspace libra=
ry)"
> +readme =3D "../README.md"
> +license =3D "libselinux-1.0"
> +authors =3D [
> +    { name =3D "SELinux Project", email =3D "selinux@vger.kernel.org" }
> +]
> +classifiers =3D [
> +    "Programming Language :: Python :: 3",
> +    "Operating System :: POSIX :: Linux",
> +    "Topic :: Security",
> +]
> +
> +[project.urls]
> +Homepage =3D "https://github.com/SELinuxProject/selinux"
> +
> +# The actual .so is produced by a custom build_ext (SWIG + libselinux.so=
),
> +# driven from setup.py.
> --
> 2.55.0
>
