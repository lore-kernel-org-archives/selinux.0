Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B724CEF1
	for <selinux@vger.kernel.org>; Wed,  5 Mar 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191140; cv=none; b=FDr67/5cFkx+lTpiF8xQLPP9BzNoWCswlp176DsRYMIaHKdFEjRTQc8MOsR2eSPD43h0tvyPAWZiCHd3RYysTJ7ch48V5vzcXgx3UpI3KSuUR2DVi04UMSAqQmImdcyyShJpn94ZIxxgja6HxGycj+8Ktw1kfZRgQcZ1mJPRcnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191140; c=relaxed/simple;
	bh=2q39nFob89uGjhIZ3SJiCBavEHz6XphRtukgeM+fPHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqUVP4ejTmyLm0jmkoZdbdaFbVLnnRG1VdLZlxP6HhsrMC5b5F2a8HB+UQ+REfd8XK/iOh7Q00Yu90Vlz4/nrE5UfXZ19/gHg1c9QXKV4OepPGEVoZOU5fnwsiTHJtDdQxDp7CF1ryZjDXB+2R+ISmMouxxsRSidRMcEpAUbJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GRCmUsk+; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GRCmUsk+"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e608b2698fcso4969603276.1
        for <selinux@vger.kernel.org>; Wed, 05 Mar 2025 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741191138; x=1741795938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR6v/qJNcz2018VPIy19J59hCQI20OhNaLeBeMvMyms=;
        b=GRCmUsk+KxmEFI1arAP0wyX/T/tWMTzc9ZJ+oF37MOw5vKZfVPQfE3GS0AImNbqEV1
         t/WJ2kUcsQ5FaifEqil2ms5vhwPJQ+hEC63dbLxWoLgBqQ6trVqZ7E+zSPAJrxuxa0g7
         MW+oYixfDflRvccCzn4GSy30B9Ya+nS/f8qDuQuD0CxpbB+bWLdykfDgr9KVSQkJljrN
         l1y0PRKxER4TdC3RI1kd3hAyKXX42y6Qa+rcMX4VXy1WjHKFMx0rfPllrQhKasdPcE9S
         9TSKHrYxV5yE1TujVK03fCfYDAsz+IqXT49919qukuVWrrwcJqugFSc1Lpg4PPv5OeQF
         fEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191138; x=1741795938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR6v/qJNcz2018VPIy19J59hCQI20OhNaLeBeMvMyms=;
        b=E37bXs9bvTAlPxFE/V+bAisuQy8zcQPF0bKXOE8rRn+JdJjfQphHv0cSF0OC97zwrJ
         x6DTb2N1OA90uRmcpi9iaCPzR8ax8Zh4rzzw1WxTXx4axQsFOa+6rpvZ+IqeeZoPAlp/
         M5IHkaWXNOqZO1E5yHiCD1plw0IKKKISnuJEwgO8hksTgBWZKo210k9gFLdCuFlNJDhv
         rHCCXCJPSdMy/ZUEHS8gkW1ZDcm/vkbR45QAQn88tPg46pFpY81f8QSPJdgGNhfBwnkd
         +gtSwvnhzYbDR2bjtm3NIM6gEXcakHw5ySiIwVKT2qyqYBydpeH6FUewt7PAeVxT2D/i
         c/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCW6mZAbP+NtFqTxpPCqFUfBEnHLEvBvo9yK7XCPOCglfzcU5mtAuvU8s8w8zAdrgzOflGl2gPN7@vger.kernel.org
X-Gm-Message-State: AOJu0YwxaqrU08QHqOGt1PjQgJSoU9kUXRfIAubijwp1PTJhf4ypVZ3l
	0iLeuQr/rp06SOmOeVw/dPb07ymAaDhTqXqnKJZK90TcZoYS0h2xZx/4vzfdt3Uu9VuDpK9ZxAM
	nz5qmdDOvgLov8Os3Ekni4btcZaAMgAVIhGDm
X-Gm-Gg: ASbGncu5MZkRZYxrBdeFKW0JxevxhlFQYBzfGm2HRaFt6AmdgXBow8ZiI55xF4TtqXg
	RMcpPedLUelhMcufs2Xl6PmNsqoisTAgOcSqHoEpZheVP5zQw3Xvb3TmwAyLnxRz9pj08CpacOO
	Uew8zZ4L7YGK9VX+xeseRLxSaB4g==
X-Google-Smtp-Source: AGHT+IG2+ri9TiG/+pR3y5KkKxoz0d2KVOY8e3WkmBgUHc2qC5BioAV59fgj/NVLtTUT4F32NzzVt7ytF05Eu8bmAsg=
X-Received: by 2002:a05:6902:1583:b0:e61:1be5:d0ae with SMTP id
 3f1490d57ef6-e611e196a54mr5413376276.5.1741191137730; Wed, 05 Mar 2025
 08:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com> <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
 <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
In-Reply-To: <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Mar 2025 11:12:07 -0500
X-Gm-Features: AQ5f1Jpzk8xNhqaDNcdEV_2AlQwGfaf4RmRxkPjJlwjeTek1OtX3R3sL0LkAbEc
Message-ID: <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Song Liu <song@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:32=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Tue, Mar 4, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> > > Paul Moore <paul@paul-moore.com> writes:
> > > > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > > > <bboscaccy@linux.microsoft.com> wrote:

...

> Do we need this in the LSM tree before the upcoming merge window?
> If not, we would prefer to carry it in bpf-next.

As long as we can send this up to Linus during the upcoming merge
window I'll be happy; if you feel strongly and want to take it via the
BPF tree, that's fine by me.  I'm currently helping someone draft a
patchset to implement the LSM/SELinux access control LSM callbacks for
the BPF tokens and I'm also working on a fix for the LSM framework
initialization code, both efforts may land in a development tree
during the next dev cycle and may cause a merge conflict with Blaise's
changes.  Not that a merge conflict is a terrible thing that we can't
work around, but if we can avoid it I'd be much happier :)

Please do make the /is_kernel/kernel/ change I mentioned in patch 1/2,
and feel free to keep my ACK from this patchset revision.

Thanks everyone!

--=20
paul-moore.com
