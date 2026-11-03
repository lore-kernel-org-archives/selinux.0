Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793666872;
	b=YNN7Oycqvm5wLGKDevzy8baLmBq8dpPvuZEtWSokwFGE8SNFCLmamAkHFC8RLAXNHk+C
	 zb1uZy/W0/VvND3kIIJspIlpQF42uAlVGe1SI1Ow2CrKsx1W50N1MMn7aku4RYcIqIKA2
	 hAsIgGsp4den4H4ZyPCBKxdAZpaIfETrrA3trchKEp5r3tFXU6bx5jHOwYHz8U/bxJBtr
	 EUgJqaTH28MzktmlekGvOIUIwNH/Q2VB53R5Z8yiPzCtPjknZFPLWw88ZISQHN96WPYGt
	 AXSXReqDdgnn0nudpreJBNtkszXXSj4OtpEpu5830LMg09uuZsNerALrdHtHZTrQTww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qmH5OvatWzBofiEN6YsVBCfdM8VLN8xm2S+OiSeq2qc=;
	b=NDrdnAF9QPrKj2b9laKS97t5ntJwRwKp7jBtd7wGnEsV2LKcfPTCtbj3nPaMmAfqnAsu
	 Nl2nTFbsmPKQIqAr0hRsLNvIlGBIXLhLxy4oXUEo6WrA/b5kAe3yOIv3upUsL5ijKbSLJ
	 44WWoXgO4hbAJuO3PDMZggBKOlBOunVrblL16EcJoieFwD2oEjn8RyfQRWhdWnMjEOEmj
	 oty7NRwBDNUQqsg6xbtDULo8SnlH3bgMmsFqOa4V+tOI8Yl/yeh5v9TEXvQMala0h9wwG
	 a9IJlGfan74pFxxC2L0+yV+avqbUQRIOZbmA1H66X9TZ3AtnGNVCBX2FZ4INBdNk8Kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NE+5SyMU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D79606A32D
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 00:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D79606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NE+5SyMU
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso1429208a12.2
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 16:47:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793666871; cv=none;
        d=google.com; s=arc-20260327;
        b=SyPLV/ERfqj2BVYswa4RG98gg51LOA2VDDicx2cFWoT4DgKWavXLOrpP4Kew5+L1CK
         zoQb+5ZhQ5f3iIq2ImXPJJ1W9WWv3dPrxHppsx0/uHge/e5zTrlcdplkrGpZ2bm610Td
         oxLXonMrDMexQW+WSmjNSwbjDMSXJtKt/t2nUMkC7BOscxrWq5RsKFzV2xMDdVcLgP+P
         aQkKjhcPLGacWoQJnGBmNUmDb4BsamztlMhurKRJIpLncrmyUDiONtAgNv0Qk9LTJhCA
         ZB2MKHIszJQWWF+LfPzPJckmZpA13/aoddQGAmIb7LsP6jMCzBhMMysXiNI8bF6cYyuC
         87Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qmH5OvatWzBofiEN6YsVBCfdM8VLN8xm2S+OiSeq2qc=;
        fh=qlDxFZZFeeRZsixDAjFHnCDzYeDzeG2qTMYb2wgyQe0=;
        b=cHla6+A+fLXFHeEt6ySn2MGiK8TmeT5XDx6J43wPdN6vNr3+7i15XsOlVX5yzvHZ+0
         1XtasJygFZFQDG7d94MIl7C6bd3CIQAlFSvsIQd+nBAiRSZx3u0FLTghcYmusuUZ7nM+
         /ckqMn/lodHQX9cqSLKO7WBy3D5pDjzWAkkIGweJmjz+SlTbDuVloOqgfznfbon/b4eF
         C1ijOb8g8UWXQNS1Y53/4hSTQsy358LFuLWkI7WDbKeBsPeHBE34fgp2A/9E6GTK5gDn
         kdbXUwRUZXt9OvuxAvIMtcZ7wEjTkofa2xoKFugwVd1WrJC8G+COXZmvykicwmBIJYif
         Y4vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793666871; x=1794271671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qmH5OvatWzBofiEN6YsVBCfdM8VLN8xm2S+OiSeq2qc=;
        b=NE+5SyMUfN+gGxZQPx0GVzjzJeWngBa34Ls/rh45/noiG21jaRtB5aBI8BrctrYY09
         b374TBrKwJW43aNm3XeK6M7ItT4nrAosQEfR/UOQZYSgpdnOWqAiHtz3SNuy1WvOuV1c
         2tLrrZN9w5H4jY8do/0mM+ixJdkEFG5OwW4kpKP2UYYQzjybupKPXfu9O2gKZIsSnB/7
         Pv5Qygy0gs5BcaIAkygAUskAhuvrx9bcsw6nf8P8R4fPLUNUEyzVDKBKmCGMx/5YLecR
         19z5pz2LtUth6gsMZEoc5+5WblkJBZuBhPLzCjeUFP6FeVYUfd8udpkjIyuDbQ0kGJin
         mi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793666871; x=1794271671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qmH5OvatWzBofiEN6YsVBCfdM8VLN8xm2S+OiSeq2qc=;
        b=JqpRRrH6zdFoHTQTXJbnh4wLUJ1bApxVSc3jClpExEkzduRZAdSgQTacz92nifSBSh
         PLJ9DZclEIcYH+WvrE3zxSb8YMdKTVTeQsNqRGRHdW2bs1S62ntK1iHxN+syEPTCM1KZ
         nxsYdzQcVMI76sxnOz/kbiw7dEhRZhZwAU0Bn7s5qAjdG2CX0C81F9wS4h9IrDWSY21Y
         xdAKidM5SDhTpDUEZhFnSsffSUO7MBl7suuYRdUNiGiSdifUPVqU0RUr6vW7/xDtUTNv
         xGu0Mlqpp+GxdF/Jn8w26OK036CZbhERE7PR3s1yHQlhSdRnNrop3VrAB52PNGEfIHf3
         fNSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPCSjjbgQg/ZsluCiYG+drLnG0XQ+HFU9K9zuV7rpCXhV6X3D1xfZptjk5FzKON9QkcMTmQKq+@vger.kernel.org
X-Gm-Message-State: APuU4Z/9Mn0iNM0eI5SkaO/1Xfvz2y3HiCcRPKaw8g4qxIeYtqU19muU
	kYWbisP4wp8iDDOhrYug7Ideo1Relky3aqR4QPjTgCA/rlzCJ3yzBv6Sag2Go900KhYQZQeyyPA
	Xo6d7/vhwVj1v78ra+JYFroIi7uPzJ/CjhhSlvoEY
X-Gm-Gg: AYBFou230r10vtKD7Hcy7MSHcdPTGOlqmNx5egd5x7aV/KV+CXWCNg8WWoLHZ6GNO89
	oXq9nyw3tB4PoESH3LUJz35H+Copr9sq0HgZJiGlFp5A+3Lsvk3zEZDFO+Fhr2+QqOnuNV5kKGF
	Fo+2wNRpJfB+AikLaT3jrk2xwx8vqS6DJiYUphB+aNcnIFDNOI3LHgo4cOOLeZMNvN38+uIkfbp
	485zp03vo9L1Zyk8fyEJipCI6qstIuOzgoYkj852vzV8yS2Ojr26PWumeFseeBW4SQ7pKGe2jig
	hoDC7a3GnX2QlCuz8MJ55xO+kJgwWj2T+d0sj1xgMpTfuZcLfF/33uqpAyw3Em9sUKCJC2P68Wj
	9Q39FAPT1L/+x6cTdSjLJCYwL0BPrk0uHKz2NyIGvQsT3lHmPbSVI8uqA843WNwvLfvTZ
X-Received: by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7 with SMTP id
 98e67ed59e1d1-3ae897aa7aemr9873041a91.49.1793666871426; Mon, 02 Nov 2026
 16:47:51 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAUqJDt1pXQ2KVBvMoMiDrzz8ishonqhQ0nnQLEppot4nmv9Bw@mail.gmail.com>
 <2026101814-strut-endnote-a0b5@gregkh> <atYj06gmgCa40q6T@google.com> <CAEjxPJ4zV-YE9vRJ0=DgjuQY5gjXwRa8hcd0KpgVtyK_9AM+oA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4zV-YE9vRJ0=DgjuQY5gjXwRa8hcd0KpgVtyK_9AM+oA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Nov 2026 19:47:39 -0500
X-Gm-Features: AclHuK-H5LxOjKqHADEoKlThTJbWl_uN7gOPX5dElTGASqVVMSHM9dmMRNjNZS0
Message-ID: <CAHC9VhTzV-6FbwCimrdUHuyvVhmUfzwL8PtydKx7Xq3Jkp5mmw@mail.gmail.com>
Subject: Re: BUG: selinux-testsuite binder tests fail with CONFIG_ANDROID_BINDER_IPC_RUST=y
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Carlos Llamas <cmllamas@google.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Oct 19, 2026 at 12:58=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
> > On Sun, Oct 18, 2026 at 06:53:49PM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Oct 18, 2026 at 06:36:04PM +0200, Ondrej Mosn=C3=A1=C4=8Dek w=
rote:
> > > > Hello Android binder maintainers,
> > > >
> > > > Fedora Linux has recently enabled CONFIG_ANDROID_BINDER_IPC_RUST [1=
],
> > > > which turns out to cause the binder tests of selinux-testsuite [2] =
to
> > > > fail.
> > > >
> > > > Minimal reproducer (no SELinux involved):
> > > > # git clone https://github.com/SELinuxProject/selinux-testsuite
> > > > # cd selinux-testsuite/tests/binder
> > > > # make
> > > > # ./init_binder.sh
> > > > # setenforce 0   ### <-- may be needed if SELinux is enabled
> > > > # ./manager -n &
> > > > # sleep 1
> > > > # ./service_provider -n &
> > > > # sleep 1
> > > > # ./client -n -c -r 3
> > > > Client ioctl BINDER_WRITE_READ error: Invalid argument
> > > > #
> > > >
> > > > With only CONFIG_ANDROID_BINDER_IPC=3Dy the last command succeeds.
> > > >
> > > > The issue reproduces even on a kernel compiled from commit
> > > > eafedbc7c050, so it seems to date back to the origin of the Rust
> > > > implementation. I'm not sure if it's a bug in the new kernel code o=
r
> > > > some bug/wrong assumption in the testsuite code - can you please lo=
ok
> > > > into it?
> > >
> > > Given that the "real" binder client works, perhaps the test is wrong =
and
> > > should be fixed?
> >
> > Apparently there is a divergence of behavior if the SELinux permission
> > `binder { impersonate }` is granted to a process, though Android never
> > uses this permission anywhere.
> >
> > Thanks for the report.
>
> I would treat Android as authoritative here and fix the
> selinux-testsuite to match unless you think there is an actual bug in
> the Rust driver.
> We originally implemented the binder impersonate check just to make
> sure no one ever impersonated a different sender without us noticing.

Unless someone knows of any other widespread Binder users, I tend to
agree with Stephen that we should treat Android as the standard at the
present time.  I may have missed it, but has anyone posted a fix for
the test?  We're at -rc1 now and we really should get the test fixed
soon ...

--=20
paul-moore.com
