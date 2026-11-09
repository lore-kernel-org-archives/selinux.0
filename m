Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241247;
	b=H39YreXA9hzULPqky0ANI0D9BM2dcb+Z7fs77NCPG49PmPNfskEqvoY84ugfYC5CXoiP
	 FNxd3dhRFbaEDpt6EzD1JODPNLcbrm/Ibz086fzAzqVB1TwEVXMxE6aKutyPilYmefb21
	 iRpQtG3fldhg8ytbRNnvmOP9jIKofZUKu8jKKEAX9QI5cul3gBV47pZav46PrCJZGK3XH
	 E8z2ruajlTBxvbLm4Q7xohoFGJtvrJW+kVm6b9mXO0Dn3ssCAFqkuhqe5J8nGnmqUHf48
	 k1VLINyzWkb37yXCCAkFS6Y5pTxzJeOcOVEWiI1dGDohRNLJoPlqkOpNdEio5UY3J0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=NgRCqMLFvLjuRrDDrm1ekhwt0VHB+kS7V8Z8bQ6j4Jk=;
	b=ttfRj7b+ewgYY0GSEdEVkz0r2UIvfLw2bFjAxV8mg9sg7SosS+/CTzXWbP9UEKdpYZOJ
	 NHvAWVr8+LtnVU3pjL3UkP0Gy0bGpoUSh7j3lUC158Zrrd39jP3MMzWxsHG5d6B5pM/wl
	 BguTN179i70zz4laOT8UZrqgZM/1w7/Pry/PHzpvZgqWS+Mf8wM+jlYHfrj7zVs08221x
	 lLK2nNxk76U4/3KSYNixR8C8/HhrzsQ2Nx2XNLHt3LGrt3JQdAwY/l7ucQXobl5lgp3Hv
	 77nQkAAI4HPBPCf6Eixtr6100b0pV83Bcc5+Qb0rhkr0nNtHrSReGXoPnXDbdscEuYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyLPvUKN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA913606A321
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA913606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YyLPvUKN
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b0dba37a7fso10788207b3.0
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:20:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241246; cv=none;
        d=google.com; s=arc-20260327;
        b=ABkgOpYmQx6wU08MBv322rn0t/EUkO3GFhMjg3x0H7xUm64FJZtfy0lcW77eOnyqXK
         iOLsjxfgi4VRmuKLRd2LPmpGyVoZaR11pQElXRHZGK6FF6jBLN8WxWtHXHE+WMmOupKW
         QADiLP5aoW5EcpGLPZatIlgnzVMlcx0k/gI6PNUTOzPjGfZbyoOB7hzTRy4V1uqJ1qWg
         G4wUQM6TilKBBJDaFfl5YYdH+UArCwz8lVlioumUiNGe1XOPZXwQZDRf4ln7OzTDMpf5
         2KfZkyMOoIoF1Srkj1K4SRiZ5Gswz3UsN1T4U4VT1zg3bNGWZMzjHVv0AL3ePKgfnhJ4
         1imQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NgRCqMLFvLjuRrDDrm1ekhwt0VHB+kS7V8Z8bQ6j4Jk=;
        fh=6ukFSrvF76AQcoFTaTVTCq+q3hg10Iykt9cHjSUbAks=;
        b=pPzE6cV+irV6usDVbsCrBoQdloEpV9yYdbpxj0CAYOFL8u191UIZmR/pvvJNa2E+hu
         c6ThBwwSgYiP5Q6xyPKxF/MJwLO/iBNQTh6d95DZt9ku4pyQucIMQpq/1z598j2j8538
         nhpLwmRv9R3ph+hKVPXXokKdFVbAqOROtDgrgJ9HjuG20WuAC4VNjuavDCIPbKeXrHrI
         iiwwY3AetYejbMDzoSXWnt0t3K6AA2sWKMossDB1eMdxZi02gc0AooBeTz/hOcM4XeM8
         qpXChGSDRZBfcesP4tTflWz6G4K81xiuR5dvhzV9UF6JEuldv3kfIvraxeC/sr5HRJAS
         RCnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241246; x=1794846046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NgRCqMLFvLjuRrDDrm1ekhwt0VHB+kS7V8Z8bQ6j4Jk=;
        b=YyLPvUKNN1cqxrr4HAYuSe48q9EiR4xyCX+aJIrltDzZEaIKqW9TI7lvUBlB2gKXMO
         e7Put7cNqau4X008KPHt+aRwINPT+UQwcSB5zNnfegUk87iDriqFF1XTwY1zl6lZ2BKP
         DS5XCfRj5boio9hJANORWk93gY+lRo3hyZYf+WjsiyfdZmlCRP9cMRjKF40HYcQJVeeE
         yXOzpgeuFq0yQzEygLl/pk9jSnY93usrMnDeSNacus3x071ltfs+lLtGNVhqN8MWDwqp
         7OOE0V9Qan9F0xT6b3XEfbc4B3io64wEy06ituwppmYu60Val09Z7W/W66ao0Dpc9loy
         wzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241246; x=1794846046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgRCqMLFvLjuRrDDrm1ekhwt0VHB+kS7V8Z8bQ6j4Jk=;
        b=05JgOMuLAjrE5aQ6Fa5F3DkwoaBKQJqSOKg8hUPY6XgHDQg0GSOmdWV2K/iouyoIG2
         sCCJmtq88O8itcNPv35x3W0g6AV+q/6xh9okzSBg0MnkUYDysN8OYRvgX+lj8RGhwdfK
         2gX15MnhOTmmjrrue1yXPVZQFUs7Te0oJ8PhgImhEFlcAZlnVwkrSXVECu+hzbewHMf0
         g8D5zwgCFG2eaedXGj0IJ9vDkL6kBipM6V3I9fhnuKE6X4KRJT0mCcVIx6tYMVp+5FLl
         Zq5OfUkEcgOuA6kNLzk96rKNCMXqWYGZ7AukANBGEUa9Et2YMEShUSn88hx1giDw7SVF
         ATVQ==
X-Gm-Message-State: APuU4Z+UAXE29UQzI87PH827JX+SmuOTgnBDpe/r7KH2pr1mcAF35GYg
	ccHWT3xud1EJ73Qy2rrk5uOVAZBRyxfmRsmIVGkqFv9B8ExyCiYjmOemgt4ynlpB06aN4ei7/mE
	Tg8i6djn6AcnHiGqAnBp5KTxcWGe/I0E=
X-Gm-Gg: AYBFou2bUHLuSfyh9BYluV3TJIicNzK82lkswSSX2TuuWDs6rFV9l3PFQ6vATBMHDa1
	6ROfNiSI9gxWYOxM+9UzSpHCmQYP2XbywXcQKOJAy+xGzJjyLzZAgCbbXcphGndX8KuB6LcvpBI
	PHGfwPSwwdLmR7c2ilDJlG48u+SXtcIoQ5DbSD1AkyKIR9ReRnqFg69PjaB8+hW4mtzMdEmW5uW
	e3Ay+O7M/mGBiCZggPfY/QDBipXpo+BS5KsbQWQW71iIIgAEwRoRh8eKS6zYRae1h7gWBDnIo0L
	RkDRZeC6Z5UR+r0y0qUJAkM3litBx6j4e5holj7Fmb9yrm4Ze2Z01W7F3t+ngaRq8qhkssr9lz9
	1FX3VbLvZfgDAL1mr5CgnJllTPS416S4rJM5MbuspvfjKUIwc1izjZEEKPs42HOlNtM1l0BhHHt
	0nf6RUPOnn3zhIl30qC2rjizz5cJppSL0rcY6YQIc6txGa1L3Ln7ibvSYj7A==
X-Received: by 2002:a05:690e:408b:b0:679:abf5:1478 with SMTP id
 956f58d0204a3-67c5674af0fmr36274d50.50.1794241245828; Mon, 09 Nov 2026
 08:20:45 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
 <20261106123510.76727-16-cgoettsche@seltendoof.de> <CAEjxPJ66DMfY2VqHT5hFG7Eq6XCPaOfxVMO+-CejNM++qCx+aA@mail.gmail.com>
In-Reply-To: <CAEjxPJ66DMfY2VqHT5hFG7Eq6XCPaOfxVMO+-CejNM++qCx+aA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:20:34 -0500
X-Gm-Features: AclHuK9_JiKqEIiKEf1_GWMugSDgZw4QPTNFM1AjEJC-1AsLEP__xaoWT3_6-Fs
Message-ID: <CAEjxPJ5JY8eYL4geAp-ODrXCxm6v0qdpJiNfyn55=4JbtegHJw@mail.gmail.com>
Subject: Re: [PATCH 01/16] libselinux: correct realpath_not_final() buffer
 size documentation
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 2:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 6, 2026 at 7:35=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > realpath_not_final() checks the combined length of the resolved parent,
> > final component, separator and terminating NUL against PATH_MAX. A buff=
er
> > of PATH_MAX bytes is therefore sufficient, as for realpath().
> >
> > Correct the public header's PATH_MAX + 1 requirement and fix the gramma=
r
> > of the surrounding comment.
> >
> > Reported-by: Petr Lautrbach <plautrba@redhat.com>
> > Link: https://lore.kernel.org/selinux/87czpkacxf.fsf@redhat.com/
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged. As a side note, since we are in the
release candidate cycle, please give precedence to patches that fix
bugs only, with security bugs as first priority (via SECURITY.md
process), then bugs that fix issues introduced in the 3.11 release or
later ordered by severity, then fixes for earlier/more longstanding
bugs ordered by severity. This will help us prioritize accordingly for
the 3.12 release.
