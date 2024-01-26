Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD21D527;
	Fri, 26 Jan 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706285089; cv=none; b=o+6ZmSfVFdnhmkk1fpN1Ndf/hiofl/r6NAlNKHLe0cH3gnqfsaJmUI+mNHfkjCM5K/xaVhU+VW+FI2DwmCBFe3p5+nYyJV5rAC/6BcSdttWiC6HMLVjbZdeHzlnAXrOrB76CEEEtxNdVHta6VPfBb5SUA/tFFqKqOXpubk/psBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706285089; c=relaxed/simple;
	bh=J+Y0fLcOWOyaWRlvn/lG7habSZgfrNyVoIBHk8KbHTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzKl9dSMUOwOk+SVYca3Wut9vj+ltivvQB0wMUDXNczFHugLOBixbdDFnNKBroLQGhEycp/iWxbGY6+ot7g4dLo6nOFq/ZKTnQXSRvYq6nxF2YyjFobRY18lRi3chH4XXMjHfklRQZSGOSQ4KsT9Q3MAMoE3Z2o0/M5dB+I07FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4vZmO9Z; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4vZmO9Z"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ddc162d8d5so416978b3a.1;
        Fri, 26 Jan 2024 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706285087; x=1706889887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6U+b91wnnsjOo0a0kxHUFOdXkPqnUtagff0CUdvN+4=;
        b=F4vZmO9ZMuEtpX1U+288bEp1yt/NZxyK8ICGnyU0lHgCZx2BKcxCS86cSM4Hcy7xFH
         BEbINrxsVzrbyXUOuxKrgsvzVxAW/m697tQed+TzsQU5H1uKxC6ZLYr5i9Gk3JQPPt9T
         7AWy+05tqnDGmN52PhIyUEMqMsvIQjXWrob4PvM7BPvNLPOgoP6nUFjR1YVzsEiIzbET
         OU/HrAFJT8c7Vt9QA7kqDNa1V7+/doGUKaKPdtLgYeJZ/8XFfC7/bPkyQLhzWcxtMF+9
         539h3Jqbrm/35/Nx05MvGWj39iJDBsVgy4KvlNLlv3JnyH/LLvh+JBbqcHZXRdYbx0c6
         UnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706285087; x=1706889887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6U+b91wnnsjOo0a0kxHUFOdXkPqnUtagff0CUdvN+4=;
        b=bEqwmJ+tJMmaDR5qUIY1GPhg9KLbBGbO/RjoXHWtUV9Ws0VcBPDGNBeRcBhvB2enrJ
         MnHcnSKr4qj7/Co/MyNswi5nc1b90c7FO7pl+Mx+WPdLSdrekA9S8PfEmhT1f89tYPUG
         NG0l8SDV0zTcEF/z1p3yOXOmerjuz3OtP+7EXvzAubbkf8Yju0DmBEDJXFiPQPvpDUXL
         Y/3KgN6PIKUAHl5/3+ur9HwVbwdQ3Q56m+auOIoLAz4C81qAGLr0LfX5wFUiOkDPJ/Ll
         6XCcDaCwC7jS62bev9ovafb4qENZvuGkmiRWoKrl9Jjc8wkPxlyxjNDkh89eggRKWsJs
         t/mw==
X-Gm-Message-State: AOJu0YwgcIg/dn/KE6xSPIoG+VikzACKnAiHYBgOA3Jir9Ud2ZvELThF
	SSdMoSlbu3npeEUVCQgcRzdKU33Rdt8D5cwBJwwW/diM/pSSqx7q4exjumAtFHcNd3A+pl2Nld0
	qdbEzgWBdyxm3uo+6Egj4pg5FQt6QmKqYubo=
X-Google-Smtp-Source: AGHT+IFBdbbPVDtSsTpUmdPeYRFkWeSxgHdKZfordltZg8DG0StWmNQFEFnjPQOsTlNFkq5Qs9fERkAeehpDEYptah0=
X-Received: by 2002:a05:6a00:9095:b0:6db:bd8f:c05d with SMTP id
 jo21-20020a056a00909500b006dbbd8fc05dmr19253pfb.8.1706285087321; Fri, 26 Jan
 2024 08:04:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com> <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 26 Jan 2024 11:04:36 -0500
Message-ID: <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 10:03=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jan 26, 2024 at 5:44=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > The inode_getsecctx LSM hook has previously been corrected to have
> > -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> > behavior. However, the call_int_hook()-generated loop in
> > security_inode_getsecctx() was left treating 0 as the neutral value, so
> > after an LSM returns 0, the loop continues to try other LSMs, and if on=
e
> > of them returns a non-zero value, the function immediately returns with
> > said value. So in a situation where SELinux and the BPF LSMs registered
> > this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> > returned 0.
> >
> > Fix this by open-coding the call_int_hook() loop and making it use the
> > correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> > other hooks do.
> >
> > Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh9=
0jYPwRQRAqXxmOKD4Q@mail.gmail.com/
> > Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx=
")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> > serious issue that Stephen reported, some of the tests are still
> > failing under NFS (but I will presume that these are pre-existing issue=
s
> > not caused by the patch).
>
> Do you have a list of the failing tests? For me, it was hanging on
> unix_socket and thus not getting to many of the tests. I would like to
> triage the still-failing ones to confirm that they are in fact
> known/expected failures for NFS.

Applying your patch and removing unix_socket from the tests to be run
(since it hangs), I get the following failures:
mac_admin/test            (Wstat: 0 Tests: 8 Failed: 2)
  Failed tests:  5-6
filesystem/ext4/test      (Wstat: 512 (exited 2) Tests: 76 Failed: 2)
  Failed tests:  1, 64
  Non-zero exit status: 2
filesystem/xfs/test       (Wstat: 512 (exited 2) Tests: 76 Failed: 2)
  Failed tests:  1, 64
  Non-zero exit status: 2
filesystem/jfs/test       (Wstat: 512 (exited 2) Tests: 83 Failed: 2)
  Failed tests:  1, 71
  Non-zero exit status: 2
filesystem/vfat/test      (Wstat: 512 (exited 2) Tests: 52 Failed: 2)
  Failed tests:  1, 46
  Non-zero exit status: 2
fs_filesystem/ext4/test   (Wstat: 512 (exited 2) Tests: 75 Failed: 2)
  Failed tests:  1, 63
  Non-zero exit status: 2
fs_filesystem/xfs/test    (Wstat: 512 (exited 2) Tests: 75 Failed: 2)
  Failed tests:  1, 63
  Non-zero exit status: 2
fs_filesystem/jfs/test    (Wstat: 512 (exited 2) Tests: 82 Failed: 2)
  Failed tests:  1, 70
  Non-zero exit status: 2
fs_filesystem/vfat/test   (Wstat: 512 (exited 2) Tests: 51 Failed: 2)
  Failed tests:  1, 45
  Non-zero exit status: 2
Files=3D77, Tests=3D1256, 308 wallclock secs ( 0.30 usr  0.10 sys +  6.84
cusr 21.78 csys =3D 29.02 CPU)

mac_admin one is unsurprising for NFS. Will look at the others but
suspect those too are just quirks with performing tests of other
filesystems over NFS. Should be able to modify the test scripts to
skip all of these on NFS and thereby allow clean runs. unix_socket
hang though bears investigation, because I think that used to work.
