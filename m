Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7D2857CD
	for <selinux@vger.kernel.org>; Tue, 22 Apr 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745348253; cv=none; b=qkaDgehxsvT6LK3ekVu8Y/i5PlOi8axh9Rqjg1onXpY//2NV3ARd9f8aAetoOO/StKPtAUMm+hDEWXZdMb3IiGjFOU1dzOLyitlWLrgALgGIe874oMjMxrVuomrbg/N3+sYDK2uhKx2x65ZNd2oYje422n2C5AKSqydjCjlUdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745348253; c=relaxed/simple;
	bh=oLJT7aMOQgfco1ehaRy+87jUpJRR8DZ2HU/Bk0oinbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aorn0F809Uzi2ymGKneS9olWCnWxJ14lKnOwVJRYhg9L3HgFt/bTFjv6X4BdNsCifRho0LPoBtnrlxeLdSx9wKe3Y+3FqTEpYvVhdNlsw/c5sZlQIdfOFkPVE/7m/1taiMMnWlNem45p0bFXCKV9HIIzxSqz/XmYAfM/F3jzCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsczIziZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsczIziZ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30572effb26so5046452a91.0
        for <selinux@vger.kernel.org>; Tue, 22 Apr 2025 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745348251; x=1745953051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn7Xg7Wz8cj1wU7UcixHtfqd7pSyuBsX6mQriBiZIFU=;
        b=lsczIziZBIUrnar46YVl/aDvDx21Z0KGh1bI64lle1lXmki8ikBtPcViOHRfDkiUj6
         A9K0YSFuybMQ2GU8W/EgDZ4p04bF3ezPxD1OnJ9hce0Wi20cfR9kC90Wr74rozdZIYlP
         N+3ItQ25FS0Y11SDD9H7F7WIZowwAzg0TdTQ8jJPpF3b0O/VIFptAzruPGIKOK9EcAos
         dEopozygOsWBVM0xE5CEbHww4V9K4lig5baICvPJADuUCbTEGwFBauMvpea2UYxkB81D
         SZWCx9WYT9idIAjR/hWx5hlELszyOEPaxBkrLlc4LqalSQfRUCjUhjCkeyh/1FPK3M5Y
         JEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745348251; x=1745953051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cn7Xg7Wz8cj1wU7UcixHtfqd7pSyuBsX6mQriBiZIFU=;
        b=haH6c27pByjkO5G9dYCqsOtT3tzOlZLG6/1e/qMxPe1+TUi0lgrEOtPZRKziSVpnS1
         +2LO82VjACd+EbsLM43xvjnKrwBDP0ePaoqMuV4FSwENNjUS+98vdzhLoYz7kebWRRcP
         nMB0TZcaZ/fGCTzSTMRwdaNwFN6YGkITXgrKdPLUGFPjRBSW615zOUjBTEpZOvYY6+Tv
         wkg53Kf+a4XvjnGf9NbYwr3G6nqmEQylHx3ATpnVEMqLXbU/21Bm4uvQ8u+WmISlHg27
         3iqKDkIHzHsAaEZqavh+e7UEhNsxd6+RpEsUYYbISPMA8YTP3NyBusNI/YHaNNatUVqi
         waRg==
X-Forwarded-Encrypted: i=1; AJvYcCVkt5D2HdcdZ5VlZI0H11kK1FAAPkfAF8JVs5JuusEybfYdgZ+WsBupCY8mlFe40VFbjv+HR6uJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9wGbm57Jv0GKWSdNRr5SF0nXndwlvjxTRkeD9Xl0iuf4Pffz
	/ErbiqoAg4gJ1wu/q/dpddDXieihazWg8qnfnMp/ae3h8O21c9/QnJQavD9pXKJSvo3oves1/mn
	TbgAwSK6FXpvIdQvP2z7Zbk2kWk8=
X-Gm-Gg: ASbGncueTqP557bedNhfrGLBbV4kBbQChSx5Z7w92M5T0kL5+MNZ6rujMgV+FR53teD
	p4SuvyWg8RQW9zClHa9JhDalwqV7u9UBnGLoy+YH/S14ZlbdihVErVbdCMOzOGuN5aoMgx/Y6Oz
	z3G6rSdMoEsRTS8uelMUp18w==
X-Google-Smtp-Source: AGHT+IEAmo/7hdeh+5Hw+WBYlM26V/wp2FTVcHBuccLMM0AicV8C9xH2Q7SVY63ABxUic/IeKt1Q+DmWTaIzBQ6Tu0I=
X-Received: by 2002:a17:90b:1cc5:b0:2fe:85f0:e115 with SMTP id
 98e67ed59e1d1-3087bb9f463mr18691279a91.26.1745348250689; Tue, 22 Apr 2025
 11:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D9DB7KSD01JE.1LSPBCYV65C6Y@gmail.com> <2afda875-867a-42f0-a454-00d42b62254c@schaufler-ca.com>
In-Reply-To: <2afda875-867a-42f0-a454-00d42b62254c@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Apr 2025 14:57:18 -0400
X-Gm-Features: ATxdqUE_pluFKiAoKtfs62bzRK7gYALqCpMCC3AM1j4D2l5MKgry3m3r5y1Ok6E
Message-ID: <CAEjxPJ6ocwsAAdT8cHGLQ77Z=+HOXg2KkaKNP8w9CruFj2ChoA@mail.gmail.com>
Subject: Re: ls from coreutils 9.6 doesn't show labels of some files
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Rahul Sandhu <nvraxn@gmail.com>, paul@paul-moore.com, omosnace@redhat.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 2:07=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 4/22/2025 9:31 AM, Rahul Sandhu wrote:
> > Hey,
> >
> >> I can't think of a good reason why we would ever want the *listxattr()
> >> syscalls to not provide security.selinux,
>
> If you're using Smack instead of SELinux as an LSM you want to see
> security.SMACK64, not security.selinux. Returning a value for security.se=
linux
> makes no sense in this case.

As long as they use the security_inode_listsecurity() hook or similar
to fetch the xattr name, it should handle Smack correctly.

>
> >>  if there is an individual
> >> filesystem that is different/broken in this regard it should be
> >> treated as a BUG and fixed.
> > I've spoken to coreutils upstream[1], and they also seem to see this as
> > something which should be fixed in the kernel too[2][3], and appear to
> > want a soloution in the kernel rather than working around it in ls(1).
> >
> > Thanks,
> > Rahul
> >
> > [1] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00011.h=
tml
> > [2] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00025.h=
tml
> > [3] https://lists.gnu.org/archive/html/bug-coreutils/2025-04/msg00031.h=
tml
> >
