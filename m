Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7252E737D
	for <selinux@vger.kernel.org>; Thu,  9 Jul 2026 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623947; cv=pass; b=hrepPN+kwfz1pjEnfZiftcVr2E1rngxRH5Hx3wzn0a/uY5/axIJ2ySzczl35FdjWSlnP7bR3ul7W+ZTsVa2/67KyK2KFni17hJWMPoRTvy54vf7Jb1GpEkbQIDi42KNFh09ounrJiKbWaxUddjpjOa3lO70f0x2dpUQNH6USJAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623947; c=relaxed/simple;
	bh=8v3YlXdHbHcSvcXHyg3zxEi4s0QUmFke7Y7jgdn3uao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5LttCmH+pTyy2X7L3hpximXKGFY6c2Lswy6qafHlxZa1HORnB+wyuZr4mxbpaXOpFJrNjHAK7/IsNTtjneVnJ5EA2VxoQ+pGE4EnvAQz9f7QijLxf9DfElXplexu95QzZDcpStkQqoElSDnq0CjDdsqmV8/XATh/MMhaAjzhes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgXixtz1; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgXixtz1"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so243335a91.3
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2026 12:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783623945; cv=none;
        d=google.com; s=arc-20260327;
        b=qjjKQ2LLtdxGVBoLuKijijbIpA+GiHYQh8/Bdycv0cgJnBQZ1X1xg6p54guUioT5i7
         OfJcm8xaq8jkgl8YjIM0tpMhgHlzaJBsjjLX6mogb4iqnT7IO4ySVwsg0AwYVy4BP6Lq
         rLTkN379EVTeAe0/oKDtovsbsmEdpvejpuexGM/ElLD53NjBy4n5firfPm7QgLmz2chl
         ES4YE5lCkt1uxp6KH6UtnRsc7T4gl3lj5kpQCgZ0ww5xD/thAR38qu8PqdZ61V52ZsDu
         G3bBfxlQOfMNXH4cvi/ZdBpamWKpkdK9+LIkJltMiIIhgrmofzQIadZPbeMjN8k68r7W
         RQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HfLxCGC1AnIcwyKKb1GG/Srpfi9K7SOtYU/ActZRkb8=;
        fh=cWi3kW8rsHyAhg0+a/rjvnARy8e1ms2xzmZhoFZJJgk=;
        b=JkuQ3LtfzaOBjoK6/2q23V7j/2+69zdPA1Timrnuv4iDg1ng5mZRKdqw/qIbsDrFVa
         mqVQjl8ThZqFBP3PLzlxs9e8MkC44hwfT3kJGP7mXBggB7oyemATF0VaI27Rz7BJXiNT
         DWJdALWJ2OF8hCpJu3bdEnBHR+j5Y20XOGyEul9iy80Ai+F3lWZ0ky3HrA089MAMC8Be
         zGzLT1J8p1yOjqT5CU1ExUbedufrPLYqE3pN1h7iKzMmsHVrY0DgssfkQHdvHQe3pPuA
         R7Ptd51YIGZ+ZF6TyOv90ir/AK+mvNrrEmgr6oVA4Bihgpi6ORzSo42IQQ/Ini5j2Cm6
         ZD6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783623945; x=1784228745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HfLxCGC1AnIcwyKKb1GG/Srpfi9K7SOtYU/ActZRkb8=;
        b=VgXixtz1Nb8feyJFPuBSV1DjSuvLIs+SuLVGoKU4nWLKFXR3eoEj6LICsq0vWOoWJ6
         I6nH1uWV+g2Cfx6L3owA38TvV6S3C67AUGNZESoubmMw9JSxk9TGPZHHVTgESoZD3KFQ
         k00HXg0m0n6wrTbQoSQ9I2MV2w5+uXYBn2CmZ7Csu+tbwQtKtVghRv2nOvqyzlAl/iV+
         TXW0PoI9PFtwGdoKXw9LFvDof9lVIMbtJdzs+54MGR0WCZDCleMvHTZqUQ/otWRVaOk8
         9J4nvySYxnf5HzNek61cyNY13FKAOoawFqo6B+niqfaouoaSC+nXgin4xTmTSRQ8XyLl
         SobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623945; x=1784228745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfLxCGC1AnIcwyKKb1GG/Srpfi9K7SOtYU/ActZRkb8=;
        b=AAbLvHP7hIeAnnu3bG8CFigon8vQOKio88scL6KeEA1yYv/L0TM0HvicsRaq1p9FS3
         f/SqFP2vrLG8RUEZoLmhTEAaekAYWlwQwC+ar6vA1TScBXOk48JM6BKcwbnBJBaIgutL
         oo8gd9d0CJAT9MDrTHK8EniI26YwGoV7Oc6ffaT02MoTHKwqeVSJR5pck4HNJ7OSL/Pm
         zPhsK3cEp3IjoWXN83UU1oBNzlEzwqg2GZqFJG4BDzZrQAGEsp+29WEeHcv67SRiTM3v
         EJcNcR412c5wIa0SHT1aVHqwnkBGU5eOhbwkoGHdmheHTXgvUhnGsMGTZnEeTHCJG5tc
         MPaA==
X-Gm-Message-State: AOJu0YxLaTWTSZ5EMP2LgFQQZFBWwOYFAUmM3dXMU7vn0XEmv/OqTtEd
	ixuPsAx1VGWl9mCSCjXAvaepiIlQTshUer576kweOCK0CE41hXXC5XQKXmrakgh0V7je6KR1nL1
	dtODv51sedXsifWJRrnyCKpwpuhU+crNsOQ==
X-Gm-Gg: AfdE7cnN2O7sz67qOnxcaPkbeCzniZCBR8FyFrNMKLbq5uMeN+tT5LBW1lkGQ38JdbE
	T1QEk08uhT5qeB4oPNo61CrVn/gbKxULPHliwggS60WIGm7qEbKmLP6YrCScr7Fd8A/E6PmyXow
	iJc6nQimujMAXhk9vskZvN/XMgYYBV2IYLjmzofYmg1UYGEy/VqO/28HknGJA+cx1XSwC916PBD
	Naa4qRkBbpg70cxGd+S7o6FuKWMVMu1HsJtvsbfxaplkJf6XGoma9mGtbS1gRGDl59UD1Ax
X-Received: by 2002:a17:90b:4d8d:b0:381:85c0:1d9d with SMTP id
 98e67ed59e1d1-38942f7356emr8704397a91.27.1783623945228; Thu, 09 Jul 2026
 12:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+jXL7=3=+wxXqm42Q_tQaoeusdUCnwzav_6gF6niAttPZ4ijg@mail.gmail.com>
In-Reply-To: <CA+jXL7=3=+wxXqm42Q_tQaoeusdUCnwzav_6gF6niAttPZ4ijg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Jul 2026 15:05:34 -0400
X-Gm-Features: AVVi8Ccsfqs3QLyyvcERqsUM2ZR4rUy10cl5FUrewdB6B0-QFanNIg85HRUojG8
Message-ID: <CAEjxPJ6oehVAWO47=dCnk7q2-GZ+wkyiKXa6j--PAziPP4135g@mail.gmail.com>
Subject: Re: [Bug] Double free vulnerability at define_genfs_context_helper
To: COMS VLAB <coms-vlab@ucsb.edu>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 2:57=E2=80=AFPM COMS VLAB <coms-vlab@ucsb.edu> wrote=
:
>
> Summary
>
> A double-free vulnerability exists in the checkpolicy source policy compi=
ler's handling of genfscon statements. When parsing a new (previously unsee=
n) filesystem type string, define_genfs_context_helper() transfers ownershi=
p of the fstype pointer into a genfs struct that is linked into the policyd=
b's live genfs list, but fails to clear the local fstype variable afterward=
. If any subsequent parsing step in the same function fails, execution jump=
s to a shared fail: cleanup block. This cleanup block frees fstype, which l=
eaves a dangling pointer in the genfs list. When the policydb is later dest=
royed via policydb_destroy(), it frees that same pointer again, causing the=
 double-free.
>
>
>
> Version
>
> 06159ee35d6b4c968c1f942c9361c111644de826 - current version
>
>
>
> PoC: Please see attachment
>
>
>
> ASAN Report
>
> =3D=3D2502=3D=3DERROR: AddressSanitizer: attempting double-free on 0xfc1f=
82fe1330 in thread T0:
>
>     #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId: ea3a1d53=
43a0633f08393e738125b8f44be83f66)
>
>     #1 0xaaaac9ffd49c in policydb_destroy selinux/libsepol/src/policydb.c=
:1596:3
>
>     #2 0xaaaac9faf758 in main selinux/../repro.c:11:5
>
>     #3 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18) (Bu=
ildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>
>     #4 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-gnu/li=
bc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>
>     #5 0xaaaac9ec7c6c in _start (selinux/repro+0x47c6c) (BuildId: ea3a1d5=
343a0633f08393e738125b8f44be83f66)
>
> 0xfc1f82fe1330 is located 0 bytes inside of 2-byte region [0xfc1f82fe1330=
,0xfc1f82fe1332)
>
> freed by thread T0 here:
>
>     #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId: ea3a1d53=
43a0633f08393e738125b8f44be83f66)
>
>     #1 0xaaaac9fc8a60 in define_genfs_context_helper /selinux/checkpolicy=
/policy_define.c:6163:2
>
>     #2 0xaaaac9fc8a60 in define_genfs_context /selinux/checkpolicy/policy=
_define.c:6171:9
>
>     #3 0xaaaac9fcbc1c in yyparse /selinux/checkpolicy/policy_parse.y:787:=
30
>
>     #4 0xaaaac9fb95b4 in read_source_policy /selinux/checkpolicy/parse_ut=
il.c:70:6
>
>     #5 0xaaaac9faf750 in main /selinux/../repro.c:10:5
>
>     #6 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18) (Bu=
ildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>
>     #7 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-gnu/li=
bc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>
>     #8 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId: ea3a1d=
5343a0633f08393e738125b8f44be83f66)
>
> previously allocated by thread T0 here:
>
>     #0 0xaaaac9f53a4c in strdup (/selinux/repro+0xd3a4c) (BuildId: ea3a1d=
5343a0633f08393e738125b8f44be83f66)
>
>     #1 0xaaaac9fb9aa0 in insert_id /selinux/checkpolicy/policy_define.c:1=
31:10
>
>     #2 0xaaaac9fcc744 in yyparse /selinux/checkpolicy/policy_parse.y
>
>     #3 0xaaaac9fb95b4 in read_source_policy /selinux/checkpolicy/parse_ut=
il.c:70:6
>
>     #4 0xaaaac9faf750 in main /selinux/../repro.c:10:5
>
>     #5 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18) (Bu=
ildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>
>     #6 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-gnu/li=
bc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
>
>     #7 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId: ea3a1d=
5343a0633f08393e738125b8f44be83f66)
>
> SUMMARY: AddressSanitizer: double-free (/selinux/repro+0xed518) (BuildId:=
 ea3a1d5343a0633f08393e738125b8f44be83f66) in free
>
> =3D=3D2502=3D=3DABORTING

Thanks for the report. Are you planning on submitting a patch for it?
How did you want us to attribute the report regardless?
