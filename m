Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CD212624
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844324; cv=none; b=GqanSN+n0UMMF440YQTW2hVEPzzyVOCYBUfjyxBBP1KhZB1CYnkxcIrpmAjAiJKW0JIRDDbB8qPg1tc3nzkPhqcBq9al9f1SJnGtNChX/aC5oRBp3Q4dswP0+V5vSsQdKAkv1uoJ8fCb2b4RVCHeinyeLC8Db8otgj8Em59hYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844324; c=relaxed/simple;
	bh=djBJ3X9b8PV3X9FBvYB2DvR8/bEo6mFq5HQ90DmmY4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMXRt9HWrx3z1bysaaZwp9hNP+Z5LMsClUw2y6jA7So8TEqgGuyuOgX28q4heHWZjpHOK5OwENB8t7NKr2+UccrC69v51kkjdho7w+k+vmc9o3RIu8pgVSL7jq/+prwAK0/9KAYrfbnKdUwo20plD+6fL3D/6ALsrw4nonU+HPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MOCTC9us; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MOCTC9us"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea8419a57eso36226797b3.1
        for <selinux@vger.kernel.org>; Tue, 05 Nov 2024 14:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730844322; x=1731449122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhZ+0Y9dSaLb2rve1kOjUAczY7wbLs+msnWKXaMK6Qs=;
        b=MOCTC9usKgp1nGk5iaqLnYdttea3fDU3AX2cnt0Bet4WEu2WUWTwboM3TzvZ1sWM7E
         MG4dk2wGRgdYj6Csuxn/qOPGhXr3iQSvAeEl4Ix61PtiJ+4ktyhbKB3BFqcSdGhvs0fL
         AMCogWlcLAcIJvqo+W3H6AcGi9bMg3ZWZWpM8gPVltPVsnd1CUEgCIVFvYlfoMpwEgdZ
         DkZ77YiEGzXFyj/8UoGM80TKVUYMhYid6toEzy2QKo1hD/WWgBGL8hhW/shGNQBI4i+N
         ElfyCHB5/Q9/iS5yJi+1/gjTrYLonnbr+TAMbIz86OzvVWZ9pEUB0Z6rHowzD5qj5m+g
         iI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844322; x=1731449122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhZ+0Y9dSaLb2rve1kOjUAczY7wbLs+msnWKXaMK6Qs=;
        b=qvR8Ws/kD54uEnofJmzoMxQmBmWfNJGCFpHB0P+hY2qc3ZaBpZcQa7b+iu1eEzilNh
         HeV+3ssf5+hdzWPp+TNE1axZD2NxeN8VzLXG0WYtDrnUg/i7DD3yYcLzIPDVDuwpx5xd
         2M8WSaLiml7bGJ55JxuiyXY/dRNyrDz2IsJ5Aq42wj2tEFkVQKa1jxcIN4tNyg169PpN
         oSKhRP1daZa6Vq/3b/A1QT6ATmCbC7g4M1wA3dujtH6Y2dHCQgz043zpryCr31ZmNWLT
         5MjvDCqJta+KnntQ25l9VjgIkDg7H88YjiIdQWK2rTTQBwXxZlTvUzqaEgHG71XcKvQG
         YvoA==
X-Forwarded-Encrypted: i=1; AJvYcCWT4ap8YUiwd3aW3bz7EyhN38FZG/R+oDgdEiy2TvWOxXLlgn5GjaccCazgerygtX6RkjBt5rV4@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZSI6hKJB3/JAQctS9Ul/iKB95J/oTk8jVVOZqeoJG0tRBCD6
	b1gMy7Ib/0s06zqR6QvC5dlExi/S8erZzlz38jLbNj+eK73cgddbph1XeOu5bPKGGmrFLHDf/jE
	JKTCENHreD24rkCPU+KPMEP/Js/wJuaWzL003
X-Google-Smtp-Source: AGHT+IHOquUqvyWgtXT2/sE8iENbvnsQpc3TOSa8HX4MAum2KDhJxz63gYWb26deeOkneLh0dVm/l7sooH5/2AEa+1s=
X-Received: by 2002:a05:690c:b82:b0:6e3:1008:6d7c with SMTP id
 00721157ae682-6e9d8939dc8mr367029867b3.11.1730844322234; Tue, 05 Nov 2024
 14:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d02f331-42ee-40db-a64f-5ee378eb44db@stanley.mountain>
In-Reply-To: <2d02f331-42ee-40db-a64f-5ee378eb44db@stanley.mountain>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Nov 2024 17:05:11 -0500
Message-ID: <CAHC9VhQw-DGzCq-q=ZUXjzM8GN-cUJXb6nU2PhOMre3nhiQJ4Q@mail.gmail.com>
Subject: Re: [PATCH next] lsm: Fix signedness bug in selinux_secid_to_secctx()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 5:31=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The "ret" variable needs to be signed for the error checking to work.
>
> Fixes: 95a3c11eb670 ("lsm: replace context+len with lsm_context")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into lsm/dev-staging, thanks Dan.

--=20
paul-moore.com
