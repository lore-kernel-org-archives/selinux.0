Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FCE306756
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592726; cv=pass; b=ajulJFkoY5e+FPZ56BVdEyc2Kb51bg/gK6GZg1uuF5JJsOVbnqINLBg446tp6T47MgB3Iwv5oKC2J4Erbty9PyToEaelEaK0/llH2QIAe9LmdXT7iFXABvJwdBas3gGuF4K+1vDuyrkifOUF652y+OAxS/rnT3RFMWxfNvpMul8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592726; c=relaxed/simple;
	bh=49jW8ZapXANMFie0lrwx7RkYd4uYDwwdGjS4FnYv9zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3GZwNQHHJh+Vse8g+XvNlSTMoBBjGR3D36GejnOeqJ4pYDuG/LxN+N8wCHPqBRNbtIJiXJbI4PVN4OBMTC8rWjVzoB4mN9hon0tXg5sUbqDDLWqDYQJws4O92UXxUmV/x4IinFeJm82w8k0bS5DHH3wrIPLsB4deglHGcrY8is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q6nbj3ar; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q6nbj3ar"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so35118985ad.3
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 06:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592724; cv=none;
        d=google.com; s=arc-20240605;
        b=igX8ahKlw3xzNFpzUwLfr4HQms51qXUDd8UZmYnLPk41sBqy8BZB17ATZ5QCRuDaqa
         lzf70XJ5qTV2US3e43L6QaLbrKOc1HgBM0BDzbnFHPpw3W5hYK4XRsV4q9txK3tvFuEd
         CZZ1JV7KZm5pQhb1beUJqgrdOjlZAO7ob/Xxfq8v/UF09ILwyqcd/GZ1Jd54pWjHvzW7
         zMOPzIKdI73KkF7JtMijA92+qcHb/mtluhvH4b1pgIdqzzqMC69OA0zv2G3IKKBKMJAE
         D07S5OtR0/kvV5boT1k+VT53hY4eJjhFLEzcSxxRqf8r2H1fU7OrlaL7zTZUKPP52PNA
         /1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        fh=tnxKZ1Vaxu9UHriigYcE15id1C6K1oopZeYy/7uLDHo=;
        b=KTdrCMCBj5LXphGfZTQZdkDjAd4qLShJIWUthkXmVabZot75Cv+UT+XjYN/Tv0N/yj
         dK0hLoZ2hoqHBIwHyE1+mrFDTpYQEKNpOr8FpftEvstqTBnk7GyjcPRqMAqoTIgG8ILF
         t8sFkyciEnbxWOCdE18J/RBwjKt86n4wPZVvjM1nv0DfDlZG7FPITQT4Yn1XgvK8lf+6
         yP4YI2DR9QXKrtNl9Vwh90rY/kG4f56XaZl1rNS+Thv+HdttKsGsGh4anyLJ0kZNXQ03
         ckBUFltL7B9YhiHnEOOu632KvaFbCUa3HEagsJgNuxmSiZmQ2iD6yPlfB3dKq/A2gF7h
         kE1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778592724; x=1779197524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        b=Q6nbj3arsrs1ZogqprDPGpNBOPMkhELFsB3N5YCHDF263py0coD/cKJ4XAI81ReJlX
         hytSGWtxCzD5JSBLPFhUzBDXKv8AJYSj2XG64j5syFspKgTb1Ycoqvvv9Ihd/X6Ie959
         GYGKadZ7tViP+6Zl3jwlzsw5bxSvkyAqwyAbbUD7iy2EpowVW81E0hkB/d/0K0FlW415
         7ssdDaVxrIlhxx7qoQ4FCVI/ApRussIxmNJDYg1wIK2vNm33UxbmZh0DK/sd93Dk/Sot
         7vmX+VbX0aCoznwEVklpf0uVXJZylcZ7k23sysAzIBdDS4Nx0Xl2/JYNQmpVxXVnxoRD
         a3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592724; x=1779197524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/aQ9mwTMsHh/sgB4/Y2KBsn0VNAa/XO6yw99kEeKn0=;
        b=cOacwu6FvgN0hhiTHzBXl09JStllsAMT29MECqT7rVPbHQrSIvc3KlLPmCWdHvdeuk
         SKiE1YcnlURaPi+iWkivFTQrUfUtFFMGtcEqNx+RwrGExq5L9YFoe7qVITo8/xcZlCBD
         jIUVEeR5Pf1LQgvXMMvKRKvCxFvjRuuejUCE1/6vsY7Q91LJtQ1I2bjHKppqaGDGnr90
         m/wFZSWH6ytRhfg5o4FS8cXDlnYc99VTlukeg96r4xfmLph6lQwrdjucbB/Z9EZq3/it
         0QC87IbeRSXIF4eeU0JykhonqU5FtGWbgkoIuv27KQ8L/apeJwulqFcVKt3i695jr8G8
         lhSg==
X-Forwarded-Encrypted: i=1; AFNElJ+NmGzuo9dio47nCbB9M8JA3dKabcpGUv9CuQmXCpWYW4GqxikWjYUSZ0MTyv7Nk6Sggd6zxCsB@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfMiYdRbLREhdiVQB8t2CI0nJ9wfihZr8p2cAOp5XNdF34KfJ
	vet8U6bit3DD8OFjKIzsVxME9jkFPGq9Npl/Niq6oQkVuz2LqpyZ57zXtrSDaezxDytCYEoPhKD
	f+290EMcMj7aVWcnuy2uxAylT4vml5kk4YVrhu9qy
X-Gm-Gg: Acq92OFkSdBNm5AnkWhfZ5GKaCPrcdxvqZVWdFAC+y48tfwfu9yrUmWm1/w+nEdd+hI
	SkhkdSsOOdz1EtbS/l2//4wxgPw8onGPNQLjgTpirRnDCivsj6gUOCkKAg0nbWpnjcLxvcEFRx0
	632Wy6VEe3j8HQrA9dNmLttsOlUhd6BHhqTP6v6ioZsApb+amqe91J4PGcMb5LZIhS6lHbig61e
	x+4dEKwlIIeqnA1djkCvvp8HrVtU1Te+31L/cbP6MjUlRnWJdz4fbHaKd7S+VL/qy9veXIaT7wO
	7fwEsP8DzPsQuo7wQg==
X-Received: by 2002:a17:902:f805:b0:2bc:dc0b:ab1a with SMTP id
 d9443c01a7336-2bcdc0bad76mr55621515ad.35.1778592724418; Tue, 12 May 2026
 06:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509015208.3853132-1-song@kernel.org> <20260509015208.3853132-7-song@kernel.org>
 <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp>
In-Reply-To: <42a9075e-a4b4-4eb7-b96e-48e5c0cd2f3a@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 May 2026 09:31:52 -0400
X-Gm-Features: AVHnY4IPU0C4Y8X9_dcIUSlLPhJJAw5e4I09h5zch8q_eb3KJ5_1mBDuZ4l2gH4
Message-ID: <CAHC9VhT9vvaoYpRX4fPZ_H13+PaqG72CpRbS+d=9xgMBaKHo8w@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, herton@canonical.com, kernel-team@meta.com, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 7:03=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/05/09 10:52, Song Liu wrote:
> > Replace tomoyo_sb_mount() with granular mount hooks. Each hook
> > reconstructs the MS_* flags expected by tomoyo_mount_permission()
> > using the original flags parameter where available.
>
> Please fold below diff into this patch. Then,
>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/tomoyo.c | 60 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)

Thanks Tetsuo.

Song, assuming you have no objections to the comment blocks, please
fold in Tetsuo's additions in your next version and add his ACK to
this patch.

--=20
paul-moore.com
