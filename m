Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91523238D52
	for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689543; cv=none; b=XuQMdur60leIP3Ngc1mOAMwu/epM+xdGudldEZgnQ6xJ1p1NSD6CF8u8e5Yj+2sA2dpIk54SiozLDwYj6x8mlsME/vdmTo2pizuavmvIXX9I8njHmTFzMeO3CccaAGy7zSitxk6MkV0jggjiKyjAZoup7DD+haCu3Z3FFt2b+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689543; c=relaxed/simple;
	bh=RPWvmQiID9C2DQzkovJppjpP9zwEI/6FwtYvyFUuGe0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LnUueV0p7/Hz4JxN0ObElgqsm6YQbda4ebk5r1k4jO2+k1i9is8UAFNgaEZgL5ncb0Sn8SBHOkoz9848PuyZxWo+0QOZmXOqhujgw0izkuCXR8LtVhV+NZX25g9XgHxk0MUj6qWZYHN1/QyUIU+pAbsjalvssmEDjZ8tZzHepkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LwJ063KB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LwJ063KB"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so8038346a12.3
        for <selinux@vger.kernel.org>; Tue, 11 Mar 2025 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741689540; x=1742294340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPWvmQiID9C2DQzkovJppjpP9zwEI/6FwtYvyFUuGe0=;
        b=LwJ063KB6g5LaWCqi9v/rW+Elp1iphgnqj0j2/F/QfRT4GEB7haDlxe8NpzkAZ/jD7
         enCed/4lK3G+yd5xvrh+0ocgy+p3x4ZGv4+CMoPNTSoqdVpYnSuqur4b7lJcc/a683jc
         Wk3HKyeRAV3zRsFNqqAFyuNbBZU2ZzxRZ0GhUAWrJIItBnrESnbTJqlOf7cS8mvqAzjT
         kXdze3hZjHR+sK5pfDZJIxkT+vSBm20kyOcERIIn3gojDxpEssBZc8JQT5RqOOR++a5e
         kUkYQSNAxLGCLScmCHhWQEIhP8EGXvGRIZbwU5JB1n381PlXmYoyNpM7DELFNr7BO5P0
         yDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741689540; x=1742294340;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RPWvmQiID9C2DQzkovJppjpP9zwEI/6FwtYvyFUuGe0=;
        b=Ka7ocav8irv2w0PVBnK9X+rmUEwnEZTNW7kC85L3/ZrdKK1UVeAEiXH7+Ren+Qbvvo
         M3V11Iqafm2VYrYmYLXAkHbfWkPDfssCDDUO1aiin6fYZ1L2I6+GO638hTtUg1oeFBgb
         gz4djFhqkj1S+XVwAf5gqnDwFmNFe9fqaUUdH/KNMKXtv8bPDXepNyS3f39eY1YNXR91
         GELduaXlzCV86EiEMIFdRNOnP54pvNO+R/6Ewh7+eo2sK3y2oQj7fJz3NyDh0t+uRpWP
         l++SO7/Z7VD88v2POoX0sDZkqfNiuavhim/lfBCV17N+VfwfOd/WrSzcdXFijGr3AOog
         Rr8A==
X-Forwarded-Encrypted: i=1; AJvYcCWAnkFxl1asmLFPqIT1ieRDYyzgSLHueP0rdAVc/rA37OJeZwei96lOYWjdowQYkH0DFHbJ22Rz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxek+vhDFW6Y6jLbI5CRi5hxIT4ZSbEKI5CGInKVXY042pTUZW2
	hL4LO8UIAdGJvp4KFUpYSGCzE6zAvl+fMAX2Ui20/niQ9EiOtwtS
X-Gm-Gg: ASbGncuA4PAK0vy3r0ODwwV/KcOrcaMV3M4xEsRx6LqGXUGeN2hPoYIolKoeaD9WMbZ
	VSwCGI/kYqk56bKNW+js8+jvpSVp5w8HKpVMNysfuKHcwzwRFVG/PtN8KlPJF8ajpkY44OLsxRE
	tYGWt2wRSNov1XTBm4FCAGHIs4HCgtN/lST/C98fN3oXgsjkpnJF993NTniTK4glZsSmSWKmx5B
	q53z+KIo3ofGNIRO4vM5XStt2B8lnsJdrVO4UIhDRp1cjK0sGBIkyvKeq1KlvfpRPWRSmGquwAa
	r7Xml61tpCjuwesYdAc3JcBJpD8JWSBsuk9vFt6T2viJlI4=
X-Google-Smtp-Source: AGHT+IGj0Cbo8rzxoqBZ3h9Qco3DPRdDmN2f6VYm8hbAYH5QPKO8ZsJnKQPVStAKk1Aq7kaEY+nN6Q==
X-Received: by 2002:a05:6402:35c5:b0:5e6:466e:5866 with SMTP id 4fb4d7f45d1cf-5e6466e62demr10242196a12.25.1741689539499;
        Tue, 11 Mar 2025 03:38:59 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.240.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669eecsm8140637a12.63.2025.03.11.03.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 03:38:59 -0700 (PDT)
Date: Tue, 11 Mar 2025 11:38:56 +0100 (GMT+01:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: Takaya Saeki <takayas@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
	Nick Kralevich <nnk@google.com>,
	Jeffrey Vander Stoep <jeffv@google.com>,
	Junichi <uekawa@chromium.org>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	selinux@vger.kernel.org
Message-ID: <510029be-c806-48b6-8d8c-f2ee47ce15b4@googlemail.com>
In-Reply-To: <CAH9xa6dtem=xKPZhF6s+ttiOsQRyz63Je=Qv1m8edxCV1hE7Lg@mail.gmail.com>
References: <20250311092920.1114210-1-takayas@chromium.org> <CAH9xa6dtem=xKPZhF6s+ttiOsQRyz63Je=Qv1m8edxCV1hE7Lg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: support wildcard match in genfscon
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <510029be-c806-48b6-8d8c-f2ee47ce15b4@googlemail.com>

Mar 11, 2025 10:42:22 Takaya Saeki <takayas@chromium.org>:

> Hello, now this patch no longer appends "*" in the kernel space.
> I tested this patch on Debian by creating a modified SELinux policy
> where all genfs rules were followed by a trailing '*" and the new
> genfs_seclabel_wildcard cap were enabled. Both the new policy with the
> capability enabled and Debian's default policy without that policy
> capability made correct labels.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool wildcard =3D 0;
> I overlooked that this should be `=3D true`. I can fix it.

Or maybe drop this assignment, since tge variable is always assigned later =
on (and modern compilers are good at warning about uninitialized local vari=
ables).

On another point maybe this feature can be combined under the new policy ca=
pability netif_wildcard, to avoid adding two?

