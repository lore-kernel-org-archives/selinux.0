Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3482221F27;
	Mon, 17 Mar 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215278; cv=none; b=pv0h62TE4MjJYRrS7hGjlwNXAB0QCq9kBrGK9wXu/h20dKUxxE7deV9bRzxZv5hwLD/0Bd92ayZEodrAJypsu6AskFT/1M4yCD7z375QHQDbDlpgThnjmxZ6w8+PeeDCPo2ZMuJsRk7nXaud5A2VOnDwieAjsWdof10fwjbjL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215278; c=relaxed/simple;
	bh=+dvxJm7c94XXe7gws2T+sV1TL7aK3f751i2byBlmSac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDZf+F7C1XaC/WStjpK+zjCRT8/78CqEI6O9Y+5iTYKdktQoYqkEmx3sPO7KAuhtzqZaq8z1SD1gqZ31UYY5dNg8WQGww515o2uBTOVoCZS5sCSx0zLhPEzjf9pfZlhdNYQeq+PkCczkfaCmXnzK163baP9VICrAIvpMVZnSZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBiN3q9N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBiN3q9N"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22435603572so65673925ad.1;
        Mon, 17 Mar 2025 05:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742215276; x=1742820076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKj9/0GKwnk0VVvo6X2TtZsAEzhKejrcmtIHIh8nwMw=;
        b=cBiN3q9NF4Ko7r2tDoLbk91sPO4gXjC51AfOMvxJ8KZqOQzAf9KnUDRO1ZL5BxXR4a
         MWaEAGcgLAQ9RPvs6AgxyB928A7j4wtDhIJrt4apmZ36J/FZgWqpSEJySfhugDteltSv
         Vss9syPLJGLlxfDmFwzlPPbNAyWiJQjfuVrvJfcEnLy6CgPazn4NvxL/Nhh6c4L8EuMD
         SAa37N2p+QQbM/chqIaxwSSpDVEcMvzROOrhIYmaIkgox/TLa/rJ3d6XanKPAHe9IemJ
         rBpA2GgM+SvE30XrnnuakJrZ0Sku+hYk8xnwCmMXZsPJYaDaqkEhGz6AlgZwVXEyesTG
         fZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742215276; x=1742820076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKj9/0GKwnk0VVvo6X2TtZsAEzhKejrcmtIHIh8nwMw=;
        b=s/z0gGmg0BW4Nw2U7tMwLnjsa066rB+oEt+YhcejH+sejIy7vRBlXOd0ut3Qex32B+
         6vAokyTmVtZpeC4iVMmzZJ9uOugyMpz2N6XZNgaqacDGa55vekIDchCy4hZk784mGxq4
         P2WjneBD2BYG8roN52BYnsX+i9uP2ALfpRTyYI8E4ycnPfFguZzEszKHzC+1yrfs2pPU
         ulJ3maJfBK71T4MnVRPKFb2HOMPYAHmr5mTWerRmt0CboPiVHWjUklmVAEUjlV8sq7TX
         Ve/2Lt/IbzAn19GJyOX/M413xDahjeoWW00u87u2VJDgo6+H/Ppj4iUiNgkWQwS1aMJr
         Wn6A==
X-Forwarded-Encrypted: i=1; AJvYcCWVOdUOBRXPDWDW8XNRG3KOz3eeBSKUyvh26GN5vb3vv1wsY5G3GY6lWrSQwQAENE/mWlOaN+6yy/xCh/s=@vger.kernel.org, AJvYcCXoy/B0ESo0jpPrP/bv2fXb63do8Bs9zsHf/dYvlwBkm8qthZTDkW05IhLh4D6GLwz9F3kzO1RYGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAowtR3feQsmXTiVB9yNDzOfBq/Mh8lF+YY4b7UPzkYwNuScp
	SClocoVvweNZkz3EF9wlvJI5P6+MHc/tNJWH40qnie6M30ZRMAqVAb/K4FoAqAT0NS4vdbEtZ66
	BOmMqj4RxZ9yqIYoeR85GZ5V26f0AIA==
X-Gm-Gg: ASbGncu9hFWwNyxZUAs1/hvPB6GYNnxyqYo5pUK8jrciSzstJhBKAJhdqOfAZzDxCQX
	YmAsdLlj/oQxemiWJ9QsY3LF2AfxTzbRcG1VO/DfcGZArdrKuaGF1Ra0kYecWRoDb/KmE3hYkQt
	pCvc9i3QNx2wrML4q0Va16J76iRw==
X-Google-Smtp-Source: AGHT+IEKRUZQ2Hg0C2GO/PmQ2T8SgDZbs29uLgcMhOKnuKBglK0QXvlmIcp/ZMFfvYYtGNMZ82Y7H46+D4Rtn3BOiRY=
X-Received: by 2002:a05:6a00:893:b0:736:50c4:3e0f with SMTP id
 d2e1a72fcca58-73722370260mr12612622b3a.10.1742215275932; Mon, 17 Mar 2025
 05:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315141209936kL2XHnj3IaE2dYcjQZlnV@zte.com.cn>
In-Reply-To: <20250315141209936kL2XHnj3IaE2dYcjQZlnV@zte.com.cn>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Mar 2025 08:41:05 -0400
X-Gm-Features: AQ5f1Jqpl4bSRGHQyqKji4UYsfjTQtW6qpkUUKmFi0NaXWBW9rleoIZ2xJKG-HE
Message-ID: <CAEjxPJ73QGRoG8VKV+T+cohz1f05QB5iQ3DhuvHSnSJtEYx0xg@mail.gmail.com>
Subject: Re: [PATCH linux-next] selinux: avc: use sysfs_emit() instead of scnprintf()
To: xie.ludan@zte.com.cn
Cc: paul@paul-moore.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 2:12=E2=80=AFAM <xie.ludan@zte.com.cn> wrote:
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

NAK.
Despite being mounted under /sys, selinuxfs is its own pseudo
filesystem and thus shouldn't use sysfs functions.

>
> ---
>
>  security/selinux/avc.c | 2 +-
>
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>
> index 4b4837a20225..007bd94975c0 100644
>
> --- a/security/selinux/avc.c
>
> +++ b/security/selinux/avc.c
>
> @@ -164,7 +164,7 @@ int avc_get_hash_stats(char *page)
>
>
>
>   rcu_read_unlock();
>
>
>
> - return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
>
> + return sysfs_emit(page, "entries: %d\nbuckets used: %d/%d\n"
>
>   "longest chain: %d\n",
>
>   atomic_read(&selinux_avc.avc_cache.active_nodes),
>
>   slots_used, AVC_CACHE_SLOTS, max_chain_len);
>
> --
>
> 2.25.1
>
>
>
>
>
