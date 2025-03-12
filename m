Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419B1F2367
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741823497; cv=none; b=ksa0YmbsH8E1YT4gosbkHd3Cma5a2/ssBQpdWzJpp0qa/n5YDrvJpWt3m33PAxCxSo294j7WjoQQAeKsO/MTGNnmKMFTltg+G6hZEW1TZb1yo9IP75A7OEYrxFcAx2mbEXi9C7DU+aT3Ra8KF6Fn7OUY3GzqGu738IGGfg+kDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741823497; c=relaxed/simple;
	bh=nZppvXExe9z50boTqFggcjUjW+ehiSBBDdzzf3Mnh3I=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=NdhP6K+CGhl7AUjWkLYEFxp+LpOks/SAVjrKolRcdQxjhQKKFwelLpQjkUqg8qaOa5n5amjKf/Ou52pti7Q1I8cVmhjiiyglv2FNEGxurARzgOBjNRKQkPZHbt3tQO2/WPkz78r2oQiTdkTavJtIaxCQfl1qC76f+w/7BIupmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EZ+8pCy1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EZ+8pCy1"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e904f53151so3485806d6.3
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 16:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741823494; x=1742428294; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CW90axoo0o9jpPTk+/SEj4I5AijDX95SkVqF//3Gczg=;
        b=EZ+8pCy1b5Iv8gyVt3xRDvb6fknPtM29D7El+oqDFPB4nlAJdTHmzlgZkh+j+qcaRB
         ufXPokzwA3jOcyPOgJ6lRj/1FRB4O/U7V2SJyBLYKb7B1W772i+tNpFNThJGy3N3+af0
         utDAn8vAFyBooZrDMKhCd9AfaUxyCSIamTBv16Kdv1S/EMlW4dNpGQR47Xq8GYIjsZqb
         EtPLL+uSznx3rLfY6c49YpsPXp5XC13dnKXhidIXyRi7FXUZs81FZF1PRhXEiCiiRy2x
         PuTpWh3Fmrw55t+cZImN0KN865YapvUmZDmip+p7FVJ21KKka9e7P1l4Sze1kCyvDQZR
         NJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741823494; x=1742428294;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CW90axoo0o9jpPTk+/SEj4I5AijDX95SkVqF//3Gczg=;
        b=ZoTIIjdic0GfQJSYpCn4bAal5+U52f1kW0n46g97+K70meoM3T0xjTjXNb5Cgl9lwD
         Q9uGp/RNlu72BCeAFzgNGyhly4llBMPAn4W+2PBP90Vp+wrzU0WTDOZrlV9Raxj2fD8/
         Hl3XLf7CFOxRDSii6XWqjAuDuDehlwX8c8qRWsCu9xGUIgxUHv/zmvZfOasKaKeAyCSb
         yyjVknBbApBWafa1zT8e12A0qeVJ8351HzqNAN7Drv7wS7NNsWXCZ3Y840WzmdXZ8mfR
         /tCWZ0afw/l4s7K2yRosEDbqGnzXypSAHPAapsZQju0e0JRFQ2hBgg1R4GoIJSqeefRY
         /1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVneHWHmHUl7lrCoG2X/ucPJd3UCoRqKiOshM4pJMNxaVDWJV50kQpf1nV2P5zuSD1BFFSFlYye@vger.kernel.org
X-Gm-Message-State: AOJu0YxaI+9WRbTC5QM2cqD2x1o+B1os1OQ6JMWLl/ecS1JFw3esY38K
	tsIwPd1C+SOQ6BZzMUQORd37e5VqM5uL43dvmbPhCMM6C1ePyXflxheJbkWKDw==
X-Gm-Gg: ASbGnctA8WhFR6lMJPzXXJeBNoWWgS+Qzsh/38NuXFg8nXPndZsPfP6TXcr4NJcFs9r
	XR0OrrVp277P9RYnyBjb/aZH13C6nvwlaPDpmAgkF4E4XycVeh8nsPIL3jTDLYy7sZwOA5+tgJE
	RPo9XgWaQ0aqOIAV/f8sNE8XcxzTL3Z+fTCzWb0qaPRo7FwN6L/sH/trukduqGcXZ2hIHHodJ+I
	bWzqnZrWeZoRtWiCviAhctwB0FwiJfWDfbrXo1936AstWHbpgnR3EoXZHk5rvW18bNVF+h4QoAY
	JBGrggOXXd0K9aTDaDxrTD8eoJqWHrviGSoV+eXulCkjMPxfgA8D0CQdqsst72TUy2wRSh+loBL
	IAZvMa4yMHZWwHQ==
X-Google-Smtp-Source: AGHT+IFSqTK2ilUcKx6zm2i0BV+o8XNbFHCnS5If+1fP0sLk3byjVxocCH06FxErBK2o3HRcOC9grQ==
X-Received: by 2002:ad4:5c8e:0:b0:6e8:fb44:5bda with SMTP id 6a1803df08f44-6e900609592mr404688736d6.19.1741823494123;
        Wed, 12 Mar 2025 16:51:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34c51fsm1722136d6.109.2025.03.12.16.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 16:51:33 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:51:33 -0400
Message-ID: <d3a295144441248d47fee124e30a008a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250312_1930/pstg-lib:20250312_1930/pstg-pwork:20250312_1930
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/6] Audit: Create audit_stamp structure
References: <20250307183701.16970-2-casey@schaufler-ca.com>
In-Reply-To: <20250307183701.16970-2-casey@schaufler-ca.com>

On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
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

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 9c853cde9abe..2ec3a0d85447 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -994,10 +994,10 @@ static void audit_reset_context(struct audit_context *ctx)
>  	 */
>  
>  	ctx->current_state = ctx->state;
> -	ctx->serial = 0;
> +	ctx->stamp.serial = 0;
>  	ctx->major = 0;
>  	ctx->uring_op = 0;
> -	ctx->ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
> +	ctx->stamp.ctime = (struct timespec64){ .tv_sec = 0, .tv_nsec = 0 };
>  	memset(ctx->argv, 0, sizeof(ctx->argv));
>  	ctx->return_code = 0;
>  	ctx->prio = (ctx->state == AUDIT_STATE_RECORD ? ~0ULL : 0);

Since we are now combining the timestamp and serial number into a single
struct, let's move both clear/reset instructions together up to where
we currently reset ctx->serial.

--
paul-moore.com
