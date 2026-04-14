Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA651EB5E3
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776185711; cv=pass; b=gdX91GmqAJjTl4hOF7GWisQiESFi0iBWoICM+XiqOW3x+wzBlplHwYD0nGJ3KkvWhggOJsWVhmfjMqD4EVaqybemdGHUfEi5yJl+gFAcc/We8ksSInEPajNw3qFfqlI6aBqFDxBLmzYc/0s/VUkjHpB2J/zqylUv7cvRD8J1Llk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776185711; c=relaxed/simple;
	bh=bC46T5VztHcZXV2Jc5SOuertXw35xhKCnbbNKKojamI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHX/jSZy4bxxSvSmo1QoOkUnmnFmNDZtrcJY3m1cOChzVsYE+Ux8l2jnAANSO0jTUisk22ZYmq50mpdRfxpdUWJSYiPuymd12OYy6+ca05hshM+bfmckIH6XR/rq9alZdgavyGHRv8d+ZnpWtRYRM7q/fBNDSwI97ZlPuvoHmCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r43UPqsY; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r43UPqsY"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76d797b180so3634642a12.2
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 09:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776185710; cv=none;
        d=google.com; s=arc-20240605;
        b=XVenCXU1agsLlc0ZP0cJkahXMk8C3bJL/YYarHs71OGKg3v590hBaH65Hsi3tet8R8
         yr6tU8O0Jg1i2AHVge6MofPgR2uFd12ANzfC/4fr5p2YifbWFUz/yG7aNKWrUr5StE1w
         wFTHLKMslDTVKr37wSKyoij29xybfOREUzhDRlunCCeypNvZLsgbIBK0AXpAFDY5Bt1i
         pXmHTDM0fhVKYScbM2xYfS72j2wbPLTejvIFqHTHuuu/z2/5dYQxDQvI/jiTtknKxoLN
         nxDFeOL7k29+MEyecSDj9/xgDEBav0gfXu3KV9/thZ3oZ8n2lLb2n2nHz+gQ+MF/19K2
         AbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bC46T5VztHcZXV2Jc5SOuertXw35xhKCnbbNKKojamI=;
        fh=N7PtZmn02hpPdaeX9AswJv/h9+Qwz/x7Uwoq1oOEY18=;
        b=I2xWMGv+AaV+I2YoU5WdVDDBXllqo9jPUgTrZb3AxxkWspCWXypxdgwUNqEqpqIaLw
         H8IQUj8c9hVdNpLEJbnbEFzUhI2mf2bTJ/nZRU4HXvc8R4i28MpSQghIXLzD+TmmNOCe
         O7ZMruQF9A3oafmF6YVUM2/g65lWI84x9DELXl6dOMbDVbFqB+czKfk0zVKloHonylgY
         L1T9ZqVMyksiATF8WxVTub5E2OZ6aexE7BLD2Xtxv2sHVN+98E589VdDkddOhClxM6Jq
         WIjX7fvvAm4lF9iPawLtk4coLJqOP6roHyhMuj8y2P3FpVLWqvo2YZBz5nelTx/LtOWb
         GxPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776185710; x=1776790510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bC46T5VztHcZXV2Jc5SOuertXw35xhKCnbbNKKojamI=;
        b=r43UPqsYqCfmrvushblM6nIJw91DWBtkefmd15C8wG1b5CVBO3L8TtPJsXf1zxLbI4
         Wx/jydLpRdzCzDjZDBFQgeDXpwVYZyih7BbAqCkWF07vgMdvbp60Pf9/S83A6aWbg0KB
         RhS4Zo1EZiu6UDGCO920UFupdSqBwACeo9BbKjPm9gR0CKPvw/OH5GoBV6lyoXmfo9d4
         b6wSofel8GSIEoVTJ6JlYBa32myE1bREH7N4JHedqBaf9lyYxpPowm6L56AoltfFbtXL
         73MJvBxwzDJE5tzyoAFh8fQRGdgzdT/LR+qvPu1UnXDG0qiGESKXLFNnF6UyEPgrzxtW
         r6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776185710; x=1776790510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bC46T5VztHcZXV2Jc5SOuertXw35xhKCnbbNKKojamI=;
        b=mgfdy3+wWvyzCyOxnxrGCNSUsIeHAjh1oTuKNYRJAMz9E6baXsO+y/coqp8169+Xeb
         bh6xv+pojc0kx1CMfU4dBx96pCmlZ9N5bJ7MdGCHiUSi2xdqhT52O1g4kMyGg1sTnUHV
         sAXx5FLk8ktkf+e3dL9Z+fOxbTLb4WKIHkUMzk7g+VI4QOQQrfDTSPg3evqa6WrXRbFU
         Uy/b9fvnooe4DjHtrGrgJv/UzWjaGhUCZgZoT0smA7z9mpZUgVA0PHBwzcVGuQ5gd1AU
         JA0AoOonjtNyrxfCUU33GXuyV8bu5GNYLsahlDjhj48ML+FWzLBn1JA000FPnKv4MMPM
         y0Yw==
X-Gm-Message-State: AOJu0Yw2bIB0ywk02Q3miC7OxX51JLl3btXLXEcPYq+ggaBepSUm0PpC
	H1MTl++DrMANX6lpAB8CUAh4cE5PUSzuhqEkHPdjind9S5GR19Pl58L4Kcg7hMlbJ3lfzY5G2g8
	yu3naU9kOPh4O5TG68ZeB3V5zKMgHoOM=
X-Gm-Gg: AeBDiesDSZ4nPjzrD3k1fIgCglEuEHO+AqFlN3Y+eCTWuQQLr93pLmGhvVzvOGdUjrZ
	/MOIKiDbLRORJp5BbFngG2Apneu//+dwlIwCyhtNzFIib1Oks8s8ejl2DiEY8HRDhMgAGCq7Byu
	V3hBjMqPkYoeZ+FDLxy5APB+/3cdEEbsyy3j9dWLSWw0EZbfxuZY2lXfGp9SqOwzo5GEwnBPn4/
	cH50gznKmsYFga2eRdoaBog+/9JJbzJQbURGduJrCLzvqprypOkv9WafQA9XB0Bo06St2DXoyA4
	iwemMik=
X-Received: by 2002:a05:6300:210f:b0:399:b194:5d7c with SMTP id
 adf61e73a8af0-39fe3d8692cmr19550153637.24.1776185709924; Tue, 14 Apr 2026
 09:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330193100.3603-1-danieldurning.work@gmail.com>
In-Reply-To: <20260330193100.3603-1-danieldurning.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 14 Apr 2026 12:54:58 -0400
X-Gm-Features: AQROBzDN7qp0nBzRp4Knax6mddtqxo5jZKGKLUl4fRli8ryLURIfXGQ7ksQnYTw
Message-ID: <CAEjxPJ6eWtRyLpVQ1WvMC=pfddqjmouH+kb-i=sdaHMmAw+A1g@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: implement namespace_alloc and
 namespace_install hooks
To: danieldurning.work@gmail.com
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com, 
	brauner@kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:31=E2=80=AFPM <danieldurning.work@gmail.com> wrot=
e:
>
> From: Daniel Durning <danieldurning.work@gmail.com>
>
> Add implementations of the namespace_alloc and namespace_install
> hooks for SELinux. Corresponding permissions are defined for each
> hook (create and setns, respectively), New security classes are
> defined for each individual namespace type to allow granularity.
>
> In namespace_alloc we check the caller's SID against itself. When
> a namespace is allocated the SID of the caller is saved in the
> namespace security blob. This SID is checked against the caller
> in namespace_install. We fall back to SECINITSID_KERNEL if
> ns_common is pointing to an init namespace, since these are
> created before policy load and will be lacking a security blob.
>
> Requires Christian Brauner's namespace LSM blob patch and
> Micka=C3=ABl Sala=C3=BCn's LSM namespace audit data patch, which are
> the first 2 patches in the series linked below.
>
> As an additional note, the namespace security blob does not
> seem to be freed when a mount namespace is marked as anon
> in the kernel. The free_mnt_ns() function only calls
> ns_common_free() (which ultimately calls the namespace_free()
> hook) if a mount namespace is not marked as anon.
> This is causing a memory leak. This issue would need to be
> addressed in the original LSM namespace blob patch.

Assuming that this gets fixed by the change suggested by Christian
Brauner, we can drop this note from the commit message for this one.

>
> Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> Link: https://lore.kernel.org/all/20260312100444.2609563-3-mic@digikod.ne=
t/

Otherwise,
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
