Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A332FA2B
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534600; cv=pass; b=NMVGisxCEBkwcVSoGcn2PfBAc28R5U/jugpjA7sFHf0gze8sRD2a021iSxsivUvZ17w5ClLgvTLYQ/7dEtkYt2O07bCJ0S1WxSU0jKzEd+49gz6AgYsqjbvf1YHs8RCvgJrJi4dcxggOjLm5Ysc/Xe3AOpYo9QrOXcDO2O+ZOW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534600; c=relaxed/simple;
	bh=kpO9PEXx/XIiH5ZwWY4YGhkICx/l6ojRZfzW/2hja1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIUZzXwT/5N0q8kmLZA5nA0om4ZvGbmdiLD+Eh/CNpaWWbNzwuneTliVwNAwqPp1Oc6qu8yD94h2Dx5zuRNngy4iWvDhsAKZcD317nkKsuiLmLognpMKVEGEGp7Q+svhexDtijT4OZ56MrlAxnmiI1eSU2OZtcs/aRw4JHc0t78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c84Vtihi; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c84Vtihi"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so1577020b3a.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 14:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785534598; cv=none;
        d=google.com; s=arc-20260327;
        b=XM64uCGLoz4epkX2IUuNlxXuqzVMkPQgLNiSROaR2tiKAYvD03No+mZCNdLTcvLBXo
         rgwY35e4OVUKRrlRh0+YSRULIxZNkut9F/KusXPGI9LMBEaT5OlGX2ucIPSR8phD8Ion
         5YeIIcTpg/vgMuyQiY5HLo/s9e+nGFm2/r4SZnucDCYJRH3Qkxy75JqMMlyOWRiNKK2D
         ttaDwVI6WS+yUoizO6ZGVezDLKEc8LKHDBq6vz0Xr7Sk8pJzaPK932DsK3ZfYJcfzeTl
         k1jWkA4RzTzGNpuTty86JsTXDnYXyByFBizGH5D3haVgwQHhvR+u/Hdraaf/TIwtRkjV
         iITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KOVe171/EgYbHhJuKKdA8XntY2KmAAQiC3TVfynAeIU=;
        fh=A1bY/WeShZIGh/P09osU8gTgqtUSOXVbyp5gzb+GayA=;
        b=YiJ8vgKTJ3uXcVAsh2VMCp6cxCKnBy/9rhqNerab3bh4A7cAGeKY+058VwzPYNbUHY
         Ny65E4yO5XVvcuvw0DSTAUyQE/FDo05HIKyHDdFpQt5xGfU45jVO5peggByENOhw3h+F
         2M8hcq1xT3YiPWtsx1BcGYG4UjkXGc+0xvNLSENdnwQrLEkxnwwa4qV4AR9I0JbBGxXu
         nO4+/s52ZOgpM/naNnaqpiFZAxLSX7couxOaGQA9DMQpw/1wh+wKxGO6ShE9ShjG/fFD
         s/Sn6cXVtSLWnAjw+isWi7uGlYYSm0Nac+8pCcz5i7gJxG6bJUHtj2Xlm6qJs8NwOsOj
         7MVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785534598; x=1786139398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KOVe171/EgYbHhJuKKdA8XntY2KmAAQiC3TVfynAeIU=;
        b=c84VtihinNTAKFTpUvWgPuywFIBXbIrIdgFC0LIyNvf9Cq/SiAlmegMpggVzpg1lCA
         ue12iRkr6NAfm+WQocwFOaOuQkgtvioU6T5uaTIeOeNpXGEgVXMoFENwEyGlj0KD5ZDZ
         Z7rRPBa9XFPVCfz9wtSgEis3f3ZNHc0qbrlByFvG5mmNz6GaZneri0L8eAE5p5yfmbIc
         9Hj+cZoORh1wOvLilf/S7784TbMSler4wvoDax3QHj5Ep9w9AvBEbEz8tA1kmCWADop9
         ggHbVBp8uFemBT5TaYqshUfvQ7bPPOEMOmu5FVJPffOEIxk5w2nBvqzcNLwUwVnP4YAk
         jung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785534598; x=1786139398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOVe171/EgYbHhJuKKdA8XntY2KmAAQiC3TVfynAeIU=;
        b=CUujU9T+Waz5mpB/hlTAOM5ARM+mDx81Cr6tReEAG8ho1HjEQr7dBRLqsIEz2AfuDW
         tYVoO+abZRgX8p9/EmiGvZp89HM+e/4cdV0FeBuX9sNqHw2Wmsd4cbIsbTqdh6vHbDZ0
         6sQ23ymQ58bSx4fqEf1L3QTiP3a8hiR9db3mI9mj30m4hKNzGwPKKarrzNP3GH3fbDUa
         e7POUwTv3Z6l/xpAIdJq/kUbc30OnJhViA9zlRpdAipah5XQm4+rQ3j+s3tcGVfT//g/
         3A6+duykmnHvyBoFVSbreT9tdBPMGp6WqPEvKwrwiq5B4XRFEhtHUtuRHgeiy+srC2Eb
         koDw==
X-Forwarded-Encrypted: i=1; AHgh+RokgPfFw/xheUPrzzvlfC/ImCjXeENLXT37ebfrW7YZaufIXRyw6AU9oE9EKRNy/GadnGJ7/3sj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzil6InbTGM3ZTrimsE8hZowRZTRFgzZOYKGv4/38QJ+BODx76s
	lRw7+jSKhLSuhWqZq2OzP1OHLgA+XvEdFjCVBUKFZFzw7Ue6oRlJr/TbUT+zt2g3zFbEwyle5hG
	I6EdKu26+L5nq5BeXUSnr65FBQqoBm4Mehftglh9u
X-Gm-Gg: AR+sD10IU8dLWzPlogQYzNOrK6s9MpYrhnYqOaS0VoHcp0C8V/QAAb6xLA0m/QevUkx
	2Dc0eR+fBn1qv23KMFnJnrgbUq4/pCKDnG/eo0jZVDDvnCFsbn2Llsrm/UptNGjafdGUsicKdOG
	9cz/ouNN20bwhXdSk2nIFmCwk8ZaLX97uxmApp2ufk3d5+GO6oBwAj/uSJCsbMlL7QTMK7SmP4r
	ZmLrLlCba2B3pT4JQaY4UNn278OS7qWwNv0MZVgF/JAM/gApR6eSsYZ+dXb1RjFk+c+vEUPQ4L1
	yGGsAOn1TT41ZVK8Yr3PHGrIuDcN2erfspY1jNwjQJC6
X-Received: by 2002:a05:6a00:1956:b0:84e:223b:98c2 with SMTP id
 d2e1a72fcca58-84ee494dff0mr989540b3a.77.1785534598073; Fri, 31 Jul 2026
 14:49:58 -0700 (PDT)
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
 <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
In-Reply-To: <DKD2R5268G2C.TPLR4XMTZ91R@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 17:49:46 -0400
X-Gm-Features: AUfX_mxDgkjotLxho_QpbF4kUqhzrCQm-_c1GtASttEFM0UzlBMMT_SHEoVRkJs
Message-ID: <CAHC9VhQNozNGH4o=8D6wxks4deZ2eVOHmxFK=fvjhkCC0JSCkw@mail.gmail.com>
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

On Fri, Jul 31, 2026 at 5:29=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Fri Jul 31, 2026 at 10:48 PM CEST, Paul Moore wrote:
> > On Fri, Jul 31, 2026 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> >> On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> >> > On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> > <memxor@gmail.com> wrote:
> >> >> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
> >> >> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
> >> >> > <memxor@gmail.com> wrote:
> >> >> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
> >> >> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwived=
i
> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
> >> >> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dw=
ivedi
> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya=
 Dwivedi
> >> >> >> >> >> > <memxor@gmail.com> wrote:
> >> >> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrot=
e:
> >> >> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <=
paul@paul-moore.com> wrote:

...

> I think you keep forgetting that you cannot unilaterally decide this. Bot=
h VFS
> and BPF people have told you that it does not make sense. What was clearl=
y LSM
> specific code has been moved under security/ already.

I'm charged with doing the Right Thing for the LSM framework, and in
my opinion it is in the best interest of the LSM framework that the
kfunc being proposed lives in security/bpf_lsm_kfuncs.c, just as the
VFS kfuncs live in fs/bpf_fs_kfuncs.c.

> The right way to do address that is to get people who added and maintain =
that
> code to agree with you ...

I think that statement should be read by everyone, including the
original author ;)

From what I can see the only issue we disagree on is the location of
the kfunc in the codebase.  Based on your earlier comments your
concern about the location was based around testing, review, etc.
while my primary concern about the location was based around the
content, calling context, and general behavior of the hook with
secondary concerns around visibility, code ownership, etc.  Once
again, I believe your review concerns are already addressed by our
standard process around cross-subsystem reviews, and I'm happy to work
with you, or anyone else, to address the testing issues.  If you are
unable or unwilling to work on resolving your testing concerns then we
are at a stalemate as previously mentioned (a few times now).

--=20
paul-moore.com
