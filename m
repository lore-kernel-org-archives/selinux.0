Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534143CC332
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572218; cv=none; b=rRb29AQJlX0/EOTYudmBKtsodUETgLlCYI1g3VLDg//EX77x1sw+YETz0yXeef3GZazB4tnEcbXNURypT/c7QX8QrddKGkv26clwMgpNyElyZIXNs0CqV8XmAqQsRlFevm0Me42iTz0EfLTWPGuCZuZzeKdFOf0WiG8AxXzJc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572218; c=relaxed/simple;
	bh=OwznwCCL51DqvpfNCtpfM2jVCP0UbJ8x8niEoEDbl1c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eLm/31lPN0NUiOHKYoB/z0kC9ax3GUw9YTgIH3TGAMU42hIMogIrwqoKM3m/RQsfXks99Adf5RnCSY6SYxwzqsjc2pxWw0Zncl/SRzACLskPheLqU0O/wh1C8dE1hPkg6HPAVkXAggsgCbQf6d8ywd8lu32wP8uiDv70yiBap+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJHo0iPx; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJHo0iPx"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46e260f9e57so2499161f8f.0
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572215; x=1785177015; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LvO6UAbRFcGCSjoBuZmDbMqs86kUUw9tJDf3lq23ABQ=;
        b=MJHo0iPxIH3vbeR/eb3ZK37zC9/W4Xhpm5/kuTAKx8kN0C9YFsg6m4mmlVYnYxdrgx
         sfF3XDvy9CUrh/4IMV33rdxVlMHmOvRMqIdT4+OJuFdcu+llOt2LhDKyS0iT48IRk+Em
         swZ21vGyec0YAU9Gwo0aIiO/SCqQeTR5UMSqPqpxdMFw+z0KJRKFc34BHVxmP+tI5DCG
         rtOZQURBk+tWbA/SulQhuwDiSNXDt+h7nFFKHLsOdbnwQFUJMx4RBYDcXhLuxwuslSxq
         SmgyxlmNuiAgIf8z+fNi69KN7ox9pAIQqr5dBsTqfMteAfWrbKtQrYFv+1mv6Re2oPUt
         gbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572215; x=1785177015;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvO6UAbRFcGCSjoBuZmDbMqs86kUUw9tJDf3lq23ABQ=;
        b=AwodHdiUMpMd8997sb8I681382NO94MVBHqjwKErT7tV5VNyKGqDORtMGmXSarFhBL
         loq4Y/fMWksp5tm52JPNeAELPHdzrDnSaYUXvLRTweCdWYLVoF32gG5FQX6Nk9/GDyot
         iEO6CvvTFMrSyX8zgFjhVj+xNTD9mixmFAYIfD/ts+AyrYHLkbw223L6+zlomMMGzqhV
         GPhS8fI7nhskOdcsG00xFEVNOFuH08n4FqNiAL7sto8h8r/ytq4qx57UOmRJkIhQDZhT
         RFYjd221CgTngZP1xsRz/FDgaOOdjuBnIlOtcDWeTMCQlGpxIACVtUpYgnsYurV/74i9
         QmsA==
X-Forwarded-Encrypted: i=1; AHgh+RomW9gLUN7kAnWwEuR02fFiJZAjHtALrpBKqcdAKMAMphoio+G70TX0zYTgJu1NZoAwYiVfDo11@vger.kernel.org
X-Gm-Message-State: AOJu0YzVPHPcuKiiOv8jPx8jsbDx8oIY2Dtyy+9m848qdESNhuiSAsq7
	67m+41WIC8XT4ufcvH52QP5MdnKPRsKsPOuSQs1H47oebuBR4AUNazo7
X-Gm-Gg: AR+sD13C3a6wHxfVe8CBiT1NPyg17E/Enkw+ql0xHQbSvN5xxfzeu7r0mz3yI9xZFnX
	UeQmJeEGKUXAxxPrRxyW6aPhnwRxEANwdPORb3Ztxz0IzdLV4xcJfpyplxFZjNXurQTKKgMT1dx
	uL5/tO6cSDghrjjlsLQRVjZxcKZlWX1FpGwuPxwQkmHiXSLmEa7WC4HbiV2DFuIWV4qf+J1PLkn
	qNQmPRpmmaBhmXhgTgDRJbQmHm0YDZmRHdbDucvbKm+LSSX2vg+XqYJZp+CpsD5KVp1kSNNob/k
	VdpNLf53jzCpDnfNFDbf0uFrHKJt/5m5Vlf7ZCHa1fw7xk8KG7sTib1dz0DBiVNCYrQ/dJ3ZJDj
	tt+glN6N/C/Coy3sWQ3P6t6S0ge7hNETAZutgnRITW62y2epk8VzrYtMCw2zmoxzeZ2IWIOl9U2
	PuPIcD5KbfgRU1X1O0iGyrYX8NuyCfGp38Epw8Ix0QOkDjsrob5UBsy9Lb77HZecI+HnLfC6Jk+
	kDLx8pisyQxb/WlEoyNERkB2Pui11+mCEPbWk7YuVS7H2M2sLBb50g=
X-Received: by 2002:a05:6000:2385:b0:47f:756f:9a83 with SMTP id ffacd0b85a97d-47f756f9bdamr7960451f8f.55.1784572214440;
        Mon, 20 Jul 2026 11:30:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ce4sm32759891f8f.8.2026.07.20.11.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 20:30:13 +0200
Message-Id: <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Matt Bobrowski" <mattbobrowski@google.com>, "James
 Morris" <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, "Casey
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
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "David Windsor"
 <dwindsor@gmail.com>, "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260708000956.46138-3-dwindsor@gmail.com>
 <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
 <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
In-Reply-To: <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>

On Mon Jul 20, 2026 at 8:27 PM CEST, Kumar Kartikeya Dwivedi wrote:
> On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
>> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
>>>
>>>
>>> I'm sorry David, now that I'm seeing this function again, especially
>>> with the LSM specific bits extracted into a LSM function, this absolute=
ly
>>> belongs somewhere under security/.  It's only callable from within a
>>> BPF LSM callback and all it does outside of some BPF pointer boilerplat=
e
>>> is call right back into a LSM helper function.
>>>
>>> If the BPF maintainers aren't willing to accept that, then we will all
>>> need to find another way.
>>>
>>
>> Where this code lands doesn't matter to me, so I'll stay out of the
>> decision of where it lives.
>>
>> If this kfunc goes to security/, would we also want to move eg
>> bpf_set_dentry_xattr similarly?
>>
>> I'll roll v6 of this series meanwhile and we'll see what the BPF
>> maintainers say.
>
> I don't think there was any preference expressed from the BPF side. Logic=
ally,
> one cannot be faulted for adding a kfunc to set the xattr for inode in th=
e same
> file where similar kfuncs to set xattr on other FS objects / entities exi=
st.
>
> The question about bpf_set_dentry_xattr is thus valid.
>
> Anyway, I will leave it to Paul and Christian to decide between themselve=
s where
> it makes most sense for this one to live.

Also, perhaps it makes sense to use set/get naming for this one too, to kee=
p it
consistent with other ones?
