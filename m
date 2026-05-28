Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A9DDC5
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779926932; cv=none; b=hTkt2yzr6Dy9Y3370JeQuiCJcJzQ0QG+lfJyN/RSww6WGm6OUSypzqD+im7dLUXKWrdVB/Ir/TGr56DNO+3MckFyuorG+GmyFuRy1Ka8QiLfKhqYF7yBWqe7I17342dhXwMZumSA1tYaPwL3abS/Iax4wnrWz62wc2ArN4WCyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779926932; c=relaxed/simple;
	bh=KENGMk7Jmu6GJOxbifpiqXu2/EXr/eQrao0h+BABakA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BcDrGJYkyn4LgDMMUKJvx4QaqP//5rhqiXaBb1a2CCDSJBiLnWtzzkuddnYgRrN7GhtK0pALeYFanpWmetbTtwc6ggoa2W00Bfa2PGWZFMY/kwT9/odtA6nHPPfbJR2Z+tAM23j01D5ybCS9QVqg2OL+93ZzBV67YdUi5ef0L7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Nju11cf8; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Nju11cf8"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-516cbde40f2so71538981cf.3
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 17:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779926929; x=1780531729; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27080+LBRRYWZ23G3vuugHpWyoEvf8BZ1dAK7JI5E4I=;
        b=Nju11cf88ucmJJlhKou6yRiYQzqJQeSV+FcSTRXrV5/lyfajqyxKIETtO57/g3+sJo
         uqCd0bE9RAfE5k/ws8XwXnYT4MZFGZsp+s5/aSsi7xY8Ug23ipFVFrP1xctY6b8yObyy
         SXu/qerSnyqEPr4I5NDm2oSpiubz0FWgdABB0g+0JyKw8dT/Hh9EjieRaqQ1Uso3i0x1
         qlV38A4fl3fn7QUkGFfSKDPXK2bJWLXVJnJckjFJ2zoCaiCpe7//lKk+A7TJtnzMcGLH
         Dx1cRTgX42+WY6fDYuHLkq86hXdiYBOgGcU+Ak6OzvxugrBIyOYeUdO+rj68hFKVhSdi
         zfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779926929; x=1780531729;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27080+LBRRYWZ23G3vuugHpWyoEvf8BZ1dAK7JI5E4I=;
        b=mdVgtYy4sJM+oVBlL/GKRLCgoO0yyYyd5GAwdxkBOVluLH6pUZDpvwENy70g8eJQlb
         wmz6K9V0zdOfuTYnNs4sLVYZiL3foPMoliU7bILwYmSjCoVoLAUBg1m3ohocJsx1GdYm
         jElwwmO+ROuhw42XK8TgK6yKjJ0sWKay3tGuv0NMttRs0YUcCn7YSO7b2FeuBtx8xVdo
         zbJeMswcyin+1ftt96WMjzTZsZ7981KsjWjh0O/b9bxaROazoXu6XB59wqoCrMV/GS/h
         wMcvv2lEKhu4bt/om53wo6yMhrYWcL6tCVvbTyzFkqJm9y7ybREX+tbJ/LX3ujhf/aXx
         LMCA==
X-Forwarded-Encrypted: i=1; AFNElJ9KCqIgnHgvP438jYAussXMaCLVmxyfrHiOJSjnyGzIphLznq6lwhFyviiUI9XqOEneVjIKDk/l@vger.kernel.org
X-Gm-Message-State: AOJu0Yzopz6ZRrjH5DejjSnG7796C5I7QbgALlKq9anIqn7uHMZUFkfP
	dYUEwtl20b4PiuSC9CtztxS9EO2tJ9OCPlHaaOGFIsHVE96FPlfbPFTTv0oQWRxOgkAH6u7xmZ/
	70rVNLNp9ERY=
X-Gm-Gg: Acq92OEdgMKQJKESmWTiemFG1VksoMnKixzsGXrniC+Bg8pUuBsvHXVLlmSo9XUyeOX
	0mjfC2F2XPJEk0ke/FRcr6kO8i+H1M2XfSWjn6oJMHdXT0TZEPlqrfPeyK4nanqSyzPscYTy9zV
	ni/e04TiiUbJpZL+WUsDERhku00cbS4AVw+1+AgwJcKKhCy3MxlpBs8uLZ6hzswpCv0YeZJxJlp
	ssD1sqmaoUM/4ht1U1UxjVyvCRk0yi3UXZNx+gWJ5zFVq0jgwjv5zOJc/Bvr8r8tTju99bgLHNU
	8fxSCo+KrvKz76gR0t5UY/Rd6Rj/yC0/7XQAh6kx+g2wGjI9yh2kShtX6YdW8S7nvEerlrR1f7U
	YUI135r+p7OpZ2fz2/En8hTCQalK+fySIG5sUA5RDI2tv7C/+vy3X5dFOPGOD79mngFzS6/yhMR
	HjGJ6m8pUsG2Jyl2A3iiAfU9lB+FnttmTNi9CXm7EMPG7vNYWxXQK6PiQLaSo/VymxmZAxVU856
	/SHZiU=
X-Received: by 2002:ac8:7e85:0:b0:516:dede:2094 with SMTP id d75a77b69052e-516dede2793mr307224451cf.55.1779926929518;
        Wed, 27 May 2026 17:08:49 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5170691af70sm63462001cf.0.2026.05.27.17.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 17:08:48 -0700 (PDT)
Date: Wed, 27 May 2026 20:08:48 -0400
Message-ID: <6a62b4c389dacc684ca20c9898152ffa@paul-moore.com>
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
To: Kalevi Kolttonen <kalevi@kolttonen.fi>, selinux@vger.kernel.org
Cc: Kalevi Kolttonen <kalevi@kolttonen.fi>
Subject: Re: [PATCH] selinux: trivial typo fix
References: <20260501185939.31898-1-kalevi@kolttonen.fi>
In-Reply-To: <20260501185939.31898-1-kalevi@kolttonen.fi>

On May  1, 2026 Kalevi Kolttonen <kalevi@kolttonen.fi> wrote:
> 
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
> ---
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/dev.

--
paul-moore.com
