Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232A91BB691
	for <selinux@vger.kernel.org>; Thu, 12 Sep 2024 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174791; cv=none; b=hBH7w1ZHbVUGC85B4SWkCegrLTudBNUwwUCqhBYgYctGMsLLeSUT3EQ6XSw+GQJP3vef/A1UbO3BWQK5OlXlecdF4IkKQYFISCKCOjcK8y81qMFGOgNVO3QkAuCchrPBHt6tXw1kxE9WeBDkQwU6xmaPVDpykUORm/NEc6PWuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174791; c=relaxed/simple;
	bh=cAbAdJfAWvXcMGzLQXEJz8mvDAf9C94T25Rumz8sqaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOk/l/W83oDakBUlq0+ZNZMlOd+vXzmcKej3N8uE0pZFJz7NPTOjtRoQ4W4MoNtt7m9qZRDqqvEjFdqbLjzivNqgQE253A1d/9YXAUObfYU2MimHwBHO39k6DPD5JSXaXWqXBCeBCdNaNzQE96eHPjbuD/YFHsUfrQJaEZCPmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fwSk6H6F; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwSk6H6F"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-277f815e6dcso715444fac.2
        for <selinux@vger.kernel.org>; Thu, 12 Sep 2024 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174788; x=1726779588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mM5Z0KLUO8efTiZgA6ECQxJ5r+uA/1F2hapQlso44M=;
        b=fwSk6H6FwFSImla2JI4db2pKAihE3YGTsdT6hM7GiyLo8SRYVdzhLPUrn5lI0G4KXC
         bKOqdpt9tLhJkQoG9TJfdFqctjoJXVjK+WS4grWX2SGXuPat7AvL/3nTrGb9ZU1e5pTk
         8wsnnRYD0GJAqvSAq7s0OHt8leWJKpEMZvvtvTBK5bvZmBROM1v0Lzt30OoCjXXDqiCj
         RuOdhh8EBGO+/mX+EJN8eT99KItxRnyvsgtua7OzQ0XEftb2ryV6PFR9a1oi6UO8TshT
         H+H2WCqRy/z3JHygHgUcpjaDm3rt7rHd3EMcEeuuVKkk55Vd97MD1X4vqC+qVKehiOC2
         cHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174788; x=1726779588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mM5Z0KLUO8efTiZgA6ECQxJ5r+uA/1F2hapQlso44M=;
        b=GON0+j2JFbUnmZ8ThZQQWK8KltCHC4C6V0naSNt8bD9tIIRUtYLCK+Kqcr247YCQd4
         W5G5dYK53u9OA7cpGufMFnmv4M7qzzVFRO7/6LINEkOsNCmBUqh9smxEMBO48RxQq1Tk
         yZgPKY1Z4HvK49ng2tcn9b7O7zElNqu+6yJfogT6HEB+Dvc1Mt17RnP0RX2rsGY3fTKy
         XzWC9z8Ic7Mwz2IfaEwzyKg2cWr+MtMM4Nl82ui5+Qbt+zM11VqEKOQ2kHzxE51OjYlf
         Nr6iuQfMfjAYxOzCSfjOs+fwlIKyDqpbYE+ByZSBEyKKqek9Xg0j0s5ESknTx0ToisH+
         BhBg==
X-Forwarded-Encrypted: i=1; AJvYcCXojtG0o/9FlOcdoA26Sw1ZXYN0hLpfeQkCzLO5mRG84v5XshBN/yYLA2xUj0L2uGrnt7wMKNaq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KzBZR5kxR5mNLOOPIQYtbn5qSgB0V09wlj++wbKz6I9wlXjw
	45+7QfyDE6aGDBlbZTG37r3iSUoxiif/wJElFbY83hY7I0oV277bcwCF4ipHLA==
X-Google-Smtp-Source: AGHT+IFM1AXJ051IzPPqsl49dRXV3EAPdU7MADRa2Tisd07EWLACnR0AfN41J2K91Abg++8l1F9PzA==
X-Received: by 2002:a05:6870:610c:b0:27b:6267:61b0 with SMTP id 586e51a60fabf-27c3f603118mr3165118fac.32.1726174787877;
        Thu, 12 Sep 2024 13:59:47 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba3f3f125sm3276542fac.25.2024.09.12.13.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:59:47 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:59:42 -0700
From: Justin Stitt <justinstitt@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	alx@kernel.org, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH v8 2/8] auditsc: Replace memcpy() with strscpy()
Message-ID: <u42f2oneitzqmzh2tvwokzjxawj6utitu7rongurqeiglkvkvc@ryjktmvutysi>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-3-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-3-laoar.shao@gmail.com>

Hi,

On Wed, Aug 28, 2024 at 11:03:15AM GMT, Yafang Shao wrote:
> Using strscpy() to read the task comm ensures that the name is
> always NUL-terminated, regardless of the source string. This approach also
> facilitates future extensions to the task comm.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> ---
>  kernel/auditsc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6f0d6fb6523f..e4ef5e57dde9 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
>  	security_task_getsecid_obj(t, &context->target_sid);
> -	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
> +	strscpy(context->target_comm, t->comm);
>  }
>  
>  /**
> @@ -2757,7 +2757,7 @@ int audit_signal_info_syscall(struct task_struct *t)
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
>  		security_task_getsecid_obj(t, &ctx->target_sid);
> -		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
> +		strscpy(ctx->target_comm, t->comm);
>  		return 0;
>  	}
>  
> @@ -2778,7 +2778,7 @@ int audit_signal_info_syscall(struct task_struct *t)
>  	axp->target_uid[axp->pid_count] = t_uid;
>  	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
>  	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
> -	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
> +	strscpy(axp->target_comm[axp->pid_count], t->comm);
>  	axp->pid_count++;
>  
>  	return 0;
> -- 
> 2.43.5
> 

Good usage of two-argument strscpy(). This helps towards [1].

Reviewed-by: Justin Stitt <justinstitt@google.com>

[1]: https://github.com/KSPP/linux/issues/90

Thanks
Justin
