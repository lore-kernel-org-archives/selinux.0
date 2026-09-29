Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC845DF68
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697564; cv=none; b=ntWjzd2kZrMEZ9ondhc1MRUrdAkgGG8W19JT4pfycRC0EmQxZN9gRvNcaC/Z/vEUwpL+WmRAW8ekVzeaB73a4VPdAEmkAzEJ8b2LrGzsn//rfNhImNmu8Hc+3MUf2ThoT9P9mxzpGTyB+mmzS2rETQ5rumSI10ZV2rVgerCqyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697564; c=relaxed/simple;
	bh=bwnWYK80nFfKr3iwUcfFe3FiEOIbobSQBQGXAMlfsws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqT9sRT1MpourSyu4ehf1U2xTca/ZuKg2jrGT06dSE3gJUUCJMAMT0WgOq+C7Nd3Io+opY5m0omX6ecGsynWBt8Zsvp81cNTm4kg18wBBqINJVxyyfjtjFu/RpJ/lslOM2aZMkUwRgg+aTzOy7VQULVlPYihLGOUjcpreloKip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nYBYdIxr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nYBYdIxr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so24869415e9.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697560; x=1791302360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=nYBYdIxrDawbXfSaFe7w3OFYOIJlQrI7qz59yDzNoP/mpoddTQw11jDpz8fIdtFR8U
         Znr8Mf9igyXtWKyhX9oMfdAJDqgBGoGjvHJ6igkkprc58F97zd5CcoCsAlzLvRI3ylim
         m1hLqtLjxW1ZBq19GMmUHaYSFSOffW8bLP3K3qMkDov5FsMy3S3x/irgsjS1eOVIRxq+
         mTxoNRrvS3DP/l/GGQcl6eQRSamNLt1PpjT8Td4ULW0LxMOaLDCJ+NvWfW4h18DY5Ss0
         azhkGRaDxXPuY2FEehlaV3VB2aS/wbvlM5l1jOZ2enaChDZdM1x+J0h36wzrNkROlZrg
         6rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697560; x=1791302360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=qDLPDZFtPJFH0mJ3k+Pwh4BSFpV1vMAKPA7S3t2U4zEaJ03rOfywUZBJxvUlxQkODK
         KLYmE8UD/ffCDdlM/1ObNUG8/CvAEztfkWTSa8rY7YfJ+YtEdUun9fqyzHmchWo2ttZm
         knRDR2MAim9bVPl9NR8p+G0kejfn/KUYHiEjxq75lCqd3Y6D/yg1DFrn/cBBTKOyWpaV
         mKaTagU7nwQpgz5MJTHafx7/u5L8F/3HB0kA2Bp74u6l5M75ZUGLjerz42ya7HC7yrWv
         t76/A6u7Fg1aA36kORDq6oMznAj0h3QmQXxhl7jMXwGa0fZY8oI6+ZZpXHcNa4pitASg
         5k8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwgCyqGR+GGSDGz8XUWQxbJdLANSMW8IJnaq4dK94STnJjOh4xzFuDkg4Pxl1UUukOxhx6Onio2@vger.kernel.org
X-Gm-Message-State: AFuF++mfu2+gtr1ZAxivgyg61onmKjmOvf+ZLiGxJZUfjFglpKi9fcKD
	ffzUihAqEybnVuIS5bQTavAG27GZNsBrH0rM+hKU/G62XR6QY4FcZV53urBD/LYTl8Q=
X-Gm-Gg: AYBFou3XptRgOlHvNmdjM9fInqL7YIX0FCZ7/B/CW8aG9t0bITPvVCB7sHjy0M5/Oon
	j/9OpfXoP4/pFZjVpRXCfA2sied64dr9H/owHvazvEgk2mO4ygRHtNi8kqYc+lbzahPPLbhYUNR
	jYElwtqKvldmjqvz0yYfbE7H0r5oQ0t2WGmMuBxDVvwqko2H90QMkPjYUnEwvT6fDEpzMoKKg5C
	LjcMLxID8+WxKqS3LUuctbxpEkkz227HSgZByiJpF5OweUHZwQ9i3ed3fgSRDyn/VmDy61Go8ZZ
	Ugb1YOa2o/kZ1VgYlQayIfFKk/6k1z5r7MmvaZUCq5/nnBD8mdzuc9j5WPC26cuM17ec2VrOfrZ
	d/00WO2mmhMefqSWWphlSck5dgqptUVuAADB7tzS0NJmde1XveKE6m2gucJZQ9lWfidEW0dVu1c
	mAmT5rMPkMRIli/mhevZIh+00qhjb8iPxfZjWFi02DXPyqCjBxkwsWNOS6Xuxs29cnpQ==
X-Received: by 2002:a05:600c:46d4:b0:49f:ec98:f030 with SMTP id 5b1f17b1804b1-49ff06f839dmr227620145e9.33.1790697559827;
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013c6f295sm7062155e9.0.2026.09.29.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:59:17 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
Message-ID: <arvgNTUgcO0nPh-V@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:16PM +0100, Lorenzo Stoakes (ARM) wrote:
> MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied by
> MMAP.
> 
> Also while we're here delete useless comments for mmap actions whose names
> clearly indicate what they are for.
> 
> Also update the userland VMA tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
