Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633B3955D8
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659677; cv=pass; b=J57rSO/Wz3zGaZ+GA9efEASWhxLiJZ/xoq1+QGnff7tbEV4dnj0Jr1xnjmZxH+NJUEI/nTEjqHXmRc8QODb2IS4JeRJQq7yQX/fDQuXB4HOQfM7uYPrLEdxTXNz43PczmUvqxUy5s6DUZfee/6byMTKxZl4VFQi6YWdu23t8S5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659677; c=relaxed/simple;
	bh=ITJdoCV+lrw+A6UDGs7EKKiXqTBEDtjZDmS3XA0i7Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aewI6tK15W3wBCCo3bVn+qWO5YjraIDdUNhzY2sQKPr2JJajMzhf5Sn4F7qS7fWLpYng8gODk7xdJXsqr6jGUQyuHLEg5RDPaJ+JhpLe+FJlLgkyJYgW4u/OXkzOVSMGtqpuWc5/biOnq69GfRNOzoNjDD7SoGTkXDpc7QLNP2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTyAd7gY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBbV/r9W; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTyAd7gY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBbV/r9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778659674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qp56NQwQd6ude3plol2H+pLQEZpPA19adhXYF4e+XoI=;
	b=XTyAd7gYGP0yPx36c0B9snKVGAz9PF8f1CIrE2ox6dYRexVMUnxNI3uKwguuT6TSXGiK5Y
	x9y03S1LzGzcjJEeOtAo/XstoGkDqozExnWI6tsPtJ7aT0VpHfUPKb6vHaBWuNfnKeu6UC
	XEpKqqoBJzLewxnDzHj/WeW13elsj+c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-nr9EhKPzP--FblmVhAzBfA-1; Wed, 13 May 2026 04:07:52 -0400
X-MC-Unique: nr9EhKPzP--FblmVhAzBfA-1
X-Mimecast-MFC-AGG-ID: nr9EhKPzP--FblmVhAzBfA_1778659671
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so6099261a91.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 01:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778659671; cv=none;
        d=google.com; s=arc-20240605;
        b=Lbm4W8To/cSDNnS2g1PLao2lLpsRWBHKXsXzMWhy43jKdgTTyz7xh/jtLrkmGipqcB
         mONSP5WC4KZ8hkbSOlP28sp05sdJMZmPTNOI8+xGxkJz/aELk2kgkKD18JkqOrdHbHF3
         QTCjCZ9nm9IrTLLS3fv9KxdJ1+jUdtBbfcWGq54wOZ6gHIQC76czgREJGcvGL2JxVkrf
         pKjRSH2O1DgodGy1mljMuqfKrJmwjKbbR5p3fH9YoHqAZ3GYzOSpvhGBWciyYLPU+Ry5
         0uXVSX0yHiZYne+5X93hRewsVGONzCKa5DKvOtaAP/bgmVNSjc5rH54kaby7T5kHSOej
         jP8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qp56NQwQd6ude3plol2H+pLQEZpPA19adhXYF4e+XoI=;
        fh=LWoJkQLWL94W/tKWLtIVIRDILPlsqq+t11tHPyfXr/s=;
        b=ghjCX1jSAHzROFTNzMfQhs5sURLyceycE6p63OyKWqylBGKhuQpSr2CuZ/4cEmoonj
         SFzsVlmJy6g9l8EVuCJCWDQFs66uaq3t0mngPb2jyE7lSI3x8Xi5orqKcSa7rvZhnk0j
         mpi07IOM8E2CvZ5UbDsGgcvFh0m//uhE8tlcDeLgHTfN2jKj+0pLNVD0tmOr3G7UhL6Z
         3UEgCbZ7zUv+d0CtfD9E7Ed/LmBucWbHfL4wKYcsQyrUvuQ0qO5ZN8TK/2twgFB8xhBM
         gGk8Oq9WEmUToQRTLZvGakQN000+3dwhHeahNIUmiqz8nU7efksQ1Ck1Z6tljDxsr6Xv
         8GfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778659671; x=1779264471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp56NQwQd6ude3plol2H+pLQEZpPA19adhXYF4e+XoI=;
        b=NBbV/r9WWS9JrjOL5yYCrwul7G2FO1jhlSeEDEqyVChdflnIUgYb2PW9qdL7hOlq88
         7nEv7tPWFgeKIhOljtZiG+dwL/eaA7wIv4NVDXMeM9Cu2J2n16pfQ2tmQzoRl9+ddFkq
         3TzDf+fz2ZW930xsdjb8l85hBkK/SLa6Sdf14Op4I1Iq+BWCiE92tvSgeeaUze8l9cfC
         pA2+8ydYGlfWNrPk4xPwKdi9BdZlKqTMZB0xcUavB+atAkcrjerzjh3t5QAFuKwGyePS
         avk6plDLzyL4KtmzsjCXpBiRfTaz4rLArKB3nSlY4am/5ao40jDsSVDp3OTNpkIjYxxJ
         ca2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659671; x=1779264471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qp56NQwQd6ude3plol2H+pLQEZpPA19adhXYF4e+XoI=;
        b=do/wgCkRb51uMK/JxtcQOMSUqeteEb02xOAb9I1sGi5hRY2Bq3xxdxy8w+CaYiL2jV
         89FT/PMZetlaYUqkIgZ3sKU+W+/fVjbBjt2h1Jx3+E5/jgDWp36vdCnrbjHqvznB6yrM
         HufNQQc8db5fAAE/f0Q15MBDxTU/GYR4IVZvw8k8fbbJ6LVTa7FYjxCkI0/zFhRlaVhs
         S3V8RR0CfXjbmYlO6aZvg3rfFqtoos1QCXJOxoh/4hTRHHqgJntVJ/B8HR6n9VJTeuSd
         a69gjNf8ceXgGLZ7xduWE47Qm+7TiXBnOtYLwrYBx3zJ9OJF3aV1b3QeozjjeQUCTVtE
         9kaw==
X-Gm-Message-State: AOJu0YyHRernKymfgnKeoSSEhQZ7WGmM/vttA9ekErALqFkpbwe8VP8S
	ie1Y49Hqld4SGlcFFwwbISh76GmLtjnzpxfS40g3k8ld1wkCk5r+O9iUNVi8FdfdmPrYgQNmjr1
	v4iWuSijhI81ULCKgJ8qlzmqmBFJXhBeSXj/3CukOCG1M4R46Hj/iaCV3wGSGa+MShEnU+MfszP
	oT+I+1aPBwnmliEhg8Y6YtTauJfVR06Am1Cg==
X-Gm-Gg: Acq92OFOlVa974xp2+NYM+v2Nn2GiaXV8NywegoVG2FezR3x5n2KPOgi2AVciVq8a1z
	XRJ34hYo9oxlpU+tjdOD4rav3yPBrHsbJMJ7blfOVA+ysG6DCenMbMiqZJnnVO5P7H4aafoaqIo
	N5O8qv5Y5pxXpmnbeIGeQLlYDBVOt5gWIdV5dFczbgNeAtRBOUlDWXNqixguIU3CWXue324y3tj
	VcrVSW+vbw2ej8dVxFcplN3rI3BzgROWxyThCI=
X-Received: by 2002:a17:90b:2d4c:b0:366:1bab:c3d6 with SMTP id 98e67ed59e1d1-368f3ab59c9mr2503904a91.10.1778659671321;
        Wed, 13 May 2026 01:07:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2d4c:b0:366:1bab:c3d6 with SMTP id
 98e67ed59e1d1-368f3ab59c9mr2503879a91.10.1778659670856; Wed, 13 May 2026
 01:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413175736.66018-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260413175736.66018-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 13 May 2026 10:07:38 +0200
X-Gm-Features: AVHnY4KAJ7uXHpCnABUKqxRs3c6EK-gaj8-xsVU3yvVh0oUmJ7PTg1UwxTlvMNM
Message-ID: <CAFqZXNu3HhyxguQoUgg250Rafx+JGBWKP10X1w4CfjfNWhssmA@mail.gmail.com>
Subject: Re: [PATCH testsuite v3] rename: explicitly test directory write checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 7:59=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> After applying this change:
>       make -C policy load
>       ./tests/rename/test
>
> Then run ausearch -m AVC -ts recent -i and look at the recent audit
> messages.
>
> Expected:
> avc:  granted  { write } for  pid=3D2456 comm=3D"mv" name=3D"dst_dir" dev=
=3D"dm-0" ino=3D478160604 scontext=3Dunconfined_u:unconfined_r:test_rename_=
t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:test_rename_dst_dir_t:s0 =
tclass=3Ddir
>
> avc:  granted  { write } for  pid=3D2456 comm=3D"mv" name=3D"src_dir" dev=
=3D"dm-0" ino=3D469853139 scontext=3Dunconfined_u:unconfined_r:test_rename_=
t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:test_rename_src_dir_t:s0 =
tclass=3Ddir
>
> ...
>
> avc:  denied  { write } for  pid=3D2275 comm=3Dmv name=3Dsrc_dir dev=3D"d=
m-0" ino=3D369112042 scontext=3Dunconfined_u:unconfined_r:test_norename7_t:=
s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:test_rename_src_dir_t:s0 tc=
lass=3Ddir permissive=3D0
>
> avc:  denied  { write } for  pid=3D2276 comm=3Dmv name=3Ddst_dir dev=3D"d=
m-0" ino=3D377910481 scontext=3Dunconfined_u:unconfined_r:test_norename8_t:=
s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:test_rename_dst_dir_t:s0 tc=
lass=3Ddir permissive=3D0
>
> This highlights the difference in behavior before and after:
> https://patchwork.kernel.org/project/selinux/patch/20260410192949.16542-2=
-stephen.smalley.work@gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  policy/test_rename.te | 22 ++++++++++++++++++++++
>  tests/rename/test     | 16 +++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)

Applied: https://github.com/SELinuxProject/selinux-testsuite/commit/1186eaf=
201cf72926c490431cf81a10ef516e5bf

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

