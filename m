Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09604AB3A6
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346970; cv=pass; b=I9r2PBlT0bkimXb5fQQnRQAbMVV8hAsZJi5CgphnZF5xjQk2QLB+4UJv2XXf90LnuWiLeawdHafgQqjfiS0/Q2lbziFfXT4gnUCW80gCwrF382Gcr1e/eNmxQQcYsh0EasZM1V/fUOKmbijIOYc9PoR3zKH0n28pq3jY4cWqiFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346970; c=relaxed/simple;
	bh=cLOUr9ZHBO5gMsMzQOskON4pIpPbzqY2uaRPE2qHTuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtqFHAK4ChhSBF5IZm9qqOOZCWCJoYm0PzX14C/ahJf1HkiYf/qyT/oxS2zn9+lUL18lOZLsTghr45emJ7hfFfRu7FsBIhZ4p00xkbLUYqfsHog/7wTQZ9ISnxkRB/YEjmlD0JlWo/5W45nq++OV4rRLuaBK5wj4U00CcksCteg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6RZEJ6/; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6RZEJ6/"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66f7f72a284so1089124d50.2
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 07:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790346951; cv=none;
        d=google.com; s=arc-20260327;
        b=FsubjVrXg5UCgNJAeqYfidAc4O5nOqMJ+lbHtp0lHCFaylkUL1M5BkMMeAYsZ0sLun
         8VjE8tY/ZrlKFbHMVLJ+hZhvasmnm9gXwIPUo1jgaK+TQzWR8OPLl/SDPbUCJ/E8HbaS
         Ye2GhiAa3Bqpa9pcEAykGTt/WeF+gHdNyFqSGKJB+b/WhGDIKXqfGZC+cOtMVl7Ercm2
         337vAGrqAEfIqGPTAnzSzY1GipCtmAFN/wzWBtOBvR7JpoywNLkro0YSkUxX9HLxs1o0
         vmUclhFJ7LpIn4BKzpbFSj62fqlyRjmVwWsyuyC8teC7h4FBtT1+6FRNd0Ce4Ys3FX0c
         9JVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cLOUr9ZHBO5gMsMzQOskON4pIpPbzqY2uaRPE2qHTuk=;
        fh=O5OTJF7gLJlYjd+4wyYY6xoEmpPyczXlm4GpG/I2vLk=;
        b=A/47bNhsZyr2C/hr1lBrgkYB9xRGta6ppZ557J9IWM9yXbBodXezE07Ym3t3AncfyR
         tkf1lRC1xlXOyJLqR6MZ9Df6GDygJyzYmPbLVeXKW8IYgDhMHz6AHju6a/hGW2bONipQ
         goVUeJ0jxluO76kQ3wgHWgxKrGp1yt5L95eEdohNv/pzissJanC5EhJQQS9JOFPEGbea
         6L7FP3PQczxE6aM/QNTOcMufO3gwetDI3OAPIWohxNcxyU9CXLpO01wMIwu0NhnJndpl
         YnHKHkgL0VlX7mCTiBrKUA0GUfH8clQWSPyZifDISwQD35C7w6sKYih4cKmOkxrJhfmw
         1rSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790346951; x=1790951751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLOUr9ZHBO5gMsMzQOskON4pIpPbzqY2uaRPE2qHTuk=;
        b=j6RZEJ6/lGzzPJm4kSNlPeWfIrTjd6Ai1//cC7KoK2dVCNFOD7EOBA3wOMOKSl7s4K
         HXlKGVwvW+4S2bfwW3JPNh8eAAdVc29j/nE3Q8KmkV4kpANP/bHQT63ekadnipG0g+Fj
         bF6bJakn5z+z2+ntGmBzWyJ8Ky2pZPqJJleB3kwgTd1x4i520AvAj6MmL+z7RpVi0Crj
         siBcTgErO5EM7TY2FD9XIz6ewANJ3cLFyzfCEsnNXi4KcJV1fYjbaoHREFmrgtdEvnc4
         HmSVtw4plS2aHkEkhpLGELqf1aD48O43oQ3pxu1CVGqZcegXFHiemjqEpg7Refiho/TH
         hGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790346951; x=1790951751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLOUr9ZHBO5gMsMzQOskON4pIpPbzqY2uaRPE2qHTuk=;
        b=mngze97Fjj++rQosiRB1q3fjMKCTm3R+ZrFLILXxdnfdJn6tI1Zkr2hrPTvgGSvnrh
         QOhAvlM9xVg7co0IS1G9H4Sj7y59foKwUVJ9sHNvk/t+RvRw+jOwvbfVQqJCFA8Fieky
         qW1PTP3KMCxymxjIyr37jeNNvRtXKc7120CFv4VtJzj2abWoLdvd5tIP4Y8TOZkAGxQb
         9G5C9phpTzwDKBFf8SlVJcvFhuw1GlYS5e81CnAeYQhuCUDFheilqYo6HEHprrTcXqAI
         FpfckPyMF93/Jn9AQcFRnTfITv3qChrc1f1J/G2S7cx0+DLwBmkPSdLxLgBLBus4mpkJ
         vtEQ==
X-Gm-Message-State: AFuF++mGDgmaLuC3/5lwIyfqv2nob9TFEH0nKOUqnLAehKW3GDVP214H
	JDSKJRffiEUvVYeuWyAanJYYPPIR/J/IEWnQLgHPZFaSUc0jyDyjuQ1+YdWC0OI2USzg6wNlq8J
	+KPvaJoDqyarZEMBrliqdKABATFPqtRo=
X-Gm-Gg: AYBFou02fa50E6i8SFLdiH8KtFKXQ8t0E7spmPAkkuoV88i5XIwMXUVHZksmMUMm0MX
	esA5otM1+fcJAFSwkPyj2SuCovn6olpc7OJpzDoJfiwV2rKnRcjmwCruy8ms1cWAT7W08k201YK
	JUTgfcjLzBKrLz8xqXs2zKs44f6UWrwUe1rcuH3b/XB37ENnnooGn2AT1VZ+2vUJPuHBtaMFxFr
	pxaJe9Im7CF7tTuWrah2I5XF0fAkhV/nEaZYkkwGdvcDxP5dUFvFYv5ku92v/uIWgWSlf53hhpp
	4wHON1y6W3ElLWLjQMtDlshsKWvN5gpbEJIEnMdjwg+3nVeAmKpaWO4=
X-Received: by 2002:a05:690e:418b:b0:672:bc9c:6e88 with SMTP id
 956f58d0204a3-672ed2648d7mr3010485d50.16.1790346951217; Fri, 25 Sep 2026
 07:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bc6aef31-856c-4b10-af51-c0104de167a7@ieee.org>
In-Reply-To: <bc6aef31-856c-4b10-af51-c0104de167a7@ieee.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 10:35:40 -0400
X-Gm-Features: AclHuK_WcN1UCeWdvnnTLnutbuir_u-9ukeg4NaM4EpTWP03ehAEjp4WWejejLI
Message-ID: <CAEjxPJ435WLhAg7Q21R06meS+2YwZDrZNvCGtb_NvRP_ZPmWSw@mail.gmail.com>
Subject: Re: ANN: Reference Policy 2.20260922
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 2:55=E2=80=AFPM Christopher J. PeBenito
<pebenito@ieee.org> wrote:
>
> A new release of SELinux Reference Policy is available:
>
> https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_202609=
22
>
> * Enable policy capabilities that require libsepol 3.9, except
> netlink_xperm.

By enabling netif_wildcard and genfs_seclabel_wildcard, you have also
raised the minimum kernel version for refpolicy to 6.16. Not sure if
that was intended. If so, that's fine but I wanted to make sure you
were aware.
