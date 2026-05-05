Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9B3BFE2E
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009265; cv=none; b=HszjzkEdG1bA/T3uD78YQJK8wVTFgzQwM8KrocQp71L6LFy8xhlAx/AM61xCAvfR14ND3R4/mUo4yZMQ59oJY2C2ZwuT3yYJ6kK/hSkzZPuWU1XRw76jDEtm/OpcDg8nm3TTgxZyGit6k6vDYzbZ+CPaUGJs0e0fQYZKZRc0Bnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009265; c=relaxed/simple;
	bh=nheuL+Z1ojrYbO3EB2N2fpQ/IHQwQG1Co6mOOxWj58U=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lyWCcbqPH8wQzK1RrzQYutvBvYTWDKaZi8O8F7ookVbx+wHAr24O3aJeHHXM5EKGGvQk1qzNvQoASR0+310aszyzX3AS7TAwiecTFe9KDj4onMLwweEXRt/OSjuzInqOk5cqp81ZfG2ZmWFre0vst1TLwaHvUe8Fnxx+Wyouyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SEKMBFhh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SEKMBFhh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51306c36c3eso10772541cf.0
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778009263; x=1778614063; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7OWthRF1JPWS6wt3vZfE6x1PDz7aWRpcWQfOXolmD0=;
        b=SEKMBFhhNxBXkDikv4SnWO++MZY0ZuLuQDUU1+uLplXOIj45vvQzjnr5RstcBc1jS/
         vUqiwObHNQOXSd5/kmAMggQylr/ilvEEy8Xwj1Av4lK4/f+u46Kh934MTYZE3MjHGNKJ
         sawaVnr5yImoTnCD5pM7AOyapiLsMIZxNftphkXy5JHnKRxNUf5OPGwz/w3uwGmTrkFa
         AxLsEdgPEtwCFmCkvd0+ne5AWnyPD+AzecXB3isvYH1KygiEGCPUCZLTYKrGNW5JFVJ6
         yB/WaxtWhYVeeCAN32SuRd7oqN+8Cq5QCZXIx9bWc84R3sxYNjPXmvMiplxQU1Z7MgrR
         /zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009263; x=1778614063;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7OWthRF1JPWS6wt3vZfE6x1PDz7aWRpcWQfOXolmD0=;
        b=FiQoKS5aVKA5X8DiMtLx+cmAgMRkQrHzpUuKWw52b/XNjvbI4F2BQeXsLqwdzHphX7
         cRwJ8TjJT+nCOUlgs6mLxlwj7O1vcWCAUArT6dP4KU/7kWo86xs/8HDXDkN2lP6RhCVO
         pT3E8mMec65wL5JhtnpjUITwtWDbCajU6zC7VbZRim6evHcfwqeZYT5tyb1IE2jdYc4V
         hLH8wKnyUNx/UaLBEhgmy6htEWhRAslMvhkCcbNsL/BxgKnnWO71ewF0Hs79K9uBSAKX
         oLzDQKj+MgI8F46Uhj+TxFlVAK8tU8WOl9UVPThMhWshFRUjHASEnm8RvuhlLHsLx6qJ
         Hy4A==
X-Forwarded-Encrypted: i=1; AFNElJ9s3xKCVnnryRIsahGERpR+pue6sg9jovgyUrfVUrv16lu3yjI6HaWV2ydHx7ojyxMvTFwZeZDv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gSPTFLukinGrRnBh4Qv1DRjePnTdiDIl8YUClK5E03IPpBqM
	hbNPPAZ4BQuzcZBZElxVd67CaMML1NMAKoBhZ+d8BVHKMSt+5sTAxow29iHUZhcw3A==
X-Gm-Gg: AeBDiesMwiEwxV5mon9cHjCMYxfuRq4YUi0jn0KnygJQf01QwJl7kneYXd89e9zJpOz
	KI+fHb36mQ7TryJdI8JU1/TmKgc8OsDECBX4IaYfUB6DbXVLmAE885Suv901UC9zKprdoJBBxu8
	pvFns7yE+m9NxKnE5xOsFRGOyUmcuPUyshmdcVO42GxMFa5aj9EcD4Ap6ml11uH4tcpp33305IF
	kvVrIRhTFzotFOGtG5DapcfYG2XdSQrrb57uSY4FJuzXjs6kNKK7WjLdj76emEWks/5QifSNohr
	zX4ANu5eopo3rptfFRoFXFZYcHzV6TisT5gYlBDoN2BaAfx7JYbqbwkAGKbkoS1iBqRN8jsxnXG
	PTGEp6OnSCV/VJQb6MoS7rUs5w1VNtWoC88GMwgoc4KNtmdMKi1fANjmi9X8Ll/bf/K1L6ggJou
	qNmOGqtMgHg8uEJcaWyiVqlFbBKJYTd7o+Y2ZxEQ+GbJouAs971QD1pMwXUrxOGVxfw6o4nsWU5
	f22GMk=
X-Received: by 2002:a05:622a:1b15:b0:50e:6313:6e13 with SMTP id d75a77b69052e-51461be0caemr6664101cf.5.1778009262949;
        Tue, 05 May 2026 12:27:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040ba8b0csm135711291cf.30.2026.05.05.12.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:27:41 -0700 (PDT)
Date: Tue, 05 May 2026 15:27:41 -0400
Message-ID: <0c7f9492015734afff16209b62eaba07@paul-moore.com>
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
Subject: Re: [PATCH v3 3/3] selinux: prune /sys/fs/selinux/user
References: <20260505124949.2541-5-stephen.smalley.work@gmail.com>
In-Reply-To: <20260505124949.2541-5-stephen.smalley.work@gmail.com>

On May  5, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Remove the previously deprecated /sys/fs/selinux/user interface aside
> from a residual stub for userspace compatibility.
> 
> Commit d7b6918e22c7 ("selinux: Deprecate /sys/fs/selinux/user") started
> the deprecation process for /sys/fs/selinux/user:
> 
>     The selinuxfs "user" node allows userspace to request a list
>     of security contexts that can be reached for a given SELinux
>     user from a given starting context. This was used by libselinux
>     when various login-style programs requested contexts for
>     users, but libselinux stopped using it in 2020.
>     Kernel support will be removed no sooner than Dec 2025.
> 
> A pr_warn() message has been in place since Linux v6.13, and a 5
> second sleep was introduced since Linux v6.17 to help make it more
> noticeable.
> 
> We are now past the stated deadline of Dec 2025, so remove the
> underlying functionality and replace it with a stub that returns a
> '0\0' buffer to avoid breaking userspace. This also avoids a local DoS
> from logspam and an uninterruptible sleep delay.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 adds a pr_err_once() call as requested. Note that we do not need
> to copy current->comm when using it in pr_*() calls; this is only
> necessary when acting on another task (get_task_comm) or saving
> for later use.
> 
>  .../{obsolete => removed}/sysfs-selinux-user  |   0
>  security/selinux/include/security.h           |   2 -
>  security/selinux/selinuxfs.c                  |  68 +---------
>  security/selinux/ss/services.c                | 125 ------------------
>  4 files changed, 5 insertions(+), 190 deletions(-)
>  rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-user (100%)

Merged into selinux/stable-7.1, thanks.

--
paul-moore.com
