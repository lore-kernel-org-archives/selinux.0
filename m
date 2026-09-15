Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CC4C8C48
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498115; cv=pass; b=FUkJFnQIOL/mTqEAx4Tkxo1mwzikehTKAqzVsMIxs1Rnku21al7iyiMN9CYG3zYs+rGW+08aU/NpOdLn0E78yShQFHbz+A1Lj1OFHzbqA9ROlwq3MQsMjDPi0eDewTDITGNhW2RiABjC2ACLL8FeDSkHociOAmQQPlA9Fb/HL2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498115; c=relaxed/simple;
	bh=C/Qwt20N49G1mc6jza2TBfOTrkg32Aej2iVvXUZXR1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PlfeyC4ft0pPRbfntsKBAAVAMqmXgAqX6zd4O2H5EFc1Z6GcUT8fyLNVFHLJkkDPlZ0fF3rvAFldk/9EN6RscJJNM+Cb8yT/QnxeuKyaj27s71AiEYwP1kVunvNsJZevGUIKZ2yFcewF9YryIU9z7yYUhDhokhtftwGbAIRvcMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfc1WeB8; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfc1WeB8"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b2f1dso72113fac.0
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 11:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789498113; cv=none;
        d=google.com; s=arc-20260327;
        b=a3usSWZgmi0o6CN7A7HnzPlwBsJQwhuHMsCCH3ViJpliC6L0bMQUggaKy1UMoSL4kX
         dyXcXbnauXnpGDA10Z9XimXaJKd17Gf+LwOEH0HrSfD/WveEXgavcY7LEmN5qnk6RqIE
         VQBimzBUntrz1LUM5fwE+k2VSZpqwY/C4F09SjefP/4Z0uRawNUfUNy+zA8wDuoq4C9F
         npUWUygZ9yQHIKfl0ofQqLtjP16o7pVcXthsolgG5jj9ZXIgtf+/DG6LlhD4IlSyx2NR
         vt5jJzrIrFObYw8M8On5dlv7NilhQlidBNJzBOjxLbGxwc3GPM5aATZyA+K3y3Z3iku3
         DAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/Qwt20N49G1mc6jza2TBfOTrkg32Aej2iVvXUZXR1g=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=qOxHu8H2xTiWxnalQGrYEFh0qCGicqprmUwvinq7zD7tynCl3KqP9h4OCP93gjBv8V
         Kw4QzNn7cHwcHrcZbd6WA3aETGqqYHmhEks0NgrPGBXbodQXE6djSf1t84DeviBTCzb1
         PeLGzL5NCR2mCo4mDSCY5krHq7zRiIdYraawb43MfFrHVlneUthhTxOHDD3H0M1JGXIl
         LPsgTq6dhfJdZRy2vUTZGfaVaHcxmqJtcRr3M18Zw0byzBghAWzYqZS2DgxLfi1wvVXE
         BxRXsimDPCwttR6+ccIhs/3ZQLGBImaoFUxt5AiarlUIxGpSa3Q5fjU7Ka1v8e86ytwO
         8LCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789498113; x=1790102913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/Qwt20N49G1mc6jza2TBfOTrkg32Aej2iVvXUZXR1g=;
        b=jfc1WeB8OXJpD6H1kQ3iCnuW6Vz5+2meGlfDw071h2JDnDCz8cRfGmyU69yaZ4r10q
         WlLyr7PiVVfohFIrsoqVJbt/Y+ZhNj21SbbwMKR7TJFkondgaRWUoZca7TUZDf2pt+yx
         zg+h5cbpLlzjLFq33z3TFr1fWcycj8gejRIk94LZNQqXVh/Sfeuxva6DOHXYHAY4XzmI
         KFvlz7ffBMYvxVVhGyGyI4W9vYgobg00jFR56/o2dmpzPwtUu9XNwRrcZxUXm7m/w6+O
         rQYMTbrAezamY4nEnTMt7A048GTL9y8G4EIwKor2wYPvrqECWrWZoiGtPnEoDcVfOHTc
         TeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789498113; x=1790102913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/Qwt20N49G1mc6jza2TBfOTrkg32Aej2iVvXUZXR1g=;
        b=D2ezbALxH5gpwX1OUvSp11hgDgptSVFoXxSJhbDUcLbAm6sH42PysBZbJo8gjCjttW
         5or4ZSAYKjE+XJnhEhHZRm7HBxAsjyIYUqIXBOMIVYcG6lYPZQ1KoC2++t4cYlMGj8Da
         sbLzI7dBjHrxLnIM7jUdn+OPOmECkaWoSWGEXUToh5jHoQBOBc4TswoSE0Qt1Cf8gCvh
         DfWtk4smOQ6otZHNo33LIy1hB0e//5HjMFaRJI2x9kzxnoCgAeJeTes7DUzQ8yKZnsmU
         IRd4x4tmcGSqI940nwZvgf491gaE88CMoJOvhjqkF7uDXIGyH4N8lzkIe4TuSyalv4N2
         /2iQ==
X-Gm-Message-State: AFuF++lGvVMe5NSLeBeRzELDpWa2T1WihadoyvQBEnDlQLBHzCBBnMZP
	r8QLLydyGgVhZwEo7PEIiZLqwdSh11GvKBIHctO4EOFlXJZf5RIaWbTHpqhHEvtxBk+neCyHBa+
	hR31YD9K4e+nuffLHQ/pBFCnHd6Mws+OQDA==
X-Gm-Gg: AYBFou0r+VXZaKtAxKDJqfvXNJpy0s3tR+Ytiz222PtXPvPqHgb3GG1s4TPWVeQJBow
	3TsCF+QTss3FYrn5sCUP0eWaQyeP2ReluAdCERcrfUzvg0kasUwd6U86UDWyz5UDhKY8DtpQpXG
	lAoiFiQKcMZkpTe0HmLEbPxnxa0y/WDraJ2w3/g420k8rrhs4ogTaJ9DJ8UD8pvTp/j68vtoevs
	JSP2nZz8wSihEOOIdFs7zolZTgu9w6tF53DtVMzMdA4V8i0Z7jBtmVl+2IxN/c3IRc/0zdh78wb
	Ig75Y0XLlmmj482x8W9WxPsgiRZBu3gKlVwE9PkiHgLr6GRiVPWmSe4=
X-Received: by 2002:a05:6870:7309:b0:470:e96b:43e1 with SMTP id
 586e51a60fabf-482e50c8e28mr3217580fac.13.1789498113339; Tue, 15 Sep 2026
 11:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260915160738.46723-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 15 Sep 2026 14:48:22 -0400
X-Gm-Features: AcwNN1V0ruwnuvVcCPFVD-BtYk1H_DnB5q02UnnS7t7D1SKIwaFPDekIYrEmXvw
Message-ID: <CAEjxPJ4prs_nvyq1WjC8WPvCL5B0v1pqApn=SxSgazYsYPOBoA@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: reject out-of-range OCON_PORT field at read time
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 12:08=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The on-disk portcon record encodes protocol, low_port, and high_port
> as 32-bit values, but ocontext_t stores them as uint8_t / uint_16_t.
> ocontext_read_selinux() currently narrows without a range check, so a
> crafted or corrupt policy with e.g. protocol 0x106 is silently read as
> IPPROTO_TCP. policydb_validate() then sees only the truncated values
> and accepts the entry, and checkpolicy -b re-emits it as protocol 6,
> changing a binary the kernel would have rejected into one that will
> load with a different meaning.
>
> The kernel reader already bounds all three fields (U8_MAX / U16_MAX)
> before the narrowing store, and OCON_IBPKEY / OCON_IBENDPORT do the
> same in this function. Apply the same pattern to OCON_PORT.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
