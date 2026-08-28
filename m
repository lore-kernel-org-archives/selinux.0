Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C6392803
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954721; cv=pass; b=DKr+f5iAPpbfEXYuXatY04cbxrciyzwyF+VvmHkEPPJoTn72gA5WmEZv1FUQOsKq71cf6SGhUcjFIA6+tNoSs1ejN+tDEqa89lJ0OwznmnEXiKqHalzAFfEZwaszBY/aZvH5dOzGeVvlcwkMP21YCvwJGo0AJ3JdDCUvrVFp3b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954721; c=relaxed/simple;
	bh=ywb1KJ1Y2s6u3tEahxyzMtIqPZn9+T2wYc+dlk5oD7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Br2iBVPT/DMoailmdYipf2U5YM4ro3EGEjUXu5QM0bPKyeDAp/7QElOliMBHDRiaeTRhJOsIjhu31wl2m9EPHZ4p4TuId2oVUK7TEDr0qxUGQa2ZWL+0MUmv7R2t4HJwVZeN6dM3o5ynDZeyDtnTdLY8qNFfTf1BYtPV6/3SdFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PX+Q3V/7; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PX+Q3V/7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-853c947bfefso1290403b3a.0
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 15:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787954719; cv=none;
        d=google.com; s=arc-20260327;
        b=cn/56MzbzD3J2HsPF4dXrdxUbfJkGPPMGBgz/cf2NyGAzB0iP+uw5LNBrSBrxRo9+P
         yqI+nr2yUWLeZlXUDNj2jj3q12PuSFmRsu7p6sBFF+Bg/xJEEhe2MEU0y9/4tvLeUKw4
         BHPcpVr71/TUx7i2nKlnNXefHay1fDSYGNAmJZ/3IDbhGy1J21kOWMzAH0OSq6wzAwi5
         nqA7gCany+HfecGr4fGLR/qsnYDmOF1tINujfYD8a7uvJLccqzhnWgy8jXyS3SLOqY92
         n8WFlgiTPErnF4IF4nEjcGMRp9yte5McmaQIEMxUKwyfO/eMmItbXyrs501+OQUaOnYf
         qdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4JU/PBBK6zKmaR3Ao9o2l7RAKkP3IvAVlF4SOyruE94=;
        fh=MNz+zMIUT0J3X2uIptAYUiLMAGuVZ4WSvICJQnOnSV8=;
        b=gPt1iOAn77pz0FRoGaT2H4+BZavRaH8vlT480wuEtPWiFiZLJQ+TeFkuuDSgQZpw0L
         3oTvtMoJlOd3qKWKblnaPSmc3GL7KAQ1rvt5JJNPxdsP/C8Fo+MsciZ9d1qzkdMiysDV
         gR4fomWSeLkbuXSNpvs00fJLDi0Jcp8GTyWPuywLB0THNcFNBA6gYNnLiFnvP1Uqi8Mc
         2UJqSTsrpLYjiSdoDgGhcKzGtRU7U4JbwP+Qyo7R6l7inpkh6pq9pzkmpJj1CPRWsd2S
         vePy1IwaTf5oncCNgRM9jRy9QHd4W3v3xL/CT8ROaUeTA3vWAk+eoDv3yj3IC9qhvRO7
         QeJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787954719; x=1788559519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4JU/PBBK6zKmaR3Ao9o2l7RAKkP3IvAVlF4SOyruE94=;
        b=PX+Q3V/7J+jTHe5kPXf0pCwDFcvh8oFYK8FD46DS9WljLL9w5lQtDNbO+dYEv/MlCn
         VYHR/+0xTCOePqIiCP0K/ubFqheBkfHe3LFHFgF3MEQkSdooG0OCjmPVtBlPNpXFfiq1
         J496SkaZt3AOalbUBTgLysrVqZM/W9jftrOHy658bqwx2X0izBS1fBWlU/eSx9enPQnW
         mtz/eooPLcSgm1GV9qBNoFKcuMRVOiZmLxfbahNmX889zGT6s6LOvWDPceNiFXW716rN
         UcDyFd2RDL4x3R0QrOqNQQf/G2X6Ftcelx3lY+HQzwY1BEX2v/1y5k70Qru+oLYSh2cs
         G9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787954719; x=1788559519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JU/PBBK6zKmaR3Ao9o2l7RAKkP3IvAVlF4SOyruE94=;
        b=nYP9XRIYwLf0pg7Ca7HznFfPURk+Mi/PPSnSMy6eS7mlLXcjAcRpF1qI7jbJim6VDW
         jIi9aWxNpVNeCEN1Xmdf5DmLMKagAPRYUf9DUgA1DFPrvPDeHFpr+t1+eEN6QcYPnjs1
         C+h1YkhQ1azKdPwKPgZel0L4+e2Vd+d5Jiin0ZVulXyxskpfGvQAbGW0Q6Obc2WCwA9p
         TyIYLK0RoDRRINYgZT6/SivvXui8sblzTb4S+mwXTSDSODfSRk5gvrtgf2DhrSZOJgno
         W5Yekj/2YpeH7DDPLBew/vt+KiEJiySaKbhN46QeSd46A2p3+2HnSRyTwNOAhW7mHl4G
         lwZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUMkkcErRR7l9yET29NvD4w9lMn6DwoGivj177VHs8h87s9OoS7Om3spCWoX2BEE4tQJCm8Sxs@vger.kernel.org
X-Gm-Message-State: AFuF++mvCtimxFiFXGtYbH/NknPo9nPZmXasxG0W9v5RJmG63Axd0iiP
	JnK33fDPto9Y1MRK7gAkJ1NP7rQdzWeNrhEMFEu1u8MwNurnfbvcdDDPlTuJAB4F6XuE4oSR+Cm
	BIhKdk81fl1oKaYxeLWay5M6g2isU7NY3Qr/uEzy3VusCVgePrBNi8E7B
X-Gm-Gg: AR+sD11tB/z1Bg9PCNyq5l3sW1W2kn45PeVZnv2atHSOEVjEL+Ca3mAjToN84zOaf5U
	uf6oenNcNU4GxGmGgAH8L2qXRb5hOdH/sEsKutpviBpl5cdDPDut+MlhF+4dUPEM0OwFgCgyzK4
	8SRjhVVtUTUPRZfjuS2d0FP9Ss3EyjOSjls3Wg5y0pBx0V56BEDODU5fr7VV7aDBi195rxxwGey
	v6n0Do77xENmz+YDqjluIsTtcRpgmOfMRnkJdKtMtQP7HEySkAE8Qsi18/Hr4QQVWI7X8SQzG7T
	Rb9mXSeJmwqsypkS3EGvyq0DyE4Gx6Ni8Qpj5+Nb7nD6
X-Received: by 2002:a05:6a00:8012:b0:84e:242:4bb2 with SMTP id
 d2e1a72fcca58-8576e187183mr2599254b3a.4.1787954718985; Fri, 28 Aug 2026
 15:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820175832.44512-1-kmehltretter@gmail.com>
 <5fa5ef078f41cd57d0e52ab2ab023094@paul-moore.com> <CAOQ4uxjn3sWjkrV8KbA-V+eno3E4OskTnCznNBex6FOstEbJ-A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjn3sWjkrV8KbA-V+eno3E4OskTnCznNBex6FOstEbJ-A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Aug 2026 18:05:06 -0400
X-Gm-Features: AcwNN1XzAxZAeZ9YbWbmD6gATJOUq2kxB8OX1cUcN_SgCoVZnhreW3OY7Y6Acvs
Message-ID: <CAHC9VhQ5oQWL7bj745U5UzSWm2OfyKMjHVeaEYXZvzO0Em0iZA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing files
To: Amir Goldstein <amir73il@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 5:05=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Thu, Aug 27, 2026 at 9:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Aug 20, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:

...

> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 1ead2eee1944..171b90412ff1 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(struct=
 file *file)
> > >       return 0;
> > >  }
> > >
> > > +static inline u32 selinux_file_user_sid(const struct file *file)
> > > +{
> > > +     if (unlikely(file->f_mode & FMODE_BACKING))
> > > +             return selinux_backing_file(file)->uf_sid;
> > > +     return selinux_file(file)->sid;
> > > +}
> >
> > I'm a little concerned that this only works for one additional level of
> > filesystem stacking.  Yes, I know that OVL_MAX_NESTING and
> > FILESYSTEM_MAX_STACK_DEPTH are currently set at "2", but it's not an
> > unreasonable concern that at some point in the future that number will
> > increase without proper notification or testing and we will once again
> > have a problem.
> >
> > At the absolute minimum we should have a BUILD_BUG_ON() for the stackin=
g
> > depth.  It would be good if we could watch both the overlayfs and vfs
> > constants, but the overlayfs constant isn't available outside
> > fs/overlayfs/inode.c (thankfully it is currently set to the vfs limit).
> >
> >   BUIILD_BUG_ON(FILESYSTEM_MAX_STACK_DEPTH > 2);
> >
> > Ideally, the code would be written to keep diving down the stack until
> > it hit the true backing file.  No one likes to see recursion, but at th=
e
> > point where this function is called there should already be a reasonabl=
e
> > bound on the stacking depth and the work involved.
>
> Unless I am missing something, stack depth should not matter.
> file_user_path() should hold the user visible path, for all the backing f=
iles
> in all the depths of the backing files stack.
>
> This is the issue that was fixed with commit
> f2381b546e7e6 fs: fix user path of nested backing files
>
> This patch makes uf_sid behave the same way and also documents this:
>
> struct backing_file_security_struct {
> -       u32 uf_sid; /* associated user file fsec->sid */
> +       u32 uf_sid; /* top-level user file fsec->sid */
>  };

Perhaps I'm not understanding your comment correctly (it's the end of
a long week), but selinux_backing_file_alloc() and the newly created
selinux_file_user_sid() functions don't operate on the
file_user_path() path struct.  In fact the path which is resolved in
backing_file_open() isn't even passed into the
security_backing_file_alloc() LSM hook.

Are you trying to explain that the way the backing files are allocated
in a stacked filesystem, regardless of the number of layers, is that
they will be allocated from the top down in such a way that the uf_sid
will trickle down to the bottommost backing file?

--=20
paul-moore.com
