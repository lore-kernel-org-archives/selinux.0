Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DCB1DFF8;
	Sun, 16 Mar 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742132303; cv=none; b=La9KlDGu9p4Ip1NpZi0qSBzcM/Q0OXhfB/Le1w+dWA/Ysjcv9NyzwZSOXbiT19nrHdUFUQDUqGS8uZhtpMtEtU7OhpzkihHZL5nj5/uaU5dbSeS4fI6EczoqkK+dCJ/2RcK7KNH78rWyiGhD5G+pdsuLOR1qU2WfsmYLbosvKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742132303; c=relaxed/simple;
	bh=cD/MUYKo+nkfjChKS+hZUIC9o+gMpql+CqyRcsBaPkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKvAuf0C9SgzBnwu4RT5eFmuhPX6deVmTvAmMFTjaE0dXoOH5I/BAXTvgY6JVMw39YogdGfb4yYLEDUqMknCU6bPnI7LhPbAYBDJUeWQIhX1w0GuQo9F30qZAAmZ+MpJBT6ZIZNUX3P0wzhgSijluBOzYmSgN4G+OeHs7gy7Wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Uo/gdvum; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Uo/gdvum"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ff4faf858cso12715937b3.2;
        Sun, 16 Mar 2025 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742132300; x=1742737100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W20b2Jn5U/X/Wgd5KSlyToeOXghhFnrA40a9Zj/VnpI=;
        b=Uo/gdvumLAhwsIpKvPryUMkqSTw75LMbYa8x1RDAE6YT0gyAC20aHbFS8kFn/KmtXJ
         PZCxko3YhG/cPbCAoi6EtibbYGjCMWWY/CPDzDcIe+62tsF3gLxlEze/hnTd0mY7Byd6
         a1asUQn6EM8q5AghDZ9Xp4ym9w+WbZYzU2RVTttPIR2I+D6JpRWBLnORzijLhVZtHkzv
         1U7Wr0kTFpx79IIJbB5zkT8QyQfih7yw5BkGOlK99DsBKH91pjXdeXVLkAoDAV7hll3S
         9sK3C/Q48DwkBK0YFSS1fwOpEQzDFI8YeGOaktw27Zjhgl3TaD1rLjZNm/t4cvbTOMCz
         jx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742132300; x=1742737100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W20b2Jn5U/X/Wgd5KSlyToeOXghhFnrA40a9Zj/VnpI=;
        b=dROE0L6zyubw6ynw/SYspEMDkSfsPugd0R9g8NLYrsALIGElF+BE0Pnbd95EL+QsIW
         ZZOgjBV4zsChN6zMUJJ+oSGld+KS/OU4yc4Ixs1qDNOEcnOvt4Qe2Fwz9otL5dPeNuWQ
         Q4UPZxgJS40heOlhn84OSJJnbIObEamnRH5QzZYIxkpO7Oq3WbtyGgRS8xn8XNPRZGX4
         QuxxywtO6r9af7bxs45rvk9Tb4G9OqG8kQOQNzcqlKcAwHQK0wz0DmrmtbudySv5KMmq
         /7Wn/Tv5fn05zaHSz7GNTKHQNMXUfx/8hQUTNy+OIZBz+IjuDNxMg7csInLtL1gOEBZb
         zRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA6E82/sU+IkVY+uxmPXyG8N4QfVDd9A+vAxTRffvr56moq5A/F2wkh29GuIOqoozOI4876yD88MT5lGM=@vger.kernel.org, AJvYcCWA2r7aiLGi0x7p5xNYdnnWWona2TgR1n+GB4/rH2MJ4x+6L4Bagznde4Z5AWfzRP/7T0lbfjm3Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsF/n/+W0njehFpZYlo7gB728eTQRgqLfEs2MVcx/lXtVdp35
	PaUman5KFZEiPVutNImSzAa1pS2KmCJMGScSLmEu29Uj292py8Fzg/9oKLUUjGvYObmVZVWhs/k
	XK8nhHIcXv3eqptdFmZTEbDugqWTyit8V9MA=
X-Gm-Gg: ASbGncthXpFBZfHBcydn8ywrC1d0V+Gmwott5vo6s5L7fXMUFfGJwxUnUvBYAgz63E8
	YbRAefidVAiH/uNxF6eMRnuiyjLaoaiGMyHCjkACU9dithDAnvH4cVEIZjeO91oQSEC/QjZeKzj
	2n+zfiZkKEh4KBKsv/NpOZYbyBZs8HrghIkZWR
X-Google-Smtp-Source: AGHT+IFfzRFS2Ow1XYtDZDeAnwvNabEogKNsbdvqjn6ta4vDOy7z8+baBWJecwjpgg4LKcjYKWcoWsqlRBBByYsmw7A=
X-Received: by 2002:a05:690c:6f04:b0:6fd:4521:f9d7 with SMTP id
 00721157ae682-6ff45ff5be5mr110610097b3.24.1742132299976; Sun, 16 Mar 2025
 06:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315141136817waFGT5DFhPs9QMwybNwb5@zte.com.cn>
In-Reply-To: <20250315141136817waFGT5DFhPs9QMwybNwb5@zte.com.cn>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sun, 16 Mar 2025 14:38:09 +0100
X-Gm-Features: AQ5f1Joz-UfQG0y_YMiJxmrQ7GmwIv9lHE9Ov9j-GFiZ3izo0wL6FeN0sHLXKUY
Message-ID: <CAJ2a_Df3QmeteqHVJ3hp7X-t3UsBNwgzu-utfTq1rDMJdwEz0A@mail.gmail.com>
Subject: Re: [PATCH linux-next] selinux: use sysfs_emit() instead of scnprintf()
To: xie.ludan@zte.com.cn
Cc: stephen.smalley.work@gmail.com, paul@paul-moore.com, omosnace@redhat.com, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Mar 2025 at 07:11, <xie.ludan@zte.com.cn> wrote:
>
> From: XieLudan <xie.ludan@zte.com.cn>
>
>
> Follow the advice in Documentation/filesystems/sysfs.rst:
>
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
>
> the value to be returned to user space.
>
>
> Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
>
> ---
>
>  security/selinux/selinuxfs.c | 20 ++++++++++----------
>
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>
> index 47480eb2189b..17c56fc87d98 100644
>
> --- a/security/selinux/selinuxfs.c
>
> +++ b/security/selinux/selinuxfs.c
>
> @@ -126,7 +126,7 @@ static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
>
>   char tmpbuf[TMPBUFLEN];
>
>   ssize_t length;
>
>
>
> - length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
>
> + length = sysfs_emit(tmpbuf, "%d",

That would be dangerous since the target buffer is of size TMPBUFLEN
(12) and not PAGE_SIZE (4096).

>      enforcing_enabled());
>
>   return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>
>  }
>
> @@ -206,7 +206,7 @@ static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
>
>   security_get_reject_unknown() :
>
>   !security_get_allow_unknown();
>
>
>
> - length = scnprintf(tmpbuf, TMPBUFLEN, "%d", handle_unknown);
>
> + length = sysfs_emit(tmpbuf, "%d", handle_unknown);
>
>   return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>
>  }
>
>
>
> @@ -314,7 +314,7 @@ static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
>
>   char tmpbuf[TMPBUFLEN];
>
>   ssize_t length;
>
>
>
> - length = scnprintf(tmpbuf, TMPBUFLEN, "%u", POLICYDB_VERSION_MAX);
>
> + length = sysfs_emit(tmpbuf, "%u", POLICYDB_VERSION_MAX);
>
>   return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>
>  }
>
>
>
> @@ -345,7 +345,7 @@ static ssize_t sel_read_mls(struct file *filp, char __user *buf,
>
>   char tmpbuf[TMPBUFLEN];
>
>   ssize_t length;
>
>
>
> - length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
>
> + length = sysfs_emit(tmpbuf, "%d",
>
>      security_mls_enabled());
>
>   return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>
>  }
>
> @@ -670,7 +670,7 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
>
>   char tmpbuf[TMPBUFLEN];
>
>   ssize_t length;
>
>
>
> - length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
>
> + length = sysfs_emit(tmpbuf, "%u",
>
>      checkreqprot_get());
>
>   return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>
>  }
>
> @@ -1226,7 +1226,7 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
>
>   ret = cur_enforcing;
>
>   goto out_unlock;
>
>   }
>
> - length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
>
> + length = sysfs_emit(page, "%d %d", cur_enforcing,
>
>     fsi->bool_pending_values[index]);
>
>   mutex_unlock(&selinux_state.policy_mutex);
>
>   ret = simple_read_from_buffer(buf, count, ppos, page, length);
>
> @@ -1416,7 +1416,7 @@ static ssize_t sel_read_avc_cache_threshold(struct file *filp, char __user *buf,
>
>   char tmpbuf[TMPBUFLEN];
>
>   ssize_t length;
>
>
>
> - length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
>
> + length = sysfs_emit(tmpbuf, "%u",
>
>      avc_get_cache_threshold());
>
>   return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>
>  }
>
> @@ -1726,7 +1726,7 @@ static ssize_t sel_read_class(struct file *file, char __user *buf,
>
>  {
>
>   unsigned long ino = file_inode(file)->i_ino;
>
>   char res[TMPBUFLEN];
>
> - ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_class(ino));
>
> + ssize_t len = sysfs_emit(res, "%d", sel_ino_to_class(ino));
>
>   return simple_read_from_buffer(buf, count, ppos, res, len);
>
>  }
>
>
>
> @@ -1740,7 +1740,7 @@ static ssize_t sel_read_perm(struct file *file, char __user *buf,
>
>  {
>
>   unsigned long ino = file_inode(file)->i_ino;
>
>   char res[TMPBUFLEN];
>
> - ssize_t len = scnprintf(res, sizeof(res), "%d", sel_ino_to_perm(ino));
>
> + ssize_t len = sysfs_emit(res, "%d", sel_ino_to_perm(ino));
>
>   return simple_read_from_buffer(buf, count, ppos, res, len);
>
>  }
>
>
>
> @@ -1758,7 +1758,7 @@ static ssize_t sel_read_policycap(struct file *file, char __user *buf,
>
>   unsigned long i_ino = file_inode(file)->i_ino;
>
>
>
>   value = security_policycap_supported(i_ino & SEL_INO_MASK);
>
> - length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
>
> + length = sysfs_emit(tmpbuf, "%d", value);
>
>
>
>   return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
>
>  }
>
> --
>
> 2.25.1
>
>
>
>
