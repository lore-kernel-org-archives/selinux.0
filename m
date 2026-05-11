Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727FC37DEB7
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529168; cv=none; b=j85ilghR3vaExNyRQBRWQUX5eYTTpim2IEH6N7TkZAd+aQC8Nn9xMlwECwkq0TmXVMhDQHBG3DAXqekMMFX/nktRa1IiBQZjUqXaOsyHeyOFYekv1qpR6XM6NMU7DmELmKcpMn9yKXTANGAk7iTrgnxuIo83PCLp4FMArtvsvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529168; c=relaxed/simple;
	bh=rKxh87Y4Rj2/mJmQycKYsxIgVUIAEj71pDy+b5FX/ow=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=rVVasqkWTJKEtFwVJupwSp0SYg6hMvVM5hqn2buMfBKJcDZl+/f3i6nJmhBtUViPH/wxZD0oEqKhDqTMSiw2UKdyQDKLcr8Kapw/SBVWQ/91agkTECZAaKWMLiH9stTG8xvoS5CahUfVOyo9ygK3R2AC9ciWcWTu39Qw2LWQqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E9lVJyLD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E9lVJyLD"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-90ce49af8easo8597285a.3
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 12:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529164; x=1779133964; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhgeQ/Hv8h2FLNPnpqx7Nq4djCqVR8s71dQNMbQD8h8=;
        b=E9lVJyLD68P9mb02OeDiuxB5mMUgH5x8C9eKQQXBi/kUsedChlQRKN28FBaldSCv51
         3MwfG4uglNXTJjoQORG1jvzmokZMB1zTDwCdmAALZToHJ4jEmUDTIK77fGVGaxGuv45s
         7oMTunZMG0fStvlKBpPxoxbtA5JV8dzbkFn4dwZL57ikpdXKjn0sQTdWkkFWIbsyHNdV
         gDlQPMutxdJ1m5CVO3wiiE56/6gf9+al5sqf+QJrAf38IiPwDTdHYaKgKp1MloaCqNMj
         Vyd7gx6VEdNGfOQYiMvMcvSBvCzZBfPfVzMwkkfiJbynwNQ2tVq9KF1f304SRsmECtYN
         MeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529164; x=1779133964;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhgeQ/Hv8h2FLNPnpqx7Nq4djCqVR8s71dQNMbQD8h8=;
        b=Y9S1mVmGWuprQNCeia7MFAAV0JMACdWOTfsdsEuLxrcA0FWUt3rKMjPNIcYrZ0Ry6i
         d5/cOBfV0LBIod6ijWmsTNK4er/e9uQfhYIgDm+aW5T+1wbkW4qtm42L/1In2hR31uQe
         J1ufLA+2mxJwfB4+ll1HceHVrc/cRMS+6FKSZx10+Kta6+1Q8RfRb1HoWp4UQlpeVpW5
         OwS2QbOk8jp7LX4/cgyutJ6ZzrC0Um29/H5vxIGHbAn0VE+EH30z5RJu05Mr6ghOgc2H
         O8NDoNIVs5S2aEOV0xwIWIHjXvQbKBEGnma1gihKV87AJC+zrV479Q3nDLr17dOV2oaO
         u+Kg==
X-Forwarded-Encrypted: i=1; AFNElJ/e/bk+bXirC22BuaM/IH5b/jxf4XXx1M1DpYX56XWhQA4Y4a+y7CTV/zqw7VGLCj2iD5Z4FvrH@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJcMEDGBwY1oH2H22avvabYsH6OlqeAV3x1B24aYAKOgt12o1
	53OquTvzxZQUITtpeeQIr44cRKuh2jAwxG2BbhjS60hbrpGu8jIU+ErZ4G0gVocGxA==
X-Gm-Gg: Acq92OFFugB461lg8JwPyrOvJn/g9R9n+Pp33IH5BVSFRxRiAS3zL5LLW+KQHT2jKQZ
	INZcxaLVzzEbo4Os/8YuB8IVT3w+XhM8sEcte7qecubus55ZwEUjtNOkKAJC7IcGPRUzZHk+QGQ
	LPARJFTNUxHWWckGIo2oEsoFE905SWOgErEo6nWik2vgbh6eDxCHpij6SlP4aoUNyzq9rR74uKS
	6jLYuZ1DIy6yCm0Fv0a5mZiUoLETi8hxGgkq1kQ20dBJfG/cx68dlE45gmfR90YZhP4VGkcAvbP
	tXeSpfMtoeqAfDYpg/pQCmkofH//nw3yr+XeNW0QRmLuAFaEyCQZDTJuw0Uvgl0v5Y333dAGNOh
	v+OXLxXYPsXLHrH/DbnrUNPsRtKDCUVtMdmBP5vc9XRNkjUhAyGKby3JR1AFm1X//4OIwOjtuEN
	sQr1K7zY3Ehmz5KO3DAp2XLXvutA9djLZ0osGZMIeRK2SMIhEZ4wvfz6kuXllJW0gI+PQO
X-Received: by 2002:a05:620a:318d:b0:8e8:ffd2:ef90 with SMTP id af79cd13be357-907b8d9e67dmr2467034385a.3.1778529164314;
        Mon, 11 May 2026 12:52:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9286f22sm1151090885a.13.2026.05.11.12.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:43 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:42 -0400
Message-ID: <b32ee44eb833fad926f4667892f2259f@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: john.johansen@canonical.com, georgia.garcia@canonical.com, Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 2/7] apparmor: Remove redundant MS_MGC_MSK stripping in  apparmor_sb_mount
References: <20260509015208.3853132-3-song@kernel.org>
In-Reply-To: <20260509015208.3853132-3-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> path_mount() already strips the magic number from flags before
> calling security_sb_mount(), so this check in apparmor_sb_mount()
> is a no-op. Remove it.
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  security/apparmor/lsm.c | 4 ----
>  1 file changed, 4 deletions(-)

John, Georgia, are you okay with this patch?

--
paul-moore.com
