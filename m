Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09ED3672A5
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536595; cv=pass; b=JAmSWfaadsOHJkgE5qcxmxS9U1Aa/mnhquVtVOlZr1ppatcDo5gdq7kb6KxHQuEi7M17MAaZMe+BxbOn7ERAuqK2L0PPx9t0YaqkgbfFBhf/IVmgSVP2CJMozHRPSt2kFPh6Azus3ewVCAt0C7ydcPTe6TvDQuTYyNQ+0891G9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536595; c=relaxed/simple;
	bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WETIkY3hlxAH1pTrkBqB4dMY7Mr6wRJUzTGHYlx8Bl7BDy+4Ph8bh960sRZrLQ/f9jawfjHulPMnJtafYlctTnTPc1e7oP6ZdgkK1SYGQj3r+C/TwTVcv8jqzg15ZuCG1p0um4uZhxlsg5eF+mUanEhFhnVBkhNTDEPhYJfuWfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=azYAMVWj; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="azYAMVWj"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1949869b3a.2
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785536593; cv=none;
        d=google.com; s=arc-20260327;
        b=LVnqUD5KrHHxHNlJHE34vC5/n8HBivudO4me4kw6qMwAibksBcmu1w0nhZ047S7moM
         5H6snCRfoMH3bTdvWgjZ7ota7sq6/HfZeQ839UTVj/27Y4ell0Slm+5/90i2UBJlozPs
         CUYoiWID+hrDQn61HHYME9ayMxf6E2Q718B7UDEMJ9iuOl0x2/Kl5cE3OQwtRiagFnj1
         k2jBap62FCnTn9T1JiWBRtLH+M5OI2MTfSmNhHKM1gPi7FwiUVWx8hQyFcZKlCWS7VQu
         nxCimJFzSSXpVpVYOFIY7fLf2mrapSXYmX/0ro3sM/FgbBsnnnThvvGcGBgrxXt/bTBU
         TGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        fh=BgMGt1Yothu6O/7PefLYxs/ToC4Ev8fExQJG1f4zNi0=;
        b=KOBw5cW2IkNoJ4kbWUHEYw3a14QdbO5261nKEuWgDPkKe89tdXacBeSBae0HjZmIUt
         nDaHgWq/5SN4qAg4M/Moo0EZnPBjbwgOJVcmMRRKXFGr0M7PIF3mHBnMca57vZfZFTHc
         Ds1PnJg7xpNNH4d7z5bdkljFgFkbrn+gh9Ur6Efzqy5tkioiWHDRobCQ7NKe/Nh0VRE4
         TEuJYbMwcEMAho/HWj6VqeXrKAVm8XLWcLKqsr4/cDcVSjbowSdtL5DtRsYTX6IBYPy2
         0xVHyXLKYnjOZ+TvaiEFLhCcu42qvhDLKrq8gzX4prjIvlLvR58fMTC8W7Hj3OAmEbny
         Uz2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785536593; x=1786141393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        b=azYAMVWjhYdwMzeWcI05q+xknmIUABIj20r9StipuVxCW9z+9th7XSxJqAvVXfLmGe
         kwiyItVFAYt+/ueem29u5RRBWGKKVb/wEmoj2QlgXoncZDuBe7sHY2+mO9KYLJQkzMyP
         eZzNV/8pcDHq3R1KiUYE5q4288oLsAtCZCxriuDmXBAyNDhifmb+sHXOEmyYaL22lye2
         BMRteaBReo5RF62tMgo4B/Fz0XbfFvMDQqUJBYYrxNMBbIc0v5bNJQh42DHKyBp4+gev
         EPWOPkGDeGFMIo+IqbnsjD4/JzZJmej3g8N9b4AvPsvs9jJVId27rbMrogTfmo7xAwdr
         2akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785536593; x=1786141393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWC//Uy5P2vJL7f4I2irNaI5LhMsKvWd5AiC4Vo3R54=;
        b=gcPN3gQsimssHUms+bn1naWqubLR+tlMg9KWxkyoBAlxUtGDnjxvpGOiHY2YkBqoXi
         pM6Z03VzAivazzBqhFV8U7iyMz947xQWVot2DBeh+/Wxe1UpgNYRWI4hOkWZvKc494u5
         s1lDBUbkr5oEDBts38dxpGMZ10n28p9yiF0xbVLfR5ohjwJ00+1QjblLH8tgGcEJkesm
         Mdfz2ikq/0JNBeykhCOxa6Yqn3I5rrYtKGXe7fJXFwbYZ8nhScwxVhKwc5kIvCTZJ12K
         JvQe99nJoQYivhBijFB/tK6d/Sq2wRA144Tk6aSNVeHG1qmYfZLzeK4FmjaeMZvmIhpa
         qLZA==
X-Forwarded-Encrypted: i=1; AHgh+RrmB37DNLTgUegmmTj2VYd1vi3NKYAKa9IoPH+qyHivPsmOkHmEfAGrNf0G3ph2Klshwsd7C8IL@vger.kernel.org
X-Gm-Message-State: AOJu0YxWQSkDUfHJX2klgAQcTkf3xbjfbLmcvAFUnJ+XiBkSx5Okychn
	SM6kFCz7xDBho2TK0qBHQe2vnzNv2W9QjVanGXxkKN44FLDr/8x92aJAbtDVQhqX6sPfn1LvYpv
	JNzJqmqVKnhi+/K1n42BPbCUs0K+2u1Uz+LSH6XEB
X-Gm-Gg: AR+sD111a9FyMeijrzzvtAV8fzzF1F3n1+M7fAjyM1PsJ4qqxUTlCMQTC5p1apMPXs6
	Uine4Vicz2av33f1kqrADaLRD5Xc+IIto+YQR83q72xEPBJK5RuqjwhNO0UjvsCyF6fDETk4nbR
	JLT57QVVD9GWZWnIJr1PgS5OVRjlghJkqv1uXr8AR5V+qZhJfRCMKKq5pfY+2XtZ+CAnJNAvdBx
	dzTgdyAYkzoM8FlLI04QwIymNdf/IL++0jJqTib1HZbCbOoBwA/7iWTSNBdYlvtkKS8MRaOKWG/
	v8B54IzXot3Vgb4F37Nsa54Mf2G4bOvY3bl4Qj5pUPA4
X-Received: by 2002:a05:6a20:e20f:b0:3c3:c3fb:2473 with SMTP id
 adf61e73a8af0-3c92a53cb12mr1339830637.20.1785536593141; Fri, 31 Jul 2026
 15:23:13 -0700 (PDT)
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
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com> <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com> <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com> <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
 <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com> <CAHC9VhQ24fp7_sy1=NiWkfzPLSM35ugSCOKDKxnm6H9W-pDa6Q@mail.gmail.com>
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com> <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
In-Reply-To: <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 18:23:01 -0400
X-Gm-Features: AUfX_myDvAP-mn0LUSqkiSdO37b1-jlQ3lFWXPwWxDYV3yXxAuKFWzBHOxeX2Yo
Message-ID: <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, James Morris <jmorris@namei.org>, 
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

On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwived=
i
> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwi=
vedi
> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya=
 Dwivedi
> >> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartik=
eya Dwivedi
> >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor w=
rote:
> >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moor=
e <paul@paul-moore.com> wrote:

...

> As a consequence, everyone suffers because they first need to satisfy you=
r whims
> on how all code and kfuncs written thus far are wrong, and need to be mov=
ed
> around ASAP, including the one being proposed.

That's not a reasonble or truthful summary of things, I've only
requested that David locate his proposed kfunc in
security/bpf_lsm_kfuncs.c, I never suggested he move any others.

--=20
paul-moore.com
