Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3C3FD957
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432203; cv=pass; b=J6hO29KcQL43PypdozAafKaJtR+3e1tUCwDGUeBxkbz8vjVHcwWEWczLwquRAN/i9q9kUFxJ2NUmmECs86m3Ub2m7S/s+B102rgFgZT9lbkMmAeOUJTpKt2AF7eekYeu5SXKAtKQlDZVAEpmHcXQF/snJvBcYpdYFk2PUJXNsVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432203; c=relaxed/simple;
	bh=3jxCPCeKaLBh4/8CJnKcovu7OS615R27WDbPQhSQqxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUQg/GpBmOtMhhlyY+aEkeUCgpqMzCqA998cgxY+3LaZLluVBW4F6QCq2y/O8nrRoMmUkHvWjezNk8tLZeEVK0/i1OTxtA9fMnd5pq3DhZms/hijSigMLfYBq/u1bY9fzvRwC0WkiJsMYXAhP1OnXldF9nQrfBdiFx9/eZFTOsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTNr+4k7; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTNr+4k7"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a198cdc4e4so1097293eaf.1
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785432200; cv=none;
        d=google.com; s=arc-20260327;
        b=MeBfRACL5eEF/4vSQJxkmFqMNLCYt27+EFDps1vl4Gr8guEogjUSs5+M0o63xdm1fp
         hg8qQKHtd5ZfvJPZDuLP5FE1PA+Y731oCldJCyYOFnmESNFn4FzGl4eOe/dXpdiBPHJ9
         CscJDouzoqwFt0fh/27yrZWtWvQlWio2oi6L1IxIqqrBDxF/F6fkUEEc/ZqC47KHLzPe
         Siy21XJ0asgokcz0G1Qjnbn29K+jbQjlxud+kcHkQzXgszIe43mfIZlf6zNfZyU/YgMe
         rKSbpSzoeS9vKlF4lICUjPMzdfIqFRsHwKgLy4ugw17b1w7fiiKkGN2Lv3GV61E25owE
         SReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r+NbKPWJ6diPQOg9JXBhQV4wMrFK/+Ofbkcp87WHGyM=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=fXD9bY6ST+310zy1KR+eiT6KLEpZVZhQSLm8b6D7mHGzJkVkt2m7xU7PXeS9WXGWa5
         xAUE+Wx4cryodbdlEyW8SaBiuEoXH4ovBorYaBOB0w6NUkTFC1Bim346AvoMegx9vM4e
         FB+WFE1iqMruD7a1ThCIEVt0S7M1OmxEWeUuNWk5Jjy3URV7EGTmpQXvXCeegQM0nQt6
         89rdQce/sQdLv7ueS2BRlnUV8pnu6erjX5S6+CSddRcP1bhwo4jsXrwae1Fh628WIP3+
         VloiXpiTlhc0SQg1qU8FDuKqmvM/f5BJfWv+6B/aEdCw0jdCRsXjudvK/9nwQ0A1ud8h
         5Fmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785432200; x=1786037000; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r+NbKPWJ6diPQOg9JXBhQV4wMrFK/+Ofbkcp87WHGyM=;
        b=QTNr+4k7R3xz3k43QD1Cn2fvJrFokGN0nHJq0ZeOBsLlxBiHYQVjB3eiJJyLneLy4m
         nb/pd6CS1S3hoeW1zWWrha8m68n3l/IS6PvyIOJA3iLMLEsLHtsxVD1GTFAXIN8L74jV
         qqGm/wHWY2K0SGLX0ynAVhHP7I8vqrQYutzU7ImeiL2N7awdwt6Bdegl7W6YkVz/6hj2
         U4gSHYWesWL6g70YSVp6vrrxpUS/h1LA0U4/MdNGtG7MQBm6RDNk0+jkrQh6v+bbQ0Nn
         DFP3bvqabjLnNWen1taYiZ+n7uj9tq+T/8DDP1G5sUMR/AZDfXYASpUP764NqLC5r5qT
         1hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432200; x=1786037000;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+NbKPWJ6diPQOg9JXBhQV4wMrFK/+Ofbkcp87WHGyM=;
        b=rPfnwjaZax4zkNvUaDLYFKmRQ0uY3IJ6JG4mkVOAXfW3Pua31u6Ut+U9250m6TGzkN
         qV0pZk3bJ0msXCOTUR+96WjHtwfqXPpRfESWryDStiwO3tL3YntZgjq0bfRGQK1k+Iwc
         A7OO8TYdpduGgMYjMgoHq9cfJEn2893bc1opdFp81stllOl2BsVSQaltq+ruBTJ96WKP
         7NUXtwMZc28n4tktlGCwomupfcXgivJsmsGcQHjlpN7u7ke9NXRuXvJRKIgFopEPbUXK
         nQOpCndtbSTAgYCdDT+Q8HWhRMRVflPEpbAHkSFnvqeKged9qndWjWGh8zputHpHbnlI
         cfgw==
X-Gm-Message-State: AOJu0YwIiVlehbBybchRNvc9LtHvwii9i43Iv6HlPyjCj1S0oohhfO5Z
	8xzIl78I3S6p4mvcDCGtINCeJDP0gF2BN5lleVQIxWI45VLrGpywke+x2VpDQVFOyuWwLcQKjo3
	RPvPIbISCHjRuw2t9IHKvfXVe0hE/zvy+U3/M
X-Gm-Gg: AR+sD1106ypV6tB68sZwdINxjlBPkymZ1nZwSYCaZrR7AqNtdaWpdFFoXDZSy0S3pm3
	krwj+1s45cr0TOf1JFvRJYm7RBOHsxVKGMfDfTeTnhlpzRaSahZN64T4T2sYI4+sriBA9rdvRWj
	+P30RgwMwwXma4b+JaamgEaF3LjDSXmQbv01vXxwp9ZIHNiAMepf8HowXFIn+e/mk0fcVXAmDak
	MFjVeQUY/t9pc4Urj9AXDTXgkaD13vWn2kfax3bPa/2ubO8dvmSFVe4Q5Jfg7o99AtcC5/Q505R
	ktXxIf88+8p57LG7g0Ljffr7mir+wEwN88A7GGYd4s5K
X-Received: by 2002:a05:6820:824:b0:6aa:cefe:b025 with SMTP id
 006d021491bc7-6acbc1ef5eemr2080107eaf.65.1785432200359; Thu, 30 Jul 2026
 10:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730085713.1484927-1-pmatyas@redhat.com> <20260730135601.1510501-1-pmatyas@redhat.com>
In-Reply-To: <20260730135601.1510501-1-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 13:23:09 -0400
X-Gm-Features: AUfX_mydHIVtD9aNwFXJLLq9pv672vSMBcXlvv5cr4Dg_iSkzoRLRg-w7To7Jnw
Message-ID: <CAEjxPJ6-dU+zGDQejk_uUbH=a971ZHFY2W34oM+e2+=8xfh-BA@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 10:05=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com>=
 wrote:
>
> The PCRE2 interpreter is susceptible to catastrophic backtracking on
> crafted file context patterns or lookup keys. Since libselinux never
> called pcre2_jit_compile(3), the JIT was available but unused, leaving
> the interpreter exposed on all platforms.
>
> Fix with two complementary mitigations:
>
> 1. Call pcre2_jit_compile() after every pattern compilation (including
>    mmap deserialization) for both complete and partial matching modes.
>    pcre2_match() uses the JIT automatically when available, which avoids
>    the interpreter's susceptibility to catastrophic backtracking.
>    Note: pcre2_jit_match() is deliberately NOT used as it is known to
>    produce incorrect results on some platforms (e.g. aarch64).
>
> 2. Create a shared pcre2_match_context with a backtrack step limit of
>    10 000 000 and pass it to pcre2_match(). PCRE2_ERROR_MATCHLIMIT is
>    treated as no-match to keep the lookup safe rather than failing
>    noisily. This bounds worst-case matching time to milliseconds for
>    any pattern/subject combination, regardless of JIT availability.
>
> The vulnerability was reproduced and confirmed fixed on:
> - RHIVOS 2.0 / aarch64
> - RHEL 10.3 / x86_64
> - Fedora 44 / x86_64
>
> Reproducer (149 bytes, base64):
> AwovMi0GLy8GCygKeAYGKwYLKAoKCgAAAPpXKgsoCi8vBgs8PG5vbmU+PgovMi0GLy8GCygKe=
AYG
> KwYLKAoKCiNXLy8wCwsoCgojV1dXClcqCygKLy8vV1cueHhXV1d4eHgveCsGCygKCgonVy9XV=
3cy
> eHgveAcGJAsoCi8tLwYvMi0GLy8GCzw8bm9uZT4+3q2+7y8=3D
>
> Signed-off-by: Petr Matyas <pmatyas@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
