Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A81528446
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073563; cv=pass; b=q9dAIszwGWc3pS2FYC7pBUMONNoeDSXsWD+pB30wYk2Z2MusUQ42VOuRlXwDf1fcHeGuhMFF8GKMJOaSBr94HG3Jl5sX0e3+H0MDnyEWHituiXvYYOC9P3drIVZFNTM1CsnDfTbjdDSbbBvNhr2WGFXyXdySz6vEEgD6LzmCBhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073563; c=relaxed/simple;
	bh=g8gPjXVoSNNHF+4+VMeqXwpiEwlB6SoBT5a50XXhDok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blYQKOUGZINzVLvyc3tvY/w0hls/d5TlT9uKYbKyueNWsu7VNGTJuE32LpxWsdjyWGKDoQ2jmmB0rTat0aB+3umO9HTajoH6yvCHc9eVcskEAl0YqkYkm3MaVEydGa8IaQxUOukEDOler0JQQtiFNydwIhUYA0kYkZOKUCPbtfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAoBDRjL; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAoBDRjL"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66fca0709caso1476882d50.1
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073561; cv=none;
        d=google.com; s=arc-20260327;
        b=ZonyiyHPYWGatXwsOVze782W7HWRkw2RR3VYgesCv67giJOsbhxwoSI9dOskuvyeUA
         3rOhFBoV6IeewFpDYkgRTWcOIch7yflScW3SV6faUjyVQAvt8qbCWDEcusdVcnTLdYNt
         1WUtniZTkG3tSyflFrg/mvL7xzkzDvPMOVC6v48e5FceagJ1RB+uJnza+1628b82P8B4
         /oppHbcY8opUxpDrZk2CbmG9UF7Aq6NJxCwOFUvRHzfgIE9xxtu9IDRO3MDcTblkNON6
         nAi+gB1elks1QBlGNBlECL4/0HZo+61IqPYnHE9HMRe9BrNZ/oWLXPloJ2AhW/qjXOhl
         EpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g8gPjXVoSNNHF+4+VMeqXwpiEwlB6SoBT5a50XXhDok=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=hi57cuKKtF9ug58f8RFQsxDIQT+hTtwihHk/pdOkuY7J6EzIvc7FwUpTDRrTZAXWzO
         3JpYYqAEY/xXZck4qWXDaJ6T3Fh0urhy34IJlNaCoGyZzXhS6Bla5B2/DY1tFqG4R0/I
         KqbiVXzAJCcjeflJ+HehI8HtdMLe9kKHGJzaEzLIbmREZNW7vvmHBwnFoPJZdBFkaw1x
         g2kZJHLeIJ65GAJUCsUiptISwJcv8i0xzafGwDX4I69Ha7HYn754C/5um1rdhHsoK3v/
         HVhLyvWpfLXMeAEUskvTmt72ViorJJT5dKsK2hQhNpbSJJLxUcUZqrJ0GiF69phEaLl2
         KO8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792073561; x=1792678361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g8gPjXVoSNNHF+4+VMeqXwpiEwlB6SoBT5a50XXhDok=;
        b=bAoBDRjLahU4bGUBoBoXsYsGk0vC2FIq42TxKVoTNPszDvOfSWBWLj5v4+LCZC6oZm
         mmDVuhf7G9rVLYinUcKBdS2ITtQM44ubmdx8EY4gzt0QD0qjcFare5wr3tY967KdjNen
         IEMgxn7ImaoDhHU4paq+VkyoOdTesX7uQMiFW9SI/3ltoar2OP4VwCXo9AuIQQCLPqNV
         ozxKj66SZinIfEhYptuHuaI2j8XOmRi+j3X8glZXqHnkQKJqu02ZbkHjqn1vPAv4yg1r
         j3DM0jWiQjP7R+vWrhjrjG5/mBOv00GvwLlZxQAQy8o7h73hdtW/qWipq7baxUrWNON9
         B4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792073561; x=1792678361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8gPjXVoSNNHF+4+VMeqXwpiEwlB6SoBT5a50XXhDok=;
        b=Tz32LbKHtWMwa/CEnbmBJ7yz+bHDJBWVY7N58UoxxMu/T4LtD0oc7o9eXEUvo0/jco
         jOmkeddbejlORqJm9KDH+l1pC3A+FPDEOlCdOHXuFf7mwli1KrzKSZk0M4dPew8+9Ff0
         pRc6tC7w1R6TNInoap7M+rN4ZKUoL/gzBrUqtsTQbMzYepZ58QuXaAAt2r3Ko58CHriN
         QQQyXtdjqVWLErAMd7u5eE6VKeQt/GzdCaLP7gUqDeCuNPn9sZZV1S9fGzjRHPesdDD1
         q38ZHknuJlzkkcrz9dw+Vp9srBLrJdAgPbdNqafV+5uAE1Y1wH7B8WkmfL0zAKryrwUi
         7Caw==
X-Gm-Message-State: AFq9FYKc2yzO6/FFWBHsDJsXeQ12WcynYSa2wzWkYC+fCU5ljGGapv4Q
	1BxE05XNwBvbP2dUav2MTkNlllvGrwfm28cQ5LEan+GFJwRBCDqBdyQGqm+zNheXcWSVbg97Z7t
	etHjRI/JJYvsuOf5q+usaO/hIPJODAEmi4Ltq
X-Gm-Gg: AYBFou0xO+Lusi9+aHZStuqItKu/a84thgKkVLjGyMQVzlON4GTk64D3KPRe1LmSnJm
	X18jue17jRDg+i0ZYExsxq7RdAqr1P/P2+0bVDFmrN2sTWXMq4uw8vXHSNPEniJkGxbgfGVJ/Ei
	w6O7fV/U/RcV8CdVr+2iagEUoJqmVhJe+t+EKzrel/Pr0Uhi0k1W2Z3XytYvIQe+0B3BdNODJKO
	caHXzxn4tqgWWcxN9Yh0qZBUrU7+7hombzpI1/nx5ZI0WQyg28pYscZjHOWa/Bqh+CWW2eeyzHP
	CFSLRwtE5QgPZWcgR71D764FflOX2/IrfjzefoXVSm+HgbRM+HlbZ4I=
X-Received: by 2002:a53:ed52:0:b0:677:a948:8d6e with SMTP id
 956f58d0204a3-679362e5029mr6787256d50.68.1792073561300; Thu, 15 Oct 2026
 07:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054932.845406-1-omosnacek@gmail.com> <20261015054932.845406-2-omosnacek@gmail.com>
In-Reply-To: <20261015054932.845406-2-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:12:30 -0400
X-Gm-Features: AclHuK9KUuVUqYjmUtEQDNfO2tpskUWBAXB6vUuZve8okRoS3ZRQPUWeLYhdIjE
Message-ID: <CAEjxPJ7sRkVY8zsbmwMp7=Wqw-dHSXPojii_20C_tgL2z6hTgw@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/4] tests/binder: fix compiler warnings on ppc64le
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:49=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> Use the correct format specifiers and casts to make sure that the code
> compiles and works correctly on all architectures. This particularly
> fixes compiler warnings on ppc64le, which are now treated as errors.
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>

Non-blocking nit that can be fixed in subsequent patch(es): client.c
and service_provider.c still print obj->fd / obj.fd (__u32 via struct
binder_fd_object) with %d; same class as the handle fields fixed here,
might fold in for consistency.
Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
