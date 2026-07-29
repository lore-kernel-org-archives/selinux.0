Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93948986F
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356353; cv=pass; b=J2xE9Apu/ayvzUNLuNJq1MdsW7kvyjff3sL1Dyg+2f6TLaW4sfJLLcr9ge+S5HQKpH6Bws7eNZpQhdxjD8CXFLISoIn0FMDjOejupyj7TN3KKzvoKPT/g2WekV3K/m0nJg0lD6GLD8agMNIL5hMeFBGyhVSrTJbPIM9ppj1eHF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356353; c=relaxed/simple;
	bh=KyHjwuH2YdC0SzZHWAWuXV8Iig4P7WUh8Ry3NQxmmJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjPlum18B9jNfQqJabCIZy7xZW8Jb1KC11uomjdmVOKXI5aw1KNF4bMZG3xEuPOo/U3+aLSq2lp+BEBKJkUkfta317maKie5wZ9edHuDegbW5XiCV9exUtGVrD9pRFVkcazHgTlbEC9yJtbf1qk6I2HZbk/U0khCa3ckVmh49sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+Y1RvWb; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+Y1RvWb"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-44aeefa1c00so64530fac.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785356350; cv=none;
        d=google.com; s=arc-20260327;
        b=kMNu4CuCyG3asbT8nBbrgqwPyV79R/5soh/8pvQZMZCLzSbJsMKwMaMDXPVyp1xGiU
         0xoQr++b7RqaMRLKN4wLRF5R9Z7sdD4nokMUa0qZ0YTCMgy9D3BsGZF3vy2ju1lk5Ja6
         XEqHn+FWyc8tOAx6XTiTqpu36wRz+rmiI7zXyctVcqv96xyWXciRUAHLyZFx421gDeoL
         AfwxYFWhT8gD2Dqkw7pIlPkAyjn6ErGCr5oB4NJWNWCa//B+zwkS2saEFAy81C8XdtG6
         /R5HHKAmG8xvtM0A8YrkTq+nysoktP6Idx0kbpIlZqQx4zExlMWSnXgWwqlFv9FJvdKa
         +xhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yo7ka7rS57LXEp+/66AMFngf3y/VFgC7Jx8BnL4/oXk=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=b3NcJKjglGhT57v55CB/CA13bnxXNhdqd3NcYDlrYGad10GCRpuUYrykKRJe9gQ1DK
         nDptIZ/gRmidADRkvug3IMx5GhWWr9zAL0eqRarn1TLmn9EDJTzvGGIOgPZ1oqn8DL+N
         gXgwx+IQ3gqfoafYE5OwhPaKC6L31kgak22cDHNVyPDuqC8pwMkBFdghejaKIBRffgvu
         4ilYHYfxLf6DO2BYwaFwDIjpNodZfulDoc2A7P3gowzUsrC4Vxqchfz7KxL/f3QbkFf7
         o8BaRcN3cLYwCRCOpIHx3MHVprIi33DOkPaaPMP3Kjnc1AOh4JZXLyR2fjstsMotK3IS
         Noug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356349; x=1785961149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yo7ka7rS57LXEp+/66AMFngf3y/VFgC7Jx8BnL4/oXk=;
        b=r+Y1RvWbzDamuIAv3hnio2SYkZ/FdFCFf+Bhl00aOypGtfqL7bSDEaTLERCHmKeAL3
         CoTOxFXQySZdggZ9l/AqxsdahamBaWyZdUJFYG/7rqoF73aZqfsz1QroDFIEVZ6ULTgJ
         ojlNCM2U+rGpOjPZaAfD//WKod2iKV8HyjNLYKWUjxiYEGs5H+rbHeBLF1IK4gId+zsU
         tlkmroe9Z3bOkcGk0A0NvTOogJ8zftqiAlPg4w3UyLyukdjQoKNuGmWqP1ZrN1Ucf/Tc
         BEwajSxtW7usTjKEni+JAYR9lxFQrMuAqTltQ6BFDyNe9VBe9Pmeb+nM06JZVkdSdQSu
         LN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356350; x=1785961150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yo7ka7rS57LXEp+/66AMFngf3y/VFgC7Jx8BnL4/oXk=;
        b=YjJ21JyILU/pTyq7j+NvJQmackknrvSJggfBdhHpK9rfV7/BcxEJPaB9RDhyMlZDfm
         sK27YQshIBhm78gCh+z52ZsF7lybTNSxVmdrxuxXa+k8BdJB5YDjiDWAoD/JKQmZ17TD
         vgaBBsxiHHlSSxS66YwSdbhOXRyvSYiKQd7yZNURG/BRFR/e0DanUgDGyNkQpnH6FjOJ
         cqJex4f81UQhqdmSm5rxqMY5EA3QKr6GI2OwX4QNBtOsNJmOzxTACci0q+P/AEZCfTdS
         +I9yPzjhF2DMRVmAQ6N78KnVCqwBM6gPFNuuulUYAz7iTQ/YXVsOxZHp8jCb3US/ExAI
         EZ2g==
X-Gm-Message-State: AOJu0YwWiyd7bhHAOnyYj34/fXPIRwfeLDLSQiLFlOU1WZmXeeuuKWg4
	ZQIBWBGZibRJ5SFZjvt2cWu4BKWzxcuIiEGl7smNpjGRmiz+2sY9yCXC/h3RT5sHRtG3+gQJzu0
	jbUw7tiL84yKBsxx4jJzVGi9qIUQXw0Lu4Q==
X-Gm-Gg: AR+sD13UUxwulvtaE7dchlnEVD97grBhWqceTSKWAuCED3KTeCAT2u1J+VbLKcD7guV
	xsqFYMPwqUHBeGyzprBJn+YNTgkGA39eeaJYfegnncnNWTjWNx7fQqQ2lFnUJz19S/Cl43DbwYQ
	FzkJ25Co4ugHnooRxEIu8AYj/TgrKGNyGNhHzaP5C+/Qyh9f7ETo5eUdkM/LWayqsM5LepcakLZ
	WuhGM4fyo5NiwTr12a3MUEUl5EoMcXo+VFtB96LQOFeO0WvQODyygTujvko5DMoHyK4mkraJHWg
	7UALYm649W5Ns9Sulmwist/4+WVEDmHyY8sWUg+75gGY
X-Received: by 2002:a05:6870:535b:20b0:448:9a00:4ec3 with SMTP id
 586e51a60fabf-458962fed01mr1251938fac.26.1785356349668; Wed, 29 Jul 2026
 13:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727191748.24108-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260727191748.24108-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 16:18:57 -0400
X-Gm-Features: AUfX_mwZOP7yQj3jj14W0JmlXQvCeN_GYkfH8Njuwiz8hok0QAZ8qP8gintYpYQ
Message-ID: <CAEjxPJ61MT5kstaRSSjMq7OfAf6Vr-jdMvBrSL2tti7yNBYbwQ@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy/fuzz: ignore invalid policy versions for the
 Xen target
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:18=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Xen only supports specific policy versions (see policydb_compat[] in
> libsepol/src/policydb.c); the fuzzer will always fail on the
> policydb_write() call if given a version not listed in that array with
> a .target_platform of SEPOL_TARGET_XEN.
>
> Reported-by: oss-fuzz (issue 539336382)
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  checkpolicy/fuzz/checkpolicy-fuzzer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/che=
ckpolicy-fuzzer.c
> index 7db0d4c8..c58d10e9 100644
> --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> @@ -159,7 +159,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
>         /*
>          * Take the first byte whether to generate a SELinux or Xen polic=
y,
>          * the second byte whether to parse as MLS policy,
> -        * and the second byte as policy version.
> +        * and the third byte as policy version.
>          */
>         if (size < 3)
>                 return 0;
> @@ -189,6 +189,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size=
_t size)
>         if (policyvers < POLICYDB_VERSION_MIN ||
>             policyvers > POLICYDB_VERSION_MAX)
>                 return 0;
> +       if (platform =3D=3D SEPOL_TARGET_XEN &&
> +           policyvers !=3D POLICYDB_VERSION_XEN_DEVICETREE &&
> +           policyvers !=3D POLICYDB_VERSION_BOUNDARY)
> +               return 0;
>         data +=3D 3;
>         size -=3D 3;
>
> --
> 2.55.0
>
