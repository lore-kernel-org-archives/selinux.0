Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA632692C
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206492; cv=pass; b=kFL+0EXOgOHEWzbAI0BA9wTAmGDVF8N+JAYXLnimTqbefsR05D7yrgnVnDAONOTrBmF3tqFo0t6jBgwLhvhcqE8jevqZBSm7eDe/TQIjw8neGDFP2qGL/nNk4SzSCIFyrjyDI0mlKC10TgXCjIZqMoH7fn2isLGMCU6TIoUuRh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206492; c=relaxed/simple;
	bh=KQfZNNrMjG2Kqnp7Af5JGVIqTuf+X2bJ3PXcVzb7g70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DE3z3ADhjG3vefeY30CTn7ptK9l8n6qmR3jJ1mtu6pOqsmlGdot/KfX4XPdwoiKo3CcmGjW0rG+K6wFPTDBqtUzdiS4E1msWlTCXU2NYijDyzP+JM56Zrv1t56wRVsKJLsDvp31QnhEkEg5y/1RHsaeUTfGGQNxxfXz24RNsc6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3vLm+5q; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3vLm+5q"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f236418so220238b3a.1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 12:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781206491; cv=none;
        d=google.com; s=arc-20240605;
        b=kDvLQiTQthRTLovU4S8wRsupoAI2y4GVSsSt18ehEor+O2saKUtV7RwLvkCBvTCxCV
         nq6A89tOxKW1gioTsAC5AKXDq7a++eMkI7wYkhMBnlHD1Rcdg5QswNzdmr8rATtaqeQg
         W/3ZjsQhPgLvmOu/SnbNiDCQpYkVjTM6cCPwaJ1+XCcFG9+Ksox/7DkP1f2EPAs+ax1M
         b0SGFZjoakzM6pJdoHyHjKTH1zZLbajZ7rdQYAkBnDeDNsBnIQxV6k6lbqjnB1RGQtoJ
         Rv7uCJOWZMGqj8s3MCcgggnPTpyk/9O5w7Uoce17zkNsf/BDAUtHLfwEAqALKYTN29pB
         IEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KQfZNNrMjG2Kqnp7Af5JGVIqTuf+X2bJ3PXcVzb7g70=;
        fh=FtK/lcmPopwhenPbfaNJghOBi59lv7Uem6KTQb051Bg=;
        b=XBnOuY9SKx0RP61yco+fVlN8+JtiCbpcqMX6AiY5/yCsP916o56P32mzMZ7/lfnWFY
         gESxeCVofAkdv9mqmHe2vMAn46leptdcXjEfZYTe6O274CkgkImXTX0nEQ70eXJOE4D5
         0SaETv9I6PUODHa32h/BIPV6uecv/WFtkKq9/bEC7G4VV5vt+2433n6ZLMs5GlqLjaHQ
         xHJhgFR5Rb0YQfm8j0WKt20OCbhlYIrTQEKcEukQMdbgBgTC3MJicvyjN4hAovLEs47f
         8uTKE6L1NUXRxWAnNrjeZ8XdIg3FIkPRz4/4+5jHOH8Ntkrw6kJf2HWo4+VO8X/Xdugz
         OZpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781206491; x=1781811291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQfZNNrMjG2Kqnp7Af5JGVIqTuf+X2bJ3PXcVzb7g70=;
        b=V3vLm+5q3PwE4vz3jAqIAvbJ8mv4vd+3oKPaVkXAhBkuduWugT9eoOIYtuK5vyaswJ
         B3KobUWWmR9kTiNlMCx2xiypFeGc6kDoH2zMmq6Fi+GKP47p0FWAd0zoL0Aq4ekypcDy
         NalfiqwJLfMy+bzzehKALGjnXbI4zXOxfFG6w0HCzFCgzw2cVjlSADUebw/LX30Ks8/g
         cDJaRrpYtj8TfPTWy8ZPeZ62Nkx32PGx6Ka6wcqJWAhbCCJSw7rB0PPcQxChJSF49RBu
         uMEgcPHl5Mm99+8ZqokTdMEozfUj/fnq4HUiLkNXHitzEB52QfE/8hrBigR0AdtOWXJB
         idEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206491; x=1781811291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQfZNNrMjG2Kqnp7Af5JGVIqTuf+X2bJ3PXcVzb7g70=;
        b=qcoieqizwoDZlgGpsDehsPpJlZvUa/dqUmuSKXFsSCn6aGVT5JIefRHuZ3VvFfr6yK
         M1pbK0nCC0xCHJo7/hnbzLorqWLJSwgpc67zy0c9fz+vmP7Gmbsbl4yXt+aBe/dCBJAA
         P4/p1YHHYv5l00qJyZILAvBv2YLzR8ClA6Ks+qC8qLDEwXgkSrzM1jhBLvcbIj9pnLXi
         wn/6ThXnYlF0FLllg6hKSTJcvlNwd9EupEu2TwO7xgTpvjh1uQMhUrGrHnBJ3Fkn6/dl
         ueEyilH/OrXLDUx86bzJ8f5aVDDDn6iBQrkYVLMUyjVNYnoYdRLNHWQaV47w4j1L+qJR
         LNIg==
X-Gm-Message-State: AOJu0YwTarXtTeyUiruRGz2TGTdNop2AzYJuGXBSEd5jdUPtwvwu2Eh3
	eOiRHc3+71ocacSaNGiv32MA3ccjJ+p8O2p4sXRQuDO1RGjGGNzNrzW+CzJoc7U5qePlUjCs7jp
	hNjya+2stB3EBpaDCVCwPpVI7O9+1UcY=
X-Gm-Gg: Acq92OFVvArFQR7MFHmvPuRwJfx9un6fqwIWquXBnSaw8mav3OHnGn05ZlpUQPKPWr3
	HdYaPzJPkNRcaBQ2My3CZR7uxB0cSl9AeqyeMv8dhtVoAlMEyIBxpiHdVuZHYNAikPUSsqfkN0X
	UTCOO3RfmTqxtP2CHJ4rOyL8zrqzaD8I9rBeT0OxSDLdXrE6D/9p31ThAgg2bJldTbZWvMHcKN4
	B4vcy4inaHwtTs1kbPnHh6r/8R1AewhnhvQAA2LaNtlTgnDDP+voJSbDb7zrtUPnVxtQnhswrbT
	BlB3xpc=
X-Received: by 2002:a05:6a00:3a29:b0:829:8942:2c93 with SMTP id
 d2e1a72fcca58-843367eba8cmr4742749b3a.9.1781206490742; Thu, 11 Jun 2026
 12:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611130351.15988-1-stephen.smalley.work@gmail.com> <CAJ2a_DfUb2dWUMO-1Kr9_8j5swjeOHwwp0n7brfQR3-5vg=HmQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DfUb2dWUMO-1Kr9_8j5swjeOHwwp0n7brfQR3-5vg=HmQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Jun 2026 15:34:39 -0400
X-Gm-Features: AVVi8CenILD7ac7nj4qj6pcl9Qkh4Hn07BECk2LX2cEoxjcVCcSGgswT06tugbQ
Message-ID: <CAEjxPJ4hhWE_9wAywrdPT4UdUJt9cgo6=ckH6_4=2gnxuET6UA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add --undefined-version to LD_SONAME_FLAGS
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	omosnace@redhat.com, Pepper Gray <hello@peppergray.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:50=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 11 Jun 2026 at 15:10, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > commit 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> > introduced a matchpathcon_filespec_add64 symbol for certain 32-bit
> > configurations but added it to libselinux.map. This was benign under
> > GNU ld but breaks lld due to differing defaults for
> > --no-undefined-version. Add --undefined-version to LD_SONAME_FLAGS to
> > avoid breakage when building with lld.
> >
> > Fix: #512
> > Fix: #513
> > Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
> > Reported-by: Pepper Gray <hello@peppergray.xyz>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Personally I liked the fallback wrapper definition of
> matchpathcon_filespec_add64() more...

I don't strongly care either way. See
https://github.com/SELinuxProject/selinux/pull/513#issuecomment-4674610134
and https://github.com/SELinuxProject/selinux/pull/513#issuecomment-4674659=
036
for the argument made against
adding the wrapper definition.
