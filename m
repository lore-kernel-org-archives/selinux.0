Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9D3EF663
	for <selinux@vger.kernel.org>; Sun, 18 Oct 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341386; cv=pass; b=q+f7MoOxg9/dK8h0DKP/4vhYJcqEHgrMn6nAF8bSkkA5y6ZKZVw7pNWB1Et70nadZBRYCI78J/Ig5MArHjJfo1A8Nnvq0sKsijBXOi1YrjuO10RNaY3hIOxVyuEB3gIPtghxClFOgj4GzqU/Tw3+IQnVKscuxKC1luaOU8/mYdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341386; c=relaxed/simple;
	bh=FPLZ0Gea9hz/JSRmqm8+Yl9PbAcCBUg55ctbtcIK6Dc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TnWkg80Ylj4cYbDQIb0MTUmS8RJyJ/1ZxGtRbWnaJAgDaTAizCoSebXumHaSnA3rZIyn/R7HU48wv6c39QkoBy75LXeearL/SVNBrZZx8USDrqquqxSXOgroAq9dI++w1l1larUzgFK7RYXxehsobpoe0eJ1ikFB4oJ3JBScwMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBuWlXbe; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBuWlXbe"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-17bc533fda3so1518617c88.1
        for <selinux@vger.kernel.org>; Sun, 18 Oct 2026 09:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792341376; cv=none;
        d=google.com; s=arc-20260327;
        b=mmyBrJ9OuG45vXz+pxcKJfw3ukJ2+2zTJN+VIclCsGpd7zhRX+Rol3KAGkx4o5AQIY
         +IPl8qZiGel89Ybzklai6un7oX2UhdOL7f3mdX7aP2iBo5d2zwBsWPASY/DnidJ8DEHd
         VO4aTH4AsdjIIaVvACkSXkFu8YIlQGbZlO5j9i9W16/T6dso0vIt2/Fa/599U5whbxbF
         e74a5FDXkdxnf4Gq58opkZD7tEp+ZczjmBiLmoMT4Rngc7a9NegJJNNo72OCtMmD8ybC
         5mUrTqvfpLcGWDvoiYPZGC5tx7zkpIlXcaxcks3nSel+qbAU9LAQGFodNO3PFhtaaTbv
         bNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uSBn8urtnG85DeyPZbiYm19GCTTJWBfHm2XDZcJUMBQ=;
        fh=v29piZp/l52ik7EH8uiCfEbC4MhNpeYfH7SNK6R7Uec=;
        b=SdDvn63jB0RzuHtZaEsa9d8L2y+RwEDURS3lME4wacapbo5H3brM4EGx3Y8gzDtvaW
         d4sfh/rMCu/DFNvc5Ni86RwSyP8slhqJNHo1Ld0z5bGuNj1iMTfUZNrAN0nGC5sU6f3c
         kZTpPWn0SnglMUGQzO4wN+MPcZSJZv2zDUJQWifYs4emPyI3n83nCVCl2KucSL3uxThM
         oVOHU4y4tAjNHnE3LpiEIwo2vGGGk6osddTO/1qlwvTbeeUlf35syX9cBAsQ/ezD0MEp
         oUFi/rVhP5sJRsBdP44pVrASUidJe+nzoy1c+TN95tHiZlR+v7EIXTFf97RXYF/AT/iR
         K+5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792341376; x=1792946176; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uSBn8urtnG85DeyPZbiYm19GCTTJWBfHm2XDZcJUMBQ=;
        b=WBuWlXbeEq88koZDEL5fB4FSUEZ/4PqpO6AczKGAz4UodFNP3qoEMVfHKaAfBaiz/w
         3x7KXRqbK8iUOTALZ46eQbaTlC5AlVaidF3tbk67Kl7amtFMgePOLNEtAPFSp2qeexQm
         qzg8R3KxDd+LrXKKunDW+07VE9NexDMVfK3vIgbBMTobq0UWY97WGbm7kwp+n2u3WO6k
         ofRKF5ycDvVuhOus68B+RdYL9/hOYBl06BFOLNOH6IWVJwqO1tIWG/hqC5fmxcka8oD7
         /LKR3ccBkP98TmXvp/XGx34vDhKc/t60ew56uOljWSaCWKHkHjeyoitOUyeFMn5HGkAB
         ecKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341376; x=1792946176;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uSBn8urtnG85DeyPZbiYm19GCTTJWBfHm2XDZcJUMBQ=;
        b=lJGct7LFuRucwLjLHw42dX6V6braWiMXihFFSyCuLdK433lHXbokXxRLJeYNZtcN1Q
         DLWatWY9splOs+XPUZJswn6i1z3QyvwupvChEHtGEMQL+j/r+U478ZW8FSp2Fo2VmMtt
         JeoDXKXCmEjG4EBW1ItFbB2BsnpkQeO6OCHKmrn05r08bMLTwsKUBxgwHnwrmLoizPFn
         v0wMViSDRhSLwmOfdZ+gacF34Y9fU9VPOoHAYvOs+GjySlkNTuWVt3dcwAwiYtw2VbiQ
         7aQdfoAYgnWHtCNvwtgiFdIz68WiVzqQEtqpaw8GjWZ3DN56GwfdFQ9FmpvTNPsGPOG1
         68Iw==
X-Forwarded-Encrypted: i=1; AKwUvBx3JprEtkSh0KX5Ya+nilbb8P5Bz0e9nu488ERAYzeK4U4rMTclK5Zyx4eszvKR2+oEnfy0kLGz@vger.kernel.org
X-Gm-Message-State: AFq9FYIhRzIQdUIM0J8pgll2dFYVbxnY25lsI5CTDMPP8f3Ru0JL6OyG
	VYBVAfjhSgYIkH10rk2gX3gnbjeH8JQwfBzY9gHE8XEgKQukQbSjHUF4c2szLAOViPWBedrSEEW
	PgY7mAuT3F42nWZUFao+6GKFpOn6xDK0=
X-Gm-Gg: AYBFou0A4NS3ut3lL8k6DPxcdYRg+rGM8wM9RooVmKolqyFdh9UUfqP1TtU2oG58M5O
	GyPcv4nzxkNAZWzcorcOpjS+qCQ6dII5WTxLVetdx7+rKDUG6ShCzccLLC5XXGbHJK7x3O9bs7o
	IrYY90MQN4fYIhn9LF2BshSgtEUGTbAGOsWEyLD5Nc5ZZS1i1N3N7SBcuORiaTASULKLYnkzZuC
	G6WWf7Nf4UnG9Kxds/uXzk6RiYzgBuigFmsHQqidOP2DWlB/8A0x6pDy46xTuqOCSnQv0awEB54
	W/0ewq6rjit6hd5HLV+zcGxvv9JRhuJaOU56BVebV+/MIzB2GFH6yrMSwoaIRTzI5MuQXqzltko
	k+W6lLv24ZGIRwJfXwiiSeOMejArU3Vfpfu9cLzTuF/NMoQG4j5EXGpj4MtOtSgeAbXxAL/KxNJ
	AiVzY92sMOjXs=
X-Received: by 2002:a05:7022:118:b0:166:29a2:f83f with SMTP id
 a92af1059eb24-1850c5f8128mr12785809c88.5.1792341375837; Sun, 18 Oct 2026
 09:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date: Sun, 18 Oct 2026 18:36:04 +0200
X-Gm-Features: AclHuK-wxXorEEYCWGPNP2gvIDjNSEL39qVBOA3obzMzh_QZBSjRBFUZs9UouvI
Message-ID: <CAAUqJDt1pXQ2KVBvMoMiDrzz8ishonqhQ0nnQLEppot4nmv9Bw@mail.gmail.com>
Subject: BUG: selinux-testsuite binder tests fail with CONFIG_ANDROID_BINDER_IPC_RUST=y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Android binder maintainers,

Fedora Linux has recently enabled CONFIG_ANDROID_BINDER_IPC_RUST [1],
which turns out to cause the binder tests of selinux-testsuite [2] to
fail.

Minimal reproducer (no SELinux involved):
# git clone https://github.com/SELinuxProject/selinux-testsuite
# cd selinux-testsuite/tests/binder
# make
# ./init_binder.sh
# setenforce 0   ### <-- may be needed if SELinux is enabled
# ./manager -n &
# sleep 1
# ./service_provider -n &
# sleep 1
# ./client -n -c -r 3
Client ioctl BINDER_WRITE_READ error: Invalid argument
#

With only CONFIG_ANDROID_BINDER_IPC=y the last command succeeds.

The issue reproduces even on a kernel compiled from commit
eafedbc7c050, so it seems to date back to the origin of the Rust
implementation. I'm not sure if it's a bug in the new kernel code or
some bug/wrong assumption in the testsuite code - can you please look
into it?

Thanks,
Ondrej

[1] https://gitlab.com/cki-project/kernel-ark/-/commit/c12a0ae360f154fcffc0dd72381550391f77793c
[2] https://github.com/SELinuxProject/selinux-testsuite
