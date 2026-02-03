Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537222C234B
	for <selinux@vger.kernel.org>; Tue,  3 Feb 2026 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149974; cv=pass; b=Ar8PPqXxZMr4nmnj013GLKtXQzPHId3sGPP3W+cLJmsCxmDSqutt019zahfXNkFPCiJpNbXDknFR0h+iyj4qcdTlvXtzY9z3h+sP4s3TMg5Tjqv+9T7rMZB8x9e0o1s36XTVMopa0QDpre0J0Pxvn/VMJ39mcdQsazOtnx3WWwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149974; c=relaxed/simple;
	bh=cLCHK/GWJNtF0Sissn76Fa/A62j01BKs/V9HBnfNYfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvsmJHR6MBb4o2rvrPKqRyrYFrJv+3rBzF9cSEeGGbBCql3I8sh8J7/3kWIwfolWEL3QQHTZ/2uP93YGVTNuOHY5ioqPjKaAY9mQMq8IZSh1VckBXWtzS5prNHOEEf7nbLXWXeq78LOLCI2BhevQxMlrZGrHzcnly6vBSw/dVxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRmT/kGv; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRmT/kGv"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3530e7b3dc2so4803175a91.3
        for <selinux@vger.kernel.org>; Tue, 03 Feb 2026 12:19:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770149973; cv=none;
        d=google.com; s=arc-20240605;
        b=EQ2MYxfWTzaViIvQlFEuQv3F+DCHkE22CmttgGqkxG4o/X8Nqh67UWG1t+33J0jnK1
         CyommCn94SjJOGr1Xx7VInJqa6Jz3y0VzC4M5csSkJMHRuOXECixrCkfn63N3oZq26Ot
         r6CasqWAhEfWeQjLkillAnGx7TnCxt9qKnrHs1crVyl2M6KyTFXG/C85ypkp+f/yl9o5
         E7d9MYxVhdzpqUMT+wPbOc6VClsJQwGxYmwtePUeXyk6RJ1uQIHdDv5CBnJnnbWhlSfn
         LaQNyzhzbwbB06fqMA6pa+PcbWYNz4bL3+DG+VXzKNZKeMW2EQgZkumndnCOmFNX98x2
         An8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jYxPCQk+JBSCv5U7E9uBdPsqZldB3TWjT6yVCqr6d2o=;
        fh=BawarOUyYa4MjdWkcdupHeXlGj90HG96LMuvxJG17Po=;
        b=HzeH8fPyK7nYUz96bY1ew17UKz8J5yBqZCxOiFWqUJyi61NLhY/73mbB034/QSZf0o
         /AxlU9OPc7trHw2ar5zAN96KgbeOboAp/PdPB0JLot+N90VvLuy5jpHd+GQos/qGp+Ox
         FjfZv6nRLAFOvqUlYhntrw2xVqCjoEsLu55mDH6nKTVurLSpwrGMx9+HhvOMzy/3smJ3
         ZWnUmhVBZCPKPjjgSXz7HjIpFMk4b1x/vvODmIE2Jk2DtTvKFRVfnwjQRr51kZ40Zblm
         7VfWHbZXXzJQ/DyoAqHnnrfhy67+Z2zb1761GVMI3/K8zFztyUI05jZ++Qk22uK9e+3W
         m9Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770149973; x=1770754773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYxPCQk+JBSCv5U7E9uBdPsqZldB3TWjT6yVCqr6d2o=;
        b=hRmT/kGv2ZoucdjQ0UwJsNO8J913gIhm5LYTz7B1Tv7jFLnAHm3csMzbv8eQZ+m5p/
         OrNw4bG45aKVau8AFFFunv7UoIe0FSa3Mnd78J43gCL43wy/YMmoWRCozeRo0iRUWJxt
         FNbepz91YCMxUnTK2B01Jhzq1f7yvKA9UFtXLtZLEqodR5wk1qx9aGHfW8ykVHngLCsO
         bEt48bKMca6dwebLRbdcIjtWalu9TnRaDGaMAoWQ23d0MFfeh3uy/AHAHWUVn6us1vpz
         2elgrYCDtpVK2XrLdX6V0o9HvNnUlvL85ZNhdT/A7SHSLBlifAvoTgiel+yILChmDD29
         Nkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770149973; x=1770754773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jYxPCQk+JBSCv5U7E9uBdPsqZldB3TWjT6yVCqr6d2o=;
        b=wnIyTxc/syuUT6Y12MJXwG7mYiqnaH5QzPtnawUC7+H9M0iLVZZZdC7mrBfdw3g9jw
         17UTu7b5eDJ/EodalZF+7i/iPeQb+8z6l3xknO0BGTiXH9eUdRKJ9DIePOtwCdJtLgDU
         RCi7Kp+j1Xj5s/ntQbIpOUVXjVY8u9OcSA0lt4OzEy96XgIfF1cnQuVPE2PtsUCZrolh
         Jij8doFbMLsrEbJfxq20K+sq+FDKeJYmDABazQ8YaAit20/zte5QSqpEh6/dO7NkPz2h
         /6y0s9X/LNSM5D7Gf3TN3HPUquxj7iekRyH4xgpqrXDVdJ7ST+kdrmH+jKeQSHDMdvJ2
         D/wA==
X-Gm-Message-State: AOJu0Yypet64bbELkEjzXD67YSQmgKXbJTzx9Dfp+PznWpPeuXXMmZrO
	65XS8US6ZNC0s8v2p3Do+4PpJhY6FOrQDTJXSxfNdojarHkAWY2tuJh+zy0u0DWicOe4b+7+eid
	YS/xxvDh9sC2BUYimA3vxk8WtBr02Zq78uw==
X-Gm-Gg: AZuq6aLqlEYAZB2/SIKso7A4EXMxjsk0Y7u0CCh3DRLSwaygQCoRkxnRDUw/x6Gqi1J
	0bwSC2PWRImeVXmn/EDh+BNvbl6IHokapRTCXl/TXpIzSwTCueCtna8xX0PMlMsOP2XBL7q+X5F
	IimEkc0rERTZ8aNZTx0SDbvKwEXW3GLmH0O0JFuhHxZ7dQruK35Y8AEp476WvSzRt64BfxopX00
	fkpxHbJyvQt+HNpZKb0VDoxIDD6Tc0gGEwVlfEoDNjstI7LUtlI72K0DhGhoqKHMfbLbFc=
X-Received: by 2002:a17:90b:3f8e:b0:340:d81d:7874 with SMTP id
 98e67ed59e1d1-354871bd5efmr470209a91.26.1770149972536; Tue, 03 Feb 2026
 12:19:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH3PPF7A88A980A236C1D23F1FDB87FAA2CF39BA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
In-Reply-To: <PH3PPF7A88A980A236C1D23F1FDB87FAA2CF39BA@PH3PPF7A88A980A.namprd11.prod.outlook.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 3 Feb 2026 15:19:21 -0500
X-Gm-Features: AZwV_QhvLI0blKAJJlW5188wjekrRDpJ5QOkX8z4yZdyoupISqEIBicOF0eVhDc
Message-ID: <CAEjxPJ4BP1isHT2T0sL1K58bLycwocG8FGFK2OSrkA6Qc3Pxag@mail.gmail.com>
Subject: Re: Missing audits
To: Martin Bonner <Martin.Bonner@entrust.com>
Cc: "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 5:29=E2=80=AFAM Martin Bonner <Martin.Bonner@entrust=
.com> wrote:
>
> Complete SELinux newbie here.  If I use a word that has a specific techni=
cal meaning in the context of SELinux, please don't assume I understand wha=
t it means.
>
> I am working on an embedded system using buildroot with SELinux.  I have =
changed a directory permission from world-read-search to world-no-access, a=
nd my device now fails to start up correctly if SELinux is set to enforcing=
.  I know it is SELinux because if I don't set enforcing, everything is per=
fectly happy.
>
> Well, this is easy to diagnose you say - just look at the audit logs.  Th=
e trouble is, that the only thing in the audit logs is a bunch of audits fr=
om all the "ls -laR" commands I was invoking, trying to debug what was goin=
g wrong with the permissions.
>
> Next try:  comment out all the "dontaudit" rules we had added (I left the=
 ones in the base rule set alone).  These were mostly rules concerning fifo=
 access -processes are invoking sub-processes, switching domains (is that t=
he right word?), and then they no longer have access to stdin/stdout/stderr=
 of the calling process (they don't actually need such access).  The freaky=
 thing here was that although I got lots of audits about fifo accesses, _al=
l the audits about the debugging had disappeared_!
>
> What is going on here?  Is there some sort of configuration that will sup=
press an audit if another audit has been sent "too recently"?  Any suggesti=
ons to debug this?
>
> One additional complexity:  the access to the directory is (or should be)=
 happening inside an lxc container (with luck this is irrelevant).

audit messages can be lost on OOM or hitting the rate limit or backlog limi=
t.
When you say you looked at the audit logs, are you only looking at
what auditd has written out under /var/log/audit or also checking
journalctl, dmesg, or cat /proc/kmsg for any messages.

Was the system working with SELinux in enforcing mode before you made
the change to the directory mode, or you hadn't tried it yet?

Does your system look basically sane in terms of process and file
labels? If you have sestatus installed, what does sestatus -v report?
