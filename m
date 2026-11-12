Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794494908;
	b=kMz2xD64zshL4KilInTYi6QmBkWJhPmZrTJhudETrK/T/CymGub2XV34iwUXhRcnI0A7
	 ADfIJQdYo41/yPzmLoOaCcbZ3/Q5CPQTwaUwvJ3P/fFTt8M3zAyjaE2eog1VkhzREqmeI
	 rHZBxPF3AxroVqEAq2VlcsRv4XV2vuZ+N7yp+RAb8fJaBm7FgmhIFrVfso7pExBv+r8y+
	 E0z+4DSfTuOs3CiXz2w6XpCP2l/zoomEMnVUdieRH629mX24ec8u0qAKEXKoPKZzW14e6
	 NXAixXzE6VMtqY+3X6qqm/fYgP3oYLlKmVr6CYtaqOC4zlDclznezVNNew4ERpK8jXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=K6IsRzpyqJeQDdVpUQPNu6ORF93ESw7butjtQL/TmUg=;
	b=OcMC/fi/I3XdD5idQAmGXPAxbH0yav0OC1/zvESMBlC2Ntb06q6+y3xdtUE/gAPK1Xyx
	 VstkhU2OA+EOVET6ul5TO6BU3hvZUHjTefR9EbEmKak8yIPPiBkK5MsJPBDFup82fc9/B
	 Bt5djOQ85WySqHt+bL2lzOr5NHXVKVGoV55M9E9yWQyBiOwb8kxIYFwIjpoqNBpuqcFcu
	 n1WW4Oa2zXk0UQFGClrFmKt+V1qAkOaOMMogXBmp/3qhUoOdjgtNe0bjfSN8gR6G4rQwB
	 /rI+pzLmP5MFmVsETZLGvIuZUHEEOlu36vRZRIM84OUTML3PX3uxXR8a8d4sb5V2+UA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A850v+uv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C9606A323
	for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 14:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 775C9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A850v+uv
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67c00f291e1so3385922d50.1
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2026 06:48:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794494907; cv=none;
        d=google.com; s=arc-20260327;
        b=qNb7TeNIZ4HL20okI1vnCRgEdOmidrs8WODyL/RnkB3Lnq+cm0n8E7aeR5te6tzRo1
         BjKfauG1uLms2mp2yM5oPdD7KKzpnfw9J7FhITj6Xac79xg3UTtAQnEeudUJmvFrmmv4
         yXiajhZGvb8SHeNCyKq2dpUXd/kQQAI11XEihPhNbCb67/kyttQf4Hz33063lTB40Smn
         c2DvEtMveLwrDgNI/pXGTsuLCd/Wqgfd1K2NR/+7KtwQhTysg2CBWYsSWsHJR/nkoNGX
         bF4EQcTfJiuvu63uv0OEwY1cH0wC0cG24N2hrT/pWkkjp/17zoqwpph2465sVSy955/C
         lGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6IsRzpyqJeQDdVpUQPNu6ORF93ESw7butjtQL/TmUg=;
        fh=BDiKfGHJuhysupDjl1ERlggA2muMPeTagq4ZHcZhpXo=;
        b=qZki9Er6ntriCos9GhhozECGRFErixK5xn+GBjlBcfIg+Be0E8c10Bhmcax3VJ02A/
         Kc/xg0YI0tZ9RS/PYnoR0J/Rq/GWXZ+5DhySDKjlRe+Kl6oG96htKQmUMN1KiEqVbz9I
         MQaXj6iGYGuw5flU28k8D1xpByzLSxGgxsRfKeRYPJ/9nPFSv7hKnUnXb/uXTLOpTjuf
         rNkKGT7hcc1fkp7UR9lT1Xbi8nv/hwO3RzMXh7y6sWLtXOVKEr0m/Ch9+dDwi3Ghwmt+
         0jdpj72j4KzPIgj/7GsvUrNS5daO2CzcO5Ia7xl+MoKBPQI3FKoRLM6jVxmbA1S6fQdZ
         mfHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794494907; x=1795099707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K6IsRzpyqJeQDdVpUQPNu6ORF93ESw7butjtQL/TmUg=;
        b=A850v+uvVQbq/fB75XuFkOWVBQ4nJN89IkJrybzkK9Es69u3CrOC6Z8GR0oiP6DKzS
         aWtTrOCIkTrNcr7KsmoNRuVKbTmPqEdv9iO591IKcRD7ZgKlJZ6nhvt+2r+HwsSyMQRg
         jEJFLUiHOGbxi62ArAAca9DVGTRDOM7jF1Gl7bSnbYrMGDwlMiVyj7FxzpePuAN77hzb
         ZOH6HTjbvyZ8TiCZipcTmz5FxgkDPGtkT1HS4bnSQiVX9Y3DSxopeSpZR2TaiEuYWE7k
         dnoc/Y1F5M/e+Jf/B0bVCk7YkUN+nEfweMbcRZe8aECOymfCJPHLEAaTVcErIicZ3EMb
         35FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794494907; x=1795099707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K6IsRzpyqJeQDdVpUQPNu6ORF93ESw7butjtQL/TmUg=;
        b=MgmgHwSAcOfGyVQ0ZSEj8h5SOdVpAgeQ8TorFtsC3O/HEdoAus98e11AcJXZtnE0KN
         TaI89N11YsT2pjPYMTA1llWgt5BeSyzgCAkTR7jODAP9Vfxj2gu5S6MWf/ONRgX481VM
         rK+WQM32B0s9NHQc8BRJBQ3NMZyvX3qLyiJQpl/EtWkgebj3zXJdfKysx6kWMLAODnCS
         dXCiqJLnn/WYAr1no4GLkIVWYNMC5MHhTAqm4CzLo2NcuhUKdxJYiu4Wp/QHvEQkTJOz
         utq3pjWxAWVNwOAYs5d/xeIxYzEt1OTJ2F7GTfY3TQiWU2kLByhh/dAyWkb96IMDZiGr
         +29Q==
X-Gm-Message-State: APuU4Z/m+KvnazdqjILZdxH6bWDj5GonwC5v+aSemm6+nQi0Yvpz8NZ7
	cNXNy2ygdwOTV8skSOHyRc6GgkLuytAjZvkueE6CVu/X7UOds6V+KIMkE/rp0vLgQwZJHN0ljAX
	1DDIjCOVfbw83qyAGfC3CfmsEhpUcOvcUW7C5
X-Gm-Gg: AYBFou2vclbCVDwuPEJU3Vaw2JgnR6RAcmOcwFp2ifPS83unyK+cg23HKnEOAmrsLGc
	tMDVh32asX0YyfYno9vhhvUvPSspTIUicX3JBZwfVAvi44sWESbP96vBcVUiVai0PwEApHwquQs
	g0nkStquPDxOWS2k3BreMEYSnr/GoM2po7XaYxu+F4LGe19d3h5C7lZyog/nigUj2+j0jUVj53z
	neKLZSDTdwvxUxakiV79faE75NCxZHUyVmyDhrr4LhvV0U6tazAMGz5u0XAerQJHArkKJOZKR4v
	LibpYRY0+t/UWtIia6un6yqjoSMOo8hrTjKpdpZwcFdqNONqczaIdrjesJAayWYuwBcur8BfZbs
	Y+KHzLu+ipJuh5IDucDfJgHgCBBxTHCqCbclWHC64TsQJSG5R9m4g/k23q+QoGaD8zE9NY2+Ffx
	d0+Jz/DPrVWu+fmHgq5tuan3oTX1ALcQYsfxqu1yNsNRgBhRj2BXb/mjETcw==
X-Received: by 2002:a05:690e:12c4:b0:67d:8285:4326 with SMTP id
 956f58d0204a3-67d82854481mr490896d50.129.1794494907360; Thu, 12 Nov 2026
 06:48:27 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110154125.31153-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20261110154125.31153-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Nov 2026 09:48:16 -0500
X-Gm-Features: AclHuK_Ggd3LbgvJZme2A7BvWWfdV0I-o2wk_2ykFG0VHqTiFubxQFEHJ6HMgz4
Message-ID: <CAEjxPJ4=X+nmp-abqfQQY4HbXB=nRvpMSN3RcpkMH-DPNp=8xQ@mail.gmail.com>
Subject: Re: [PATCH v2] tests/binder: fix binder tests to work with the Rust
 binder driver
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnacek@gmail.com, jeffv@google.com, 
	tweek@google.com, Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> With the original Android binder driver it was possible for a process
> to invoke binder transactions on a binder fd opened by another
> process. Hence, SELinux originally implemented an impersonate
> permission check to control such usage. This however was never used in
> practice by the Android userspace and never allowed in Android SELinux
> policy.
>
> The Rust reimplementation of the binder driver intentionally prevents
> such impersonation from ever happening, failing such operations with
> EINVAL. Update the SELinux binder tests accordingly to drop the
> testing of this now-obsolete SELinux permission and to not rely on its
> availability for the other tests. It doesn't seem worthwhile to retain
> the test for the older driver since it was never allowed in Android
> even when it was possible.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 just re-runs ./tools/check-syntax -f to fix a formatting nit.

This has been applied and fixed selinux-testsuite runs for the
userspace testing (selinux-testsuite testing is still breaking on the
restored NFSv4 tests presumably due to running with a kernel that does
not yet have those fixes).
