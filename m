Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48681136665
	for <selinux@vger.kernel.org>; Wed, 24 Jan 2024 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140787; cv=none; b=LGQNMm0fTn+wHTTP1wSrY6Mx94eqeCkS2FYVC+JruPupXuiIZLfrXkDcNOeRI0CzWQb9itvJrTaDbU1bDj/nSLgrkbDiRxa1phhCw7MN/hBSbY266q4x9kETNcoFEh2JFB8fJig1Nn7Xhp8xXWDT51eUMMtsd2YaL/dF1JwwR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140787; c=relaxed/simple;
	bh=maL1nBVb3loVr4Vq+G0ZcfTdgHx15jI1TWoWEIy3O78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0jkgur+CggT6cTPL0w5x14EAygTHvq6IgJ4UzBHgeR5GjHvpVtSmu70RZe4qFBd6EAa0RCKXVLosEjq380B3iufLaVv9997B9efQOOhFZbPvdIifd+Ci+VuEToKe1298z9sdSLRzd5kGgbt80ijbDcGIcQBnrKlXVQTxRANGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fSb71e7l; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fSb71e7l"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc223463ee4so5520244276.2
        for <selinux@vger.kernel.org>; Wed, 24 Jan 2024 15:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706140784; x=1706745584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9ayzdpLCpwSEzgfqolvwUpx5pbrBH3JNBHTp6SFgHA=;
        b=fSb71e7lgwImeiCGtLvNsd8CfbRV7wsZio6STyxf2qGYy43/oH5g3M2REWRHlmK0F6
         T3tSV6ewP2OqdvpQRUDQSbtVONbCD6I09MGHYzy/t09Z2dQVOTA8FGlhypiseud3SB+g
         T++015vX94xaBD5+eDQ1JDZUHU4UbpkKlTNj3qphFAFsT7wFPCA3/kRtQPm+zgP+CzlI
         xad1HSwedTIzL6deEEpcgIZWPsxyhX3yfYc5Fdpru2L9EKfxlW4Q3ox9Ru8sC/C1VMTM
         Cg1wVCDzs04aMqx7c35+DvLNU8ldynRyJyf1n4EJVMYoiLOTouDHNdBAqXNi3cQg7pqz
         gOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706140784; x=1706745584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9ayzdpLCpwSEzgfqolvwUpx5pbrBH3JNBHTp6SFgHA=;
        b=St/G0WTtjR+fZMAMtBGi/ASmvLnBvRLBTUXnXhsp/HlXO/0KTwPj6VwuSEEHvOIxAS
         T/Vb5Wfk8gVUDlXk5DdDAX9by/yDiBPw0c0eI54LHInEXzF/SmhoI6niiovSm63GQvlG
         doMQEElJlOZloyxQxiPP4CPNejrN6Z6PUzqK8Jmg4Ea5pJuQh+oSvclHxCVPBGMUSrXb
         MsIApMioKIBwBdN3kL9tOD+M+H3yCvGaMg1qLlaE1CL1R2QwnyqY/MRDnbBnaxOnxv33
         EgYti8QcG5e62dZUSvybr+zSVaf8fVc4hsOVN14IfXsLfE11tktwpK5RKhmnRyaWwYZh
         hASg==
X-Gm-Message-State: AOJu0YzcfhIW+6hcMDi2zYCHX7EAc0FWERUtBGM/NYk5Dp0qP9/lsqLg
	8/mAYJa8hNgniI7pOT+YmeCVbEdvN5ZaNr4DsaVAznMxNNChWYCwouRTVNAqhuxCl/aWLj7QBE2
	o3jZrjWS5lqJuiMZ8YAJ+hlYWhFfF59cHKJF7
X-Google-Smtp-Source: AGHT+IFqkibhd4kfZNGMoX0cUhRT1hnJyuaqAH5vdwu2R5ItL23iLNhiLEi3Ud2W5qihL2/NDnFDB1YT4/GvJ9wSI6Q=
X-Received: by 2002:a25:6608:0:b0:dc2:6600:4eac with SMTP id
 a8-20020a256608000000b00dc266004eacmr115099ybc.116.1706140784182; Wed, 24 Jan
 2024 15:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com>
 <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
In-Reply-To: <CAEjxPJ46kPOA3N7PAgqWs-z74siF7bMoGSU254dYReQwFCNoXA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jan 2024 18:59:33 -0500
Message-ID: <CAHC9VhQKXtdA4YS7=fB9ffGTDnd7qPkCZVCTO3fvaQWjzwUT=Q@mail.gmail.com>
Subject: Re: selinux-testsuite nfs tests?
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 3:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jan 24, 2024 at 1:42=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > So the recent discussion regarding questionable setting of
> > isec->sclass in inode_setxattr and inode_setsecurity that was
> > introduced by the labeled NFS support patch made me wonder about the
> > state of the selinux-testsuite nfs tests. Trying to run those on a
> > current kernel fails even before getting to the tests themselves
> > because the attempt to relabel the files to test_file_t fails with
> > Operation not supported errors. Anyone know when this last worked?
>
> Looks like this has been reported for Fedora kernels here,
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2257983
> as a regression from 6.6.2 to 6.6.3 and later.

Thanks for looking into this Stephen.  Unfortunately I can't seem to
access that BZ right now (the FAS login page is hanging for me), has a
root cause been identified?

--=20
paul-moore.com
