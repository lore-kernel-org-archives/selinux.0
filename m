Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD87453A3D
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523334; cv=pass; b=uyBWsuuAcQ9NycQQCgMkkp7iUG24qYN/QyR9KJFHkLc2iJXezDc1kJJ6CVc798f+9iTtrAp2Aokn+lFPY3L+I7dI9K8NRm8veBVJIFRw1cXPgZWoFaHMGlZyexpADuc+QOV/dLEgYDpaBausnnAcaSUeHVB5K2j/v9xE08GX9qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523334; c=relaxed/simple;
	bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNKyI78DcQn7ZgBLsOCmiJ9gpHXydX6a1sx0QQL6XifTofD6iOMwX6T0w8lZfWmjJrKZ+q+N1Z5JCCgXg/KOnDbt6ezmAGpFhVNZK+fiuD/JRIyIqK0nlfiLuAj9AfpEP8LJoCXwijgv4H7N+DrafcIzys1BHailyB8+RfSpmOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RnJTn1gs; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RnJTn1gs"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so1293757a12.2
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 11:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785523332; cv=none;
        d=google.com; s=arc-20260327;
        b=qleozYJH7AoEdJ0aIt3wug7lScSc63A3jgjlgMDrYyagmu4tVEqICEPmCk+RE1svX0
         fsZLCvK4wBZQAQwxzMYt92p+LgRcM/dLRo/eFPjD0UAkREgzPsR5yRH4W7jLn+WQKWBe
         F2O58SmyMkRjUVu6Hb1Ldhw4IVnGMVDq9CMGqtbppM+w40G7p+1Hr/0U6jLg3S1UjGts
         IdPLpuzZxAw4fIU4AB87e+JYJ3Sz7s1EQ9LSxSscPo/nJgwXRpJvsjzqCNvTps+baDA2
         Rd1ibZJNm5G46r/gFfoqNGmZHXqmhnjtSPDuj5tIgV56v09io74pf7E5SYoDJXeEXAEx
         E3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        fh=cc0+GcfHmv7fhQkQqV3DBFGE6JgywjJ9dLtMPtkNOa0=;
        b=X59kfUdMZ60p+OvKuXVLRogbdp664xgNyzCRax4f08pTyjHsHOE4AGcft+ArOQiVQP
         PJIasqCnZd/8C32ptca/EBoRZkizYsfEnIoK4bnV6IguQ5Dyu8dYx/DeW2eWCXiCARhh
         2JphwAAEK+AZ07feGGeU9K1UMEtx4U0YsNyRd6EuLmq13Lio5zscR0OPKeD6ERypWzlj
         Jd8z7zBchu0bVQaXoh4OLMzFqdvOQvmPHxbGzTp7y6e9bI7mPVEVxRjGtMOsAZYr23VC
         PlanZHWlUH7jWpvTMCkuSXCPhiQGzfoeiKv+C9rJ2+/GeLsRceCWJ8XV/ySZwLeHEVkT
         Df4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785523332; x=1786128132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        b=RnJTn1gsg8Uvh+FH/JN6RNrus99YZFL8IUWO8gsTbGhi7g5TdULCt76g6yFSun3eam
         /fzTn46vxP0Z0X2fnq7JigzVRr/xdX/XHA70QC1cy6h1utGmvhKCDLCFoQ/RNBGOckvg
         97y1yBejqtJ65K2/0EWVzZaebgnnON2raioNwo1ai9KoWhm+MWWt5xCgxgPjfqBM7qFe
         QNakghMFv/aMxbH4adDhNvmjTErcD+whz8nvTCoYiABhrlNcPPUHkFIIUASoypBphT6V
         5dD86q/GjkETaPz+Oh4RXhVxtcD3gzD/ealPGd28IbQNTXDVihOUC/6CdXG8SsU4bL+x
         ODBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523332; x=1786128132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Wxcziuaq5iqoUJMOxQXO3dIz9aa5Vn96onhFBf6rhY=;
        b=XCVGvYfIFWrf4O4DO72lQZbuEoZNT86ZRPKrp332ZS/99O6giyOI8J4IKaCbZCvd7T
         cnsN6IUjfiaKvozrCTBL29jlxGPsTY/FRPJmIK375s0ewc98I1htMAW+XHkehR+kvsX4
         EY+n+314g5bjYAxoFu3Qn3OHy+vsihRELDwTZobow+9AFWgc/mspuhc6akapvWl09Qef
         2+GBtYwMiG5qneDEtvK7ntNEWQSHzQ9FNfjzEWdlNLPaHvfbBHeFqjO3PizrDQJQ4MJV
         0S9CY2IN2C1kzvjwj4N91ghyFHGItP3U8K46YSZvctRX5vfEkAkdL/LUa8/0Ix2Eiy5V
         6veQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4vV4iqwx/ob+deDVeWPM004zD6elzZYOM2sh63fui4ZlWQa/Y0DHge80n1mIA/EEDNTHx5Vgt@vger.kernel.org
X-Gm-Message-State: AOJu0YwihSrnH5yKmI3HcC7jYlZBx8Nv5Nvp5ORe4lF3tk7YsEqLf17L
	JcpHpbqDgtMjynIR6DoruOkE+eRotX/q5JVXKQi45KAYvmryWThAoRMXvMcpMM1a+kaCttrmH2k
	rJFhoIuTTLaN6GykvzxMq4E4LxMF+302UynbPT1Sc
X-Gm-Gg: AR+sD13qbCTl8aEcA2egZdCfCMyWk8CiLP3XdciwLq2UlWp8mbXWmNsaGR3ExTRUA+s
	yXPrSVNNTLDhWojXyeskOrVCBEb6zKLBWf43uVMTHB+xhPjWYh/O/2oYHz/R/xbwa0R4GKOrX9w
	DBBAKmw3joX9bUVqunAEToY+OXB9dOrkaoGBSRswwAEORQyqR0IRl1jeaow1Ewq5h+BLh/VTyiV
	fhZ+On1gqnO02K+Yp+6mS5EcGcWr8AnPOXO6eRT1EgcM3aauAPwfglqLPKUNlzQTxufMLIlS/V5
	rzLLLUK43SzIMEx39TrsWLU+7GNQUIY1JNG03MYccZFcFdLS5WV+zSU=
X-Received: by 2002:a05:6300:2208:b0:3c3:ab31:3d1e with SMTP id
 adf61e73a8af0-3c92a8d3125mr777248637.56.1785523332205; Fri, 31 Jul 2026
 11:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com> <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com> <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
In-Reply-To: <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 14:42:00 -0400
X-Gm-Features: AUfX_mxuliCX4ORjmGWbiior9WDlNPKrwS-oHeLLni0oyboDwl_jDraty6suaKI
Message-ID: <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-mo=
ore.com> wrote:

...

> Yes, I understand you feel it should be placed under security/. You are e=
ntitled
> to your opinion.
>
> No, I do not think the newly added kfunc is a big enough layering violati=
on such
> that we need to do it ASAP, disregarding everything else outlined above. =
I am
> sure you see that too. There are several other instances of similar kfunc=
s.
>
> Therefore, please attempt to meet me halfway here.

I'm happy to work with you, and/or anyone else, who wants to work on
finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
