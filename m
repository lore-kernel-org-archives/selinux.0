Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8517BA6
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948557; cv=none; b=d2c+EraNDgl5Acums+5q+7h93BE+RL7kyg5JIJmvWIx4pxlb4LXAyrbW7ya+y1nlg9vBrjdhvOttFLuW/DhcyKfvN1IFzLGUHWrV+V1TMWN2bD6Q/hHK5C0jg+Q4CXRrFKCse2fod/GKH/W4ThFbZizjqcrO2TOTk5W+gJsMKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948557; c=relaxed/simple;
	bh=Fs9Fa/gk3E1diXXRu3QxyoMYbwZ2mCZhrhR0fsw1i0A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=m+TNCMYKCh03G/brUcUFMl8sfKa0JAYrd88j/8eSzte4I4yPWBgznk/H+++8Brdl5mxnZCJcnpZYKNYTzp7srVYN9lcDtWN3Y7dMNJx04seP7hL+0t82qPwCbXakY+r+0ehGSW5qoUdrYocTCzuuGY3uT/QiAWYiU6XOEu2d7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L0Ol/SnS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L0Ol/SnS"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d4f78fc9f6so520666285a.3
        for <selinux@vger.kernel.org>; Mon, 04 May 2026 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777948555; x=1778553355; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eh7QGTg8/z3zgLRDZ90j82+k6ZI5Ws+jR5EE+hhzvXc=;
        b=L0Ol/SnSmbq7wIrsmkluP8fxLb/mw8UeQUPrD75PFYVhJUmOrRH9NCfVlpA+PSP03s
         f9trZV6SOPZSwfW8Mf7sFzvPZPIh1pfPDTHAljIaKKtIjjqCA50pA6thuU7qN6KABMu2
         5FNAr1SGVRh0C4rQLAUcIuqiE8GRURo1XOIh5xE+G+SfxCGx3cObuGlbqpVVpzfcon/M
         FKWOKerrdlyFN7l3biWbd5bJgmhWApRnLHw529iYzIDbBIDY+eOa4sc6k6+JrVEl2l0m
         I82GHbKix1sy07SQS4R0bQGvPR+xtF4g9b0i9tgHRA+byhjknDXJqHGuCvYFZ5r70WQT
         sdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777948555; x=1778553355;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh7QGTg8/z3zgLRDZ90j82+k6ZI5Ws+jR5EE+hhzvXc=;
        b=BExR+7ZydSI75urcjJE1GDW6eKs65fU6CP6nx1j2o5y3vrwVl76UyjO0oUr2yAvhsv
         QK1ZEVUItGNBh2MRbeTVKC3xNA18qllJFueN8eaJqPUC+vT11q1F4q7NdPW9dFcHKSon
         HUwWmxl8tdQchKH761VUL958AZyK0g6oYIqa4v13+6eZcQ9reWxDuRJNi6q2s6mvS8rO
         zbeOXAHa3DHIgY3PnLnuiFxpT8cc+mQKkIGGeV2Ym3/9jZToxcMnEB1gdFMi1l/vwc7K
         LIZjjuSY/QuZYiYVT//LxIjSh6x63hQPq3+JOZX28HOBRVu2ETNFLUvl3MHBMjVwCGzi
         Ez8A==
X-Forwarded-Encrypted: i=1; AFNElJ83q9aO0VJd0duIiCpehVJ6k/LA/ptB7cYxTeGZMf9QCS0zJSQ0q89uviiVYeGuJL6hugKQE8gp@vger.kernel.org
X-Gm-Message-State: AOJu0YzjN1wv7Dq1JNI/9D8N7hV8b8LUo3k2/w31/ObgS4C0xKtmG2ut
	J3KJhk291a9OEUa63OAiGQKcHs4wgnOkn9UthFZV2ugLd8lVZCra1sB0sjy/peQI9grTStsPL4Z
	oHiM=
X-Gm-Gg: AeBDiesDYEzxx6D/+Glj9RCrd/CqkgWyb4vBnXTpxitZRnWnvq6n1e4rOUz8cY+GIar
	UAd5JH7gVGu/6S8mYjC/RvayBDD2FPbwDMHdqKun/k3dhEcveW1QbynzeTn9bdtQ2LcF2KOVcVy
	jR7MzwRbJSrDodp8uylOYGlrylXiQ3j8F+uIL9iuFJumLy0xFwWuTRcRF2IBg9RQqyTH8vGAdWu
	MRjVyRyR2JWn62MHdBueTxiY/2hjahGkn+RtUFoHAEI32sdkENA7PJq8Nku8MBg6TJpelNyNVsG
	Nsv36hzjA8E+gYHXBjZpBKYc/1SgngAk9/+rQ4FXbDqLfXq7jlG8aKP9WZZc+R1TvWIaiiLEPkO
	02sNwhdSUWMuuIybtDuVtns3bslqSKsKYqUcoXE/c7BLHTT54F4Qderp1BliFJUcUjFyz/M42gs
	C5h3qw+SVBX+fBQWLGOzQDn9KpqTENSDZddYzxWBUHkYG6E2peWTEmgAhLXIbKaImjB9yfmSa6E
	repBbE=
X-Received: by 2002:a05:620a:25c6:b0:8fb:1acb:ccde with SMTP id af79cd13be357-902e4c7cf7cmr254135585a.37.1777948555042;
        Mon, 04 May 2026 19:35:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938d20fsm1240458785a.1.2026.05.04.19.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 19:35:54 -0700 (PDT)
Date: Mon, 04 May 2026 22:35:53 -0400
Message-ID: <7fdab4e591c35b481996ffd3761d5428@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260504_2038/pstg-lib:20260504_1547/pstg-pwork:20260504_2038
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnace@redhat.com, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: prune /sys/fs/selinux/checkreqprot
References: <20260429211229.3750-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260429211229.3750-2-stephen.smalley.work@gmail.com>

On Apr 29, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> commit a7e4676e8e2cb ("selinux: remove the 'checkreqprot'
> functionality") removed the ability to modify the checkreqprot setting
> but left everything except the updating of the checkreqprot value
> intact. Aside from unnecessary processing, this could produce a local
> DoS from log spam and incorrectly calls selinux_ima_measure_state() on
> each write even though no state has changed. Prune it to just return
> count (i.e. all bytes written successfully) so that userspace never
> breaks.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/selinuxfs.c | 45 ++++--------------------------------
>  1 file changed, 5 insertions(+), 40 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 8c107af5140e..71ffa64b15a6 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -689,46 +689,11 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
>  static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>  				      size_t count, loff_t *ppos)
>  {
> -	char *page;
> -	ssize_t length;
> -	unsigned int new_value;
> -
> -	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
> -			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
> -			      NULL);
> -	if (length)
> -		return length;
> -
> -	if (count >= PAGE_SIZE)
> -		return -ENOMEM;
> -
> -	/* No partial writes. */
> -	if (*ppos != 0)
> -		return -EINVAL;
> -
> -	page = memdup_user_nul(buf, count);
> -	if (IS_ERR(page))
> -		return PTR_ERR(page);
> -
> -	if (sscanf(page, "%u", &new_value) != 1) {
> -		length = -EINVAL;
> -		goto out;
> -	}
> -	length = count;
> -
> -	if (new_value) {
> -		char comm[sizeof(current->comm)];
> -
> -		strscpy(comm, current->comm);
> -		pr_err("SELinux: %s (%d) set checkreqprot to 1. This is no longer supported.\n",
> -		       comm, current->pid);
> -	}

I agree with Ondrej's comment that the log spam problem could be resolved
with pr_err_once() while still preserving the notification.  Since it will
only be reported once, you can probably skip the read/parsing/etc. and
just report that checkreqprot is no longer supported:

  static ssize_t swl_write_checkreqprot(...)
  {
    /*
     * Setting ... <deprecation url>
     */
    pr_err_once(...);
    return count;
  }

> -	selinux_ima_measure_state();
> -
> -out:
> -	kfree(page);
> -	return length;
> +	/*
> +	 * Setting checkreqprot is no longer supported, see
> +	 * https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot
> +	 */
> +	return count;
>  }
>  static const struct file_operations sel_checkreqprot_ops = {
>  	.read		= sel_read_checkreqprot,
> -- 
> 2.54.0

--
paul-moore.com
