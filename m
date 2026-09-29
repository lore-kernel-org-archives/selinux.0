Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3031B80E
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698869; cv=pass; b=HLES/tuNB/IzpUnv9vgSQeYv9UzSIKdYyTJ0H4bXw5bAvJHsXhXOG06I6CcGbeddX7iW+vlcFkms4ymNM0Fn4jJgtnctqhA+UdpHyWTrlwLy/Lh1yJjyOTnuCyz1mN5G5AmFJ7+87ohxRGfEB1LhgKyLw/hi36ALabE7NiWpBSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698869; c=relaxed/simple;
	bh=wfTGDgT30A04begBkXV8/5lCNQhONECHJs/XFIsB1f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WodJH63gJL/D9wNGdz3HIylRedxgfqos3yxiwIUDZd3f810pCWhYanmR3hIMKWmOo07Es446ar4fo4MQWZsFW/9LqkxYx1pr3JAsyu9WAewV5mHmAac5T8iwH0r0ljWlph2ToqnrA9vvmg+5iG3GRCZIcrXORYxfTodASZqp8mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHBVS1Mm; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHBVS1Mm"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-89666ee9b3bso34457747b3.0
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 09:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790698866; cv=none;
        d=google.com; s=arc-20260327;
        b=Uxa6SGyA4qjHRkRTZsignGYg/bQlDHA6Y7WW2VZlKpJ0jXrhN0OXXs4BLYFyglMJJ0
         qKRj7uJBvfFQ+xVX6HSrPi415NdMCQvM1jjfusMU7rTvPD6tAZbXM48Xtk28UTsCrRkv
         PgopLNSm64AE/EKgWLBtcjjCSiP5hHGHnXd5vvDEKsEBtYV9BK5EOFMwZS2AXoU8hr3z
         xlQwPaVlDXoURbtOHzGYGEQLF0pwRIomn+zBznojpHaNpkAt4tAxuZ6G8XnU6fuZdc5M
         20o954+1+6LAohNhLdzuF7M3Lr3OAcBc3AltrCqnLS9x7RaWMj/FPPTuISa/3SFO2ACC
         UNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fFMxwcPPWHuYXHv6ZOSCSnvGm8sE4MgDa5dIhEce4c=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=iba7qC6slVH4FxNbH7Q9cc8UGEDkLt0vFZikjpQsuvmayO9J69q/WkUyBlxM4dqA3w
         gCqlLlGJNRGrHCqyemSDQqpD4C1/l1F6Ojh3TOyPXbF0lnrTjMd2a3RnzPJk0AR+Ue82
         bZHc1Q1gqaoEUwrfd2LB7LRsdiyD5PnOPVG6fdgZmq7QpjBEsDx0eF/AunH53sHMY9ij
         C3vVE28YC8FKNSfGMNxoYMvwQzkHEXszuVgj0fgUXMoPFJY4u8eh3knAmu6WJviiCFHk
         nEnwvIHgO69vTygHPNQGv+i9ovXP8fWoWoXrgmgvxOs7dkMK8T3y0Xc+tMI8W6omGkPa
         iZAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790698866; x=1791303666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fFMxwcPPWHuYXHv6ZOSCSnvGm8sE4MgDa5dIhEce4c=;
        b=GHBVS1MmM2vyx3POhzaVzviRsfYa7v6JuFndYa9cKyvNPwsAu984X2mtln1DmvQHP5
         aMyeCok/4Tx6q8yaNlDWPZOBB2pn8KD6UHT9pkfxDSor3Nvt3i+0My+7aP8/izuZ4iDc
         B+L+BIgw810DpsI+ryR/FnEaH5R7EIXdpsk4iPmkYDNgcQSOpc2tobQLoBzYRYd3/Ki8
         XrPQEHOMsMQk79+YwQlzH7JgI1jAR6WyP8aLANJEdKpWvVHkLAwLpRGiwDyrrIG4ME4H
         zI/dYsZOE/52BlDqt4j+jrz8flf+BnWK4m8UewkyXoCtb7h7dz4LmUbt+ifGsLrRvEev
         NMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790698866; x=1791303666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fFMxwcPPWHuYXHv6ZOSCSnvGm8sE4MgDa5dIhEce4c=;
        b=NXlX7PQ34l1LBuzsDINf9yUKF33hB3KUQfCfPF29gS2R9G2DBqueFr1XW6VBvQaCok
         AGgT0np+8hr0PoHeOYancDYZLZnlupnl8xNdQkP6YXxqePFHhmZ6T9ZH8vbIOy219LuS
         LwjtbU8K6X+Ip52oOBQYB1Av6/uYL9TjK+yLSIa4TBwVG6kIj84MEQOuy+tt3Llguj6+
         y1uuknW5QVLtdANRhnxLDsFRuqatusJk54fGDfkbu6NBCwAlsxxO2a1v27LkxYOxdRXg
         Estv3keBOrr+3ufN+uvIAXm5n0piFgGxj1rKhGfBO5stL+629PsIf4QukYtUQRxWi5cE
         WbIQ==
X-Gm-Message-State: AFq9FYLfOVVOXR5fL6dOJXS9CcIgl1XQHffCW2sJEJbB31CzyIYLzQCk
	JH5bcJZ/HJY3s1KCphCTob+iBkD07GMgoaCzY6WzWfIZPYy+SZvP0gAXmpuBpGNsqgBpIJcGCDp
	KF+HV/vw/RVj1e5SnYzoVTp6QEq7ldDmIrjWH
X-Gm-Gg: AYBFou0h5OYloK34eWL81KalZuAliuv9CW85DqkD0x88o2a00liKbI88DjuFDdBVGnm
	duP0uFHGSlr97+yakUGux1MHcrc2CyON3ORu64MThSRamrNy9TRuimGS/ZLlErCH2Hh8aPZtCLW
	3p7nUlj6yco+6yydguytUHQd8ypxkK8I8jHBP3bAeF3nNy8dHbqC/shrRN6BkmsXJy5/zUSMbha
	5u0Hl9uzDDv6nEgHrGZ3HKfwFAfVxNtEcHvvX7m0VzmXdt5nC2qvmklorI5Un4/EKjS1IW0xfml
	8jIXrA+h1/qdpJhaxpXB2qgFiNVvkRQdkewQeVRP9Nq9iwIV0sWbuTA=
X-Received: by 2002:a05:690c:c:b0:87d:b776:c659 with SMTP id
 00721157ae682-8a6461b9d23mr101358527b3.11.1790698866294; Tue, 29 Sep 2026
 09:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 12:20:54 -0400
X-Gm-Features: AclHuK91T6wCteiE1rucI-_sr0MGT7CHUdVL9nFfACt5tuTcrQxx5b8LaTUE9xA
Message-ID: <CAEjxPJ5og6tDyb2N-xSNyk8MmMNQz4ANVWuSGbg1CVv=fGTqCQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] policy: fix build with Reference Policy
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:58=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> test_file_load.te and test_bpf_token.te call interfaces that only exist
> in the Fedora policy: files_rw_generic_tmp_dir(),
> fs_rw_inherited_tmpfs_files(), userdom_read_inherited_user_tmp_files()
> and fs_list_bpf_dirs().  With Reference Policy, e.g. Debian's
> selinux-policy-dev, the unexpanded calls end up in the module source
> and the test policy fails to build.
>
> Fall back to the Reference Policy equivalents, as already done for other
> interfaces in test_global.te.  files_rw_generic_tmp_dir() needs no
> replacement, since Reference Policy's files_tmp_filetrans() already
> allows writing to /tmp.  test_bpf_token.te also uses bpf_t directly,
> which only got required via fs_list_bpf_dirs(), so require it explicitly.
>
> Fixes: 011a106285e1 ("policy,tests: add tests for new permissions for loa=
ding files/data")
> Fixes: 16ac3af8cf6e ("tests/bpf: Add tests for SELinux BPF token access c=
ontrol")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
