Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795923C2785
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539481; cv=pass; b=Gfs1EUtqQl6u7G6rsG3gMLiEzgMWVSaC0+UxXXBLBmDSqKNsKjdoB6jtEw+0T47bY1ErxGhmTRNPsyExcYBuyF0vUB2VeiYjg27dqmH4HU7b+MAGSduY9hKr07p2GYv6P639ldj7zih1sGJv82tyNr64L5EnjFXgKspFV1+9WUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539481; c=relaxed/simple;
	bh=Llu5HYAUV321zAUTnCstCUwOGM/uo5kf8WVYwVpTpcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgYnkYw8W5eY0AVxhxyOK0oxkI8ll0NKN3lBZSUvXQioz4PD4mMj0Ym9o6ojwWZNuAc+EEyhpeTnz3SdiKYpd1mNNBTwJUu16AXsu7emTkg8bNtpLi0dr2K2L135KiAVEp9n1V4yW0+hwINXKzukeb/iyOEGMZo/mIwC8DUqqeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkP5+j8M; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkP5+j8M"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8eeb4508f29so10842306d6.0
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 16:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785539478; cv=none;
        d=google.com; s=arc-20260327;
        b=a0x8/1hPvAEYeIHWHoAW9zP3HZZb5M0qDOT1QcxbRHWydHHdZ1L1ih6KzR0gSW+NmJ
         XzSbm5Ol+bLlDFjihAjZfgtEj3XS0iFI5Ho6B6c/vGMTaJs8AH8ohaZUcwLQRQNB6LmW
         /wNUR39loTg7QBgcHuSCtkxmJe8OQYsp1g8c9SNDnogUVjVVM3t+xRvSV7EPzDPVj4xD
         qvXOsGealWipu2rnWO8VvVr3VwQ5DnQ1By/vRMDHVH9upCi7kfjkE3kHIsQ3Gnk9Apgs
         xCHJUNRiwjR/ktZDED64+dRcUy/v1xnyugsLCVzAg/0l4VRYHUQcZx7MpRDsvkKtw57q
         tXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXV83ZNX3Y21YTeQXzMxiEAKn/GB7bRp+zTDG9agiFo=;
        fh=d9z04qTcgTVfu9rD1ztD9xkdpKrDJx+WB0HF8DztmPI=;
        b=R9GWk3dwbyqxREzS4A5vYVEVQ202MKqMylw3zy9QEWMM5G5AUyWmjqkOUG6zp0JmBr
         bRyQRCdrntyGAMr/ksCg6ZVEuWmZ+AuRTIwCLoy405RrMAKNoOtYdPvJWTI5ySnVVPXA
         HT2nrYxSNojkwAI0dKad16VJV/qore1FGeuXTuQ8pN6HbOMv8JcQVcTu7erTOUuk/Xxo
         HXIx3BGlCg/FvBVVd4RPAeY3+Sdsv84VSqiUKqkKdejkTRWhbQ0k/nX/+Yq46DjSKvR4
         3ZP70hnN1zEp2Cz/PuTd6KIu2zNXnYpAZaU34HsQ0Bd/us8peQ/ye3o0dW/Tm9Q38N+E
         afVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785539478; x=1786144278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eXV83ZNX3Y21YTeQXzMxiEAKn/GB7bRp+zTDG9agiFo=;
        b=DkP5+j8MtScptzTZZnZoYBhfOUHmZwzeK8WdGHfPWN36kZeocMag3+pCM88pmWDhpZ
         DX0QH9f7ipRD1u6qpcpkTzjegZzahuBtHqxsLLfx9wJ+UTMIrk/4Ukwk793usgN6vOr/
         Kqn/yBhjePKs3aaWE3S8oZ1YlNe6ISadfknrwCnT0aYbeNCwa1LjHRmg5UorJpK3TfQT
         BMqICM4m7i80OBjSyQW0QYcYbNuBlptf6i3VmBTecwYaCwBzvvY3SaASZwGj3J7jZ1G6
         TRkTAYfoW+XygO65RPDOvAtDzLd63W2G7Ou2mtI7XSq2IEP+ubjOl8j+1a/z/Qb1Zasp
         O0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785539478; x=1786144278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXV83ZNX3Y21YTeQXzMxiEAKn/GB7bRp+zTDG9agiFo=;
        b=Glw+qX3rJ2sP/lEC4IPGRQ46rP3BQ1ao7SLuTgeySXhIfKS+3J3XDNZn8/JsMMTmgY
         hSGN4CAJVnA6gyKNAlqsERttDCAP+iYwtbw1toGoKUAu8YSXQoQf0j3KGQXeDj2FENzG
         N8KigtceA4OwcTnotFt5EBH/eYTKpBcDP/WItc/vzzZEWz/hkTPFrSArTWyCWH5PhMFo
         9g7VgJW4qUcz4VKbpsufxHPTZFysqja/8ePkxzGduOiabukb9Es/25j1Ax+qEOo/fEuZ
         /KWXaEYlY5tTBWURYg80QqofaTjZustlOZRsL7JnkqX/wkyxfwTRP3r1FqeXIvkeoP3G
         LYDA==
X-Forwarded-Encrypted: i=1; AHgh+RrkNoypsFDp78vqCJ+UtfZg2CC+6tf2KSj06UVv87eU8Jy/PGa9YzUnIEPWSvA/hZAtdbJ5r1Cx@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXGev45Hbq+vJQToRMECufGf+6H9NwvdtHx81vIM2BaBW7sWE
	gBkVKG6KRCOuFyt2v8xGLiFDM+57m8/suoKJHUeu6xKbmobP1XKmNIZzyHonvSsQlEyqxYATPji
	61hpougR7jx54LDnGhaJ7drTYeUpD0dg=
X-Gm-Gg: AR+sD12P/YDbtDinQUnSP4Wg5/QI5KjgjdEffNHZVegDiZVBhMwZvZkG03qxqWqebUj
	7O4cFLGPxexCMh57J46iphH8Uq2jSCzxZDQUPXdXIDvl2AagTb0bcfCANoHnkPl23veFhg7OAkU
	GwpMDgvLmYsNTWoOBwFQRedKiSxrpfs+QUTYM4XPRqq0FlLZiCbjH59jcqfjlmSmRM6SJrGQCo+
	HVd6AvjB2D/65YjpdBu2yPi2zjAV+Yvvf6N5VEsEYW5F7QyKbTfc9pjXaSX6IiNfJhCGpOXGE68
	jptNcIlTAvPLNghuyjfWbQMZhQz3QVcOIW/RzyWbv7QuX0TXv3cndR6Yb6quIlG2nNz/IlsU794
	=
X-Received: by 2002:a05:6214:5401:b0:8f2:1d56:3e8c with SMTP id
 6a1803df08f44-9084969d98fmr42804666d6.29.1785539478275; Fri, 31 Jul 2026
 16:11:18 -0700 (PDT)
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
 <DKD3I17NPS96.3G49BTZ4ZVUVV@gmail.com> <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQmb=v3-T5HZUzfr_me6S7bo6sX0Vs4nDFQZnMe+SQOMQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 19:11:05 -0400
X-Gm-Features: AUfX_mwPT5QbHLoShK8MUNDhV1cYgpH-wDwOaqHd4-WwjBfuCUGPSRVDO_MBrPk
Message-ID: <CAEXv5_huGfd7u0tKW5Eq5bSH+rzkB=ThKOTLnfnxepqTmgcUPA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
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

On Fri, Jul 31, 2026 at 6:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Jul 31, 2026 at 6:04=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > On Fri Jul 31, 2026 at 11:49 PM CEST, Paul Moore wrote:
> > > On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > >> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > >> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> > >> > <memxor@gmail.com> wrote:
> > >> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> > >> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > >> >> > <memxor@gmail.com> wrote:
> > >> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> > >> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwiv=
edi
> > >> >> >> > <memxor@gmail.com> wrote:
> > >> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> > >> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya D=
wivedi
> > >> >> >> >> > <memxor@gmail.com> wrote:
> > >> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> > >> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartike=
ya Dwivedi
> > >> >> >> >> >> > <memxor@gmail.com> wrote:
> > >> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote=
:
> > >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kart=
ikeya Dwivedi
> > >> >> >> >> >> >> > <memxor@gmail.com> wrote:
> > >> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor=
 wrote:
> > >> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Mo=
ore <paul@paul-moore.com> wrote:
>
> ...
>
> > As a consequence, everyone suffers because they first need to satisfy y=
our whims
> > on how all code and kfuncs written thus far are wrong, and need to be m=
oved
> > around ASAP, including the one being proposed.
>
> That's not a reasonble or truthful summary of things, I've only
> requested that David locate his proposed kfunc in
> security/bpf_lsm_kfuncs.c, I never suggested he move any others.
>

Looking at what's left of the kfunc itself, it's basically nothing.
Everything meaningful has been moved into security/ already.

Aside from bpf dynptr ops, what's left is:

if (!name__str)
    return -EINVAL;

if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX, sizeof(XATTR_BPF_LSM_SUFFIX) -=
 1))
    return -EPERM;

if (!xattrs->xattrs)
    return -EOPNOTSUPP;

... then a call to security_lsmxattr_add. Why not move this chunk into
security_lsmxattr_add, and leave the remaining bits, which are pure
bpf, in fs/ for now, and litigate the total placement of all of them
once v7 lands?

> --
> paul-moore.com
