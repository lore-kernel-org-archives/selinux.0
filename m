Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966A33F59E
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953284; cv=pass; b=o1xdRL0zRlAPn8DCg/1X8p7eHJNpwdUob0TOifFM4WBtPwEFQ+609/40AvlCip3/rCzG8W/7LvEHj6rF6KqjfxGWd+06Oz+4pDowkgCsKELUblHTnQxysjkoPx9X4w3IskHVE9D+k6OlC8z+8z4v7ZzAgnHY5+XxonVIhTwPo8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953284; c=relaxed/simple;
	bh=arBY6oDiy+an/tZuYiSLY/mNDxhXPf56qu6NtG9hVro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wf0TJcg8TSmym10KNM27X8kMwciKQ5wyXhQIfEhlCIkwpHYeRVgA45dAQJhjTZ+mgOqvgBz8MZyRs33/QaZuKhYm/FNAuHgb7Y34JEcHoNS6Fs0WNRlzMMlRFqYV8QIb9vz1AwsU6wZezp32/0Hb8R61kSYhrCJ05RHa3IiVHdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGGTc0K7; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGGTc0K7"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-6756a6320f6so5360d50.2
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 08:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790953282; cv=none;
        d=google.com; s=arc-20260327;
        b=m7stkoC7NdTqrQo9b4xZpM9s/PZa3p/NaxNsjKiqZM6/VPm5j5wwPMU+JgXsDrau/V
         H2zPfotRKpp/jA8yJ2wThNx/LhjJS5ylcvdCVaZgS7i5F2gmLWl9zQ5PoM95T+6pK7VL
         Ec+H8e8/cMSUbEA+JDqgm/04mN6onzCa6YQwCh1/iPiXYoUeFOYzbfQwukZ8aJFDKNxM
         AJU1ks0A1iYAa6nH1e/MHsiAooHYWIbogGJqyXXu6e6NNUqOtr7r+AlAwTW7QG2cMVm7
         FF4+ps9t2ezgxVb1qh/ayaIX7Ve2PcC3KvrJ8CYtdAhU1z0xn4U/ywBQsnGZaWqvUCiT
         /VHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WtBKRJwR6ocfj0kQntT2P7xBauT5l077y6F4wUEXHyQ=;
        fh=cLvO7/F7djoz7FkQ03zhwxCeyH79PizrdX2eNe6+yWE=;
        b=WT3WTL+6d8Nwp4+vXyns7FQ5D7e7em9O0MOq7gzaK/vGGvxXCMFh0DTzNeuP4swFXk
         +C2DYzDUAPdFgrbWmDOlGA4+u/Q7EpUtGJvGlMHj5vbauGwPKVzZGXQZPQCuMnsyCdSb
         rNyWeGMYY5blrdgJ5q8sG8bZLsZctnWXPPbdsVSW84thJtmkeHreCT9wOw50Z1mzZQg9
         Bp7ETMmriqL1w38gdPiA8/5bYu97dxK3DVhliCD5AnmQHk7C1zCuAvpAOKjaRv2rFD9Q
         53MmpiIp2SuqzCHWsiaawFzHycHePFyciyxSbT+2DnprMeK+URPXcfKi7YrLUGIuyT8/
         U5cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790953282; x=1791558082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WtBKRJwR6ocfj0kQntT2P7xBauT5l077y6F4wUEXHyQ=;
        b=PGGTc0K7bxkh1UJfvlD9pgWE8+rcVrLTDHefGrWB1cLwqvBnVYoTETS0I4pNsWeGZl
         DDbo6TM4Ej1cWvHy67WNWvlfx4G1XU1BA/3e8jEYuT80e5pjf1eUAug9eWDncRFf1wFm
         0hvH4tlEZep9+peysppySckJ/+JfYTNbrX/2zs3i4kaA0cUI6rzzRVO52UrM47b02fVO
         iUacrv065KELxxc1krKBCEh1xcAeG+BQ0QBHL/t/SlOCMeZGQmqKps/+1UtPmcE01Be3
         /K7Ij8khaBInQnM095C2cWSL6qsUxZnQ5GdoOpfIDG1DNfMIktgY4luM6T5n3r+9ItSK
         Y5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790953282; x=1791558082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WtBKRJwR6ocfj0kQntT2P7xBauT5l077y6F4wUEXHyQ=;
        b=phGkvliCS9v83yI+Qv6rxKfNoVM9fGAR88mrCuxBXqe3u0Et2fHPDBRFCN2vQQbkl7
         uztgIsamtxK9+B6xZRdyTU5kYHVOlb1bFm4KVXL2dQah0JPntaTiMXf+qPhOxLaMMLpS
         cVt5TtknBV8UOLRT606248kDwM/5j3fVH7cMmRn4/f8OU++rWA2RQ/LtVbUVqbMJ4P0O
         rCwLe/HnI3A0GcUqJvBKqSv0kwRldc7ZoNiqTWPKwaxBva+EKBOsSv0Fj5NBs/iKmNhE
         kZM6IXKGuZwxjmXDiMKNFQ5ogTWyWLVmm5ylATSPds514U/WSi9eYzUvKoqRF4lelqmf
         1WzQ==
X-Gm-Message-State: AFq9FYJHw4zsNpjShPWxc3PyPsAkAdIwETE23f2gvI8CZ35ejKCiVFgx
	+aBLoNCNQplAGYGdV9uqW2n95XEK06FxV60fIr1NHDwVAT+vwalKgyaP6H2RvkGgOvZAR4slz3V
	Bm/CKFMsLnh6f8DXH+HmDCvmlMlb3sHU=
X-Gm-Gg: AYBFou2IOzPRZVvFb2tpjHdqBgiXlel+FQ7mHPYcyfHIXwlIV7OADhAS6yJX7rAlbZR
	SAGaZvAYQIAtdc6O1kSjVFSTYQS9NmLTdhn0ZnOYVxUscRj0vORogjEopCrJIgILj1nmc63eSb3
	iEhe3PS7+3Rm0Qqqhc41EUynHcJRdbQ/x4wJ60DtlM+2gl9k05dWQttWv0mGFen7F0LSlswbpEo
	r1xYn1HbnoAdqDU+HzJkEyyNi265hcytuhP6UCmDMlYVatXdeN/b10aPXXIA2WdY1xkFIGGNs1w
	7BhM8vdLua+6qmGUnF7CoqITk+hLrl1/ivy4c710a0G/dgvu4MsEbCGc5gCaV1H4Yg==
X-Received: by 2002:a53:d047:0:10b0:675:a033:ba0a with SMTP id
 956f58d0204a3-677ac180994mr1198933d50.105.1790953282234; Fri, 02 Oct 2026
 08:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710082514.452700-1-jonderka@redhat.com> <20261001153650.105863-1-bgrech@redhat.com>
In-Reply-To: <20261001153650.105863-1-bgrech@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Oct 2026 11:01:11 -0400
X-Gm-Features: AclHuK8KBMajAUOdVhoB6ZCB80l6veql13f0pW9G1jsBC8wg7TXn_2t1V4t0Oqc
Message-ID: <CAEjxPJ6Ria-P6quOcjwkGSGdEyFRVCiJ0b+mwsd=LXGR5oW-Cg@mail.gmail.com>
Subject: Re: [PATCH] tests: make IPv6 subtests optional on IPv4-only systems
To: Brian Grech <bgrech@redhat.com>
Cc: selinux@vger.kernel.org, jonderka@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:36=E2=80=AFAM Brian Grech <bgrech@redhat.com> wro=
te:
>
> Skip or adapt IPv6-dependent subtests when the running system does not
> have usable IPv6 on loopback.
>

> - Add ipv6_enabled() to sctp_common for C helpers and SCTP bindx paths.

This isn't in the diff, possible leftover from prior version.

> Signed-off-by: Jan Onderka <jonderka@redhat.com>
>
> Co-developed-by: Jan Onderka <jonderka@redhat.com>
> Signed-off-by: Brian Grech <bgrech@redhat.com>

Normally Co-developed-by: would come first, then both Signed-off-by:
lines, with no empty lines in between them.

> diff --git a/tests/sctp/test b/tests/sctp/test
> index 5626ab8..21b636e 100755
> --- a/tests/sctp/test
> +++ b/tests/sctp/test
> @@ -104,6 +104,27 @@ BEGIN {
>              $test_count +=3D 8;
>              $test_nft =3D 1;
>          }
> +
> +        # Determine if IPv6 is enabled on loopback.
> +        $test_ipv6 =3D system("$basedir/../has_ipv6") =3D=3D 0 ? 1 : 0;
> +
> +        if ( !$test_ipv6 ) {
> +            $test_count -=3D 12;

I count 11 ok() calls wrapped by if ($test_ipv6) outside of the
calipso/iptables/nft blocks 2 in the base-config block, 2 in connectx,
1 in sendmsg_connect, 5 in the fb-label seq-server block, 1 in the
fb-deny-label block), so this over-subtracted by one. On an IPv4-only
system Test::More will report "planned N but ran N+1" and fail the
whole file.

> diff --git a/tmt/tests.fmf b/tmt/tests.fmf
> index 08bd129..c9be59d 100644
> --- a/tmt/tests.fmf
> +++ b/tmt/tests.fmf
> @@ -121,8 +121,6 @@
>      - xfsprogs-devel
>      - libuuid-devel
>      - e2fsprogs
> -    - f2fs-tools
> -    - jfsutils
>      - dosfstools
>      - btrfs-progs
>      - rdma-core-devel

This doesn't belong in this patch.

Also, please re-base on your next version since it no longer applies
cleanly to latest main branch.
