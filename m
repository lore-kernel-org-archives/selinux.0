Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914903D890F
	for <selinux@vger.kernel.org>; Fri,  1 May 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651271; cv=pass; b=JBwEJ3T1RABpqaURVpE9pttgCMBsVo/km+A2N0usuG8LLT0ookFbfFafaTjcuDo/G/QFEDKfqFKkgDJ08fAWI3bwUJMEi+Od0Cc9aGWd+WtthiWbo0gUEzmnsNZAkMoGghYzC2bI7lhY7Jugxxw19e2ifda+rJj8sX+Zvkl2AJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651271; c=relaxed/simple;
	bh=i7dJg+Ad/jLF4unFEZVC9YnfPvnVtLzsZxdPQEi9eo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH6iOTHGTBWpLOQTLrGEnyDxzRLCK9qyTcGCuXlh4P3V4a7OzCOZzm4Sr0RZsDS9DtgxtMntLWsqI41bJF953bG1pDxW6rO13myeDzYGUTy3kVsUtI4qZ3O35V3Jvrzfyb6DtgoYLAv/YqrU0E1CB4J7SPftp8VXPJhwbHAxsSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBpXWxAg; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBpXWxAg"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36505450d0dso299863a91.1
        for <selinux@vger.kernel.org>; Fri, 01 May 2026 09:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777651268; cv=none;
        d=google.com; s=arc-20240605;
        b=aD2vbP0ghqgOrzWFjo/YqGmpXajc0KR+XT2jPccbDc0q4nioaJV6SDwyp5SMh8db7x
         yxuGwdXKVMVkcmapgtRH99m064LnL2qAI6tuIE0LEH1JJmRSNWuvD9cwJ/4Qc3QKlkck
         gwSqyB2jGM8e86F9H5apxcl7J/IoqCewwGuxXq8AiHf6au/rsWkatM867m/xatosslxm
         FnLA8hKi9mU0XoLNg7/MiQj1QCUzdh/o3c2xt3BGjABMGH6O2VTtcp1WZxcFhFT1X9a3
         cjUqPDiX7ilgj5ZKd7+Sz4aBsRfKX3eEYY8fiajK0Ei+rI2TSsDWz1dCBSqMxZKuXDgP
         +irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        fh=ZpjR0YBreWerwjFTOToXoZvBgPF5u0kQIBqSbLVmbQQ=;
        b=VJGzqJC/3f6dlKzqBv6ZAnWB8HcmS7EpPMubrA+7Uwa2Q1ZpaeqN3XVULksWIPmldr
         lAKhLJCkryszvAOjaicF3cU/oCB5uimGfKtDK3f0w8imOeY1UxWLE1Kk0sKf9GZShh6G
         R+wUCE6e+vPpNEnFO81WURGa+9UbPEvmrbLjEXjxDjLPUbegprbSGjmzR6GipcJvAHfo
         32KFv9JNSHtDNKIQ6aMNig0OT+5vha03Yz7Fxx8HFffj3C9Kv3No/kbBgo+jLvLev138
         YrtdzMpRFDRqxj4PtIeAHP+7Rw1H9QlTmLBvZiigTvTweuS2WIgnJ7acK0Pb5xLvz9p+
         bnwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777651268; x=1778256068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        b=CBpXWxAgBMkmjB8Xok4tXdUjTk929M0ao0dwZZEZEC6mdNe9MdvnjuOqpXVhH0NVP8
         MVcuN+TdNx4bHaIVDMKE2NTrh4B1QxcsMAFFACegusAQ4fwaFQEcNIXEDftiBSX7jwq3
         q/SmkzexRfa9nDb7/V4yLE9wStgCCclIsEHddAwRHNbOp2cwwrEp7vkLqK0InWac4bAq
         2zD4RQ/eFr/aWwBqnBxLLMBZP5q+wUfXpFJuQ84EA6yXWZPOJkY5TovrNl3CV30ma2gw
         0uvlQevr2alGJ+x1/OliNj9p21ToXn3hJrZVf5RvBTDJg7JZDaYqlcRLmqbLNnzpO6yp
         EHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777651268; x=1778256068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        b=EzvpSby9raNsjBGQXmE7FnUKpKg8CXNC3WOCcAlZPbk8skky6kzlah2H8WLvRY5g7l
         K8xeqgR5zKr2JFhz0SxCFvf9Gexf4Y24gvZ+25l6q/EpwyRelD5W/OiSdZjFoo6IIMDR
         UKbquBieqCdG0nD4wdO/BV4I9R8I3S8Q0F02nnPQxjGOIGmcxDFE/s7LKmeRlWjoxj1I
         l5r44AoMYUsliKsAK7HEKQ6PvF0OxCpKdF7ohXSQk8dNWR08V3OyGvNOgCvtYz6QyLHV
         wnTWpwmWxN+OpWcknVTGhTcfH9CN/sIq5cQqGz0vi5m10xpkSAotp8l1VVn49AWOhNma
         sEGw==
X-Gm-Message-State: AOJu0YxjNIKUKZGu1udx45mdx7gonu65gOgJ5ZPfo5GPjs68Gk/c/hRg
	eLfC7mU5ZDqoju6WzncMy13ani2LPkygWDvWX6DIjWxSuABl/gmFNx8aEcc0OKENoXasM8axW1i
	1Ly/DwW6WU7PCZ2v1OHGEp3AB5U1rpt5OJyvamo0IYDP8JE/goDI=
X-Gm-Gg: AeBDievqmOIds1o3nsnrjBdF0y7OSbtQP8ylvhq9W2v8vuEkmwkiVb7hHHFbHy37z7K
	8wnLK26TJHpNeJ6EwslfUAKhxGtf/zaiYXUfRRD37ek/wXTqlspnFiopHcTB9lrcMAfWIaNBGVo
	AUYeZse/cfC6zYLUUQ3niVAQ7a0pZ720l3hJen95EnuNi6xzaM75k8d9UqicG6jDO5NzDLQ7B4j
	K+TB285xpO+W7PGhhwoN62jqKJbI02defRSN+J4gR3aSHHAOGveRSP9hLn0N/Fr+iwTbQMNErCX
	lu22V3nWzQr7V6s02Q==
X-Received: by 2002:a05:6a20:6a0a:b0:3a2:d838:bfda with SMTP id
 adf61e73a8af0-3a45fe26b94mr4353703637.46.1777651267760; Fri, 01 May 2026
 09:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260428192119.226244-2-paul@paul-moore.com> <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
In-Reply-To: <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 May 2026 12:00:55 -0400
X-Gm-Features: AVHnY4L3FM6UrambQrN7cixYHO4W-gQ46kIRQQMq31UfNN7fq0b5uZg5p-YAHAw
Message-ID: <CAHC9VhSyDVLOQ2vr0YL1PUCdS-jh0gvwcDruW1f6t9g1WTDS7Q@mail.gmail.com>
Subject: Re: [PATCH ported/repost v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Apr 28, 2026 at 3:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > [PM: forward porting to bring this patch up to v7.1-rc1+]
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  fs/nfs/nfs4proc.c             |  7 ++-----
> >  fs/xattr.c                    | 11 +++++++----
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  include/linux/security.h      |  5 +++--
> >  security/security.c           | 16 ++++++++--------
> >  security/selinux/hooks.c      | 10 +++-------
> >  security/smack/smack_lsm.c    | 13 ++++---------
> >  7 files changed, 29 insertions(+), 37 deletions(-)
>
> With the security_inode_listsecurity() cleanup shipping in Linux v7.0,
> I wanted to get this patch ready for the next merge window.  As
> expected, some borderline non-trivial porting was needed, so I'm
> posting the ported version in case anyone wants to review the patch
> again.  If I don't hear anything over the next few days, I'll plan to
> merge this into lsm/dev later this week.

This has now been merged into lsm/dev, thanks all.

> The SELinux test suite runs clean for both local and NFS test runs.

--=20
paul-moore.com
