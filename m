Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072C1EC017
	for <selinux@vger.kernel.org>; Wed,  4 Sep 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463761; cv=none; b=k82CMprw9CTuhka2cymlHVAjKTJEK5jaQj8clZj/MK9QJv0wITRLBHgPA2SRVeNU2rIwsgZ+ZkL+iwsZJG3nl05DwJatf+RtOsj7FsWRsMTXEBrwhcSDZFfrCe/XTlkdSZqAEXDW/tek6bEfHetxGWKodbJs1NGoMTmeKTsoFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463761; c=relaxed/simple;
	bh=ZZlFKwXBzjMs890VmeBsER+emrnlGI8ENbFc9GjoS4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsHDHuW4uJwSDKChf6FvYf3IOs6n5L2doinTTQp9jhLni8m5mqFqEt4fJtlKrV4F5mE1ugNCd4lVgTBjk+qjiwnrar+U87NBPrBr/vATFE5+WCrrTCTfcxyIk5TOofZg+rCoR2MyQBe+2QKUtFNCyKJZ8AA35ypDPdelRkRNV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8nDITxP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8nDITxP"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2055136b612so40814125ad.0
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2024 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463759; x=1726068559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZlFKwXBzjMs890VmeBsER+emrnlGI8ENbFc9GjoS4o=;
        b=A8nDITxPiIp6edGoS1qd1Zam3+GCPk3KP3AEpivWKTrS8PPJEHx/ghHkCOZ9bAakzP
         ilMc3H9ZJOZuS2TMxROZKRM7FDgwxUNXCOOcapmwxwO74zlAW7+9tKdll+Kv809E0xjz
         4Zf+dmILSrvgUFDubj0X11pRFoYykwgSwq6+QyFsth0KSD1zUAvtboL5YsIZYqJTss1a
         XeoT/MOTonFitIHxRBF9dVjmUKFbDOE68e4UN1HuxSox2LQORR4RjQcVthHrSuKle2tx
         GH5Q88owZ9y+FM31Ab8RHyGca0r9+RwavJ/CJFAANvH+V1nTJ3VsBLPcWW+1eUpbG3uP
         IGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463759; x=1726068559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZlFKwXBzjMs890VmeBsER+emrnlGI8ENbFc9GjoS4o=;
        b=dDMDYsW38urzSqyIadEe9tkoWJeNfBJkIHI5B2jAim/7Cu7uMERA7ShU0A1/A2ocMb
         uyBZl4e4u6HR9E5zv+ufmqAcF7bsYTL+yKx3wJB5J3ioqVKhJoVddxA7eCnIt7/AmbKi
         FddaiXmIYWx21WjdMcoHTBdm5r2Gid6fWEiNzoDXeopdZNE4VwyzUaXRK4PLrYmfl8HC
         RztnCKksKUVKO16iJ3dp86MG6suvkaB+E5J2X5ZXILVRB4L7gAxk3WjdE8GsSRrSa3rm
         a66zS1ZEtOYoV3lHikkfFFCPIzQhah3tBkr5yC+bz+D9vngq+s9tb4wfWe8VxQN/OwUf
         8AmA==
X-Gm-Message-State: AOJu0YxrXI9rdqnsNfj45qU/PNlTvgGsH/KjmmeQYsq4mZHB2yvV7kih
	/RWBkKIF0N4hrRFz+9ftRW6wn4jJBGXqhZlqFuZwwvg72ZXOQlwlzP2N2eEUsk1nRdJv6Kv1Tdk
	YIQ2uoZXjD3efnKSJfkBA1Riv+NV8TA==
X-Google-Smtp-Source: AGHT+IHgW98BhOCwg18872iUGJcj65eQi/iL9W2VNS4IAdAu7khlUUdNQ+AzpmQSPpC3yvF5CT5pYp0Ce49Fmyr6brc=
X-Received: by 2002:a17:902:da82:b0:206:9ab3:2ebc with SMTP id
 d9443c01a7336-2069ab33684mr71216855ad.47.1725463758905; Wed, 04 Sep 2024
 08:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNv7T8Tv_9AYX2xC_tJ9x10qPoPFQsQPBUDOuphUfUFPiQ@mail.gmail.com>
In-Reply-To: <CAFqZXNv7T8Tv_9AYX2xC_tJ9x10qPoPFQsQPBUDOuphUfUFPiQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 4 Sep 2024 11:29:07 -0400
Message-ID: <CAEjxPJ4o1cnQ3J8d2xE8Si_9QPM7JNuGin2Kz6NL+mu+Oj5u-Q@mail.gmail.com>
Subject: Re: selinux-testsuite / NFS symlink issue
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 11:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Hello,
>
> While playing with migrating selinux-testsuite CI to Testing Farm
> (more on that later) I encountered a problem when running the NFS
> tests: When you create a symlink to the testsuite directory, cd inside
> that symlink, and run ./tools/nfs.sh, the nfs_filesystem/test fails.
> In fact, I also get some strange failures in unix_socket/test in the
> general testsuite run over NFS, but only when I run this scenario
> manually, not when running through the TMT tool (which also runs the
> tests inside a symlink to the testsuite directory, but only fails on
> the nfs_filesystem/test).
>
> Feel free to investigate if interested, for now I will leave the NFS
> tests out of the CI, as it's not clear if the issues are in the
> testsuite or the kernel (or both) and I don't want to add workarounds
> blindly.

I'd tentatively guess that the symlink problem is merely that the test
policy isn't allowing the test domains to read
<whatever-type-is-on-that-symlink>:lnk_file. I'd try that and if so,
possibly add it to the test policy or relabel that symlink to an
allowed type.

Unix socket test failures sound familiar - I seem to recall an earlier
email exchange about encountering that myself that turned out to
actually be the bug in NFS that I fixed earlier this year.
