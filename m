Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CC46F4B8
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697106; cv=pass; b=lfwYvzcai/IXu8GKu6XaRAAx44ML4UYjmFt1I9hBFlKpHAidQytcurc6uN8NxGcHLrFv7K5lTi0fy9h/9cGtspH+HvGWS9w+ltUk4iHjdb9digqvGtAU2Cyn1KRLLXuvlpLKZnoxkSYsd21Q1ntzgkvxGYdChvjPdNsoLrkhL0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697106; c=relaxed/simple;
	bh=c4/0IRsIgRJneY3QzB9RfUeN6zc+HzqNfD/g6wGgx3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVajWm4bDPKpOlI14h2kwG1Sdpy63wsltqHimMoEOFWnOu9nt3sc1wkmmcU7AJ0kdLw18RQHRO6Tjt8XzOTVNMrpOVcsvwMZsfBNm36uNT9ug8fWSxNE/SfomXW6lrjWkVqQgzlKk+ivzoH67n2wap6ze8c9bEezXWqz6sz4hjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfPrU+ZD; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfPrU+ZD"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43ac8d1eso39829937b3.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790697097; cv=none;
        d=google.com; s=arc-20260327;
        b=efY1lXiKPyPaGdQ8VWjR1PKqXxQ5V16ux3OYjSmd4bRPa+qbg/CaAJpFKbenvopqqD
         HjlPEZ7Hx6D8ug3M3hIn1qTtUop0VVCVkqnj8QSYWb2AQ1RIUukigLLSaJsLx0LLXuV7
         np8ob77XKBNBZPx5P7SN5/BqANdGqw/ma+08aC1VYOFsuzsNc2SFl03WJFLCRNLuO6xf
         dpljS4GJgUNQkm8+hgDPoxCUehoDZbLz3V/oqS7eGKu8sNIcEtj1rr5425SuaXniEBtV
         V9ptBkRHrYPC6xJLVfZXAWcY01HCi1CBNdaNgC0OGG0KQONXRyKSwkePx/BRzAfIZMd3
         jSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PRgqVo4cSgbm5VB7N1TuVzA6vIhXvYRmi9EjsB5mKFc=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=i0Cb407AGaHJGYIrE8Bi7unI2nDJ8djHXkIluDVeiWJD6YewaVOoHtSpTkwpu+AF+7
         yTRRpAbgJImGzIpLdvAf9UYgqhSGSFrUcVsAxUN9Iev+tRBexkRPArlfyCNx0szuoh50
         Eqa0ABnZRqnnhkEbBMwNPaYJxUiXKak4z8ixQz6qNQJm5METsEmXMkNHZFQLC2ipuYfv
         KoLC6zK96J6DoBvGYuhfyMVawQrLp0V/Hage6iYYcPaUuwmfVKN8FuvJ5SlI2jn5n9gK
         0/S1rfc6eH4B19k7FzQMOjH6gtXh8zvI4XC56V5OhcvarM/7WmOwt7t09fHzZXlKWotZ
         qs4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697097; x=1791301897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRgqVo4cSgbm5VB7N1TuVzA6vIhXvYRmi9EjsB5mKFc=;
        b=sfPrU+ZDMx8JvSi067ZVVkIiNLRVQIlbWQ3nT/tlmYJBvKECVSLQanANLMycXWo0lo
         ag6oyxP3ucZeEgZQn93uqV5jY+PWnE42tZkhHZN7z+mp/sBY064Lqttv4RXR919bnZ0M
         IFpaS5sKSMinKl0X1m+38KZU4UA0LmUsvhzfkmVh62qyqFjCSDePMgGeQ37OtIWxZs1p
         tOia/69vcWWjEiSoYEOXr+p14a1NC2fCK8qRKgqWcQGlwxcDbiHcaaKzGtaxzDqV/DdF
         bFSt/Xuq3rNVEpB+KUs56gPX7HEsYDTla1/KBdRJ5++38Le1LZKkcmE8T4gqD2AI4CV9
         0s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697097; x=1791301897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRgqVo4cSgbm5VB7N1TuVzA6vIhXvYRmi9EjsB5mKFc=;
        b=EjIUr/N9YIN1zCjUaMiH1DxRjeLg9oIKRpib6QEkcz4YFuQtc7e0SZnK6PRFsb//p/
         X0tKQxGrAE6OA0pYtESoN4Krlx2JSXtWmk0mcz4FTmDENbHLqn23PqxtM8ymkaC48vA/
         eR6iO3DaGEIo59ZxAuO5thfCwsghfJKlZ11rDKm8nviAg4iQvEa8jqK/5MMrs+9b3fwP
         QPhybCy1munBaiHve8Ju82WzB/MsVVV+EBaxa24HhFsdgVxaJ+PW24XUS925nV7verkp
         DPWaz9MxX2CxlersHzr6SzcAJRPxM+syUya3VV/VF51U2YqeJzV3khg2snrntpY6UzcX
         FuGw==
X-Gm-Message-State: AFq9FYLsEDOeC5H8tcvIUXtXwXcsJ4UPBfbr/27UCQjBxuYENZBQIO37
	boNZWiCbpzLM85pwxPbZMdx4UpSq8VvVF5hH+HMppz3TtSh5v03yJL5cUnJI65ogarEXvt1S7dD
	YbIF1ir9lGiVe/Py2tZjI+q+cbCi+z+k=
X-Gm-Gg: AYBFou0puSKg/M2zcJHHVWb7c7hN8OsDZRO2txE2Th0l3VibCq3/D0XJ3WrCcOlcxcp
	Wa/xlE8RuakCdXW4oFSrGaJV6Yj9AKn4RJOX0OC7JPn3eCNHAjrAp4fKf0iVyoUY4iwimrze1ln
	95+UTkwbEPGx993QQOzxdYLyQHQGyFUgPh7jUVK/LB9JduZ0nximqolLybyS1ZvhvGzT926V+yc
	n2Txs7+Jm1aQHKWwQ12iBOJXOsk+Ei74A3PUrURylPuTD3JYaJaVA8KxZIL5pfSMqZ8hxTJBKwQ
	YUwihVRUL0cpQeeBkPvrckzBIpwAjNgkRnpycDsM1hXgwo2F7r9loeA=
X-Received: by 2002:a05:690c:c3c9:b0:8a4:9ee8:bf26 with SMTP id
 00721157ae682-8a64c33b675mr67331497b3.60.1790697097265; Tue, 29 Sep 2026
 08:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-19-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-19-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:51:26 -0400
X-Gm-Features: AclHuK8ueY2_MMbTLnjXLObLwzTBTtFDvxJUVgDBK0IbdY4PPhIjiIl7DTh3C18
Message-ID: <CAEjxPJ6T=i72kb-HabYaNX+jnSsDr37J4G+=f9pOXSAv3OExvA@mail.gmail.com>
Subject: Re: [RFC PATCH 20/32] selinux: consolidate MLS context copy helpers
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> mls_context_cpy(), mls_context_cpy_low() and mls_context_cpy_high()
> only differ in the source levels.  Implement them via a common helper.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
