Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793895800;
	b=1kDwhOkCNXYPO7Hs4dzZqOXcTPd2Tv0LZD4GORbSoSUetT3X3o3A21UbYgElg/4Fl6BB
	 +aKgbgfDWu45LpcfvAxxpg0iLoiv1DJeJZZgWb0lKhl90J2/jm8jLnZlrvcap22eE96Cb
	 5etVLruGIPzl7jCMiMXxEzuzMN2a+7MM8oVm8StWab8KYfcnyzl3egsOUCujW8VWvC57O
	 VE4ju4rbnRKRZp5GbhAsaoUD1cyW51uWLz3wUfNsVMQ5yaqhg8MVLPDmLP59HXe3193zt
	 mIsnMaJLyGTgOu9qPYJkskv1AxnqATNL7IGKkOcXyLhA+Qjng2clmLlJ060AsSWl7lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2TTFJjHnti06NUGmTD6KUbzFb/CGLV1Wf7woUDyugx4=;
	b=bpFD6ZGUc4kbKgNbZtVkR9nWxpEUclTlc67D9rosIPj/9r8aM98YfGlUvt5yNYtKg72+
	 hkbnxALJgtYDEQLN8SbW1TJwoiLEwLYhSBkWZahFz2sD4eHr6XFbqSgwt/3W0Vr18e5DN
	 25JCwVv04L1BWw/XfDvDEMeN/hnzzrk1NI933Ae8cXnjnbT2C2ZloZ9PA9EkiGhkg0oq0
	 ig34ESHiteEv0G/8txPQQ7JR1uJnk/PJpvwVyEhdjBhJfCoLHIUNguw0Sq3CNvxOlMYIR
	 5Bn7mXPtIrJD75Y2wRKT2HW2ZODttdgXoQ4eeFoIS/DFcuKGZevBai/qZXY7Kx0bR8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=RPJW34SN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EEB606D802
	for <selinux@vger.kernel.org>; Thu,  5 Nov 2026 16:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94EEB606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=RPJW34SN
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb684859cbso193665a12.1
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2026 08:23:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793895799; cv=none;
        d=google.com; s=arc-20260327;
        b=h+1ZPrNpq9LKc6+kHsXgjMa9u8MP3ShCdPaCKSKTeU/Ri+0oH5DQQznWR8dPAxe3mM
         6Q8En9tZG6WGm6J2yug3NW28bk7cGPZErl3e/3wffLp1dOMdj1U6Pad33+DL6R+9kCMR
         /kw4ePXyX27lYQpxrxtZnFWggjlb7Gfx/YA3JgIDJRNYVZtC71h6crxUFGQaeH/jurra
         /KevgwB+sI479N4VHsJ6XTToD08wE74zGLRlHIYwKOImEKXqieShT7j7CtVGdKk116xo
         JieJVUDkOYV3+S88I4PZAKCjoW5lH1TmuHreh4/xAwDft21j+5zA6thcHqys62vebC1S
         4F0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2TTFJjHnti06NUGmTD6KUbzFb/CGLV1Wf7woUDyugx4=;
        fh=W9p/Z+ngMGqOF2kRSXAyL2hwFRWhOWBSk6rBFW8b0Kk=;
        b=k4UUXb6FNaXo66KV5Rw/6sUU2nxbsCsAcdjedKwX+HdLpipSNYbmG0ZCJi1VmhgfAe
         yFnL1mHoF7earq1zaLjHvOoXz4u4di2CrLBIAbNKt+OUwRVohzRuxCpSkKjEOrVtyday
         2zy2Y7vp4T+AhILLOjgv81pAtsahEYBlH+k6QRhPa1P3AvqY6H8TiiMsUYcfxfijdhym
         pKsUBHR55CVRIGwH27zUXVX8ejMCk5fRmq0komMrgTWHDuQyV450t9VKD2zpneHIl+Io
         CeSI8XeJKIwhSxWOdRC8rdtSOuaUyFF5nABhWtRtZ/LneIiTuWaSdaFK8Tsijuk+7khz
         hWVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793895799; x=1794500599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2TTFJjHnti06NUGmTD6KUbzFb/CGLV1Wf7woUDyugx4=;
        b=RPJW34SNYGj3EgChTRfAfFpjTHi0GJKCjUxVeYJNb7ntBQ0HXH3ZjJ0nlWFM4wsJc5
         HXZOozlc53fIAv8GXFXGGeIU5tPJOzrcQiw+RlSYJL685jyUN/A3JQvn9rzEjZVq1o9g
         X8RlTV9BRP2R029VFcoF8wFrGXDHFDa8073zWfVUGQjsr7E+9ITwuKjULq6a+Vsx8ita
         mui6xY7E/4l8fdxid5znOBUMphNDC9n2CVflzcWo6sIhlBYA63hjektTV5OvMVVZyKF+
         bsUBof1hrviKLuXPXGyA7E2F0viWu+EScJ23X3KOXNXJcBBCLVFey0jVOsU9MUoHPIqR
         DtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793895799; x=1794500599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TTFJjHnti06NUGmTD6KUbzFb/CGLV1Wf7woUDyugx4=;
        b=FXbi+SVKqb2H6lbffI7VNdcF9wNkFLxHsylaKfWLolC7mKjwC+ejfApG1sabM9MQIv
         3+WAxoi/XYUrzOlUMbBCHKXvqnoGi5dIEp6DM3OqtGgJUr/1eWBLJbe8GPFWQO8PqGvM
         sfcALcgtJi+/7iDw682Qxde5nw7uXgJ228ySkGzGF6h2X+SQ0AM2fhGTtUAFkjrP9KIq
         s4i7ACcCBsYocTl9ZFURZVoKajtnYP8mcwj6aafMRPZK1AUcMDuYZRYL4akMFJmbXDJo
         8kTksezN7I3bCKXDeXqoMFxlQOTwsoaWu+RAN/Ye5WxUBmQHHRVeTnVUL2wZGhNtDu5T
         Cukw==
X-Gm-Message-State: APuU4Z8OyGZR9GujX6zTMFYp82+vY0ZcdWA2nfr+n4QBtkp5qFgekwEc
	tja83/noXPpX3UaTaow+d5S8mLkFYBn+KwwHrKF+6o1fwwZdq1zaQqXV38T+5APhroU786nnRJs
	B2LoFhHCASr9k9z4HIIBHfRzB2HSuN3k9mwV8JxH7
X-Gm-Gg: AYBFou1Ut+e0j2VPvSPK9VjLAHIvOsG0ZO/Us7dT+C2Pz8Lb4E3ibtswFIamEfRtJjR
	bJvjUKFfJ7cxnn8tdCDbvIHMlHc51IHjFeIo2JT3tP305Md0MgTOgqdZ+gBQahbXILmMrXb6FZP
	EVnO4KnekQ3JDaAMOxCC1v6hrT6reCSX+BwyD8ONvf4naA4olPjge4QF4JCg+VaJU9uAgmYEgm4
	jFtN8qAYFWW7SY561oIwj0KxtlroGQB4refC2+Fm/jyR1y4Oes9nWDhMG0sBxabnEu65nmAAvWa
	Wx0Iex492Fff2LsRRBj3CBwD0mLi1UK0vZ3o4WmIRoLF2KtuDfBazIt6axE6ci4tzjVHSPfht/r
	RuC5r+txFNnRxibYtRIlt0d9fTegqo5S3iFq3hYu3WTi+oN6e3FOJpdzYUoIbwNFPn7rk
X-Received: by 2002:a17:90b:54cc:b0:3b0:ce1c:e754 with SMTP id
 98e67ed59e1d1-3b0ce1ce852mr905668a91.62.1793895798647; Thu, 05 Nov 2026
 08:23:18 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928154323.48910-2-stephen.smalley.work@gmail.com> <CAEjxPJ7fSVCf2y9f11YbMOzz9FwmcG8n0skqCFs4UTaQ-vtNBQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7fSVCf2y9f11YbMOzz9FwmcG8n0skqCFs4UTaQ-vtNBQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 11:23:05 -0500
X-Gm-Features: AclHuK8MXwxAeIx8EtOGklgiBevCQK_MnC1yPbW1VhvIlYhRojRu8icjKpaEjEo
Message-ID: <CAHC9VhQ-DH8wQ0h2QBRek=UgXcT8LPDMSkbdE7As-=D6QPTnyg@mail.gmail.com>
Subject: Re: [PATCH testsuite] Revert "tools/nfs.sh: comment out the
 fscontext= tests for now"
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 10:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Sep 28, 2026 at 11:43=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > This reverts commit 7738f9f68cedfe36ace71a15ae49ed3d9dd85b36. The
> > linked kernel patch below fixes the underlying kernel bug that
> > prevented us from successfully running this test.
> >
> > This change also updates the test scripts to skip a second Test
> > Invalid Mount test on NFS because since kernel commit ec1ade6a0448
> > ("nfs: account for selinux security context when deciding to share
> > superblock"), NFS allocates a fresh superblock when the security
> > options differ, so the "same sb, different settings" error this test
> > checks for is unreachable on NFS.
> >
> > Link: https://lore.kernel.org/selinux/20260928141917.17577-1-stephen.sm=
alley.work@gmail.com/
> > Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/91
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Is it ok to merge this and the other testsuite patch to re-enable all
> the NFS tests now that the fixes have gone upstream and marked for
> stable?

From my perspective I'm typically testing just the bleeding edge
stuff, e.g. the patches in selinux/dev or selinux/stable-<latest>, so
this is okay with me.  I think even for those testing older kernels it
should be easy enough to avoid this patch as the commit message
clearly explains the situation.

--=20
paul-moore.com
