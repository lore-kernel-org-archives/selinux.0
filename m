Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4141F334374
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415687; cv=pass; b=Q81nNDdTqHVyK90FS33AA0/oXjvjztk5SIk8HhPjboITWdaNi7xV/W+my4TaFvBWxUyQbDFsPPm1jfPFmh1rqZxVEa34nI5+IlCtfRSNwpoMjPqyJBGh7yDiqFwF6lRpImRB+gLbCWjocELWM72MkJawn0vK/tcLya35seOHgKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415687; c=relaxed/simple;
	bh=2PffCu77Ax/LQDL33veKETP+Yg24W48VMXx+RQWaLJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhFZ/W5c+nA5iONySI1iDSWgvvbxkzRetJX+c/gwRsPsgcpTZgyz+lFIZfP9jNOyAI44HcRP08LIdUjAmQnvFm+zgyQT6dPxjfvaGDzwfcOwJ6j2Ji0BsL5DB9uxmsgvPIapwmCC8gO3siw9B+lAsjQ0qm49MgmsBDHRKLin65U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pApwZFGq; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pApwZFGq"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6ab021f1daeso808850eaf.2
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 05:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785415685; cv=none;
        d=google.com; s=arc-20260327;
        b=cGGP0f8f8lgURLFVkaZqCFnvH777C9mTDHRsLXJurAYFbeoEQucP23FJXjtd8GMUAq
         VD7idHw+RhT/YHaSuBHVETeZhWWRUlYvnxoUCh317e3Rgk1jJm+x8iRQD8ObDcX44R9B
         LQVHb4uAYUeYSXoxNeObDbW+IuWsfCdA3tgh+NfCHAwQot1P2ldoFhN1mGrr7JpAk1xx
         lh7SnDGvqqWoqBLuKVaHP3RVL/PMuK+0gONtNu37c3aBkKsz4JDc6x5aKBnY1K9Z6IB3
         uJ9Tr69hq+SI+8zAtTCR3EeWFuYR+D+VZRBJNanCQ8iwJjFkcneT23WV7R3gYYXEpW6Z
         75ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jLsH6kEdA5E7XFYPXPerHyZFyPDXPHH47Lz/Hfv/3rM=;
        fh=o4EWA82M+vtfNglaTzMFhY8rIYTLnPpjxHW+AHnzuHs=;
        b=mIiDtVHfIeXxSp4B8kX0+QKQUX8KYKFk9StpmePtCRAlbpO7jvVY0e75RF4g3LXLIO
         +aVNsd/23Kgwv6IXDNIWRxrPFy4yIG2ims4vkDzQf5FjK+WVUYiXs3zHEzbCsfGpsiQb
         NpPwF1oMOePkYc/2xCvq2FfN2wrvhtCkmBgSxIZNzhzFQRA11x68G4x+t4faV7A9b1VO
         nY3Eosp5oA4pilMeGtstKOkVE63yDeahlD2ZRSKOU5xkbyykdavibGHXNZzTvUJ58I7J
         9ggZordilOIfwbs8GUjqKeW8UVDwN/RaCKtR9jGggl0IsrFVMwQy1uiwesl/3KFl2ds/
         Tg2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785415685; x=1786020485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jLsH6kEdA5E7XFYPXPerHyZFyPDXPHH47Lz/Hfv/3rM=;
        b=pApwZFGqywUitZ5muQ6nQ2mnRVUDzzfVKb5iIptRniyiEW8D67UJ0Y0WjKxmhFl8Me
         f7wdBXR7sKP4MyfO7aBw3cYvyq8HhuoBfwZropRUDCDQtTA1GU8Y7AOXX/40kDq/Njh4
         LH2Hh+3VX4WHUr/vPq60M/3NtnTgpNHNGW9tR9svge/gvDWUQIJbNsK/G1CFINYT8ZkS
         o8UdVLafCVJoeWfIZ1emfxQWQkqmjxB3ZeKQg34QGZCW0psKLeCrzIJIcy1FW2x49IRf
         57v1aJl/800IxzqPrm+T7wNbevGkhGYZqMhkxYyUH+56DG72k5Usmut1+LA/ri0HjrD8
         GEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785415685; x=1786020485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLsH6kEdA5E7XFYPXPerHyZFyPDXPHH47Lz/Hfv/3rM=;
        b=c1m+cW46Vh/QFDqr0yxJrAUSV+iUl2i1zYnO59MbiRIAHi2ibRw6YORCYPyyg0Xxvx
         PnJ6gq1pBTb7F6YSVMTjVlWxvFsJRETdZKzAfs/4u3d3JmzqCafWpo6EgkbuDd/2Y+iF
         kIEaxMzIwOnZB6kAiK0W0sbbQ8wD18zr0IR8huy1qewwQnck/dTfsce3tDtXKsCZckt6
         sqc+kINDWbvLrGrctT4Sc39nQmZlwJIH6IXa2Xw4lQFTtNAmN9UO6VVJLoAH7ONMwAqV
         ZoUc42RxZMYscRMkcsjsXQTz5kYWalCdWP8P2jPuM6bIyhFzEq/MKFWqQ28c/EUYxH9j
         13mA==
X-Gm-Message-State: AOJu0Yyo/mTw6PMKkqOmnxaQOzieixtKoGQT984dzAYY5OwN4WrkvXn5
	W9FyNjHVe2cxitgydmWiIMF+YJExle9OCke3/wInHQHZcINnh6eEtixeewqa4hYqL0rFocJmhJP
	erbTJ5cjHjNCBKAC/9ZYIwXAQK5ip18M=
X-Gm-Gg: AR+sD12BIcSF2HotdJtUKrJrqGzuW5yXwyR26iFxS7U9ThYRzvD8Ae/Muj7HjTVtUWY
	+Ct4PRxMfT86T4mekm6sSwyp54ZBT1SgSTj1rL6pzoYBNTB5zCxSkCgr7SR47k58SSGuzxdBGXP
	g/K/LvVJCeS6EF0Mo8tmSlL8T4OarO4xbv2f996Fp3JaLuPjjOoFtJsVNTw1QcG/oUBTivaDZRC
	wM6wSr367lkgWd9rCji2YKlCnLlfQSCEigjdYTTl8cgnW+hupB7G0ctUa1mJzIPZRLwqmOqf9yK
	CBNSvyaTS48WWBI6BpvVydupi2buu7p3IL3nsdQAzQZR
X-Received: by 2002:a05:6820:3085:b0:6ac:b3b1:a5a2 with SMTP id
 006d021491bc7-6acbba939d1mr1242714eaf.0.1785415684973; Thu, 30 Jul 2026
 05:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729131413.1390890-1-pmatyas@redhat.com> <20260730085713.1484927-1-pmatyas@redhat.com>
In-Reply-To: <20260730085713.1484927-1-pmatyas@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 30 Jul 2026 08:47:54 -0400
X-Gm-Features: AUfX_mx8QH1rDb2-uNNfaOHA84Y6n0Wjt1Nv4rShE1cSSl7_ySWWIQu_vnR3yjA
Message-ID: <CAEjxPJ5+woPckt_ETz9etNwL1vrHscN9QTs4=Z2jyeUe3d2sWA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: prevent ReDoS in file context regex matching
To: Petr Matyas <p.matyas13@gmail.com>
Cc: selinux@vger.kernel.org, Petr Matyas <pmatyas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:11=E2=80=AFAM Petr Matyas <p.matyas13@gmail.com> =
wrote:
>
> The PCRE2 interpreter is susceptible to catastrophic backtracking on
> crafted file context patterns or lookup keys. Since libselinux never
> called pcre2_jit_compile(3) or pcre2_jit_match(3), the JIT was
> available but unused, leaving the interpreter exposed on all platforms.
>
> Fix with two complementary mitigations:
>
> 1. Call pcre2_jit_compile() after every pattern compilation (including
>    mmap deserialization) to engage JIT for both complete and partial
>    matching. regex_match() now calls pcre2_jit_match() and falls back to
>    pcre2_match() only on PCRE2_ERROR_JIT_BADOPTION (JIT unavailable or
>    not compiled for the requested mode).
>
> 2. Create a shared pcre2_match_context with a backtrack step limit of
>    10 000 000 and pass it to both pcre2_jit_match() and the fallback
>    pcre2_match(). PCRE2_ERROR_MATCHLIMIT is treated as no-match to keep
>    the lookup safe rather than failing noisily. This bounds worst-case
>    matching time to milliseconds for any pattern/subject combination,
>    regardless of JIT availability.
>
> The vulnerability was reproduced and confirmed fixed on:
> - RHIVOS 2.0 / aarch64
> - RHEL 10.3 / x86_64
> - Fedora 44 / x86_64
>
> Reproducer (149 bytes, base64):
> AwovMi0GLy8GCygKeAYGKwYLKAoKCgAAAPpXKgsoCi8vBgs8PG5vbmU+PgovMi0GLy8GCygKe=
AYG
> KwYLKAoKCiNXLy8wCwsoCgojV1dXClcqCygKLy8vV1cueHhXV1d4eHgveCsGCygKCgonVy9XV=
3cy
> eHgveAcGJAsoCi8tLwYvMi0GLy8GCzw8bm9uZT4+3q2+7y8=3D
>
> Signed-off-by: Petr Matyas <pmatyas@redhat.com>
>
> libsepol/cil: Return SEPOL_ERR on failure to set bit
>
> The functions cil_typepermissive_to_policydb() and
> cil_typeneveraudit_to_policydb() return rc when ebitmap_set_bit()
> fails, but the rc value at the point is SEPOL_OK.

Something went wrong with your commit message - seemingly
squashed/merged with another one.
Also with this patch applied, I get a selinux-testsuite failure, see
below for just running the individual
failing test:
$ cd selinux-testsuite
$ sudo make -C policy load
$ sudo ./tests/file_contexts/test
ok 1
internal.c:assertContextsMatch:24 Lookup for /base/unkown from
test_lookup failed (No such file or directory)
not ok 2
#   Failed test at ./tests/file_contexts/test line 27.
ok 3
./tests/file_contexts/f1.fc: line 1 has invalid context
system_u:object_r:rootfs:s0
./tests/file_contexts/f1.fc: line 1 has invalid context
system_u:object_r:rootfs:s0
ok 4
./tests/file_contexts/f1.fc: line 1 has invalid context
system_u:object_r:rootfs:s0
./tests/file_contexts/f1.fc: line 1 has invalid context
system_u:object_r:rootfs:s0
ok 5
# Looks like you failed 1 test of 5.
