Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E83812D2
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540940; cv=none; b=ZORYyei47pq3lDvd+Bkp8ofisKglhqpxJsNvlWCFROewIQFsCiySuRmZRcUW7Zje81SguXMSR9586SXnuJzw6asn/FX5Nl6v2Bczt3mVKiSnr1737Fdq5zh4D5N4j5quYylQpuNZD31CREE432r7AZk9TJ8BCRvxxtugPjY8FIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540940; c=relaxed/simple;
	bh=E7AD1CY3Sv52g2oANantVmZ5L4EPUbRo2OwSiRw2zRo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=qvjZeBGx25RQrUH24HGFCK3R6exCaW8wHbO/dG7VKiwXpH9b7wBfCVkytXnrmv3hZz36Wq7DUVjh7fl/8Q47xu1qU0V69sTk/kyR5cTTGJwrfkmhw2+pVwyf/MpO6dpxuwkm47uaocZZbkm85uw8B51JybIwFDS2j36/V/WhyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRMc5/Hk; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRMc5/Hk"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4955f00e593so867795e9.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785540936; x=1786145736; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NAH7LZBWSLN1vfCOZsndZVsDBYzJNfOag1t/z/WjVS0=;
        b=hRMc5/HkH7EAo3d6JMqtf1CusAWagPmDZh1+2bIF4ntX3h9LCW+ETsiJ1lTyPABKoE
         FCXSkciHGOZ0F0WUP1p8DSuAI4xTYQ7AwIqATxrEhnKMX4gwUwJEzhoRrSqDKGNYDnBO
         PeBn/yXq0sXOmzbZ7tAQo1qGbC98+acngNaysJSaa/22qoz7xMKiIfQtvAYUdbMS3gK3
         XPD4U0KrXX2sr/uucqyMh1J0uaJDVEcaRGXhKBIOXBi0TLMMP1ETP09G+IA74ifDLJ+a
         LQVnXKmc6qDNeWa3TjMDTHWOUSWmz+THeOpAHC2C3mjuK9ZRIH058RGDTH+qwMa0Y5sI
         LqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540936; x=1786145736;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NAH7LZBWSLN1vfCOZsndZVsDBYzJNfOag1t/z/WjVS0=;
        b=odJeaCjMoWhcVRCzB9I3g8qpmSiVeqzst8IgI7mvyHsUW8e43S/V3Ob0fsSJvPL0Zb
         Y5kNbJdjwsqyS6t2ONTvHqwM52hTrxE8759pBX9O0Zg/xtcrrT+YIN/EAJEUOf8jaEOL
         W6wcZRE0zblWpd29AKzhaa98IgjIYzLPbHRq9FA6F9B1dphmzn2iloleor6YPBfhPhqC
         aVPfPN31qwd8n7eH4EEalY07rlg9/WOHzGzkoDFShQkF8P9jki6wd4iK5Jd1iu7Q7HVK
         e5fhp4DtwwEVIyYXreYFLu3XCjVQgI20KY7c+v+887KSJyzvaQFVY2si3UnXvjSkmerk
         4wMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOSIkf6eK5JJCGkQe82wdnbXpzIr0wT1L7jNvYaGeXIcfYlrhM9aTKT+44NRWCaEVYAKWR6/9g@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNu+8IrtlMsfJD6/maqmgnMixQYLjn2wkHPxl5ymp5DQ9FXQY
	1IlU8vckyn1868GRqcNPtZGzXnC5KZwVXDy97bqbMTz+8czzsrU0SzM9
X-Gm-Gg: AR+sD12mD6R0n6qfpxyLmqA6lVz4q1s6EfGxIXYmTYQK6vPrUapxmSCQfJLNbqp6miD
	EaZ8x76u9iFnxm+4FLuHr0d+Vs0CgW+D+N2SarH1ySzAYKwMtGA7akQ3Inat2zFT2AAStgZ9x//
	Aj4MxdnmOLfyW2EgO1j/bRcFS69K8a/0TIz1LF1dIiHP/+AI6PuBv1wclovHkPpnNcaa2d3WoQj
	ovwbWDXVy5k88F8HMHUwF4Cs44vWiqD65oB3/wHDJZq+5JMluiqlXA0mep0+ihrbGYw2dT962Hu
	r85UB5p8mZ/Af1y+2lO/MuAMwj2D1npaEF6YUAY7fyv6mDNVVJr9Hupmws7hN0Sje1U59a0M4Vy
	3oyfb3b69HcS50cwgxOgIqoEp34xUah/1hgJpeczJZJr0I+QRZVBph5ohEJJ0vOeQ6rTMtRy8Ct
	dF1x8mKlhhbG9A6GJtP+9R7OZSnkj2bMWi+l1s+aljmkLwZxq5+v3+ySPd1l33dMXVj3y4U4iMM
	YJdm0UddgPY3A+BLQu+mJJVx6+iFAIh04EoQ6i92h0BxDluHpVNO7tLS4UifxrmSvhNRy+LDYGB
	rkNUWvCnnSiLZRG+Xin9dPxxhFzVOi5kv4JIbg==
X-Received: by 2002:a05:600c:4292:b0:495:406f:dff6 with SMTP id 5b1f17b1804b1-4980c68e114mr998445e9.33.1785540936415;
        Fri, 31 Jul 2026 16:35:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm10260172f8f.4.2026.07.31.16.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 16:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 01:35:35 +0200
Message-Id: <DKD5FPZ03IMC.294CDPH0KRZGP@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, "Paul Moore" <paul@paul-moore.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "James Morris" <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, "Casey Schaufler" <casey@schaufler-ca.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek"
 <omosnace@redhat.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
 <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
 <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
 <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
 <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>
 <DKD5ES7LKD1F.YKD4OU6GTUXR@gmail.com>
In-Reply-To: <DKD5ES7LKD1F.YKD4OU6GTUXR@gmail.com>

On Sat Aug 1, 2026 at 1:34 AM CEST, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 1, 2026 at 1:11 AM CEST, David Windsor wrote:
>> On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
>>>
>>> On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
>>> <memxor@gmail.com> wrote:
>>> > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
>>> > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
>>> > > <memxor@gmail.com> wrote:
>>> > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
>>> > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
>>> > >> > <memxor@gmail.com> wrote:
>>> > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
>>> > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwive=
di
>>> > >> >> > <memxor@gmail.com> wrote:
>>> > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>>> > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dw=
ivedi
>>> > >> >> >> > <memxor@gmail.com> wrote:
>>> > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>>> > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya=
 Dwivedi
>>> > >> >> >> >> > <memxor@gmail.com> wrote:
>>> > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>>> > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Karti=
keya Dwivedi
>>> > >> >> >> >> >> > <memxor@gmail.com> wrote:
>>> > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wro=
te:
>>> > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Ka=
rtikeya Dwivedi
>>> > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
>>> > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Winds=
or wrote:
>>> > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul =
Moore <paul@paul-moore.com> wrote:
>>>
>>> ...
>>>
>>> > As a consequence, everyone suffers because they first need to satisfy=
 your whims
>>> > on how all code and kfuncs written thus far are wrong, and need to be=
 moved
>>> > around ASAP, including the one being proposed.
>>>
>>> That's not a reasonble or truthful summary of things, I've only
>>> requested that David locate his proposed kfunc in
>>> security/bpf_lsm_kfuncs.c, I never suggested he move any others.
>>>
>>
>> Looking at what's left of the kfunc itself, it's basically nothing.
>> Everything meaningful has been moved into security/ already.
>>
>> Aside from bpf dynptr ops, what's left is:
>>
>> if (!name__str)
>>     return -EINVAL;
>>
>
> You can actually lose this one, the verifier should prevent passing NULL =
for
> name__str. Other functions don't check it either. Feel free to check it, =
or add

.. and I meant, feel free to double check that passing NULL indeed fails ju=
st in
case.

> a negative test in case you're worried about it.
>
>> if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX, sizeof(XATTR_BPF_LSM_SUFFIX=
) - 1))
>>     return -EPERM;
>>
>> if (!xattrs->xattrs)
>>     return -EOPNOTSUPP;
>>
>> ... then a call to security_lsmxattr_add. Why not move this chunk into
>> security_lsmxattr_add, and leave the remaining bits, which are pure
>> bpf, in fs/ for now, and litigate the total placement of all of them
>> once v7 lands?
>>
>
> I wouldn't bother, everything LSM specific is already where it belongs.  =
That
> said, your question is a good demonstration of the absurdity of the ask h=
ere.
>
>>> --
>>> paul-moore.com

