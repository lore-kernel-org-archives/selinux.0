Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793996207;
	b=Hj0w6Ot0YFwJq5/eQ152gEyv05KqJJdtzEte7PtxTWgJNj+xc7UnMZCP4pxI41Ifxuwx
	 w3JHHLoO33iQtOm4njJ+iFpZvFBlwkaVBq3TgEL2cUKLn6odCLpfS84LRffHA34v5I3YP
	 FzkYRJz7g8I4obQAhmXlJmnEBY+X2gvZrt0khu1x+hjjQWpbB2mgW5wVHYpBoHjboLwGw
	 ZoD32S/uf7r4U5f+43f6F9oYCuj+Uz+J1/OtCjpGNipFu3M7dn+yFRJLEsSoVE80EK8UZ
	 JCWkSk79GQc6FtyWAwvA/0bYoLrWC+6WF6rLLXTLDf3LumCPGjCUHd6Cjq0IGTdZVig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fAvF16KjFDgDFoq/+WNVGwmlBlWdmAIfp3uu37dPxe4=;
	b=kTNB80tqMJHi8a1MY9EoIEeYksIdjeXsGcQhK6tRHL/UaVCmWJbiiRX5BaHLzMuAf1ad
	 J0ffLgVqc1xEZyjHcE3iMLBqjm882+D7T60LFKfb1ffvcbwURwgSLKeWurLRcC4gHW3Ne
	 Da+CKfNkc9L3byeikZ9rlTfdPB5Zma0a4Txc6ahasTtE7yGUmJZGenVtBVCzDYb1vY7H4
	 w0bKi1Ohkpi5BGqzzVxk+zm5gwDoyu+wrNfxDyxy9m6So6Qe6gTY90tflCxgYAhLgTHon
	 yhH5yj5zUwiClIo+WLz4YU73zIuRweRP0go1kQT4qFHoSXq7shA/xO4XM0zKjXIoyfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWvvlwdv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017EC606A32C
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 20:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 017EC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWvvlwdv
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso13253887b3.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 12:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793996206; cv=none;
        d=google.com; s=arc-20260327;
        b=VdPkAkuiTpO+13KZQZfOF5WHXWqKPiPf1iHacrQlaxXSOGR/efruCAbpWNvZshTpeH
         72ZsNUHiD3hCASBBohSQ5yVQ6lqxuUzPCsJZngna3obYOr6YjNMI94UGyosFYFA4jfop
         wAjUlgfPhC5BN68EAipnGa47bUk4UtM/Hi4XCUWWXBCVAMQYLZdDj89/S+/4nXkB/RkX
         Pe5tVw/eozhS6gkCR+Ia5p/p9/D+XCUIPAFO0oQYc+s27mKTkbhn1H/QdcNGXSX9rQQA
         N2N7u9LRrC+eWbg5T1NvomttFCVm25zC/daKra7kYf6CU1Vg5gfO8C4aLx9kgAZE9Arb
         ULiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fAvF16KjFDgDFoq/+WNVGwmlBlWdmAIfp3uu37dPxe4=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=F8fhlZl7OWH/BbNGGk6FOFB3NddqW4RDKFaOR0w+bgkOTaWVaIjM86OXslyXJjAU9n
         IpCrYJIOSBf8OoYE44inAiEflR/Mp2fgwlk5N4XsCH705aSLKbL3+P1mbOo7pLELA/lv
         MCMG8dEIgpMQsAGoZ70eU6ckMaV9f5MsJzTfLz6DCrDfWKpIkmody8Fsaf8+ontQuusi
         n1IYn65KV74fAb6VB1Ylub7ayrVOzUZuvZrXcL+h2UmvVqziKqBz8K3UI8ExAO1odRhf
         O33vlyyUSoq4tzKgkiR7XVDRt8nvxiq05tyDQX2l/lM0+ts8MEh0UTSd/6xrTY+TWj49
         XK3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793996206; x=1794601006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fAvF16KjFDgDFoq/+WNVGwmlBlWdmAIfp3uu37dPxe4=;
        b=IWvvlwdvmGXETc2KkLa9jsuhQjO2HA/XJWycjxXx//0oFgDeAEfalpOcUmhtmu3M8C
         n7BuW77Gg7doxuU9sxNegkmYpY5M//kqD2EFxtWQnX9YubO4shdOHY5tDNWz+2kWWD2o
         rMCJRnkGD8fvff0Aq4WcEx0HOJfnvQS1EP5qjv13oUH25phyyXhMzQtx+SgLVEejDVoD
         Mk3e5O+3S6r2yGG3LcO4a7/DppcEwYk+FOFqyvfVCMLqxwNRvdkKL7IGnqm/jz8ghGFM
         KR1u4ihegguq+6fTJRp7k+5AEHY8OubexsaC4Z2yHaDoBho6TyBtHeCyE3rg8N82TN2E
         EXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996206; x=1794601006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAvF16KjFDgDFoq/+WNVGwmlBlWdmAIfp3uu37dPxe4=;
        b=vMVXGVRBcTrwvHNIC5B8kKmM05z/1mrSknFer1lcB2e24YVCUbl7Z+cJlzqwrNx3km
         OzKmA1yryY2Z6SFGGj7m211A57ovXvGTXILJToLsQwX7p1a6/etmrkgRTYgUNpuCM6sh
         VYyYDRaaX/FeLwn26fOSY2JVakWs+5s4hWTJfodDYqPQn20k28Rr34VNhqTk6IVy2LUs
         lENNfz1xeA4HPv5Tw2qJaM7LgVj4smMJIUyo4GO2sbgYunScByR98+TyLud4DQz0jN8n
         U18dYC65aQ240Y4DeDXX4Ha9DqB8GYUzmdLBFtcwQ2H5ucDezPgfFMqSIQzDXXUOmQoZ
         ljUQ==
X-Gm-Message-State: APuU4Z/IFl03BE3LQxIYPBhI+CN1piOoMckQ2q6BS3Ub/31zRuLKTibD
	Qs0g5meqCdCy2ujiUfLP8LKONt/KDHy1/Buh+moOr2ja/2/sub5dClJVcdFHlJL1dHQ6obBxESM
	viPAjqzAVpN8cJ3J/qwsUkSHEgll5vWBAOnK9Ikc=
X-Gm-Gg: AYBFou39z0t86gktvSW+bPVXuVh3ao6PTgVwcUBHfKZnL2p0CqBEtV2jX2/WgTYvETA
	HtWzfXBfN8cJuqWAH0Scq29JudGKqvk/8AZHobzc+iHCPE0354O/le7g0/3xWoSSBn7YVEql1Lw
	urFcwF0SqToT6o8lhad8C/8uuu8Ff1Ss7Pxw/CvqF9mCeFPBRw9U/No/GPGJomon28CRMHs2O8h
	AgK6rhXfitcO3IC9/B88IGGcd1v1xRN546nLmSGmSSGV/PWvbj3zQ0buXaq2Rd0De1l4cP1HgDF
	UJXINwQAPC0R7/eLXPtItISAB8iFjuwMHG+0OpElwM9YQE5aYNK1W6LXZGNvmb47yvET7Ar/UqY
	6CWOpRFgkLeIdZwLGHExjKGuzx6tqm8UzMF+BEhGpsu9bOFNTAlqRCmjXbjhM7NIfJXf4WkhtDy
	fafvAm+Is8o6LYEVTI25Ti4KZSdXxITrFwgdQOM/5pGFxEvQBSspBFXwknPfifvrLk2QBpqgiMA
	yR8U/k=
X-Received: by 2002:a05:690e:1c1f:b0:67c:2674:ec65 with SMTP id
 956f58d0204a3-67c2674fbd8mr470923d50.59.1793996206032; Fri, 06 Nov 2026
 12:16:46 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106131652.267648-1-cgoettsche@seltendoof.de>
In-Reply-To: <20261106131652.267648-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 15:16:35 -0500
X-Gm-Features: AclHuK-6SlqcZpfGIYKiA3kMmmhgG11rpmHAJ4uatoyod_Cgquub0XIuwRm5Vk0
Message-ID: <CAEjxPJ5GXUcUD58w3NeWqqTGPJirii-HHUR67pK+SEDv14Awgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: keep the uncompressed filename transition
 format for Xen
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:18=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Commit 890bc6bf ("libsepol,checkpolicy: update remaining policyvers
> comparisons to correctly handle Xen policies") restricted the
> uncompressed filename transition format to SELinux policies older than
> POLICYDB_VERSION_COMP_FTRANS. Xen policy versions are numbered
> separately and never gained the compressed format, so Xen policies are
> now read and written in the compressed format instead, which is
> incompatible with every earlier release. For example, a Xen v30 policy
> with a named type transition written by checkpolicy 3.11 fails to load:
>
>     ebitmap: map size 4 does not match my size 64 (high bit was 8)
>
> and policies written now cannot be read by 3.11.
>
> Use the compressed format only for SELinux policies of version
> POLICYDB_VERSION_COMP_FTRANS or later, via a common helper for reading
> and writing.
>
> Add a Xen v30 binary policy written by checkpolicy 3.11 to the
> checkpolicy tests and check that it is read correctly and that the same
> source compiles to an identical binary, as a roundtrip through a single
> implementation does not detect such format changes.
>
> Assisted-by: Claude:claude-5.5-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

This breaks make check-format:
libsepol/src/private.h:53:36: error: code should be clang-formatted
[-Wclang-format-violations]
#define policydb_has_comp_ftrans(p)                       \

Otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

For this and other format-only issues, if you want me to reformat them
for you, let me know and I will do so.
