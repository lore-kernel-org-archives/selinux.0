Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505651B17D
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073599; cv=pass; b=lxnRC8WU3BsAMF4f2UFFnSHtdGo81DUQrzBKGJC9mxcgW2ELYalhBUFiZff6HPmediHxyleq3ztbREWfirjVIlNqxbHQvWmwn9/lkJHegnBuGH9az64Kzd5r85wTp5pi6OBZ+UQ8fgjgj2/PezVwyrStT0VtnYrANbYvIMoFEmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073599; c=relaxed/simple;
	bh=nWPLxriYYYYKXkpaFXYTtlbjxbVfEmJrHLXHA8heahE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLxe6OSriGuRyndsCtwsNrnNoB1UIQv+rzgt6MJRKKHhjIXczJUfTSFIZCslCctC1SE6tPlou1uYcArNrGKYNW2zvd9OicJRFAnupa6OATrjLD5xmYMK6Vgd/6PddiskAcKHU5YQfpSXizK+Lw8/Vbp3zrJkDd4eeLtAXZFDmRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN53e84V; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN53e84V"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-679a2b5fe87so597562d50.3
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073597; cv=none;
        d=google.com; s=arc-20260327;
        b=baqw3wVv7D+L7u+c6Ze/C306//yHrsJ8hBPqRvSqqQba3NCFDFZEyMH4Y5bWyQvQej
         nFG5s2HMKUB7Fik16Ll8LG+BoGdXyevg8yZgsX5M3pl2rZqPLFDIUh1Jxutnpl9sCZDu
         w60ifL8HY7z/Kw8yWsdaBmgyMWpzmMOJOci5QMXVLYs5jzZIaRsQPevAxor9cAmA73zC
         R4z0MuxZ+8d0a9uy+v6FXZuiijewIbdqvgPzlbmTUcgk5pRnWLWQ+Y2FBiFitcq5xFe/
         50VCrkDHnYS2AGjmygjCZlcacmbPn54YLF/0+CzgT1adzAo0bd+2/qzO9XuHqu1OaM9j
         P1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nWPLxriYYYYKXkpaFXYTtlbjxbVfEmJrHLXHA8heahE=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=jMbYAVO9oT+N5xZhDusIUBubR1c4iooUAX/DTtX97tI5HKZGME784YO4Ff5r8/Gry1
         O8zBPwcZ4QUV7Szya4Uf2Vze7KTA10B+fTi1LGg8uY2SE+0HW7GAGFTjt4cziNPFiiJ0
         oYAVQMENC9ZqpECzGrewCKOIOPkWcrgJwbdTk4hRSUTQ0mxa1fqB5XOd10jKNkZnCdD4
         IYANpijdzi7uHN4XRfJSHo4IHozdAYzXVkEeQs3D5byYrpTkEUAdjEdWs8LJlwyodO2M
         MSwsjlAZxg72CKGGq8gea1wRngZyckKSRgNaqijjuVsE1JsFFN8miX2vePwbUORscXdh
         7Ipg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073597; x=1792678397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nWPLxriYYYYKXkpaFXYTtlbjxbVfEmJrHLXHA8heahE=;
        b=IN53e84VYOuWCqnqoQmeSwUv0xH89epGC1lJlXjNuzsvHRYKOlyMdN0oxRveUez6fK
         ftOCPsVH/B0p0CUgpK94r/Pe7dWlulG/i8iXuZdgRuCX3yktd8G0PUTdv/rrcQaorcdN
         9UUvdGbvFZQtYgofpvoJTYDn0lYtSEOcY9w7lmqmQl1C9nz2YA4DYX7cRP41yeaoTxnv
         3dEBhBajQVNatsO1DLCmAN66E9kwqk7CiI+JE4JUw/xODWzuvuwZx+710ezNjTN2rLZQ
         s+/94K4AxLWVtaTKsl8QypnP3ANB0ELwVq77SWg8ITz3We1/aqKtqDrxCqFcgfkQMM0Z
         Ypuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073597; x=1792678397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nWPLxriYYYYKXkpaFXYTtlbjxbVfEmJrHLXHA8heahE=;
        b=qGCq0j/IPr3Ep4rzVkf8LbVg1r2pjsPP9eJns2o+9m/e/UtKEL+Rm8hnA59hci/xsq
         IHy/as4DjfdWF+on/R2FhwzwLHL+8vhxr+Omcwn3PnJODJzc7wB7wWiGiGIEKGrZ+wp1
         uao9EdwFGA3FBg1EQdbIKAqcUY9j12xYaCuIZoFDYunsw2oHEljaJBQWJ9aqog7/AReZ
         NU5AQ88UDdWg//Yos1qjHmgilRFnQP6zhcgBK+yhFr0QHDpUWaBKL9nQ8Ecpg+QH0JOH
         kBpjbmJiGUA0aqpHrryl9JjsvoMdmMdXAPGgG06uJV08avpUm54JN/y8+JfpzA/E9HXB
         1wtg==
X-Gm-Message-State: AFq9FYKe0ZLO55/rx3GAeutrQtaW6RQ3MJoKjR3A9g1rhaHHX8vScprV
	1xgoJ7Fx0rMo4D5EgCgll0WW8ay1+ndCWL8bge9LlQgMJM8Gi+ClthOPhci+nGyXa33S1I7dxvx
	NDsSA1dnHWOQcBs0nkLZFlYiKSGhxm9w=
X-Gm-Gg: AYBFou0tsdx9wIoxYwX/eXTVXHWWnUWclF742L3rerhNzkNE23GCZskndvb+0o6TqP3
	UYwPRL5dQnQOTeRLjQqS01SDmmgkt3ygPUYpnbi9oyL440E9qIBdPbBdrDYJ5xVJe5pU/wTNyIv
	Vm0gOx8qQWaQudALSX97cYSaBauuLyYRVfwR0wHaU8mq3Nzd5rfj8IStT8Imu2dK5eik2EA4LDp
	X3ygU5CISzU8JHEc8Al3uvQG9k+UvFwUQpJtqpqaEMG5NwY4pAKDTpxl58zwi0QjbBywD9ZvMJu
	Kcl3FYYctwHaG4zwcIQRN4gK/6hXXUth9ugC+sqT007HRS4QYTPZXOU=
X-Received: by 2002:a05:690e:1447:b0:677:bf19:f06b with SMTP id
 956f58d0204a3-67936262ba7mr6600883d50.84.1792073596902; Thu, 15 Oct 2026
 07:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054932.845406-1-omosnacek@gmail.com> <20261015054932.845406-3-omosnacek@gmail.com>
In-Reply-To: <20261015054932.845406-3-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:13:03 -0400
X-Gm-Features: AclHuK_FZAyhIiSODIgeIfs57E1YAoKYcNc0zglUZdq7CVHgQwDs64MxvgqwQgk
Message-ID: <CAEjxPJ4QirKMMPUUvGVZyDQRYvsxjuQ7Ya5Gt6CaDr7-9169=g@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/4] tests/perf_event: fix compiler warnings on ppc64le
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:49=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> Use the correct format specifiers and casts to make sure that the code
> compiles and works correctly on all architectures. This particularly
> fixes a compiler warning on ppc64le, which is now treated as an error.
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
