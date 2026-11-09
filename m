Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237541;
	b=0gUbRW+yzuk67TE6TWSqPOoJCthwpSuTLlk5st7VMgRPV1rs6+waKx8FkKErMRVa3OLT
	 M6i0BIbt0uOja7pWWmU8nrwEeXjgGdcs1tfT5bqpfR51OuLNwOrlRVKkCbIfz5GUlvNbv
	 XrDYS1WtMgwWDCZoPcl8P6KrPh04KEAlOXcnCHEIJ11VrLa8Gw9XXCP+qIo9jJtanc/F9
	 VpkLbpH5/YF1Xy8QyQ/Q9dTaFvwZC7NN1kWhQpD4LodNvS9w08MCWk5LiiF1nSffN1//Q
	 AtADmYctTuNLpg1jQdy0QTHKK8Jxz7el5jNe5yofDtzEgsEUVQvaQDAnCjqAilUdv/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ienT4EM22oGLaRNnvQzIpXNfHDWgR3pB9ca6YknPvzA=;
	b=wF2hMViBRfdOMRzxAxkoaCYqxOLR+z7NLkmVqqd+5vxNkqRYHjhI50zlmAtUrfY7fjS2
	 B7fLXWPmC4TgxJ/02DHXteTxABy7NdXTxzptEHJZGVDjA+o46wAt5txd+YZcrb26//Hj4
	 kM6GVkvN7OpDnzjJ9xOVWfSViUPMhmd+EUAOJspx6bYQoWFqmPaPr36lnC26pU3kcVMKA
	 /xek8MCeGRrq8pXZ25RArTZKbZ7TOIA00sLUyfIL1RVBNi4sHe5ZQQsC5DHAEPK1xTBqP
	 Ue55tx+W937/iWjd007IF1i0Tmi9+spDzcSV/Rfmi9bxs3joWgQqy8EixGGOkbcnfGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=VmYwQqya;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F58606A321
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 15:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F58606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=VmYwQqya
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so8656055e9.2
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 07:19:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794237539; cv=none;
        d=google.com; s=arc-20260327;
        b=ayj2ujJUZTkNClX16X79K4kXMV93C37UB/nA9AlqVCMLGAywqiEKYoZKFaFk8iIrN4
         HrgE+lgCHzApoamtpjNEvJ8phzzmDRt1t9jPIs+Zf06220x0zueF/rP0jy6OSyybMNqv
         RexDBLHg21WkqdNFy29SJGwhSbSjJYKyBOXQlJygZjNLvHMpN0vcLnEyhjvDRL33UhU/
         dOMbykCtiacDvBCKEm4z2xUM96BHUfW28Fwzpa6k9K6GI/qi/h2FM5/k4C61Df1JGVD8
         bhoxAl7QrAVPOtaVUYH94uL79U7K7yfJGQdxMnBHkobzAG48zSLHY/YTvHu/W2NxIo/7
         +BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ienT4EM22oGLaRNnvQzIpXNfHDWgR3pB9ca6YknPvzA=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=Q1PJ7uMcyxu4QG1gVx1EjrwOEsv7OH6UwxnkohninnHmX3Yh9eV32/FKgv3Pk3oTEH
         Zo+VoJWTCm1949kKORnZ0GaK7szt2LkGSwzghPL6s/2BeEaB1opa1ICjVurk9LAjnFK2
         Lo1T8gKCnUB/c0kvtLHAGg6G04QiLG3JpwTcf1C4/0jowJETSMdM0BiFnlJDgJuCHVg4
         4mrF62utCue7hDDl03AXI/fcRxjUqLWgnGHxygSiYKG24htYg33XspyojFZedOXZ3wmR
         MoAgO/tcSnFIHXUIsX6oRVGbP4XBtZPYFVGb0CyURVYVmTEWt0Z80vRqmDg8p4hgKAIp
         VaGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794237539; x=1794842339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ienT4EM22oGLaRNnvQzIpXNfHDWgR3pB9ca6YknPvzA=;
        b=VmYwQqyaOUwC5DCU5WbhoW+M0nFMqO/v/YSAWjD1TEWLPcsaUIRdIRmxtooPRZyDY4
         luJ1Dylk7EiIGcDFo57/8adOCzvv0czSnOrAsIHiZxHZbLuWC1BHJHTA93o5SDHLppeW
         4t3PGKpDk6ahKimRVkxc1/EgI+NW2StLunOVbdisieCBDt9c6vuo67yNNy8kO7KSe8ou
         3XogZtih29sCcLGE5KME5jOyMY7yrsxgZuy2IvB/wcMzo5gXeVCJpOBGBPeiRvMUc9eB
         h2sq5ChElL80CNGbRKDnCh7WQNfji3CDNbbJD/8X1H/1Mr1tAyJB39+YpAh8lrl39lo5
         4/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237539; x=1794842339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ienT4EM22oGLaRNnvQzIpXNfHDWgR3pB9ca6YknPvzA=;
        b=xoFbbemqumCiO3bPpZVSB/JEn3mbAZKzr4btc83Gjkj/B77VGbBUx0I+YWXeIjTWuD
         BA8H65ypqHPVIAl2iSu4K0oeqm4hmKqcqkqlFz0MsqgjZabPUThNeXjwQdxyT4rpZPT+
         lbRrfgAWVLrT9Wj8Cr7uEDbqnLphFcchKZs7+kADyKwW+lbSAjsjS3ArpEBPI5iqAaY2
         YHLAV2IxwB8QLEdmfAVBgHCyBNFDsYQqfiJdYDcBPoueg5gHy00VuC3y4i69f5UXrspA
         hobjLkrfWMGjOgWc51tUW9B6H4XUiIeedRVpieF5PLqZ8KfL3sIgKYYuxc5SUj7D+ftc
         uggA==
X-Gm-Message-State: APuU4Z8pN3F6H/lv8OelLYb6WEj6XDKCM4Pv0sV8oKyzHdLTVafeDwfg
	3hujGk6ukMbYWjJyEl/7Freqxq6fRxudkWu/o4/wBNT98rO+3f7TVnGl3zJTHMDbjJP36WyEEOW
	Odm9ZTagx0ke0A/gZ9COJgokG2cYN4wk=
X-Gm-Gg: AYBFou0I8Ihv0PKBNdm1J9okdDV9gWniknl7spJQpiJcJUiofJzMHwU0KEGmHFrJGW0
	7Gq/h2OW6comLck8Bz2VWcX3KswUvr/WOvn57aWg3B05B6bguaF2YSuxIeq2g5bPbvy17F6uO2K
	2IDYNjFEoS3RjEJFxhn7SRwah42LRrgKBIIT2P6379seU0Aa+BquJ9tJhoWUUJ/Hy4c9leRm9/C
	Zl0aMdLNSgodrjbyMFK+9Js63nv6h6m+GAx4z59BzFGKiyREU7WvvEdGRYzF7AoxrSWTRC4xFr1
	n4JIaRmSY+DAELn7vIT2ZfMfhr025l5tLpT7kSOdcmb9FrmBPhCf9917bHL62S+g1yX4I14qZkC
	NbVpVe10oI8ZP4cJ2bX5kWHPY7affCYvwE4O+O4f+siubXA7EMfI=
X-Received: by 2002:a05:600d:82ea:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4b943f76d81mr97300765e9.0.1794237538720; Mon, 09 Nov 2026
 07:18:58 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106131652.267648-1-cgoettsche@seltendoof.de> <CAEjxPJ5GXUcUD58w3NeWqqTGPJirii-HHUR67pK+SEDv14Awgw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5GXUcUD58w3NeWqqTGPJirii-HHUR67pK+SEDv14Awgw@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 9 Nov 2026 16:18:46 +0100
X-Gm-Features: AclHuK_ijdatfrP7jNc-NQDfNYPKEmUjXrBly3A57OyLHCsl3dzP2-5OC-8FEZI
Message-ID: <CAJ2a_Dc4hUqbQQGvUaAZzbmGn2HEk_4XoaaZRb_-3h5Ze3RNvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: keep the uncompressed filename transition
 format for Xen
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Nov 2026 at 21:16, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 6, 2026 at 8:18=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Commit 890bc6bf ("libsepol,checkpolicy: update remaining policyvers
> > comparisons to correctly handle Xen policies") restricted the
> > uncompressed filename transition format to SELinux policies older than
> > POLICYDB_VERSION_COMP_FTRANS. Xen policy versions are numbered
> > separately and never gained the compressed format, so Xen policies are
> > now read and written in the compressed format instead, which is
> > incompatible with every earlier release. For example, a Xen v30 policy
> > with a named type transition written by checkpolicy 3.11 fails to load:
> >
> >     ebitmap: map size 4 does not match my size 64 (high bit was 8)
> >
> > and policies written now cannot be read by 3.11.
> >
> > Use the compressed format only for SELinux policies of version
> > POLICYDB_VERSION_COMP_FTRANS or later, via a common helper for reading
> > and writing.
> >
> > Add a Xen v30 binary policy written by checkpolicy 3.11 to the
> > checkpolicy tests and check that it is read correctly and that the same
> > source compiles to an identical binary, as a roundtrip through a single
> > implementation does not detect such format changes.
> >
> > Assisted-by: Claude:claude-5.5-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> This breaks make check-format:
> libsepol/src/private.h:53:36: error: code should be clang-formatted
> [-Wclang-format-violations]
> #define policydb_has_comp_ftrans(p)                       \
>
> Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> For this and other format-only issues, if you want me to reformat them
> for you, let me know and I will do so.

If its okay for you, it'll be great if you could reformat them before
applying. I'll try to check for format issues before posting in the
future.
