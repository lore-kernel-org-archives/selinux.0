Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA361471D1C
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859208; cv=pass; b=rEVSIAftorkUEVHuA9HdmwKwpeEkPlpxYW/UkpfDgWwTGg8QMWicfHXkyoet9dWVwyNkLcHVTNFmYe1sZr/GcaWzqh2Ws4/T/hJw0YI1jSfQlfQWHCBAsrSDnYFTOOJEdFPAHrsBNt7YupY+VBvHkkmxqCL7+zF8/uYo6k+hL5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859208; c=relaxed/simple;
	bh=22YDCwDGFPuVKdQbYYiR6dqt+cjTpH7O7S4K5cdKBAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7JSaCo1zbXWZHc/81MVh5g6LzvOiMmb3zTLR7/YXUFm4m7EaO7Dp5t+Gxdv9ZnRVL9iEw9JDlPgW5ZqeqB5YG/GHEc+86EE/mGWBawXChkGmVPUYnn0H2K1c7z+lIsNSiBdcVnxm4+ECzcpIQ3wnqj5cqwL2q905ZfdBZKNOEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0dKipgH; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0dKipgH"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-455ca262ccbso2902219fac.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 09:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785859204; cv=none;
        d=google.com; s=arc-20260327;
        b=opYYdmUDormUb3xmIkmgWxdBrZNizMvodv8VJv0f6KZxVjU9K1LZJgtkog5C+KrfZc
         HvL6MenH7wrFA8h14yAKx9LiTi2d83yT6BWWdWIn2SpyRKglIfg3VIPP1knHpXEYPoMT
         iq6gPQWQpOubBEfGSm2Oa72xoz02++IZByN0mxon0Hb1P3hkfERNMxBNPKxXB6BEZL+5
         g6f56pkUJIawYq82PqqRr1lfyOg6yLLDQW4ZKwV2AzHGAPlTiwSw6DYlH5uIOy8DT+YQ
         iCH2w8DTX0mtwWPhtl8uiTfttoqy3Z6jnzzFkysCekX4yYfoN2+4J7gvw7A2fLIvDgQ/
         LvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=22YDCwDGFPuVKdQbYYiR6dqt+cjTpH7O7S4K5cdKBAU=;
        fh=wY5cFNIrFxocNXn8dhXLjCWtx2mX+LDI2hsGzEtklkU=;
        b=XAboJE23iXWdy39wyr3XlU8PLMPHnP3L8v2QwuRHHQZVkwYdmh41MWqTkvFcCLVzy1
         CVU4QyOJoYW+toCyUvvPJw5ZJCyyp/2tpFRPUNlXWcOGwCODXnEFfL131PA56YJkd/sc
         hfU3PZ0MsXKNtD/9Ksl9L+hegSThi/jGRbvSpmfraBYgjsB+QZXDDkN6nuZ1TsSSw+Qg
         csd6WDPoUSasvMTTPZ23You16cA+O0pRC4BXEcaSQ5MZeyBzC1bWliBLtnfSHh6gQb1b
         ZSqWCQuJahvIIpSgXOE2svAuc2YSR95jhLUfIxIjF3EqnFh61hYXXt44sjYDCXeiVxLE
         orWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785859204; x=1786464004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=22YDCwDGFPuVKdQbYYiR6dqt+cjTpH7O7S4K5cdKBAU=;
        b=c0dKipgH2vEXZWNJIeisJmiFyYZyjM/kAzDHQcFOcezxWxEs9WG7uH9NFR6pI+w6KP
         Unm+hAxCTxNMuqj7A2MfWXWF4vysvbT6V+vSYIinY0UJ5YdFmocsQ5mm92MVEv3cUJU4
         aGcdZiwCU/ofhlZbNojzde+szgcyuFHsNer+0WkCrv4O42L7/MkjuKXSpPxO6v5+MjQY
         vO9tDUBhnuix1ckpZEXvP5qbXxKo4Huj4ce7Bi4OezVptd7UtyIJ1UbvUsAaLnUxwv30
         ouK0GfQWuLIGDnmqWWt69Ma6KCpAB2f6qNPCHlUSwQZLVxlSf+VepeV9MT1fCt+XE94q
         NVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785859204; x=1786464004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22YDCwDGFPuVKdQbYYiR6dqt+cjTpH7O7S4K5cdKBAU=;
        b=VIm6Vt9RTpkv2PQQ3paFf9fVeLUAkEObfsz66UAbs4S2wlTCnePMDU0ZHr8AoY5Ynm
         F5NEzMjbcL0YQI8FHcRGbSB+66H1NLvvqHFG9q9dF8ITapm4OUl//wBnDE8+ObWFtsZg
         eTXcEUL5t9ApVcFUTeCoNdi+vSZTKxlLPSYGr3Us5x5APsYtauUWW6GKaEQ9jvKttUWt
         G4EZn8Os1j0CXEGRNkC4JrW7AF5zUDrIzTuznCzSwMIELijhcSzcUt1vofW5fZznUfPD
         ol9P+yTWqgkq6p3j5X+mvRxM94INmhn8pc1/l0tR8yvjOARqyEbpov6sVnlwvfTMkOEO
         YhVQ==
X-Gm-Message-State: AOJu0YzmA9ZdbJVS2kLATADglatQra79hbyyC+g9yIT/3EQ1SAxTQVxe
	7TYQNw/QFmijpRTAXnVLxPoWWaT4rTgbvtQz5JV+4cjbwpGr3QOCT7UJCTMEcg3WDQISqzHHNui
	8GdiNvcDR07BWJMbf9JZ3RUAE2yfcqsZ3/Q==
X-Gm-Gg: AR+sD11uHE8S27wgZn4Aj5o/T/n4QMlqpa7BkgJ2P34Ht2L48EoiERVRGCj60OUJEhs
	5Bdm8yLhmxu6leBGil24myP2dXpXJT+h30I+L7NQJ5hO2bhfGNdZn3xa+QUiY3ZR+8/26xAemV3
	y4mm4vutKqERxvONuSUVOWXF8M5FOALwlqt9DE7LhphYl7Zr65fmXfk81HMC5oTkh1u89fveUVF
	4Sm/Uu22jyXZEZAsgKe5cv0hYwA+/xkbVE/cKzAtpSWeEbaG/CssFNmCMJ6hwD0xLVOpaS/vkzs
	SoKtuwricvXWvPVaEPEYZIk7l7lH1EqIRkrgbqLhH1SDCNnfcR4k5uw=
X-Received: by 2002:a05:6870:569e:b0:448:7ecd:583c with SMTP id
 586e51a60fabf-45905a8ffe9mr22169738fac.17.1785859203751; Tue, 04 Aug 2026
 09:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804122505.54855-2-stephen.smalley.work@gmail.com> <CAEjxPJ4ZGDkQE2eiQ-PUFJ_qG5aHEOE+w4GMh+qXNuNmPMSpqw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ZGDkQE2eiQ-PUFJ_qG5aHEOE+w4GMh+qXNuNmPMSpqw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 4 Aug 2026 11:59:53 -0400
X-Gm-Features: AUfX_mzYnihx6WjdszG3phhox6BgnWIYeESSBUoR54qEwAk0pql3iP9Bd15-bfE
Message-ID: <CAEjxPJ6phzkZDq4Y56H7d4qBpnLBiH1ZjZkx3tHBLQ6Leq1k8Q@mail.gmail.com>
Subject: Re: [PATCH v2] .github/workflows/cifuzz.yml: update branch and upload-artifact
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 8:52=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 4, 2026 at 8:25=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The cifuzz workflow was still using the old master branch,
> > which was recently deleted. Switch it to the main branch.
> > It was also using upload-artifactv3 which is no longer
> > supported. Update to v4.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Since this obviously hasn't been running for some time (was never
> updated when we switched from master to main), it would be good if
> someone could confirm whether we actually still need or care about it.

Merged and completed successfully. Seems worth having enabled again.
