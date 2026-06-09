Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6728C3D34B3
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985006; cv=pass; b=rcXO/Newx9a2DUq926z+BG9WJg7H8e5a5355jycMxCjNOIVZX0KLcFQsAnNIChLBfuQSXiOWyxh4zQFXnfNVfacifE0h4JkJPa8PsRE7j4g0QEkJGtf2RXEZ0wBuNJXJB6pZqdFuGFTR22CV98Lg7EOObI5LU1cPs9lVwqbOn08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985006; c=relaxed/simple;
	bh=LrHwez1d9LLQRP4fFpttkO8kT0PzQSufcRkfhr3cGOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJWcnK8+PZ25KZtMdBc29SxCsQSJFNWlhgW+dscG3ms5n5P5IFA5vD7//xNib5HNytnQk2HHOxJH/Zh3m4l7qXPmabzq1MhjARahO8owsQ5CswcPmPiG9soqTeDRb1oNhggwgWvbVADWgMoVINOerawBCm3w1QoP4H0gTWw/z9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tK1arkM3; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tK1arkM3"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa69131836so4479939e87.3
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 23:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780985003; cv=none;
        d=google.com; s=arc-20240605;
        b=V7lC5ZR0WkITvbepRa+zy1kl3D9jw622ZwhBAtBBn6Ivm0z6psmXW66N8TaLqsFimY
         iTi3Nhha3za+F+Ij+UFeO/zjDStmjyDVLpGHPguEwrcaGKulAH6t9KOTAoSl+qWBZ3s+
         E3UlLakf7bUOde52+WhVuwO5F47byZyOOdTTOawO0sEZl0u6FYxNf4LFto+Q7BGUvGWy
         Yfevv1M2RGeG0QX8zH1qPUy4i98c8UuhNbIkglNQWwMj/DyPEykoGWrqjWuvI1d8krAO
         Tl5tMMd1LGZA2aXY2ASJKn8G4zFlO0zu6y9iHqggUDHGUvZS+f3q3W1Vnz2HMYLaw6OF
         bWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XZGD5AdwPvyN376ovEwRMZ7vNbqAKo+RXz4TdvkBZGc=;
        fh=PvVq3dmv8yvnCRJYSTWWanBfOaJzW2R+gufroGOSnBQ=;
        b=giDV7Xdpehc8qcuSXN4AJeJG5WGHD8MnblL2Fu97Wx+nBtZJYl/m1ja5U3Hg8VnMRe
         fsGnyRP0RpglHmaw5EZ9fz46BLPaCdYOeTlEOzIHGAhVHz/P2sUWS3/uLV8P7f/jJF0Y
         fP2CroHv9wcuEoA8GzFuX5BBlcLq1ZWpKsZY9HWUaCNeRyF0ELyheNARy7pWntE5oLVA
         bHeJTjXX1Udg7l0Hyu37SzpFQZ30HPkmkaSrggE7VvM9df5zptvJex0ezUcdJVDkc+y5
         +fqy45dbUvddJOcrQMGWDF+AnIOP1wGpID5VUCKBduEvbABHlqV1Nkam9zHk62rD6GJZ
         vtGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780985003; x=1781589803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZGD5AdwPvyN376ovEwRMZ7vNbqAKo+RXz4TdvkBZGc=;
        b=tK1arkM35G82qEG1tLVDHuLk7SSkFNNqNJ12ABuraForPnSPkWvWY/haNIBNiCEq9B
         jUObqv/es4Fqod+U9lEch9rCZr/T8VJ2huC++CeH7GlDVl375bE/N+Nbdj3Tsi3PnuCi
         3r1dWswygv3JrSkHoP20KhnFj7FVqNHkT/j/6htZn85K3ZApInsGeEqfOO+jSvZiWBhD
         1f8/LIwW6yyrdA+Nrhj5S5YpgNihUk+07YMuH9jHMjHP56YdgeRxrPg8bQwGL//E+8pa
         3T2rlmjc1k1nKilEe7Pr7lFNW2EiEqfzlot+Tdd9BNOmZOHkyZeB69NipW4IM4itPhck
         8cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780985003; x=1781589803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XZGD5AdwPvyN376ovEwRMZ7vNbqAKo+RXz4TdvkBZGc=;
        b=LGNBXhZwSJkpGtItSXqlfpoJxrt6OQEUbtIlhTvrhf5gDKfCpmrgF5aepzxkgZEH6K
         kTUWM2dtjgYKDcxHdtKVHZJWtfNf0vDW3460jqC6Ly7NA1DWnuVWmVX1WYcnUz0cP375
         m8FY30+UqFHcly4i4N9chR2ywDUjqmY3pDzX5W8k/eypAKYZAji1ehfEU90WIg8mjPej
         yk5oB1riX3TbI9BFImkIfTMINDhsGomQDLC3Ymii25XWEGNvjDHo10OA/F058Y7XST26
         aa+WHyhQdeMuTuXb/Zpul15k55aqExawztpqlLDWlTmfWoq4j7fruKa3N93JIR0pYNI+
         PD9g==
X-Gm-Message-State: AOJu0Yw3z595y1bZapGRMREE0Fyq4rfKFGirvuKnTPKG7l4i/Nu2SQ3m
	fQz7fUTd6jDqheOmN+my+jYGRgxfvb5chai9ljlYN5g0hKEuu3VsJCHdW0v58MdzmS51t1SwF5H
	r5FJmuLFILnRCdT9YQ58PVSLCUkSb4txcCY4l
X-Gm-Gg: Acq92OHVHEme8ifvJDIjQ1eDkf1GT3JcXFNpJdtDBIZw9HnOFKys/CBxNH8PZgPDiRX
	UBK1O+q7JqYyAI3y6ESOSQ3UwRdwtuEZnoPj7F6W/ATfRybkJgIWNtw2louDCkfSAj3ci2WcVSJ
	+zdHDb5FMs+wIUdcn6hPshUu5BQHyMSk5Qts+tBMepz8zMVvyZEfzeZ0ie0j/4jjKOQJc6GLGJK
	VvvwtL4jfnuiClUyf2fW0XemkuRN2Iigfo+r42jFJa0LUhwgNHg2GUuoVXHd5mktCvZr8k5805A
	t81GEV+T86JoKQWhQ/Fkp/u/6FVDWA==
X-Received: by 2002:a05:6512:3981:b0:5aa:6ec6:2593 with SMTP id
 2adb3069b0e04-5aa87beebf2mr5695372e87.39.1780985003079; Mon, 08 Jun 2026
 23:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
 <CAHC9VhSf-ph9D63=J-AemOZfvb9HXLFguCRFWkU4y1DvDsKr9w@mail.gmail.com>
In-Reply-To: <CAHC9VhSf-ph9D63=J-AemOZfvb9HXLFguCRFWkU4y1DvDsKr9w@mail.gmail.com>
From: muneendra kumar <muneendra737@gmail.com>
Date: Tue, 9 Jun 2026 11:31:55 +0530
X-Gm-Features: AVVi8CcJMVhmuPZ_NoSoe4Ktja01rh9rukAejpgLK8HHvLc6RckWeeBaxdniK28
Message-ID: <CAAhcyzmUS0QkOL9_HReHD76fNTknPpJUui67-mLW-Dx_BPFzZQ@mail.gmail.com>
Subject: Re: [REGRESSION] LSM/VFS: startup latency spike during rapid library
 lookups (ENOENT) on x86_64 between 6.6 and 6.18
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,
Apologize for the typo mistake.
>>Can you please confirm that you are using a "bpfaudit" LSM?  The
>>standard upstream BPF LSM is referenced by "bpf".  There is no
>>upstream LSM named "bpfaudit".
It is bpf . (not the bpf audit)

>>Are you running a distribution kernel or are you building your own?
>>If you are building your own, would it be possible for you to narrow
>>down the kernel release which first introduced the regression?

In our earlier release we used the Linux 6.6.78 version and then we
upgraded our kernel to Linux 6.18.33
We are using the kernel from the below distro.

https://github.com/intel/linux-intel-lts/tree/6.18/linux

And we are seeing the performance impact in Linux 6.18.33.

Regards,
Muneendra.

On Tue, Jun 9, 2026 at 1:08=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Jun 8, 2026 at 3:22=E2=80=AFPM muneendra kumar <muneendra737@gmai=
l.com> wrote:
> >
> > Hello,
> >
> > We are observing a reproducible 3x performance degradation during the
> > initial dynamic loading phase of a userspace background daemon when
> > transitioning from kernel 6.6 to 6.18.
> >
> > The degradation appears to scale linearly with the density of path
> > resolution failures (ENOENT) encountered by the dynamic linker (ld.so)
> > during its library search fallback loops.
> >
> > Isolation Diagnostics & Matrix
> >
> > To narrow down the root cause, we isolated several configurations:
> >
> > - Hardware Profile: The issue is highly reproducible on x86_64.
> > - Kernel Parameter Isolation: Passing the boot argument lsm=3Dnone via
> > GRUB restores performance to the 6.6 kernel baseline.
> > - Active Stack Configuration: The regression occurs when all four
> > modules are active and enforcing:
> > lsm=3Dcapability,lockdown,selinux,bpfaudit. Removing modules reduces th=
e
> > overhead linearly.
>
> Can you please confirm that you are using a "bpfaudit" LSM?  The
> standard upstream BPF LSM is referenced by "bpf".  There is no
> upstream LSM named "bpfaudit".
>
> Are you running a distribution kernel or are you building your own?
> If you are building your own, would it be possible for you to narrow
> down the kernel release which first introduced the regression?
>
> --
> paul-moore.com
