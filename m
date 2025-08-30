Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2002561A2
	for <selinux@vger.kernel.org>; Sat, 30 Aug 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563320; cv=none; b=SVBMg1ybfplmFrdZLy23rAeoX/SC87IR6wynMVzl5QnQLeyZP+P0mHZtud7wTY3mH0Fmtfop6a8dskxyHc0U7QuXmQPIPvGXJO6kUclCDVniZxqsOGRAgzEJE8rOrxEfMdOs2/Z5IDfInuluKPlaBmCsEW84jE3LcLFeyYmBx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563320; c=relaxed/simple;
	bh=JUvCDmRXFunAkEsF1GRXbXtYikzq0w1vDWUP6HCoymU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=MoNXWJ0FCVCtDIRkiarvY+mx12ZmBBwUg8h122Ir01fRqoFnBGbOuEV+QHM61G1QFeqIa29Ssa+OR2TSTs+Nw9vrLdFznT13PN0iajMMHkoG+1lQ4Jhnnsn/G0UZSLNowmeE5W+BIpxpEFQ+Wmzuo2PpVVtrOkdPl/86Nt+Ue9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PAcJ58PU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PAcJ58PU"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47052620a6so2912002a12.1
        for <selinux@vger.kernel.org>; Sat, 30 Aug 2025 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563316; x=1757168116; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdijhc2hQ+HCzm0Bxa3P9aIQeay6kqPQfSVWfxshLOQ=;
        b=PAcJ58PUHfp4hMcxmDTRQ7mRryINHbS+m+lSZ7TAjVR3iI99kawAFbYvh9WVYxrpZy
         getGeM4yZeVviSxsCRg1BL0FC2KgdgiGS6GK+3kilIhXLCwmi0prmwRKWJrCDKLXncCV
         1WgHT2JADs/f8s2meak1aqvHkLdnW3+8gwlGrcuNT2ZXwo2AI9sWZfyH4Dlxp3LJhgbm
         aaotxR3RztfRL1ELuPgSUdr7EHIpdewzIu+11FRlShCkvz9Vtue4KdL3vBm+zHyvxKum
         SGcelhgtLcSUAgUgRiZPDVvKO6sla5ijwCfYLtYHqvseiL8NvfK0lmKCJOYWykMDswix
         Ci9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563316; x=1757168116;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdijhc2hQ+HCzm0Bxa3P9aIQeay6kqPQfSVWfxshLOQ=;
        b=mB1E7v095X6VGCuo8UFdirXDdjodmjKmMe+0TMH1hhtcWkMzGmC3Wh2NG4Plld2iK8
         DKRoSNp587b9MIR8My9zlco2TvX6+5CMVAzpVDpO9vafZNqAjOEtXYmLqz/zOXhCQJbR
         IFxJku2hOo9lwmzZEdGFmRe/PQpuuTABJok+vDHeyn3MWmbnskscTmqOOF6fMtf0tXK6
         e/JViEaGDgtfPdk909YyknV2KirR3ND2ITodLdK+oKcDZ+zhhK6080dfU3MIlVtkE2ZE
         1+dJixtU7Na6ZxWSTLpfkQZL55+Y2cGtgwl2iNzXmBkfX6FTHQ3e8oLq3bS8HKEPNBvZ
         kuig==
X-Forwarded-Encrypted: i=1; AJvYcCXorsqqnkXz5mlcr3A36L6Pg7S7dAKhoeuAOJmcbBYmV+Fn+s7Lk8gkoY4Eplh28v2mPP3HsmWG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IT0vPGKdXQxPSvWe/WgB/xQUNp8d6CeItfChjwZjRawpVNZ7
	QJ9zEHzydlg0nLU6sKOKlBlZb5v69SU0fwKDHrGBUpG1Q3xMlEb/akOEJQziXzapFA==
X-Gm-Gg: ASbGncvZFh7Lqnk6s/R8MXG3vNrpSoG6PywUUkGXLrTfNEVfBPyFDbO9IoUepNfZfX4
	acRPhzxKm0jqA2P2ZrCk9cHiCJA9nEyYzinYObrGpelAsysZwEiHeokd70Jch48V+Q2b0LuBC+6
	P53uK+8s/3tTccgeRvxmuA5N0/U3BoQeB/j9jcqq5r38Ip4C5r04CO+IkwwPEhjcO5MnQQlRKTw
	vlYxYE9CjIcguDqMjCoTWKcRWoNEY6bFZAS14/mgl6erDTjesXuX4lEsxwd44LkHWC0lLnGz9kl
	clGkpQUy//ngoLO2cwrLQRAruKE4rBnAkGW/9Qi86DZ5UjF2vpX9ZOcJMZNyKgYImfsGfft1Jlp
	V5uIqpgGi4NghMHoX/jRAT8Vm
X-Google-Smtp-Source: AGHT+IEQEsGM+8lfyVtjTlgkC5lbtII1qVz6+A4KiCnqNKckDNqV+kxRsJNCugaEBNYu7LYPVzpTNQ==
X-Received: by 2002:a17:903:186:b0:246:2cb3:5768 with SMTP id d9443c01a7336-24944b4323fmr31449135ad.30.1756563316240;
        Sat, 30 Aug 2025 07:15:16 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24903755851sm53673845ad.56.2025.08.30.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:15:15 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:15:06 -0400
Message-ID: <1c0e40a52934243b9721df47aa604734@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 3/4] Audit: Add record for multiple task security  contexts
References: <20250816172859.6437-4-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-4-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with a list of
> skb pointers. Add the audit_stamp information to the audit_buffer as
> there's no guarantee that there will be an audit_context containing
> the stamp associated with the event. At audit_log_end() time create
> auxiliary records as have been added to the list. Functions are
> created to manage the skb list in the audit_buffer.
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS record is:
> 
>     type=MAC_TASK_CONTEXTS
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
> "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based on a
> subject security context.
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  16 +++
>  include/uapi/linux/audit.h   |   1 +
>  kernel/audit.c               | 208 +++++++++++++++++++++++++++++------
>  net/netlabel/netlabel_user.c |   9 +-
>  security/apparmor/lsm.c      |   3 +
>  security/selinux/hooks.c     |   3 +
>  security/smack/smack_lsm.c   |   3 +
>  7 files changed, 202 insertions(+), 41 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
