Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B782376E7
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597240; cv=none; b=KZ7iuk86G9ebqQ5W1b6M7DCx+CqJS3TmdWS21QW2WABqfblH4bs2g0X89tWAKKUHO0BfRXK0d7hU220e3htWJHJximm0MfT8EdDgtpV2HXng55wCdO1JmKq05Ll66/gDDQloD88KLN1N3zUjJG5mqqXb6lUwUNIE+6HOX1qB6mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597240; c=relaxed/simple;
	bh=vHzrEzooH4K8CcIGUei7pRVS17MmHjHrMcmzZoer/Ec=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Vwv7/duPdovlsEbPkdl6J/PeIdmV/XpRu7pA1fEuGn1W8sJdK8XkeOmwQp70PkxMpMBtkzP4vItdXnlc2mzuoMuCwcOefEGGvl7a2d6pyQ0/nbvDJTDnbLTQS/Q9+xVbRVSMSJZJjEbiP000OwW0hWiY/bWWmnUyw0aY0pUQis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PrgrgjIB; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PrgrgjIB"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4721325e3b5so1226111cf.0
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 11:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740597238; x=1741202038; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=PrgrgjIBDzFyuCW0/BkssmUrWr+ejDo9K2GOMxCGaRhnW6xhcbtTD1JwwVGKLo/83P
         3dM9rKUsAMq62CVpok1RfQHA2wfcnXMzJ18qMcZcYUdGiwaEKk+ikc6U0hO+hXP5eQ2E
         NyqwDG/QmtPKzQkkLdTGYwhvbp9CTaW2CN1tiR+JGk13bm+x5+rLq5IqlamFPgOFO8PM
         HjoHxNDXIv68a/z/4EiqGgLE/s9X5kBDvYWorhxzCCaJ/Ef6jGrbARuL5iiZvdsP0RaR
         Wk+ZOlH0gvpRUqepXN07eMUzObSySHsdNfhHZlo1wCex2FQyD78d2/r2De4OapeVF9iC
         RAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597238; x=1741202038;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O/7HubgIS3yguXLFwagiKL0MIanaDsiXeL1ZcDJnpI0=;
        b=DajdVcyJDulvw1wiY7zVWpNA2HIPXD3PHCRGtjpfyveTddw3trNS4hlJGIWFreoWhJ
         EwkPT07jF/PgSrDVBWW9+160KoTf9kReEWWqiFL8nG0w2GvdShK1xNYfoOSnmqJCsHI1
         PhQ+UNQ27pUnOKicmtQxHBHR5oqxAGnorhV+plrgIkQxqnqTbo6rmq11ELDxkmu68Ji1
         +pzO1vpMnh7vjxe9F/pTrfP5abzBjJ196hV8U3lUV/e1csXiPAvfMmsbuDgDBveQQqfj
         CLC81b2sEe0YW/yoyGwuncTem3ySPtn+QxmcmCzzzmxrCA6o88pcxboLk5+qIc6zNV8L
         a1zg==
X-Forwarded-Encrypted: i=1; AJvYcCUdOZYdt8xFQqWsgYkh7n6n85883+2TgkHxhWYJQt4PzWVxoJyCOUZyCg0hZH3pUUSuGgm3RTqa@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHpdl3LsHpNyjHFGKZoxiYcftBaWpmUd4Amc4lh2neCt9+ReH
	QgQrmgGEPP/6ybLOvIhjkNEAQf1gXcO52UsXPrDCAGS3jsLPO3eemtZNauwiYQ==
X-Gm-Gg: ASbGncuf5Gm1VEplsEuybMCR7l4ug1kvJioen9aAM/2wR/EKKwcc1pQRbG6HDrzMhyn
	UNY51Ubf/88lZqOLjto5ywdS8s4UXvKMKfKAJRdUBAv54GUJCt4CW4QF6dypeL5xISwcZCAA9UF
	u3jAcJBpPy+t4zdGW7bGacx5O9Q31JgEhdwa0fL76dcqOxgvSLQfhMM+ZWVV48anS3RbwpsCPBt
	SI2BuZfE6ZdaygZAHPdBntOS0Dh2wbIHF+H+rGDOPGON6t+oT8iTol4PmjWnL4PfvRh3x4oP+uI
	GGrdMVLNDjK7kWQxu38elaC6M1Im2dz8QUZm+WxMUFe4MRiInnPVFM8pFvcSwBAY56kG4b0=
X-Google-Smtp-Source: AGHT+IGZKQ763FRka4tXmeqX9uwcpJ0v96pIEchafXYFD2cwhU7ih42tfW2HHRWzr2HQKaEkzBO+qA==
X-Received: by 2002:a05:622a:1a07:b0:472:201c:aa45 with SMTP id d75a77b69052e-47377116ed2mr109013401cf.9.1740597237709;
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47377e1543csm28407591cf.27.2025.02.26.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:13:57 -0800 (PST)
Date: Wed, 26 Feb 2025 14:13:56 -0500
Message-ID: <41cb98ddf724ade0fc529b8c952f3efc@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, jmorris@namei.org, serge@hallyn.com, rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, selinux@vger.kernel.org, luogengkun@huaweicloud.com
Subject: Re: [PATCH 1/2] perf: Remove unnecessary parameter of security check
References: <20241223070650.2810747-2-luogengkun@huaweicloud.com>
In-Reply-To: <20241223070650.2810747-2-luogengkun@huaweicloud.com>

On Dec 23, 2024 Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> 
> It seems that the attr parameter was never been used in security
> checks since it was first introduced by:
> 
> commit da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> 
> so remove it.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/events/intel/bts.c     |  2 +-
>  arch/x86/events/intel/core.c    |  2 +-
>  arch/x86/events/intel/p4.c      |  2 +-
>  drivers/perf/arm_spe_pmu.c      |  4 ++--
>  include/linux/lsm_hook_defs.h   |  2 +-
>  include/linux/perf_event.h      | 10 +++++-----
>  include/linux/security.h        |  5 ++---
>  kernel/events/core.c            | 14 +++++++-------
>  kernel/trace/trace_event_perf.c |  4 ++--
>  security/security.c             |  5 ++---
>  security/selinux/hooks.c        |  2 +-
>  11 files changed, 25 insertions(+), 27 deletions(-)

Now that we have Ingo's Reviewed-by, I've gone ahead and merged
patch 1/2 into lsm/dev, thanks everyone!

--
paul-moore.com
