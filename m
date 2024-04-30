Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D41BED71
	for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513859; cv=none; b=UyVGHb5Hsyy8X1eMDBEluaO9jg+NkU2Ss4M35Sy9nbMfvr0Ny33cRGodQI/6nPhKSBhzE7XCPFJBr3uMyJnV+mGfh0c3ok2jrIsPqWAyuI/PL6SD5GHvfDxJlMSdtvx7LYBII8a8xmgkhc9KZQ0+0SoMgHLE0RisLLx/u4Q8YpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513859; c=relaxed/simple;
	bh=iQ5gHJsaoJ6hbVCVVlqLQuKRcbH8cc+61WUXwfvQZW8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=fSqStr/JrUdQ98LfYC7V1P0BPZtepYJKTQBekoaMaXtAIFuLfvuJqQ9NYk7v0fgSfXsuXIcvakWS+1f5jyWoF5plvx4ehQpmyiyRscB6pgeN41ZcpevKU2oCnD8scchs/AgNJl6VxN6V8IJFq9noH8manHmq4Y16FvnXOVuFv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UcA7eU9Q; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UcA7eU9Q"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-47c1cf8a7d7so1678925137.0
        for <selinux@vger.kernel.org>; Tue, 30 Apr 2024 14:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714513855; x=1715118655; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k0plH2z8YgzdwRO388ameaxQLSDpVAR1bRk128hQE1s=;
        b=UcA7eU9QOF8/C8qspTibPT7DwkiBHaQ+rlFz+PKXZK3ky1Soq8HEMZoEiIeq2ZOW22
         bfvcFYN8z7tW1bc9s1ZQurDB8qZDHI4S0GMmQIhxA56FKuPMiNQNlylR4NVjBMc693SK
         RTZSY5pbbGPymqrcCoV03jsOUyJXSLq8IVYq9ncjwy78nirD8R274/1V6fEc5kShF9Lw
         IZeY9etM9B82yvgiiV5jG0Z5ozxfEv7uGcDNbKHnHvzDAjE5knwcAbfAgugP+0npSjHX
         VGRo8wb3mDGBlNyBLy0DH0lsVTBgUW1+riKEnE3rlxUvsEvK38s6jbbWS2/qVaK5qros
         qFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714513855; x=1715118655;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0plH2z8YgzdwRO388ameaxQLSDpVAR1bRk128hQE1s=;
        b=JxP+DoeIDfu2t5S9y9XW/MBQwSZGqQeTZ9ko+COzO/ugav+C0X3jbdbyrlsnrRd9ot
         /yUnJkMeWnxi+wYdqIFanOIR5go0qLwI56m2OQl2mV3Lq7CctU8mVWtBqiWRP+X8IjsG
         sGd1st7WQcZw3+0atc3tsmNAG8CKlsVoP1uLGwsMBDuJyH4K+4U+VaWjma8FbCO1pIX5
         9yZOjhFYkNU7i9Zyy9hgd12iBeVDqPEBSEdI3VsfdEuNmHfxc5nVsB07PQL10DV4irwg
         gv/3sMnTEYezspHiXhajGmK5EE2v08lwkprhIUsyn7iUTBnRR0FmoIFaYXZIMcnwShwW
         R0eA==
X-Forwarded-Encrypted: i=1; AJvYcCX7KtAaf3NbJ/B+5GZh0sdW7gXKKlrSl1PRDCwiAMyCY4J3vbEM4uNZUn+uyA96NBH52F7mYQsXPXVpeSwdFJuYhP7Pu6XmQg==
X-Gm-Message-State: AOJu0YyhFDtnox2EyI4/9h6/QqnuFV6HRX7KDMHeEUpD+ShxOyhUwFoQ
	KsscCUxvfbhD50zzP9Y/oaGLE/JChZls17ND2chIk1VOJrN9unvvh3EuSiD1MA==
X-Google-Smtp-Source: AGHT+IECmJxDZ/mHwmdlUOZa02OzygBDpSwE0Qzsb0CMFRAyhYEILD95m/u/7aR9jdn+ROyB5xDQQg==
X-Received: by 2002:a67:fd02:0:b0:47c:2b74:2903 with SMTP id f2-20020a67fd02000000b0047c2b742903mr1213260vsr.22.1714513855414;
        Tue, 30 Apr 2024 14:50:55 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id v15-20020a0cc60f000000b006a0d5ba108fsm1683348qvi.109.2024.04.30.14.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:50:54 -0700 (PDT)
Date: Tue, 30 Apr 2024 17:50:54 -0400
Message-ID: <bbf99ca20884fa6e549cb699fd6269da@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v2] selinux: pre-allocate the status page
References: <20240405155033.249321-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240405155033.249321-1-cgoettsche@seltendoof.de>

On Apr  5, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Since the status page is currently only allocated on first use, the
> sequence number of the initial policyload (i.e. 1) is not stored,
> leading to the observable sequence of 0, 2, 3, 4, ...
> 
> Try to pre-allocate the status page during the initialization of the
> selinuxfs, so selinux_status_update_policyload() will set the sequence
> number.
> 
> This brings the status page to return the actual sequence number for the
> initial policy load, which is also observable via the netlink socket.
> I could not find any occurrence where userspace depends on the actual
> value returned by selinux_status_policyload(3), thus the breakage should
> be unnoticed.
> 
> Reported-by: Milos Malik
> Closes: https://lore.kernel.org/selinux/87o7fmua12.fsf@redhat.com/
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: ignore allocation failure
> ---
>  security/selinux/selinuxfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks Christian.  I trimmed out the 'Reported-by:' tag since there
wasn't an email listed and I wasn't sure if that would cause problems
with any tooling that digs through the git log (checkpatch.pl did
complain).  If any of the IBM/RH folks want to check with Milos and
make sure it is okay with him I'll re-add him to the commit metadata.

Merged into selinux/dev.

--
paul-moore.com
