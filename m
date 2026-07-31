Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF124418EC
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512680; cv=none; b=nsS01GQcmTFlgda7tDm4zi+m2/6fO3542xaOjRJL77QxeI1HIuj5p8k0ck0zSFvY4zCpSN0mg9EsH44tVRSVVgvWC0+nBN+vVI6rbGUsIXogS/2Xp93yVQcSB1Gu9HDnAB7a1upyhmFrPQyWdDPxqVggnI7uVlICaIxS6VKsGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512680; c=relaxed/simple;
	bh=3TMU74QWZoDLOURmJXG/MdRKhkJLQUmMeQBO4XyQ9QI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ir0A6oRaUtPaz0OpMGaTwI+r64eXFyLD+arQ7AkJoP9R/6YZVo6kEwNWs9vtzOr+2NNyOAh8KBUxo9+TmdD/WJpvryoMsfwIhniIUDI878nCwBaJ9YOI2rp9DlZzOWnJEcg4ZhJHx613DoRGDOwcePNcmn3SvQnRfZHrqKv8238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUAjuzik; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUAjuzik"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47f7f93b3d4so338929f8f.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512677; x=1786117477; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3TMU74QWZoDLOURmJXG/MdRKhkJLQUmMeQBO4XyQ9QI=;
        b=BUAjuziks1o6IcLjjnCNTj5ZPOZq1/j9neEAYN+xFL8YvZJ0GabVQuFG+cbmrX1GkQ
         /HD7ej+ToDjie5K4/X3LT7FTVDTBUetjvyHN2PELc2rOSvdxHOFR7oGdotXmCpZI5SVt
         NJiNy4ozrOkKt28Ma8f+6NI11frL1BRQMPC63a9yclHwLR8PnVA/tQrLAp89RWTGAi/X
         dfXdGUA57Rq+lVKKu7SLl4hvArDlAsmwa5AVfNSzepQFd/0fJp1mrELZSKJ6M8U0A3FM
         iSPSp8HSZ6MYbAkuQejlwnvCUKRRk9c0wG5kEXDwR/h0fAfnPe271m5pmCOQ/p9kqsV+
         JtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512677; x=1786117477;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TMU74QWZoDLOURmJXG/MdRKhkJLQUmMeQBO4XyQ9QI=;
        b=CV6TtSJgQ3tv0WURqCA533rqg6w6Dzjk6jY774eUnz8/zovhkpo9NGUCWTA+FsTosw
         K9N8DCJcICQwrLQtKwm66JFBqIXiXgej5BgsAoOVRhnefAuQGjrxWViIF+PWNtHE+t0L
         n+BkT92iv+1nZIcigyevRjQOJH1LAo/rEtq8HN6/79QAQJY9Xm1EpYh10Re88kO58P0e
         p7+kkY812q2hchcJ/0nanDdNQwkffrj1dt7zPuFyXBMacnJGM8gVdN3FElf6NOvqXvPy
         0DojtWZVZ61hwQJVP7UiAIhtZkVUl2WbmBVV64QoiibjTaJIfzaDVngMNMY6JDJZSVbM
         eoOA==
X-Forwarded-Encrypted: i=1; AHgh+RqnL+Sqv8ULM9Gp8Mx1mduMKtAFiPUBycExA7iJ2Tx1VJ6QD3Mvr5WY8pw5Cy1+3JIEQ3pXcsjQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcUKy/PWYQypEztLOwLzJOJqcbVl+OjG9eFlujhnBpVhJt9LS
	pqr3ybp8MSK1GOp0Gs+1TIejUgknc+CFcD/eh2HTWn58Y8ApgAPu1h/tTY9xf5ji
X-Gm-Gg: AR+sD12hmrG29+YSCCHHRrWanxODOdzumOnWAjllwQSTd2LQHFELMstjn7RVkl4XF93
	7aW6wP+OaYi8i5l4vfvIgH95DHQhGjmyXX2FD3CVkyK4JkC4qT/dSSVq+mPfI2dIR3Nt6tJxQap
	/2nhkBjaZhE4LJyWlOl89rcvWUR5B/mXt+gqQ81awD1CJIiJOVFGGPeSOrxCuWzn0FLvw+gxt8+
	tkhH1zhxWbSR40Yyz8CoW5yp81M/eGRrtlpGgIpov9Ou+MWp4YqkY3fX484ZR/2ErSD+mXQMSFi
	uzdvBMHBhyMwAxBjK/WhYDvUK+hFmnI9BMLyWqaYEkDMTJse595zPEGvUfgaOEKbm731qsxpVSA
	fwvZ0R78FrOrDEQVQsiULX8ZH31ci/iIVv08XuxxxjR7suV1tiEkD0cDe1oJEgoYC1P+RgjgEg9
	ix2WkktQH3qz/W18D8zI2kIuUR2Fwbvh4yL1ZT1P2JRYVmoHFmHxF3mONNNlqGMiOtvIW/WY7rk
	yAWCvkrlIORZbIa1xcQVMfqnPSR2OSyOgL4RRHuF2mQF2SIY38QX9O+dLTklH8zNBKjd6zs4+EM
	wKe4Cd/wY654FlqeUvljaNhqn6s=
X-Received: by 2002:a05:6000:4615:b0:47f:918b:fa07 with SMTP id ffacd0b85a97d-47fd72d4500mr253409f8f.22.1785512676702;
        Fri, 31 Jul 2026 08:44:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a5a4sm6264702f8f.20.2026.07.31.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 17:44:35 +0200
Message-Id: <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
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
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, "Paul Moore" <paul@paul-moore.com>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
In-Reply-To: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>

On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
>>
>>
>> Okay, it looks like there was some confusion/misunderstanding.
>>
>> My understanding of Kumar's comments was that he was referring to the
>> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
>> not necessarily the new kfunc you are proposing in this patchset.
>> Kumar is welcome to correct either one or both of us, if we read that
>> wrong :)
>>
>
> Yes, after another reading, that does appear to be the case =3D).
>
> We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>

Since there is confusion, let me clear it up.

I meant it for all of them. I don't think it makes sense to keep this one i=
n
security/ when others are in fs/bpf_fs_kfuncs.c. That confusing limbo state=
 is
worse than just placing it where others already are.

As I already said, the discussion around whether all of them they should go=
 in
security/ is orthogonal and should be done separately; it isn't productive =
to
repeatedly bring it up in the context of this patch set.

I honestly don't get the urgency; it will be a mechanical change if we need=
 to
make such changes. The worst outcome would be stalling David's work over it=
.

As for landing this stuff, we can let Paul take the patches touching securi=
ty/
and route the rest (3-4) through bpf-next after the merge window. We need t=
hem
to go through BPF CI anyway to ensure nothing breaks.

>> However, regardless of Kumar's intent, speaking as the LSM maintainer,
>> my stance on this is that the kfunc you are proposing must live in
>> security/bpf_lsm_kfuncs.c to be acceptable.
>>
>
> Ack, will do this in v7.
>
> The Landlock series currently up for discussion [1] is proposing
> placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
> go there?
>
> [1] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gma=
il.com/
>
>> --
>> paul-moore.com

