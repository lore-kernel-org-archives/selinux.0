Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDE2755E0
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601171; cv=none; b=jcxEodn9BTjqmyQ6btKFKEknBB6cjzDdiZvv0V2zv8jzjL0zlEseIrJ3vaW4jVGr5f1zpBEuWkqfoWP7iA8bfqCaYtUcwuaY3CUhMmCQBPdsTkq6x1cYSgSoajHTC96LnvZvfATBSJqFYxXL6wNjzanxkH2cuTtie+C7q3J3QmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601171; c=relaxed/simple;
	bh=pRMgXJFWpAts+pU5cfw2qJI3yKgdhqxFVB1HP3y8nVc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=LkyvgA9VacKG+seaiFIYuxDnev6ZVf7KUhEf80ZwlSQN6CaApNwjrNl4LFT7TAm05uoXiTlrzHpWXX3cCB5HYwE25PaYJq03cGlKaYjJw+AU0Oy0ymFt/oWK5+NTAlk7D+u3zZr17G9i+dVGn/pd6l3D+AHm95ikjhXvISryYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dveIoudK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dveIoudK"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-472003f8c47so2457581cf.1
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740601169; x=1741205969; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghoD3ag/pzPbCtjFY/jPNaeLEDXXel6+TW59rVHfjfk=;
        b=dveIoudKzKxKugANPB5GGsZegCwMrqDZcYGyKaEojssEcxYPTMjaP6BNUAButblbPy
         zbS5usrttUNCBSCnB3ybRBs8awJI2cASsu1AEF+JS+RJS3rFCxP3v78pWBlXIgUc33lY
         6FvP23ZUb7XMbgD86DpwYk3IpYZGNHAnO6yAsuGpixq2myYv0kfg/1voWZ1QGHRC3ytc
         fglXNgv6NNvGAiRh7rugpzBbWn2iogvJZ8Aa5BCQflLaQP0t+4QVBSz9o62UXeX9RDg8
         eoYLKcIeaLBnQEO/hfAvUPW1Bw8Firq21NSMkhtvcqEa1xImEcpcz/GumpEqCTKo7Gkh
         g+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601169; x=1741205969;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghoD3ag/pzPbCtjFY/jPNaeLEDXXel6+TW59rVHfjfk=;
        b=imCSz2c0nwvdfTAw4RQ9S51soFMlQC2X1dnvhhuhp3dROFWvcLpvjyHPg2pjfC3zX+
         HmcDFvVH03HDF91LMLok4ZqV2LamFU/ReLgxIqahywr72OqGd0fNEXQ7BVPedD28nEp7
         gL9NR0dyJgi65L9KlwhXEFid72vmSQ6Jtx+F11M4ae6XN7BV1KTDIb73Texj7np53luG
         x/CCB5LHxY6ML2uLuEwILwAb/EsjGqX+7heqVKTtkRIdMmmTWrAqOhRh+2B7l8qH2i8a
         E1GGeGu33UPVtcmUFEZ89YGgnKlM9cNTNvuGTv7kcPGz6MRTYWktLJs16leUqMmKVc23
         CB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/P7LB2bAcDayEMJD2hL/3Twpzecw3XG6EuY7wSWHvdRq1X9n4SHm/Vy71Om3Fg/AWuVVPaMsY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5TrgJJwKKr08bdvAaHTawnsBstqtayOg+M3KOyi1F7rwvAY1n
	yNwv5CbFiuMD9BXPduA2WtsCnOpwHCvfxoeSETVVbojxL/4atguUn6cbIJgb7d0Uti8EA/x8qNZ
	2vw==
X-Gm-Gg: ASbGncsR2kFjfQBTo+v1FWL6gN9a5+Hs4n17l8mAhE666+g9j7ebtT7yTdhxQACmjXe
	/sNRJ5mJqkPFFnTKD8XfEVrfGLefZ6HPePE9kjMXEAc4gxBt3JnpAA9M073vib4ZilD9gKLv9Mg
	1RVHU98kGIz9o7QjpZIo4MZtFTXfj1NMuVLVhKkGR+Lz93Rpr5YILglXrFN+CO7nllaWzdBUSnz
	kUNHdf0u8lSZKQA/uXLnI7q1LY9oMOO12ENZEyJoUppaaa9Xr2509hlqCli5XnginzYDnEtD4Ge
	kjY042moVsXOE+ZwvxhiZDmlbh+98GBLUFvtp2koV2aH1eteZm5xkSnlF9fblyH/VGxwx2g=
X-Google-Smtp-Source: AGHT+IHlD52Lc+Tn+8mhSVeF3cbMWb5L2ojc8igqm9bfmEeYLdqG9MAA2o2DdRWX5V2W073wALgrfQ==
X-Received: by 2002:ac8:59d0:0:b0:472:521:871a with SMTP id d75a77b69052e-473e55a7432mr13431481cf.23.1740601169160;
        Wed, 26 Feb 2025 12:19:29 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474691a45d3sm357351cf.8.2025.02.26.12.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:19:28 -0800 (PST)
Date: Wed, 26 Feb 2025 15:19:28 -0500
Message-ID: <4a98d88878a18dd02b3df5822030617a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: Miklos Szeredi <mszeredi@redhat.com>, selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selinux: add FILE__WATCH_MOUNTNS
References: <20250224154836.958915-1-mszeredi@redhat.com>
In-Reply-To: <20250224154836.958915-1-mszeredi@redhat.com>

On Feb 24, 2025 Miklos Szeredi <mszeredi@redhat.com> wrote:
> 
> Watching mount namespaces for changes (mount, umount, move mount) was added
> by previous patches.
> 
> This patch adds the file/watch_mountns permission that can be applied to
> nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny watching
> a particular namespace for changes.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  security/selinux/hooks.c            | 3 +++
>  security/selinux/include/classmap.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Thanks Miklos, this looks good to me.  VFS folks / Christian, can you
merge this into the associated FSNOTIFY_OBJ_TYPE_MNTNS branch you are
targeting for linux-next?

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
