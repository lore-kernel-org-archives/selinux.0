Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58411F9C0
	for <selinux@vger.kernel.org>; Thu,  4 Sep 2025 20:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016957; cv=none; b=P+yKXYfW02ZEd49aWkNYr+qK/P08NxxETouGHBtpSlzIuwptZXTbxiv4ROBzzC7Rh/sW4uHZA7On7BzQqADL2L8chyOBIOoQwTboldbxEbQYEbVkAd5ZFSD8L5NpGiQj7Qb3SLP45Fo8mbi2ZBEsC90KhtKB06Dq5F/pFPJPbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016957; c=relaxed/simple;
	bh=qVNT0CbMSIOU8qDaxlLhQHgz+L25Hqq/GpRSW9zCIdY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=f/efcsLLez18qoTEgH7N+rcy2ye1OMCMkYz+9VZFYFzG1hva0q/Ii4jiQySbwmAa/3B+4VI0QG0verhjT1QRYtDRg7T9Jd1hr4OWJFfety7Qn9vtVJ+lOLX8qlfyr86vbUq4l8fSI6eZFQLwISpPFA/aMPk0qLnpN83NtjfhBnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ccUHMCob; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ccUHMCob"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8072bb631daso149283385a.1
        for <selinux@vger.kernel.org>; Thu, 04 Sep 2025 13:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757016954; x=1757621754; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+680EUIEPlbLOYfx6FNfIkN7nwv+fre8jP7yiSa4FY=;
        b=ccUHMCobupeqH2+VzoztjCjZ3AJELJhhDjD8Q+4NCV0hS871UpEGc97gES6tUXbbqj
         gkkCVtT6YvSo4TkSYgDJIeQRxsmkT76wAMf+mphll2aLxjhE/AnEFBtky7IO6KnuHS1U
         xahz65rDKJ/MeZwlgWQl0eqcd1M5RC9Qops6OqAP7wULdWU9js27mVnHjMvZzZSCYz/J
         AOAQQvXwi1LUbGoLwV/4DRjW4KdgaygcfF4ew7RobT3WMKmI7iwsqh7Br3eOEMVA3Tkr
         j+gJ0OzuhdjzsXRNJ4l1otjaFibTA3bDqrkYwzcaHBOCBNtaEShkuFctOpi14gVwYnmI
         GQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757016954; x=1757621754;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/+680EUIEPlbLOYfx6FNfIkN7nwv+fre8jP7yiSa4FY=;
        b=shpNtSVYBUQqcfEA5SuaAce/2LhSX2TeJVQAuDBluyo9PPbgpMBipT9NTL0QQZvr80
         /2LOE4RYU98IBGCywoLHZm8W1COW9Ge/I8DDTDCnF23uN2HYNztXnhbIA9u7JlXntPPA
         eg2MCO83ppP6pzuC0ZW8S7WjkXzC/N0BzDXQeoV5LS+gtPM3FhwqfjqRhXT7bzCuzE1z
         H+GcdxNSnu2NG1IfWwAGbfaqDkkjj7Eik6fA7ChIIlQfLuKLWo6cOWeFZyMjTvMSUA2F
         VL0P39/mVbOHRmXyJwrQJy/INK6vlHxI6RtzUltyR8i2VEuwpNcnrT+IylVhYZktwXEg
         YigA==
X-Forwarded-Encrypted: i=1; AJvYcCV+JpHeqEIJmjIVtPcAM55TyFWLJnDJJstAth34tTccma0tKCGgP6uTK410ZybpuGPeUolfdoQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRxoxK6W2LtUadZlKqeBqVKv5Px1jeQT6lJ47x/M7iyGUKmB8
	FCzvxX/1Wb7B2G69fmi5AWxk4pNVLjJ0zsyN26p3HrFMWDs2tYjGh45zuJ98ODbRdA==
X-Gm-Gg: ASbGnct0YD89ZspcFytSLPVb13ewzMLodtgsQa0cthihHeEQI/F6AI3J0INL98udD+a
	2BEp68NszwfUbkz2XyM0MiBIbEqJjemgczwLd62bkh4X1Nzi0PHElGfQDPCjeHfG5cGoi6av5+e
	l7Haxu33okXZtC5FyKaKjxBTTCtAf2u49CvtvGjROvjFxmLNknfZUO5JkcucS1FvNvhsQlDSx5i
	7JwHLG7MDuRIXt96pGCgNBTU0L5xOclhjcsbIvY51tS8GTZOn4Y/W+PGWHJJg8CyD9Gq/dy3j+n
	5wrMiDbP/FBVTgimRPvB4XIlPuJ7xj77W+zJq3IjtY6xAeQRiwKVJ44LlSvmUyvY1UEZ8HCF5Ix
	O7C6gFPbhShcESlAYP2R+Jwdqt/T4VNpK+H9RdbPw2K98xi9Y/qwRsbuwB6JqMgrqXDbbaW3RdD
	LDwjAXqsZXvL6ndw==
X-Google-Smtp-Source: AGHT+IGcpdOqg5H1mkv4XguVPsHn1zuGxeD7ZQ/j0Cwgoh/FoGRTVROAIGg/0Ow4seoYOufr8Iy2Wg==
X-Received: by 2002:a05:620a:28c2:b0:7ea:44c:d4a8 with SMTP id af79cd13be357-7ff26eaafa5mr2625182285a.14.1757016953965;
        Thu, 04 Sep 2025 13:15:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aaacfeb4bsm342220885a.41.2025.09.04.13.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:15:53 -0700 (PDT)
Date: Thu, 04 Sep 2025 16:15:52 -0400
Message-ID: <e2c4c055ff356b4fe5d49bc9df3fd2ab@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250903_1645/pstg-lib:20250904_1609/pstg-pwork:20250903_1645
From: Paul Moore <paul@paul-moore.com>
To: Neill Kapron <nkapron@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: Neill Kapron <nkapron@google.com>, kernel-team@android.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selinux: enable per-file labeling for functionfs
References: <20250828170317.2322582-1-nkapron@google.com>
In-Reply-To: <20250828170317.2322582-1-nkapron@google.com>

On Aug 28, 2025 Neill Kapron <nkapron@google.com> wrote:
> 
> This patch adds support for genfscon per-file labeling of functionfs
> files as well as support for userspace to apply labels after new
> functionfs endpoints are created.
> 
> This allows for separate labels and therefore access control on a
> per-endpoint basis. An example use case would be for the default
> endpoint EP0 used as a restricted control endpoint, and additional
> usb endpoints to be used by other more permissive domains.
> 
> It should be noted that if there are multiple functionfs mounts on a
> system, genfs file labels will apply to all mounts, and therefore will not
> likely be as useful as the userspace relabeling portion of this patch -
> the addition to selinux_is_genfs_special_handling().
> 
> This patch introduces the functionfs_seclabel policycap to maintain
> existing functionfs genfscon behavior unless explicitly enabled.
> 
> Signed-off-by: Neill Kapron <nkapron@google.com>
> 
> Changes since v1:
> - Add functionfs_seclabel policycap
> - Move new functionality to the end of existing lists
> 
> Changes since v2:
> - Sending as separate patches
> 
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c                   | 8 ++++++--
>  security/selinux/include/policycap.h       | 1 +
>  security/selinux/include/policycap_names.h | 1 +
>  security/selinux/include/security.h        | 6 ++++++
>  4 files changed, 14 insertions(+), 2 deletions(-)

Merged into selinux/dev, thanks!

--
paul-moore.com
