Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D292EAD14
	for <selinux@vger.kernel.org>; Wed,  3 Sep 2025 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934786; cv=none; b=WWda8fd3TqoQTHPpL9cqC9Og0ZHjIQSCSRbPHnI+L+JswEF0iZlBaLoE+0TEluKzFA5UqHb/NA1UIwO1ad7G3h5T63yh2U27e3LmKSrvTo2+wv08MNC0Pdw+xre+dSI1P6pvp5YqOg34P3XqpGkBMqTNor9f38HDSef3M4T9cE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934786; c=relaxed/simple;
	bh=M33kH1V3bhnMJw3m4nRTDU3lB0zxC4Qc4fFgF5IA4WY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ojfH/ZF5jc4X6YTcM+iPJROKuzEEeF6xWXP4JOFYv76HCiQS7fD0hH6eWgHJgmjTz4Egm1I0gYnM8BK/dAQ7sNAAaZ8DYCv8lR+fD+L717YfZgAxZtS1RtKuRTb3QUq/4dIVoU+U62XLfa2SM1Vd2fv7IoovTV5hu907CNMJs6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AJ5QMHyv; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AJ5QMHyv"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70fa0e37bc5so1954586d6.0
        for <selinux@vger.kernel.org>; Wed, 03 Sep 2025 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756934783; x=1757539583; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKAFUEHK8OBYchmycuUbisd/bzFy1QHMzYkOvBvFOpA=;
        b=AJ5QMHyvKING3BjPluB3ye0NMQAKeruFPXa6w2AHY1AyPZz4nZqoS2i/Hre48Tz3sf
         al3j3k9PQlmnXKJn1XcFr4YVG47PczuSbk/YIlrLgokKqHBF9c6xkaSU+ChUsDYys0TX
         EH/fiOWXvdbb4EnqeYmHfcoemFb7LhINf4LeR65gs5x3qcErdkEfpCeSo33ZVqHugGOD
         BrWRY9mW1zqPxCh+T96a7ohNvcDUm9aYcuyGAjeJeQY7fMRUp4Vrat6RAS7TmzJzOeZk
         8SD8qMCyvbJkLPZeVl5bXwk2hMa0AnFICIqc9s/1/teFwZWwlAYtYVpg8/nu4INQx/cu
         nFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756934783; x=1757539583;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKAFUEHK8OBYchmycuUbisd/bzFy1QHMzYkOvBvFOpA=;
        b=YGPArFZFqW2HdYef/cHQ60Fh3w5CNamlIaaE6gnKI8K/ZpIOZSndyemjx6mq3t/tcV
         ngdTqWo+RpfQggR5XXRtMEoZNXdrt5aOkk0PZCu4ukRIq7LdO/8D/r/uZzMBIMEYnP7q
         96XEug7FXe2fa/2jgcQ4ivtT5lkcgpUpRtYEQZvKhkQLhX2lSE6HiLe2s+cW/3AY/cO+
         aOEJWsqVPU5Sb5t7gZcxun6e1nU4iQxpMWGjPCGXTn3h40Qd9cvZ1itFwDwoSm9gHgEe
         8akAXQWQP2y/esKgnRIDjKEqqBrmQPCPihq5ZtZdu1GVFjH977G3m5RvXsT6t6w6UM+q
         pi0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTnOTOdc5YooqwYO2bp0QCG1UFPP+/DiiBEvwCqWiUWJLUPkJt6TMfspT1FVzQNIvT6bHfGUg8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WwfjhYDYhUE3BLM8rdq7BBO9xvdgHmenhIScJJKkG7badhKF
	ZvdwpIEwHVvz6mlEuAp/FUkd47DsiDPmPMH9/JZaTlgfveyqsCqpgXajvFUOlYwPFA==
X-Gm-Gg: ASbGncuuqIrnC+ZpUJza7sru99NrYzNeWxWso4IvZX/p9cH2AinaYTPL3mdPAYaqAPL
	+AEfpbG1fvGjKB1pmUX38W7sVq63XGJZ82qIfF3hhErHs3qcZ7DgPzbH/dj7jsJbfgcDhtFs+6i
	+KvQTqK7lmCxwS3RU4Cvfdq5JLFVn09lNGZkUArcBaY4K7PYmyGX9+gOAlvVE70Snyt01LqqVku
	u2/w2aoy7I8Rr0BC04AdWRzYXwDoOthm2E8KusLAGuSkWnoihlAkIuUeUdAvRcPHDILF7h7F/5e
	D65RvCSAVTGDmKdMcAyAQNYscB13Q/80sM6GX/BGaslOZ/TUDqD6FZNdWubI01vyNB0Mn9x8XDC
	OC4jAQ8QU6uLx0HkhFv++2Xu2OTM7V5OvKkrrQUx+ZOSJ+TESGId47rYYNu2b1PyZiaCr/Lee3f
	iAMkw=
X-Google-Smtp-Source: AGHT+IGjeGVBk59qanrKojqKe1+ebv5QbBLUr+xq2vrJdB1gpx6C81S9JV5wN46o/dcj2HWmCycKCg==
X-Received: by 2002:a05:6214:c65:b0:71d:478f:e0cd with SMTP id 6a1803df08f44-71d478fe49fmr118773496d6.26.1756934782933;
        Wed, 03 Sep 2025 14:26:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-720b466614bsm34702456d6.38.2025.09.03.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:26:21 -0700 (PDT)
Date: Wed, 03 Sep 2025 17:26:21 -0400
Message-ID: <6afc91a9f5caef96b2ca335b6d143670@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250903_1645/pstg-lib:20250903_1606/pstg-pwork:20250903_1645
From: Paul Moore <paul@paul-moore.com>
To: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, James Morris <jmorris@namei.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Hugh Dickins <hughd@google.com>, Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
References: <20250826031824.1227551-1-tweek@google.com>
In-Reply-To: <20250826031824.1227551-1-tweek@google.com>

On Aug 25, 2025 "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com> wrote:
> 
> Prior to this change, no security hooks were called at the creation of a
> memfd file. It means that, for SELinux as an example, it will receive
> the default type of the filesystem that backs the in-memory inode. In
> most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> be hugetlbfs. Both can be considered implementation details of memfd.
> 
> It also means that it is not possible to differentiate between a file
> coming from memfd_create and a file coming from a standard tmpfs mount
> point.
> 
> Additionally, no permission is validated at creation, which differs from
> the similar memfd_secret syscall.
> 
> Call security_inode_init_security_anon during creation. This ensures
> that the file is setup similarly to other anonymous inodes. On SELinux,
> it means that the file will receive the security context of its task.
> 
> The ability to limit fexecve on memfd has been of interest to avoid
> potential pitfalls where /proc/self/exe or similar would be executed
> [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> similarly to the file class. These access vectors may not make sense for
> the existing "anon_inode" class. Therefore, define and assign a new
> class "memfd_file" to support such access vectors.
> 
> Guard these changes behind a new policy capability named "memfd_class".
> 
> [1] https://crbug.com/1305267
> [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.com/
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changes since RFC:
> - Remove enum argument, simply compare the anon inode name
> - Introduce a policy capability for compatility
> - Add validation of class in selinux_bprm_creds_for_exec
> 
>  include/linux/memfd.h                      |  2 ++
>  mm/memfd.c                                 | 14 +++++++++--
>  security/selinux/hooks.c                   | 27 ++++++++++++++++++----
>  security/selinux/include/classmap.h        |  2 ++
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/include/security.h        |  5 ++++
>  7 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
> index 6f606d9573c3..cc74de3dbcfe 100644
> --- a/include/linux/memfd.h
> +++ b/include/linux/memfd.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/file.h>
>  
> +#define MEMFD_ANON_NAME "[memfd]"
> +
>  #ifdef CONFIG_MEMFD_CREATE
>  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
>  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
> diff --git a/mm/memfd.c b/mm/memfd.c
> index bbe679895ef6..63b439eb402a 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -433,6 +433,8 @@ static struct file *alloc_file(const char *name, unsigned int flags)
>  {
>  	unsigned int *file_seals;
>  	struct file *file;
> +	struct inode *inode;
> +	int err = 0;
>  
>  	if (flags & MFD_HUGETLB) {
>  		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
> @@ -444,12 +446,20 @@ static struct file *alloc_file(const char *name, unsigned int flags)
>  	}
>  	if (IS_ERR(file))
>  		return file;
> +
> +	inode = file_inode(file);
> +	err = security_inode_init_security_anon(inode,
> +			&QSTR(MEMFD_ANON_NAME), NULL);
> +	if (err) {
> +		fput(file);
> +		file = ERR_PTR(err);
> +		return file;
> +	}
> +
>  	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>  	file->f_flags |= O_LARGEFILE;
>  
>  	if (flags & MFD_NOEXEC_SEAL) {
> -		struct inode *inode = file_inode(file);
> -
>  		inode->i_mode &= ~0111;
>  		file_seals = memfd_file_seals_ptr(file);
>  		if (file_seals) {

Hugh, Baolin, and shmem/mm folks, are you okay with the changes above? If
so it would be nice to get an ACK from one of you.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874bf7d..429b2269b35a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -93,6 +93,7 @@
>  #include <linux/fanotify.h>
>  #include <linux/io_uring/cmd.h>
>  #include <uapi/linux/lsm.h>
> +#include <linux/memfd.h>
>  
>  #include "avc.h"
>  #include "objsec.h"
> @@ -2366,9 +2367,12 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
>  	ad.type = LSM_AUDIT_DATA_FILE;
>  	ad.u.file = bprm->file;
>  
> +	if (isec->sclass != SECCLASS_FILE && isec->sclass != SECCLASS_MEMFD_FILE)
> +		return -EPERM;

In the interest of failing fast, this should probably be moved up in the
function to just after where @isec is set.  There are also a number of
checks that happen prior to this placement, but after the isec assignment.
While I don't think any of those checks should be an issue, I'd rather
not to have to worry about those and just fail the non-FILE/MEMFD_FILE
case as soon as we can in selinux_bprm_creds_for_exec().

>  	if (new_tsec->sid == old_tsec->sid) {
> -		rc = avc_has_perm(old_tsec->sid, isec->sid,
> -				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
> +		rc = avc_has_perm(old_tsec->sid, isec->sid, isec->sclass,
> +				  FILE__EXECUTE_NO_TRANS, &ad);
>  		if (rc)
>  			return rc;
>  	} else {
> @@ -2378,8 +2382,8 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
>  		if (rc)
>  			return rc;
>  
> -		rc = avc_has_perm(new_tsec->sid, isec->sid,
> -				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
> +		rc = avc_has_perm(new_tsec->sid, isec->sid, isec->sclass,
> +				  FILE__ENTRYPOINT, &ad);
>  		if (rc)
>  			return rc;
>  
> @@ -2974,10 +2978,18 @@ static int selinux_inode_init_security_anon(struct inode *inode,
>  	struct common_audit_data ad;
>  	struct inode_security_struct *isec;
>  	int rc;
> +	bool is_memfd = false;
>  
>  	if (unlikely(!selinux_initialized()))
>  		return 0;
>  
> +	if (name != NULL && name->name != NULL &&
> +	    !strcmp(name->name, MEMFD_ANON_NAME)) {
> +		if (!selinux_policycap_memfd_class())
> +			return 0;
> +		is_memfd = true;
> +	}
> +
>  	isec = selinux_inode(inode);
>  
>  	/*
> @@ -2996,6 +3008,13 @@ static int selinux_inode_init_security_anon(struct inode *inode,
>  
>  		isec->sclass = context_isec->sclass;
>  		isec->sid = context_isec->sid;
> +	} else if (is_memfd) {
> +		isec->sclass = SECCLASS_MEMFD_FILE;
> +		rc = security_transition_sid(
> +			sid, sid,
> +			isec->sclass, name, &isec->sid);
> +		if (rc)
> +			return rc;
>  	} else {
>  		isec->sclass = SECCLASS_ANON_INODE;
>  		rc = security_transition_sid(

We're duplicating the security_transition_sid() call which seems less
than ideal, how about something like this?

  if (context_inode) {
    /* ... existing stuff ... */
  } else {
    if (is_memfd)
      isec->sclass = SECCLASS_MEMFD_FILE;
    else
      isec->sclass = SECCLASS_ANON_INODE;
    rc = security_transition_sid(...);
    if (rc)
      return rc;
  }

--
paul-moore.com
