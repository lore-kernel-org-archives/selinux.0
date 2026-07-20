Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3E4195DC
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582694; cv=none; b=PeToy84eMRpJWzDiChxyetRiuUiByFfeiB+b8+tRDEOKVBwaCpf2GbmPqTQRkRtv313nom5Gwa/2Lxfty+CO3WMvt/0S02d933kA38cs3oOhDlGFr8nps7SjDheoHTmsgMra9H/MIWdhKH7A9vLx9Cshb+HARyEDfsShZZXATgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582694; c=relaxed/simple;
	bh=RcxGzEEwefX7zAbWTLQPNtYc6E9SwfZuoICNfQ9Im5U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QaoLbQC/BoSUDwH+KscdyaoR3b69PZq/XyYoB6TypVvEiDBI/pdSQmb4JAEYMUYgfxfug+TF32+UmyLhjuKjA6/+yfk/ik7Gt+CN1kPgqlm9bd3jV/9ggcXZpxWk83jHCjf6VdXGJXcIcgfAiVEGA8mtkm/qhZ+FvtJnL8ILO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLAdZdR5; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLAdZdR5"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4954b049503so6748745e9.0
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784582691; x=1785187491; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GodhWzpy/c4vsdA8Jyp/tHYkO7IhbQZ6imvsrnVIekE=;
        b=aLAdZdR5xPOkHVS3ZZO7tRXs2KoCcxRTyzJw7bqbbmG2FCksMr4SWNeHNOCraKJgJ2
         JQItI9AznZ2nyXmDvj771w2dmcTtCkVKpNC7g3rr/twj8xAz6lYCyxD+AbLEVcyPngMh
         NUbQ3jVl4SrRUTkN2cxLs0tldzjYZy1dkaaGY8gEBE17ikCIK7J22uz56vw6HsfpyPMp
         GsWq1UnfN9MEtxJn1JhkskV3hUUNSsY3KYztwelvpUgAXvRF9lbI6Kku/n8zVWvatNbH
         Q+WUZDZFmuqr+b1YEHcCG2M0QbqaLP9/UB8fTd2avdFTO6a0Xc9gdFnE21JfbvJrZQYb
         H23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784582691; x=1785187491;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GodhWzpy/c4vsdA8Jyp/tHYkO7IhbQZ6imvsrnVIekE=;
        b=K8PTiqg/2fxmvUHcgOYoMaynL6ZMx4KUFkkOfkJo4tNBB/J0U1+OA4NseyGCktNTod
         vaS5FTbQ3k6EVw/rGbRHqMIMgANT6EO5KrtlCeOiOAZPg1ZMEg2HJheM0bbZb+uasiew
         H0rmbBbURs4MfzNuh7ImRcLshMnm2MgUc7a6w32vkD1cLs1GgsoM0olCIkJnxfvfkMtF
         W68qJYG6YCJCDzjnQvnaeSkB6fwWJh1kmTeP/RhnhZ8J4WryKrLmu1iiDxZLl8qStOeS
         u4vLOk7PIF9Z5Y2lBowPYO5U5nvW4Bo6kleR98iY7hvMTBOgSZssB1RCjt8YW11Id11N
         c5Kg==
X-Forwarded-Encrypted: i=1; AHgh+RoBTylluuBjUTrx5oKOFsBYSLeyWBlNHPPVlYymyF0DgqEQ9K9ZiiYf6YnwW5a6J7bpvvQigW+T@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1Mx7GNpqYus2KfgqjDcabPFHoZNuhLK5DA7YZJunUz0uY6zr
	uaKaKlbT33Mhl1y2+xz/DZfai6vpZ/4OSZYEwz3EmIwnbxaWQmikerPf
X-Gm-Gg: AfdE7cmjrR+L8Z+F7yf+dMGThkmFJPqVmW+ohNOh4JjvaP8ce5qaXlMTe6GEV6W2KyC
	KnY8gD4tty0C/jJZHAHLWKFOFGgH+oyrQT5YdNq2mU3n1x5qwZ8UcoyzCWEW1ilBmzEjDXwXJ82
	flrYK0IPDa61OJXsUSyb6MPUJW1q3srUxncLHDwI+VaP7JXWEnCm8fzRuyMyzMndbIt5hyT8mPa
	Mqm/83mWwWVC4ZN6gmYVsMoid6kByLqOSxIwsgiHp7QomRtijrV6hrfFGUhLmP3RtC1BqTRxOfa
	3cvnrDGTTTvOe4N3HDcCofKhCNYrn/E/0tFpa/H2oF6flvi+zkHq3bUcJ9jE/bUdkfdVv75rICw
	1O/7T4yCUJSykGYPwgywEj1YeG+3XDZLXsIh5jjP+B4YB0BuISEHtEJvACMEtV3rJ2v8aj7l/78
	F6G02w+xBv28Td+WSX6x7pSafva5NfQqUvhu25hAxHDiPHdXfDyMhZ+YR2mE9uY3zkTfyzCzwDH
	2bTQ5D9wPpKVDFGqrOhN8TSGsP/WbfJpvPECC4C8ZIi
X-Received: by 2002:a05:600c:4fce:b0:493:fa66:4861 with SMTP id 5b1f17b1804b1-4954a404bc2mr195886525e9.25.1784582690803;
        Mon, 20 Jul 2026 14:24:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653bffefsm17137255e9.9.2026.07.20.14.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 23:24:49 +0200
Message-Id: <DK3PRLXZFGKN.GES64J05HY6B@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "David Windsor"
 <dwindsor@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
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
X-Mailer: aerc 0.21.0
References: <20260708000956.46138-3-dwindsor@gmail.com>
 <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
 <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
 <CAHC9VhR8n_TBPGLGq-Pray+mHrUCdcmqGXi9wTXyeGa2Dc4m4g@mail.gmail.com>
In-Reply-To: <CAHC9VhR8n_TBPGLGq-Pray+mHrUCdcmqGXi9wTXyeGa2Dc4m4g@mail.gmail.com>

On Mon Jul 20, 2026 at 10:15 PM CEST, Paul Moore wrote:
> On Mon, Jul 20, 2026 at 2:27=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
>> > On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
>> >>
>> >>
>> >> I'm sorry David, now that I'm seeing this function again, especially
>> >> with the LSM specific bits extracted into a LSM function, this absolu=
tely
>> >> belongs somewhere under security/.  It's only callable from within a
>> >> BPF LSM callback and all it does outside of some BPF pointer boilerpl=
ate
>> >> is call right back into a LSM helper function.
>> >>
>> >> If the BPF maintainers aren't willing to accept that, then we will al=
l
>> >> need to find another way.
>> >
>> > Where this code lands doesn't matter to me, so I'll stay out of the
>> > decision of where it lives.
>
> Yes, you're caught up in some territorial wrangling that goes a fair
> bit beyond what you're looking to accomplish.  My apologies for my
> half of that, it is an unfortunate part of upstream kernel
> development.
>
>> > If this kfunc goes to security/, would we also want to move eg
>> > bpf_set_dentry_xattr similarly?
>> >
>> > I'll roll v6 of this series meanwhile and we'll see what the BPF
>> > maintainers say.
>
> Thanks.  Fortunately, it should be easy enough to move the kfunc
> around, that's likely one of the smaller changes needed in v6.
>
>> I don't think there was any preference expressed from the BPF side.
>
> Look at the second patch in the v4 patchset, you'll see a preference.
>
>> Logically,
>> one cannot be faulted for adding a kfunc to set the xattr for inode in t=
he same
>> file where similar kfuncs to set xattr on other FS objects / entities ex=
ist.
>
> First off, I can't say that the existing BPF kfuncs intended for use
> within a BPF LSM program are in a good location.  Unlike every other
> LSM which locates its code under security, the BPF LSM devs have
> chosen to locate their associated code all over the place.  Some of
> that happened before I was responsible for the LSM framework, and some
> of that which has happened afterwards has likely intentionally avoided
> traditional LSM review.  Unfortunately, this has muddied things with
> respect to what is possible generally in BPF versus what is possible
> only when the BPF LSM is enabled; we just recently saw where this was
> arguably the root cause of an exploitable vulnerability.
>
>> The question about bpf_set_dentry_xattr is thus valid.
>
> It's a very valid question.  It is my opinion that kfuncs which are
> only intended to be called from within BPF LSMs should be located
> under security/, just like every other LSM.  If there is a kfunc that
> is generally useful from other contexts, that is a different story,
> but in the bpf_set_dentry_xattr() case, it is explicitly only useful
> for setting 'security.bpf.*' xattrs.

I don't think we should do that in v6 though. What you're describing affect=
s all
other xattr kfuncs. That's a broader discussion we should have separately w=
hen
folks are back from vacation, and more importantly involve FS folks where t=
he
code currently lives. As you say yourself, the lines are blurry, xattrs are=
 as
much a filesystem concept.

So I wouldn't burden David with it right now. David, just respin addressing=
 all
other comments and the CI issue.
