Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533265;
	b=Is/l58u5hYASyMz979UPY9U9SWoNifCyTyY3r8FH7LBZaEgcjGLadev76WzLXSHFan35
	 AzzBXm043BHX3UKIas0RdSqiFzKTecdGOhjUnVN2o6rK+zWFUiCpPKdsbWY+n6Q9/IeZB
	 79xxreDcSP0HDCDOjAFA093kpNdPmIbgAf2xss170V88m3DM8R507FfWJmO/EH5/YjqgD
	 //ONN9NjLlb6YsM953Kyoz3qIyeGpssvKHjukEoNoqKO8keT9kAAhWaSbOX2PD7HkG6xk
	 WYuYV3TmiNVdukSF+y7RTEy0xUF8GlXu4NJCrUnyM56hx7t4HnIGRHs62yAacygi6qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type;
	bh=PVJS6gkYs1IOy2J1QEN8soh2l1ljp7ZJVoiYPlTtrQ8=;
	b=Phg5B6la13AcflXcVTpEprbEh1xnCbWEIUEJwi1mFJPXcZ6IOfLoBuMkQySqDP5pQ9Bm
	 5uhSXEFD/zwe2VN+rA8rKSUbp+PtjegIZ7V1sIndeZSiq/GWD5H4CL/91F4l+MyR4lJUr
	 nQcBlYk1znjlE40+9qYEnmBCGUSnA7ECX+yoXfICEX/P1r5Xs0tLAArmA/vymquaUMvq0
	 y+QUE2fsEh1GYzOa/LwxCjEaZj/9zI4wrp9rzmWqBlhoPHXZMoz0WtD5imbciN3Yd6J+C
	 fXlVcM80G/d+QC1S7VSEmTI8SiL6t9ya6pWFzxIRYnvYJSFKhMraQXev1TX+pJuN/gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ebSy9c36;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536E606A330
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 15:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9536E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ebSy9c36
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so764030566b.3
        for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795533263; x=1796138063; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PVJS6gkYs1IOy2J1QEN8soh2l1ljp7ZJVoiYPlTtrQ8=;
        b=ebSy9c36aTR8fbWR4auSrsGE/djusSt0wnGSrYtNZznYZO2AGsYTXrIWq5Yx/WWe6e
         5ppdti40uhKEW94t7ZFSocCJi011dLv/IVmpZLdx/hiVg8VcBfIBAEs9q1T6IWtCm+Xj
         oSM2xBQwN4fD4gQt5tj/eZqzLrclz2LCj8ebVfMTOHAVciqttvJTIS7ZcwhwWF0k9wQ5
         8NioETZdeLEjKVFWDGMpidQVMTe6Mx8z++FhWSVzYqOd2ooA4jgnCjR11G0MKsf6jdMF
         /pjFmiUu291q6bMbQPtFgKvgB/yL4somch6Ia+TKpVodctkK5lj2HheDegrBEjDsKVgM
         rucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795533263; x=1796138063;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVJS6gkYs1IOy2J1QEN8soh2l1ljp7ZJVoiYPlTtrQ8=;
        b=KTKZFLnoAsBv6l6UiMQbnGhI/Yuao5AZCtoeMgYYXZX/5kMqjPYxWYT3jixGpwdwGJ
         tSvqtZj8bKgpEWL60Blph1vZmEZtlgDpPOKyAXk9GB2ZhUJWqh02POom8LYNXxdeG8ce
         g4jcYCOdg6mDXQB14t3EAT1LNspNLIiIGWelMHVx3V1O1Oy6YzWNUNsV3ZKySGvMEfQw
         JtWWH58pmew4f+5LwXrn7fXnKpQo8EPkxopa/frvCtTneP0e8XE42yG2K1oge6Io+AXz
         dvhgy6Htvb9Ro33pkSA8+rEIqgph/grNv9cJj6eLlXf4UPdwAO9zsBlQ22zQm3fzRy1n
         aY+g==
X-Forwarded-Encrypted: i=1; AL+hErEb1QSDwLpX2rMCzGhCp3AV++2CFUl45fKMOcTeOUJ7LpcDFIFmSdj5IWNwIqjMbPiGGvV8DH5s@vger.kernel.org
X-Gm-Message-State: APuU4Z+SxDhZn942VYNxFQzqOlvjh1LCYithi/0Oo/wEL3gwpr6c/H7U
	WfwknD02wwh8FU2ZFBpy7h/wVYQl3qwMsRje+B8FaVbuW7+42YQO1NJO+v9RJDYci/g=
X-Gm-Gg: AZFdTZdcnR/n/HjBme0N67H1Q6xKXe1luwzC0vM0CI3HMEYAoRVFAKUQSuwIRZ3ugyc
	GixIAO0Fp+7vzAzy2WCE+x6VQ5tPCXkZnhbluP7assp3kye1wIyClnfnPZHiPCs6n7x+ZYNVMT2
	q7bRV652qBOwwS8MkxXEcHx9Cr2a4M/gMKHYQ+DX8+PPKPrHMqPV7GWgEvDvs9Rneg6qYAy/bgE
	g06h9sQrsvgNDM8iuT/ZNhDY2ccevOn32CA1bXk725RtR7UjhyVe7/XFgdY8d5KPDMMoeJRzZ2t
	ohfH7Yq29dOZO8rCo2qVJBmD+w3pRgOCZ1aB4eDM2DVLEqKNHz5Gii7ZyoJL3xe9N7sbvH0tAxq
	6TIb+DwUJPJFUucAfDlqOdu2teCe8yI8HSxICms3V64EITurl61MzX23c7NFYlbroZ2+5kb0sax
	r0qfassyOLvt8rM0fX14VaRMKsVpqxsW7rk4MN+IpaL0TBi94HsjDcHr2NpOBq0zHYEFIPmmYk6
	65FyXw+VbCsSYBWbHiEWsQF1OWtQkHGhiGAG0BVxx6zdTHPRxwFZuIhyhHgPBOp1xH2A4QSnd7X
	Sw0Zq5gHHqE3u2w80R4GERkPpS9WK79cPMeqe+f8aKVft1/QZRcqknNr9PCKlzv1naGxThrW85c
	tEMVNbgHSRN+bEpDXV1FKnEXDB+ZzG6UTRkiPE8IlVT2TgFEFBCw=
X-Received: by 2002:a17:906:c14b:b0:c35:babe:ab44 with SMTP id a640c23a62f3a-c513a1e0076mr1490288666b.0.1795533262820;
        Tue, 24 Nov 2026 07:14:22 -0800 (PST)
Received: from ?IPV6:2a00:12d0:afa3:c01:92cc:e257:77ba:97a1? (2a00-12d0-afa3-c01-92cc-e257-77ba-97a1.ip.tng.de. [2a00:12d0:afa3:c01:92cc:e257:77ba:97a1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae698ccsm534442066b.26.2026.11.24.07.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 07:14:22 -0800 (PST)
Message-ID: <589d567e-912d-4913-9949-ee28dfd7f719@suse.com>
Date: Tue, 24 Nov 2026 16:14:21 +0100
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xen: convert xenstore interface mmap hooks to
 mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
 Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Scott Branden <scott.branden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 netdev@vger.kernel.org, linux-mm@kvack.org
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-7-0b0d99d655f9@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-7-0b0d99d655f9@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rZw0QHKmzMvHx5VSPSOUKur0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rZw0QHKmzMvHx5VSPSOUKur0
Content-Type: multipart/mixed; boundary="------------1hIkmj8WyEEdRHjB5CXVAQ0q";
 protected-headers="v1"; hp="clear"
Message-ID: <589d567e-912d-4913-9949-ee28dfd7f719@suse.com>
Date: Tue, 24 Nov 2026 16:14:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] xen: convert xenstore interface mmap hooks to
 mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
 Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Scott Branden <scott.branden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Richard Cochran <richardcochran@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 netdev@vger.kernel.org, linux-mm@kvack.org
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-7-0b0d99d655f9@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-7-0b0d99d655f9@kernel.org>

--------------1hIkmj8WyEEdRHjB5CXVAQ0q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMTEuMjYgMTU6MDIsIExvcmVuem8gU3RvYWtlcyAoQVJNKSB3cm90ZToNCj4gTW92
ZSBmcm9tIHRoZSBkZXByZWNhdGVkIG1tYXAgaG9vayB0byB0aGUgbmV3IG1tYXBfcHJlcGFy
ZSBob29rIGZvciB0aGUNCj4geGVuZnMgeHNkX2t2YSBmaWxlIGFuZCB0aGUgeGVuYnVzX2Jh
Y2tlbmQgZGV2aWNlLCBib3RoIG9mIHdoaWNoIHJlbWFwIHRoZQ0KPiB4ZW5zdG9yZSBpbnRl
cmZhY2UgcGFnZS4NCj4gDQo+IFVzZSB0aGUgUEZOIHJlbWFwIG1tYXAgYWN0aW9uIHRvIGRv
IHNvLCByZXRhaW5pbmcgdGhlIC1FQUdBSU4gZXJyb3Igb24NCj4gZmFpbHVyZSB2aWEgdGhl
IGFjdGlvbiBlcnJvciBvdmVycmlkZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvcmVuem8g
U3RvYWtlcyAoQVJNKSA8bGpzQGtlcm5lbC5vcmc+DQpBY2tlZC1ieTogSnVlcmdlbiBHcm9z
cyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==

--------------1hIkmj8WyEEdRHjB5CXVAQ0q--

--------------rZw0QHKmzMvHx5VSPSOUKur0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmsFqc0FAwAAAAAACgkQsN6d1ii/Ey8U
agf9EKmbZX8l548UDsdyJg6oJvCYHOXjuS/ExKBuNpmGhFgk7GREMY+3u3PwwH5i8jr55bbeWohR
PQZmJLsVx91G2Go2UnTECf+ux5hcQK/L88QRCcbKXHLPL5o2jl4qSVtCpjc4+Zq8UulQYIwYP35a
OS34bD2osQ81MOzn9C89cW+1W2vyw6436TybryP/f0H8AtinZ/cTr3yFyQO/tR2V2NBHtEzwqslP
jNDjxr1xdpiDdCL4jZ8rdh7WfCE5cgGr89hzbDR9ZyzH4ka8x2ICUX++Mym777GSOuxLf3wzSPuW
OkTRlKQEHsYqdVjYj7TAHGOBC56IwBlTfAmWefOR2g==
=vFml
-----END PGP SIGNATURE-----

--------------rZw0QHKmzMvHx5VSPSOUKur0--
