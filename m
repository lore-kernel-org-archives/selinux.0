Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005547DD78
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988996; cv=pass; b=ULaQh20MjpY0M7/RKb17FFssQwouYxoj9qsyBRpmAUUNOglugivlfeZpGsn1gZF0tycncMVreo/YNPoWyQZpBJzTry38f94s4zuDp6uM/xlr1qSwpYVU30+k1RpRaYfpRGOGbgdRMlecOyFQ1Z1febobO2sp/vIcg9Lq+GB/AoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988996; c=relaxed/simple;
	bh=dwtJGGtWfivJTDnEUkDart9O2ukOCksxaNnx6dZ9xy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmrY5weIYHQI2xOaJbJv6NYzQUV4RaQRWyV2WPy6Kl2mWlvAMapISCNRVO0vN4InMdY52Q6kjSwP7kKxZtdeeb/mZkqOD9TCpr3ohWYId9WkYzuFOYaGgFe719olKcDpReJH8JwfPwz164bVudbO+vC4dErpdSIGKrzwqq+HT3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=frbFmbFg; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="frbFmbFg"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-365212191f6so2083608a91.3
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 06:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777988994; cv=none;
        d=google.com; s=arc-20240605;
        b=hMr0wxudHbN/dTIcjKRi0a7sydurVNGYo+D8MC4pRxANtMpqC7C065tyNhljhb4HtP
         Okm2ycDzi1Hf5GmtIDrg8slWaHmz+nC9sBxe/O7+yHZrfNmdOK7F2fy+XkRGXG/M/73p
         0m4VNEdx2wEAt/gulKF07eQsjrR0fUH7u638gWPPFeGylwBKdECsuoJdnzctogxy0lIY
         ENKaB5EozNjzk4cwKZ8bC6SSlkbk6CnmXuL+ulvpVt9pBD8xMYzFHvTFywCthy63vS83
         Y6AOE4+ly24KU8TzMW6ftPWt5nfnk9qqf4LvIC2fo45nWPCiRs/Zf3w4xKczhK9q/hUe
         Yd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        fh=AAI9XZWA9dRZGjQqUlx70HS4ZJBVX0v6I0e49QcT5G0=;
        b=MzvF+8BAC9PH6SX08gbPB316G0+lLCSfHRazWDQgmXaKATMPTuLOGbAPlLr11XIpYC
         csChzREWQHgAYcSPQQyEHGVwunp0nKRjKUgsbq+cjZqKzYffFMVsOpAhnA2ojWb8aT9Y
         vj5mf31or19IS8xdmUMimhALDrNTK/RFHV/PB8hRgUvz7gy8gpegxnNw3pyyd6Ulhded
         iogl8bvK1aqKr+vVQrIMnxG15ZhaBFsjIGTIFING9IiNOiko5eDB+mgGJUMSiYjuV5Ej
         xaL046jt87m/ZX/vjkFNBsMfrFNWXyhY+ENB9d4+o8HjlglpRiEKyysPTN8748v+iROa
         24PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777988994; x=1778593794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        b=frbFmbFgOy5VDj09J4f62miUa6qVAKlhZG3/8HfPOneejt5h6GUtQh+bJQcYyVXcJy
         OmsPiOMuN59cYHOycQHeT/fex5uKz0C3c9lNgZRI5cWhWaf/YgfV3zrNKOTQvhctF7/b
         SsxJo8VaIiPaynadx4HM4POuFQY7HM3sNWB3aP6pj6djFe1joxyMQF/ThxZnKM3T5tui
         olWtUGCea0udn3tlMK8N80eYwbORI2WLMtMKL0G6v0P3OTM6azccnmnPrJCmunmrLZ93
         RPuZFY0oa1or8jPs4empxBo4YHxMqqLLDwDL19QSzLbL4rVWxUp9aOEvIlTWfpe1qw18
         Fg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988994; x=1778593794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        b=QYJ0c2Q9DJuCQP1MTQCBBJONqHcqNQZeOW35+fqZpFz4viDWZzesCmK1xUuoR5EjfT
         /fEtoj//d5dqdHXADlPbao17LCMtfYBrg4CUPP9+2FVs0o1O0LUXcV++46Ky9BVP7gDA
         U8HEbughExUrgeFN80Lc6ZrTNF+ic1vy2R9pm886HLfappNGKYWguHo3oQOLaiblL33k
         IKT8z94dKCRCWeDiNw3W1yKPnfBtgrtmrmrrB/W06zziDHBs3NGnpF1WMBoo5VLtbG2m
         uNNskKhqX9Y+l59An7yj1AWl3lrqVNmaxGICZuaWzfQ/y6/VYI3I1BjePKBLjbTHtTgu
         us4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/7SmiuH5W/iCwfwGKeErWjO6SPipJ3RgOjZfbQvWNB/Z028gWfg10izXrf9DqD1ZtJei1msMpA@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3HQGF+/LpgBiVMubfiF6g8A00ufV5mlDPmda67emPDwn4iBp
	MngWfpsk+nukY2TQ2el/XQ93hCnzauQuidzkM0knjVWqDosPXjSaMR2tb10k3SyafZNmKOwomQT
	reyTqk6NXnJ3VDVohIEg0+bShZe6JrmM71mHGCoro
X-Gm-Gg: AeBDiesVseYoGpfBexMf25x52R9rHOajvS8fXea7aDVFkOXk4ZrIfOjmtpuR5ApeI6E
	lU8iFPcKtJWxEnA91vNoBi/xmxDvFatwi5hxMESWJwH3SJCjnu0l3Ws74e8CXhaic3eACieYa9v
	IuKF/Hg1a2bw/VUsu0DLkl9pqpA+jOlHtBVbSdRSFyszH2t1uSFKeTrINLXpS88NsJS31Zr7ggL
	hpMyVJMVUl7auXAiGvsX8Gskn558+nHa9Hhvh2a9QQcfWoCG5gBGbtmrWOXQR82sMDQDD8gZp+k
	UOcq7YYo1y263Z+i3A==
X-Received: by 2002:a17:90b:3a84:b0:361:4521:d311 with SMTP id
 98e67ed59e1d1-3657747cdadmr3159694a91.18.1777988993821; Tue, 05 May 2026
 06:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
 <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
 <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com> <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
In-Reply-To: <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 May 2026 09:49:42 -0400
X-Gm-Features: AVHnY4Kdcn8NUgT3x3TCJLSbVA7TxZZZNO16IatME0SS0-imLL4d0tdSq1ceCGU
Message-ID: <CAHC9VhTWpFbK30ueZw5zTgNfMoABLXcbny=_eWOV17+1ebFVKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 5:00=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Tue, May 5, 2026 at 4:02=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> > > On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > [...]
> > > > > > Perhaps I'm simply not seeing it, but is there a check to ensur=
e that
> > > > > > there is only one BPF LSM calling into security_inode_init_secu=
rity()
> > > > > > at any given time?  With the BPF LSM only reserving a single xa=
ttr
> > > > > > slot, multiple loaded BPF LSM programs providing
> > > > > > security_inode_init_security() callbacks will be a problem.
> > > > >
> > > > > I don't think there is such a check. Also, a single BPF LSM funct=
ion
> > > > > may call the kfunc multiple times, which is also problematic.
> > > > >
> > > > > I think we will need to make the default bigger, and also introdu=
ce
> > > > > some realloc mechanism for the worst case scenario. This should
> > > > > work, but the code might be a bit messy.
> > > >
> > > > Thanks for the clarification, that is what I was afraid of when
> > > > looking at the code, but I was hoping I was just missing it.
> > > >
> > > > Increasing the default is an option, but I don't think we want to
> > > > support a dynamic reallocation scheme for the xattr slots, that wil=
l
> > > > likely get extremely messy with synchronization between the LSM
> > > > framework and BPF LSM hook registrations as well as special code to
> > > > handle inodes with lifetimes that are disjoint from the BPF LSM
> > > > programs ... I suppose there may be a way to do it, but it will sur=
ely
> > > > be ugly and come at a cost.
> > >
> > > BPF trampoline already handles all the synchronizations, such as
> > > add hook, remove hook, etc. properly. So this is not that hard.
> >
> > How do you plan to handle the issue of disjoint lifetimes?
> >
> > > All we really need is to allocate a new array, copy pointers, and fre=
e
> > > the old array. And we only really need this in the worst case
> > > scenarios.
> >
> > Oh, is that all? :D
> >
> > Keep in mind that the code must also handle arbitrary ordering of
> > LSMs; in other words, you must handle a BPF LSM that isn't at the end
> > of the LSM order.  While a BPF LSM at the end of the LSM list is the
> > most common, and recommended ordering for the vast majority of users,
> > we've been working to make the ordering as generalized as possible.
>
> All the BPF LSM hooks are called together, so it should be fine.
> Maybe I missed some corner cases.

I was thinking about the LSM framework as a whole, not just the
potential for multiple BPF programs attached to the BPF LSM.

> Either way, I agree with David that we don't need too many xattrs.
> Since BPF LSM is reserved to the privileged users only, it is safe
> to put a reasonable limit, say 4 or 8, and do not handle the realloc.
> If the admin would like to brick a system with BPF LSM, there are
> many other ways to do it.

That is definitely the easier route.  However, please add code to
ensure the number of attached BPF programs is limited to the number of
requested slots.

--=20
paul-moore.com
