Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8614E77F8
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609190; cv=pass; b=mTzEerKaKzYxBJdX/6cd8bZtgrIhXpK8ATVdrwV2Rp+NWq6fNWoylqjKX+ou6Eo1A0KnUesBw3wkybTJBQKLZq2wv//dcKpmT45yoYsChdd3+1NcuBaNw9InEGcItL14W5wi6UiepYeGQb6I8tFQgyhdqQr2akVUUspHEs65oQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609190; c=relaxed/simple;
	bh=9DMBUFNQMztS/KWTWDm722pDacqD8WvElm8Dg7iwuLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QR2qs8C9X/Es9zDPseaz9HOl3S2A26agkB30wVKJGiLSEn7pxnnCLtlGCBtxx6xzcGbspsj2pX3MbFo4E/Upt7RsIAjSCKi/7Ui5EUVPCnOQcMjPIMsEHbwcYmaiEwNlFp5GSpFmP42RLa2HrBSbPo31gaL6kObdszwkMt7TkYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwRWwfx7; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwRWwfx7"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-895fd505824so25861827b3.1
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 08:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790609187; cv=none;
        d=google.com; s=arc-20260327;
        b=GEEuw0WbODyUGC27zJC7FLjdeBdOQNgpd9yYwC7V8ZqY38/xuqzmpH3g2E/TPq4KWb
         pWy7Y32m7xy4TcvFvh1aygz4Za3St5pfi1PPpHOSBikkKjckFwUfWDSuf2Mz1c6HM37W
         h+pkcfuPkaPB0e/rsRedGUoZLVLTKzv5xTan8MQXkeb7NpA2cTKsI/J124V+haE4D1ne
         cI9qdaradNgFo+RiatL5P+d1y5r03USBEocE+ESZRq8ey+Aw/K2F8ZMj+zcRDdzFyw67
         sjbxR9N0w2z/v05MFHu+MOp+1KrrfE2ZFNzzUZ62cZBnH0Ossra2X/MJ4h1jb0aR+w0K
         m+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s+/uV6YicflkKrix7H90kLlPIxJUTMCDKlEx9tlMdvk=;
        fh=JHL+dlBtetZKWAunLGWKbt14h50PoOUW6V+T78x38Ms=;
        b=Dr6JbRC0/Sl3OU+aVi53j4xbHnUDm7eQmB5oEV6wMYJphs/LGKQetCy7suIeILaZO8
         jA7w7OgMjrZfVfDDkMO2mjkR356VFFqaH2JOIXrPDpWH2uKuzBcLK7g4URaNgHUGHZqZ
         HQY8KhjkcANf5CJ0QNrhtQvXR7w78w92eg64mrr+FgUdiJKZ7Rt+GMfTcBKXg10djL2k
         Y4+7el2jzQPRkwl49eo2G/qFKCYm8RDZ76MFznzENJk0+AS7HTlI1sBeA4ZscuQloyan
         CTxhNmPTDrriwcY6F8UBxf4Ba4dwylypbxkQQYRB4G2QGs2R8DSy/jmcxlKfF8G4rNAs
         B99g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609187; x=1791213987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s+/uV6YicflkKrix7H90kLlPIxJUTMCDKlEx9tlMdvk=;
        b=GwRWwfx7gd2C8tcAJ5PPxKIL6MiUDHbYG1txLlBCrjw5KpVoFWpkPoRlI95zH1sc7a
         VISBhC3FcBkm1czQ225ELVrhqztc+1HUN2WcfvdqJ8EIFVJL5pW5uoYzUfwwiaU//zRL
         nl8fe/PZNeYbohRSOLx7+Ozo1qa4nSxiFxaAgP7X0qg2bbj3JXv8kxhbZMwQl8sZoBhX
         Gtna9LPtQtkplsc0X+k2KyK6Egp6S+MDFgCzcSJZpRwniaoYO340eZXkVvyYmr009Pqq
         wsJ8o0Y4DkYwV58DQ5TbbFTHa8SbGUX0TRt445woUQ/S6MU3tDuLMzvDtr8Hn4n4L1jB
         JFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609187; x=1791213987;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+/uV6YicflkKrix7H90kLlPIxJUTMCDKlEx9tlMdvk=;
        b=RzBxCjsVzDNV+h921oa0ZYUu3bV7JOJFWNJd3sWWCoWZ1cfOby7K4Ro4EuvydT8tIp
         Qs7nihhLrLA+zfmzVolV74J6gSOCqSGUfMOCbL/lmLm1HZKrR1VE/dGnUS9lJ2tGQQSO
         M9qIn4f3bhfWrDiD2EMVkpXr+YoqHUmoeqhN0/wWxnFaLcHx+Jp9quuR/Jeid4zSNrz0
         imECOXcdcIIKV/RLytzVLntDoapUSrlx3DYh7M02cdqLb48VGKIjfZfczZ5rGxC5i8iL
         ocu+0ionvhDXhmwy2p9wRdUZ15/Am7cjJyaVHJbOyH37jqrtcV7YWIwOSiz6EjPKJf/j
         RAIg==
X-Gm-Message-State: AFq9FYJsG1XMwu+XZI+bxxdqwm58Z3Fg8lmUd7TotvXFhRjiTJ5wZ0bd
	zVwheqErlRkDY2x1ME72vFg7p/6MbTNwgqDGOhs37EHW61xh5gXlaWKAtyvFU6Zb5Wk/OXt73Ln
	em0cXnV1+gxogHGmRU6hyxeO2ufsF4trcF3tB
X-Gm-Gg: AYBFou2UDCsPW6obnIPayxqJ5VluqTqZucukYoCxx1xSZ5ymfGM5xcq7MwAyQJsjZ8Y
	jt2gPDFasbTL8hqIYTRaYv6QvjG2zx0KfAfs67o3T/p2XhPov946xMv/MsyGBsINOhGaEUb4wzs
	tmiT4uw1glZYq5YFvTatbaraLRV3dSCTD8Jd32zKnf3uJ/yOxsXz6tkaW/cRnTnqq92VDpwGzZ2
	d7IPCCM/IcdU65NJ+89JiOarznHvYWsElSdYCrLDZEQNIaXKzEvA6mWk+3a0KTPAc7GFUTtoGIy
	DyeXz82MQdWtvr6FGhV7OSrHd0YJjjh/naDv3iSKD+uFhwk7H77IJfo=
X-Received: by 2002:a05:690c:319:b0:873:5bb2:6c37 with SMTP id
 00721157ae682-8a64dfc80fdmr65150997b3.62.1790609187036; Mon, 28 Sep 2026
 08:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928141917.17577-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260928141917.17577-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 11:26:16 -0400
X-Gm-Features: AclHuK9Anx4Iv6nqSqzS1FS7sYPQi1CJpIVO1_3jpf8avzkkLJjpedbT1zuG4xw
Message-ID: <CAEjxPJ6JUzSBgkfKRQCTeW2JK5L7pbLHAe68ZbCeg=Spj4mESg@mail.gmail.com>
Subject: Re: [PATCH] selinux: preserve NATIVE_LABELS on already-initialized sb
 in set_mnt_opts
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:19=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> When an NFSv4 filesystem exported with security_label is mounted a
> second time, sget_fc() returns the existing superblock and
> nfs_get_root() calls security_sb_set_mnt_opts() again on it. Since the
> superblock is already SB_INITIALIZED, selinux_set_mnt_opts() takes an
> early exit without setting SECURITY_LSM_NATIVE_LABELS in
> *set_kern_flags. nfs_get_root() then sees kflags without
> SECURITY_LSM_NATIVE_LABELS set and clears NFS_CAP_SECURITY_LABEL on
> the shared nfs_server, silently disabling per-file labeling for both
> the new and the original mount.
>
> Commit 3815a245b501 ("security/selinux: fix SECURITY_LSM_NATIVE_LABELS
> on reused superblock") fixed the same problem in
> selinux_sb_clone_mnt_opts().  The reused-superblock path for a plain
> second mount now goes through sb_set_mnt_opts rather than
> sb_clone_mnt_opts, so it needs the same treatment: on both
> SE_SBINITIALIZED early exits, set SECURITY_LSM_NATIVE_LABELS in
> *set_kern_flags when the superblock was already using
> SECURITY_FS_USE_NATVE.
>
> Closes: https://github.com/SELinuxProject/selinux-kernel/issues/69
> Closes: https://github.com/SELinuxProject/selinux-testsuite/issues/92

As it turns out, this also fixes the other longstanding NFS bug we
have open, so you can also add:
Closes: https://github.com/SELinuxProject/selinux-kernel/issues/70
Closes: https://github.com/SELinuxProject/selinux-testsuite/issues/91
and seemingly this goes all the way back to:
Fixes: eb9ae686507b ("SELinux: Add a new labeling type native labels")
