Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5537C933
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406951; cv=pass; b=Qasq8+MKcFAnEU4mxAhTXk/V2+iyOegl8mTFl7VoV6WDY3jn0vsVvnpcgSZoMVHEDMd03hJoWlZtm6hVNWv68gykplhzUw2YyhyvMcUAGEbAQ8MRyOzER5vqCeVQ4np4jWpXD3JUhGtHrv+DqUxeoFLZO9YWtown0yD7kZApbe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406951; c=relaxed/simple;
	bh=pUGpi/C8hCgcC7TlRA7V3DScz4/+6eyeqSZSfbNE/rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiEdi57dBdA9UuzE7c8yEzRXYJkc60gKDNEIhrMH4stUH+nWDmCOzWNJyCDpoiyPYBM3A/JRDr+5AH4FijxoA9ZHx2dP1mXNN5Grl8BgHiIOTZyaqZnAzVxd9nGYMf1rQjSnDBcNf9kQTqOm8K4wDOB8eds9lSvm4fJgFyko2uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OenK+Xea; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OenK+Xea"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516d6009380so6071cf.0
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 16:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406946; cv=none;
        d=google.com; s=arc-20240605;
        b=GEhx4Iq3jB/ZS/gZaL/qGrERqHn9IjuMMae53M/SgVYxRaS/H2Di2nnWYszEBm67+R
         fr/Ca0om/KP55bfNl8gXIIILSITBPqghRn9HRhQSE7wcK19nhtjs0wxnPVJn5zi0u1ro
         sJAW9tGMonh+wOTS1+fR/yNUnWitwLMmRvNM4zu85GqQjgItwotTP4fK9nai0PqnEWKD
         1bpCEilT2nOgQMV1ogYQBBIJKT6VWKrQBKIK1UYvckKdvEdKAks3jzbLxgmjg+tblJcX
         0XLY0HSUk5j5Aw/X6NgPZ4nG+4az6AeIsHaLWfbhk10UpKu8FZRFsUykmwAiqti+if6J
         6upA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pUGpi/C8hCgcC7TlRA7V3DScz4/+6eyeqSZSfbNE/rY=;
        fh=B19HHMpi2aaXmTIVJP+SZRGHfG2i2t8kfBMP5fHLakQ=;
        b=W33jdcrKeJ8pLAss1GuOCkEJ2OJ8vyDmALiRt+r/4O1XlYVzq1OKXurP05VCM5+yJR
         jXiw8+GnzIaZGG3z8mY1WMB/Gfl1TRSJ4jjzNVVm6B3vEwcZ4eP3gYsnPb6kXG+MGYFc
         spWo1b/YXnf4Qm5QxOaEX0uO+4VuRUDO4FsFVUh9TYlx6LUZL8GZE5TVUdbYSjFAkhbw
         vRuWqs1mUCbREYiexhP7LDe2JuqBbz3DTxxPCGTNXXavCvdftfcQDH7wN8oBUsrT46HU
         69W3OT+lXtIjumaOPzl7zg1cr1DRJ316a11t2w7GuW58Z/OdPjD/EtSUzzpxruFma6eG
         0XMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779406946; x=1780011746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pUGpi/C8hCgcC7TlRA7V3DScz4/+6eyeqSZSfbNE/rY=;
        b=OenK+XeaI12UJ7jygEmD8dDA1shY7zZKvE8XaPsGMFZy4UgVjw0hcrr9GafR2bwqG0
         t5kQ+lm5Ca8lonbPrsL7z1xHE+zDm8orgbi+/XIAf1dCOyqFlG9WGb8dvsDlWKhENFg5
         XkgwSLrZ/BiBR7+aWikO5h7ugRR2PNgIf+Hf9FtPiMbDsQ/p7blEf2xi5ZEFk/gvQx1T
         tfWwQRb9A63amdAxXhZ2tSyzBkA62iu0WoyuSmFJvP17LqSLGnJE1/Qb9vVGUHLxh/z3
         3UFtCp6lPp1zpG+ocE/2mB71ji+MiLvcgSn5ZgZiqBaTAoJ/S2+HMJOeslUJV3NWlThB
         hxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779406946; x=1780011746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUGpi/C8hCgcC7TlRA7V3DScz4/+6eyeqSZSfbNE/rY=;
        b=BYAcOfs0KvRjo5e6ARDdXu8b2HCfhOYd2+POZEwjQ8Lu+wt5cZboH4ZAuSyt8njk2M
         7dnpDnFDmfp1NkFjxEQ607S90uoO7F4U5ziMCn1cqMGVFPgSwdNl6/NIPfKzud7RGrea
         Lp/2YVlsfi3ELiDZhXQPzKcuqfqxVxyLXV/iyl9jSyKwtjqC8s9f+mpL5ZgEH8Ejgl9c
         bOdVRLyMzThXvkaVCYT7ub4i0X08OWWqje5vFJJkFymfhY32I66vPla8s23TcteG3xm6
         8jShgfYj8tOKk4x6pXlzdHDDbxSQkAsXOuV7AcDzChw+d+6CGnyNRkVdjapeFQCLjMFF
         GxJg==
X-Gm-Message-State: AOJu0YxS4ofVVM9FZ+w9XQxPfVHDCx+EwxWU2E0QV77FRrToOBJhJUmD
	5H76vREO1Qf22A80nRGLyzZBKCHOE3Aw//TzCuORoqCD9j/P/G3jozBZ7UAHRBUX5jKubb+u6Xs
	sYsK+Wv0X+YDi2a3ozGSLD/J2tTRJouj195UcNRDX
X-Gm-Gg: Acq92OFHMzvrrspR91VS9jDXNLCp9SbRRB8ZxF6yWBL6QFix2fPbMojHqUIRiuBAzWz
	WoFOfxszK6Uh/Ko1Cpq3/+MJDW7IkcsAy6vm/4I+nUBz8j84OIVlV6UFCchcgFSyfLXE0BWzKj6
	cGRLbLfkEwJ+WDW+U/WjHk1PgnmBUzAD9uZ2zGnMl5luKreFclZQyeV8+MB3m0wl2RbVLXk9zKg
	knmg3jSbG0Ng+mtOVN4UQrT7zv6mC/1DI24/A6jxcuc4Fy7+RJWnGJU+d76Xqbt8Zt12LXE1ya0
	pwQnE6ax+eDA+QvuIHg1p5CdCx331is344hxl7QfSrsPny6G47TU05Frl6k0iwP51RdvG3Ieii3
	3ISlvAOwb6ST9
X-Received: by 2002:ac8:7193:0:b0:516:4f62:85f1 with SMTP id
 d75a77b69052e-516d66aeb2emr1796251cf.22.1779406945121; Thu, 21 May 2026
 16:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401051651.3639709-1-tweek@google.com> <CAP+JOzTMYcDF=z3mC2Avtd2vPQw2imLp8fi0HictTSW+7eUKKA@mail.gmail.com>
In-Reply-To: <CAP+JOzTMYcDF=z3mC2Avtd2vPQw2imLp8fi0HictTSW+7eUKKA@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Fri, 22 May 2026 09:42:07 +1000
X-Gm-Features: AVHnY4J3xTcxmSWg4aY36mWC7Ffl0rxJmi2lMhOKzSAOaIEpcJZP3c9BVOq82_w
Message-ID: <CA+zpnLfo5X+iAqsZjvgWBm8jRii_c5QwNn5cDqzXfj2BASA94w@mail.gmail.com>
Subject: Re: [RFC PATCH] libsepol: Add support for checking standalone CIL
 neverallow rules
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> We definitely want to support your use-case and I think that this is
> an interesting approach, but I am a bit worried about adding special
> cases when resolving things.
>
> I sent an RFC to the list of a different approach which I think will
> work for you. If we add a function in the CIL library to check a given
> policy binary with neverallows pulled from a CIL db, and we add the
> ability to output the declarations from a binary policy to CIL
> (instead of the whole policy), then we can compile the declarations
> and neverallows rules as a CIL policy, extract the neverallow rules,
> and check them against the binary policy. The individual parts are
> simple, it will just use the normal functions to compile (but not
> build a binary), and then use the normal neverallow checking.
>
> Let me know what you think.

This looks great! Thanks for taking the time to review the change and
propose an alternative. I'll reply on the individual commits, but
overall your approach looks good to me.

>
> Jim
