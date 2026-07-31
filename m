Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A51ADC97
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511039; cv=pass; b=N+SactUKGHoCxGusTWspxegJhsS50syV17d4oksik0pAQDIyBs8NpbiQ0WByE5gT355ucOfA/puQG3doTEcrWnnbaFnCN+ZW/NgtBvGNGZVJi5p8a5Cl4KDI27boD5G2T06/OIU2YMz+U7NjJf8XSTcxsb/sWiQAfYjDplCzILQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511039; c=relaxed/simple;
	bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8E+0ChGwmlDWjKvFwCGkFmSS/PSB/kYsKZ2KolZ/vEERALCySAVCjSSDlwbu0UMNIPXt4xualpJKCLpOMvw7fQOHYzLUdY75b9nKzpKdlzhksqviBlZtqN8O+F+5IbMxeBV4amuJV4bajsp7KPwNPa8v21VY9+aYfs42dgrpaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C5URBVxJ; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C5URBVxJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ced3386430so10530355ad.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511036; cv=none;
        d=google.com; s=arc-20260327;
        b=lJT6iQGUkdVYLTJsVm67fjUlDiTvg6P6JhG8qXsGI1UQfnav5+DPS658A3sv+CbTzi
         zKXogaswLP35coyfyNxMzGXLntn6UN+KrjcHtAuey1Xe0SW9NXiUuqwYA8jUuHaGyJBt
         A8TuShGpe/z9WijmucloSdie61ykGn13yoWB3hS+YNHxRwUu8eKGcl6B1mrXhNJUSbLX
         w11xfvtVc217/Ps9FKiVeb9sg3LiZK1D3TumXKk54vLg08GzeusYKV9a3wFVPfAHMBys
         QILVghaUQlQsAw2nApvKQ4/ftDZ9vaHtEZ8AH9QuIqnzeMtArCSRuEdwI+4A8hIIpKmK
         s0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        fh=vR80kKt3x4b8xQicgIaCOKPrwDfit6n1WD40y6eCXQg=;
        b=Gztef1rNniQMCx5nJgPYMgIadzxTd/Z24LZyuHVq8i7aBMh8+k1lkGomgd9bSs3SXB
         J8y6MLcDXgtCytt34qf6H5Ff6aI/vrlUXrEj4qlIz7oH2AM/4Hmz1OcOkrz1CeX5bt6r
         af792XOUvJUcFu2hR7wMrox19Heh0WnEpg2Y5PAoi5GGWbL4McMBhs0rxIJ2B202jurL
         1xZcL7lfiUIRm6irRb8SXJ8qYyWbP5DeusQjGzvdX90v0rAVaM/119NIi+jbNd09G330
         aXPGXc9M8FThwpzk6M+TZ8RYNLDPhU0JIm7jg3F23eCfeeNwOQhMpG9OTX2RJB8XW9gb
         z8Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785511036; x=1786115836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        b=C5URBVxJ5tERBLgnpI1F6Uk1I8wczA1DgsZx6wU5E29TDJD9OlexQVboj2ikm7m4Vo
         G+DVy29rCfY3z8DteBOBZrGBt0A6NzbErXM1yBfFloMA1eBgxFG47mHi78CJI7hh5MTS
         Kajg4htZS9wNxXJmoOulS7kZUqkRiOhQe3zOkrQpebhQd9lt9YZIF1/aHmfGmxtjhxGa
         rD/2gv7lce/d0vipnWSBIgY6IZW6n4Z1DEk+Iv3wdUrZyhATZdXzysAX6p/yE0ZA9PHy
         G4lifiyT6/Kvh4p2Q7Ogfwx4NUJ17PuYzIPlojAjBifCDzNPoMo0FU5DWkCLgTqj15n3
         ZXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511036; x=1786115836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaagnOxntbuxGRXITbLMVGEEGsWlGpeYqyeDM+L3JQ0=;
        b=ejUPjUxaFJ/rd+W0XWxvJ7qLl5n/+7UKNgPStmTvCJd9mHZv+umBsICMKI8hkf1on8
         tfD1Okfn7OI25c9lbFbvXe0IZQBu4R08gKnkhZkt9ugGtUQhC/cnoi0F2v4K0MHDpx+z
         tgnKjv8w2jkxoD5nq3ujEMzdIjKvODaNd5tPrxsoAR2fabEHpZOB0UxV75BnU0tKizBD
         JsJwMFGG6iurv3ZeupA+9YYBZIPcCWNZhj3PJ/BDdPfH1FQQoL+aqEMgnDD9Y66nvnxP
         2HKVzqoMaAIJHy8H3/6TK0/3wyV+DA6kuIELmHwdhR87ZEeC8gOnReQteRu0O8mjC91d
         gdcA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6hPbX/tcXPExwhwu6qoUwaU1pPbZn+o9LFAXDtwUAu6ioPTQTXHj4Ss1VndsU6e3334U7MCF/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb7TNd8Kr4fibBSre5Ay42hygCQidOFjmxBx5njZXi45SD9Zm/
	/Bjvqmaqz0dzQ4uYAwf5/htbL1bVenKmFSc4Curv+MYgyFhi8e8gqSxiQkRtbr9TXkafyBhh9JC
	cLXzfgFwLNOi7c/WAdfs3NMiK7V4QJONaJyqONH8vldb7I1cs3NC2GWn/
X-Gm-Gg: AR+sD111dJH06q4VWehey/EwY3TDRoMGN31TOT3BIss6XztKElpfNxD6RgjYtc5cHq4
	ehkbTnK3qDNZo8OKRGRhxhsQXYjcizycWU/3ZWrUlu/wBuU3XAGAwkcokv/TtPq2TWReoQp1/BD
	GJr+X1096p+a3FOgnYv9lLN+COOFAnbTBFT7VjUNDJuo/OTDOx8Iuh1ouS6yolyR5mAXd0S+MKB
	pBUHjUChZsOFxJIkeTTwmF/mUqMPS/cRlqsbpOELP5LyNCUh3znmdolAiBMXf21wXfOJNgSOcvE
	f7G0/AoVwwjKRuFFa1XqiXcoc9gSEh3ot4+fVgepvJpc
X-Received: by 2002:a17:902:ecd1:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2d0523b96d8mr3879785ad.22.1785511036384; Fri, 31 Jul 2026
 08:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com> <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
In-Reply-To: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:17:04 -0400
X-Gm-Features: AUfX_my_07XA5O156m3d-t8I3fv7r1HuUVA6nIPOKrM8LOdCX7kqs7sLBvl0mUM
Message-ID: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
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

On Thu, Jul 30, 2026 at 8:01=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Based on our discussion in the v5 patchset, I was expecting to see
> > this under security/; did something happen, or was there some
> > confusion?
> >
>
> Nothing happened, perhaps some confusion. I was basing the placement
> off of Kumar's comment in v5:
>
> > I don't think we should do that in v6 though. What you're describing af=
fects all
> other xattr kfuncs. That's a broader discussion we should have separately=
 when
> folks are back from vacation, and more importantly involve FS folks where=
 the
> code currently lives. As you say yourself, the lines are blurry, xattrs a=
re as
> much a filesystem concept.
>
> My take on this was, leave it in fs/ for now and then litigate the
> placement of all of the fs-related kfuncs after bpf_init_inode_xattr
> lands.
>
> Happy to place this in security/ in v7, if that's preferred. Apologies
> if I misread the thread.

Okay, it looks like there was some confusion/misunderstanding.

My understanding of Kumar's comments was that he was referring to the
exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
not necessarily the new kfunc you are proposing in this patchset.
Kumar is welcome to correct either one or both of us, if we read that
wrong :)

However, regardless of Kumar's intent, speaking as the LSM maintainer,
my stance on this is that the kfunc you are proposing must live in
security/bpf_lsm_kfuncs.c to be acceptable.

--=20
paul-moore.com
