Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD93DA5C3
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449239; cv=none; b=ZkqXKIzAMTkMFReBCWWdaL7pZowOGfSo+FaMZEYA1gjQfq5O45M/b4yA6Omn2jAkBexssnDbJoLEKjLgvoP87TPdX0xkmiEe45SbIJDJ3sTpkxroAEDBBmZKBYW+S/dea/HdzNKmcNb5npSKs+jgFNscrqUKRjkl9QrgL7ZObzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449239; c=relaxed/simple;
	bh=hUl2zOVyzUL8lT3SiYapCjovg+lHxQaZIYKJ8BlXglU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVLp4+ZF7/Ta+aDcLuw3jIrJYtGxBRTFZ1hPXIkTcDGECkO41CdhVVeGiSzzyAfiCtq96J5IqmaHwaA9tFEHr3+AZS1le+o6ZxDlAZ9ybNAnBbqE9goz7b4DzDjOxcnMJYCfafntX5ziedMDdkjvq3CZC18ENgzO30am74821ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXKviWlt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXKviWlt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab97c86bdso21755ad.1
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785449237; x=1786054037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vdkvtQLWpcWGFw82Hi5kFN/C9JuaGxTc6QXo/A4PB+U=;
        b=VXKviWltygZBhIUkoOLT7VHl2k2xtoKQag7xfM1vfgUpf7y/3JnAbcn8oJKtYJHmN5
         LSyJKaTY32D/ChgDDyundLtIVjDPBtF5NBEqkABNORv4UQeqQE3YX8/tZAKalcxLYzpr
         7alRMO8gO1XZn5M3o19A93TKYIMJotzA8LwitqV8Jup8QLj13ohXkbOVfMhdRxHzRzA+
         PNMJ9GZt9s+rfXJbrBV6xjuffXQgg3J3RwWXMBLKjKRuT7BfzuSX05+jsoK0OkFVChtR
         LKzgbp8Yhx+pBDrGvKqCs6hnaqMuUSjsdN/nSXbm8ipuTNbYWdd/7Jnz+jAAX4Msc+iL
         Te0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785449237; x=1786054037;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdkvtQLWpcWGFw82Hi5kFN/C9JuaGxTc6QXo/A4PB+U=;
        b=lZ4VSctRdLTIhVhfp7xfaLDOfdR9HDch0BJHrEyZRDqIR7aktnTcyibDE8PxxUcE0y
         HKmAD3+MkblG8hkMpAaRt3LOlb70XPHwCG/GiV0HiGK9DnMHsOxCbQ8MFWxnqetbLmMe
         HRDh87vSUKA6bjBnoadLkc5KRshmm+1xGsoduUVskGK/hp+5DXwQtI9B8WUq4Ito4wuM
         FCXZpS6fPMndUIshclYcC/vFaO73ynlH6QjWniCzQ9oUyEoXiHIzgpvmo436YftfXzyT
         980DkzlryS3p9oOhW4orxjCPKgy4ZXPUu26QD6HkN3q5WbQO4Axn/CQ3yOmIM6zz4HPy
         aLQw==
X-Forwarded-Encrypted: i=1; AHgh+RpfVe9vrKpbKtXZSjppVQmbEfNxRv0WOULOG3oPQNJEjhC7auzHGQsUn2lAPHFsh6oG65F7pNEL@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUFlVmMQEDpWGB5FVw1tAh2JIx9atlJQ2N5Enu8vzd3v7oLRw
	5yXCLbi4soLaXRxoGXq7hPD/b8WqC+43AQ5CMm4jvvGm+7xDQIyK9EoJAmPs8GnySOfMK22SHYU
	P0nyF6g==
X-Gm-Gg: AR+sD13TbgNtwlGGJgonoZpd66eXw7U2aLjudEG1hc4fxEe1maUvUUwwnxWza14lVe3
	ztavOKNO0r2jJGOJd7IS1B0hg0+xkRA01i1B5C1RiTPTnmDX1JZCnKiIKcIOoZq/4H0SiHjXMvq
	tezDQ6XNRNc/aOIMxfuSb+ADNtahpXMcaqjvHPdDknMvonrbRDSHTBnr8vLdtmGu7dqO+PTeXoB
	tWkszotYWQ/J06f0Cwyd4b2t0slhNPs53scZH9ugrseDQUYe3gercpjM6iQVLQzu1K5qLLQd+CM
	iOgGSxWezVP4jgLfwICpHKtH7ClCIHiFTuPsNqwu17TYeekxBodFDRVqkMcaJyENjc+pB+Y0mBG
	CEkeJdBVfygmf+hCsVWbeOwt4qxcLVOTtiHvXjQPRVKsLhvZFB71TRjAHziaGG26cjRquyrYApM
	+4kix14ajMmXFCYG12O0y5CPJizBHFb3aMWrS6DHyaQKiN0TkXpM/exADl9vxInuvGczS7EPsrk
	BT4+LPA7pOYeVyZFffOK9M0MB0i1ZnoyMAqgFhW/o/TaQpp0ypn1XgyscoLzObyNbpYsCF4+Y57
	+X1/ByAmvtbJx7bzfQ==
X-Received: by 2002:a17:903:2385:b0:2ca:e0db:3cc with SMTP id d9443c01a7336-2d043edec5bmr1360785ad.11.1785449236599;
        Thu, 30 Jul 2026 15:07:16 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00507b0sm3691939b3a.14.2026.07.30.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:07:14 -0700 (PDT)
Date: Thu, 30 Jul 2026 22:07:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>,
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
Message-ID: <amvLDoB4g7NMlf4R@google.com>
References: <20260730181008.3654413-1-cmllamas@google.com>
 <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>

On Thu, Jul 30, 2026 at 05:10:00PM -0400, Paul Moore wrote:
> On Jul 30, 2026 Carlos Llamas <cmllamas@google.com> wrote:
> > 
> > selinux_inode_init_security() marks the isec as initialized before
> > checking if mount labeling is supported (SBLABEL_MNT). This was fine
> > until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> > where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> > xattrs) and yet leave the isec->initialized. This breaks subsequent
> > calls to inode_doinit_with_dentry().
> > 
> > Do the SBLABEL_MNT check before the inode security is initialized.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> > Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 8d6945edae7a..09a12eb8652c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >  	if (rc)
> >  		return rc;
> >  
> > +	if (!selinux_initialized() ||
> > +	    !(sbsec->flags & SBLABEL_MNT))
> > +		return -EOPNOTSUPP;
> 
> If we're moving this check, we should probably just move it to right
> after we assign 'sbsec' at the top of the function.  The calls to
> inode_mode_to_security() and selinux_determine_inode_label() aren't
> doing anything useful in either the !selinux_initialized() or !SBLABEL_MNT
> cases so let's avoid the unnecessary work.

Ha! That is a really good point. Let me move the check further up then.
