Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795451401;
	b=cYx6R5VeRyurinWlPfZkyu9oVPS5NiLGdMOxddf4HCX0+5IzJo0M6L7YGoGUb8PTujy7
	 B7tMG+GoA+Bi4naoCDyB3pBeZaReJ+KeEunkhyDHBkSxWnk5neQZLwcuiWsnabF/HK78t
	 LpxsiQK+cgq8nPaJhrwz0QlrvlnBErtcghFkv9RpJq1OTParmTQ7fFZgEHT5sx70v84NC
	 OS58Zh217LkWsUHOmppy3yzMuWi+ztjYb88wQS3Uey33g3JmvfuL+09GVNDtR/PMZSJYy
	 CVS9mLhuxbqdCpKMfy9w5SUTI8hh4UTxPHcp+UG6oKI8lp/w9NgXaLlkfbJTHyvt3Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UZQyGiSlptqH/1n8J3JmoD+dT46q+GqjUk9T0sV4kJU=;
	b=t/Y09ew/GPL/cx9+Hxxh60woCZlXeqaRwkc/VyOw2odeHvxRXZlXTA3MUN1IS4s2IGaw
	 FdB4iWZA9pOD6Fp6O+pN0z8fN7jcwRV2BMMuSSatbSjOV0TOedqWWc/R82txhGH+KwqBr
	 /8m7n8qpBJ5a8UXlLnq3vtTU3rnJwiW6a9GJHGQnj2ODNfa5RsfqfDCV2xjckEzQD8Z6s
	 KmciQLHPzO/yBCHoJgvFE9utYXYfJqpNGjqbd3lLE6P04rwB6Fy8j+NCZ2+JbBqE7Gva2
	 tGFEiS76DTxQDQjmfo9GhY/5CsOvrgkqls7vPBqAloLFGZ8lVAMMXGlevdnaBoZVcCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pj8Mz3c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49165606A31A
	for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 16:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49165606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pj8Mz3c
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67db0791748so3795763d50.1
        for <selinux@vger.kernel.org>; Mon, 23 Nov 2026 08:30:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795451400; cv=none;
        d=google.com; s=arc-20260327;
        b=k5VdQ2IRWY93LBP95q+V96jG6cKNNxYktZdMhNTuY5a0JWG9xTkGLPgTPmWUy3MyOX
         2Ky4MmQmzQC9WIEw7BXycoHyx+HuGqYLNrbxahTHs6R05aaXBMoLwdyODKUZ/ta4ez8G
         SZsrzrWlf8ugncnNB6Hr4/ilmg7+mRlj8O06WmbwkwHj2N0oYovV/+nb9EeqIiuPQWh6
         NyyU9zgvrfv6pagq4bESKxasiUceKueyhGwfblzq94APXqPbSvXUu1YeSBhcDOs2wk1H
         JzsfxwZywxC29J+g4ZQQ0EJbrrNmGebKSFmPtknYjItWnm3rTpigGFtXpBgIFkLjo4ql
         FY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UZQyGiSlptqH/1n8J3JmoD+dT46q+GqjUk9T0sV4kJU=;
        fh=QFKa48eN4AZKFIyrSiZk3FCE4nUKAEfyzhRYxfFXB60=;
        b=KVDwljJbJj0r9eyohdCI9vdR7H8uQCKLqO7Mvelh5qs9eUajN6Q3G/bCcpiNEh8TFS
         6MOb8WB73sI3zLSILRkun4sdLEDIVTZ2aqD0JHItR+odtE9D/4+UM7AflOwfm7hrzkd8
         QXKx+Jbh/9O0etPNj6ppiLigxCZnrIc8v1O+QTUsG2/OQaQ3YMGOM8CiNPUsaUPxcf6L
         ZQvnxEaPkCgzSygq+be/as4ixLc3u2G4cWV1xe2ZxtdnSuhNYlErCenGKaVzz8L2EZzU
         Y89mOyaooc50T4RrfWaaSzAPuJ6DLdOc880pWsyYxVCRHae5DGaUUOpLPfyQM+RsePZ6
         kQkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795451400; x=1796056200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UZQyGiSlptqH/1n8J3JmoD+dT46q+GqjUk9T0sV4kJU=;
        b=0pj8Mz3ccYL/0Pa9fX7eCs3jPmj1SR3yUPIZTBNWDzR713jq7FDTH2nS5veqJYWz1W
         DxD/d0ohFlJNUPnmyJCJ1JqS3L3wqMeBE4c2wb929bY5ZrlTlmy9rGIjXONiWQ1FzRVs
         YNb2Co7cmpvRvoGmC0WykDsWPoqBHSMtjmuAbZZpS//mhSxRMOW1nLjqg6PqwraclYXE
         pcCz6Mg2NaMDWP/vJBA/81CZd0uRy6NYV4/bYHqZSQ0L7RYwj121KpJnMPcWCN2qsbuZ
         Ohq19l82zVeINC/q39XSSiQnITAhh4n8pN+3TCKDoYGsydvb0kLmTCHL2uM+TgfSmoKP
         O0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795451400; x=1796056200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UZQyGiSlptqH/1n8J3JmoD+dT46q+GqjUk9T0sV4kJU=;
        b=0rOR+y57Vm36AKDPHI7UmQCpnv3e4RZrp20K6HP4D63KEf2JlZIFCJoA2C4MCNHt19
         dAcFsDtrCaIlFdEK4Z8ueMS3Gz9Wm8mzi4PjGKRutLOv9c2RJiEL0CmdAlEotYirwn2I
         FIMqRpEJgF+WjodYP3DS+5v5CKY+ZN18qV/wk8qMiMap68fAsBGu5rF0461vLyVojXwP
         g+NodMTkzBjyKRC0PAk2Svjha0AgSQYO/FuKiLptZto0N/LDB1+GUWifcv4rUwFzBN94
         E6gPd9as7lYt3NoXblS778mXo9Fni+pOl+5vKauNPfJ38OQTS+u4kpqbYujzJj/2lSx2
         RkVQ==
X-Gm-Message-State: APuU4Z/6WqcvjhiDO2Yjmjg66he5hN8i4TIEpqZ1Yyoxpz9l38duVL1i
	fd1MlGutzgmWdawV7S2jV0F4SmJXX4yRcn0tETOm2uxxIKgDULaGTj2yXzKVsBSQp2aDIVeWm6/
	r+dLdVjTcy37zd43LTXi4YH2eYKNcalAomxjo
X-Gm-Gg: AZFdTZcXhgDnbJCWhkiFw/4nwKFMVOTfwoqpzECWyQVpit7iJsp4KIKnxoEXhx+Fkjk
	xA/coQ1eohQdN4485i+XC9Gvc9cdA7DF2gSVGZKn+UJVm3ebGlKLvVv34+HPWmm38yJmxhu/jiz
	onM2QmuVQA5D+dMJlIq46VJIfLQxHjIcHG0syZ+YC+WiGR9FeHEPio69O6CManaop8piriBkx1s
	eCNxQSt8wMkxIwkTm4o+Iz1F+/SpDbR3n4ziOtd5VQqRq7615F5NyrtjV2mSR5g/Vv7hiQv6U01
	i+IafCu4vgndkDVbSIVfjWTNwVBdHSFBDfoM/DKO+XP476/buOhvzMXlg5TxqRN9BLuYHAMEfwD
	jPtzMRPFQ/BovoYHTvYfPxzrWyWTojGBkKHTguSMe3WkMsCCElbseYI4oHy+FEE8U4DveO8WOXg
	C3f1NrG0N3FcoS540KxXb402qMA6RQrBQETl3XDNVL9OM+6yxH2phhZJY6K/uqlCoG1sQJiXdi6
	VWNIV0=
X-Received: by 2002:a05:690e:4385:b0:67d:a1d7:674f with SMTP id
 956f58d0204a3-67df44500dfmr2990905d50.78.1795451399906; Mon, 23 Nov 2026
 08:29:59 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123145414.55475-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20261123145414.55475-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 23 Nov 2026 11:29:48 -0500
X-Gm-Features: Aa3M54qCa6p6UzK5kwBoXQHf4XRbqGIWgadggH7HkWuG4PVZO4RjZoT76eVAElM
Message-ID: <CAEjxPJ53+V7NeiJCzB-6mvkR0szj=YaOtCRR2q9Dod69rBhVbw@mail.gmail.com>
Subject: Re: [PATCH] .github/workflows/run_tests.yml: restore clang jobs in
 the test matrix
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com, 
	jwcart2@gmail.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:54=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Removing the gold linker job left an exclusion matching only the
> compiler, so every Clang combination was dropped. Remove that entry
> and retain the specific exclusion for Clang with the BFD linker.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This has been merged.
