Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06723BD1B
	for <selinux@vger.kernel.org>; Wed,  4 Mar 2026 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583789; cv=pass; b=IFY4/FWBUoVSED6qSUYM0LNuYFjeNO9ugxFcYF0duR81WLOjGz1Ud5ZfJ8UcHFg0ayfdQ8qD9XEe9a6rhW525A7/f4LnJrxPvd6YlbhyBJWttu6DUbGO1ODzW3SXogXXUZmjwbRAoLaP4sw2/MjYcIT6wD9VMu0g7SvnIFB/Cu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583789; c=relaxed/simple;
	bh=JUEBCh2lCsJPSe7uthdC1eNi2BBKz2HNUq3qk7+nCZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3GXaYxrKmh6gg7l/6KBLkXkPoA2bcLk4TEhkEOH2O0E8EqI7ZBypybJW8t7DWT74UgaEr/fcPDg4FA3nhjD2oXE4OdhyOJwWyFPlgU9YK+2PJteUnJs5ibMo8CBeioryUEaceZmwjU8iYZZMesYwbylIvmIk1ST//GQ3m9KFHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ROqH8ZLz; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROqH8ZLz"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5069a785ed2so788031cf.1
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2026 16:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772583787; cv=none;
        d=google.com; s=arc-20240605;
        b=XaRmxvke8CUBnVIxs9TkG6CxN+BPGF390R65IFCAoSE2wxHuG89fYDUPFc2H9nlkgl
         ZrzCaJoSn5ZPSCvLjsMuxL25JUbOgfjwAKwUArrSoIcjmyZvIHr7VECeeuGPOtXe/EX5
         /D0rvt8XygQOQAeQzW73vQqldoCxyNRcAODm//OyDvpt54be7/6Suh6uSIeDWbRemKOD
         pcy7KofuLxRMPqzf2Ivgf/zm+5IVIJa6p9UxIMrU4l3IEyS0sN5QmqtGjmn7ZxeCYFrX
         OPtijILgaflrb2VaNt6LcxegnH8l+KeQFOXGrehEHO4wmjPf+hseFOKNFlDveVHmYBse
         1cZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JUEBCh2lCsJPSe7uthdC1eNi2BBKz2HNUq3qk7+nCZA=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=KHz53D3g+iTMpslIJrHNo8bzWHMgnCEVC3g0c98OlHBK32KPxWgbO/lz6+VNUtcuPE
         kSaijfCvRYQmWy+H8ldiTd+/P4Yw8m+HZI5Kxx2bgE4Ris+KB695hPdwiuMvodbv9zAC
         T1ESeK9CKdT9sYNBiM30+AODeTQK4ld7vXFX+v24HNDiFky0w/ql/glUf16iODxe0VL3
         odudewkW7ddEiQ2GWDwJ4LFi8MBetI7i2LqIUHq1IqPFLRUeBaJIyCqm6Ghf4mOdR1Tq
         sEvCF+trgxY9s8ZOVOokNrxsBKZeoyfoXR+oL/Tjzi/pAlKbSSZPOoZkOb9nLpW4CXLt
         7I6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772583787; x=1773188587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUEBCh2lCsJPSe7uthdC1eNi2BBKz2HNUq3qk7+nCZA=;
        b=ROqH8ZLzZYn+QgXZm43yxXjLVIEKl4QFT6/LNLaKj7kv9qvPTp4NrXaTc3Jnnh2kkK
         WuF/fswSGQNGMKCASKhEPvTL6jrFpPa4UjSFd2yiuzsaz5EPmJwfupDpSLlo5QBsYHtQ
         PHlxIeTNxT7Evokuy7cRKczWwbkWy57JPvbOWK2qrORL7357jqqJesAm6anikVwuEBdC
         gBbclnG5RF3SYczbIFhgZaIQ8aPW1J5lfpa+wUDRJkMTA8sAsBJp2cXJ9376cwRND56m
         OT2sfClk2fQolNccF4x+eZzyhvY6S3LdAv/v0TJubKrxyZZ3mLvSEhNpdUSvjzdc8ONj
         3txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772583787; x=1773188587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUEBCh2lCsJPSe7uthdC1eNi2BBKz2HNUq3qk7+nCZA=;
        b=G+YBuUfcmDH+i7t+BiVw2NNxA6qW1LYGxE/dsQ7oTu8GFiCufwu8kceaP34cFo9Kc9
         rhe0YaByoxr8+pO8EzTR8ssAO6Szcz3oQ+MeA/fmutnOy1ux0gBvpx8+WAaH/OjYiKhy
         0zOuDRRibGFPWB4igvihFqoAXJI462QrpiDFrQFR/T2HUkzg292cf/LUR1yXg4aN5NKx
         taYOfNcjROnLg6oS6a/0aO4h1jXMwbWrI/NaTfUtHDQSP7QsURX0BNsE8CLx/0il2nbb
         jTfzlUoB3D4JaV/b2cP9esRihNVUkob0Ysy4F2pS6UdDOCvtSsb0zTnEdOjtx8D/Lo8x
         yeOQ==
X-Gm-Message-State: AOJu0YwOhwtUdIqXuz4mMCFdKW8qZRNYyu94zL45QWFh1xhxijt04WA8
	W6BS4KlEmwdq8jptGd3o5JJEp6BUr3+eafFp1CMgGwz/hDltF8fWq89nK0Rtv1xj50tE0tRaTk5
	q2SBXjMkhgRMdlpz/h5+/Id28YVxCmn+0kbtQxSBd
X-Gm-Gg: ATEYQzwdPsghGfj/8MDgAWWRAKdzQjO8J6niDTwPqAluwzMhkmTqkjtX5IaFgYUrk9o
	HPad9zbLbQBRsB7DtGIwStYeBDjep0qweO2fbsfPrE9miD/oFb+WQCXMJQZphLMB7wjVNfZskLv
	zBdC3ncRqez+Wv3BXuNQF/4J/C7cUa4EA6LMybdI8E3pHBAZWmaiA5B5Z0EFMUwgrNhhuLT1gup
	ZB9/q91VjlsWSEVEZXeEECKV8eEFUf/kvbFQvsA35lESypV+nbi36z4U3aKmDmsc6F+ZtglRMIY
	PgYZYvc=
X-Received: by 2002:a05:622a:106:b0:506:6ff1:fce with SMTP id
 d75a77b69052e-5075fd1d5c6mr45787561cf.2.1772583786749; Tue, 03 Mar 2026
 16:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303122412.1596047-2-lautrbach@redhat.com>
In-Reply-To: <20260303122412.1596047-2-lautrbach@redhat.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Wed, 4 Mar 2026 11:22:48 +1100
X-Gm-Features: AaiRm51TTZ-i70XsAgiRfanyJbXyFvLc4jdggGSnsi4tWNWqvgZ1vE5jXyBJX5w
Message-ID: <CA+zpnLcC6e74amyz+6pqau+zUBYLhYGSP4zRy133XUfC75Qbvw@mail.gmail.com>
Subject: Re: [PATCH] Add support for UTF-8 in file context labels
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:39=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> - libselinux to be able to read UTF-8 spec entries
> - libselinux to compile regexes with UTF strings and unicode properties

Thanks Petr. I'm a bit worried about the performance impact here of
always enabling UTF support. Were you able to run benchmarks on this
change? Android's file_contexts [1] could be useful data here. If the
impact is non-negligible, could this feature be behind an option for
selabel_file, something like SELABEL_OPT_UTF?

[1] https://cs.android.com/android/platform/superproject/+/android-latest-r=
elease:system/sepolicy/private/file_contexts
