Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8CD37204D
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886197; cv=none; b=LHwMqZmiTLAz7F2OP8vZCf8njl2HWwxGEkKyDQPoRrzkcK7BqUgh/lDGusQtrMkDRMqmgroMHrigDqY7tWmj9tmRop2N7mq5+oWDIa2Pp0/LFL5v9EwB3RAurbe1ujJFN1MTYOcQj3+4ZnSlhJh5rDNyoTxZu5EqcEIOLyGbkfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886197; c=relaxed/simple;
	bh=6KbUYY4Kud4/SPqyi3x2WMVAQjlqAWpfU8+H8Iqg4wE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SwJ78SGy068oRzeFJagbdjzt466AC59TQVfAu+uHK4NHsyGXd2x3E/M/a40hyRJx9jV/2/M2491Bt9m4XIUiE3d03V7fBMYKL6vC5I+AITB0n97tc9j00s4Af3BvmKFCduzaoMaNfXN4voKc/ZjUH8s+I3vRoumQTE5HxvJI77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPALaJxL; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPALaJxL"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44793168d3bso158244fac.0
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 23:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782886195; x=1783490995; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHk2CYv9CFjND1DA8+37qjWHNRV+096bhWS2yVE+OC0=;
        b=qPALaJxL49eCojqqTZcH7dHmncs/Z/anbHriboVoEHKtv72PkXZU0V5uGQaQ2N9wWZ
         nMp/GCLkq7cY2sl+E5E/scOov1FYElc45jgJ27fx6ejdC8pkUVS1a/0+34DLXzVHEM5j
         piCjbnymC6RWYRuQmTy/BpHobJ8E4w9cdxFYAabB6zrcMKc/kSO0n/f7+SvPDQPZrjiS
         pUgYH2ZRd2f4sWpr4eWfGsC7+k7w/cp+wVhGIBw7zI2zt8gmGpcuA03TsTLaqDTNoMN6
         JI/BEfzJp4aZSNpJ4DG0p4FeEjjnBQ+gDPdZU1OefWVPcZssIrAYOwE5xiQxMiILwdyY
         urUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782886195; x=1783490995;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHk2CYv9CFjND1DA8+37qjWHNRV+096bhWS2yVE+OC0=;
        b=axDtr0RuGVKk+7ItVVA0cR3NNpbc1Fdt6fc/mbGUnHcZIpCOGDj3JscW0bg+r1RmDY
         xeD5BpCScx7vsnoAmI3pj4GvAvDEu/Y/hKpXZ8l69nxv0dHge90SVyzmPYEG6VkHvtGb
         WOCOiYa3Oi4tV2HFzu6yc906+0AIaoN2GY2JyJ4XlhBzZgIseJgeujh5G7y2Q44vmfgp
         IzHyavrr2bAZ4iwwCzSdMscqYi7WoTB95e+zQleZC49svGWOLyMSMqnOcRXqLWYF+Gc2
         Ix1r/Qs2DJTz6kgzi7qLb3hscD9rcpedsYD6luGBlmTM0ELWIs32YnFPVq+xsX2cBej4
         qaEA==
X-Forwarded-Encrypted: i=1; AHgh+Rq6ZQduHILwC8sLGYd9tA6rFQFYh/MO5EHfrP54fRtOytmi0+w4nnfSD0gxEDjgOBmoocmkGjGQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtn7DRLZ77UVzPGEGniusaxZeXGRswxEuBvyEowEm3GjNZ3tJB
	UHJl6P2b9RaC+qKm2yBegKlBK2JUP2oFv4mBDYak8IxOcmRnYV83IyG5
X-Gm-Gg: AfdE7cnqygK0c2tAqKDepEOrcXZQ9qdpTGCYnsDnKQN82FXz7MK2o9KydSJ5SQu0V+7
	jkHvaAlTtk65Yj6H7UxsSwHSmNBidhJ2QKV3gRuiJaIhR0kYR8a/7ybtFVDfod8xevJmfO55+/q
	o3m/F/6ZmveANltTkyoCmVs/D2bKK7xY0o+vL/Lo5PRXS7G5Eb8UhOR37ME9+yIb0b6Lg6CXlVT
	H9cTY3sYuZ8KFX0z9G8/3cZYJ7J104cBBgvX1dMJs4q+a3gkGMU4mUHcfMbk6KC/yn7scOOzz4I
	HG1b8rvv6XdV2LKr++3MR/i2OvlAR7eV2IzyO/1eKgBumbcRMFLNjuP0wcC91v2p3xGOxDOZy5a
	E2n36PtutWPp9eWP+lgfUVQcEkIcPgxtmOukmNgbMFKMWlAUJFZEWFa/PnXQnpKvIwOPe09fPVC
	wcvG2Os8IePEexo4EbuZaxkaVE01I4sRKN7UToUf8B1+m3B/EoQ+jIAchKkXEyBucIaRD5mkQjU
	PXhXf6Rqwy3LQ==
X-Received: by 2002:a05:6870:9e83:b0:43d:5d22:4719 with SMTP id 586e51a60fabf-44cab961fa0mr69097fac.22.1782886195152;
        Tue, 30 Jun 2026 23:09:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44c62027e5esm886593fac.9.2026.06.30.23.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 23:09:52 -0700
Message-Id: <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Matt Bobrowski" <mattbobrowski@google.com>, "James Morris"
 <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "David Windsor" <dwindsor@gmail.com>
X-Mailer: aerc
References: <20260630183956.281293-1-dwindsor@gmail.com>
 <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
In-Reply-To: <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>

On Tue Jun 30, 2026 at 12:20 PM PDT, Paul Moore wrote:
>> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
>> +                                    const char *name__str,
>> +                                    const struct bpf_dynptr *value_p)
>> +{
>> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)=
value_p;
>> +       size_t name_len;
>> +       void *xattr_value;
>> +       struct xattr *xattr;
>> +       const void *value;
>> +       u32 value_len;
>> +
>> +       if (!xattrs || !xattrs->xattrs || !name__str)
>> +               return -EINVAL;
>> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
>> +               return -ENOSPC;
>> +
>> +       name_len =3D strlen(name__str);
>> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
>> +               return -EINVAL;
>> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
>> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
>> +               return -EPERM;
>> +
>> +       value_len =3D __bpf_dynptr_size(value_ptr);
>> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
>> +               return -EINVAL;
>> +
>> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
>> +       if (!value)
>> +               return -EINVAL;
>> +
>> +       /* Combine xattr value + name into one allocation. */
>> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
>> +       if (!xattr_value)
>> +               return -ENOMEM;
>> +
>> +       memcpy(xattr_value, value, value_len);
>> +       memcpy(xattr_value + value_len, name__str, name_len);
>> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
>> +
>> +       xattr =3D lsm_get_xattr_slot(xattrs);
>> +       if (!xattr) {
>> +               kfree(xattr_value);
>> +               return -ENOSPC;
>> +       }
>> +
>> +       xattr->value =3D xattr_value;
>> +       xattr->name =3D (const char *)xattr_value + value_len;
>> +       xattr->value_len =3D value_len;
>> +
>> +       return 0;
>> +}
>
> This is not a generic VFS function, it is a LSM specific function, it
> belongs under security/, please move the code as discussed previously.

Paul,
Not quite. It's all about xattrs.
Having "struct lsm_xattrs" in the arguments doesn't make it lsm related.
You needs to study existing kfuncs and tracepoints.
A bunch of them have "*lsm*" in the arguments.

All,
CI found issues, so this set needs another respin.
After that it's hopefully good to go.

David,
you're on the right track. The patchset is getting close.
Thank you for working on it.

