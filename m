Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4E3905F0
	for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788021765; cv=pass; b=eXLsMRKpMbCiQMSIvIH2malGicM/eFMGB77jvFlOubGojwpT9CvwReWgo+rB/H5OefEt8unNOIz154dp/31+GlFd+9zpQsIpIGc39Ax2eXXiX9DIPYlgS6tuWlrWiazc+1bUlwOBUE1yDR/oi6Oznsz6atLnCsANsy22yEDUlUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788021765; c=relaxed/simple;
	bh=gVZFIq7E6DUEA7UcHTTV0g77Ncrm6ajPHymyOnK3Cyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE8rFNJHRhHKx1x/Fw98GJVb+NXjpocdFdUvgcovJoTTPWdXsLEfAGIsjagp4glh8te+wvguJ1VzQfQL8jvqbpcb4fXTlX0en2pD7LQAakMpxI7xJyvB2CHsSMzPnsCk5e+boqW2g5ceoS8x3cOtpTqj4iELFcFoSfqyzd+kUpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTetC3FY; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTetC3FY"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c25099bb1fbso275163466b.3
        for <selinux@vger.kernel.org>; Sat, 29 Aug 2026 09:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788021761; cv=none;
        d=google.com; s=arc-20260327;
        b=DDf58uidwP3yBS2ANGdWSuUZHPYZXj8nDTqMLh/cZ+MESpeA08lD0jDcwzEraFezSt
         zEuy+/MzCyERDIZw3Y37MVyNPNCewfi6AXhMnuLdp8i4XQTv2dkZw3cDWMi1prncr5YU
         BI3oSn4XwylKEsVGkrmJt+3sM1JiGRogWYAK3ApsimEzmxzqxYwEH5N+ENCXmvbDOy1T
         PmwkovvMqMmdiLvq7/jAz/JODHKflodQ2TI9zLCUYLpmMQ2R8OquC78QjrLl/gvLlbHK
         g+xe5lbtHIhKMW3Rdhqnoj4bIoIgzYNZcqxuWFyJ+xHrk/Sskh69G78oGfGqlru5wbo0
         ERIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        fh=jm52YYe7djN38N61XScJgWRZ+RT1haCXdT8EGCZ65HQ=;
        b=gXpy4mnP/7tPgwvxFCU1pK5Eq/UPdZLBVog35QUd4B25psBh4Hi91Qa2YM08ZSwtv2
         CAVIJeEgydbtnIJA96/Fw+OIq/yU/t2xB7eegts/IdQjEpUgFrreuJftYDFNglYw4ahB
         uZJQDFNsUGWD6rIlekH0P2weVCZRl2bN/09HkPrVnbsdiHiBAysYRToxgTa/0MW4kwJZ
         IFPoPEjrOy1witC+Q3dQQEKmVj2WS8qc94165Fkj5FEwJygK9nxNIFbUYu6kC7tnRqJG
         /6wMJTak37xKbIxFQv5+XXlibobqDh5swivYZBMznh+AqhdlNsga+CdVYc8wo3CYTxIa
         GSpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788021761; x=1788626561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        b=OTetC3FY9YR2dT91pmq0tWTCBVQw98A+ro76zO0jrdRuA8IZtsnSh7UkqJxyoJsput
         QYkwqUcp//atCTeq9nNabFfVtR3cltA4BnJlSN/uar5m/kgT+3MEs42eO0e02wospduc
         rd7a0zJaN5uoUP6GJRavB4PZ8F3hyZZHH4PEbtX9YmOgSbCfGFN/PElptV+PHQz0J9vf
         Bkx0xSdvVwNswH+ipIw1CNfsIk4PAx0dQAqh41NWWhrjuJmVCLhS+IToYESJMrG28Xbz
         dtUzdafCWjb87kTs+7MK86BNNaSyY3rkhvgNFqCPfd9b+Pbk5DgfsG4pW4torbn/l2sa
         A84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788021761; x=1788626561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDbJApH470Nb27U1ofVrGiRQ548vKaC8I4YjQ8kLrVI=;
        b=U8nXliAbTFxaoZtpV5O/NzkfMlFth7K2KvJ5Qjs4GUN7zz7BhiEULNo8OR+qnIv2uy
         9JQJmWdM+Gl3elHbLB5GX4eMq8VJTnU/gPghUzU9spFuEu/5mVve0V/md31N/dA6yjFA
         HrC4tib66pzVoQUWhoszumZhoo9SK6LBy3dNuTHxIxjtvawKPq20Usv3hizd3+Ps7JXL
         NzLAtB11j92IQkLt1Zb4RsR2GizETHw7fOQRAXlTR6niTwJh0B9VCOqoUTErlkspy3zh
         gnywbc7bxQWBAceqcAcHZn3j03T8ARYvXArr2PNyAMHWOMCLr9YuXsM/nxp+tIA2nzz1
         dYHw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4MuUEzl/hMlpL5v5Qx+448grqNMgGZvgGze6HXRiDNbXidYkiFnZ7gkJLg9ftmFvVxslzUvfs@vger.kernel.org
X-Gm-Message-State: AFuF++mP8NhjV8WylDnS7m1j9xarKEkGIja4r15w1Z+ZRAZdJ4nChGUw
	a3/bdHaaLChGxAC0aX4/bl/D/wWk2cg0k7TaiOg0blw8M069sI3q+tK34lts2FBqfWNT1uzsf/b
	zQiLRVFl+u7cgW8yQipukJow8xklp+XU=
X-Gm-Gg: AR+sD114el8bgD+tq4uw/K3Ieg8nExh5K0EGe6TIL3YPC/crydB5R4Gwe+xjTLIArqw
	MbqCp0e510Ihzn4IJL8i97xIL3bKHou1jFP6ZeIt/4EEInZuw/bXWghE2xfHBM2YOO46jVOP1/v
	heFl6UVRPqnil2a982+7M0IVuN/xIUNT131p/q8D9rvbC257fkMrUR+bkSYvtiPD2hsK7XjGgeq
	ZxDrxJd920IwcQGNbQChNawXV/Y4ujjoI+8L+a1/cBbnTGntsbnkVM3Kj5K38cVIaEiIlcZp3yB
	rI9WwNf5fmicn43pqMZhRDEnhM/zdbq9Wsj50NK5A0GT5A==
X-Received: by 2002:a17:907:3ccc:b0:c15:f26a:3438 with SMTP id
 a640c23a62f3a-c255741f461mr1048868466b.24.1788021760941; Sat, 29 Aug 2026
 09:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820175832.44512-1-kmehltretter@gmail.com>
 <5fa5ef078f41cd57d0e52ab2ab023094@paul-moore.com> <CAOQ4uxjn3sWjkrV8KbA-V+eno3E4OskTnCznNBex6FOstEbJ-A@mail.gmail.com>
 <CAHC9VhQ5oQWL7bj745U5UzSWm2OfyKMjHVeaEYXZvzO0Em0iZA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5oQWL7bj745U5UzSWm2OfyKMjHVeaEYXZvzO0Em0iZA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 29 Aug 2026 18:42:28 +0200
X-Gm-Features: AcwNN1VZx95EdI2tjlNCAWiVqqkY5zejH9GYUNhl8FvdsMNeGPTwmtuy5Ph3m7k
Message-ID: <CAOQ4uxioiwVPntt1=QeXXftehoPPb5LFZHuctfJzkNJzrNq9Ng@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: preserve user SID across nested backing files
To: Paul Moore <paul@paul-moore.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, selinux@vger.kernel.org, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 12:05=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Fri, Aug 28, 2026 at 5:05=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> > On Thu, Aug 27, 2026 at 9:39=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Aug 20, 2026 Karl Mehltretter <kmehltretter@gmail.com> wrote:
>
> ...
>
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 1ead2eee1944..171b90412ff1 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -3843,13 +3843,20 @@ static int selinux_file_alloc_security(stru=
ct file *file)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static inline u32 selinux_file_user_sid(const struct file *file)
> > > > +{
> > > > +     if (unlikely(file->f_mode & FMODE_BACKING))
> > > > +             return selinux_backing_file(file)->uf_sid;
> > > > +     return selinux_file(file)->sid;
> > > > +}
> > >
> > > I'm a little concerned that this only works for one additional level =
of
> > > filesystem stacking.  Yes, I know that OVL_MAX_NESTING and
> > > FILESYSTEM_MAX_STACK_DEPTH are currently set at "2", but it's not an
> > > unreasonable concern that at some point in the future that number wil=
l
> > > increase without proper notification or testing and we will once agai=
n
> > > have a problem.
> > >
> > > At the absolute minimum we should have a BUILD_BUG_ON() for the stack=
ing
> > > depth.  It would be good if we could watch both the overlayfs and vfs
> > > constants, but the overlayfs constant isn't available outside
> > > fs/overlayfs/inode.c (thankfully it is currently set to the vfs limit=
).
> > >
> > >   BUIILD_BUG_ON(FILESYSTEM_MAX_STACK_DEPTH > 2);
> > >
> > > Ideally, the code would be written to keep diving down the stack unti=
l
> > > it hit the true backing file.  No one likes to see recursion, but at =
the
> > > point where this function is called there should already be a reasona=
ble
> > > bound on the stacking depth and the work involved.
> >
> > Unless I am missing something, stack depth should not matter.
> > file_user_path() should hold the user visible path, for all the backing=
 files
> > in all the depths of the backing files stack.
> >
> > This is the issue that was fixed with commit
> > f2381b546e7e6 fs: fix user path of nested backing files
> >
> > This patch makes uf_sid behave the same way and also documents this:
> >
> > struct backing_file_security_struct {
> > -       u32 uf_sid; /* associated user file fsec->sid */
> > +       u32 uf_sid; /* top-level user file fsec->sid */
> >  };
>
> Perhaps I'm not understanding your comment correctly (it's the end of
> a long week), but selinux_backing_file_alloc() and the newly created
> selinux_file_user_sid() functions don't operate on the
> file_user_path() path struct.  In fact the path which is resolved in
> backing_file_open() isn't even passed into the
> security_backing_file_alloc() LSM hook.

Right.
But the file that is passed into the hook has the top-level uf_sid
in selinux_file_user_sid().

>
> Are you trying to explain that the way the backing files are allocated
> in a stacked filesystem, regardless of the number of layers, is that
> they will be allocated from the top down in such a way that the uf_sid
> will trickle down to the bottommost backing file?

Yes, both selinux_file_user_sid() and file_user_path() should follow
the same pattern independently - they always stash the top-most user visibl=
e
path/creds.

Thanks,
Amir.
