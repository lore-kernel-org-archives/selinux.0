Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DA1C3BEE
	for <selinux@vger.kernel.org>; Fri, 16 May 2025 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410275; cv=none; b=KWQlF+K+/Fm/rKSjMYEpOHkfhxS/SJQglcUZpepOEiKIwnfPB+PFp7i3rps/j0zM3gErD+5h7/59OtY83uSlerqR+tzx5PBukparil8K+37hS9l9W2M9PIb/cEr5PZdDgtvpI42h3RaRJI04P+3PK3EZwkSiw5YImuFN1g92KWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410275; c=relaxed/simple;
	bh=5R8yiBl056IbwkqIJzcg8v6y5YTmXde/CMC6Ilr4V94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=heKHCKmQDvaI/kZOaXLWloaOCJut39ORwq988hSlyv7XCByghPwifYhEoSRxzdaStmUS9A2cz23age4rfev101WPzB+TJ64QtsAZ6SVWgbMr/EmnMxXw3p8fr6smHipGCN1NbxGmAU1ZLvum+Cx8emsDVsAVKMXq2dtTgNZgx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dYFzqkHW; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dYFzqkHW"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7904da218aso1733248276.2
        for <selinux@vger.kernel.org>; Fri, 16 May 2025 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747410271; x=1748015071; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzOyIMmVypAMK1Of+a5OEJBkqwW2vK/RLQKqPv+tnwA=;
        b=dYFzqkHWTpBP2BchushlGwRrAk9YqAn1H3ziIlu2mCXFfzx90K43rr+1n+ELdjI60I
         CIuezHO4Zip1DhsVahsCjaEYljJ4xdGK3BhVE6PVrLtTXbiBwyT43DD8suDwtHd/eHQA
         Vjm+MSew9ExIK8Onn7G83bmJq0pygiPWVwRXMmFaWu+ni6Bdjm7Uih/4s55aD1/EjYYU
         avqL4VYBCo8XL34DzoYAS7X9eBEwBOUl314lQ7XcXxvjp5JYc6pjXr+nX2mkH1FI0ylh
         gXDwKz5HxSCPNHpHyeWsQ3c2iQGQEKpjcPbgE8IDuUt4mtBz/Dqdcn40tVesjyNOG3a6
         JxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747410271; x=1748015071;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzOyIMmVypAMK1Of+a5OEJBkqwW2vK/RLQKqPv+tnwA=;
        b=OejKJCiF7rOxLSJKpptM+kLvb/lQFG7GdnpkLIQ68qjeavd5tC981ba+k4YWCHiWjH
         Mq3pAxPDVjiZGzHpP1IOFQjgzycCe9li6fjvJPBUz/6ZxCVhQZC0J61MmgHwyF4cElz2
         wbU/9MDMHLU/gkKYogbhvLIbl323yXaImEK0iaUq6phnGW1om1BxR8g2yf7KzQzDbTMb
         2Xy4WB7TR3LUa+QaTG0J4qIxEalqzGs4gHAXd//Sd3P3fNJm9Q3FclOswrdnOCa3jOEz
         0Y8EWYZhhP/KshCfqF2lV92WkVYJnt+sdWD0jROtbrF6+4zMzDKAB8oIMSwJmxmnXSUd
         j3yA==
X-Gm-Message-State: AOJu0YyhC1sdaE8G+cxwv/oeYfQxHTlh3HQxYDn3mOBfs1a2kpdhtNrq
	vqJPqMlkvk1M4G+fTzsNyJP66hylml34zJCu5Vpzhlk7nscHbP5wxQ1EiIQYjZwdbW2f+dyWeLc
	2JhT3s9jO6q/fZlbJBL/9q521KebgH/HI4Zf0+FVYRfGCUUHgp73miA==
X-Gm-Gg: ASbGncs+PAsruWBqM5mrEYpBlixu/czhMuTB+GoelihVyYLRGKWDT2dVWdHsPPDIDKn
	AYaIqUfvEwNG2CQx/Ul739BxEi3n9mPLe8w/1XeKc7+VnxV0/K1bsZtyewIV2PI3mrYtXQpGqD9
	SEVUGXPQKl0ttEgZPOuZheV0nbuTduUj1P
X-Google-Smtp-Source: AGHT+IGgH9zY5SKYEd+gCZ5QG1pPGeu5Ee4Ewzgv8EEJcaY/4wZRx/MCocG0cy9tsuv5O5m4ts8jt09aQl5OOSBYG1c=
X-Received: by 2002:a05:6902:228e:b0:e72:95cb:8c96 with SMTP id
 3f1490d57ef6-e7b6a1f177dmr5765644276.26.1747410270848; Fri, 16 May 2025
 08:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhT4wrN6ProQmhv1pgF_TSPWOhbSf1WRi3Cm0_M0nu6x+Q@mail.gmail.com>
In-Reply-To: <CAHC9VhT4wrN6ProQmhv1pgF_TSPWOhbSf1WRi3Cm0_M0nu6x+Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 16 May 2025 11:44:20 -0400
X-Gm-Features: AX0GCFtZY4KIhPihAJGfSuRGXoFDLyRTOEWZbjIAti2HrsAHa5duaBitXG6oRGo
Message-ID: <CAHC9VhQfEMo-8Mtugqy5=k=9QdBKrY-MQyqv3Mr2xuNd9F_3nQ@mail.gmail.com>
Subject: Re: Recent selinux-testsuite failures in tests/mmap:109 (execheap/execmem)
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 11:42=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Hi all,
>
> Between Wednesday and Thursday this week I've started to see mmap test
> failures in the selinux-testsuite, specifically in the
> execheap/execmem tests, tests/mmap line 109.  From a kernel
> perspective, their were only 42 non-merge commits between those two
> builds (via 'git log --oneline --no-merges 9f35e33144ae..088d
> 13246a46') and only one that looks like it might be somewhat relevant:
> 11854fe263eb (" binfmt_elf: Move brk for static PIE even if ASLR
> disabled").  However, going back to re-test Wednesday's working kernel
> on the current Rawhide userspace, it appears that Wednesday's kernel
> build is now failing, making me believe there was some userspace or
> policy change in Rawhide which is causing this issue.
>
> Are the Fedora folks aware of any Rawhide changes which might have caused=
 this?

For reference, here is the clean test run from Wednesday, May 14th:

https://groups.google.com/g/kernel-secnext/c/X2HxKsp7uR4

... and the failed run from Thursday, May 15th:

https://groups.google.com/g/kernel-secnext/c/cU4zkQ_gwpM

--=20
paul-moore.com
