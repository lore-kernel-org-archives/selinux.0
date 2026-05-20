Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF5221F2F
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292727; cv=pass; b=NW7xHDSBOIL6U//74ycJlGy+CTtETSubec3DtlvOTrERwbcJFxwLoEnnT27bjY46Vuqha80nqiFq+rZtG7nbpipF83N0e2IXrSQpoKn6MJDu2nOxlxj6i3ffmV0kx5hYwPrT279uv9oVg7DRiqWpfGoVH6o01ajZfJ98Mw82Y9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292727; c=relaxed/simple;
	bh=VVhFgtTu50hh9LzJM4O8lNCRUjDwWsAY0Rr1zWN8zYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTAungXRBL1p+e1UKdzEBrKjktsAwhIdsU/4CwvBf5jeG6v+uBLNumaB2x4+gdVWHetLvSj7fCYUqU4REhGhgq3KmcMGdMOlee110EcgHt6j+z0KyUo3e5cfObqqvFEkba3fEkCXtGG6ILvdd9D+WT/YBYx9hhsa+C+016j0ECU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/RQMtUr; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/RQMtUr"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa1b2327c8so6277654e87.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 08:58:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779292724; cv=none;
        d=google.com; s=arc-20240605;
        b=R4AV7Jxpe2vewu3InF+BOYAZuMryiwoQXrx8Yb/0HrB0pou9BMiU3BI9GwKGvx9Puo
         Ue0LZjoc9CiP1n/G1rwMF0Qov+gcFmdxxXecVQyDVWeY5GSx+B1e9HXGCb/GmpErWMJZ
         QDwnxBngPMHWGTc9T5P+oyst56g7SQ/LUHkJ9OOPpbykEJdAr2DL6BvE9SXiSCtmzEC6
         m8LU8qM0IeAgZ28gUGTEmm02Q7mEWedXIjNRICACbYZ20QSNKeUOvYfVWu4tHdq9EZNC
         7TXxubipCxosbfzlwwjN7qYCjKFc/h84PV1XVrFFsUDhmvXF9I0geyrcYo+OUkOKueJm
         tUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zW3hQw3R6NEFANWeJh0+wJQ/uiUKKhufq4ehDbBvmMw=;
        fh=ObTz11kw971cUdBUIpEO+FroEbPqDMrs3q2ljAGcN9U=;
        b=XBh4GEVp41PWtKea3lQe8k0ALzYwRrExcrJhnk7WBKvxK4/T6OiBpyfxh29xG2UPQd
         doL4UXS/xhDoe69ta4G4q2UEGRicsrd0KQKR8oCPmOSo97uix2Ea69cbJu3a146JR7lj
         FnWTPKRrsztjSj7FmSXPYmN5Y+5ba2Wvv+nbHij2zDGdvWR2FBU9Ujk6ipwc3oGst8YJ
         lVXNUFEXOfKv2c94i4CL7GTDPSbobTeQth2f/t2lth8TJBu6Qs93xBs1+K5nll/+2+0v
         1v8Dma8x+r7SvmKdTum3QexSSj7C8foNczHaLaYFFs0KbtSFyFcF0Y5tP1CPFIOm9Tit
         TVVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292724; x=1779897524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW3hQw3R6NEFANWeJh0+wJQ/uiUKKhufq4ehDbBvmMw=;
        b=p/RQMtUrGYumlaLUsneCNPCmJ/bS9qRhufNrCYGsQoj1TdR3aS/E6/xkfzfT/yeSWM
         cNjrpCOldCedf9rbvCAqpJsqUcRALygdQYC5GN6F4f/P8dESxX8qejZWC/h3gQTHz3ka
         AUv1XaLMvII+eBF+kD8Sqv50uI5jGEjus1neoR85xi5Pq/2UgoJ/ITDJpSKkf2jszFmR
         MW8e7kj9b6VfwaE+yMMecPyxZJD+nEc8myVs4taroxGhjsf0IEVi6oRdLox+WAd7nQds
         UuBHpjByBn8YCcNnxnWyeIjfBRw3htDbyxN8uXu4UQCQq4VHQLTGjBkKTMraIpNW8yim
         JgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292724; x=1779897524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zW3hQw3R6NEFANWeJh0+wJQ/uiUKKhufq4ehDbBvmMw=;
        b=TEWqYgr4xnwfk6cdikypbev0HlfWSngGdZHqynqO7HtNbUAQ5HQUyAChrFQGWyutDb
         teh53ojyjFAWeUdUdOfe2x9lft+Z1J9GCmK/x5SnWmDtaXDP3L1OlrjLrteCQpnnAAlP
         N90+ByCpO4HHU9kWSWiBEdEfFykzZb+mBxf5nFKV5F8CU3ZFj0HpnHh3Jd0vPGrFQ4kg
         X58SenjqPEXcIHWYFPXK9IunOuq6r8DeSX52xFjA0jilBWxs3EzYAyQjBWJzRT37+ZSQ
         kRoAxC6lQ1SEVNhQAylOJ9nBzPjQCLfVXQ2xnq3oyp0o40l3XkGNiFm9aSjowxOIDkYK
         HlKQ==
X-Gm-Message-State: AOJu0Yz49luiPwjD5qjaA1Q6AJhvthJFoiqOqPQ5U6yeqxXxMja50vxd
	Y7+EU5fDG9l0y5mUvlNis1s6CiOTmeEyUAjKx32gUBRYJagh6Bo+25i5VPM5cs0Rrvg6z2ZAcuy
	Y3qS3Zv5nFaflsuc+jromXVp2Vx5IycL5RA==
X-Gm-Gg: Acq92OHqVgDq7mmXrVb2dvtyhEfzzEDRHFvPAe4WIWZXmCc+cSlW+fje5UN+LxiRXqj
	pdtoXoIvvBgk9r4mDxhxCNPNikLJ3YP7HDq1hO9RfYupYJQbsl+F3IasOmeU6fKfGaun6kgCbyv
	TCKC01EN41TQrtW8Me4inSymodKswVsJpKnaZY/BcwniX4xbG+DQaje8+U4FKv5dH1CO6pcZXlo
	JeoHCx4N78L5JwtXgNmUcIr0bfmnpRqoTxD5rWhh/jxggLtST4BtiMMaHYgxfBgxyTwkJf7e+cL
	5j5h
X-Received: by 2002:a05:6512:1321:b0:5aa:b6a:9256 with SMTP id
 2adb3069b0e04-5aa0e7409b9mr6329143e87.43.1779292724394; Wed, 20 May 2026
 08:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514160943.5332-1-muhammustafa@mecesoft.com>
In-Reply-To: <20260514160943.5332-1-muhammustafa@mecesoft.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 May 2026 11:58:32 -0400
X-Gm-Features: AVHnY4J7gA0pPzrVdUJ7EVcmvkmkwqBIXudowC0SnSc-UjLwyEYrcG6mOB4eTT0
Message-ID: <CAP+JOzQEDJ=wSO-rFq6FtbU+jszPuGt1Gdgd9pXwsnVuUCU1Xw@mail.gmail.com>
Subject: Re: [PATCH v2] semodule_package: fix wrong variable in error message
To: Mustafa <muhammustafa@mecesoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:11=E2=80=AFPM Mustafa <muhammustafa@mecesoft.com=
> wrote:
>
> Use 'outfile' instead of 'argv[1]' in the error message for
> sepol_module_package_write() failure. argv[1] does not reliably
> reflect the output filename since argument order is not fixed.
>
> Signed-off-by: Mustafa <muhammustafa@mecesoft.com>

For the Signed-off-by, we need your legal name and email address.
Thanks,
Jim

> ---
>  semodule-utils/semodule_package/semodule_package.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodul=
e-utils/semodule_package/semodule_package.c
> index 4cb6f5a3..b81b7e42 100644
> --- a/semodule-utils/semodule_package/semodule_package.c
> +++ b/semodule-utils/semodule_package/semodule_package.c
> @@ -266,7 +266,7 @@ int main(int argc, char **argv)
>         if (sepol_module_package_write(pkg, out)) {
>                 fprintf(stderr,
>                         "%s:  Error while writing module package to %s\n"=
,
> -                       argv[0], argv[1]);
> +                       argv[0], outfile);
>                 goto failure;
>         }
>
> --
> 2.53.0
>
>
