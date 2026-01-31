Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521A220F2D
	for <selinux@vger.kernel.org>; Sat, 31 Jan 2026 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818993; cv=none; b=buHi2ywmrOSxKE8d1nUzKXL0iQsXOKJn+R3Z5M+iGT/FB6F5+uPElV9SHi7Ltwo62uKdJJvGM6vF9fWgzr99kiIGO2Rf6z+J5aAUb7R9865v9uuIPfs1GP9uAfHdvvDxqUivyXbbcl/8o67eiaOB08YKKdutaFgXC74rNsdFBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818993; c=relaxed/simple;
	bh=w7+B8N3XRoFg3Of/Fw9iyPoy/mghU2Qrl0CPBbBgDGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaWN64tvDhVIPnEFAJS55k0H5jTF6i3saNSsGlueQIUptRT/K0j5NEz6SGyF1J9Z/DCdE2EKv5yx9sew7yaKZE3PdSBnq6lqE1AH16RTPEyFoBUgNP4m3au7DapA3ZVUJTyNmXcOn/x/aWanQHIVSuC3b1ewUlTSMVZwfIAF820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=coPGsqCL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="coPGsqCL"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso4328428a12.1
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 16:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769818990; x=1770423790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qV4mmOV+uOXX/Y9XduJfQAli873FtpKVEKD92eDGYCM=;
        b=coPGsqCLgU+ZSpVZQHdvg69Eowv0S76zId/42jYFSqftxMmWmBZs6uaKmEVswpSo+8
         3XwLmmhD01so0JLyrm9pLdBVQzmbzzRwJs4Ox+5tJZxjHocTKt8e+hvqG/bnEXBp1Zmw
         nRIx7EY3QGLSK9IG/lD5HYbWAZr+KtwlzJOiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818990; x=1770423790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV4mmOV+uOXX/Y9XduJfQAli873FtpKVEKD92eDGYCM=;
        b=bqmc55RVyKnyTrUAplJhQ4rK0NYvpI2zl53OHpWfY98CvJIIcEGw/kV17+g/a/Lwqe
         SncDzu75jhgT2ncae95NxJwvugntpsR1kVRqZLkk4mOJej0uA/BVQfWmzvwqGxEDwD4B
         kHaicdxAqsIyXYMGWeiILuG7NHQjQrzpN4b0ZKh5wAH5IvJHJOs5eCsm0yVorfdrhXYr
         jKLEO2LHlN65xpwLMhnF/CUqkSSX63U/uelUfzL+SiqcJn52UBfcANKLdFozI9ZRTs+c
         VDnMgFR5TOr+C88HXSoW6tO2Us+hnZv89gm+mty1Mk0o14J++/tQYjlir0MvEAAHkuv8
         EgKw==
X-Forwarded-Encrypted: i=1; AJvYcCXxcc9yqWNWBCSFlHFurZ3Vl8Nx5HvpsRoKsQ1uBHxytjzLQPRSy2j+SQwtAYrZSVeUtTAIxkrP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4hnPkbO4nV8xhx7qDsTluLDCFDNa2aKcS5m9yA7V525Dh5Yt
	bpfWPi2ZGaHROihkHfjU9OuFeyDVeLCvtUqcmMlBGw+GWtymcjq/H6YH76VR2pV6VsHh/MCV9IV
	0A6zF3NM=
X-Gm-Gg: AZuq6aKi672hQ7h9eznPry7qsv1t8dpxAeKk//4IofuyysGyx83WJbTt0TWB7aiGdfN
	St2rGoM/UJdiF/sr9uzw6MU8e2syhF8mvTX7nd+kjYqlLnbRdrzMsI8MgoxDdJ3x7n8JVSqBpgM
	wxUvh4R/pv3J/gH7DEguVvbocM8G2tdXB0kqPgUtvRR06dh9YCKPBRCCjKvkr8XznPUR4ni3iu1
	/ybaoRtDksdi/CgYCJeujNSHFDTPIPgrdV4vmj1P7UDDeRRPUTnHBqqX1CNmdnyWl9uXC95tMq5
	wHJ9wu/nGO0musdWuLrvmB+SetXFuJvRS6McG+dLjeJs+WqMYLQjHyX6cMJk2MJi5SaLPcXG5fL
	pKNxJWh673YLsDiYHgTgo78q0c+rfuuxvvvIPNIwd45CKpiRpqjaegAp3MNcekCBHMr5QgphqbM
	UeIc9on4x8NWJZQBm/k8BpAEaraxikX2Dakaz4YAmTqE8p3kZwEqTH7TdRpnWZ
X-Received: by 2002:a05:6402:3587:b0:658:1274:3841 with SMTP id 4fb4d7f45d1cf-658de589da5mr2709599a12.21.1769818990163;
        Fri, 30 Jan 2026 16:23:10 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b469eb9fsm4819115a12.28.2026.01.30.16.23.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 16:23:09 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b883c8dfb00so636898266b.1
        for <selinux@vger.kernel.org>; Fri, 30 Jan 2026 16:23:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuFNg3UYo67zGpdReVQjAKl8hhgc2zWJ0dUf4RdeHdx8A5t3nSr6aboZwvoZZ6OJtMGDzXxYTN@vger.kernel.org
X-Received: by 2002:a05:6402:1d54:b0:64b:4f44:60ef with SMTP id
 4fb4d7f45d1cf-658de593957mr2779765a12.27.1769818504441; Fri, 30 Jan 2026
 16:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
In-Reply-To: <20260130235743.GW3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 16:14:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
X-Gm-Features: AZwV_QjK3epqif7-e_sBGUc-n0f418Z3nV80PkvQC8yX5DIdQ4ynfWKt9EE0KMI
Message-ID: <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jan 2026 at 15:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> So we have something that does O_NDELAY opens of ep0 *and* does not retry on
> EAGAIN?
>
> How lovely...

Actually, I think that is pretty normal behavior.

Generally, O_NDELAY and friends should *NOT* turn locks into trylocks
- because user space has no sane way to deal with kernel lock issues,
and user space simply shouldn't care.

So O_NDELAY should be about avoiding IO, not about avoiding perfectly
normal locks.

Of course, that horrendous driver locking is broken, since it holds
the lock over IO, so that driver basically conflates IO and locking,
and that's arguably the fundamental problem here.

But I suspect that for this case, we should just pass in zero to
ffs_mutex_lock() on open, and say that the O_NONBLOCK flag is purely
about the subsequent IO, not about the open() itself.

That is, after all, how the driver used to work.

                Linus
