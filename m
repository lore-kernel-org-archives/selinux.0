Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF30218821
	for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786260; cv=pass; b=KbooH5Dp30K9Xoq5pAJLo88jumB+jC1aG1gDd+yHLOyhMV33SdaGdqoq345taGdQmGvtwWQ0VTkirHr4miO1cMW9ygrTqZZo3fga29mfFK6lxfQwhKafwpn6VU/LMY8+hg+KhnIgu3sRD4SdhgWuKhOIAzz4bO38GVMs7O7nPwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786260; c=relaxed/simple;
	bh=y2+hZxbVTEoMFnSQddj1xxO31eZCaQ7fsHzgp6Ik6BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=it1tiLPyzCofN7Cx4o/JnV7mNZSKp0Xtuwr+tWe8w9JExhQmHmCGK61r9XL9k6ZAUGoRtbJdUXEi0S8MNNLaTlyWWz9/xWYOqaRcxCz7h6VXwtDs2ag7+014QqVEhwV/IB3pqoVUOidO8tV7krZqPk2XUdb+wy5Fk+VytoMBF1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRWHH2Fx; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRWHH2Fx"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80bb8287d99so38618287b3.1
        for <selinux@vger.kernel.org>; Mon, 29 Jun 2026 19:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782786258; cv=none;
        d=google.com; s=arc-20260327;
        b=JgIOYgD6SO+JjWUVx9zr36U3p/cJfFO0vLMV+uH65IWiMo9wJ30WFdd58TK2dRk1+W
         rPaI3eeXRGA5/NGgkVeaeOtsU7ltkwpuxcZbStWJ/Mq/8g6wpla7DTwYocow1fMzvuKS
         RxCcTEOSlBGCQ5VXce5rF5rjt7puTKB6e9YrE2cQNQ2oUrxygB0+JtzDqZ2E0v7VpkyJ
         4W3/cpJz8GIYf/IXUnO5vhurqFdvfzHbpIObDZs7ufgiTLoClO7GPNOarysHkL5DP4UA
         arVZhtDCgu++ssKFMJ4BnCcoHa4Y0R1sGUZiJ9muQq8jZM2ItzAv3amtaI9v2UlsAOtz
         IYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y2+hZxbVTEoMFnSQddj1xxO31eZCaQ7fsHzgp6Ik6BI=;
        fh=XwHl0w/SNOokAMmAecwxthWrVgUYag+M1HrRyXxlXus=;
        b=qx7qqJLuTEjMUo5yXxn2+MsxnTMGX/aWWbRs+M4ZtACbAr7T4NWOOflLVMbDfwGRZf
         awGHmrqs+SC/GHk18zP6L0uUSWnm1X2ZUOLFRVyjIfc6MgqkwgI2gGT2BYdf9YgPVRWs
         Kcaftn8ea/1hpZgzqijAn7lV/AECeFeMDV8/L3+y7QpvUbBpf92fqqlwfH7Y6h3PItHa
         kD/Cimyh3MQxAYRpEFuRf1fsfwbbV/XVOUYZ+/XhO0sJfhtC6Fs43ANACJYwZ0WJWqsf
         a1XRjqdTm9gtKRlTGnl8iSth8teFVNyQpgv/nazRhcT2VRkklI2uB65CXGuhVibgR1eR
         4E9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782786258; x=1783391058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2+hZxbVTEoMFnSQddj1xxO31eZCaQ7fsHzgp6Ik6BI=;
        b=lRWHH2Fx9AabC7w1B9y0bEMXZ925aNhFlxLzoxOPtr+o5JtZIfAlnqtUOMV2GSpwqu
         VEG4kleABvgtD5mCGeY6/GvoZsancOKoibxFdMDRLUgm2jkQQfHvbJ32OMMH3n7fJhbx
         YcuexUZCyQxDUNvQC+Jf+Fi7AoLUKSx7vgc69DVvKLTiH/GFhCRRZ0H+F3y2bkN678Vx
         hNFAOXzHwsun+1GiFEj2RAQMX6epM0LF5Gg0Mu43mTED9IxKieRe5trWigQR5uCwyQoU
         NpYJywiFNT0HHXThxgR0NDx+hqD2ps+JQiy7zlvx3sX5YUORNMC3AmGgUfjxmoiotUHW
         A6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782786258; x=1783391058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y2+hZxbVTEoMFnSQddj1xxO31eZCaQ7fsHzgp6Ik6BI=;
        b=naRADuON3kco1/J5RQPjYmP80o4xfniICAdNXLPBPsipHGn7+RXB3SVrPLDLt01bRX
         2XN43lgLLauE0sSQEnaTdRjLsAdnnWZdTJJzuKp/c24Qa/pFaeqmIBLUv2YQYcLAeLvy
         +oXJ+z/qfP+WsJoH8kaxe5rO9g2p87xp2Fk1s94dVK31qX7EmiVPZBJicefC6BnPgWNK
         ZYleAFP8dzo4CgP3w7H1PIDYhld9ivl28WVsIN27NFR8Z+cFSs74qkBHSDveO0SW/+av
         7BFRKPSlSgzLXYMUNFE21aVlQh7ZQ72148V4FjJOxY4+lAn7osUIwhzXhYEYAw/u+tbT
         eDAw==
X-Forwarded-Encrypted: i=1; AHgh+Rox40ZItrDoylVghovzgtcychgZ5k6EIH7SfbBEHmpXYReqYjCOgu3SWAE+f83loYp6MjkSCsAV@vger.kernel.org
X-Gm-Message-State: AOJu0YzqB9u2VAjYROOljO3pa7btPef91KZ0wzc77cER0e7FVm8eTN7D
	pwkGHNO3fRY3xMBR6CRs7CeEd2vw9+mpi+sFMbCizxXpdDji3p96v6d1G3OCCqbvV8rOA84pX0C
	5a6yL5Hg1aeDJiYe0rVPUOWsiAz2Lxm4=
X-Gm-Gg: AfdE7cnXNsyDEbo+EBYMULK3Xv5vOpnkWmCVJJ0ccN0u/NuJMRFnMj7eUY+LqdrN001
	RDh6GZUxRRqBEu6g95jliy+P0EOBAKgSRtROWafFGL0ln2Nsc+JUX57tvA69wG66MkgzAoawpuY
	kvclU6hKTJtk+P6JgNVIguuQ7LWa98Lyxx8lMX60fx+lctzzBkCtER9NwR9dRfYwrw9xfhrGQSw
	6eIhBwjaYd3MsBVQJ6DynHDwVA2pwPz476O8k4vTPqYET+riymy13+lsVNWtG3WUX/NbBIau/CM
	+Z5WNu4gTG62z6zcnLFZPCnLpOFa1w==
X-Received: by 2002:a05:690c:6302:b0:80d:e214:c2bc with SMTP id
 00721157ae682-810da60edc2mr21494597b3.35.1782786258423; Mon, 29 Jun 2026
 19:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629063005.64700-1-laoar.shao@gmail.com> <CAAVpQUD4tpO7h92FCrp_phkjQv-QXXyrYBvhGRDDDG=doht1nQ@mail.gmail.com>
In-Reply-To: <CAAVpQUD4tpO7h92FCrp_phkjQv-QXXyrYBvhGRDDDG=doht1nQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 30 Jun 2026 10:23:42 +0800
X-Gm-Features: AVVi8CfbLI8PYRg0wNYYdMhaFdG9GhdjzZIBYrBxb4UjzDXLQUW-K7G6qqOlzFc
Message-ID: <CALOAHbDvvk1pkZb8dqz9+FET3N813b2Hhx3M9hKF95FETuDgSQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: suppress warning flood for retired DCCP netlink messages
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: paul@paul-moore.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	casey@schaufler-ca.com, kuba@kernel.org, selinux@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 12:16=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Sun, Jun 28, 2026 at 11:30=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > When deploying linux-6.18.y stable kernel to production servers, we
> > observed kernel dmesg being flooded with SELinux warnings when running
> > `ss -l`:
>
> Please update ss instead of reviving dead code in kernel.

I will submit a patch to update ss shortly. However, I suspect other
tools may also invoke this deprecated interface, which could flood the
kernel log. It would be preferable to suppress these warnings in the
kernel to maintain compatibility with existing tools.

--=20
Regards
Yafang
