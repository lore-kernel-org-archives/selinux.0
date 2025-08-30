Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF3253B71
	for <selinux@vger.kernel.org>; Sat, 30 Aug 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756563295; cv=none; b=HybY+c9uxkzog1UMi9ZPKFw5hUAzdO0gjUvYXlJ5UF3ZNGf1PV7wlFwsYNWMCUrHD+LMNPNzqzxUV6Linjc4tOqehA3ZDbs74YUTa84yzM94DVnkqu+QtNM2k8Nq+dPXyxqifwB+qlXAcCjqkom3wIhwghzMJGePhbKRTmnnjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756563295; c=relaxed/simple;
	bh=NLarFhy3kQ/TjCF4gbAzrkvsWHYogEKJLhKX1GQRe6E=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=WNrORXwclnsgqqJDrZ3Yoxpc3ehy01V0tC9b3LJuNa6XArYZPKAgfDJVZ8KSK+XqFvik6FgdsUyQ1Gphd+3Qg+VvuI8TzSNdqDxn+TMOuYtkn9VwdYqrIeODJGPGM9rsXVAoWDG7vk81Sp4ExA6b+9tY0PAAxYE090Qy5hynoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PzTO+rLX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PzTO+rLX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77033293ed8so2691325b3a.0
        for <selinux@vger.kernel.org>; Sat, 30 Aug 2025 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756563293; x=1757168093; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vhRNtUPsZDFJYGrztPkjMPFnVe+Rwz4ScA0R7wbO7c=;
        b=PzTO+rLXWFtNInMn5cl2f5knPnOvyE8e/ZqjD6aiCCgQ+BqEwHDYo2HM/3A5Bp3ZZy
         kYJ8hDu8Ienhgrt1uHtN16ectKQmQN08h8U2JrVHJuXTQ6jnCisyevIRb9LNG56KJ7oN
         j9nGMxcgPfM/4aK6n0gGcpk91LIAFAwD81DpLOkPe8CIUGHcG0gAPew+VP5xXWRp+/oJ
         13bFkvkb0Hk2b+Zp87AaWQUa4siq/7PfpHEC/vTtqCqxPZSIK7weWF5prqkbRimVzCQs
         1jE3rlj/30EYzDkgEAkf6paZLUkCmynYaNk/jQH8zHBcHE2K6C+gqg/WV6lz1lY/VXVe
         YRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756563293; x=1757168093;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/vhRNtUPsZDFJYGrztPkjMPFnVe+Rwz4ScA0R7wbO7c=;
        b=rOytEUPDB13/a3gcuBcq5vQ6+jAcleB19wLhoAQSwVJcu98mezIYbhVUXJ8ZdgoBIp
         w/aavzxRDTfxhU9Xaug7X5xwwcAm5B6o9/L98epsFnO//wXDinYkdLMgV3I9ypcgXh8s
         Nw19qjv4tJv2yoYeP9GoN4kQu9oJSeac6CnlpX+7Bp7dUQ9bPqlknwiXlTaVYGfkfGO/
         Y0J6UkeorpDBgGoZtLAMmFanV0/IRGchbK63jzM181GiOX4i5uF9VrDGxu/h97p3lswb
         fcto7tEEj5R+wBtH/2NhYLQJEibZm8hK9aijfERMFSEjW71QsSr1kj3NcASc5CB7gjqJ
         LPQg==
X-Forwarded-Encrypted: i=1; AJvYcCXTaNEwzirEOLvay/GqCJdzqbmA12N8bbWXgFRrBWIUdiQITLie1eAtQQuL1gny3+WmFfh7sOY7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+YV5pQThya2aVtIK/uG2qKehlau8nUv8Y2bH+0nkF0+2TfHK
	4Axt3lN/d6buVOv423LYsWw8WsyXGIjAX+0b0IewTJ6VpnMGcNIc+RuTXEoMqteHmA==
X-Gm-Gg: ASbGnctb3emtzyVr24fCDNRguSas26E16eeYrXeiHH0V64UnCoHM8j43qNRcd6OT5Cc
	/fbGeLA9ihsRz1tIfbKPCmwSkL2MaG104yeWQIDUy1v45Kj9rDbPutiLzzCO8lziJ7gKFXZCC+Z
	PDIDjBQg1iQGi5yh4Zuib9bCgbHv/UYO5mOmRS86Qn7QD/FuvSCSUrhLeDYatXKB6PVTYie+7Aj
	ojL0iksuJ8uniONUM0A3pgBzvPahtbbr12JyQqhBjcBQlhjk+o45YAcAyi408NzPZdjuR9/kR1X
	f3qnxcE+biio6Xq/bP5qpIDk7BqR7Fp3GlcJNy+BchyNYhTXW3EAD33aBkHv6BzMTO+TH/ArWZb
	jFoby/eua8HQJbw==
X-Google-Smtp-Source: AGHT+IGXGDxudBPOQGj+2n/Xq4JGPNY8rIEn5BPaZdBF3FLtxzrLU7/7VkCvAu8X+BdRWPuL6Qz8AQ==
X-Received: by 2002:a05:6300:210d:b0:243:966e:21a with SMTP id adf61e73a8af0-243d6f0b8a2mr3512373637.36.1756563293102;
        Sat, 30 Aug 2025 07:14:53 -0700 (PDT)
Received: from localhost ([205.220.129.22])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3296c8c11eesm1319169a91.19.2025.08.30.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 07:14:52 -0700 (PDT)
Date: Sat, 30 Aug 2025 10:14:37 -0400
Message-ID: <e6e9ea4bacac5553810f7963533a71ca@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250830_ 948/pstg-lib:20250830_ 845/pstg-pwork:20250830_ 948
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 1/4] Audit: Create audit_stamp structure
References: <20250816172859.6437-2-casey@schaufler-ca.com>
In-Reply-To: <20250816172859.6437-2-casey@schaufler-ca.com>

On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the timestamp and serial number pair used in audit records
> with a structure containing the two elements.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c   | 17 +++++++++--------
>  kernel/audit.h   | 13 +++++++++----
>  kernel/auditsc.c | 22 +++++++++-------------
>  3 files changed, 27 insertions(+), 25 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com
