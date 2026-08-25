Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA23CB54A
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686268; cv=pass; b=pQF7M67JBdupOO8VlsEUKAny18L8/SA2A9kwJwYIsiXZ+vBX+Vp8pRdWZ62NTEgwQOzNGV9gQ0xx2SJms6ZpBnEm7J6qVF97VvCe3ujxr75ZWM+YjGt64uxHV30Oh0Mb4h+kOALOr5JCi0DZIBU4jf5elBFwTgbwOmU8McQKV+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686268; c=relaxed/simple;
	bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNVkjCuVeeYZVinK3G39/z9DIUGKoiypbEKN0fnIT9CsqsQo/n6Sd3aB9Eu9q4fe6kDY/O6xcZ/CZVQGwC5ATgjUw9vUNP/qg4m55MaNzqJqqHGIqQs8WdHpiJHj/Xk/B894DmdCwT3oQpAtGvqllPSQS/f6Wlzxs5J+8Y9JSww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5KqrbLS; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5KqrbLS"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448b69cfc6dso247547fac.3
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 12:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787686266; cv=none;
        d=google.com; s=arc-20260327;
        b=UC56O/8c9nhTaWO2axTIbb44legKzScaZGfJzlFF7u/UuBWPhrwHYmU1qC5LQSUwgw
         KDY5W+vHeUTIqZnGAhnQb6a9Lf097rR20L+8+79/z2nfTnpgKwNHtRDrV6LHP+3SsKMK
         h9JevbRS1FQcSKzZWIyCGEHFnc6WuOpE6rzbRFQKc+YZ3ydof7HySGnGsWqykvv1J68S
         Sfcf7Z3VjlsU5l155SOTtnS7cORbYJnHW9cRcWOt2GrF0Swy6U9ULC46g8VJHGWNxxvP
         xr3NHO91QfVTaazbD/Mxdr6auwwlabgKoOWVpZ+ITEwIG/WL5RPX+Ol1klZx0dJan4DN
         Hm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        fh=17j7FhXyIoZY6VaQk1xMBeApXsEv2cTTvGg2iVZeEeo=;
        b=adfbL151QShwBNwZZLme9ILYnbEMUdPDvax7QsWUbawJq7cgmiB09KyWttRgNJbaS5
         g2f8mTYd+ZYSe1loXCynEzMZFKgCp/p36WID3p5GOqpj7v6qVqJeWyz4t9s6LJXZcOIU
         FE2YFU32SOMQykB1P9OoAi0qZXsEwjRbqgdEFMjo46muSTNSMh6rnjHdYM8Acy39PG7h
         OxjIIhk044ad8H6TdydJBIXI2Pe38DrcCl/sf+h85COUeQlOaid3XLpPdzD+rcOGpzhg
         iAhDbe92T+lb7hqMe2KWlWQoKFizJmWMKwyJkrCs76IWXNPG72cTRsc52DWGBnPVx+6e
         rjAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787686266; x=1788291066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        b=U5KqrbLSH60/6DLyM08FWCBhsRBlmLgfmlVuHLeTZZPUfE++6wKqjh1SLOapeih6hT
         NX0XuGP9z8Dsh305xv04rZc62DTuu0HS1Jt97N6kxBGw7GRbAn3cT9CfOUuaVj2Z/ExM
         fLouXUaAgF2F8K0i0MONaO8EKzI+Ti6REyw8d+xJiXz82qukdmCzPDIcJxBZrS2sFkVT
         lLv6kLs4SFAE6qDOHWuXvhDpZIjzmhChcE7fxbPrFFMhgaQCxJ0MGiTDfebm7dhE0HD5
         YvIBLEGdGe6m1w8orKGboZMhoFJpCHKyJZSFBctn68l/flyqqWrYbns6YGxvKnyt1aWa
         nD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787686266; x=1788291066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        b=o6jnYxwyHeh7oQu9Vkmbqb+WXGr01AqaNAblmn8OmQLBDpltCVcSH/pnk0Z1xYK92f
         LSE0wQ+mVcILVgvRh0HMsCoviPzZCdQlueFSEeD7EwyeMqOKbg/XEXQM9DezPNfdNewz
         10HauRv18CzwQqp97W8o3ewhyJR2PPDEo5C5B8zWTk98ITPWKfEPw8wCYVJiXtMw1vuC
         Q67/ZZA2dzqJxhexpYGTrVlolly/iiWrNZ168lYdhzbflKcADdFREX+a+UnIenWl4Vo7
         hwW7o2aqaKmfnfyrGfOQ0BJ4JDPXL1QEHSin6qB8cYhup9CQMyYiqFeQeTA73SGjPDoI
         QzfA==
X-Forwarded-Encrypted: i=1; AHgh+RpFC+8bq0FCJUbiD9fgEkongWax5fpF50k/A3n6GDGUz6lDwDXBc2OK8YaUHM9TZ9ftRB351/A9@vger.kernel.org
X-Gm-Message-State: AFuF++mqQgwR5QjYF8eWaViS107wBI6cSpzp/2JUKZDrY19MllZ/3Pwh
	poED3RVIwadpY7+dPbiRLGuBCebgcLQyrjxweq1DCcQfnnlEBGczMddTRgaY6Zx6vaFMThLSWa9
	OBFcn77aWBFM/LYIdmR4Yw4X2S+DH3aM=
X-Gm-Gg: AR+sD10IL1Q8NaAvUCHmVTm/dm7WYcIGLuyWR2umplTMIdu904G6M4qJFy5ASQkCLmb
	rM1HgXeYMFTb6bFpML23miedxO7nkz0KyrxJWYGoNAWrKoVwmIsXA/jJsWcHbUFyLL2dYL/c7v9
	rgYGXB4enXlmpkLBcP8egvGyLfg7GzvuTHJxwjBRIEvtXMugmbljlg3ldrBfhNh2Yy9yq9+GPt5
	LTBfcpS8XXk36tuOrdfNqRH1RGTLfh2O7IKXErNBuMaVq5R7LTF2Fl42ZA4DhXkJcU9ujMY8BIi
	ks6nQqjNyPmOPY17lmbBig5PUgnm+aeSLwMQwdd9Tw5kkCB8pBwk1HU=
X-Received: by 2002:a05:6870:6110:b0:455:9a0a:f40f with SMTP id
 586e51a60fabf-4659af5add6mr1857019fac.12.1787686261101; Tue, 25 Aug 2026
 12:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com> <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 25 Aug 2026 15:30:49 -0400
X-Gm-Features: AcwNN1W7w3jv19S12dsWPPPWvBnTdscjqtDJ6w6TlqCes7086WzzU9lKHcWHgo0
Message-ID: <CAEjxPJ7ecY4msx_tGxW1bO9ywDpB0wRv3GtQyu2SnsGV9May_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 2:39=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process c=
an
> only create anonymous executable memory via /proc/self/mem if it has
> PROCESS__PTRACE (like when using /proc/$pid/mem of another process).
>
> This closes a hole in code integrity enforcement that Project Zero has us=
ed
> in a remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without
> EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
> /proc/self/mem, which made it possible to load and run shellcode containi=
ng
> a kernel exploit.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
