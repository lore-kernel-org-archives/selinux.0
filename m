Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4C1D47AC
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699427; cv=pass; b=kFiVZQoCebfD7l5kh1269uS1ay0Q65UJ9jJdLwE/TFRfndntin5CuqHNQ4euGG252JtI9APAryKDod2fCmgc95mHgPhwTVEJ8PGdfEziA/kLuxjrBmxUA6a8fhIYah8ihD98mMxB33KBmPUW7PYvIkFufDzl2gPp58It9rFvrSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699427; c=relaxed/simple;
	bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+YVr6+FGVCDhsJiRa1NfHhWHse007oHDW9Numo4IdczdKkwSP0maK96ZenrgoOhI9rfhSh2xyDz9jbbzOdXq1yLay0ySKPVlwpg9SN8FHUI/FOBqQ+/NyCISCMIWKRMppaJyMgtnh4JHSTI6h4f09HTQg15Kv2+AM62WukioPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA4L2Z8C; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA4L2Z8C"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3fa8a788so11813527b3.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790699424; cv=none;
        d=google.com; s=arc-20260327;
        b=lNLNd3kIdzw7G7AJVe5jY+FLqT4c3C6PU8jy+B75zKbd8FSNPJorxY23YwPDrthz6M
         45QA12B61hmsZA2ljvgEJMW4J7JWysF40jYWeocwy0D71BrJaOPeMVIb6KtNfb9yNYwL
         dfFU4IyOW4WEWutbNKzv7NLjk40WUdGvF7Zf9qhitWTHnOnYO8rZlBOQMNba+J5f48In
         S/Gu8EkYj8qvyrI/VF40VbwF1Kbzw4niz0TScnoOxpa6OHm9UBMsVkAA0yx1XP05ZdoR
         90gWfocPgWFSxxY+sBoB9ty+GvvHQLQPXKS0xZKC8BDCbezNNqixGf50NKGygvneTLYi
         vK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=WScNSXZFy914beRx+kryac6KP0TaCBXVk/bMfBBlujNoveCJYWrfLtzI6fsBatOpM6
         9ULcXMyiJ4G2P65+Slzyjz8Hsfr9DZre6qF9da/O/LlCXohAGn8ITSN/ktfPbrrUQkZ1
         pibFGMOL774npBqeC91z7ksPTbMfKVCTyH5BJh3G5+VE1K/5YS08W+bXLzGP9UND12B4
         lJZclPA48G65t86Qu7cPjaIXzuzfc7lQ1plqgRxnLLoAyBJDwHbcRBJh2sgsqgSDdtwv
         Grq9GOOPpRkQMPS5cCKNC3gBSw/NzynfHWPcnEoC0AHMYqlg7qG3jt+NIF5yLgwhqPv3
         R9cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699424; x=1791304224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        b=dA4L2Z8CWV0dWgLwWQpBY6F9E2QDuSwk11lhef7zvosUa/6iMhchrP21u+H8BgeThe
         8BVZUCxphT4rJ/Lidlj5rve8wvn3qbKowdNpikxRsCrXAQgG27nlUbQa9JqVyiIyjIVo
         2melghPFJw96okXAuw5yPu5/IjxsEwaK0cR3xbUPaZe3VQQ574v/pV8tOspvxcnTBAsv
         QhdTLUCUt7k1pkNoz7sIqVwsl0W7UQHu8SJzqwAgmceDilebjTUH94h4ds5RylqeGL81
         U3nWPZNxa5fgNI+Smvta7GdWKId8Z6/viFXDzdB6SRETlXeYfYXbe8H/bPVc40JpShMX
         YVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699424; x=1791304224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxy1XJzY6/xzeWKSZAYgWeYKRCum/vM9iGQoQsLTtsI=;
        b=yhA8OCbys5gckLAyusNRdEXeKIXdKW7n2VJtfvttDkE8+yMzYb7SrqWgwei1etIsB/
         jYurWVxxvOEwF8YiRkXSWh2nzGh1+oRn9/GqITYkK6UU/WZ4mHGE+Kym11ZL5nK6wIAi
         yHWmufQSzTd4RN6nJSDLJM9sSCshSHt3BPTErMaMCupLefhZy5WtT0R/S0GL6lkvMjO9
         BDSt5Z1ogA/Nj0pop/L2lO9rs3pQjLteTGY5kCSbCGU1g6Bl7zB0EPAN76luKVzHuJzr
         Eh0+vprO3fCOBIUvzRT3JDbG755mjY7JEX21uymlaroajWRn/cca2s2vOLqtDDspOUNg
         GtTA==
X-Gm-Message-State: AFq9FYLZb3RmKn9Iy6L77KIDzeYMwOJvUhicKD/WEFCjc6P04uP/mX/S
	NrHE3a/A4SAkOBaIRcOvPcbTElDoxFgkJ8xy3T94MIPvLvbTVdIq0xGLaFW/YrBiiXHtE6MlZz1
	eVMio3DulXzCaqdAzEgXsJ0ia3yGdPio=
X-Gm-Gg: AYBFou1j58RH0ZYzRCmowq2tyJ5IvqgAhpV4GqXC//9kRcBm0aO2Y9j4XSj8EntMitk
	kjgcicd6wAiXiMj25u85izmfZ5FZHdPhtKPZz1EKosS1BVjXt8mMGOIF8raiLDsKR+cIAZbi3Jb
	xUfVeaM4XsZGXGOlKhnVeFTs30TviuwTAl8yaBe8WQ46SmbHOiWrkZzg2mM7zzPoixwaWt4LX29
	VdgHWP9kYSX+gnrAugRAvvAx1QwPFS1V0XrYBmwnHs0vP7CxO55sZdoW3+pXwNU4e4PeLe1NQe1
	1ZJmTRVfR6hpJzQsjeKDsSCPCQQu38kLKSm/huCYDEOWz3NBSDNBtGQ=
X-Received: by 2002:a05:690c:e3eb:b0:8a9:977a:4142 with SMTP id
 00721157ae682-8a9977a42c7mr42640987b3.77.1790699424528; Tue, 29 Sep 2026
 09:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de> <20260928155753.2259807-15-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-15-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:30:13 -0400
X-Gm-Features: AclHuK8ejlQjgdbhrt7CBeS2Wr9_FW2pF4fM3obHelS9jy6dYZHzjbQulHlAvZM
Message-ID: <CAEjxPJ6gGSeWJcjN=jLkCsgS6FqY3b=GZCQ+GhLXvZJhVLfarQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/21] tests/tun_tap: skip if not supported
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:59=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
