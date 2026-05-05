Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0F2F0661
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010447; cv=none; b=ZV3lbjkCY4xA5SX/60vXZdi2anzHUXu1LCIaiLLPnvdPtbRpq6pLNgdXgPOPK4AZMZTP9eLUdqhdhKke1ZjvEczjO8LKxhlJybT8bgTJ+suxmihpd7Feztjtp/9zluFI+aCsZsEUvTx+cCZDJoxtXrz7hxFsP4orACNyIFOuNII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010447; c=relaxed/simple;
	bh=qrvG3K6Cdgpxj+rne07ZJkFk24vIG9IGF5tPGcJ1JGc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=M+WouMB9XiMpu/uUa/0zwAfUyD5AXSj9pveG9oywjj6aQfIpI/fbw8aiFb+dwclXJXJSCB0EiYki9M66qwhrowZuFnq3RhLPcvTo00ddJaYCc2loZp2tb7NmcV1eSUFp08gEF0HC5TPh7pAFROboSC0Mr21pw7UZ21H5eIpYUV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G0lNvNq4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G0lNvNq4"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8bb4e8a5240so9795686d6.1
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778010445; x=1778615245; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAsbe2soSEDFrXgwdhmJ9FYjSJZmqX3bru0qmnt8v98=;
        b=G0lNvNq4ipoeltgNB0jzNr+rLrFvJM2dNyb3JWGO1GaCveaRdNqvB81m4PuJloJeQb
         zv9gakVJlp3BCaAS/vxL2hH+xBWL7MHpFqubdx2Zf8oVwxIe3AVbgu42GXnqoV1PlZJB
         ONUmQNi6U3mBIGy9ruU8Oc0t1quSkqrFDty7ulUE9AGCuQplrmBf8s/MZ+Py7AEa7Bew
         PU3nKokmKNhpdCHrwnq3SAMLn6L4ea5/XasuS/4Nx69LLf8ghp8uFBqpxcW/UYx76GBi
         G12ycZHL1OLP8SPTrxE+cPcq7sf875it+n9dtBh+NYHI8aiZ+9IQnbCvYlFEqaZ5WMX9
         y4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010445; x=1778615245;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAsbe2soSEDFrXgwdhmJ9FYjSJZmqX3bru0qmnt8v98=;
        b=TJZTjp2QY1ffUWcHGjE9/Nxr7xN6Xq1pF5RyRooL/oZ839gy/+3gEKm8IPJdF6wF+S
         v1yCi9JEyLFecan07uBDpGK8E0NCyM3ttAE/t2A2s97KCCJWviEfBqvqo0ih1XM4Tf9i
         /KSwOzizN8Xhn8zbGE2zJtqYrpV0hp1YFX7UlGkC0UCTzXJQcbAPanwkfVNN3U6Qp30U
         RjsyMCOytisEvq5vOtC6HbbUmaXpH/TwBwfv8NXSGxgVHFH2AMpQsOaHQE/FmjUQVz4V
         lO2OAJf3o+xz990PCj7FELPcYH6Md/FMtuxYViwyqu51w5ZxabieeNYql3EfVQ8pxdor
         Y3yg==
X-Forwarded-Encrypted: i=1; AFNElJ+aWtf7VD5gn4pC9n4OtF3rwncceR0ihv24ILHYbDGMQAOEl6HAAF/De0a+QtyFcTAc9Dgf5610@vger.kernel.org
X-Gm-Message-State: AOJu0YzLizYF5hG8giaeeUu6IGUkPillykVEDfB7BoC+mXGtsRPv8e7T
	WfVibwXKx9lUwsYhK/890UKyxe9g2eM6QLTSDOSLJ0ETOxl0XZWIhjqzXpUQgUxrIJUZ5jUROjG
	Z1cU=
X-Gm-Gg: AeBDietM0VQ5q2I7Ka8ic+SVtiarzdSpCiNUGmbAC5Y0jGVfTSRCy/qbRNK3mAWYNDQ
	oagUWLBKMMQrdcub6vyy7zrhyOFQK51mYgQ6anLEiPNb3HbNIRq9oRVBI5sQohs5noDQuaSJ1jr
	H/0yDLr4Fk7YUBFGAWWrJjzRmP54foCdH+gZQ/LDz6DlPqH3EHiuKlmhw7YuvwWGpOiJVn5w5IO
	6CfYmp/0ly4y/ZNmJqagBj1JAHPannjEw4G/hVWw44dYC7G1NODcnBqZd8Jm7zg3Yw9rIcB09LM
	9sEbaAxsuEFrrRevE3R7JtyTb46PlfZIydWQGeZvzNWjM76oYPnNMSWL4c6fK/X1byIIDscq9vd
	e2xGYFDW2ktcoJzwg0yHXOwiv6rGzG7IrBAMDSZ5x96j1Edg4yFBxb0c3u7p2RQBV40XRGOIDUq
	nuO3YJbqs3bggzoz/CYtUiGu0Lgl7GRZr0wJVo+U6POFrspSn7entzBYx+B/xTj14tGV24F8hF0
	k60ppo=
X-Received: by 2002:a05:6214:3f8f:b0:8ac:b677:c3ff with SMTP id 6a1803df08f44-8bc4719ad7cmr1502766d6.45.1778010444678;
        Tue, 05 May 2026 12:47:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c1dc606sm156776316d6.31.2026.05.05.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:47:23 -0700 (PDT)
Date: Tue, 05 May 2026 15:47:23 -0400
Message-ID: <7bd65e903c99f25d9e866f7d5f097973@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260504_2038/pstg-lib:20260504_1547/pstg-pwork:20260504_2038
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2] selinux: allow multiple opens of /sys/fs/selinux/policy
References: <20260505140637.2468-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260505140637.2468-2-stephen.smalley.work@gmail.com>

On May  5, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Currently there can only be a single open of /sys/fs/selinux/policy at
> any time. This allows any process to block any other process from
> reading the kernel policy. The original motivation seems to have been
> a mix of preventing an inconsistent view of the policy size and
> preventing userspace from allocating kernel memory without bound, but
> this is arguably equally bad. Eliminate the policy_opened flag and
> shrink the critical section that the policy mutex is held. While we
> are making changes here, drop a couple of extraneous BUG_ONs.
> 
> Link: https://lore.kernel.org/selinux/20100726193414.19538.64028.stgit@paris.rdu.redhat.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 shrinks the critical section that the policy mutex is held and
> removes a couple of extraneous BUG_ONs.
> 
>  security/selinux/selinuxfs.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)

I agree the single reader restriction likely is doing more harm than
good.  Merged into selinux/stable-7.1, thanks.

--
paul-moore.com
