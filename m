Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892779;
	b=40xgTc18o+VvYx78ZwFg+j6TaRZ4hGD0qdPbNMkbpBPNFWyxDwAqbVPekEhakYJeOl+n
	 JAqPpH15gviY0co00HVqL1CDlsFWdhsQ9avnDVBU6DdByiDEIWlhNXf72Kb+SdiDSaxAN
	 0/PAQqachMz+cq8LsX79rkmjOxzD2nHQuhA2c8AcZb/eCtsJId2jS7zcqzRQMySreAbwk
	 hD9B2bgf5NeDYuBF2x+1jhAylifVHVCnITvVWCnd++4VI7PFM2Hd7VTkQSI6qVq+8Isdg
	 kXQmdKZmBMNTx0xZmnLUEm1ofTFivwqUwd5b2cfpIdvoNv056E3Kf61M/IRL1sSyU7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0CKO+5RSsG8ELN5U388bNUvgwh5IBlIfeDAKoc93boA=;
	b=yemqgJid2NVDw4Tea9SBKHsuzrEUXcr+X4x2hRGdB5H7++CIqVfkD4dCaZF5zDBxRPYi
	 JI+ce7UoHa0Z209gFcEgW/NTfZWUSYfPFsTzJdv90Dxh7BY+YvM4tN72U7c4htEUZItEm
	 BwKcUwAMakE3HptbBPoFaF8Fe+BS0PM6i3X7iHdF0YsEV79VTQoM2JDcuwa221nMKwRjR
	 D7l5OIXTgdYxmN5NHTIM9IGLOyzo+JwHwPhnsupcyMmT9ulSgUsvkYyFfPNv8HFzG8HeW
	 PN2/l63aMjj0v+1mNKmi+5tgBpOzjZaxi/jGoBhwhKKy8KkBVM0jMesVrxVad7/lQGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QD3wwCcn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7D606A339
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 15:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCC7D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QD3wwCcn
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67bf27f179aso2068370d50.0
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 07:32:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892778; cv=none;
        d=google.com; s=arc-20260327;
        b=ZUriY/oEuiACk6SxjeVc/2q850z+8TH8YIWJM8n4ToKh3WCITHK2UraIojVOrT7/Po
         XF9Orp8lUsrJj14C76pJL9Fp1+ee3TezwcXclaoHdBSMNvd52IvdVjq1vzsW475QSINY
         DXDFzv7JpAdIPLNogX69GikhbAX2sb8lJJ7fhRC6PNqSjAmEbKnZErzPPmNlHVNpqeSy
         WZgO/DE84QWSoVJo4pKNwssHmfKFdR9x3sB8O52dZEHHds3Y5HJkMMz/30GVVUwEav2c
         AHXseQ+o1I9boq+/Y+utD7RCtcLF1kayVk+9+TjKaFyCz1Xjol654YbO9hUM9Z/HKmX7
         lSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0CKO+5RSsG8ELN5U388bNUvgwh5IBlIfeDAKoc93boA=;
        fh=JHL+dlBtetZKWAunLGWKbt14h50PoOUW6V+T78x38Ms=;
        b=JO9i9dYp1pJdijzUNbjHRUhLyi9D0FxEx4CKEaIgr8bACFtIETtL37TMimculmcWiU
         iVRRxpd55l0XUne0+TdM2l/OMgT+YbmTDRc2qtLMPOvHvBwJlhFj3nuwzu/WO4QsQSj3
         qqNficgbC9TwqtwWWVitMglNKsuc4Crz2WyHMlTXITnSti2gKaT/B9N1gmoZFgy7cNzD
         7pln3rlFe5I6A7QhiBGq1Zq5Wrc92vzca9oEFnWGCkFiqUinViDNAjdDaENTzwoFxBBM
         ROOLnXBc5n0owQADIu3XoBVg87ECnYpmi4bqLuLXjDTyJt23C6PpW1aXWtHHhTaIHudT
         NJ+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793892778; x=1794497578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0CKO+5RSsG8ELN5U388bNUvgwh5IBlIfeDAKoc93boA=;
        b=QD3wwCcnOZe/D+WLK39dU1XEiZr0vsHa65JcRlLH5I39vaJCow+kamefs+x944fOSa
         jvOmQr5RA+qnTs0eNPmMdLW8Zc7cypgPgAMTa06QPiDWhvVVgpzxtOShD44VO3CkV1s2
         V0OeOVzTwAwptIrxpnrdxMNWKYA/VAv7bV1IBDsoAokyQIVjVIzQKGUJ01sqOPIydHIs
         WLK/w50wmTcKNfRuusfn4JDDxw7eewDR8Gp2Tv1bS6qiU50gEqwBKgsCfsHGig0Fig7F
         slIgCcT8xTKpYcQ+e7D4M/dwWhS4baVH1+oZaMuMfg/BOgHaqTd0BXeHrbCzuuU+/Whx
         JGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892778; x=1794497578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CKO+5RSsG8ELN5U388bNUvgwh5IBlIfeDAKoc93boA=;
        b=yCdlXe4XWa+6Si3CTesRYpxU2ehKypZz9PKs07Q3LY3wfFNmFBbd7gZxuLOsFtfL5f
         GTwL2fmkJHk9ItN1MFnStnqdC0qr6Px1tFquxA/DGYoDyjOShmQx7flLOUgds8pU/O/o
         wzBoiGTSest456pkl2GikYD1LPyM0aTkDoTUu/ihcJ/Q9wjmekATUXqYjI6qzW3M6Agg
         aZp15bCsrYS+5jGWvUcxnzRpyp29AHPyZOZRyc+liTXLeh0kF8wwXjFlVrO1JMiRk3ye
         WhnWBSOGkZCOM7rLDqFs2vK29t9Tn/6DLYhL4rVNs28Dd4dKdTs+GMbcPDp6obDRA9bM
         OunA==
X-Gm-Message-State: APuU4Z/70bpQZDwlDSWba/MfuzuhwLmwOY7vWxdVaYfUyoutWcC/emF1
	zj0UD79wgqwsnjiG9iGfY1jBA5JB16iI3i+4nZBUeYsTFr0/kD38ddNmSbVZdPRtN0IoqPfRnjt
	Lxx9Dzw2c0XrdoR/KzP6Ma0NMCoUu0NmYPAq5
X-Gm-Gg: AYBFou116F0xYlrd7D1VdlIVf4VCJlH8SanfS6FQUFRYU10a820zf+SuzOKKfj//ZGB
	/rOUcFE2hVwkxQdA1Yp7znlDTAhIYK6ZQlI+2JI5Qj8rXlSfT8/t68KDMhz/5sOOna61ST27ZL+
	AxpUSi8NRAEjaHZINfvFfyg2WfyCOld6Ct2Zkcjq7izozEK8aXY2hIwnsQubZJk1ReYhzA+KRZU
	esFEofI2skFSvaY4ClvpjoMUQCoXuNnnrBh4D7ST+nFSZymtOl1WbHwlLcSEVC827/TrD5z5txJ
	8OX6bk8+btQBlzthDRn3oscwrv+3Ei9SZX1qdUbaXc6H+6HBp2Bf+IX+K6cLawqIObpfP9rMyie
	1qsZ+AACBvY6GtcLv6dM6P4bHa/BAPl8nNwtjAN1nzbuMvRJt4cc3AcQZIVSM7hheFJCHvjAp3R
	rArk6Mvy33blBDWTJYFnOOeYMUqgOGLb3iveB4QtZm1tRGXCBu/IYmASalZQ==
X-Received: by 2002:a05:690e:441a:b0:674:981:a937 with SMTP id
 956f58d0204a3-67ba500eef6mr8027779d50.121.1793892777491; Thu, 05 Nov 2026
 07:32:57 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928154323.48910-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260928154323.48910-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 5 Nov 2026 10:32:46 -0500
X-Gm-Features: AclHuK-7WZcpXwxk13I-Xl-nv_H7MooA3neNQH6gLsSeJBn1VY2qiYlgga9TYHk
Message-ID: <CAEjxPJ7fSVCf2y9f11YbMOzz9FwmcG8n0skqCFs4UTaQ-vtNBQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] Revert "tools/nfs.sh: comment out the
 fscontext= tests for now"
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This reverts commit 7738f9f68cedfe36ace71a15ae49ed3d9dd85b36. The
> linked kernel patch below fixes the underlying kernel bug that
> prevented us from successfully running this test.
>
> This change also updates the test scripts to skip a second Test
> Invalid Mount test on NFS because since kernel commit ec1ade6a0448
> ("nfs: account for selinux security context when deciding to share
> superblock"), NFS allocates a fresh superblock when the security
> options differ, so the "same sb, different settings" error this test
> checks for is unreachable on NFS.
>
> Link: https://lore.kernel.org/selinux/20260928141917.17577-1-stephen.smal=
ley.work@gmail.com/
> Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/91
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Is it ok to merge this and the other testsuite patch to re-enable all
the NFS tests now that the fixes have gone upstream and marked for
stable?
