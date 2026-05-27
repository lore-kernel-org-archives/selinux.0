Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B113D1CAA
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925361; cv=none; b=apmQ0rEbwb8tGZS7xXureqQKe9tyAlUXWYnXKh2MGcZwVHgbhVl9PguB4Gg6lcqp2IgKgNipaDim1WmsX/15RUW2F1G8xbqvARXeG2EwxM8YqeYtRycdaJ0Eu+SFg+S0FE1m1Iuc3bh9GTXgqS8l2ASWfBqy2hLH5ZDAA+ur/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925361; c=relaxed/simple;
	bh=oKab6MBFJBH+V/uSZ6QEE0iOqH/+8AWg59Klcg7F+y8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=AHbLREvcugN0/XrUqi9VmPH5IyrZJY68ON3aM2v+ew+R3qFFQXZLT1vlIxCyn9Rv1XvBgeBzNbfbG4KrudnqxuIPbG5cwDsJ5RKLS4+xPRtmh1eFkiR+pZCIVdKW7JWwbQo2R4ReoDb8r8wkp9AI1MErZYTLQLn13XfLPd0x+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SXELclq+; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SXELclq+"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-914bbfc2464so455812885a.1
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779925359; x=1780530159; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahn0OAmqt3NvDffvYvLmMgx13/Qe9oNxidNwtJQvEmM=;
        b=SXELclq+epNMH9PsySUNySOI+ChzLJ4B0QvpaEpmbkxtT1SjEUmNv366jtPegu3zc0
         bc9Esdr/ZB75vlwnvgs8tLxqF4TZGVusAQ4ckQ76AaewEU6yFNj2x9pxX6+YxHJPUd2M
         vMXfzb8uQOQyRL7xXyV/Pr0znxb/L7vCT6dl1wR3sQKifRpKviVCLzjiHAK4RwXfzYoD
         HLzMH+0STchsQvMn6nmbTUxW2WLp+1tpFDYW0gRvBgZqt8LFrL38AWc2pJGQe8hNvra+
         s4KY0hJT4P/lE3m97UguUDCrrkCFgw/l6Y/5yh8KpKd6O19QBGdIDyMkCNP3ori3Mohi
         Rt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779925359; x=1780530159;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahn0OAmqt3NvDffvYvLmMgx13/Qe9oNxidNwtJQvEmM=;
        b=G4mWWqoY0dMgjY7On1QnPoXz5TKkYKFh8Ok9vL/pral6CW7jMpTXtGPBcdbrLezKOI
         NqxA2kYr3/Xph4OQNLJcgZJRo5PFtBIKWg2XTvrUzfPOLna9FSgu5PkIDFXhJKz16t3D
         OcT3o1HmOVexT2YPsTqJT6xzR0x/dWsKD0Lb5NUPydc4R+xWiNjt66lZlEqv7HTUKRNO
         GrzzZa85WX2p4wuaYgNmpcZKRwHun9wx7g1+tDNIKcWnF4bjc+neCMoZU9JXIY/rQ0mZ
         Hh5RfutDjT90SaB9Kx/JN7buKQUgb/xCMmHqoQ1UdHJiUsRLl5X/QqJcaZmnCH0AEbjZ
         x0jQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dHlEFOFE+xE3Tn+NyVxYiaYcfqvWkuSpYm9Neiy7XDdWt8Mxh1kefkngBDQK5jcqOJn2vSxbp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55yWz71UP46wFrMKY9dqEX4jCORdqxLnueUutvLCmIPo/p1dC
	gDJsXRtipw2j2oWIlxM1Eoyzct1yYaUI9PywgjhZqYwM05sznkmxljsZszD34Cg4Cw==
X-Gm-Gg: Acq92OEvM5UGfRblMloe4KvwxRGMdhCRf13pDnMOH6mrfe85lQLkdjsVoAVG58xZAkx
	13LnDyzalluT5RmjP/aN3Y2fGvtF4zM0D1Pc9pEtd5QUnkxCq1x0dpJh/Imxh/eyCmfK/itXJfi
	wYGRI78DFBBLOuvLUDhZRz5fvhBNUX9Ue7E6j+Axs+4oUVqFI6ZGPLJ1tT5R+rivvEsdYl4NJ3Q
	xu/raV+gtnNwWC59ebE7CjVRqfViO+BvT5ZUKR+DjaJbrYAVnjUVsBom4ZNLq59iIlUtVkARsVb
	LEQMXqTO+5SI3+MmPljRHiH7s+vWNcwtHboEhNU8miBRZ7P8pEuENTWdiocuZ0zNIRWSjBCSslD
	34wWY9u2LcluxGVCmSoJCoiEwwZr2Dtuc7U/0meYJZFtgh7ez10CnNchugWi/z4TZ7KrSB2ven5
	l5Gb+n7o8X86MlXfSzVRZJfNPwia4oyULXp0lwPfNAmDEJxhX1hiskdlt8VN/rdsID4yaTq7sOB
	WPF8PuyhfFuog3KzQ==
X-Received: by 2002:a05:620a:2809:b0:914:9bed:9439 with SMTP id af79cd13be357-914b499684cmr3819952385a.44.1779925359286;
        Wed, 27 May 2026 16:42:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86ff83fsm630942685a.14.2026.05.27.16.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 16:42:37 -0700 (PDT)
Date: Wed, 27 May 2026 19:42:36 -0400
Message-ID: <be755d49760dc9083ddd6d9a485c71fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260527_1931/pstg-lib:20260527_1608/pstg-pwork:20260527_1931
From: Paul Moore <paul@paul-moore.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, apparmor@lists.ubuntu.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 3/3] apparmor: replace get_zeroed_page() with kzalloc()
References: <20260520-security-v1-3-831bd8e21dd0@kernel.org>
In-Reply-To: <20260520-security-v1-3-831bd8e21dd0@kernel.org>

On May 20, 2026 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:
> 
> multi_transaction_new() allocates memory with get_zeroed_page() and uses
> it as struct multi_transaction.
> 
> The usage of that structure does not require struct page access and it is
> better to allocate multi_transaction objects with kzalloc() that provides
> better scalability and more debugging possibilities.
> 
> Replace use of get_zeroed_page() with kzalloc().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  security/apparmor/apparmorfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I'll leave this for John and/or Georgia to review and ultimately decide
to merge, but it looks okay to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
