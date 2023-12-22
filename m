Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046A33CD5
	for <selinux@vger.kernel.org>; Fri, 22 Dec 2023 23:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gcau6H9j"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67f9fac086bso4377236d6.3
        for <selinux@vger.kernel.org>; Fri, 22 Dec 2023 15:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703286565; x=1703891365; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGR0xmUolS+E89J2bGEq0f1NeitrM+VEG8SN5Q+WIIY=;
        b=Gcau6H9jnRMlDi2b1aVNt0J2UtCpeFuag8IvBoQNYq/KdLSpd8d/BZ4rJhQi/M8Q8G
         J76IpdPgQ9r70OsfvSq3i2Vu5I6sl8Zv5UonDc7OT1J6zXQM2ZTZ5rUft1LxaJh9XT+t
         9k1EIb1coaXvHz0pBkrTYkjhA0YvSjWBI6galARYPl40WoWAuF+4TpgFXY4LPSAL45QO
         B1Cbzvcdi9y+tVWPHL2d8BwH+r/AXcAWPaOI+e2mRj207bTz5qrTThqQbh3v7t1XnN+/
         cSfsqsQd4d8X+9Zozqf5gUd6vWrtHQPlZ8JiN0O1d8CXioJIuExMLsbXOHuznCTqyEDY
         NPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703286565; x=1703891365;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGR0xmUolS+E89J2bGEq0f1NeitrM+VEG8SN5Q+WIIY=;
        b=KXsfQpCzdcduFHqRnuKUFvpL5NrBEfeeK11WKoi+JlxwULbrgxtUBxEhW/MwB1VtsV
         qVqL1JyTMmbfjnkGDVp6JjxzBdyrlaGI6ymxIYT7ix8fzPa+28D/a/Grtq2OfUFgzYYj
         2Lpxjx43GS/2LL6sbhSwTzUyldf/SmQJg/quRDFB45oCmriXyeBhhDCz3/WowCbpkVHI
         CuRg/ss4YjA0TVi5XM2E9GkniQBtBVkNJ2oeID8fa1exrZMIbEj22s359+0HpRIjXtCz
         EprOyWmUEHdQAwJkftbHSC4Bho7SjEZJgzgqLZfFkJGKuGzUvwLsLwMroNeOzb7+SqDf
         EQCw==
X-Gm-Message-State: AOJu0YyHZ2AXr+Ive3eg+wKhrxjhM2gPNLyv8Bp53pGUkye5QF4kiL3A
	29sZUxjOGgETgCkpfAUiaexvjfZkU+yOW8JpoYVC4+MR7g==
X-Google-Smtp-Source: AGHT+IH1pdYrnW0qIb825wiQuJ2ElSNUwKmgvYtznaWticgzIMJ7jbZIUxO/dBBUGBNPZo8OS9o4Jg==
X-Received: by 2002:a05:6214:e41:b0:67f:1965:c3f with SMTP id o1-20020a0562140e4100b0067f19650c3fmr2906299qvc.80.1703286565276;
        Fri, 22 Dec 2023 15:09:25 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x17-20020ad440d1000000b0067ec8702d1dsm1678405qvp.137.2023.12.22.15.09.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:09:24 -0800 (PST)
Date: Fri, 22 Dec 2023 18:09:24 -0500
Message-ID: <3efc373e078e41688534773e09c72e8a@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: Re: [PATCH 1/15] selinux: fix style issues in  security/selinux/include/audit.h
References: <20231221222342.334026-18-paul@paul-moore.com>
In-Reply-To: <20231221222342.334026-18-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

On Dec 21, 2023 Paul Moore <paul@paul-moore.com> wrote:
> 
> As part of on ongoing effort to perform more automated testing and
> provide more tools for individual developers to validate their
> patches before submitting, we are trying to make our code
> "clang-format clean".  My hope is that once we have fixed all of our
> style "quirks", developers will be able to run clang-format on their
> patches to help avoid silly formatting problems and ensure their
> changes fit in well with the rest of the SELinux kernel code.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/include/audit.h | 1 -
>  1 file changed, 1 deletion(-)

The entire patchset has been merged into selinux/dev.

--
paul-moore.com
