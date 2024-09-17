Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5B7DA91
	for <selinux@vger.kernel.org>; Tue, 17 Sep 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557561; cv=none; b=eBQBM7RrcyReGjni9cLvAEq+qMULyNoi3/szcPKVjvb9V9PSi+LAgJsWPsEdNaiHsP7Jar/bczsSCMmwMx36l4djYY0UF2PAI9X6BGeljnkEKnhis9b6Jfi4zEKpX2Mi45s958AR/PBeJXKMJNqoOnjp2yjoLjrwDlDttHX8mcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557561; c=relaxed/simple;
	bh=q6zdGR7DV5EyISPzwE1PcFuxPKMPsxhR/hErLgUbwS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt5raTRD8bwFpVs19NTF4qQU99zo+1bfbcgS7dP/wHiAIxJuAUu0aI7lUrvYV1y1c9vrfUghT3O6TVNIgx/qVO4ir99u/w90h0GmOwFLhJCQlYdP5wgnAKuqibCffXSJquXNGkSgteCruqpQOutbCN/Qcl58eHYK933/A+BcILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MIIexYaZ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MIIexYaZ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6dbc5db8a31so32392907b3.1
        for <selinux@vger.kernel.org>; Tue, 17 Sep 2024 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726557559; x=1727162359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuyGlKrPSyjx0sDR93yUNinaUwmRi0aa06Frbq/teak=;
        b=MIIexYaZaWmuBUMuA9/XCTxwbw09d2xCRFu+MHH3suBiCZitcBa/qzHmrtOgMfMF0f
         UEgEpgVmhONFKI5o2PncHmGrChY+d+MY2XwWDXJY0RlLcLrk+yciogjQ/5/IPGiY9s8A
         E7JirJVF320iOmvpQtthH+3qK542lAR62zJZYug+UvCPOmn6WVlghEn4ZGtuiiU4CA8A
         Fca9y6cg0y88bCFz/7jD5nPShcol7+DyNaE8W6dESyICVghq28Dpk0sulH2JpWdL7qdt
         LHeTmdwOp72u3scWkSZDI1FDH0f3yoRCnZXClbnQxKVoc+Vqs2EZRtkhFgtdu+yC647K
         O+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726557559; x=1727162359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuyGlKrPSyjx0sDR93yUNinaUwmRi0aa06Frbq/teak=;
        b=eWlJpYmDXKqU8IoWLmBBJYJGu0TADiuy+7xKs7EU1uomizYf2JWuYcqn5YAkQRzLkf
         I1uRLkVarISnppRQrAk99DdB99lM3STjyWFhu94DjAeCiTZnrEVwju6HxIR4K+v7ax0e
         M1aC75NDPldxiY5gkrMwkGZ9WaQHdl922Dsr1LQZ9V8nZoOdZDb+O3X7IXmVK1TmnSgl
         /oonDfoBkTVZ27RyRfE35js11RPDDSo9xrXTjDKPPDDBX7okibzPDGxFMpY82Ul7bvd1
         phGvAKFjv59llYly69Bq1jlgYJ/GZhfkep1bs4epvtB2gVLqnxAIkcq3jMCahbIRACNQ
         unLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVETk2E8F+sJgMXJL+2cMth7IiEtX/9E1YX78bAg4uAJke29zhybPEJPc3o8hP0bepF+rAlhrt1@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLZqfNzAuK/R3tMpOSIZvK+q0X4NnNBn6GSl7JzJT2Rbuys/K
	JWB0kZd2PNODXOFpNr7Ii0sH+qUI8fXHnsd11VHmZOBJ/JyXLC4KhraqcyU4TmEZFgMMrA7vV1/
	bCD9oyLwLxmFbGGHzRZAD62Vz2ZrL3biyJ7in
X-Google-Smtp-Source: AGHT+IEf6uMuY05TaaaabfrOKCd0iraDyBXGzkVMhvbuI2NQjLn5CCwbbNM1aOpjNrJLAn0KYz4hBDR3b0PvC81gRD0=
X-Received: by 2002:a05:690c:f95:b0:6d5:7617:950e with SMTP id
 00721157ae682-6dbb712a31fmr138076487b3.18.1726557559080; Tue, 17 Sep 2024
 00:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912014503.835759-1-tweek@google.com> <34803d945f405dc2e4e798cdaf057994@paul-moore.com>
 <CA+zpnLd4AhhSUc=+pmGGwDPbRSjDPT3uKy1rn=R=h3H9oW3GCw@mail.gmail.com>
In-Reply-To: <CA+zpnLd4AhhSUc=+pmGGwDPbRSjDPT3uKy1rn=R=h3H9oW3GCw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Sep 2024 03:19:07 -0400
Message-ID: <CAHC9VhRRMQeb=QjKjEt9v_k-6FeUj5vPNzgCgmqRgCMrXzTsaQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: Add netlink xperm support
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 10:24=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
>
> > Looks good to me, thanks for the revision.  We're in the merge window
> > right now so I'm going to merge this into selinux/dev-staging now and
> > I'll move it into selinux/dev after -rc1 is released.
>
> Great, thanks Paul. I've also created a pull request to update the notebo=
ok:
> https://github.com/SELinuxProject/selinux-notebook/pull/40

Excellent, thank you!

--=20
paul-moore.com
