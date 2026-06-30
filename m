Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064B3F0ABD
	for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817318; cv=pass; b=c1R28MKvFZbU1Bh6VSjqlSr7XPIwahCj4i/BCqW1KVOnqNfjt9PmPeogfUkQKt3zZwgC4y/9V0SERddsrYfWFLTJxM7u2RlMW1ZahL6JtdjeLXI/L3j+pBSz0Bph20jxbUrTeFRDAP5bdqXh2HUyMSohIsPKsiizpxEStpz8PsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817318; c=relaxed/simple;
	bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f79FBm3oVFEpabHBh4IGj/0vgaTvySr23xGvykc+5bxP2XpqThlPmuEiRn4EvyZaNx2RIEXgtja2VpfYIQEyjzVS7McOFTEZYsLkrPEkhQO41KmHc+nXkchCwf5AWUzpi8v3HhvtxHU3GC5sKiT4foWOd/yS88rLu2YYCV5whv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh/cOEk4; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh/cOEk4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so8525343a12.2
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 04:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782817315; cv=none;
        d=google.com; s=arc-20260327;
        b=oKzn4dcZLHQFF+BORZrJURX0d4IfzhPQUgtOqzjJBX+Z9fFfIUUoRbKIjOOtVNhyR5
         gFTv+qsbi3t2x/KiK25z4RTdOapVh8VSPg5gClmflM6z8L/BUIey12Gl2espEfhs8bMR
         ktQt7FY3rz43alIdugbOQ6BnSKPFN/reJp5fkxy99Ngz4chCz0HWd9Qc1n0G2e7AB+Ld
         Ai3vRecM1dXU+oAbZGuw2Vr2GPiyziTuiNye3ughz6tURUEDOLGA2lZgQvkhqjZvMswW
         bW5urLa2QQN/XECKmsXCllTXgP45KkjlHpD04SsqZdXqc8aPwANwgp7MnHPffD6B2dsv
         kuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        fh=U/GSw3rR1O7bGB9XA71fscggEMu7GmgNCNsPnyGDc/U=;
        b=QYwGwqslkhX5/4UB2BkmVw1o9jjdYHdD98MxBykqQikMyAdexruZ36IAF8i2L5Izf+
         ERYW1FzYYoimBJUw3PEPVwOOr4VnOPigO/WGY/6DYfPXuBAsW1ev80ELrAlnAhsPbXNI
         7NpDWANfrTOqjyDuSXS5rROzEZc13h6SZAjYaGCmI8CtotRMnHkmQ0Js26Ik3DWr3dCa
         eiQVmToN944hDz/zDSrpvj0DvivMEtj747CTpCLslLUleakRTKvmduMtGxuDrnaDm8ns
         TJCeW/Jx4T8F7WpqxhlbkUTffhSA0uzgz1ha5H/Yr1uFe4Yl7tg/t4J6wghkX2ua+k7W
         eUww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782817315; x=1783422115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=Vh/cOEk41rYPNWUDRzL9fV6pGiGys+jgYv56yyVM5YLQG+CQ6HAz8bjg+2yhOi6Z0R
         HX5dq5MjKkDCK0F0V42AmSr9XYvoGMwSY8++X6KpGHvfsB59EyMe/afP90eBPd6RVRuU
         L7n25ctS5VPtXZFXOSehyvn8hizxq6TuElNJX8Iqm3lyuU2vWeZaWZSlzFn+po0im++h
         6dXOnUDzBwgqXpKdQxQeR6rYoXT3d9Jo00Fe2t0MpjfrJ99DhicDwTRG2/Uz1zEh9e4R
         eR7AWSSH51CU2MO3xvGY9EF+7aN4NbA4bV/dCilNCPOg4BUfkwmVFQbMOtZGFMCByYKP
         R3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817315; x=1783422115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVMnZazNe6ueinmZJ6D34+lB49c1hHJgeNSRfW04Low=;
        b=rOVR3zfD/LXMf6hkugl91Zyorqv9ZlVP+984PLoByjIv1d+AM2VKFabVCokVzEnMRV
         XLQetg34VdtzKglOu4IUQXD5MFHuo8VJG+304gd/JYCX0VBjv4S5g9nmrzhJV6jKILNt
         jT/DuW9rvT7dqZjxoFJSkaB51EhXFKm+fjmhLqw5BjXt8/RHs3S/9w5ZaLfMMqmUkyHd
         8sDYBHZqlfWqLJgw7eY6ZcLl2tI08xyydFF91PDG4peIi9AlDeGu9Stu7ET0416zhc4S
         30dMt609HQrn3TP4wNtC0ulPm5FmN9ifFQvcfc+5hVQY+irti8IustRxZwtNkqMo+nvU
         IKrg==
X-Forwarded-Encrypted: i=1; AHgh+RoZT6auV1JhGcQv760/IOpfd39CUneLfNogmZPCfURiBUIXz9V897EAB+EZ/xiFAHASmINAM7ka@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8SoAt5VmkqiSlySHrvpKJFbM3iyYZQbRvwPQGa54RbYfsNH1d
	MEysnbNqagBXhg6JN5uzjLmgv+JLYfVYZPkH7Sh90zIk4uDSOquplHY15RiGLpyNOHqFoklNMo4
	9quoG1nxtBGn+rtKb9qyQtJwJkS/b8EQ=
X-Gm-Gg: AfdE7clQKh2Ci8Zi+ipjFgNeFCGXFGFGoN0pvSwSTNo1lZAc83U+mh3WcExLWjjAp02
	q3ny2wH9pU7x806/JQ1woZE9AYboSD199+Qhl00G89JKRktuyoeVi/WyOf3ail8+BIfEmcT4owV
	M9FE/Ykx2OB4BfoTasKGUPsN+1qIrmisMdlug3j8C5LUlXx65g9WzT9O+A4+1ExfFtpoVMYGaCJ
	PtZH9XcZ9YHGaKYpsnPsy1YhT4aQ8JrjXx0vftzLFb74T11/R4k28jmqrbkW8RYcgTFnqCea7EG
	lrjyQEwBSq1ax7kz/2eWUFU4/Fa82gI=
X-Received: by 2002:a05:6402:5248:b0:697:4307:991d with SMTP id
 4fb4d7f45d1cf-6988789244bmr120235a12.19.1782817314715; Tue, 30 Jun 2026
 04:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629070653.580879-1-caixinchen1@huawei.com>
 <CAOQ4uxjcD0-PHqqmrpEvkLRgtKJGe8-n+6DQyBngjN2TorwU+g@mail.gmail.com> <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
In-Reply-To: <f4c8f5fe-30c3-4e7f-8512-7a2befdd1ed3@huawei.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Jun 2026 13:01:43 +0200
X-Gm-Features: AVVi8CeRSS7JXqOJC8_jFJY-F8O-_1zMcUusRfzqJnniatTSJdpzkrHWbWs8ruQ
Message-ID: <CAOQ4uxh4-LYt8VUW5o+0mMrHpnZm3t8k4WD6x2kRqEj=_ZpLOA@mail.gmail.com>
Subject: Re: [PATCH stable/linux-5.10.y 0/7] Backport Fix incorrect overlayfs
 mmap() and mprotect() LSM access controls
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	gregkh@linuxfoundation.org, sashal@kernel.org, bboscaccy@linux.microsoft.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	lujialin4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:06=E2=80=AFAM Cai Xinchen <caixinchen1@huawei.com=
> wrote:
>
> Thank you for your reply. Regarding the two points of feedback:
>
> First, 6.1 is still in the process of being adapted.

So do not propose for 5.10 please.

>
> Second, this patch set is primarily intended to fix CVE-2026-46054, but
> it seems that for lower versions to implement SELinux checks for overlay
> mmap/mprotect checks, some dependencies are unavoidable. In such cases,
> should we add more tests to reduce the risk and integrate the changes,
> or should we simply not fix this issue? If more tests are needed, are
> there any recommended test suites?

I have concerns.
The burdn of proof is on you.

Thanks,
Amir.
