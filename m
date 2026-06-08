Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356738A701
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947507; cv=pass; b=XX2fo0uFyBxsXDJ6ebVuXNLZVid4t+b/vP8F7nIfsr3F+HLyye51BEVmIGZ1svf3ssOFKHJ3gZHEhYRPNanQcXK8p03p/N3D1epzMaJ9c1O9KmzfBaCBMVH4pOxeaF0eYVNj9plhxKDXm3q2X1L4jjtzjuW1zK2wvz0pz7anZRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947507; c=relaxed/simple;
	bh=xviQiji1fAKn3kX5uQJRamGOo/5d+WIUj5cuhQ1egXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fw+HtW4ZZoAJztruqF07+VZ1HEC1s+WRPwCG1GJUCC1q37vIipgPjTBPpOlCSEtSj4glpAhdqGJj41NvXYO0QT/8GLxOKen3WIBrTfR2fFznCq7R72qZcsztl9J69F3QGYNe2EXR0yx8z0cqBDQe50XDo2PaZmQ11Q9QlftdkSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aNUausuN; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aNUausuN"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so1630159a12.1
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 12:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780947506; cv=none;
        d=google.com; s=arc-20240605;
        b=QHK1Azu8/ii6i5Uv3KLABL7iycWxxD2Jxw/radh4K7IQIqSuIUrHyKKWkIXlyw+E/D
         iHGD6dKMDmVy96ZuBlRf042u7E3yusyCVodQc776FDSLcRum+KUY3udjCOfc5xgY4Ai4
         ao/TcZ1FsUkv8diVppYGK/hxi9VJBwdVMWWexW4QuMoOflUEAIFI2W+XsH8HHDDPwDz2
         Ev3V+umrXmonmn3rewKk3tU2eTMFOMkKkYBEhnRtjp4TdRoZk0hLyXGQDsIRspUVH9/8
         3et9rSK934H7AOqqisvBo8VTAhMOXWChNB0s3o4WwyUtVjgKzYoyE0PExLRtN63J21/2
         2woQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+PwZ0JnnT/urycfNFDbYObcGPFt+DtOSrofkL6ymq/M=;
        fh=szNbHvrZ9tgD7IbBK4eiQiwR6NVxN0is2sKK6qohdqk=;
        b=U7CufUpD51UjDCi4Vz2Mm9tSV46stiTzCbg34SXxEUqkgoaQPl5Umm9IlIT+XQW1RN
         K5IjW72XfkkvvvdsdrQuaJTvmZ4QsnU1zjKjlzl+sgMkpcm7dAhQIWRxlJHL7Ok9j/mT
         ITcdiWeBYrPfSW9q/1hvWdTSKsO+joK1gS383e65G77P3ynceEPwcABs1Qy002yBCZZM
         Bev2Iy8GAaBfixowl5zC9byTXNEP21vW22ya7WGR0s3GbaWi4RW3VHsprEXM8HNDNJxg
         NZSI1G79GSt3zALDhqbrx0Tc2Oopvk2ijFdEBnybWRl3gUg8TWNxf/MpBUwqNCS2N7Vu
         WKuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780947506; x=1781552306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PwZ0JnnT/urycfNFDbYObcGPFt+DtOSrofkL6ymq/M=;
        b=aNUausuNhxXaXdsAs0x42lj0YVsCYWUF+FGhbV557g/gqluZY2BJTV8F0MciNFs+mC
         PZSl7a+PcHXohhXsFb/IKMdNvTW/mnJO9iwcNu4KuNc7TmgDyrc+YITQ9hPAnO3xm4yC
         7gLtFd5lVfIx6op+b5MrsX/LUG/Zxl/2+OEO9RhpYBWERikpX34b4eQus7c7nOCpjb0q
         guJqh0lw5f/cqcxNufn4XzexQbFH8SccPjjFwZK8XsvxHp7Wh1pD8nIibWUCRrjv0NTP
         dyjQNqGkBIXWY0xSptXmo4z+0kRnJXD9K5M1QEPCV6LYbBMaOomk3Vj00M98Tykgs2hR
         jlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947506; x=1781552306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PwZ0JnnT/urycfNFDbYObcGPFt+DtOSrofkL6ymq/M=;
        b=OA2L306tqF/ww0Wbz1m7KwydLvAWmrq5Ud8iRrsHgxTtwRWZlGpYKu3sMP3A6bldSR
         BvFaYGWw18m5T7ih1Rqz7OJhpWDZrwvU69pKHgJxb0OsU5G98t1y/zrrqh0vocj8TAs8
         GYqNq3KEMWzXb4145DUQ98B10YLyqnROnEYmKCFK03R6pcTqajxxniUZMaCtJeq6uhyY
         hOd7ufCG0gJNVHPoHCDPfWZQzCts/ZdDhSkVjur1+GQHv96zu4aXy0NyMNexLX9gzgYv
         CgPkB99InP3TU+zNYrPDVO7FLU5RWFZtwjIEeB4ngYz/KM3TKUs0fqRf00ZdzNNV5yfu
         qU2g==
X-Gm-Message-State: AOJu0YxDmYNlRnDbQCXg5S8lp43zFKZfKcw1oxYC46Voa0/3FpRVfzWK
	sG043coZlvbYb21dP8MGhr3B75sm5a44KVSDK4qL5vcWJYfdCnuPShKRjxdOPTypNrqpIJEXfUe
	ouTVRf53M8BQbPTVjAyjUHTVQHNiF05mOPVkcx0oWq96T9LdPQTem2g==
X-Gm-Gg: Acq92OG/du0WTeONXhv+U1MXMe+wOIVu2VXnxm3AZstmRTex0yKdb9X1zKso9vg3FA2
	+sremLI9nndgpv4q+Lilrc8eEFDjShgysQYs4mIX/65en3fug4rNlrmvXm4EpThlrLfBZCOX9mQ
	/iaPDZ7Jurk/PnAboayhbYtG84Il78dSmNtBHXnZ0s77GPbP7wBIQ04X+nCjlbCPZAy0mZuFuEf
	bkRJxYjxteXG8QklrfpyBNud0QEoyTqUT3Z2JJwGqSKXloY6mg53gupJkxHRkFXLNRiOu0b7J22
	7kn0+TpAkCEWM+buOg==
X-Received: by 2002:a05:6a21:6e04:b0:3b4:88e7:87c7 with SMTP id
 adf61e73a8af0-3b4ccd7509amr19707211637.17.1780947505781; Mon, 08 Jun 2026
 12:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
In-Reply-To: <CAAhcyzmaCLaRmK2anDfThnhy3M_EFRgpk7Aajd+uctvYr27WZg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jun 2026 15:38:14 -0400
X-Gm-Features: AVVi8CfZ5w-XKfqZD1zjtAGUkKFayphrgSB7EpFFspijBxN_vOw6O189Dbc8Ctg
Message-ID: <CAHC9VhSf-ph9D63=J-AemOZfvb9HXLFguCRFWkU4y1DvDsKr9w@mail.gmail.com>
Subject: Re: [REGRESSION] LSM/VFS: startup latency spike during rapid library
 lookups (ENOENT) on x86_64 between 6.6 and 6.18
To: muneendra kumar <muneendra737@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 3:22=E2=80=AFPM muneendra kumar <muneendra737@gmail.=
com> wrote:
>
> Hello,
>
> We are observing a reproducible 3x performance degradation during the
> initial dynamic loading phase of a userspace background daemon when
> transitioning from kernel 6.6 to 6.18.
>
> The degradation appears to scale linearly with the density of path
> resolution failures (ENOENT) encountered by the dynamic linker (ld.so)
> during its library search fallback loops.
>
> Isolation Diagnostics & Matrix
>
> To narrow down the root cause, we isolated several configurations:
>
> - Hardware Profile: The issue is highly reproducible on x86_64.
> - Kernel Parameter Isolation: Passing the boot argument lsm=3Dnone via
> GRUB restores performance to the 6.6 kernel baseline.
> - Active Stack Configuration: The regression occurs when all four
> modules are active and enforcing:
> lsm=3Dcapability,lockdown,selinux,bpfaudit. Removing modules reduces the
> overhead linearly.

Can you please confirm that you are using a "bpfaudit" LSM?  The
standard upstream BPF LSM is referenced by "bpf".  There is no
upstream LSM named "bpfaudit".

Are you running a distribution kernel or are you building your own?
If you are building your own, would it be possible for you to narrow
down the kernel release which first introduced the regression?

--=20
paul-moore.com
