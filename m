Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E71CF87;
	Fri, 26 Jan 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281402; cv=none; b=GKp7Fn1vaV830bvkCO76OfT4DippVmsoKJoP19EYhyrByPU2zhjwCT6wOpsByDUxK71MM79iSJsJ8X0uYaBemOyY95qXswQTQJx5dC7DJjJXMTNTm6IFeXeiDLVJnQFjjHbK+rapmsfWsaAwXeMiUTcFbFL3t22Rite1O8SYRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281402; c=relaxed/simple;
	bh=YDUHF0TkD3k+qkxD2MsCOfqxmeUw8/WJEGeR/VEljl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmVPqwWwErjDLIw7waiUC1/ATDXJX1nVBlZVUGcYFiZhW+29jB4VsTs0bpqeyXcoCn+a54NhwiU6Hcoy/p+ViJPG+U+QSHKFxowsVYwCoGbBDo8QkpLBzjA5xG7yUFQUG8RmrGtb8EheAa/F6+Moe5mhh6ra7OKJ9ktqS7jT/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGkgaeFW; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGkgaeFW"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso374581a12.2;
        Fri, 26 Jan 2024 07:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706281401; x=1706886201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDUHF0TkD3k+qkxD2MsCOfqxmeUw8/WJEGeR/VEljl4=;
        b=LGkgaeFWkeQMRFfq5VRkej/FmNr4/nbnFMu/NcrkHgMDB5LbVI6y64bl4LHegFe7/s
         /FeVpdXMf2s+EMY05fX9fUm3H5E/01/Mbr8u5J40p2rWzCTmHqf5t7LNin5IpLQkhF2t
         MJKuhdEUWrFcuHv54ge0g2xSl+pphcrhBhXnSu3JoXuqbOGq3V9Tv6SrEbxP44W/23XT
         Ne+luVO6FhXWLmiQnkfIW0XZQbuip68MD6JsudRXMCA7hy3pupXr0nUCaxSf4BImnEpx
         AQWdkb+TbA/7gVXNJntSxP96vdYPEZl5jRJzr6h2jAiKiXHCN8f5N8R7tvxhR+tv3o0T
         45lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706281401; x=1706886201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDUHF0TkD3k+qkxD2MsCOfqxmeUw8/WJEGeR/VEljl4=;
        b=fHnR3W2hgpy4XRac5JNY5rWGZb+1vLeNW8Ur8CPB5xSRPpqUZAEdaKzZW3HcLLg18N
         YpIARy+SGZ33Zmn+RwZwpxTWF1Cu6ysYy9iIxcl0DCTLiNXOqDjUICYMrP8l7ozEeypK
         GF+YvoMuGvigZU3xpvPm23fO6TBdIzVEoIOcWQUVQ14YTxyCd+HLPiFnL03345O5e0mq
         OtvLwCcZlqL/6VzD3Wnbz9+KQHPG/s5iTISqVZSeIfOAIXpgVhiX9CtoiSYsDxlbIF80
         O2IJBId1LEAXL3Sfa3LkuZuJmpYHmldtwuFVl2RlGKEnDmIE53+PZIoKmdVPKM4eh6Gz
         kBvg==
X-Gm-Message-State: AOJu0YytewVpsg4hbwF4ELoqmauk/ijt1t22/N9zjK8EK+YtaODPXlBz
	Xz534I7hfXDgeVj2zUIz1NOcO9W3lTP8qmejqd+KiS00+lS0W/tu0I69H1yqYOQTONW6/gSTZqI
	REP1XZ1TsKPOWyUitH4RzvLLN04c=
X-Google-Smtp-Source: AGHT+IFbtO+B8dNQvCSbhAXFQhD7f3Ga7hWTMnSNqAsN2UexasOVlMgPxEyox53VqmdXxYkU7dxnQFaEEaTUMlhpDXc=
X-Received: by 2002:a05:6a20:3cac:b0:19c:7bc4:6c9 with SMTP id
 b44-20020a056a203cac00b0019c7bc406c9mr2016947pzj.45.1706281400446; Fri, 26
 Jan 2024 07:03:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com>
In-Reply-To: <20240126104403.1040692-1-omosnace@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jan 2024 10:03:09 -0500
Message-ID: <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 5:44=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The inode_getsecctx LSM hook has previously been corrected to have
> -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> behavior. However, the call_int_hook()-generated loop in
> security_inode_getsecctx() was left treating 0 as the neutral value, so
> after an LSM returns 0, the loop continues to try other LSMs, and if one
> of them returns a non-zero value, the function immediately returns with
> said value. So in a situation where SELinux and the BPF LSMs registered
> this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> returned 0.
>
> Fix this by open-coding the call_int_hook() loop and making it use the
> correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> other hooks do.
>
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90j=
YPwRQRAqXxmOKD4Q@mail.gmail.com/
> Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> serious issue that Stephen reported, some of the tests are still
> failing under NFS (but I will presume that these are pre-existing issues
> not caused by the patch).

Do you have a list of the failing tests? For me, it was hanging on
unix_socket and thus not getting to many of the tests. I would like to
triage the still-failing ones to confirm that they are in fact
known/expected failures for NFS.
