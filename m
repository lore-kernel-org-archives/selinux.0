Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7F31A07B
	for <selinux@vger.kernel.org>; Thu,  9 Apr 2026 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760769; cv=pass; b=Q9jguq00VkdoIKwEujpQo4a2XgWO7W7dwbEQkN/wokxHe8rR5Iip9Ny4Kq3zLtZ24AC0fr3eHb2jYI3THR+7WKPM/2v6zWEwxPdF5wYvp/w1ZLjGKJ+oSPSmHhoeEhzBDRGnvqt4UDVuvjsEaSexXMblDUcJ0ptwsuPDAp3GNoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760769; c=relaxed/simple;
	bh=JD6rIfDM7X8I5fQZF0/NUc5/PmbBUYI8VbKmXTWCU6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GB3u+z+S8xhnzSBgnydLCNISR2dryWYutMXPlR8K7XwYWnfZDFNnEdyvEvDcKBxhVX0aaxD9Rz9iaZcn2xhnnM32Lc6XNV1WRrrY2fOXoqYxGcUOVVd2OtlV2NPy4Wrf9yMReslRhMcT7STBJQfAKssLlogbUUVT2g7fZSCZGog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BnnslZry; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BnnslZry"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso779347a91.0
        for <selinux@vger.kernel.org>; Thu, 09 Apr 2026 11:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775760767; cv=none;
        d=google.com; s=arc-20240605;
        b=B45FlR9q12ALnWxFmGp0ac0e7W4BlVs/ZJVREitNvTZMLb2/VKntQ1uAtSznkH+mKK
         L4GC57ByLrkb2XJfYdiHWde159Pazcg3Non2gnHMC4wjQDdq2HUVmld+KHYAZiNi50NJ
         6wHbgjr7ebzil8dxVXEB2H7cLQb9GySaYOKUE5zAP9thb5lJnCJh2vF3YpuPEfUPlHtx
         jHsPikqj7ekqhcdr3KBrXVrqAL+99EF5TUqQ5OomgvqUG9GKs163XJYC2YofHICR3CJM
         rcQEtZXP8sUd8yqsW5qHXPotdePTMQTHQBmJAboxNCtlP9pRYcOu4DV+QavQzrKOqKhJ
         iqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ndofJeVD6ZiWF3DlIrVLc1ieGuziyBOEU9AVHO9Qr14=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=keqfN8Jp3hzL3DhTzpnXCq9EXcXazdhquXleMXyNKMUDRLS6LAdskFeyINv0sjI7O7
         yPPk198M437ki0BSQPr03QbNM1jNjld+yM8ecg+uu1ofei8fFI2Tf1Xq54hqbcLmPvdY
         ZrI6Ee4DQ9wKGEcNIALh/1B5rR/CkgQEFEnpPweau+JOspDAGKQrSXl58APxNWDi9pG/
         uAtJkwyuU6UwKH0MwFkhVXVAL62pZmner8N3PfC30pjgHWup9cwenHnUePufV2/8lhhM
         wG93Y8Tp1K/7QSkceB7PAwN8nMWu6SGbnNCVXcmcg45WjSmzxRmX/muIgbms1oEVW0XX
         +bnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775760767; x=1776365567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndofJeVD6ZiWF3DlIrVLc1ieGuziyBOEU9AVHO9Qr14=;
        b=BnnslZry1j4SnGofIZ6ywPSCfSeu/9dRcGVY0bKvNzB8DG+KnZ/2e88aa7gP5s0kAC
         aVfM8sDFqolUwD/eEu4BcgVrKBrPrhxNslwrJJabHXCD46nmqpU25X4vjolPCwiN6Xvy
         I8vyS71TxSVEVgOPwrcpcJ0SiqhqRVyxX6mzCZJwaaM3lhy/HHkf99sXtHH9Tp3ujMqh
         2htMN2mZaQW3Rh+Qmf8YmuO4DIOOzlK3ZKNXbUPg5TY5W6bsFN6elOc/mkImcOaCXqID
         4RqC34k2DQdGGGgcYL5MyEEAmeEGOZluf7/wQPceUmbSqhxxL3Zj01s/bgbgEkE8Uf4T
         vWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760767; x=1776365567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndofJeVD6ZiWF3DlIrVLc1ieGuziyBOEU9AVHO9Qr14=;
        b=EdUbP6NJdHkPgRG8GsdkWfBhE8liIantswi14wyVcHB7y6TA6QOo/JlwawGlfAGU9k
         Rqi6PHMFZf1YADFA9xdg/UksfHKy3w4ZEaavYPnf9Nd1yJTHZU6qYwAjAg+px9rpgX/T
         +G0BNuQSh3e0NMmVrO5crZmCg7t7w9MRs1a/GdoZWCoUr3x33AcRDFWEVYofmywZcjcO
         nrsybChXMjhaDQv3Ox6n0xu0fJuyqByjocukpq2UWdK7VD+f5+16XLBGOYLlseA6x6L/
         U8Dqta1mmf3E+a0ft6wPg629kUrqn5pHT7C88iqIgaXJbD0DNvGfGzp+wrom17KHfoop
         QHQw==
X-Gm-Message-State: AOJu0Yxu50jAJIljExd5gPWSbnX14sXvwUOqxn9Pr8coMf8PCfadgNj0
	QxBbyZIzwOKz/qUoeiFFKbKXu3Cl9sCYInokF3nGfmvWbHu1q8JbpA9FmsxrIIpbkSPWhX96xjL
	tDmIMyjU4Q3tLYwHn16Qmf3H3i8/enNyf84PH0R9n
X-Gm-Gg: AeBDietYC5w8Jq474fsdR29+EIX52erqJG1MuTpHAa4FajGGuYjYbCrqcTGZ3Lx04BP
	RWacpfhz98gednXM57bXuEAIYO5uu9L1EisnixOf5xMqptGyhQmHUVbaRNJf6bqPOqRq3tQwX4K
	n9LACN/OSQux7G1Hf16Gc5atA5SidkaHHfWIHg1yebomHs5CEKTTP2SosBxigu0hkZ52hcY4a01
	M4I6oZsjAulxcAScKNxBA9EQ6FFDer8gcdu/Z9f5rrmKgyHYi5bCJuAAZv2CpHzYJIYMpv/QKbu
	DI0k8To=
X-Received: by 2002:a17:90b:2e49:b0:359:855f:ff96 with SMTP id
 98e67ed59e1d1-35e42846f87mr197618a91.17.1775760767370; Thu, 09 Apr 2026
 11:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409094222.2859087-1-omosnace@redhat.com>
In-Reply-To: <20260409094222.2859087-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Apr 2026 14:52:35 -0400
X-Gm-Features: AQROBzCdgYkmIdrFjLGV0fO5nSNTAXdHBfApCBRHDA7mOLXfPU43_Simq8SlS74
Message-ID: <CAHC9VhQBfXhB8KZK1W25mqVbzQyj6zEGwtRF0Mse3Pm5P-tYqA@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/overlay: add tests for mmap(2) and mprotect(2)
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 5:42=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> Add asserts that verify the expected behavior of mmap(2) and mprotect(2)
> on overlayfs files.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: style fixes
>
>  policy/test_overlayfs.te    |  45 ++++++++++--
>  tests/overlay/.gitignore    |   1 +
>  tests/overlay/map_access.c  |  55 ++++++++++++++
>  tests/overlay/setup-overlay |  10 ++-
>  tests/overlay/test          | 139 +++++++++++++++++++++++++++++++++---
>  5 files changed, 233 insertions(+), 17 deletions(-)
>  create mode 100644 tests/overlay/map_access.c

Two test failures on the overlayfs test running an unpatched kernel,
and a clean run on a fixed kernel.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
