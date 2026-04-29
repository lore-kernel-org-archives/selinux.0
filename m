Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142539D6ED
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495070; cv=none; b=fLjHibic9dVwSxvyVg9Mlztl8gd9BzG+qzkfToOaM7ERaIjP2fWx/SSTrqMvg7wDx3nBpNs2oP9VzFL3TGXFFf4t+X4ZFn2H2wCjRA+It7VGpkMpP32CzIPgaMzJtcxxgWGgxuYqeedM2UrpwKiqkpibCUv21Vlx8U+YGPkO8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495070; c=relaxed/simple;
	bh=3vcFiBeav6EpZW31EroVVu7q525aDZu19W97EzrgvHc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=YqGTejg/ycovKjixlJFLg5dc3c+0O7sgORRGz8sNpeWd31vXVrEOOy6iF5nckWgyWFe7Kwy0J0CvoDdeO+EGe8aK85TQmOez2KonrZaTtLj1JQJEvR+FAKBqjc0oHLpImqVh0l92pPaDCT9MNNF+x98YQrsUFNsGL7VYqzdGL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Uhuh3849; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Uhuh3849"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ee62a19730so18564985a.3
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777495068; x=1778099868; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QnpohK0Su96jdYKVm4p/67wRSZ3f44fpKyei8pP2CE=;
        b=Uhuh3849il8n/Ium9BsH1P0ZpWsdMYzLm5sDpxpqmjVjn9tn1vmsxlgrmg0fhTs5C+
         F0IIc9JaObRrZ00RWsDCdiFIfIAwWeXmidw2YvFXr6VreQmThJKwv8/7as/STcGMjW5u
         Hlrhl/7MvZ3n4eIVSrB+HCU0ZtVL6OCfdqzl0SKoXLE0YZLlom7F1y66j+Guau+gDfw4
         uAMTXBT+XHmgPgNnzZ9zFTlIWw8GrNW2JkjMLHGRPVoCwSuuZ50I9Tyo1taw/cue3Xk6
         /nBmZUKqkP+/QXj6AJ/C75Vo9KBxs8bxEUXNuukgGNSjCcIsX+bSWwbkQdLzNfu2OgcK
         E0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777495068; x=1778099868;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QnpohK0Su96jdYKVm4p/67wRSZ3f44fpKyei8pP2CE=;
        b=l5pbqA4WnkbDRXd8jRl3CE8rynQnfHnDR+5gXOJhT/nAUBjW8sBl0/lRK4PzUWf4Nt
         W31QILF8Hbzo82gJAvMPv5dfYVY6+W/e0Hg1pZo59g8nZBLhsM7iNEJ6XMU2k8Y6AIWg
         Do+ULdGC9J6WbMqMeMX3wIRX3vnFRNV0O8KSXyBwkgKLn3oReP8L9vOMubxO8w9M1xMt
         tvPaT9xuTRFDfDg5nsxJhVqW0L7UAwrJ3zBtIuunt+gznUhC3lDFq4/NV8No+sO63pwa
         xcoJvJ042KpTG9DsS6RqrDuZpvQJRzuI9htY8BVFhYYdrg8Wqtd4BzcDnRF/GLEuDpTK
         AlkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dwMYYhEA2kXm7XRmusRVLfXJ55keRkANL23Ij2t2i+z/qm2So50NDdDkjYPgi2YunOXsI0qWm@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXsENIlAQRypskumWViTK87e/2Avf19UMmHGgBAqDElQKzfWl
	5cUY09I0Edsn18oBnsapEUZg2mbUwdt0RQKmppdAGD1gYtlPnnA9iz0FhRSLt2QCgw==
X-Gm-Gg: AeBDietI69tJeHmpzjR7LpCcPbTCAhJ1XdETDL3p4NO3B+JMd55DShYvuXJcmart0dh
	M6NHui1i5jiXLVaSfj02Pz1pk91Xt9tJ43rdUhqht9DzuGNwlAFoeQehKDZva5XOHRG3GuYZvqL
	qj3IAkcHiYRGHK+QSmRUvUIgR33/pGrfGX3CYfhsSh9dyvs0SmnSafgiD47W5y3DqqNNwyA28m5
	Zf4g9Qq6qSqHdaWm44ErDvTsx7lh4sRcAKmog/hWjHAYi9x6Y0DrGwOGUvu7TEAdvHEeCgwKSkl
	apQyUwFUKT4O4B9i0oSNBpxILuJlcSJNi6bdFfxFqsxqeO8AfmaJhsadmCB9BPf5DIazWXV2vOg
	mEilgkoNYz7bRVkXw4JyBJIFMGwDfVKtiY/TzB5bQWr0HOUlH6SpKNP7gztc2lqgu/TUUdwA6JX
	rXyniotNsC5UX70lS3XpYI2QMvszLk4c65wGmrv2feCdIP/wHSsFIyhTG+WGQVbZOmJaUAXeueZ
	3A/QF0=
X-Received: by 2002:a05:620a:288c:b0:8d7:e3ab:4c0c with SMTP id af79cd13be357-8fa88f2e244mr50577685a.42.1777495068122;
        Wed, 29 Apr 2026 13:37:48 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93c80adadsm271459085a.5.2026.04.29.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 13:37:47 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:37:46 -0400
Message-ID: <d790f34acd83582559429140efdded48@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260428_1810/pstg-lib:20260429_1506/pstg-pwork:20260428_1810
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] selinux: switch two allocations to use kzalloc_objs()
References: <20260429191840.13959-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260429191840.13959-1-stephen.smalley.work@gmail.com>

On Apr 29, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> These were the only two allocations in the policy loading logic
> that were not already using kzalloc_objs() for the policy
> data structures. Fix these to be consistent with the rest and
> to protect against ill-formed policy.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/conditional.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
