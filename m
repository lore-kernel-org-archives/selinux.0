Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024D37AA9F
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529407; cv=none; b=PE3OQXpHUdj38v/vJnL4C8MDN3wLJkgCUgkbMYAfTqyNm5KVnu12G6m7fWxL40V/InsQaeMn5MZEqNsEEZJvzTrseMQa5dO5Cbw3UmBNjkDsz5nzpegQskhuh8V97b7/ntK2i8m2FjYtT/hcbbic+wEw5rvA2U2eQPXLoaGkkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529407; c=relaxed/simple;
	bh=hUkGjqs6qcYuVfKb4FdP0YcKEPyEotgH3ArbHxEaHSc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=RFctILZfR87PWCZBTbf4LCIyaKHEhZ2DAam06VN939RTSmkmBUdWHoy1qzdCMORcCa7gEuwMIkP22c5EaZW4NaTzT6ciiBQha/vo0JgDcUEWyz9r0oX8P63e4mAQTJeqD8kf7jd3LvfHIx+iP7bXIIKObYJE3Pj0R1xfCJ4iwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hlpw/N0H; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hlpw/N0H"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-939922847efso45368285a.0
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 20:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789529404; x=1790134204; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Til9bgq45pMcrN/mAeyzZMNqicB3+Nb642mFgaUojyw=;
        b=Hlpw/N0HkHsQTYtj7U049Cw8JPDLlHumzPZoCMRvVh47ABqMOdKmPjM/3x/3R3bKBO
         HPYs157NAxLqMOkhAMr2Ta2nSZLPD7YObYHyJqdDqTOTlPlmTwxtC2b2g9pYqaGuhEtK
         6ikSZnxGyzN9HhUvPjqqjnENe2HJe57yFSgPmRRS8TOc0dkvWxRW142W/TKz4GTu4ydT
         R/DgB+IeB/0q4CS9LvEEPQsduNBFZ7aMdxBiesFkoWEZOIAjEhwyqbWzvASoni4zjgOK
         kLJ9oQXTHDilMuHbvuc85vKEhw3XW9rpt8vfVEbxcZOyryESZG2ogmm2hj++uWprY7QO
         Yl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529404; x=1790134204;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Til9bgq45pMcrN/mAeyzZMNqicB3+Nb642mFgaUojyw=;
        b=w3BWvyMf6qdEpf4crK9wnTtyC2/IUEsiJjisw3+SgQutL9TN0cRACAZ9/lw+lNWfR2
         DkTLYvEIuZ3NOMpqiHiQDH10dQfdVapJn/tD9sNqVoY/xN9jmcmg8wQ+5DSEsOOtL9ZY
         FV7SIO1r+Ohc1a1cGrz0znhCN4Tq1GHGEfI0qPtX+Fs4U8mQuFJXp+TYCJsr0IyoFXc6
         dQt9ad2K+xvqUHuM0bBIT9IGmroQ1pD4AtJR+MdBZluaW4r719vLNLSsjQVjiwCwQ0A4
         ovzkrL65gDM7DJ2YLlt3zFs4KiDNJab9BdQtkXTqlsso0/VkpX6aMegW5kMxB79s6dds
         a0/w==
X-Forwarded-Encrypted: i=1; AKwUvByhDXSZvT561Vq6YvXW6aUI2pnU21fMHfFCkaxC+Uvo/YACZQQF8OfrM7ho6QV5eneGbHFPsr40@vger.kernel.org
X-Gm-Message-State: AFuF++kmjcx51KPj3eS/6D2gg8zILuCVbmCxH6qJYM/Do8ERalxVev0O
	uem4emHMdMwcVzmyWcx3752JEGeXPVnQcmtwYOG56ew7Yh/K3OQ1opO8j2N49tBz0Q==
X-Gm-Gg: AYBFou2NpyGEBLzcOFsdgk2k87IrH6jKgowao0TGXmaylnXv9JrlFWQ5/cYDa6y/ZNi
	pHBfD1nDx5TEcZqm/Kysl5ZXs0NqidhjEeRtTPu1P8ogDJOvXSkFoQMyNJTG6i5qkMW+k5Gf3DK
	+rGr+QFz+tCwzA7bp2kiObEgVRjSlyUEW+81WF+H7E73Yl7UuQx2QwDvszxATBVjnwF0fo1Fzcz
	2xQbFYdXbxtWMU1C4iSX871EzzAKQ1zX3PvsEgwjl8VSjHcZbuo6P2QCB5AynyRfley6S88jg5j
	IYqVajjlz00UqgYvcPbYN0KoIkPoKbXY4DC+inhqeLtmiQi/ci3ubSAsCiPyzZS/KEXuHk3UcSU
	q7rURmkUnADQqdwhCOzId3X3T4gZ2CbgQrvibwmukNivI/D+C5Ru8C+JklR/vQUC1jC/2qaFjY1
	xqiYqlyyixXMCgLEvm+aIdMK1CgmOOWd+HYkuvcyibgfUYVajssDDjXBid8BdKelbHw+KlSncb6
	HWGIPE1bZMinim8ZR2HDhXRhtcA509SL8c9Dnej/nkuyHi4yLov25CzJOYBNSOJJblGErao6aiM
X-Received: by 2002:a05:620a:4709:b0:939:35e5:94ba with SMTP id af79cd13be357-93bb766747bmr170559485a.6.1789529404169;
        Tue, 15 Sep 2026 20:30:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be648e5sm15710696d6.8.2026.09.15.20.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:30:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 23:30:02 -0400
Message-ID: <d852b4ae61860446e038f69541f36f9c@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260915_1728/pstg-lib:20260915_1318/pstg-pwork:20260915_1728
From: Paul Moore <paul@paul-moore.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] selinux: preserve user SID across nested backing  files
References: <20260829213256.51527-2-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-2-kmehltretter@gmail.com>

On Aug 29, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
> 
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
> 
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } against
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
> 
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
> 
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
> 
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy.  The original test was also repeated with Fedora Cloud
> Base 44 userspace and gave the same result.
> 
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access checks")
> Cc: stable@vger.kernel.org
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c          | 9 ++++++++-
>  security/selinux/include/objsec.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)

Merged into selinux/stable-7.3, thanks!

--
paul-moore.com
