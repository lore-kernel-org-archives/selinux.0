Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA201EFF88
	for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533115; cv=none; b=ftzP37OFX3U0/QwSA2j35ypc2wdgY1bDBgNGQ9oLiVU60YpUkKcriMs9jFM7ywoplH+AmOrCB4hG7W9mgE2vqiBrj4R2ThrBmzqrH4jfKh0LrO3+QiuZ/OSKei8VcBaI0FW9pQBp2fhF3DHcsW+5aDq1waYfIjSYN+mhQ4z5+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533115; c=relaxed/simple;
	bh=l4f1xNB2dwWSdrG9upCnzaeNTP8GCePr0kItE5AT2h0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Zzbiqf5N7ktR/0E5C5G0p6my7kK4PLKQhRMRD1VDtCm1yrsgsVESsJQoaN2B2M4XJM8Wd+bGcNkuyBs0CiMn3oRBTf82S34/sIvUJBuBerrLhMbB/Kf5mgDrgJCQ+tll9yBSCBhJQ3OXWJfBpD5xuTavBXwPialhe3KKcGfzm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UPnInYH3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UPnInYH3"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c081915cf3so226281685a.1
        for <selinux@vger.kernel.org>; Thu, 24 Apr 2025 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745533111; x=1746137911; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=251+9C3n6HOhFKPLs3FnNVOnITQVSwoWuSTYkyfbN34=;
        b=UPnInYH3rId+B5sBPw0zXA8lCBZADPzWSRyQqsf5t8lwYqvuQVvPuReZ0XNwcfAlmx
         rCXglJDkAkBuHXRon4A4TNs4GnrOrq3LfncNhcKarTW9D2x3aRwoNJZZ2aOUpYf0Sd98
         doUUeaWtNBE1IS8yTA+GaNzXMA3y6PcwpCZJMtPxOtXL42SrwfTE/ngEUZ0SsFdTfd3u
         +yPiGM4ByJH++mMyC4h4lMCJGLYcfvOF0N1WJf86DibbP/Z478gJnF9fFojlwSHMPQ0j
         IFp4EvF3f/Y4OV+GJOrPMFoR2qQP5a2JRFIhFqw1jLEh6lxyIjR0VsAfTdk8Q1xyK+qq
         +hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533111; x=1746137911;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=251+9C3n6HOhFKPLs3FnNVOnITQVSwoWuSTYkyfbN34=;
        b=mJFtSLzA17quoo0etO5Grj72UYpV3dl2ivDLgAu8Wsstwc5byqWaMpg8FiUjZaRaig
         q0LBnwXtt3C9p5+T3sH6kLs7NbkjGlH9rsEYLVNcWc/lpdhW6v06TeFTwRR9szGuzIUB
         EDfSw8H1lqr6v3x05aonNXj+JfB2t8m2FlFPexPIbE5GO2TZjrTRgCXQxFfX+1tMZLVa
         k3yU4BtKc2VYYn2lnbchqTcQ5uo7FnMGX7KGqT1D1LVS53pdxxRdNZqZxd/4BvQIBlej
         6Jz0RFA5X/obMX+lhsZxP5XJnIX4gnfBqVfprBLM+Ug0akl0Hg7xGhd0gw1Vn3BNgvQe
         dnPg==
X-Forwarded-Encrypted: i=1; AJvYcCU2/N+tMbDyO0NfG1GoUKJFg2WXv+7mWn6d430F09MD8NLYlA/vWXiMps/pAGGbscAhKBX8Uh0r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxefh5l24N8KEE/8hXExG5MPR+Pe9/iCLeG8xQwjZBpf7uuz0U
	bpkqz1BiktwwZUuH9p7zyfQQ6AE7k49B8dUJGL6bh9xLaQLJnZEXCQJgcAOtIw==
X-Gm-Gg: ASbGncvWGmkqgqlKJ0BVZ0pVHIfBPuCrfzevc1MHpExuK8wk8oAGpr3g1rh4CCUHGAF
	vb/uo9cKzZBgduEMnGfZnTaIIeyTNEZtt/QrBqLKogAvTN7nVoVpx7pFAaJKFZYM/2EQ12UDr88
	gYi+LQyR/oxZmc09ZtYuNipyzBPrS1Y+fc2t/Itlj59fQOc5apIfrxvUpUgmw+VlZ6RvbSJQHDb
	FZtUFZL2Spd+Be8MZg24+pUbL/JY/Kqm2KOmDrPCtSlSzW8CaQp51eeQexnd8cQZHB7zt8gDp4J
	LUE6n1CyXavXSB0MeRSP+J8gKpvLQiB9xTPbkxxR5ViFX89Qucm7m1vd40bZKSWwrhMdLsL4Y/y
	Y0I1oayiXbA==
X-Google-Smtp-Source: AGHT+IGCkjp7bhibsegJvEnhEdx+029sejsn8em3hGJ2OLmGOtsJSHM7xFwZ7JdT+eFzXvq5AWacag==
X-Received: by 2002:a05:620a:430f:b0:7c7:5ad8:aece with SMTP id af79cd13be357-7c960719efcmr44339385a.25.1745533111053;
        Thu, 24 Apr 2025 15:18:31 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c958c92193sm141850185a.10.2025.04.24.15.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 15:18:30 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:18:30 -0400
Message-ID: <a64a1877ac344c22b3c86058e97d1d33@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250424_1707/pstg-lib:20250424_1742/pstg-pwork:20250424_1707
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] Audit: Create audit_stamp structure
References: <20250319222744.17576-2-casey@schaufler-ca.com>
In-Reply-To: <20250319222744.17576-2-casey@schaufler-ca.com>

On Mar 19, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Looks good to me, thanks for moving the timestamp and serial number
closer together.

--
paul-moore.com
