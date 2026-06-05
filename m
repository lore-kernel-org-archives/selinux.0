Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01343EE1F8
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676634; cv=pass; b=rFFIi7U8eKpBsEPT3BFOnA0Tp39ugvaty02nJPKVqfC4XUxI99VNdVGyqtaQ+ehUqSeZ+lLjE0mewwmrSm73XeY/yJc7KtYkiSgIlf1HhrWHhwaUdBZZAxu/vumk4MkeLKYmCSJgv0fvFoyj39zqKNoC09vf81i2jB7VPBPJsB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676634; c=relaxed/simple;
	bh=otGb1onRXpISUdinbXUgxEbuw+a+btRAek/oNUgMhpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhmCzt6D0DKBhBiAP04VFe1f/5oihJaASFksy4c+9I7HUmS/KEl590i+JB5dqBCtiCATylQHIB3Qk5g4hQMtWjxy2o5ZMuS5H/zM1NPoNjqLwAYqxP2MJZRNnkpLXrx7anCJk3f4ghDfm7Trc5labldhKoM0ZBcWk1GtlMsTM98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bO46LGjr; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO46LGjr"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so1544813a91.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676631; cv=none;
        d=google.com; s=arc-20240605;
        b=RU7sVGK7BBR9kquYtmof4RLLP4gvFDodfXlzB0VUjq94sZpO4yHd9b/Et3bgtJkWrJ
         B9WJmv5bfMFrHCl+OOu+AgA4iibG0pWiIGfK4r+C0xudiXPCKP4P1IGNFEJV3npGMNsY
         jUzBB2qg2gs5AlHMg+Nk/8UqjdorDXx/hY6n22DsrqCj8XkyTyIBNLc33vsZ8ReMuZnS
         eiDL5a7lNVnHi17S/wEbhMFNbow452qSNESDbkck8/ide2Boe6XiU7JwyStD4i/kqujA
         nLWJMRXPmwuAoNfCEeubueUPSZc+u9FzaBnrmMS5cw0e7SoVQ+TcKDDJ2nQjiWjUSwlU
         js9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=otGb1onRXpISUdinbXUgxEbuw+a+btRAek/oNUgMhpo=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=QifwR6/T6uBsdcC0v1HVAehbmybDDByGLOrRSUf4vI0olwescfYiKLfKv2C86sPfFj
         SQCg2AbIIu8YHd11dQqOtQkNwDZWsJgqelAL76OkvjBh0Sw8QAC6LupKrME4ycZx4EkT
         E/e7pEXshRdk4F39SYbNActjNBfXvwGRd/ynncQjqVX3TyBLutiolE0Sx/sJ+eBYGwGa
         dXsZAxweT7CZEFpkZCmf24ms5r2AgheT5E4fic9mmFXyZ5/4Y96PWy7sDklSD5cER4IM
         NO0aFyyJRgnCmwOkqFTFTAN4Pn6bINIdQApSHWPmnr/1AR9X5ti2Zg3YnMI77GmQDFj5
         UCCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676631; x=1781281431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otGb1onRXpISUdinbXUgxEbuw+a+btRAek/oNUgMhpo=;
        b=bO46LGjr1hACFEHfUZYzSbCocIKX/iBRkQ7AEQYxCBlcmh8f2f3looXScQ7dnZBgli
         B4eyoqgPGELANE5UIB5UDDiHWL9uGk3p6vTM2T04F7OZL9p0x3TG6xpFcU+7ZgCZy6Hl
         FL0ZUWT6mIpeqULsn2C17mwd4fYCUCrM8wUvmv+PgMCMBbFCD5lCW+vTCh75DhyfaHEH
         s4DhlcN1gUe4WOANL5I7nscVgDn3Qw7g8mY/7C5fr8JY8Cl5uZzcdgS3koNxPZCUiGrH
         1Mx4Tep1cVDdT2i1eiQeX7weFH76fc4pVdPxGMXA30X78rM4RR+SESO5ftfjbRPpxXji
         7Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676631; x=1781281431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otGb1onRXpISUdinbXUgxEbuw+a+btRAek/oNUgMhpo=;
        b=sp2rlSJOgXxj+3HRfVGhpH+MEJLEO2BDtWVIzRKdQOkIS66JUBIUXfxOUuW6azzmrY
         g3csRhZx+bCz3j21s+tuRWPDw1yDuLHxF7Y4R4c6vrP5AtyEjrj9mbu6rWD0OzTSy599
         f0tAG85HcbB+EHhOMasQN2j4318gX+XnLB3lA+kiKGyIZPwBd4xtbBh6VdXK0fyTstMK
         ARtG5smRftCuLQoOmMyqIpWJCfOU6/04OSnl2ZFmbnDOhhrS7dzrk6frcGkmESn4S/dj
         hta+RJkyUNhVugd7luOdqwYZPhXTvwVQRbF+kEztOSP+Za+r8/eEkAodRQpTjqDiTJKE
         XFTQ==
X-Gm-Message-State: AOJu0Yz8cFcUHuxm+fHGhainEwdAhBMV6VGDj7sobVYBV/RkXKCYGw2z
	cXsvOl8NcopTwtdVIFmZrIAmyDj2cMyENtXfF8yuV5cwCd47mMbmBkOouCyfgAkQY/pP6cPtcpC
	hHvUVbsZwBXiW30Pc+lZxgjl4VgyktRQ=
X-Gm-Gg: Acq92OHmAcHVyOKopER5JkxaKoLB3PrPT9Tq/zjkXWkG5MYvWpF2CS+5GFUbIGBvZ8Z
	9vc8ja4sCXdCZNRCrfuRGSnPcYPxRKf7TrCzl54lPw8N53y9WsNIwieqFAEe9aS8zvGZ3zYisZ9
	APect0thXYfuE2ml82pjakL4OTJQIwbgGi/m0C8gX516NBZEqksm3nt+sFdFIHfx0uL4VrYIkua
	4i3YPI8+bfQdKD9GwED6kEsYhpYLsmxNFcXoYgZ1tN8djparWNxw+v+f+qdgaeD1kcqnJ88DW0Z
	21f0MdK1848YdZtQwcYpYYkunn4Y
X-Received: by 2002:a17:90b:560d:b0:36d:630a:c4e4 with SMTP id
 98e67ed59e1d1-3712ffaa11fmr2688077a91.3.1780676630700; Fri, 05 Jun 2026
 09:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125940.255722-1-stephen.smalley.work@gmail.com> <CAP+JOzTcY4iQR-ePFoCvyMQNqKC+OVXMfZx3pktHUVcKXnm_Zw@mail.gmail.com>
In-Reply-To: <CAP+JOzTcY4iQR-ePFoCvyMQNqKC+OVXMfZx3pktHUVcKXnm_Zw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:23:39 -0400
X-Gm-Features: AVHnY4Iw0eQPdDm6fGXF-mGvPwwBkqVFnbp6QpqewlAxdTcTTkgLqNOmm2rkOCw
Message-ID: <CAEjxPJ7y9b98=1j3u6AaLkkp_KVK5ncHq93wSF7piyNb9m9oOQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: serialize legacy compat_validate() callbacks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:14=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 8:59=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > selabel_fini() calls compat_validate() per lookup. If a legacy
> > myinvalidcon or mycanoncon callback is set, e.g. via the
> > matchpathcon_init_prefix() call by selinux_file_context_verify() or
> > selinux_lsetfilecon_default(), then the callback is invoked with no
> > locking and will validate or canonicalize the context on every
> > lookup. Replicate the logic from selabel_validate() so that we only
> > perform such validation or canonicalization once and that we do so
> > with appropriate locking.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
