Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB635CB76
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948558; cv=none; b=uL/ZmZVGzOP4EeuBqllFDwyIxPgeR4uRvyfs1OIsOpCpFMHR/z1jyA7eDxVvtQtIOAyKHiqp5r0BYEQ5rtdHZGbXTZ21sC3X44xLiX5eM0gVClD+xCDh/9EJNrJKPKQzj8dyEbScKH5O+bKkKRCYlW/fhaq3wrz586zGIvl94uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948558; c=relaxed/simple;
	bh=P7igMTCDj6mzUsVbYw7iHcp9Sb5FYZwTGLMab1q7NHY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EiC3jZ/Gfx5jVHcU1B1yTxYt3dMLKrbriHj1g/G1Rwm9NlB9h2igaXwPmUy+2+YE9lLjy2xHm3eLtkLdseZhfS7UhTyNW7Ljfn2Ow8iEyTtgN4htRND6XfUQjsJF4P91l27JSBx3tHXEhr2HQBixNfNTcX0w5YfWU/JGouVE+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LPG3qKeY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LPG3qKeY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fbd79350dso46863371cf.3
        for <selinux@vger.kernel.org>; Mon, 04 May 2026 19:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777948556; x=1778553356; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6SbB+RAO9nreNOlQGZll2xayCo2QzpXO5CNYlf/3Ms=;
        b=LPG3qKeY/6t5wMkgQoKCid2+qEqXB0YhN8CE+19yr8El5bQPTWo6PrWP5XDk+5Tlbb
         PgnXK8YMlK492FKN7QJutxkCn+fz0Fjq8pyzv2UazRT6QKWXaIVck8HtxWKXHtQoOK/i
         jpXQkJe/XjB9/exefCW9kyYJ34KmJ/yzlIARkJeYkmJBgfthjgLvB84e1ioePN4CBoZG
         bwlcu2KbYy/3zB1hKcAn733qhG+SY7CawgtacdOMy/SnwnNmvwqXwcdiuVb0wQVAFSRD
         dBCo026hbkaeNg0irxwbi8iw9S/HLF8B5KRxpmoG57QF2VLrpNdG2QY6tquC7Xa3xUJF
         4G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777948556; x=1778553356;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6SbB+RAO9nreNOlQGZll2xayCo2QzpXO5CNYlf/3Ms=;
        b=RNzRbHy9hkitGWvePEtK2nubRJVIhHrgortfjNXNK4x5zCWCA7lpQf1aiu2X7LsL7s
         wl6q4aNDaFiBTQly6wsHUC9lbFC0oqT8HYbqgqSEQvW/O19+NitPnnmJ0/51by1A+o+s
         LgN/6Pad3JcF3vvcwhiAykGsMouqLJbLBsCT1/Dq/aGQBrOrgoUQmH0m8j93d/tE/rJU
         LqtK9ECz8N/Zfm4khFKDONFY3AfDzj86l2WSm/dYz7RUXm9SZwsCPejfkoLQsJY1yoJg
         IkjIOFzzjMVCav1bDXARvl74vIx+7dKmOfAHmXiv5qSAxhQli93enbJqxmRNiKzBkJjH
         xq9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/IeDAftJ6ZVhX0kl0F6Xn43jk/OcPY2pj69IN+DtDXdr85MnlVPWduPzoIcp+9dIUzESMUy7nj@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGCGxbvdQatuQjKcMHVtkjrZbdPeh11EWDI7jeEzqnEvLRM4B
	YTfLHFKBDJh2S+igzmSWelB+FX2mliN3f5eZt5EshZEhIok+zb4mFGa0awfuT3CksJO51R57SMM
	BQkA=
X-Gm-Gg: AeBDievHnk4yLjFblw0TRt6cxENCC+4fBHj8sfDa1LbW3cCgmshMzFiw6+cqJDw8y2c
	N0pL+HfAbinNn1ggefrBtiNM0kvtIdZtX/yMtKYnjxuMtTdrJ4RGjfcvKcwloOIMB4T9OKS8DGK
	/QRiLErCD1UjwJ5E5znee889QhGAGUZYFfvFUTlF2wEKS47tG4Uy8zMzytpSbgoVAchJgQ2Kpym
	Dah5rd+t9kMJykDNCox1GPugoASVaxR/5U5RgSiy8ddT43h7JU9cPw0GEsHF72H1ERFFOtRHs/s
	u5kQhIWGUOr/bTn7PT8UxQI3OxVpYVfFtIConjx3aClNseLTResFxxial9Z0ObLN2guHHIQV8f4
	T4IfSAW2R7dNWegUMEBuGs/KVlzkJRiW/PPUL/5SIOUND3NAHxXmixUWzXZlwSINAnH5SSctaMi
	fQSGxTIOMVZzf/mCsCOGWP3FWxQWiUHt12sA4TmQkXVOABt+0T+7aaFWS1HGuU7TQ5VkX6rN8hv
	+oV/h5BSWpOsHOAPQ==
X-Received: by 2002:a05:622a:5e15:b0:50e:defb:9dd8 with SMTP id d75a77b69052e-5104be0e498mr177266521cf.6.1777948556605;
        Mon, 04 May 2026 19:35:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5104a92e746sm92126071cf.0.2026.05.04.19.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 19:35:55 -0700 (PDT)
Date: Mon, 04 May 2026 22:35:55 -0400
Message-ID: <9acfd81c71fe8fc761638509e17a8cc9@paul-moore.com>
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
Subject: Re: [PATCH v2 2/3] selinux: prune /sys/fs/selinux/disable
References: <20260429211229.3750-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20260429211229.3750-3-stephen.smalley.work@gmail.com>

On Apr 29, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Commit f22f9aaf6c3d ("selinux: remove the runtime disable
> functionality") removed the SELinux runtime disable functionality but
> left everything except the actual runtime disable functionality intact
> and started logging an error message to warn any residual users.
> 
> Prune it to just return count (i.e. all bytes written successfully) to
> avoid breaking userspace. This also fixes a local DoS from logspam.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/selinuxfs.c | 34 +++++-----------------------------
>  1 file changed, 5 insertions(+), 29 deletions(-)

Please do the same thing here that was suggested in patch 1/3.

--
paul-moore.com
