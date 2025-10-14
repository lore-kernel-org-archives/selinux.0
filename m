Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974ED2D47ED
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483563; cv=none; b=N6PBUySo25tS0wRoYicspL9YOB8AMMh+do+drcuYfjtH8fbFvK5YqAjcVDBqJk+pZuRJdLJK2SVXo1HtOkPS+yEdK1KNqcy6/vhd5P7DT9thF23uJ+T4c2Ei2JVhHPxBA6S/5b4cSWZkB/R/6RRjhu9tD8IDS8WJzAKCgQu9YnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483563; c=relaxed/simple;
	bh=jP7eKKlEemoHr9cH5h7XSAsqHsL7E6l+1k/CdljmEEA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=aOqZxFu8lEGvUOMdqclc7tgFXYRj37m1edBI/SaAqLyYk88LSklgIPkUJtD8BjIW2gZ7hEb+nJZslFRp5PcCoL7OQiDkqpgNvf19W1Dp78Oi5uIcJwqlu/xUMYdtKbM8r2gI1ZpRNQhw34OFB0E1XJOeLx4tMQ4N0T/raJuVjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D+m1psg/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D+m1psg/"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-84827ef386aso574466485a.0
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483560; x=1761088360; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLBpXGvn84P1YsJATB/vo2Be6tu4bfzDW/H1Hf/uJzg=;
        b=D+m1psg/0sPA5QUhpnBP97dPq4bd8CQkg3Pfjl/zaOpk19TkocwXe328GVOZCPcJdf
         bdwF7+IjhxslyctHtjf5J4Bbm11EuFY5VAPTLLChUPFzez8fN2e0Zod9GjCK2ix3WHH9
         L4p9WOhLc3SBVfIMcAbMWc5R65PsdBM8o0rCUAzH1o9DlvaM8ILu56S2mFUBcCqELEJ8
         pDfbFHDNvlEsAJWlOKgythNnBcgEbGR1MPesiNfqKBVCLji0Ez0A3Pou+wzUD6cwyqgt
         uJVfBOP67LMupZW2bPSuaWPfy5Yx7m5WjsYovsIzuOkpfH8RqvJfmiQu1R6qvp6wuHg4
         8ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483560; x=1761088360;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLBpXGvn84P1YsJATB/vo2Be6tu4bfzDW/H1Hf/uJzg=;
        b=ZiV6pJIGxa5V5JAac9S+Og5FXoeOiVyTIuRN20lB+8fhmnPmx4PNhUm+nvn0d1LuOZ
         XSgJniY6SXIKsa5oxfFGY3YvA9DFpdLyHMqNAOpSdg/xpdEyoj6iuY5TXmS4+cPsN2mg
         bLq75vIz1k5PFH6fF8rhW7OMqAOwCY/INYmZnhTGG/F6T5X/2Z1DjI1gcoG6CcqK4+Xu
         8qB5QTVb9v+B657vprSpyzd5KfKi2+Vpbqm52lBcSENDNyR7P9OvGVR1igvbuW69mSyD
         Wj/thwooXHAo6nmkiMqaXre/ubIKtRd/Ao4haixpmKNkTSp4RNcDjeMMtwopRpXIpPEw
         LZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0XWn2w9PGo0Jj0zqDHssnLwhQY0Rvp4Sz3M4cu/jigMunvVwj/zpnohhAL6hJ1SDG8eNWO4Uo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz23kGfXVz93WI0OOOBu0z79bSwZMLVcRwz8hKmTraaqQpXwLt
	1fyWtzrX4wEAjvNO3gyaeSMTf/884gxjqFkDBzBoV+vuFNcJZwnakH/r8OVaPZWODw==
X-Gm-Gg: ASbGncsdk83jXsf7dQabS5f1eI5U8rzKVYWuUHQqq2YHGe/X0gEOO/2PEIfqIMbeAsG
	qWUDpSUpp3ncQw2634ilsH+mNR/+PTFttvRCOgZulq6MpZHhHpYX/RFGun4U0Zs+pgdxvcoSmYY
	XeUxbpsw38ae4//WTGK/bTLWRL/axuETEIKk2N4s7+OB0D8ldcxoj0u+vb3Hdv/2/pMiHqW1m24
	3dGTk0nMw3lApsSaiHdvCHMBbf2NezmZx/nQXiQ/dCTUaVRyqv4I3bOnW3VaQ4/H+iQ7SDRQqZb
	oM3mTnhaRNTteMVYjptO7kEMQw5CFEHQN79MqOnEosevuxVvkcCsogrP7/Rv2jxw0DUXF6ocKTM
	5M8DYHriPEpSfZ78LWabpHJhwHSRh29WlDDGA2DNHaY/8dhP+WQubYbg3snxHls8zMS7GWmnuBl
	1nNRJDfsLdRmA=
X-Google-Smtp-Source: AGHT+IHHcLVZiMgSbPLG7eY76yfCqa2vB+jpgcP40CTtOHs38xnmpRUGPmtafOl88Gxs8UC/0Ltr+w==
X-Received: by 2002:a05:620a:254b:b0:88e:1671:2e4f with SMTP id af79cd13be357-88e16712febmr95763785a.78.1760483560211;
        Tue, 14 Oct 2025 16:12:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-88e1d60aecfsm23093585a.34.2025.10.14.16.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:38 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:37 -0400
Message-ID: <846555fc86ec02df31f55935e747a71f@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 1/15] Audit: Create audit_stamp structure
References: <20250621171851.5869-2-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-2-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
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

Dropped as this patch was merged into Linus' tree during the v6.18
merge window via another patchset.  To be clear, I generally don't have
a problem with multiple patchsets including a few common patches, it
helps prevent cross-dependencies between patchsets which is a good
thing.

--
paul-moore.com
