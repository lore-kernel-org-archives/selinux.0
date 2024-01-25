Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959852C69E
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197944; cv=none; b=IRM6wC3kpfa9fD8+UR9Gg/p2KxazlwgBe27hlB36NPXnuFvJBfUqmgxZJMkILGqb9R511YxiYicXB92wYhFs45Vxe/P848ZwKIGNWQSEVnb7tNZiDzBtEhq6jjH4FWI+K3GOOeMbfJtetTjlcl9i/Sye0lJo7unWJvsZ4WQCA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197944; c=relaxed/simple;
	bh=GoeM7TosvzC/MYbd6zZhtwxwQAwmskhgMFT4omP8csw=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Subject:References:In-Reply-To; b=pFPfcFPMeEnlqCkMmmuSxQb1hcFW2KiMwNpWREn+zNAJmsEGHGG/c62H81okx7jJ4m1tcSwroGD6iMbkWBHXqg0yzZ0DPDA2sUXUn9ManRfCsrmZAMizzO6fNHRbwvQ1fATivJ61XR0Oh1e0kyldvkJbOvOMmmYZ6jt3glXSzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cM1PFPX+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cM1PFPX+"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783045e88a6so482725185a.0
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 07:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706197941; x=1706802741; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oz1rgTN+bDq7cgJXWF883/VSImo6zEgmaV96H6vS2yw=;
        b=cM1PFPX+LDC+ZjCEjgwaoTccWg2OO8CcoREAZR3qVEIb47yBDzdeuekB7ZkyJ3sZPv
         nwqq0V4idT8VDbgJjBwfB4jGyBYt2jaDW6l8Hu+1mRWyj6+50a1O7N7Hycn8HPBL5iky
         AFHs7KgKFU24Lb5EKU+hDuXHbNwhoIGNvLEBtAFMMLUTg7/VrufnVQw1/gcakB5Wjxtq
         c7ZOduACA036iJh1RpuCVRZOJeXe9tpvaGfOoHifn7mVklHrwucs9WuCts/F0KVoitxS
         8ao8XHHzfzwMzf5u5y+uUxbLg5AiZq6kx4lCg3QQ42koGjrx2Hyi+s+aPN6QIPntO3qM
         ZmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197941; x=1706802741;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oz1rgTN+bDq7cgJXWF883/VSImo6zEgmaV96H6vS2yw=;
        b=S0hq0liCBiuPgEFllwV8JXk2jsAxXPwLEfvVSNx120m0XK1Y4IZ6CB8ia3RopX65ep
         jfVCHYu82nMfIKh92hXj/rIxKkEIB/XOYF6K5TQOEOGDxmlpZKIIaSDjASkGCG5t/CWQ
         0Jf8CqbfpQulXTR8ifm512Q4y8l8ByEUU4XCawZGDljWpFRbHfPnPZg2O9p8IGWUqHZJ
         EqFokiK0nV2vCOdV56ffdWpEyYzMJznlJ42UPO6glIKt0VO+j3rEPDC+zThxz4pk+omi
         WoFIE/BUqHwi7M3c8l0fnhdFV8ANPlD0AEtw0FtA3yfvb+NCCFdijCE2mFmPzgo6skCF
         w+wA==
X-Gm-Message-State: AOJu0YzwF5gQTRhQe6f4WFezyquTWoJHK+toVTZTGrWF7xsiEiGkBLvh
	p+WOqwH56gcfbFkSOyvwSckD7n32nujsQ4NBoErM5s9YaFcQyBFOHzSrONlYIKm2M756s3Lfvys
	=
X-Google-Smtp-Source: AGHT+IEB/u/Zw8NslAYFzPbkbf9PMeiUZDvSExrNPJseeGRXDoOBeolrzs6EOzPmIiR2uCwzBeLcKw==
X-Received: by 2002:a05:6214:29ce:b0:681:81b6:6960 with SMTP id gh14-20020a05621429ce00b0068181b66960mr1321379qvb.66.1706197941370;
        Thu, 25 Jan 2024 07:52:21 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j7-20020a0ceb07000000b00681092cb7b4sm5530044qvp.103.2024.01.25.07.52.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:52:21 -0800 (PST)
Date: Thu, 25 Jan 2024 10:52:20 -0500
Message-ID: <e7551c958a49dd62b088ed727b6e821e@paul-moore.com>
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
To: selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: reduce the object class calculations at inode  init time
References: <20240119014420.493814-2-paul@paul-moore.com>
In-Reply-To: <20240119014420.493814-2-paul@paul-moore.com>

On Jan 18, 2024 Paul Moore <paul@paul-moore.com> wrote:
> 
> We only need to call inode_mode_to_security_class() once in
> selinux_inode_init_security().
> 
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Merged into selinux/dev, thanks Paul.

--
paul-moore.com
