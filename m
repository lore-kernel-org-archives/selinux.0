Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9B4418EC
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512205; cv=pass; b=m+bbIhErI6zfssQsEyqgxQFEmjVZiYAnSskbU6ihRxbiLiCXiT9JsuzyABCiO/+6MKQd7lXBfNU/sfSELK/z0ctWxyJqPUXMdLzgYmOJMzW28zCSc/syURLYHVZ8fp6BDqBL02BZoCoqNRTPLfW5s/YnWOBX+NQAp9+7weP3z6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512205; c=relaxed/simple;
	bh=kPzEtdgmgmrhfEvclMUzFEFQMW3YYfNU1BZsWa7XSjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGowC/O1oXnOdfDV0/zwjtwJ+osNGFNSREpr+hMWK6opS5WsDYwfPoLzRETgQQfExsqTLwIazlUU8MrOiIrEjqlSCl9LHmjy2B3SZ5FJGH2RHctO5Rmar9TOtmv72RJ8sc6oMyeM2Zds4q7/h9LVtAlxVOYNg8wNjEf03XppfjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFc/OdTg; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFc/OdTg"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c08df8513so6398561cf.3
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512203; cv=none;
        d=google.com; s=arc-20260327;
        b=BgXe3D/ldBJtJcObM73WM6fOTEGnnSNjRCPlSv3AUJm8E6XlHSVgfKoSE/ySuugeMI
         ZRiDoEDf/UwEXeA0+BcWjoDHdwtvuSLtfEg2Ka97vg744NAa+Dugj7g5u2KQcWEJgs4n
         13NGFEr7OUMkJHJRjyG599iBWGhUjSQgzBB+Fmq6spGm1i9ouK3YHNDdofZf4oMgL1qA
         WdV8K38dwUxF01Iiw3mAA0aTa+yT+ibRSp3FC0xEIDRI/CHsRGnexusQSfWhESMO+VMc
         3LyOeEOZX91DSvcV97mNKtSU3fALFy0yhpUV+CpXDnbxF5JtgrGSLFhhBW0KDswgQJYv
         PAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        fh=YZ/pBJEWt9r5tKPZncU4g31CGjfGnlk35QwDhNgL/OE=;
        b=cvMGRArQuqSdE6SWsQ0akGwnR/JqgcOozdHgJ7zs8rO/vMSlS3EfJ1typCpjF2M6yG
         jsnUZpSQ9ImLzB1lcEjR9Cc52hAM5g/TA83cSgRosRyeKWDXvzK1Ows6YIwpDe0iX4hl
         DeyT95D66nVOUyvIhc/GXdQablOZu/VQTo43ZLFN9ahrYsMK+k+1YVIWaeVTTtIZ2sVm
         8zIMoeXZI6meSz/OmiE5AlU6YzT8MQVKzPfs+imIjke7CJ4rGEKtbRQFCrOXWTZNwQKP
         An/aK7i22AFh+YP0nGlZUurjEniuMS6h7cOTdDDeRqzRMu/mBSPlGPcAKFD5h5rPBSDn
         eWxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512203; x=1786117003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=IFc/OdTggyxdx71WMUkmunfFJv/VBdRsML2egv3SAZWPQsqAefG+GCW5wF/exbuiTa
         QR7uGfe2g2p08Fxi7cbO7yEIIN8XKQYDgkRTTzsgAQkPuO3SGaSSiGhnwIgPexrOySZa
         +pZ+yNZlpxVkvSZoEM6zMPBqP0Vph8OkXnbLafOl4HbYSB/gXqgS0me72Dh31n5iZk+V
         2TfcgprOH90j2Y/h/YyQJmhoWqYtQXHojL9LdYazVTSYgmVIeG3kvXXY655TfaDon/Hm
         OOzMc1jTW2zPFrgbpFNTk0g5clcA9sqMzcETIeySBrsKVqu/NoYYyuQ5t9XCId0uEIcl
         kJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512203; x=1786117003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=W04NT6N0e3Q0Kf+Lh0fDttAwclEW7NShanMLZXlzFwToX7CEQ6OQmaR1zQ1t1j9LWt
         8EeclEug4Y6N6okgr2tVKD8JH6cRrNZgonzXEXZFW6ULSMPFooNTpBOzEUrfJ1wtcVMt
         eLpHSPgseHpMrkLMZAYF4TEZtt13GEF3HW0nBYV9oVjJ0NtpQ8IRlCPZyUpNl347mq9N
         UhRdQJ4sZjnIrCwM9Or5DFlXsc45pUC5iJK316+AiJo3tsnDhXFXkUz9Mp7LDh8LCK1o
         R60B4ukf3WKMS6UW0b6Gb8KEz9hT/6Y3w9wFJwMJSrEOWFKRZYFGsrPgp8fCQydauBen
         k5ew==
X-Forwarded-Encrypted: i=1; AHgh+RpIZNGeMR+W7RMIMUTr6wNa7kTV7NGo7EScHs41ofwiU5hTA6n0f+m1JYqUwoKW9uGA559r/jiN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8oQB0cQQj8hAGHDV+tIpEl/4Zh4XxC3iRlzAktdnG3CvjAxVr
	kPI3rOwHJZYdzej831euSgLUTmdYNcjwZSsa/5hRzbb6Y6/RRJDc9kcze+6zFFt3DFgknp0gnQH
	IEgsC+JoFFJ9m5Bg1FKKsWRQNCqftFe0=
X-Gm-Gg: AR+sD11DPW+hNVWEw6Xegw4m5VD2/a6fvujoc0PPcYOfGf8UAfXlru0OMAYOXRTLIPs
	YIgpiklGoq/ctRgaVItxIPvyXPbDXz+0N3cQiB0XRvj9KNpPTYuwiRHArCpeJDbD4gDQbpb1OHj
	19GXb+pdPfqgPunSdoLb4bRKsDLjAEAUtX1aMJHiVxbqITqnjrhMYhPW3Cj/PUGA+fHcQn0CQwi
	dHBynGtY6q5eySRi+4WFm5Lyhu3I+wXmR60/nrJTS6OKM4d7qTzuhqWqbVHEisXkqC462v0E43I
	m9J0Rh87Cq37tU3uCD+d1UXqBxXs+5uQNEmuMTiVCR6rqX6mIEb2FiOrEhpWIdLRgDucPWOSCAQ
	=
X-Received: by 2002:a05:622a:1e0e:b0:528:3c2c:5c72 with SMTP id
 d75a77b69052e-52b5679527amr12582491cf.32.1785512202948; Fri, 31 Jul 2026
 08:36:42 -0700 (PDT)
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
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com> <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:36:31 -0400
X-Gm-Features: AUfX_myF-Fa2Dx12J7XG4FMqMoM3YLOYocj4Wcd15kosvCgWFWfK34tns1g5ePo
Message-ID: <CAEXv5_i+OOJqr7xb02=5JMR2O8soLJARckG2CK7yvcv2Ycj+eg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:33=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Nope.  That patchset has its own issues, one of which is the location
> of the kfuncs outside of security/; I simply haven't had the time to
> review that in full and reply.
>

Makes sense, thanks, just wanted to avoid churn if possible.

> --
> paul-moore.com
