Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7F029B224
	for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629649; cv=none; b=H3O8t2o4M1mA6IVx4z2wzlJC4TGBNMPJ24GriK2t3WKs0FUZgR4L0QuKJAgl7QuwLeTZsN9Vb3gixZ1FAqd5GqlkjnS6O3IhMIIjojhG5SdmoMV1d+DrT2RGuPombEHrsFfhAIrixOObGifEsmUl97Fur0qI/FFZd30zv34jySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629649; c=relaxed/simple;
	bh=UX3h0Pes41IJIATGA34ZfcGcoxGHwBRZyrCwKR+AqI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTp8c7rrZ8Y4SfienrhzumO6iNZX2ePydAPz+WWCFWCsakY4rufCBpxzD+QXLlMwHEiOgJD8b/ukzQ2jeIB2n6RxMQMVCMq4BY7YYiWgEFEg4L+NAx0E7UcD+hGOFh6+iYLC6nh2JzTFDW9RtL7WtDMS7Xub4m5QClJ8kreAIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TKTrQNaf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TKTrQNaf"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso2604143a12.1
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 22:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761629644; x=1762234444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kLpGC29sIJuMD8EW6D6+ekLf15xOznYOaep7iLxbnWw=;
        b=TKTrQNafrZBAdfGj/48XpPjtuU2MXhe4t1oBEktcAu0jmQwZJuA14m6z6dY8CEGKHj
         iSiYAL6/miETbP0aPi5KPymVjGhvaahSXdNL0qQybYiKtlGueyIfeSw/RFtbjilC173L
         12s/OnYr7u5tWW1dHUKwR9dllofeEfc648iFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629644; x=1762234444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLpGC29sIJuMD8EW6D6+ekLf15xOznYOaep7iLxbnWw=;
        b=If6Pf1w3mYjoN9fUkOGZ70MDcwvLx00UZ/DwZXjagwQO0dENtAvq3VwBq9Vuhh2hRJ
         sbVTZuOvUBBDd6Dbl4FDjUaQepUGyXhFYKYhyFUBgm0JXPGYZMR9DR9/N7gMX+3A6mCd
         qjIUO4ohRZnsnVzsbDtRttGz0vMfSaB6GFhKJuWld8H2q3iG4xtw+GV2SUCgitBKsb1X
         FsV5ZyUg+9R6Ctg0PPqUtCk3RWTqj7QLRKGUv+yQ2mfsw+BY4w1FDzTu/7kCAyxloNs4
         k7Vl1st1EXDB5lDkg1vBEpTw+Wquzb3mrKljiZi69YrmDiw3RaGK9kL082l0n0KPTJ7w
         nfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVci69sRcyeQckYcIWOdCWjbFt0kH9qp0k/QZzsPcw0MQ9lcXsAjuRr3siWeVbRO6nEfH7fA5FR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7KojLJAhhwoPDutjoJ1KadPhuDDxW2bL9IJDeMbvMiPndzxx
	XnS7uszSjRODQF6yH0xQB6d4YvfPZF4l0lua3v25ppOsWTKk4M+qD6DYxYGK7jYy4sdyjTTa77z
	8P0ejJF/fgA==
X-Gm-Gg: ASbGncvdeyM+TwXlLiay2rcY/5lth9v5vUjLTevyzIiGFJNKF2vKt9n5gayoY3qJfNc
	/ubZrH5qCFGau80tJjFjSC2jJy6ELi+Qfotf626M90uf21hHGBr3Yg396jIre96pnQr7X/RVP3f
	ngm5AEWXh2KHxCB0Jli6W8gJgEEXrVZYydo0ll0lHCl/pLb1/vC5S6Zg4C+uumNdSlfopZrbwG1
	LqHUex/4vLDrWHy9bIBGAkqMYVq+2FYvhWRCQ0voajDvzNtVtosskRKjuDAL0nRZV1h+FmZSXAP
	LA6N75uBC2QgDVCXUjXp0EeaIlPO+5K8YBqCJ6cBr4k/KWXi/tKrb/dt5od2myHK0JX3I3O2P12
	DY5puKbQEzkTuEjhrgDrrPGLRHOkgwsXqEW48nAqrvQbvYArhhSCGb+s6CLAT54fyQFcb/QwXOp
	VfoPV8vftZdJNX95V1ahNme9PPOSTjBgVWCJfY3ERkIqyXR8Pn6A==
X-Google-Smtp-Source: AGHT+IHz2iRjJ2mXRtCXoBAubDExcBTCtCJdwj/yVx8+vMY27cjMMmSpe8tDf+LeEq+wSyaWVOyYzw==
X-Received: by 2002:a05:6402:13c9:b0:63c:45fc:7dda with SMTP id 4fb4d7f45d1cf-63ed8cafe20mr1995833a12.20.1761629644431;
        Mon, 27 Oct 2025 22:34:04 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6402a6be2eesm550001a12.16.2025.10.27.22.34.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so2483915a12.3
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXj8M4M/VX+vNLzHXnBv9ZEcGW+XnKOz9D4NkJ2kaRNu1fInSsK+VkjonfyWroJdThUU9xddTki@vger.kernel.org
X-Received: by 2002:a05:6402:2681:b0:63b:ef0e:dfa7 with SMTP id
 4fb4d7f45d1cf-63ed848cba3mr2102592a12.6.1761629641674; Mon, 27 Oct 2025
 22:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 22:33:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_FZnLha9Qr2sMQPXa1go4FPq2p5d7CnMoOnCimS2Wzg@mail.gmail.com>
X-Gm-Features: AWmQ_bkfyF7pn4e6fUY7bNVBhf2DrgjCvQYqt5ZlzergSjGB0BKOD2LLrniXl7E
Message-ID: <CAHk-=wg_FZnLha9Qr2sMQPXa1go4FPq2p5d7CnMoOnCimS2Wzg@mail.gmail.com>
Subject: Re: [PATCH v2 00/50] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 17:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Things get simpler if we introduce a new dentry flag (DCACHE_PERSISTENT)
> marking those "leaked" dentries.  Having it set claims responsibility
> for +1 in refcount.
>
> The end result this series is aiming for: [...]

The series looks sane to me. Nothing made me really react negatively.
But that's just from reading the patches: I didn't apply them or -
shudder - test any of them.

            Linus
