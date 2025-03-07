Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF72505D4
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378273; cv=none; b=CIrmOTV8CnKHjgqESdL2IQsylxPoIR8ns1nE5f/a769V4e5aJkMe4+QgG6NtA9q/nGGr7z1qk17GMklr4XVW8spvWJD2lxF6sGkUZU4e4B1PcPFSFfSCf+WY3aFeiwX+niZgjt6iQQ+rO3wQ9hCdbxs2JmWv0zVPyKRGAgbIJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378273; c=relaxed/simple;
	bh=8mMyk1ulJwVyqgnppDDhKpfmvXF0Bc4Fw/7P5XU97/g=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=l/XiAto7E2rWeOsn3Q+vkqMevKoCZfMYmfBtjSWkk1X7eZvSWCc/qvRE2V5ImqjKmhMZP41JKaTBnn2G81PJbMsdGzuySrOU2GMX/ZRJSczrbrB/Bbt9fT2oKSRWfui8KVw5jJbj1EX/GBqJiUej+d1H2kCOgb/hpiuF81USL3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XfOStQ/I; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XfOStQ/I"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be8f281714so242212685a.1
        for <selinux@vger.kernel.org>; Fri, 07 Mar 2025 12:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741378270; x=1741983070; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q78/HiWHJU/pFecas/YddCOoXzeJ1vsGLqv0kt0f1Vs=;
        b=XfOStQ/IQBgHLs0DBQ03faY5Egd1dJT4aEYJePKvgj06hiFa1vryZ6ve29oF8j/CDf
         nM14NvzrqCMIqaAhwzxaBiCsL5fyEPTvEqIgQkI+p5XgmYwdI4nV8SlbIxoglidRmocl
         B0Hna8vUCkbq4wwdXFsfHLh2mJ4Y4xS6M0/sg0UQF2O10ABCgsoQYQd6krfjdMqmsdVZ
         U69WmHBFKWCNPKUe/vH+nZWJErleT4dsETqnW6NRJt/wvqRQWmBfYaYnNrmlvGtnuQkg
         php3LMJsptmoR4meZ3G+MG4JWsHa+lS7+maJAJ7zvNubMT7QfOu8gG62V1EmVTq3Pl8R
         QVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741378270; x=1741983070;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q78/HiWHJU/pFecas/YddCOoXzeJ1vsGLqv0kt0f1Vs=;
        b=GXnb8C+Uv1UH2RmN+1RHkfY16xrk9WsS8o6LY1Mj8HCvE3xAq88zRs9BAQlc1mH7+w
         JNJEPNum8XTONo/qGCAWlqUfef/KVhOLKzZgAj2KEKMrc/ZMb2KaR5Dv/LNcCl2QAwA3
         03PpfCZ8LkbC9A9GnXAR31megir9Q07CRSAM3vGgXLBXT/klg4uanhId0BLo8KW0VIAQ
         cJypxUFZs1wLxtJaYQ4gT3kYYzreWQsPN43H4h2cElbhDr9YA+xucWA/SbU5JPLCye1v
         jbzqDVvnbr7UW3/Kpcwlr2c8Xbeu8b7b3wFCbTajjcxiPo8jYGz9uJwPcgyaPwVKLYHq
         rd8w==
X-Forwarded-Encrypted: i=1; AJvYcCWXb0oqDHoUN/vt5tB767CEinO1SiimL3z2WVbMFhJNu2vHO7DZjvU+iHirSKbpqf2/d+TDdsgF@vger.kernel.org
X-Gm-Message-State: AOJu0YzCilQN6hisb3CRCenS9anDmXfWH7/FtgLPEMTdLw7UUTYR5lGz
	kqmv8wtHDP07zyJErCiVQHse/V7tWIkvhO+hJei48x9TLcc7CR6E3R0WWLN/AQ==
X-Gm-Gg: ASbGncsZK8cS+DPZF/nLEXdfDKDB31AWmsQHIKub5qBmpluYRKi92MjOG9lxDfUnVYW
	lKKK8AZBYS8l3k4/EAcqCSBtpv6c9QJDMkZOShCDIDdzeGCQKqbZJp698nuxwuaBq7lSGngWZXl
	vKNl4kA4KbxqCXgYwCL+JZsBsw7SH47Qme1QzwNExdLVQuKsR0MamWLYsd+iyc8vi1UxcJyfdn5
	PGqqLJs19UiyiKsJbvF54sAMhi+eJXxXvYcUubXhvQnfIz3bHlSlYCjpxPlBW145OHyhVWcSL+g
	nkdZlqJgs2GpM+YU8xqGq3zj69bf3e7SO7Xkp6yRJFTqqjy4RfSx2aHG24oyeIW5D+SNW8oZP8E
	ks9C8qqfoRCLhHQ==
X-Google-Smtp-Source: AGHT+IFigSgioC6qGGcWPMc1V2MMvwUklhtlL/Nr0hqqWle0uIyyD/88acNfu9IOe8cY2IJGlAOOrQ==
X-Received: by 2002:a05:620a:1b84:b0:7c3:cd38:9be1 with SMTP id af79cd13be357-7c4e6193e60mr760431985a.48.1741378270458;
        Fri, 07 Mar 2025 12:11:10 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e5500015sm280557185a.85.2025.03.07.12.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 12:11:10 -0800 (PST)
Date: Fri, 07 Mar 2025 15:11:09 -0500
Message-ID: <c53b73fccbc24586776e9240a14dc6b3@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250307_1437/pstg-lib:20250307_1437/pstg-pwork:20250307_1437
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: support wildcard network interface names
References: <20250302154100.104746-1-cgoettsche@seltendoof.de>
In-Reply-To: <20250302154100.104746-1-cgoettsche@seltendoof.de>

On Mar  2, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Add support for wildcard matching of network interface names.  This is
> useful for auto-generated interfaces, for example podman creates network
> interfaces for containers with the naming scheme podman0, podman1,
> podman2, ...
> 
> To maintain backward compatibility guard this feature with a new policy
> capability 'netif_wildcard'.
> 
> Netifcon definitions are compared against in the order given by the
> policy, so userspace tools should sort them in a reasonable order.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: add policy capability netif_wildcard
> ---
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  8 +++++++-
>  security/selinux/ss/services.c             | 16 +++++++++++++---
>  4 files changed, 22 insertions(+), 4 deletions(-)

Looks good, merged into selinux/dev, thanks!

--
paul-moore.com
