Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A66642356
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418777; cv=none; b=f6cbcmV1DfIzd/+2RB8Tcek1DeZFECO/he42b7IADbUG8ahVnrRUo+JA1tmN5nD/b7xiMflDBO7x0UBnqA43nC7en+3V6oDUoGSj1PFlAUylruPjxcAdvHnPgx0lZqF/3td2oUAKn8nC49VGzHzQV8WpUIUgMnuSBYRdo20kBmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418777; c=relaxed/simple;
	bh=EZ6SuXI0g/P+YubOOW0hKYEI2YhDJ3nwCgM1UzmghdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XtGPvTSq+38rLVaTw+hDWezYMYGa0konhAXsSG4d3+EHQ9elLuuOuFGYXkkH0FKfxJx230MLX5WEjzEMwyQG4cx03TID4locaPfJPhDeI0/OFThsRiGikxZ5v0IC4w77dyDM2XmUYcQ0CrP/kYeJu4ispDACeAzDcgeAjNFeKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhEczB20; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhEczB20"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so22563865e9.1
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 07:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792418773; x=1793023573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rCahezzy+NXiY9NCRh2MJ0p3KpsJ9Ta93YUdt50/tqY=;
        b=AhEczB20CF0Xf2VcazjG0wlSHZW81X35qQQ0pqHgFcBOAmh6UwxaPu56Dy7zKRWaLU
         cDU9HUL0FASo/EW1i0KSkpQ7n/PJ6jFlffMhwA9P26jEu1q2reWzvWRK2f+X+LRlK+S8
         cNXKiSM+b3uVtswgW3yeib4QIuWxrLNymS61pk/zEIviZKVGEWrpHsJRClQZP5xqJ6zG
         5PvxrssgbD78iUo1X7w3181qoIdnLDpUiaFDNnIc00JX2VAx1d/NvjviTxUiwDrBscxR
         /BedH4IFboKsSIMeRneTqovvsMxkDpGqt2g+8qf11gR+g4l82OxIhV3wAITxkXLErmWD
         ZhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418773; x=1793023573;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCahezzy+NXiY9NCRh2MJ0p3KpsJ9Ta93YUdt50/tqY=;
        b=NTmfaPobw++G1Vt/V490+aIYJ/tmisJzzxY8O7keffFaAz3OTcff1tjQ+T8Ix9+1DG
         ObYzrX/TUEXPECmxHLEH6Gs/j3+qp0pI/S2q5V+IZCY7uY3taBPz8On98tdU/NBNWOYI
         oHr7SbjmRJ6vY6sxCQttqw3IzJpQ5cDlPSGeA/kLpyt9ei0F46luh3fpJgRo2GjHp2In
         EKm0uKv5+dXa5B9p7M0qU1tMyDQahYNu6h3Zhjpp2P038bfx+7HRi99XjijsWmIiDUw3
         ovZ24E4yZ3xK22OoQM5TC9UYE6b/zV0f/7OHy2bxXAN0uBKL7a66CCt3dDeAuAfoIm0H
         93pg==
X-Forwarded-Encrypted: i=1; AKwUvBwqHedOzzZhgfzBvFE1Ke16ziDimXWo+S0cxQaxAgCyMktQitdaXya8FtOfgQqY6tVl3Jlgghwm@vger.kernel.org
X-Gm-Message-State: AFq9FYIU9C09/mIXtlp3es62Q0II8TRB1u2yAOylGVPNhNdWzkIkI47w
	BbfJwW/UwD9y6ZR4yp8TjLZaxDYa2XOt49BO6hqNVfL+RwbRAVbxPJEUO5bNCPgtt3vq9UEFu43
	1cWZ4Sli0stF8mmSh5Q==
X-Received: from wmxt3-n2.prod.google.com ([2002:a05:600d:8643:20b0:4a1:e676:5ad4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4691:b0:4a1:ebf0:43ed with SMTP id 5b1f17b1804b1-4a1ebf04495mr39875595e9.24.1792418773213;
 Mon, 19 Oct 2026 07:06:13 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:06:11 +0000
In-Reply-To: <2026101814-strut-endnote-a0b5@gregkh>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAAUqJDt1pXQ2KVBvMoMiDrzz8ishonqhQ0nnQLEppot4nmv9Bw@mail.gmail.com>
 <2026101814-strut-endnote-a0b5@gregkh>
Message-ID: <atYj06gmgCa40q6T@google.com>
Subject: Re: BUG: selinux-testsuite binder tests fail with CONFIG_ANDROID_BINDER_IPC_RUST=y
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ondrej =?utf-8?B?TW9zbsOhxI1law==?=" <omosnacek@gmail.com>, Carlos Llamas <cmllamas@google.com>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <christian@brauner.io>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 06:53:49PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 18, 2026 at 06:36:04PM +0200, Ondrej Mosn=C3=A1=C4=8Dek wrote=
:
> > Hello Android binder maintainers,
> >=20
> > Fedora Linux has recently enabled CONFIG_ANDROID_BINDER_IPC_RUST [1],
> > which turns out to cause the binder tests of selinux-testsuite [2] to
> > fail.
> >=20
> > Minimal reproducer (no SELinux involved):
> > # git clone https://github.com/SELinuxProject/selinux-testsuite
> > # cd selinux-testsuite/tests/binder
> > # make
> > # ./init_binder.sh
> > # setenforce 0   ### <-- may be needed if SELinux is enabled
> > # ./manager -n &
> > # sleep 1
> > # ./service_provider -n &
> > # sleep 1
> > # ./client -n -c -r 3
> > Client ioctl BINDER_WRITE_READ error: Invalid argument
> > #
> >=20
> > With only CONFIG_ANDROID_BINDER_IPC=3Dy the last command succeeds.
> >=20
> > The issue reproduces even on a kernel compiled from commit
> > eafedbc7c050, so it seems to date back to the origin of the Rust
> > implementation. I'm not sure if it's a bug in the new kernel code or
> > some bug/wrong assumption in the testsuite code - can you please look
> > into it?
>=20
> Given that the "real" binder client works, perhaps the test is wrong and
> should be fixed?

Apparently there is a divergence of behavior if the SELinux permission
`binder { impersonate }` is granted to a process, though Android never
uses this permission anywhere.

Thanks for the report.

Alice
