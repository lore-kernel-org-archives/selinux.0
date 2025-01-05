Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6911C2BD
	for <selinux@vger.kernel.org>; Sun,  5 Jan 2025 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736042329; cv=none; b=rQJHeCfmk5KQMRrFRyC++4zsbn5QQ+fkM3v/qbeky6hGF99/GW/LkpA/d1VHwAqL1LB8alSSZIajt4//zxzxDTBvpG5Vb+eNTpACcGI6JauLk1bjEfdkHyTCWvC7wMBwmoTxFP9Np72Qsniys+SxeMbuBYMGeOEOPXnPAn2MFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736042329; c=relaxed/simple;
	bh=ystZu7p9BroPRFRdyqxVfJBZlTJKzO4+IKLuJeWQ6uw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ps78hjTN0dCrXchEb3kqMo4yuBiTQ3+XoKHTZBqjj8fgjCbfnCzm3fAdSIm28D5mg0w4VOZMJhagYYOoL1vRqHlF8mTDryNl45r6aa655FZEuvZmyLVMWIbw6di53ddguZLR4XVxmbSUrzhPcutlz2FA6s0CtTdO50dPSsvteow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XbVWlXsw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XbVWlXsw"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46772a0f8fbso117540821cf.3
        for <selinux@vger.kernel.org>; Sat, 04 Jan 2025 17:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736042326; x=1736647126; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdurL+GC/3qSTrwduaqAqnabf2joDVlPm8ghxX5T4FU=;
        b=XbVWlXswREyRUOaKrwoR6ZtcOJUsW8ZWNqrzcNJg/M3vvfBSs/5uZ1Wf6yb1BRvE6p
         cowEo9pU2yHPpiaJ3nWXp1EqWf+VdoOduQJE+kBrWuClduDFhaCJkaImRrmOeb7awodY
         ANZeS78Pa1CjFpXgstxzIQ3DRlHsX+B+5mkolBZy6B49HgB8qhYUGIq1tAh4eO/e1vl9
         1rI7tyCaqeQ0q0d8cUgTui+3tLznWdAhntEdif8cBo0VB8KiiX3fuYJHmEeJrn7lPA3n
         zRjt2KZvbQJShP0qYDBEqY6d8/Ze6BEyuyalxC1s+Z1imQ8F3Ru5889Ks5/aI2FAQe6t
         Io1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736042326; x=1736647126;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gdurL+GC/3qSTrwduaqAqnabf2joDVlPm8ghxX5T4FU=;
        b=RJaiUndm9xuHlGF0UPJp9JCULQrPf3tGY7MaPm+iB0hIc9DsUzcgZLDmoltATfWGm0
         SjnkyCKShvPZg3DZN7yAi+Zb7h+vYzhsQZLSDgfQmbz/S7BzuzJJmPcJJqZEggVxAGXk
         4WkBVhtjJuvKzKfhQ7WMZ42bO6wzLhZoUXByQyoIdOGOgdfW0HBMbl5XMucy8bt4ffX+
         l6lJczp4F1AeLKP63nC67eOOsqsiPNwklIkCI2NVSDU44+LD5G+AUlLhpGpTcWndJM5m
         fl2SD/Wq1JzDZ669GnWeZC0NLgJo1V8tfYdfGVBsVpDndhIH3BrzrbaXeSi/rEGwUInw
         zWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuxqIZhG/mrDAFeejDkGRLZm+CNNvfrAYS2bIqjlUdv/fH0Tgh+3Li1C3SvZc37F8pIgSyxyZK@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4XNLg/L5ppGZYmzoeV0osrhI/8ESixRM2K1wFz6hC+a1xEpe
	FODc4mBwuEeixZtLsWf41MbA5vZU6V3Popzo+MLhJ7UbY267ZNMvo3TkTch3Dg==
X-Gm-Gg: ASbGnctW0dAznKG7o/7kOF+/I/EhPrptvb59N8vQuo6j7H0RjnoYuLlPsCxVqtcW+8Y
	yCfP1eJGbVsW23HTUwSvy8PSZKJCigY6+p3wq1yPUlC8b2ZmpjXd6ro3woBnlQS2kVuHDOZxmk8
	bvDmHie7FLsCDEQcp7abAHSo38Yvk+nT89se1f0BfQ8XVnF+SoZHRfgRXj51mwkPDzemn/Q0dHN
	xTcIM4cHOdKTd9fgc6PL9iinNbnoaGjjEpkBPP2eIWLn9ycpmU=
X-Google-Smtp-Source: AGHT+IEMGehhDoZi5KAdtLL/jmbR8VmojSjJILJUuGrVQWDziUyPxIoO649+N21MLwr3ilMnfzvlFQ==
X-Received: by 2002:a05:6214:2a48:b0:6d8:9124:878e with SMTP id 6a1803df08f44-6dd23320f94mr953101256d6.4.1736042326313;
        Sat, 04 Jan 2025 17:58:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac47a36bsm1401067785a.91.2025.01.04.17.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:58:45 -0800 (PST)
Date: Sat, 04 Jan 2025 20:58:45 -0500
Message-ID: <63c39dfbbe89626ab6fe17686ef67bf4@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, "=?UTF-8?q?Bram=20Bonn=C3=A9?=" <brambonne@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Subject: Re: [PATCH v2] selinux: match extended permissions to their base  permissions
References: <20241220042558.862915-1-tweek@google.com>
In-Reply-To: <20241220042558.862915-1-tweek@google.com>

On Dec 19, 2024 "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com> wrote:
> 
> In commit d1d991efaf34 ("selinux: Add netlink xperm support") a new
> extended permission was added ("nlmsg"). This was the second extended
> permission implemented in selinux ("ioctl" being the first one).
> 
> Extended permissions are associated with a base permission. It was found
> that, in the access vector cache (avc), the extended permission did not
> keep track of its base permission. This is an issue for a domain that is
> using both extended permissions (i.e., a domain calling ioctl() on a
> netlink socket). In this case, the extended permissions were
> overlapping.
> 
> Keep track of the base permission in the cache. A new field "base_perm"
> is added to struct extended_perms_decision to make sure that the
> extended permission refers to the correct policy permission. A new field
> "base_perms" is added to struct extended_perms to quickly decide if
> extended permissions apply.
> 
> While it is in theory possible to retrieve the base permission from the
> access vector, the same base permission may not be mapped to the same
> bit for each class (e.g., "nlmsg" is mapped to a different bit for
> "netlink_route_socket" and "netlink_audit_socket"). Instead, use a
> constant (AVC_EXT_IOCTL or AVC_EXT_NLMSG) provided by the caller.
> 
> Fixes: d1d991efaf34 ("selinux: Add netlink xperm support")
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
> v2:
> Based on Paul's feedback:
>  - Move base_perms to the second field in struct extended_perms.
>  - In context_struct_compute_av, memset the whole structure (instead of
>    each field individually).
>  - In services_compute_xperms_decision, merge the "if" blocks.
> 
>  security/selinux/avc.c              | 61 ++++++++++++++++-------------
>  security/selinux/hooks.c            |  6 +--
>  security/selinux/include/avc.h      |  5 ++-
>  security/selinux/include/security.h |  3 ++
>  security/selinux/ss/services.c      | 28 +++++++++----
>  5 files changed, 65 insertions(+), 38 deletions(-)

Merged into selinux/stable-6.13, thanks!

--
paul-moore.com
