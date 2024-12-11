Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80BE207A34
	for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942558; cv=none; b=rG8YlJeMNA88cbt64rzkbZGVDlmfWPhIbntyANn3UGbaUnIwh+rALoBjnsJV6imTKf4bWtK6Whz+1pmstcJp/3o7wjjxDV/LOrsTKuCy65ncFbN8W7Wf8NSbGeIHP8h88Uydy31jn7bZfAH03PfXvDalIeJE5/T7iOwj4G3C7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942558; c=relaxed/simple;
	bh=SkpeHUB+DvSm6pjTjc2XWRWHLlFEQA0k5ibgRjASxjQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=R/CDJsc1UYA/wyjKpNCsypOmEnY0IWQJcYh83Iqm8RfocKGYafYsXr60QytMTEdRVWryNP9WTve4E3zg5qDAgXT6oqRj8Krk+eBsJMltb4rDqP3kE7lhoZSIhpOrIdk25MnY4q6H4Xz7xfTYzKhIY+WuGZ0Q0nBEBezfbWbKWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rekdrgya; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rekdrgya"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d87fea84cdso53857126d6.2
        for <selinux@vger.kernel.org>; Wed, 11 Dec 2024 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733942555; x=1734547355; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04pC3QGQRTjTk+8Lsd4Sud0CdSb7C3narM3VOyiHdY4=;
        b=RekdrgyaJyAhHM2C/jJkK760uWHAUafwyHjhBW86aOYefF7u937EIyHZigFdl86tO6
         eB/ZBeoTkzDCtEDUXEcf/SZdjFz8PZnCQgdDBCPeXz4YIm6FGzb60wIhuTkVrCrh6+Ob
         epI52hb02Sr0JlET0PYmj73cyO88PdM9dVUjdRRl+Ly6mamnoen5ytGFbUCTCai8GlYT
         8r/A5JFbvae+BER88/b7qb9sZMia/8l+L9pPAwle2NXCRJUbRCo57DAsz06GKYjfaEja
         2wFGNTarHdI3nJy8jdahVv0t+lj1+Vjjz9P+ja8VehqxcmHyKn+NKa8augRZ7dAQOx7D
         6E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733942555; x=1734547355;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=04pC3QGQRTjTk+8Lsd4Sud0CdSb7C3narM3VOyiHdY4=;
        b=je2zBfiQC7I9xvIZwCAblQQdJ2AoVnEd81/y9H5stVlvchio0teh+bg4f4KI55CGo3
         aSsHexQNRQwowqET64Y2Fm72gFXLRNEEQ3Yz/ykKGgl19LW7XH1hG6Sx0gFAfPFy2HS+
         Y1CQVYuLXpktKiVHG8u5KGT7N6SZNl99PqVLpyn6V36KEqhiROKyL+B7XgDp2JQB8sGa
         N3aNwgqfBBKzMf/3pbEKKKyalBil4sF59U5MD9fqHIlfMwNXkYpLS+jS6lPgehPFwo/Z
         vAinIyGGo6CYTdvHBzRveFkm/inKHpp+OUd211DeWM6ZVE1xE0pSoDj/EBtLcdE3RS+9
         Y+TA==
X-Forwarded-Encrypted: i=1; AJvYcCX8GcM4lgyxYTfLJ7dgW6zIWdFuDNlZr/JcVUscQR7UWxSrPEif0XIrcX9XMl17DSGZl+c+Ge2D@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+7vZ98qUr8ER+CtusDKOexb+IQT7d4/NrpPOA+ctdsL0wJ8G
	8akwJeKQVuZJnMwzw5cxg4a19ghhFSbE4i84/R1VGTPBo/+nMyvTio3zXQQY3w==
X-Gm-Gg: ASbGncuGMb8iuH2MxHPQUYzrPvUaE6rf13hKKadrioE+Rb/SUCCkjuU2M//SXcCXcfN
	ehZN4kVAVxsbpriedo5aXeCRFoOxOHXH7UMIP9aOT5CGvWeBkPIEC830l+dphRFdbFO4g10cDFQ
	tF5DATVuoPtVDLmH9lOmmrN5iYvozMaZvcTzLC02S193rgoUpTiItYn/Y+4z4BIoEHkAPq+w4VM
	CB+vq5EzLjwFHrOb62bw7MbeOOQnfEtrT0DFnvUE17y92Fw
X-Google-Smtp-Source: AGHT+IF8JGBQo7vcnwREb0hv0tLiDlDa3CzKzT+euqnc01x3sznCCGYD4tzOwAdA7vudAvAWm/Vg9A==
X-Received: by 2002:a05:6214:1d26:b0:6d8:99b2:63c5 with SMTP id 6a1803df08f44-6dae38edf96mr5007076d6.12.1733942554726;
        Wed, 11 Dec 2024 10:42:34 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66db6fsm72504186d6.10.2024.12.11.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 10:42:34 -0800 (PST)
Date: Wed, 11 Dec 2024 13:42:33 -0500
Message-ID: <e9fa92d65ef886d1f5ac8daf1bbc3939@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241211_1304/pstg-lib:20241211_1304/pstg-pwork:20241211_1304
From: Paul Moore <paul@paul-moore.com>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v2] selinux: add generated av_permissions.h to targets
References: <20241127-selinux-clean-v2-1-a6e528c1ff93@linutronix.de>
In-Reply-To: <20241127-selinux-clean-v2-1-a6e528c1ff93@linutronix.de>

On Nov 27, 2024 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de> wrote:
> 
> av_permissions.h was not declared as a target and therefore not cleaned
> up automatically by kbuild.
> 
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Link: https://lore.kernel.org/lkml/CAK7LNATUnCPt03BRFSKh1EH=+Sy0Q48wE4ER0BZdJqOb_44L8w@mail.gmail.com/
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> Changes in v2:
> - Adopt Masahiro's suggestion
> - Link to v1: https://lore.kernel.org/r/20241120-selinux-clean-v1-1-68704e007f7a@linutronix.de
> ---
> I left out the modifications to the grouped target comments.
> The current state doesn't hurt and I was not able to come up with
> something actually nice.
> ---
>  security/selinux/Makefile | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Looks good to me, merging into selinux/dev.  Thanks everyone!

--
paul-moore.com
