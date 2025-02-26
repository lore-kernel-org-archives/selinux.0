Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C982144AF
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587263; cv=none; b=Ms/JZMs8B9xXekHnCm39Vtfek4y5KNxEhTru/MP84gb4778RdNUrJgZV77hYgvRVzLNVhiDjC5EBhEkKzp0cCHJHoLz+bFVugPcUBBBz6kCtQ/TGEuY1QBdqZVsK2mcxY1VM27YbymaSXcdTbnNF4LrMdVX5CTGVkYnZIIC2i6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587263; c=relaxed/simple;
	bh=jdsDLDnbLi+jDvV8tDl4S6b6ysi6r8hSdf4p+BBfZ6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjmWzlzW2l+vPn9wF4l7eZ2pXP8PujbUcyshLwP8Oh1RbKDbsdeyIayBM5OLhJSpi6ZIhWg3I+ccSXI5P1ng4diUKlEYkadPdsCe8R64iPDQEyfb9eyUrPgH/qY1SOLnLargbaUuaDe+YLwVaxbZFQdOtlv9KqnlwzqzwiZJ/sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com; spf=none smtp.mailfrom=perfinion.com; dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b=jCXrDWHv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perfinion.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=perfinion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20230601.gappssmtp.com header.i=@perfinion-com.20230601.gappssmtp.com header.b="jCXrDWHv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c665ef4cso124395055ad.3
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20230601.gappssmtp.com; s=20230601; t=1740587257; x=1741192057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GU9ns2nI2AiJccw5i3Ov5a/FFLlrbEd4LvJEfzdWgS4=;
        b=jCXrDWHvpRjy48qJZSsBcLFsktXGuqH841asXzGf5GpI0n0Idp0Z5yeMA/V4pSl8cf
         /otK1iqcDZnQT3jBlCroXzHD9atLOMRKuBxxBs61yd72ytK06FsoWefc5lP+DAr9j7jW
         HmiS6VQlfMOC9THB5MUjXRVjgaEnhM3JUF30+YgfUzCZMnvevJGzGwHOB3qjIoW0rrF/
         hMTU/blPhh6dJiN0nSTlbs5rQTOGKIDxIqvLtkRC+C2T1PMQVhLjt51F6SRgrQ+YhgTu
         mgssARltLpWc4UFRJC4tKCw7f4vuAZCE+b5bNNqYwifugW5sLjh1MzilPXI/VnxpUnqu
         EjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740587257; x=1741192057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU9ns2nI2AiJccw5i3Ov5a/FFLlrbEd4LvJEfzdWgS4=;
        b=EeXPgicHV+HRqTouxDb/VD2TlqkjOJHz7pHtANpPnN/JdBP5MRWVUx8oOKwoJc4hCK
         1hKwLWJo4iB9Ftya5NDqCxyPhnWu9QS57vNHyJbVVvkMzfmerT5RIRuyBUv0laRVQ50I
         okLWWNQbPKpW8vv0cI4RqVurR3h6M9ZOKbZEA8x8HyhEBxYS1MYps1Q36Xr0x+t+iYUl
         YguBaJbb8Aah/l7HCZ2d5XprADjLd1NcxqYiBB2DMwKUdmU0zrTKCfOtUG3akThKLfqc
         +T7t1ecr6yyXhysT/rnGY5OT0c42yj0wNICrQiygju0HJrucYEWPyXaqwUPHM8MdO6qP
         bDNw==
X-Gm-Message-State: AOJu0YzCcIcU5ESucrkOr52X8NJ1puUMp8wNmB8DU/Xz55J7R1AEDB90
	phc5vjjZoP+GX91QL1fexrx/webhcVklrNLecBAs681j6KxxePgYLNZFMNddQc+itb7Rd64Kbqd
	+
X-Gm-Gg: ASbGncsQq+ZE59NEjZDg5AqcHNludbvo6cZxPoLTifJLo+jQqyR2nyBPWx+Fh0+3ABb
	+WB3pIojlFWo08zuRJiy9tJpARrDIkIOHKz4HR4oSY1rPkR7O9kjh6gWcP2BhD4g7ekgcYQPWiK
	MzsQdc2VgpnRspnPVQdXzheiYfOzMasPQuR/Tt57WwLFzwt3ryeOxzf2ZpQfeeZ+wBqODoGNgD4
	Q+Bu132M4kJGVhhQMwCJH7Vq3bqUieuZ4Zf9aeKSxhh051Gk/45nS9d1XGKfFQK7CWofBFkFU6B
	nWvk5K/1yvwq8ai/4+uv7994gesUg5i3GmUkS1WTd7lUlnYmNQ/GXbaDBoBRDPodroHD4uI=
X-Google-Smtp-Source: AGHT+IH7lqYIzxKc6IlK3tImNLMjSxbdDNDb6Nnr7hHMaQhBvMl4OtTWXSPksxNvjP4tgcZBaWScvA==
X-Received: by 2002:a05:6a00:174c:b0:732:6231:f2a3 with SMTP id d2e1a72fcca58-73426c8d3a7mr37772983b3a.3.1740587257078;
        Wed, 26 Feb 2025 08:27:37 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a8375easm3695313b3a.163.2025.02.26.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:27:36 -0800 (PST)
Date: Wed, 26 Feb 2025 08:27:35 -0800
From: Jason Zaman <jason@perfinion.com>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] libsemanage: improve performance of semanage store
 rebuild
Message-ID: <Z79A97uBFd_6RTFz@anduin.perfinion.com>
References: <20250225075555.16136-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225075555.16136-1-lautrbach@redhat.com>

On Tue, Feb 25, 2025 at 08:55:23AM +0100, Petr Lautrbach wrote:
> Commit 9d107ab77ba4 ("libsemanage: Set new restorecon handle before doing restorecon
> ") added reopeniong selabel handle every time semanage_setfiles() is
> called. It means that during `semodule -B`, `selabel_close()` and
> `selabel_open()` could be called more than 1800x what could have a
> significant performance impact.
> 
> It should be enough to reopen selabel handle just after semanage commit
> when changes are applied.
> 
> Before 9d107ab77ba4:
>     semodule -B  5.84s user 0.52s system 96% cpu 6.585 total
> 
> After 9d107ab77ba4:
>     semodule -B  11.15s user 0.64s system 98% cpu 11.952 total
> 
> With this patch:
>     semodule -B  5.51s user 0.41s system 98% cpu 6.014 total
> 
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
Acked-by: Jason Zaman <jason@perfinion.com>

> ---
>  libsemanage/src/semanage_store.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index cf9aa809b7f8..307f27f9838b 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1712,6 +1712,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>  	    semanage_path(SEMANAGE_PREVIOUS, SEMANAGE_TOPLEVEL);
>  	const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
>  	struct stat buf;
> +	struct selabel_handle *sehandle;
>  
>  	/* update the commit number */
>  	if ((commit_number = semanage_direct_get_serial(sh)) < 0) {
> @@ -1822,6 +1823,8 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>  
>        cleanup:
>  	semanage_release_active_lock(sh);
> +	sehandle = selinux_restorecon_default_handle();
> +	selinux_restorecon_set_sehandle(sehandle);
>  	return retval;
>  }
>  
> @@ -3012,14 +3015,10 @@ log_callback_mute(__attribute__((unused)) int type, __attribute__((unused)) cons
>  void semanage_setfiles(semanage_handle_t * sh, const char *path){
>  	struct stat sb;
>  	int fd;
> -	struct selabel_handle *sehandle;
>  
>  	union selinux_callback cb_orig = selinux_get_callback(SELINUX_CB_LOG);
>  	union selinux_callback cb = { .func_log = log_callback_mute };
>  
> -	sehandle = selinux_restorecon_default_handle();
> -	selinux_restorecon_set_sehandle(sehandle);
> -
>  	/* Mute all logs */
>  	selinux_set_callback(SELINUX_CB_LOG, cb);
>  
> -- 
> 2.48.1
> 
> 
