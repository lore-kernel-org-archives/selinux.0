Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449447DD4E
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523848; cv=none; b=Xx/0S2a52uCc0eJdjSQ/ztdnaloI38x9cNQD0Oo98m3wTM7GM6xTTJry0lJx9JaL6n8D0xwOvmQa3PteLh7vQSuZZ/YvrhcSNhkkOO7t3cfFyTknJ5XTBnfAxPtwoQXq2VGDlXWtQhYghofUnFCn0dT+20Kj0jxQONTIjvd3n4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523848; c=relaxed/simple;
	bh=rNSgybq+EC4StYKEvWW6N9mV5/JG+X6iCipGDYsDyAo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=W1JrCO78Gqw4Afeq5wx9tiCZGDEqGf4+a3M+bx+qAFo7AoIhMwJPKomy0G5/seXdqdh68LEgbkwFz+piNLG730y7a3vD3rc9hYDDxhA4X4ygWgjbNlTmlOX8MSAt784sSvEAVLMvDNig1mNbs9/UY1pHy1d7PjoOYwSMhZGR2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lla4kMeS; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lla4kMeS"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso408362f8f.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523845; x=1786128645; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rNSgybq+EC4StYKEvWW6N9mV5/JG+X6iCipGDYsDyAo=;
        b=Lla4kMeSwb1aRASQHA6OqAznb9OQ1+LmN9z9/3LN2wfQM5ggl/5b/+9Bcn51wZziyV
         nQgA1fhNLzXKilbNgD1B/nAkNhGCpzkh1P6JSs1dcdfy0LX/yNuivIZ6Vj0JPdQgqfAF
         YoNfutpa+7MCRfwGXxt1b19w+jfkRM2Iw8CL+Ct2rjfus7qYqyFihMQc80KUbYSPuXZO
         Ovwf8QV8eijEwCO/VAkq3bap7PRJhwW5SsvoAv1yuPRDQ3O/d8blnxd96K/hk7baYk4K
         oNsTYLO9yuIioNX0ot0UpeU6sGIta8lnNT6Blok4h53+Zz9TQIN/vPXD+KUR0rCN4HT5
         i4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523845; x=1786128645;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNSgybq+EC4StYKEvWW6N9mV5/JG+X6iCipGDYsDyAo=;
        b=sOZk2JKJiF06Juvz2BN/ka3kN2sEKw+evkeqfLYxj0IO24pUsFz7mylWiElsUaldgM
         QcihfaNYxphrUH7TtELfPlj29f/VXEGhXGN9or9HtFdNEvCorQcb/nS/Du7oEqanh9pO
         tonjLLVex7maRMWqBDew/YvMPkYXB8XeXdOvF6IpwbcO8HkrwHNrGULkl21HvkbUEEha
         IBr5tmwYV0iNaTudE1XkYvRnQoFDGbvdWYRsXpmckKf51BOAtd+l8D14s58Sgiq+btkn
         MFB1XPiS8wnT7g69j7ri5uiBNX5D6l4yOOlEPkufbatkGz+IYSbyRuuTE3b+8OgPybQl
         SxcA==
X-Forwarded-Encrypted: i=1; AHgh+RrCZWVjWw4J07v1cUPZ5Xa4IkrURJh8YB4taRy7cg/zUw9MenhA58yKr7798lvzn1CNM9qKxfJE@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlR74DruHhIiH+H61cKMWp7fj5ZPINo4dFeyqXsZzGqQKgWar
	wknEAkY64nvHgFEYBJsXkTCnLc23Zi/6wXC35Vxi3Dld8AOj8sKWY3wU
X-Gm-Gg: AR+sD10gV0mabW2gogQDStCATopusgxGqnMiGWvuXYMaOshu41THFH7cUTvWYDRk5Db
	uT0OINmcz5+7jRcjDKoXcrWKnStyrhXRTzGO0G4kGduqOiJtQL2PB7SeV2mkSG3VAQv1uDQVagy
	gQqbdSu5q4/1LqY20HKHQXPLDZei6ziAmTB3kD3aG/06S2UxpaK1OuiUZW8wVUPbQN4kQfT+8rM
	qhICFysqcvRPcZhULNk4s8Qa8UQs2tXyMTaq7QU6xaxZHOQeQacjJ5GjWqFFcj3E4araNlCH9aP
	CsFC2R3O2AsJGgORbfrbUG2JhOam4OdaMAJz9hR1tzg7HiPHKLTFXEnIKpXkvAA9+bEnxH2TBzU
	G1R/GWRU1yjGf9ZBLxeqV1aWG3Y1B2ikuePgfrL6Ldenuw0cK5be8z0Jnhj/bmhpha87s6/57N9
	HCNvcuweJ6ZP+NKQe1o6t3sBuOwZKQxPG53dnubZ9fn52BjFucnze3V/454k++6a4QqJtMOLA5p
	pVeFRVliCoSF6yOu5UUkN1R15IF5htYjq15gctR38G/zqSOdliEF9o1me11NFLcqB+yHwlO8oTG
	MJOrsNDXa1Dchr+A5VfGIMuEpKw=
X-Received: by 2002:a5d:5307:0:b0:47f:48cb:ea5b with SMTP id ffacd0b85a97d-47fd72fb87dmr1338696f8f.43.1785523844695;
        Fri, 31 Jul 2026 11:50:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2484sm8232834f8f.11.2026.07.31.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 20:50:43 +0200
Message-Id: <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "James Morris" <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Stephen Smalley"
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
In-Reply-To: <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>

On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwivedi
>> >> > <memxor@gmail.com> wrote:
>> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-m=
oore.com> wrote:
>
> ...
>
>> Yes, I understand you feel it should be placed under security/. You are =
entitled
>> to your opinion.
>>
>> No, I do not think the newly added kfunc is a big enough layering violat=
ion such
>> that we need to do it ASAP, disregarding everything else outlined above.=
 I am
>> sure you see that too. There are several other instances of similar kfun=
cs.
>>
>> Therefore, please attempt to meet me halfway here.
>
> I'm happy to work with you, and/or anyone else, who wants to work on
> finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c.

Right, and for that file to exist, you need to get everyone (FS, BPF folks)=
 to
agree on whether placing all such kfuncs there makes sense. It is not for b=
oth
of us to decide on our own. So let's revisit this whole topic once you've d=
one
that exercise.
