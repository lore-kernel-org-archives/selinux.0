Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AE175552
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676007; cv=none; b=hMs8Ah9K4rhODLOxdy/TrFN0wlq4vwII87Pi4TmPT+JbMc6uo14w0Z0FmYtlLl3KutZyeoVdcHC7OuWYVyRz9L3Wa60RNMtTXv2/ss9f70RfvCKRl+kcz8003gHpycH7J4jR4EZWZqKC87kOcYBpvhqXJecJOpe28sWw7A/mapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676007; c=relaxed/simple;
	bh=mlev0+xu60lS5aCFpgA+GQ5JQV4d+in+aCiB/IuhcgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8Qdm4eSwoChhD9+eSilZlMFGPwFbJJHjA6GWF1ShzZa+djqg9dtc19PmzWHSMSpWw5BkLr3zB2PRKuUFgHzcRhAzunBcjR+O1F7vRNVeZt8k8cspysrjCD36gHzA7WYHsVDoiADBhNGbmdSe1QnW9aCZvJzf43Mt0Gr4NyRtJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4gFjxjE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4gFjxjE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso61502b3a.3
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714676006; x=1715280806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiiBxum90WyecrMqesT1arF/g8SdSL94EBZIVerHC8o=;
        b=H4gFjxjEVWROGOGy72j0Utw1ANuAYbsikbx7wfc1FXlN21gMrRKjhg0TYSSMS6jGbB
         Vaeq1Sd9/zq0EDcDyL/Cq6r9KgiYMla35NhiMWmsrASs9K4Tj+hrRrnyCpVO7kEeRmPp
         gt+QuHf5vD2Ipfp8bGVCk+xIgWdxo7/bSDg1PjRoI25muMaFKb1VaTfFE0HlnnTnsU+c
         fIN7g3QzVJTjx9iX9XumDTXggFi4CY7lyZm2VTKwtWmfNjubWo9kfnMycgrW4wKwREGL
         RRfK4VBXYlwP2q9x+1l5WcVJsWoK7oW8Jsy9z9ex2NCE/dGNVZK7sGRcC1A7jOmy0j3O
         OKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714676006; x=1715280806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiiBxum90WyecrMqesT1arF/g8SdSL94EBZIVerHC8o=;
        b=lT1qxrS5lQNZT0pESeNKh7n0T/tAoqVVa8GYxctnAcgycYMkXmKH6s23kwC1bUGkbR
         goqjwf0D43lwN6I/p5SYETOW2t651GAt21QHzj9Cs2OFRUt91i0tFA2SzpRYWv28tpPY
         UJa27CPjsm3cK202tjJajQsuYHImaBeFBDfRV777KjJdKjZk3YjabDN1HvDfqzJ5aKZS
         nVFjVKd6Kdko6G7lNbkNh57gscsLKgBnxa18ScTNrt9TBx58IDSv+gqfCnMQRQJvMEVZ
         RzleBi0mSCQADSkx2G4W5/BBtTrmOz5S8b7lbKokPe8y6Iooc7OCWiUBKkU6gKL/0gaX
         Tk7A==
X-Gm-Message-State: AOJu0Yx7koTFU0VNN/wGD48WXhtDkpiSu49CRUq/naHks/+34lNWVMjE
	J1aVmiS728zbm731DIpyBszh9sL5X06ZnSJcxK29QTlDRCmoyXrVGbDMKFrxkA4o5FHasYB01iC
	MJzZaLewDlCEZcBGRHD/+BchBXtQ=
X-Google-Smtp-Source: AGHT+IHoZPlqG0Euq2STDhFLcphgx6VJjaUjdkcdPZ6dP/PwUOxqUNmkX3eWk8mORNQ9a2R2WCfy0Ij6CTekbVPinqk=
X-Received: by 2002:a17:90a:bb89:b0:2a2:94c0:38d4 with SMTP id
 v9-20020a17090abb8900b002a294c038d4mr632589pjr.31.1714676005773; Thu, 02 May
 2024 11:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3c9593d-fc73-4016-b057-57706e94d170@ieee.org>
In-Reply-To: <d3c9593d-fc73-4016-b057-57706e94d170@ieee.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 2 May 2024 14:53:14 -0400
Message-ID: <CAEjxPJ6uFiUjb0siO4+D8a7Z9ZB=WWNdO=54m1RsCO8HT9n5Yw@mail.gmail.com>
Subject: Re: cgroup2 labeling status
To: Chris PeBenito <pebenito@ieee.org>, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux mailing list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 2:37=E2=80=AFPM Chris PeBenito <pebenito@ieee.org> w=
rote:
>
> The state of cgroup2 labeling and memory.pressure came up for me again.
> This was discussed March last year[1]. To summarize, refpolicy has a
> type_transition for the memory.pressure file in cgroup2 to a default of
> memory_pressure_t. For example this file:
>
> /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
>
> with the idea that we allow daemons to write to this without allowing
> writes to all cgroup_t.  Unfortunately, the thread ended and I haven't
> seen any improvement.
>
> The conclusion was[3]:
>
> > Ah, now I remembered that we made it such that the transitions would
> > only apply if the parent directory has a label explicitly set by
> > userspace (via setxattr). Not sure if we can improve it easily, since
> > we can't use the normal inode-based logic for cgroupfs (the xattrs are
> > stored in kernfs nodes, each of which can be exposed via multiple
> > inodes if there is more than one cgroupfs mount).
>
> Testing on a 6.6 kernel and systemd 255, I still see the same issues,
> where most are stuck at cgroup_t, with user.slice entries get
> memory_pressure_t[2].  Based on my investigations, the user.slice works
> because systemd sets the user.invocation_id xattr on these dirs.
>
> Next, I tried modifying systemd to use it's version of
> setfscreatecon()+mkdir() when it creates the cgroup directories.  This
> did not change the labeling behavior.  Next I changed the code to a
> post-mkdir setfilecon() and then all the memory.pressures finally had
> expected labeling.
>
> This setxattr() requirement is unfortunate, and the fact the
> setfscreatecon() doesn't work makes it more unfortunate.  Is there any
> improvement being worked?

Possibly I misunderstand, but selinux_kernfs_init_security() appears
to honor the create_sid (setfscreatecon) if set, so I would have
expected that to work.

> [1] https://lore.kernel.org/selinux/87mt47ga29.fsf@defensec.nl/
> [2]
> https://lore.kernel.org/selinux/CAEjxPJ77ZiWTwJ=3Dhj2DFoNCg4XZMfiU6VNSNAn=
yCKc0Rd+nM6Q@mail.gmail.com/
> [3]
> https://lore.kernel.org/selinux/CAFqZXNtLFsmb3n+H=3D7Jcp1g_sLEFdRL75fzvjM=
vTU1rXvaQXMA@mail.gmail.com/
>
> --
> Chris PeBenito
>
