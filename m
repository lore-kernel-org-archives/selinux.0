Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BD53E0A
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949845; cv=none; b=MSQ6Nv2e/UlDRrr2hl1OnYlfHBK4EwGQEzpeSvquL+l2+/3hKYLp0GaRZRhJLxuBkJtCsma/tSzUtM2zpQPPWgYkZtDcn5hhFFORqDxixEizJNdfc9LoqO8tBBP4Yoj3jsm9z7BmKNAgIAU+IkKbvrKkbXWII5MGg61jFGL9SpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949845; c=relaxed/simple;
	bh=vJRYc8Im7GwNPcRylBW1dUn+n64iw0H43c1XbhLkPJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2Hvb69htAAtBi5vObvPcOFMw35wDns6fASlehCs/bfJ0awXJ4zppFXGEufqosb2WGLAPL93qvnr8FRT39cN6TEN8p9ZqDPRrzLuc18gulPHkcgTEWEQcUM0gFFelqbdMmmPwkJ7RFUo7yju5LSW5B41sJi/BWr5OjH/imBaIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo/EcSaL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo/EcSaL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dee5ef2a7bso49374805ad.1
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710949843; x=1711554643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJRYc8Im7GwNPcRylBW1dUn+n64iw0H43c1XbhLkPJY=;
        b=bo/EcSaLoup1AhfYoavnq6Qk+MqmqRSXi5R7U7y0IB9Ka1DuO83hWA2BDeJVRzvC8d
         rt3UbLSrQ1plHOr3y/UW0GKJZPBhVpjSd6mOe6knvjgTko7/IMTsvbw76wDmyLwbQeLu
         dDlhLtbcZe6qXAf1+FixyLO1aMsh0G/UbzF/ucISgej8WzOTRaKWNCzIwkqwGq487zXD
         X4zyEz1cF3HdrYq7R5AWN/JsICFhGn4m+qI+Hw5s5G/gQBkEU8KButfPF7XtdX8TpJ+h
         ghl1nmboc5OqghBXgktI9iNS+7eRO1G32j5vrluEYNaKHWbhWKsh3cI+iVZJFCrBLkgJ
         kp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949843; x=1711554643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJRYc8Im7GwNPcRylBW1dUn+n64iw0H43c1XbhLkPJY=;
        b=nzySfcAVMp6rmCa4f8qG8KSdEM7DjyqyGqRBPEN1tyNFT+v9B3RtACQF6liBXK7DN2
         zAyGp0+tV8Z4uZGSjvoo1zJoMNFPXC2vkZhEaTjk5m7tIetHd0C9clKi9s44bHbIncGg
         RYLIJ0BWcXSsloAvmHgemuLdLkSy49yGR9pSRFUjzMbdmjc0OTVjQgiVf+tSUPLrrBPE
         k1v9P29uhelO/7ZQW2t8O5kpz1heHVFaOnLOXMs0KKSJXZL5Vk/w/DEQ4/zHfFM0+3nf
         RWu+WxVI2jwIl3GE6uoDgkgOrSPxKOI3El7eZ5WxtWu/VD/ak6eoH33xE42MsKOHmMXZ
         bzYw==
X-Gm-Message-State: AOJu0Yxmfl8SnWVWg7PRAMjW2/W02ujLl0ZBvJ+t8b7feq4HKB6DJfcA
	aHFcP9wsJDxaIuiHuKDcRXpDvNRDfUmvzwI164GrDk+egNZX/QrDwjjCNSmR60R/L/ch7k0DbAi
	ZkZcUyxMKSdQ8lQ5Rt44HHMhDgGUK5UPjasc=
X-Google-Smtp-Source: AGHT+IEilfUPwWj3k5vPTiBXOL0Drshk8DO9e57EgycFkCc08GbtiTZLerRO2jhF8bNP5iACJo7CDjkTLy0MKPfN0jI=
X-Received: by 2002:a17:902:e843:b0:1e0:2f59:524c with SMTP id
 t3-20020a170902e84300b001e02f59524cmr9798950plg.37.1710949843010; Wed, 20 Mar
 2024 08:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41f73ba5-7d43-4a19-a373-84f05c03d95b.ref@schaufler-ca.com> <41f73ba5-7d43-4a19-a373-84f05c03d95b@schaufler-ca.com>
In-Reply-To: <41f73ba5-7d43-4a19-a373-84f05c03d95b@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 Mar 2024 11:50:31 -0400
Message-ID: <CAEjxPJ7nCf1SYRb5cAg=wFOM5r8C-y9XNJAijfU3dVxyYuYQ+g@mail.gmail.com>
Subject: Re: Where to look for system services modified for SELinux
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 7:03=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> It would be very helpful if I could find documentation about, or even a
> list of, system services that have been enhanced in support of SELinux.
> I'm doing this as part of the LSM stacking effort, looking for things tha=
t
> may require additional work for the multiple LSM environment. I already
> know about systemd, dbus and the pam module.

(re-send in plaintext mode, with some additional info appended at the end)

There is an old list at
https://github.com/SELinuxProject/selinux/wiki/Userspace-Packages

But the only way to get an accurate up-to-date list is to use your
favorite package manager and ask it for the list of all packages that
depend on libselinux. That will be more than just services of course.
Technically that might not get all of them since some could just be
directly using the xattr system calls, the /proc/pid/attr interface,
and/or the /sys/fs/selinux interface without using the libselinux
wrappers.

Some SELinux-aware services besides the ones you listed above and not
in the original list on GitHub include nscd (part of glibc), sssd,
Xorg, PostgreSQL, libvirtd, all the modern cron variants, and various
container runtimes/daemons. The extent to which they use SELinux APIs
varies though, from those that are merely getting/setting SELinux
process or file contexts to full-fledged userspace object managers /
policy enforcers.

Then there is a completely different list for Android, but not sure
you care about it.
