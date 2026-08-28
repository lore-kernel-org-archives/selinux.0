Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B13BBFCB
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787947982; cv=pass; b=myc+/pz/NUBg+R42cc/xz6IcR8By0rMUVCbEmIIsUQEMgV+BucfpBEpMQ3HcOJskzck21yjcySJvpZF2J9sK+iEzOm0KqaqYHWJFKJH/ayPu4ernPOnslpdCWr5Ryct5yjmlpmuclBg8kZDku9ah1m1HhfzW9FSEbmHr6ZZVfxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787947982; c=relaxed/simple;
	bh=HOZc+cF+fL5+Q3mJFE49kPevrkEDYyixjiKH2Q7la68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e54IKab0jge8mqUC1q/NtGIHxOEJH7iWbZpcciHYhPVRDCHwn6Uv4tqzm2Th3/078uXBRgikdPaNbA7if50GagR/AfFqlSyD80ywB1eBQP7k/MWhwUrH+nmrBIlIf94JvylEXdNhImwmzhP9jjocnHewrwiH8/FccycCPauV13A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK9ll+M9; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK9ll+M9"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f4cc6797b7so762275a34.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 13:13:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787947979; cv=none;
        d=google.com; s=arc-20260327;
        b=WqEWeX82rzl0bd+Vlne/ql4pM0AvAI9GFgFK6Sz6hPxSpAUUzKnTwk4i3x2M8eW1nM
         XEB2fZMz5u88NT5BBXXMnV6qkIQVrHgJPolQRx8cMZ+PyQzJZ47QXI7VifBFu75xrvyH
         rOo6V1F7qmOmP55LXyvl48qcF0QBqg85YVGY/46aQSTg4GRo99oAt5JmfAUK8/X3Qztc
         3lvLItl2UpwAFiO/lr1B/LxwGrimBQ0zerQdGtVZHov4yPAfPsoTcZ+Gg6pYY2jyenyd
         5xhQAofdBl2zIBxBRfvSOina1zxnOBB4f6ZpvUW7MRM2erAf33tOueOwyUj14zNuQQW4
         mntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HOZc+cF+fL5+Q3mJFE49kPevrkEDYyixjiKH2Q7la68=;
        fh=MiDNOxUu1NOESfq3IPdT4GGwVgcZz9g8FvBGyt5UlbA=;
        b=g5IqWodRZAvpBVJubQhDo2zFD+v94i9nqbgQOiIWhJaQGUzVn7nmYRAQkmILqpENFr
         kzMIvKsbEeMB5U2cK44LMaydNfjdofxnou5OSRc7fWIlf89eylTMURMVgGONJqjeEolV
         rTUBsPHmdyfxt8F6PdRuGlhHteDUZVfZSmB+2OZjym1sE+QvBaQf7em0ipw+gDXbSWCj
         MG4tb55MZyn8EGfjZlHkiYhG/43gZlVRKrrOcNIVBYH8mlqZd7ona39Jqk9//rJvm1AQ
         XF53mZcXPTs9IaaDlu0V2vTt6qtb+ghDjN/DZsHC0IL70fJa7wWFclgtsZLNtQubkYe9
         X64g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787947979; x=1788552779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HOZc+cF+fL5+Q3mJFE49kPevrkEDYyixjiKH2Q7la68=;
        b=kK9ll+M9Mo27weJsPw5K1FwCF0RYRrRgFuuLv1sUa7SnBrFLrwFKM51XyQ6dOQP0MW
         sTk+mnUP7Vkl6CpFiA43wNY2nzwWP4eRYe/lWMqsmmDAKYdm44fJL6tVaLSucSTcF9Z2
         uxUclJdKEWFiOA7S+zGUVehFGCijKSbMAzPYR5IvvvTY1AIUR+rocCEss+3JtfREEEsV
         PXfAwuewTQbCBTSiDtFuPxr1V5Mapl4K6IjmZ4eu37wnyKmuKgDW0gsBc5afj1PFt+Pj
         AKymuKi1ZiAja4x8qByo+YpKFsqfYerX2pF98q8RnnNJR2fSkshuHttaIY65qVI+0bN/
         nNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787947979; x=1788552779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HOZc+cF+fL5+Q3mJFE49kPevrkEDYyixjiKH2Q7la68=;
        b=ksPomEzREdKVSex/shQQoEwDo3wuLAwJZzWzcC0kC7nZVGY9sgf5MZihNvUJq1xqgZ
         w4F8aotVicO2jMKOlwYUjtd7FoePRXrweuw7Vg0ikYOSzvB3hfukGJzU1crWKdoaWNTs
         n7c42BRihKUprzQy1va/Lh+PRmzD5WaM/X9wD1TlhM//4/f+dzCtKi5FbKNWFKwqP68C
         WFgVCTCJ604lil8F2dTuYXuBxixA97r3xk48JqXgSo01LpZBh3sM4E6GI+AbIKZKO0mn
         xjccZeWW9swrB+00fSpIJYSW1VSkJmlWwiFiSNu6KdhjPQ3Ii+3EM02rr8YNJYmLkHyC
         QqCQ==
X-Gm-Message-State: AFuF++mv6tZ24dpcAn40dtbKe6RHJezmRoiYAzKOGYCJasU1eTqJBsyN
	9gqNTUQnfTanohz2kursPYdWp+0hsWeWTDudhoq2JrjGhMzKf6L203lm/3WS1s7A6Qa9oFaIN4+
	LUjKfAWDYFwhql+bXvBu2fLvlZPgsu3MysA==
X-Gm-Gg: AR+sD12JZ4nJdBslE+1ImI52EFikbVB7DKlp3RhHmXXiKu0y3KcI/+C/bYLTUYgJf/W
	7H53nu4/ff4rI5dh5e2YwJkpVOMGpu3hZ+MYeJGETJ6knmhuiAHzgjMNIFHUSpRce2if/PgFwWV
	sgcImQT6JSQWuU5xPISrFXcCvZO/97g1psQiHepJI+MuPZOLbUDSOGmlOWIrND+c8XI+s1+M7oj
	WubvKXhaGHAEIrsBWdramyKAvjwGODHvGcAeFhMrr+Wc9JQfTr9RunXLu7oZIhNflhWzj0HFu3h
	mZtSxrW9ciZJ9JY9KSvn5/uGXlh/ugnPlfdWjgSMMbkS
X-Received: by 2002:a05:6820:25a:b0:6ae:a950:9faa with SMTP id
 006d021491bc7-6b1c65cb077mr7804825eaf.10.1787947979505; Fri, 28 Aug 2026
 13:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828121543.32469-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260828121543.32469-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 28 Aug 2026 16:12:47 -0400
X-Gm-Features: AcwNN1Xj-Jm1Lprzg_ICqizy7NwOZ3V1NWqj3zNXV2PI5ZmkBNNSJ2pJbOz6tbg
Message-ID: <CAEjxPJ4LOvSV5xHsvdzcJ1BajXeThum64cQeLrwazKqzRvY3uQ@mail.gmail.com>
Subject: Re: [PATCH v5] FUZZING.md,*/fuzz: document selinux fuzzing
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, nicolas.iooss@m4x.org, cgzones@googlemail.com, 
	paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:18=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Document the use of OSS-Fuzz and CIFuzz by the selinux userspace
> project and provide some instructions and scaffolding for debugging
> fuzzing failures.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v5 drops one more residual lingering cruft, gets rid of some trailing
> empty lines, and updates the FUZZING.md build instructions to note
> that one should always do a 'make clean all' first to clean any
> prior builds (especially if scripts/oss-fuzz.sh was run to get
> rid of the sanitizer artifacts) and build the base set of
> components leveraged by the make fuzz target.

This is now merged but happy to take follow ups to further improve.
