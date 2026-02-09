Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA152E62AC
	for <selinux@vger.kernel.org>; Mon,  9 Feb 2026 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669835; cv=pass; b=GCio4jApQz22h7zU+MoT14d4x/rYYICID1bQR6qvvWGmzvu5BcB7fgFhrNywth4WfKRgH2u24G/kNjKp2mkFEK5GK0hpLHBmmI4TSh/uGqSoVEbhzq3S4s8HdUmAyGXG5fcPp4r0hwS7rZKD8rrnlpeTSmzzsRoEQNt4kuHMT+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669835; c=relaxed/simple;
	bh=zBWymQge1fQxYJcnCxFkQierPCv5dEnApOFbm/WTewA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn9soBaUqdMHWufgI6gIuN8RAbD3pTNF3BDPCMHUDtwkfNLN4/HgJJYynMjCXCobm0mdDXxjCWaHdrvZZqPQwZFp3wQZqh49lyFcBOC8Zd4rDg+wW98wo11DrvC2r36LNw1G5b8jK46CWGmgdlcZL8tqjdgD19GU9uClZaPvaoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSdGxlvo; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSdGxlvo"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c635559e1c3so2071276a12.0
        for <selinux@vger.kernel.org>; Mon, 09 Feb 2026 12:43:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770669834; cv=none;
        d=google.com; s=arc-20240605;
        b=IzorrDJ23jwydyfIEijgIdz6SnCFO081eRIZVt5TAwWDbE8MdqaXwxixpobMHz1wwc
         iQZ/zfMDEYzUS/I7PXb1TukFK0HenCUfW3p4xVGDmvbTuAcI16kMkUGaZAmNg/EN47Kk
         cBmvAWIScZIDrVsO6Ul++Ol2niizpEBScEWXDG6lK9JSvLsD4EjRxoI4UX56O7TcZqYz
         ue4tNJ9fS/fh/+hKp2YUe7bTu1PspBAKgUTLBtBYZ1bAA4PZtkNvhs8SdixRh4HGV2ko
         McuxsjL27YxKX+SV1y3mNHaw4UIQL8VQapk1QzqgzK2bviQ4aC8uaGquaye2d1DwVziC
         9lBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0iHipXETJ1/tuGkUMxcmwYWNO8PoUXFI8tb/aIckHmQ=;
        fh=ktubYgjNWbPqM9V6z9O49ooa4xNe85vTz7yCZ+isk1c=;
        b=SwzWZcpv1/3eIAIAEt/P7/77UtaXlNnuO2c3QdC5IGJ2yYhZ8Fnb1Yu1rJfDZ16wn3
         3q9/CLD0SBetls+UuEdsyt+E+X4KrSzEjoJI2g/X49WLZMpi49UdReGrv/TdWnxHtLgb
         rm629b6s5RCY8mJCvcqLZ1JaXDrNVDSV1k2ot+8ETQ+lppgzWS41I79Pv4D+5nxkpx0E
         7Lviz/WAtqB1yt9soQSJPnLpeZea75KwP790Y5olUs2KCR0r1W7AkfmFQdEB02Jft/WQ
         OjCgTkGEyesuv84v5T1BCoOTzCTaRlMrKilhCi1nvSz8jHKTnZ5QP1ssuyRNIO/SzAYq
         32wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770669834; x=1771274634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iHipXETJ1/tuGkUMxcmwYWNO8PoUXFI8tb/aIckHmQ=;
        b=iSdGxlvohTpVaxUD+Gx927K88mSYBI03SPcF7PtrcfT6CypiL8vFkHWEfcGKimIGSn
         znwDs2x2nHzZ5FnIPANEDRQ8D8MBM+2VVaQmjW/i4DWyZHWFWRx2iOSAXzUIbcxU3jOT
         m/oK3+D4c8QBwmgP37GOz2VoGx0W35Ece+VowXL9bcgQ05Cag9/UaN6SWL3tSR9vfgIk
         y38Fm6BFa6vYTIBgABeq2MoptZWK+MV2erxSY2attDnBCEmH39RpngFyL1yJ6UCXyGot
         2uC+IBz3BtxWSSy1+zB+j1DExQw+huaY9yT9zupIs01gDz9+AVDlYF5qvM3HQV7reqh8
         m2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770669834; x=1771274634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0iHipXETJ1/tuGkUMxcmwYWNO8PoUXFI8tb/aIckHmQ=;
        b=JgQbGKdHYzgNiSDrl5Lm6P6KZOseG3Y2ih7xUgWOLhYRjzx9vVXi69i7P/wvTD+Rmt
         7hf3VqV9kLCXyJ58kauEyNR77zKsPf6THeTlBtkcswCv672M2wcFZMS7X2trrDwNcA2A
         vQYjHTiIPMqZfIjEI+oEI7w0v3hNSdxcpm3ts4k2yCULOQBhUvOmwdyNaERE76XcU9br
         C4m8+4JkTFYW+fvTCq49Y8GtTHUD3YpDvHWVaIHq4CSBsEEMwaYTIJkcaX5CDM7NZK4T
         baJF3Hvzh7B0xWYhqdtLpdTCMJxFlFtyoMc/RxDDMtYZyX+FaYauB16Gklj9gDqY1Uyn
         HTng==
X-Forwarded-Encrypted: i=1; AJvYcCVkZcCDvu0yk+k6VSugwDRIi1W/crWcOt2B3icrd+X6Bmvh31bfECWrskxu/eb7bMgdYu/dYPkV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgi1Z79t3vMRww2zBIwsDJpE4+S1ZmPEM16mGN9PFk7qD7t34w
	QRVmBI1Fk3Ha3XYdiumJIRmRohH5uoa5h6wc9dEIMCgbrJ4ZFwmGEFgD2py1ig4zXyxWYV1Buhs
	Y6/H0AyHHH5g5uFpohnSVYMmZHAP9xUI=
X-Gm-Gg: AZuq6aIKhpoxDNp4RSke1XDZ5XzN6wFRxKHHlTa/53mpVx/gzDRF8CnIB+Td+olo46+
	zCbMt8t6lkjDVC4FBAa1wcTVevI7KDnAI91DzmcNTArdIC9Sdi/gS2VM26vgwfEGx0Q3PdT2DHc
	lgssQDP9DMmbaHkgUn06CUOQ6OX3jFrWmuineOmF+5x7OUUpshDN4tJK0uSCgAJWfsKM3IdUA2n
	VzOY1V17yoNUlub6Rq65TP0JOBGCjT+s2ezrbdjtbVXFKpSl8utGv9y4VlMQSmFb3Dko/6i8Ne4
	go/Lkw==
X-Received: by 2002:a17:90b:224d:b0:356:24c8:2291 with SMTP id
 98e67ed59e1d1-356662a8428mr66097a91.0.1770669833817; Mon, 09 Feb 2026
 12:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205033328.1644-1-ericsu@linux.microsoft.com> <CAKrb_fEFhHRuSW7M2W+CF_B0ocSg4=3+PiG8iqb3HYbZAZ9a-Q@mail.gmail.com>
In-Reply-To: <CAKrb_fEFhHRuSW7M2W+CF_B0ocSg4=3+PiG8iqb3HYbZAZ9a-Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Feb 2026 15:43:42 -0500
X-Gm-Features: AZwV_QjhPcM6pj364G93n1xI-Andp_qOUdf3IDuj1-pwfnRD8KbtkXgCE9-UWVE
Message-ID: <CAEjxPJ5DRgdLriX2A7CZAD7cHkmmf9PtvgkWbF2yoScpOZG1BA@mail.gmail.com>
Subject: Re: [PATCH testsuite v7] tests/bpf: Add tests for SELinux BPF token
 access control
To: Daniel Durning <danieldurning.work@gmail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 1:02=E2=80=AFPM Daniel Durning
<danieldurning.work@gmail.com> wrote:
>
> On Thu, Dec 4, 2025 at 10:33=E2=80=AFPM Eric Suen <ericsu@linux.microsoft=
.com> wrote:
> >
> > This patch adds new tests to verify the SELinux support for BPF token
> > access control, as introduced in the corresponding kernel patch:
> >   https://lore.kernel.org/selinux/20250816201420.197-1-ericsu@linux.mic=
rosoft.com/
> >
> > Note that new tests require changes in libsepol which is covered in
> >   https://lore.kernel.org/selinux/20250808183506.665-1-ericsu@linux.mic=
rosoft.com/
> >
> > Four new tests are added to cover both positive and negative scenarios,
> > ensuring that the SELinux policy enforcement on BPF token usage behaves
> > as expected.
> >   - Successful map_create and prog_load when SELinux permissions are
> >     granted.
> >   - Enforcement of SELinux policy restrictions when access is denied.
> >
> > For testing purposes, you can update the base policy by manually
> > modifying your base module and tweaking /usr/share/selinux/devel as
> > follows:
> >   sudo semodule -c -E base
> >   sudo sed -i.orig "s/map_create/map_create map_create_as/" base.cil
> >   sudo sed -i "s/prog_load/prog_load prog_load_as/" base.cil
> >   sudo semodule -i base.cil
> >   echo "(policycap bpf_token_perms)" > bpf_token_perms.cil
> >   sudo semodule -i bpf_token_perms.cil
> >   sudo cp /usr/share/selinux/devel/include/support/all_perms.spt \
> >       /usr/share/selinux/devel/include/support/all_perms.spt.orig
> >   sudo sed -i "s/map_create/map_create map_create_as/" \
> >       /usr/share/selinux/devel/include/support/all_perms.spt
> >   sudo sed -i "s/prog_load/prog_load prog_load_as/" \
> >       /usr/share/selinux/devel/include/support/all_perms.spt
> >
> > When finished testing, you can semodule -r base bpf_token_perms to
> > undo the two module changes and restore your all_perms.spt file from
> > the saved .orig file.
> >
> > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com
>
> I tested this while on the latest dev branch of SELinux and using the pat=
ched
> userspace. Everything ran correctly but I noticed that token_child_helper=
 was
> seemingly missing from the .gitignore.
>
> Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
> Tested-by: Daniel Durning <danieldurning.work@gmail.com>

Thanks, applied. NB This won't get exercised by the automated testing
until/unless someone updates the tmt configuration to apply the
necessary policy changes above or until these get defined in Fedora
policy.
