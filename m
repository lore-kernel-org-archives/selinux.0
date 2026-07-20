Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36B3C5DDE
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572303; cv=pass; b=Vicb6Ckev3Dx9JpgoBLxi4ls2cF7o4SZyGyYdsfOixa5WxwRRvdt/mpbPDJiKHShnh/bw1DuDZM+QXjPJndHqQbiHXQLqLxmBrPNTdaE54dwD4OYS+VSeaZWkCLpNgkDzLdg9Zdyn6gnH7s/ySrU6ulmHy4b1dx3eK082+se3e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572303; c=relaxed/simple;
	bh=LC7hykOo7NcQDgbbnYkuyatZKfLvtqyYnzCxrtoDhEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOjfUzu+HMi8uLJuO7hxvX8cTnXt4WaOdhtYMwpqiPy+LUIwum3MqwQVRWKOQbVRDMRejrnlH34Lz8xF8YRbNDemvveguWySCoK8p8jnRSldRwjosiVmz//gYAbhSA8DL18iYMbtvJ4zU9+NVbdhcz/Y3avbGtjuh8V/ODDxbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF4oDpAV; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF4oDpAV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc891373e0so130124485ad.2
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 11:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784572301; cv=none;
        d=google.com; s=arc-20260327;
        b=XbQVznW/cbQQBcZV8heekTuk1A7ClmMxCUJHfezZSBab/s0WZ0H336W4wfF2gVW1Tk
         cVMreqJK9o25c7GCHqCmRMW+ZVgsVwONqvRosmysrHi6TxqUSZGGUbaUMSnJ6pWaB/k3
         X4LwmauLfk0J7YwAxkMLDLJwkVRsBeqszYWVyyNPxTxPh8GqI0VaY3f4HPKnch6HP7AY
         u76OACODpEZKEXmLwwsRBykBgCsoWJviRcLrYRyiTpB28IlXmAkTV1+G1JchFGN09tic
         6/Gnrju0LNkwMkFsL4pl+pA4V74dNKfpY1Xm+S+kKJA9mwQIh9w5lMDQF55Nr8Cu7BeL
         nm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        fh=JvMp5SA2/nkTHvwwxb5VMr3NLOau5skRERCyAYHeE3I=;
        b=LrbxAE+VuTlTR31kct+wxnir8KBXDajCfrdhs7GNo3DR+RXeWXxK22+2zVAfUw0BjV
         UOkI9DHvvS3DCRFazhddV5E5rwS4jwKXxHKu7fkAOUDKLzyXc2EIPH+yIw0NuKvw5GHr
         OXSAD0/J8he/MpsayLwzeqRVuDx5VZbxsL++zjjjf3crQNDaSE7oE342wpR9sRoaMjFK
         Yg3YgBiIqwe2WtUEcG4XVmOXZj7WUoe2OdVVBXKZr+Fg9TKJmzGbbvLNZ1t+1AeaGjuM
         pJa/nn4ZKbS8azfLGNmWRGHKRwxPjxugV9w7EJOL2JIS1SgNqMfLpxBRpR0zwI99bJ2i
         qmpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572301; x=1785177101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        b=SF4oDpAVjRYKdSsd1An806F+kBH3rf003d0u/ZUMNNm7Z3eZ/kHMlpnc10wsos72ad
         oUVSW/oegIFYOPHJjIelk0S79rBUhoWc1IxaZn/GFnBqExrzXoMic3eoXfLINQQIZ2qz
         tA9QBh17mfw2HmoEip2+j2tXcSavY9xNk+6qFYmUxbEBLFOg+1y78i/MUQpeItTjTJWm
         BBeiwakKjw0Otg45hxTUrmXoCmRGjkLygItlPBW01aC3soRn+U1ru7O6dzq3Xij6aWuW
         HWrIU51Yw4aQ7Wp9fC+8Ioy3i7m2/hJl55Afq+HIz1ohnbQvRwBMYwsoWHSQ62lpQjgx
         aH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572301; x=1785177101;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k3hjzl7jw5v8GiAJW52bFkdiqM0pGI3DopRM+xm9zUM=;
        b=gAS7LpWp5PGDCfWAGMMYK+IxsPH1zxkBvdotwwGrQR/HSCd7RTPDIqLAxZ0rJuUNoJ
         LthWUu/ZQx7JvOXNyQxQlMzb6sfYMQTLQI8EKw/Ijvwxf9yubpgE0/sNtpHaOiso8l9u
         Kg3DWckV5jf9MDORBqV8xrM8pvbA49ka+uOQ2dTqpppeE0XCIj62zBp3Hfd4xij/W1gd
         Z1YDOnNucsqi8Ng7YXP28TTkIzqEZiU+DZmFAB9jBJVOeSBm5mBsW0XJjH2MHsDef56A
         TvgVqk6SzMyAQOe++5NYCVcEq4gLJROjDKToJjbNI9zfS3wkvr1xXMo363jVMSFyTuq5
         7xiw==
X-Forwarded-Encrypted: i=1; AHgh+Rpr5XPGvHQRljPbu9lz9+wBr5/Qq2JVlyr+SGA+9u2o4r2BlwLpZopLUZwq9Rf+scZRUywtyPDu@vger.kernel.org
X-Gm-Message-State: AOJu0YzhHVJ/eJQrd3HUjXgTAQJI0CGoCkOrO2CPjVzKgzrBtvSPFncU
	5tFeOG06CsbuB/U9LLGT5IIPGlowV629D7zUQbREhwk+0Tjzo8uBA1K2yy9+guU4QMahHI25d1s
	LJdG00o++ikM0O0Nk/5FFQBmz5tjCkEw=
X-Gm-Gg: AR+sD12U7W97U30gvCXCHREbXpKjlFYJMNIDTcUE+7NaXmgIOKh6JQHnm7lYdRqD/kT
	5QKp4BaEFnE3CNQkzGlMvofmFxUIw9dgkEEtftoSWWqPw71kDZ/2cIvAIgVAYO6vAMwSzTyMLcP
	8Ba3PWI+581rj6Y9ep7iv5LjHHT4xtHyi6UCBiyDfFUmSAtb2x+ezoSUywP44gnH6m+o+4lP/ct
	j0P2nfszLl4+ySfiTU9Yl8OD6/73BcInlkKaZz2m/9OeIiBgFzIbOoKg0JL0IJsuWq4QPii6DTT
	BEMXqMhezI8xxs4agsR8CiaD45o=
X-Received: by 2002:a17:902:fc4b:b0:2ca:bf68:2a54 with SMTP id
 d9443c01a7336-2cf349b590bmr166172285ad.22.1784572301567; Mon, 20 Jul 2026
 11:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com>
 <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com> <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
In-Reply-To: <DK3M1X95Q2FN.26PY131TLPS2O@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 20 Jul 2026 14:31:28 -0400
X-Gm-Features: AUfX_mwvFwr-TgBt_1bjRhuE8WukQ5CZki_9yiHUuJNp8q_cbJ7bjwASItGBHzY
Message-ID: <CAEXv5_hc9x9XJZr646efGe=HD5Y90FtB1m_xi--0wWuaD18EKw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:30=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon Jul 20, 2026 at 8:27 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> >> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> >>>
> >>>
> >>> I'm sorry David, now that I'm seeing this function again, especially
> >>> with the LSM specific bits extracted into a LSM function, this absolu=
tely
> >>> belongs somewhere under security/.  It's only callable from within a
> >>> BPF LSM callback and all it does outside of some BPF pointer boilerpl=
ate
> >>> is call right back into a LSM helper function.
> >>>
> >>> If the BPF maintainers aren't willing to accept that, then we will al=
l
> >>> need to find another way.
> >>>
> >>
> >> Where this code lands doesn't matter to me, so I'll stay out of the
> >> decision of where it lives.
> >>
> >> If this kfunc goes to security/, would we also want to move eg
> >> bpf_set_dentry_xattr similarly?
> >>
> >> I'll roll v6 of this series meanwhile and we'll see what the BPF
> >> maintainers say.
> >
> > I don't think there was any preference expressed from the BPF side. Log=
ically,
> > one cannot be faulted for adding a kfunc to set the xattr for inode in =
the same
> > file where similar kfuncs to set xattr on other FS objects / entities e=
xist.
> >
> > The question about bpf_set_dentry_xattr is thus valid.
> >
> > Anyway, I will leave it to Paul and Christian to decide between themsel=
ves where
> > it makes most sense for this one to live.
>
> Also, perhaps it makes sense to use set/get naming for this one too, to k=
eep it
> consistent with other ones?

I considered that, but we're only allowing one to initialize the xattr
on the inode here. Once it's been initialized, one uses
bpf_dentry_set_xattr.
