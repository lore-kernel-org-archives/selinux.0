Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21611ADC68
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393616; cv=none; b=gF9H/aQsGpXaWooZQPWN/F9gIiN18I8+aRP9lfp8oSSqKBQh2Krabq+ZTnD1NirnzyUfXUfpNwXFIbLqmiooljXke75HyY91qft+SAWbmOKz7rQMdblPE+mRarvm8enrf21F7HinTGXBpGub4Mj7flwmIIAytRBSfhzyPJWzRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393616; c=relaxed/simple;
	bh=x1+6CIpzlADA19TQ0ikRKoTkRVkuA+ZeXn/UGHXIhT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pc9aKDvZaxcfzLNElMqCSzASnrkCMvmZJnxjHkSniCZa23AHYvkej4Q5KNewvSBSslcCc2DQd7tmKscbnlqTXZiK2gBNfX611/BbHWO8x0K+jfWXB7voFuxjAv2Bg0GdOZFlIYRtg/JgUe/n6/PaR6SXY+iWVyJqMaKz4cyD3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NoKQtWG8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NoKQtWG8"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso10812810a91.1
        for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742393614; x=1742998414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JMN4aUUtucnPvMiWKvHVAVuVAG0iabHlTuzaVSatajY=;
        b=NoKQtWG8WDFZDO4sdeVSDB/oPEFXzNZq30TlZa6/4bCxHUr07yKMRHqSkmfmA2YX+M
         us86svld9I3BUld/P1zOOeoEaFQiFCAqCjFrklqd0cWe0Nqa15KlPcfV6OQ8eMkBleFf
         UfoylJCAKytOgkFnUfbam1ldlVyuo4dOheKVfbAY/mK+VpCWjlQ6KBxSWaFC+vGLVeJQ
         Z0pmokQpTIXUkUNHrRcEljX9+FcUwbye6uIRH8DpsK2TkSlPPd9I6tbrPU1Mq8pptnH6
         /f1k13i33p0UVKHQ+yRfXqivQi7UWyMdk+pEs8ZH32lQdU6BCUD0sGxgFMIjmP+2XV4z
         5/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393614; x=1742998414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMN4aUUtucnPvMiWKvHVAVuVAG0iabHlTuzaVSatajY=;
        b=T/68yK9KXDGhPdQMBjp1uhEYBcKW8xdXV0g0G3ez3+06w7EweBAY+JJL4l0c/ufHf4
         la9AXFnnpitVY7YSow91piolKiasDqBEsZrGA2iZJpJ4n3ctYJ81iAw9ToYX86fhcSFF
         Dv5EK6lXnaNfQhUUzZF9Vd6oud+X2s42Z2WpovEuxyi7PQMnyVjtHK9Y/VLr0X0NglQs
         FVey9wnnf3t2ZtgyJse7ncTI98A4sb1/fUUdJNuEU0H+kwaXSHlf6bUClcts6SaDXOyF
         D4uPo6CUfSdSU3+10ruDpM8i1WSvh4dKrWWMgyxBBYFzV3OSlTtCrY3Az1T6Q4xPqrjm
         feZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6SaVA/19OeoUYhnA+wizqChhdYQvWvJQDPD+hX9hwu9y9mfK+lYTroDwv6TIg0ddo6o/A4Ky@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdZyFvyehPrk3EAPRRnQ9MndkjCFQvKfSzNTc4Dvc+Bp+0f8W
	p66ctDhFUHz6LykWU2/E3niDcviPr0643kpV4kezLjvAy/AUQ+qGx9M//9pQcI0Nelg9zvblq1N
	5Lw==
X-Google-Smtp-Source: AGHT+IFQp260NRRr1a4H4NyITWDvuoRP2iZ9k9Yc+PNyGvp3wmzw4MiV2YGA6rjsivB1CS437VuLdgvkv78=
X-Received: from pgbcp4.prod.google.com ([2002:a05:6a02:4004:b0:af2:3436:98b5])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:688:b0:1f5:5614:18d3
 with SMTP id adf61e73a8af0-1fbeb39fffamr5324903637.8.1742393614014; Wed, 19
 Mar 2025 07:13:34 -0700 (PDT)
Date: Wed, 19 Mar 2025 23:13:28 +0900
In-Reply-To: <CAHC9VhSVpDDGW7rKVCYiOtgq71yfXRWDWegyEx3Zp-BoS9dj5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHC9VhSVpDDGW7rKVCYiOtgq71yfXRWDWegyEx3Zp-BoS9dj5A@mail.gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319141328.3931393-1-inseob@google.com>
Subject: Re: [PATCH] selinux: support wildcard match in genfscon
From: Inseob Kim <inseob@google.com>
To: paul@paul-moore.com
Cc: cgzones@googlemail.com, jeffv@google.com, nnk@google.com, 
	omosnace@redhat.com, selinux-refpolicy@vger.kernel.org, 
	selinux@vger.kernel.org, stephen.smalley.work@gmail.com, takayas@chromium.org, 
	tweek@google.com, uekawa@chromium.org
Content-Type: text/plain; charset="UTF-8"

> > or introducing a new syntax that does
> > wildcard full match such as `genfsconwildcard`?
> 
> That seems pretty awful to me too.
> 
> If you can't be bothered to actually update the policy as you should
> be doing when enabling a new policy capability, add the same hack you
> were proposing for the kernel to the compiler/linker toolchain and
> just start adding the '*' wildcard at the end of the paths.

I think adding a new syntax is cleaner than adding a knob or breaking the
compatibility. On Android, property_contexts introduced a new syntax adding
'<prefix|exact> <type>' at the end of the entries. How about a syntax like
'genfs sysfs /devices/*/wakeup/ u:object_r:wakeup:s0 wildcard'? If an entry
have 'wildcard' at the end, it's a new type of entry. Entries without wildcard
are not affected.

--
Inseob Kim | Software Engineer | inseob@google.com
