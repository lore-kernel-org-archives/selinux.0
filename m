Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DC2F12DA
	for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143309; cv=pass; b=MK+HMb2PMLtA8ZXKaoQM0VM20LYbsBFOO6v/5znYcO6Dekthi4bXkSj9xCU6B/jUCBzTq7meN3FfWUNNHYTeeqJ7fJ0X3/E5CN/XbtTOyfpFSvwZl3d2nuzHclc1UCbyNhDUnFxWZpOVwXtR0aIxJrQPcLDbnb4Qy51lpjOPmug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143309; c=relaxed/simple;
	bh=5J3OkowqOiAoB8Gdw2dD1GkTqHs8N7r75EaJkAtkGnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnjKJS1O7VfSqs1sOcKloe/IkSHV4CfmK3rfQ0KgtrLx1xyxvg2hpWtkyJYng+9UQ+6XkhPmwXf/74gMYr07CVR4LWjB3C8p2H/kFP1sIlcqfw2rjUVKrCnEzzmlqgNpe1d1PGeTb+AefJv3SP72fmZAXpUcB9btYWt0ARO8R6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHrBBg69; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHrBBg69"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfc20so90436fac.0
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2026 09:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789143306; cv=none;
        d=google.com; s=arc-20260327;
        b=P8ORiRaOGMa4yqLC5A1KKfEedq3X/6wNazaFQEqiDphFgO8hsJ4J3Ybl/Uj3k5ihnz
         Ya9f6KzFe4fMhpR6QjeuIvyVfewyd1gOAmd0dpbcG36F8j+3x2FpqAwlQUNy9pjH5EQi
         ts0WihDeejYv8/ZcQ+jO8I1OJwGwbIRQHxfSP7ClUl8tok4LVSy2LfZxvHiBTjFpzq3X
         00htB23RWC+UYSm0CSMeZNaCybK8Hvdn8zKndxV6/AW9WmcmEXm6O2tP5F9PhIG8sXvl
         1VRZ5O/QPj5DOKLxx2z4aJpprvKot1CoWSDuBGAHnr2mwqmmHIojAywpJIjvlF8Iy3NC
         KRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5J3OkowqOiAoB8Gdw2dD1GkTqHs8N7r75EaJkAtkGnE=;
        fh=faOJ8lr6BvA95dRozY/MoWkzZnBZxwSnSLdOfr6i82Q=;
        b=NIJ7478GFEF77Y9fstg9z++Gg/8ION46U1s3JtWLvBWfgEXBmghs/oMOB5ZeQAf+Mc
         Q/KuSXqFsrh3mxBBRy+jbaqneXYuVUVWodGUubWx/EMxROx3EUC/p2jaoL0QndO9Dh7Y
         EREqC9k9xGiHn8u6MKqmaMMa5WgaSuIsgfLRSbZXmJGUUefga1n6Un67wBiEZgIvaX8D
         9ZgiWSnflySQMgfwujwtDMceuHUlQflVd1WvJLrBLgde6ssTUizycxvxfEBOJoPnuvfK
         TQDmrKF3b0sxHWUGNtWOqRZ0S/bd1u3nunAefar4bGJxd2bNe9xUaD5pXQg2KTlm4S2s
         JaJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789143306; x=1789748106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5J3OkowqOiAoB8Gdw2dD1GkTqHs8N7r75EaJkAtkGnE=;
        b=FHrBBg69FPif4AokqBqqo5OtjiJVvUhsLH3rw1tB0WupNitx9Oil9dtMAqkxjbD81n
         5bBPtuYb+g7oxkJGMjMwWYKYcV2b15MCGTRx5qNK3DzHoBYjElOzomSy2YHJTgGVuGDX
         e1c9VfgkxLHSxeHeLIREan8xJuJ28lEKHZyMW2gLGLEsYsPyVENKXWpre9WDFJYU0DNF
         0nrX7kbjslUUFgkDa2XURvNBLifNjNklVDzGiFbS2+okLo49dia61SvlhczbCkC65LRS
         O2qmim3HxrSN9KyJRj5wkDHuz/KlOBmY8MIOV+f7XcvsMjQlKDQNdxOp17CgpJZMvgHC
         5guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143306; x=1789748106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5J3OkowqOiAoB8Gdw2dD1GkTqHs8N7r75EaJkAtkGnE=;
        b=J2BI31K6w+mvdcx9oTYZ7G47Iwm3KftypZQsqNqodK2PrZKvfqSCWfKL5X9DipVowt
         aaAFWek9XD1M69jlOUBBwgvajy3Fq9jBsnY4WFYF0MRFA1DSajrlFSTC7FebBnQIJlQ3
         rSz2YkCABHAzhGCK+QSxVMdaykjlEuAcccvfkcMkTymClcxt8XZSkE5N08/jBabFV1Pc
         Jpyzs8PqMnt6J9IFf6yP28Pc1f49aQ/QuhtyEdLqnqp2wjGBy+93l3czziAgrZsPiVRq
         4HZKEvB7gmDiwe7y8AIwva7IAat9dGzT8Gxd1OUcvUVGWL7e7ovrFKqDxCV6A4CeTH7b
         6dYQ==
X-Gm-Message-State: AFuF++nB+a2wLftpZbRAdKychp0wjiEyo3vXMup+w1U3seJIKdFo8fUJ
	I62vwzlmYwPiVzRDRY4tkJ1YP7q8VsCTT3KWLqucNnNZR8OP1T0rbxDKyOOZ7lit2KG8kCUcZSV
	Ay9tJ4W0AQ6CcfgGH1p7o/eigWbRTY3s=
X-Gm-Gg: AYBFou3vRX1M+EwM/TJb2Htoz5UoByohO9f62DKBXp70ll/CftXezro4QWyaeS3lWx8
	vczcbAMKa8DBqlfMpM0FKyjI2eMcb3qa973sD195/lzWBdveV7G+7i2qShW8/q4l0pmUFongEZV
	uOGMnS6OsUiVKw8vCEEzC33tz55L1DtMl+x9AhcQXhmE/kmNV7D2w4UK8+Ti5IFSVlfNBJkFm1g
	GXCD6G4JOtveWDf4DM+ldlEK9Ng0HwXN0xDk3WmTG1MYVMe+ByAY3psA0urpa1pYdfDjjtrWLf9
	bZf+d+mJNNVqIPZuEiDi7JGvwHbYb+0zJ15z2nSc9TAuUNjDVFzVjbI=
X-Received: by 2002:a05:6870:214a:b0:47b:df9f:6c0 with SMTP id
 586e51a60fabf-47de772da01mr6217573fac.4.1789143306375; Fri, 11 Sep 2026
 09:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911145840.19039-2-stephen.smalley.work@gmail.com> <vacb35v2k5omae7ad5hcvtnzkciib4zcdb2kbokgd5gt377vc4@mdqmy6namwrn>
In-Reply-To: <vacb35v2k5omae7ad5hcvtnzkciib4zcdb2kbokgd5gt377vc4@mdqmy6namwrn>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 11 Sep 2026 12:14:55 -0400
X-Gm-Features: AcwNN1XtcdVRdrRkHw0PcwpojMJBAjkxaHJQXqv-7HcTFEd66KTTGhcjsbJA6Pc
Message-ID: <CAEjxPJ7nfLR2jp6DQkvxhGcNFD+=tUWvniU_MWqnBfPGUw58PA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: reject writable opens of status file, drop
 mmap write checks
To: Jan Kara <jack@suse.cz>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnacek@gmail.com, 
	ljs@kernel.org, jannh@google.com, cgzones@googlemail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:23=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 11-09-26 10:58:41, Stephen Smalley wrote:
> > Similar to what
> > https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/ does for the
> > policy file, update the .open handler for the status file to reject
> > writable opens, and update the .mmap handler to stop clearing
> > VM_MAYWRITE and checking for VM_WRITE. This does NOT prevent
> > truncation via open(O_RDONLY|O_TRUNC) or truncate(), which is
> > left to another patch.
> >
> > Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> > cc: ljs@kernel.org
> > cc: jannh@google.com
> > cc: jack@suse.cz
> > cc: cgzones@googlemail.com
> > cc: brauner@kernel.org
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Hum, so rather than having special checks in ->open, why don't you set
> S_IMMUTABLE bit for the inodes which you really don't want anybody to
> modify? That will block both writeable opens as well as truncate...

Great idea. I will do that in v3, drop the .open checking, but still
remove the .mmap checking that will then be obsoleted, unless someone
objects?
