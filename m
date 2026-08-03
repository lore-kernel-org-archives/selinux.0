Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B35379C43
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774949; cv=pass; b=I9DjTkQvSKEs22S1gtNgLFz5HL6DuKjKFCC0DnCP0nqySMtqLQOWyhzLczNRlPGy8OVmSUqsGVhUn0XZfy9bofTyQKKLICfy+r2/dqMjzS/Uproo2pjMxYTJZg2sq5VEr5WyI3i1tRxKJsoZR4T0wcoAi2L0FKV6VKDHIgd0lgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774949; c=relaxed/simple;
	bh=Boj3mw3LQQElqkDrWJZfdwz2OdUHLR3Fa3fN4czvpa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7IjkXpaIwQT02xhAu/CV+wfJq8ppAxl+p/mAI/Vq+KrZDFOQ886c7EPW0jK0E30mM2Ma4QFmpsvI3FlfVkpRdGnHBI1xrn0ygFohpPpuAbY0Ba8JqfSMXew0QjMWuBE6Rx1IXQ3pUEDOo823AT/raSfA+YSo3Vt4e/RgFeT4XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfhNDmeO; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfhNDmeO"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4472500e25fso1790894fac.1
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 09:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785774946; cv=none;
        d=google.com; s=arc-20260327;
        b=oUTfwRZp5daNxEOK8NM9pMiepuyIvrnNhlmoa9KnUWtSocHJrAZytuFg9Wq60YXaVS
         JSTT3o3EG2NuG7gLKf4o5/HVabf6+Zd4az0cpTh9073BWPBtcYsdJxFJOlv5d9fUh1A9
         buizRBbVEmxdP69irMyNB0ZeWAWqZqHhLFfFMZert0xouToqtXpmqODx1BSqiO1HyxM7
         belqizdwe5++33Q3OIqWF7VoC58MckryxlIxfsdYWG6BsBPHAl8ozhbnVPE5PUp2CP/5
         EZ93x8X4FMfglAZe3U578uH5g05hV/ZBK9O/ZfVptrCS/tchyOJWkgz9Rwgps8uJNeGC
         XDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GvQ9sE77kt0YeZeBBErZJK6y+TeUDA0ENAoXPZP6wQM=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=ow+PollO5APq/V0+fNI+AxI5ZQGbtg4shbTUAVGRscZb8hGGjwm4r4714DD2fC7501
         j7DsjKxuMFf9RxWMUQyZT3MZP0yCOzoC2gdQv+DX0xbN7fXvUbcjUN3ioPNItUtd2rcX
         h0bVgJvBogEcXXdRmk+VagfYGIuWBIKD+3YYZJzYF+0HxSCrbky3M7r38gFkeeH860N/
         79YetPW/vmUXqyqXIgAWccdUobfhP2tOABAt6TGwa0sltwNlcnx3Mk2OH1Hrbl72IHFM
         L2P9UONrngYEYf8nH3+Vu0oX+247qREuoL8nBe1S0oHecI9C4VRZtOiuw7nsWQyj0cio
         R9Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785774946; x=1786379746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GvQ9sE77kt0YeZeBBErZJK6y+TeUDA0ENAoXPZP6wQM=;
        b=AfhNDmeOq8Qb5jXVT9A0D1iZvhb/DqmPKF4PotY19mSMISytmpDGv67m5XBSOs2OJ3
         s68HOvVKFRtS/UBas/+ZfQuE6uTMlnSspv4ndZnFFRHqyPNOC+Hh51wrud0wajBu6H6X
         TJO+okGSO0Cdy3jTgHL2loiD8xkZl0orLscVdLD74AqeNVxgLfsTblNNc49HD7Q8VHI8
         e+e5LQqYcvButOJZjXnEiBW1pRHHI8wDjU/+P4JzV5beUu09ag2qpy41Yv4rtu2t74Zm
         sbjUuY3pqyZIRxsA/EEkkQhXSvqQ+RsVbaGdjIJhZUOOxLQN3oo1b47z0MIb3ZGAHErP
         RTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774946; x=1786379746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GvQ9sE77kt0YeZeBBErZJK6y+TeUDA0ENAoXPZP6wQM=;
        b=TmuLhYioCu4gv28iSKBbuOpNn84VRePjyGZOYOiRZO1fwreNnejwVj9qXwderz9+CG
         7hsAPHzvE5CanX3RnE2uMThwXOVPmLxGZJBXawzwAVfaWOcgbOAbnemYPerXEFvbdpDS
         ZBg0Y2+Zd1zvVfhQcQ7+ScSNb9KnzS1TaWpfPcgFOzXpLCZ+TM+yCqaYGkLJPCYtC3Gc
         s8pfpsW5D2r/ddkW4sKu1aQWoiLTfvBZIyzv0W7ndnUDrY1rXKqeVb/gweZcJeVVxHld
         Ambua0u6nLmCFXm5caN9ixbg+pfURwtUtohR824mdDqaPTVfowpX3ZxUCfQzDTDpK5zD
         UZdA==
X-Gm-Message-State: AOJu0YxYe7u6+9m2syPqJqXATTgLU3puypfxk/6flwnWUyNxpYXhTaIM
	CaHqNTGlSIKgO5u27OCWk6dS6Ybfe7Io+gX2U3cy+gi0dWB3nOv9s4ZHndv8sT0i5KzLiXH9FVo
	oTpagY9YQb2XCOXOKK5DnvwMByofi5zAWsA==
X-Gm-Gg: AR+sD11GYB8aTrNrLH4cVXhOwWfnOFXEbx2fNW+KwiBSLw68QA0D+SdiMAmedge9keP
	PU6Ka715RmuitTBOvA6hJeDgBcUjfR+6J23eGoQrVr1o99+dx+PZe6d4zkzUYrIQ8ga0EiaEqSj
	E91HncraCFPxADIWzQLTaFmx/snW0b6+yPaaM/O+2wymYaSmm5ziaTsabVIDd7MjZLwzmc7J5zW
	93fMjIMjWpSFl0Fl3kIxcm+aTcOkyF83FNzYt+dNC4rYHl6Bwb47vg1DwAZWiJR/r3Y5WqiXGtJ
	wLaNjQmvTNIK5G5Rwt9RzMnXMCh59EFRheZOQ7Z+DK6W
X-Received: by 2002:a05:6871:53c4:b0:456:9b53:c6b5 with SMTP id
 586e51a60fabf-45905d353e2mr18044398fac.13.1785774946199; Mon, 03 Aug 2026
 09:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803154748.18370-1-jwcart2@gmail.com>
In-Reply-To: <20260803154748.18370-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 12:35:35 -0400
X-Gm-Features: AUfX_myKVoblePdyK7Ww5IYFTz4RJqFoOGXVrr0yImKrK34OIlQWZGO11ugAtL0
Message-ID: <CAEjxPJ6EKS6u0mxxuEbNGUB9TZUJgkvcMVzzKKtZTrUSaFrvOA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/fuzz: Validate output of expand_module() before proceeding
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:47=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> When creating actual policies the output of expand_module() is
> written to disk. Converting that policy to CIL or performing other
> operations on it will require it to be read by policydb_read() which
> calls policydb_validate(). The fuzzer is not validating the policy,
> so it is reporting bugs that would be caught by validation.
>
> Have the fuzzer call policydb_validate() after expanding modules
> so it will not report bugs that are caught by validation.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/fuzz/binpolicy-fuzzer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-f=
uzzer.c
> index 017f996e..f2379175 100644
> --- a/libsepol/fuzz/binpolicy-fuzzer.c
> +++ b/libsepol/fuzz/binpolicy-fuzzer.c
> @@ -88,6 +88,9 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t =
size)
>                                           /*check_assertions=3D*/0))
>                                 goto exit;
>
> +                       if (policydb_validate(NULL, &out))
> +                               goto exit;
> +
>                         (void)check_assertions(
>                                 NULL, &out, out.global->branch_list->avru=
les);
>                         (void)hierarchy_check_constraints(NULL, &out);
> --
> 2.55.0
>
