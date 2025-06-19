Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4A246BCA
	for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750363998; cv=none; b=I/gyncn/VOIVhCghPil0zi4JLq8/AtHR6CvFRDcVrN7qf7SY5qfQCnDxUji6/hrW9jsFkkmUPjdLXAb7qSY63dROw3E4WkYJoNJq2gnZkKhtqH8tUwIRskQ2tizZogU+UJFmQEAGMj1WlGJ+HQcjA50BMU/bfXyZ4LdXf6ZpdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750363998; c=relaxed/simple;
	bh=jMbbnaerEHkPda/g+sZi/+TTUduIL94TQTjRU02tcqM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Ojq5JN8QCLwrfYZMG843s/KBYPE8XkgCJCqgVxpj967t81SsE5GMNFDLJE8ev+idpnP59a2IxuLAOYIM0X+4t0DkQ1Sp6jtnUC6C439P4WQjL5bKygoxnpBFvpXEYKAif3NZttCdUfNF5yOq4yQo7gl5s+jYmWOkZiU5JlxaRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c2bZC8Vf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c2bZC8Vf"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so128665485a.1
        for <selinux@vger.kernel.org>; Thu, 19 Jun 2025 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750363996; x=1750968796; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BNQiXM3IKCIJZz0RPXvHlifpx1IfFaw1zLl9Xrunb8=;
        b=c2bZC8Vf2R+FlLwySverQrwc2j05UIKTUNj2PlWbw22qxTYIS/8avyO7+c6eHuj5gW
         uPvVe4bs0KW1+KwSy87tR8dmfhYziMIL++ho+frHUsDEya6QJecZk5wt0o733NIjn9NN
         gSi9jl8uEs6myQiwlk+ot5JZJeVCf8Yh13CPA2yQYpjflorf/pqkQ6mfwQXxPaiHVYyh
         xezEFpxqS0SbaE3oMk3Bvv9cQyISRXA4+0YAkA26SilNDYrrr4pRrRqOFxrs9rkWw3sQ
         co/tZDrTlOeURVmdXdv1igOYW4MQsFcc/mndJpPU4FE2FSfQNoJEZw52GiPwtWKcbHXI
         REzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750363996; x=1750968796;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5BNQiXM3IKCIJZz0RPXvHlifpx1IfFaw1zLl9Xrunb8=;
        b=TTyUwau+f0vTU6HYVw2R2xibqyYTu2lhkMMSdYlFRG1/dbMM7gknJ1oXQo4jEW/1Fb
         /LcKSWoPmfchFfkCKbH0i+ZGdbSub0MoZl290lOBymRyNj8tF53Cb50tU0MmbGI2Hk/E
         weXCiD9HNevP3J1OqpTtUPZbLOFh42uf8ZI6s16g+KY/ufb1X9P5Y2EKJ0r0fRlK33NM
         axghyraqGzLeSc/r5EP7UGlwpJMDRqjl/4E4lswv2j3MoiNadC77YMq7msi+YVlwo6Q0
         UVK7TstkHCtyTNHQexntVDVC6mxUyZrZiqclFzHGCCAUNesSZM+X4zvOW2p5Fpd0sleo
         jVPw==
X-Forwarded-Encrypted: i=1; AJvYcCU41gCR6cQERd046JuHRMyY7cZSSvA7b+yyV3BGuV6DBJvPaAw+WnFjCTs6NiT2E+9UO0TrbwG5@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqAAZjDaoxv6aNYEkvEmHd0zrNr4jAFUNBq4htwszbXAJ7Jlm
	ZnuH+ukGW4vcyIxA/OKkQqEAPthTY1aHlzuPukAFlRwT1Y6S7he/aBC8C6k8/00uDg==
X-Gm-Gg: ASbGncsTbXu2MSXaiki1Mb7WJwPwSKuFhIuNJjmqjKoai5G6mATSuYzH8KQUQEe1l2H
	blRYlEnZ6i20FfVtBbad7cxbIUtCUMfT1rdymdcoiol/21O3FpuCKigFkgAF61a8bPRaR0iPSU8
	WVnGxnP+mXoCLnEJx8A/XJZ7SF6o8fp0uXCbLEzQ9FJ2HggvuYR2dXK+tq0tRVEiWg1RiIgJaLd
	ITc4PaYqFinY5KhOCBo58ljnZNSNpVhpENEFtzYm1QVXlXX0f9DTTlgriJEvf0LmJBITiCq0+K/
	rw8yTf+ualY0cEP9+o9QvhXRhHSIxspStRUAyar4TCrG4O1ProolBren7OX4dpknZHJuHgXgc9y
	AU8XTSjQNPL9LiD57Nmh5HN4XHn8tfyg=
X-Google-Smtp-Source: AGHT+IFBFBiLAqRlxVvp10FTPiFe4NVFqWmU8+IGdeaqHveWdBEglulbijBMHIKDvRCU0pg0LLoNBQ==
X-Received: by 2002:a05:620a:1a0e:b0:7c5:9480:7cb4 with SMTP id af79cd13be357-7d3f9c1158emr48615585a.9.1750363995668;
        Thu, 19 Jun 2025 13:13:15 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d3f99eec8dsm14864585a.55.2025.06.19.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 13:13:15 -0700 (PDT)
Date: Thu, 19 Jun 2025 16:13:14 -0400
Message-ID: <1a537a78504b326a2da4c26df314470a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250619_1608/pstg-lib:20250618_2237/pstg-pwork:20250619_1608
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>, Guido Trentalancia <guido@trentalancia.com>
Subject: Re: [PATCH v2] selinux: change security_compute_sid to return the ssid  or tsid on match
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250610194826.80606-2-stephen.smalley.work@gmail.com>

On Jun 10, 2025 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> If the end result of a security_compute_sid() computation matches the
> ssid or tsid, return that SID rather than looking it up again. This
> avoids the problem of multiple initial SIDs that map to the same
> context.
> 
> Reported-by: Guido Trentalancia <guido@trentalancia.com>
> Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot processes")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a compiler error.
> 
>  security/selinux/ss/services.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Added Guido's 'Tested-by' tag, marked for stable, and merged into
selinux/stable-6.16 with the plan of sending this up to Linus next week.

Thanks everyone!

--
paul-moore.com
