Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433225DB0D
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456075; cv=pass; b=gymwkW/q1IbcG4MQoiKkrnhCvUJXGgMPplh/GwufgDTDHApIqoQ5nLnBnjR1kLQZfImlWlg4L/2DbTOOHoeGjaWf9XsgyAuKQdfJEEiRsvS8IAYrBITIcCJNqo64K1IO+BCEAUVnjVHvv1Btr5CBdwqGyO1M/slaIv0uiAhErtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456075; c=relaxed/simple;
	bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZZUlS2mwMbnHTFSM8jb+UTNT5ewiAHe4dTlRqNuUg8nLMFdHnnl8jS7rlO02uHhXzaH1Z57smf5dFapxMzf6h1Ff7NizBlUEia+T9HtwqF8yDyU3vykLSJpeN/Fwge9sJt6s2WgMxXjrr0XqHJeOFQfdi6t2eOBQevHDub/eus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk/DigPl; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk/DigPl"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5218927884fso3151241cf.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 17:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785456072; cv=none;
        d=google.com; s=arc-20260327;
        b=b4IBs070zC3IKxXOXPtFh7wEPeyZOmUpa1oFyLmKW60CEPm9xgKXODepQMwaHvjlwI
         mvCtCCIOjQTcACqpL6HIDZzh9bgSteeus2OW0X6CQoS6Pwl8+I1bD8kpSYYU3yagEpEQ
         rZnhy920NgFJKKkRRxScHMwrf3R+QEkQnQm6uD2+h14tN6ASumDWZDkBRxDKH3ZgJzph
         bOD3hV7ct/sS+8Ai2bwSJeXmlrmfB+N/9LgBHW7jRkK8CAh6wsf5CY/BZdFvfK7DYjnM
         OXQ4nRd3kCyuwKdurNDelvU5bN7V0DlnjPm2RioF9djZwBDbnn2DXYMh2S0sEWgVM79a
         yGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        fh=e0RvG1bIfvGnKuNFxmpzRUxF8QnnO8JJh7Oq1al8mJk=;
        b=DdsJY/duOzBKlHClvwQ0+aTgDiuHpC1HqiJhWbgH0yirN28CiiiE+8SortjPlvmFsG
         9DHOdtDODmSI7SZ6z7b7ISKjno5ufQJCGHzTqkhlx9a8mYjtTijmPSreZg3EZI3y/eEf
         nM2S3qbrgxBBU2ClEbM5ZtEB86KLpXODpcAlrcC0IGlXMceBaLd7UdHtUnYKzTtmLGPP
         6PjPbdfP8ikp1QlyYEIp0wEg0jow7WeNI1EADotohMxZGM6JN0Ig+jSkPk1IonAggLqd
         2qtQIntUEABEeSDmaU6I+u3lRbkqZi6h/VuP5yz+nBrfh6fiIjRUuyqCXUD0Q1cSu/GV
         rViQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456072; x=1786060872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=lk/DigPlxuCIVbt879jIb6r7+Nmnr5dRWu2ogJeOmjjYjmD3QHGH4CSuEKHKoWHdhn
         AkdVhyIiBI/9atob2UT3f3XBr+Gwe/XQr630TJhEO8Td2mvak+gSBnKOsvd7JDzA2BpU
         802CBeK1z42D9bofWzkflLi+NCEfsgwcPJc1UKLMxl36m5WuF7T4L4mzzcHfeuyeJuK9
         bcFgGVdoJvnrF2886wiECWyWlwHg9e0BOXhMICgDnf8EmkLNVlCKwPfyw6I5QEhArx2J
         SDVPl59nY1Z+PfLyQ5k11S2DmN7I7ltlCukpdmARMsRI6b57LbPsiay8XnUQ7GT7+xj7
         MSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456072; x=1786060872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkjv3zkZuKcst+AaRQDTEpkwTvvO7l2pCMgYw+titho=;
        b=CcHCTAmdVGicsXMWWyxJvZMQqXzJBvr85c6FYbksXQSy90QQsPOr2NT0k0CTu6/hjr
         qg1nGaJ1pY+MwZw9/+PnfSnYJtQI0yBWt7ebCOAimFOklIOePDP2ZthCyBI3/NodXjb7
         JvWWUwdPWytTAcz3qvbezzaQ3yCbYzp8iDhWXpsomvAv8AE+oFBbN5VLhI5XY0XRfQ0e
         03n0e8rDdJhEjg7IkPMWSX/N0GMOFyJ0B6mEv+IAmkwYkLfZZ3QTlxfKgjymyGMYbGv/
         gDJKZigisvnd/fQazUghkp5p/zEKYf57oGSnkTjz6eXn/nHEuKzPceVUSjyff9U7K+ui
         n1RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp39nHupOX0YGluXGPA3jx8ZYDMxjrKcaG/z7/hj0sH2HrFwe9Kc714jssjLGtNZ8in2aTb5CI4@vger.kernel.org
X-Gm-Message-State: AOJu0YzzviGeAws4Sf/Ntts0jMOygoNkjyoVTCZjt8voJv9wiYy2lBtS
	FkrFxXVoEF99BitNZECZ5Zx6kxVawuoLi5ozrz8RpgZJAAMG9t7HO47bK3dgog5AzYDK4WKWYHR
	UyS7MvV0mB+eeV0vk2d11/jevGMg0Zes=
X-Gm-Gg: AR+sD10+0Vi/gAe9SaXUIwJhXDzSqC5dGnOIG1JEMxMnKVWYP3INmAurWlQ0t2y64zs
	wQVhX3Zj/HQgMfl4U6b0x3edey3k2OnIdecek+hJftkuk02bxjljA8halJksaT5gY1YlMfted4p
	AXu7/n2+9nfwr1QOFQBrmpvWTASJskNbaCGZP5yy9tS7GyZiu0F2CRATppFI7tLvMrD65vP5huf
	JQwL99C8/gVmONwgDA9zaLJ9iWHNZCqM6Yg9Nt1XSGdfEYQsKpwYAtZyQ1LZ4Eq6Z3iFv4hF+tr
	oqkVZLIiRPwgURQ0juuvdwBMyvq202VDkfdTIKU58vQlkn7zBRQ14c/tbGpYZMALhpCW+2j0vZk
	=
X-Received: by 2002:ac8:7d0c:0:b0:519:e3e8:85bc with SMTP id
 d75a77b69052e-52b4b005354mr130221cf.37.1785456071885; Thu, 30 Jul 2026
 17:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 30 Jul 2026 20:01:00 -0400
X-Gm-Features: AUfX_mzzLAETGk0-GNkiDsgUNvOmEZOv-UFFgDdgdht4DdfS7DnllTiGk_VUitE
Message-ID: <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
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

On Thu, Jul 30, 2026 at 7:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Based on our discussion in the v5 patchset, I was expecting to see
> this under security/; did something happen, or was there some
> confusion?
>

Nothing happened, perhaps some confusion. I was basing the placement
off of Kumar's comment in v5:

> I don't think we should do that in v6 though. What you're describing affe=
cts all
other xattr kfuncs. That's a broader discussion we should have separately w=
hen
folks are back from vacation, and more importantly involve FS folks where t=
he
code currently lives. As you say yourself, the lines are blurry, xattrs are=
 as
much a filesystem concept.

My take on this was, leave it in fs/ for now and then litigate the
placement of all of the fs-related kfuncs after bpf_init_inode_xattr
lands.

Happy to place this in security/ in v7, if that's preferred. Apologies
if I misread the thread.

-David
> --
> paul-moore.com
