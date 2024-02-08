Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29137153
	for <selinux@vger.kernel.org>; Thu,  8 Feb 2024 03:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362335; cv=none; b=npY4vD5cIIRLg3Cdt4ahMm5wTZfLo17VDXA5FKUiV5yZpMjPmFONBkXv/Gvy1TW+cQaN5eaGk/4m+ii/DurQZtPu/W/Ro0k62l/7CZPx2qgxd/G9lXMZnTTm10u0YTo4UBchdamo7lAUtv2qXTHWyoaoAdy7felBIv81iIhQ+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362335; c=relaxed/simple;
	bh=DiwlVKq/rRLjPWH/bc00wUtKBB7mMXp+ciN6o9DkWP8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=IXjgvD0O67S0b13nv760txZkFRRBhVbK4oAmJtRaWPt0x33x13wz7l7EMXl2kM6Dw1HO2fV+fr80BbOAkVOeqndeJ7ZozaIqaU7ykkEgH3iKhu8Y92ZyMSWpNJyBvnBByzctRcanCeiImeHMLYqJxAIhpr+N8ruuxKwmAm71pes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gRN7/ZjC; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gRN7/ZjC"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783def87c8cso72630685a.0
        for <selinux@vger.kernel.org>; Wed, 07 Feb 2024 19:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362329; x=1707967129; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w8uIF53Z2DXmiuq41g+nsrX3AvPRF8jg5UUgvEoPViA=;
        b=gRN7/ZjCN1IvnwEnxdoxsOThk5bMY0fzylZ6zONpLn/qATAkAkbUyZ80kWcjWQmnNs
         0dLAvsipHS6uScN8IKo4Rp0PjQeu5/1wOOGGtR+fiU1KyGv5KXkgPTLhn3IUW/OFmuJ4
         yqHzAnZQp1Ja7HKB6cjvpgd6MqthzfJlkw7OMvRrizPcLhIG6Qn+yNPlSWPFapaHHIjN
         xJcK+jeDcJLGLe0SUDmlD5XIF9SbSubhCCfhc9YrMy2p1OVaFvTybPQtOPUMHBTa0/8X
         tt9eA/xpwgDHc0HISsQJwxvQqj9nNFZdQfyQPzothgLBHzCAw+23gZQDBy99wQ8H2WlW
         CphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362329; x=1707967129;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8uIF53Z2DXmiuq41g+nsrX3AvPRF8jg5UUgvEoPViA=;
        b=EU0D0QA4EVySiTy7jtA416ppbfY7Un2wxxllPqAnm7OOXeDrf1P5Gz3XEqXb1GrUx0
         MKVOLJh/dwUKBUkkXrVi/+CFgP/7nw90rPwA2rA652xY97bhBEieNJoqkiSB5wqB7kYv
         /xRP3m3kGdAN9yT0wr68Rtzl9NRlD7vo7nZWQR0cdhM4zjo6vIB0ry3LsgUsQ7VbGiI3
         672rxJfLNTqsvemDBuFT8TkGViUtlAQnDgFgiJ5J0vZU4ZNomt7ksGHlhV7Jw/6cm2x8
         BurdY8lQbeXHG/6b5a4V7L9VleTmoRy2BPkmoIwAOeFbEW4T36ynQ1I0fGfCT7GHZGy9
         xN6A==
X-Forwarded-Encrypted: i=1; AJvYcCWfulkOihflHpIFgb5AvE+JAf7lAyqoGIySQiRLfwxMzrbIT6J0tJRpPg9zCqpU7KckUO7ZhQBwktE7+prx7eKCNp1CqFZ6QQ==
X-Gm-Message-State: AOJu0Yy7ILEWUOJNLgsx8126t6jwzVsI0y2mN/QVrcngXCTbNfdiKlm+
	36l8Hv8dujW7/FfyJSKgDapgQgqztdNdJSiRUJBiSfzDbfdRdv/R92b9vNdnew==
X-Google-Smtp-Source: AGHT+IGouxVsdwxvxxJ96/FPEYbCGLXmMxM09SVFDDRIXGnHSmuGQLn7Z94ZYhb0/P1VLm8XriRe8g==
X-Received: by 2002:a05:620a:5d:b0:785:8bb1:5d6d with SMTP id t29-20020a05620a005d00b007858bb15d6dmr7695936qkt.32.1707362329414;
        Wed, 07 Feb 2024 19:18:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViKYI8R9WvIOxPbkG2M4Av2YXb0xQA7czB3RiiA4Zzl0QwFFVI56/1xAkCejRCH2QojDt85FsuaL6a6Kb3gZqyuXItl+GGFhfTbtrfsUAhi84hRDUXU/lJMeAoNs3+UcMCV+sKoH74nLJCp+we9mEV9XExWQWsv7JUjTLJRs+MsUrUWrol6axwrKh7asMc4OaSWWr49VWjS4Nrw9tJFCVmeYgZQEJvRy6DCI039tgwg/23ti0cQ43eSIkDbUDu1wZJMeDuNF9p9wEW8F5mil6vM5fOQDBit0UAa5G3WOQenTf5LelmaVd4RD0YYjOYAYoXoLmdJZGUUlrNzWpIw8iVPidW2KkNQU61FneQH6Gv8HPsxvsIFPOyvF86D/k4yUqc9cYrixD+QrJbyjnFPYXwQ1YiJBzqG0quifcUGI25OSqW4cs2XdX5G2wxfAXBtKt4GX3RSvRUbDV+o2BdwrZvm/GUKqLktRs4LBuSPr3GsOkAnIIN064yu/OB4XZwl3WQVqLY38Mo6G8iAt6CcmyGOg+BxBIlILyY/XXjiZz6Mz0sKUgH7cMdU4BN6Sq5zxxkPnq4m3T2Fp6BeIUFIbqK45ht8qNiG4IDfaHI+CY+asy+OLQQEsLVZMrYna9MGzCDDaVu03UHsUgT+jBjCFBuUUgG73Evm9gqAoAMbBUyxN5pAPFi7rkgYlZVkNawpbw10N9sE1XrxLScQuV6GzkeCZ+qBR2FRgadT4E03+to6aVg1JIn4l9/smIr55wYbqYz+r6yFke7CIYYqq8bqBV9ndAvBP78sR5rj/zby4dUph6GCOMkwEYKpxixJL8BAL9xj7inzhrBwXyo6rjWFGu8kOnrTFATEud2Wcp8/WOJZVviJbqSD75JwzW47ZrfXCg+0EbLdoDtUZc+jlnoF2uPo5Xq3JqVMqzXWs2Oknt7AOJthrQCjGENUUpCY7h/isyaT2
 blihkViOIOu+Q=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l4-20020a05620a210400b007855b0befb4sm1068621qkl.92.2024.02.07.19.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:49 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:48 -0500
Message-ID: <a00ac4a8ea267e7f03912197728c3081@paul-moore.com>
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
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 17/25] security: Introduce inode_post_remove_acl hook
References: <20240115181809.885385-18-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-18-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_remove_acl hook.
> 
> At inode_remove_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_remove_acl, EVM re-calculates the file's HMAC with the passed
> POSIX ACL removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> removal.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  8 ++++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 28 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
