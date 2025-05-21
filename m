Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B44237713
	for <selinux@vger.kernel.org>; Wed, 21 May 2025 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817325; cv=none; b=Sv7DJj+Lw0hvSnJAkUZ5gBCJHY2EdZf7FHMD0T7M4zVRANx0ScSsBXreIJvUlk7INp2FHiYL/1nxPDqe4858giGbOD78yEmA+l570qaiZlcTDC4kKmfDMzEi7+ai3+iwOzDjZeMgrl4ExgX0MLM6nPns7QpMqpZa1zC8W0jy/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817325; c=relaxed/simple;
	bh=oks16V55Al3cIwa3tzMhKIQg+6JISq/7X+SJWpAWNGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyGu0iFMkUy3Jtg9ZrlEwsJby0o2eNOcIzgvZi3iBzV2OuzgkJlDiUTVYwRjeiLPOZwTqW/aKieMYG+/hiYxMohp8qEDyfGm5NLu7ZCqXHnRdwu+cczxNjS0zKprNgvoHQCVjDsSOT1QVgHUgJP4ERD3dXbLUGvQE7DFfBZcUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RI8mkj+S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RI8mkj+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747817322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBrTKYMZkRkR/+obIFDmt3FxVCfGaAspFXfSUz2lNvE=;
	b=RI8mkj+SS49vSOxzhHWQYBoO/VxdWCxWEPhFW/3bhoW9IakoXkLPED7RqN4XXJcRItZzon
	W7uWh+7UeK4dfVAVORk9uPWvfTeVRvEAeqNCuDm3lwk3M4UzPqWLfRkQkM0yEbWaXVwQpi
	BsyoCNqpmMGlXHZWoo8GUDN6IfafTkk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-TZ2rQbGTOjOEnSEirOkWZw-1; Wed, 21 May 2025 04:48:41 -0400
X-MC-Unique: TZ2rQbGTOjOEnSEirOkWZw-1
X-Mimecast-MFC-AGG-ID: TZ2rQbGTOjOEnSEirOkWZw_1747817320
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad56437a03eso273421966b.0
        for <selinux@vger.kernel.org>; Wed, 21 May 2025 01:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747817320; x=1748422120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBrTKYMZkRkR/+obIFDmt3FxVCfGaAspFXfSUz2lNvE=;
        b=ShYy+TdG3dwhFLaqanPGZc+R61pUSam5TK1lLpC/7odj9w7bMIyWS4rmMcl7Rkaygz
         hZu3l2q6N+zL2+tr4ESXRYFvdnsm01PReaFsyZgZoaGfj+37axeBiIM5n28u2+3/ov/t
         YOfjUNSU/gns3ssEPRRJC++jEGwkDL3B9PjN+2eu1LBB49RQS71pX6/4rhQoDin5TAk3
         lHN9+XgeCf3zmxeA8hCjP8lnTlS8CWRfzdrHYeyqOmjZ+Nc5vn44x7RMFy5/RfR9JpQi
         GaSqOpzkqcXlMQD/GC/L89rf8NynNlv4J9oE8OJuYHiNfVW3WNvYnZ3f9qCAiSRgFhmP
         md4A==
X-Forwarded-Encrypted: i=1; AJvYcCU0+0knaYBD2yw1FMrRWnAAvXFl4euFh3+x6nniznjm++NZOE+POsUbJScYQh/j4upGbBh0fiq7@vger.kernel.org
X-Gm-Message-State: AOJu0YxayTwF3wrcgipbWQHMBHvH9RsciZl6442nZKhKzWj/90raI1IK
	2pJDxEml8K2foA6BwQys3M6NnZ8eieBwAQ2SF2+ScBSpU9af+MDqqs4PIaaH4x/dDRLQXRYOjbI
	9AOG0/sQ7jt15QOaAOVf+6pvJVkq84QARfzVZgEGiAeMHHGYC/WXSCk4j+w==
X-Gm-Gg: ASbGncuFLgCOihZV6MPMBiBYkk4xNVxg3vzzULfUzGJpSVWgTGV0+iS7Tzs4+v4FzBM
	4OAzWz7F3j+b+F3PLOAgpUmFbA7jpuXi3q4TH7f/Q2CfIXilXRXgVTuYnkG7RUIhgTW4OZFU8KK
	ER+46G0n/blkdLMeiXo5dYutoVVyKpJMoBtM+7IE33T4Xqco4lHxlHPCRp+goi5Ba8L4PxQ8rBO
	ba0Bf4CFlyjeRsAcBpghA2ztt5J/c5mUxypHq19qcIhkE3+a44jTDHjQ1+XJwmbfAnvDBeEGZgK
	dw==
X-Received: by 2002:a17:907:96a1:b0:ad4:cfbd:efd0 with SMTP id a640c23a62f3a-ad536c1a813mr1851017766b.36.1747817319632;
        Wed, 21 May 2025 01:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Uad4LLY/qbicMx/bjSP1amiyVw6y5+cI+R+l9yVSKq3rctv7sT91m06PC9V35nY4DdIi0w==
X-Received: by 2002:a17:907:96a1:b0:ad4:cfbd:efd0 with SMTP id a640c23a62f3a-ad536c1a813mr1851012766b.36.1747817319102;
        Wed, 21 May 2025 01:48:39 -0700 (PDT)
Received: from thinky ([2a0e:fd87:a051:1:d224:1f1f:6cfc:763a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad5505131f7sm659880666b.67.2025.05.21.01.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 01:48:38 -0700 (PDT)
Date: Wed, 21 May 2025 10:48:26 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, selinux@vger.kernel.org, ecryptfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 0/7] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <sfmrojifgnrpeilqxtixyqrdjj5uvvpbvirxmlju5yce7z72vi@ondnx7qbie4y>
References: <20250513-xattrat-syscall-v5-0-22bb9c6c767f@kernel.org>
 <399fdabb-74d3-4dd6-9eee-7884a986dab1@app.fastmail.com>
 <20250515-bedarf-absagen-464773be3e72@brauner>
 <CAOQ4uxicuEkOas2UR4mqfus9Q2RAeKKYTwbE2XrkcE_zp8oScQ@mail.gmail.com>
 <aCsX4LTpAnGfFjHg@dread.disaster.area>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCsX4LTpAnGfFjHg@dread.disaster.area>

On 2025-05-19 21:37:04, Dave Chinner wrote:
> On Thu, May 15, 2025 at 12:33:31PM +0200, Amir Goldstein wrote:
> > On Thu, May 15, 2025 at 11:02 AM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, May 13, 2025 at 11:53:23AM +0200, Arnd Bergmann wrote:
> > > > On Tue, May 13, 2025, at 11:17, Andrey Albershteyn wrote:
> > > >
> > > > >
> > > > >     long syscall(SYS_file_getattr, int dirfd, const char *pathname,
> > > > >             struct fsxattr *fsx, size_t size, unsigned int at_flags);
> > > > >     long syscall(SYS_file_setattr, int dirfd, const char *pathname,
> > > > >             struct fsxattr *fsx, size_t size, unsigned int at_flags);
> > > >
> > > > I don't think we can have both the "struct fsxattr" from the uapi
> > > > headers, and a variable size as an additional argument. I would
> > > > still prefer not having the extensible structure at all and just
> > >
> > > We're not going to add new interfaces that are fixed size unless for the
> > > very basic cases. I don't care if we're doing that somewhere else in the
> > > kernel but we're not doing that for vfs apis.
> > >
> > > > use fsxattr, but if you want to make it extensible in this way,
> > > > it should use a different structure (name). Otherwise adding
> > > > fields after fsx_pad[] would break the ioctl interface.
> > >
> > > Would that really be a problem? Just along the syscall simply add
> > > something like:
> > >
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index c91fd2b46a77..d3943805c4be 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -868,12 +868,6 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> > >         case FS_IOC_SETFLAGS:
> > >                 return ioctl_setflags(filp, argp);
> > >
> > > -       case FS_IOC_FSGETXATTR:
> > > -               return ioctl_fsgetxattr(filp, argp);
> > > -
> > > -       case FS_IOC_FSSETXATTR:
> > > -               return ioctl_fssetxattr(filp, argp);
> > > -
> > >         case FS_IOC_GETFSUUID:
> > >                 return ioctl_getfsuuid(filp, argp);
> > >
> > > @@ -886,6 +880,20 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
> > >                 break;
> > >         }
> > >
> > > +       switch (_IOC_NR(cmd)) {
> > > +       case _IOC_NR(FS_IOC_FSGETXATTR):
> > > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_FSGETXATTR)))
> > > +                       return SOMETHING_SOMETHING;
> > > +               /* Only handle original size. */
> > > +               return ioctl_fsgetxattr(filp, argp);
> > > +
> > > +       case _IOC_NR(FFS_IOC_FSSETXATTR):
> > > +               if (WARN_ON_ONCE(_IOC_TYPE(cmd) != _IOC_TYPE(FFS_IOC_FSSETXATTR)))
> > > +                       return SOMETHING_SOMETHING;
> > > +               /* Only handle original size. */
> > > +               return ioctl_fssetxattr(filp, argp);
> > > +       }
> > > +
> > 
> > I think what Arnd means is that we will not be able to change struct
> > sfxattr in uapi
> > going forward, because we are not going to deprecate the ioctls and
> 
> There's no need to deprecate anything to rev an ioctl API.  We have
> had to solve this "changing struct size" problem previously in XFS
> ioctls. See XFS_IOC_FSGEOMETRY and the older XFS_IOC_FSGEOMETRY_V4
> and XFS_IOC_FSGEOMETRY_V1 versions of the API/ABI.
> 
> If we need to increase the structure size, we can rename the existing
> ioctl and struct to fix the version in the API, then use the
> original name for the new ioctl and structure definition.
> 
> The only thing we have to make sure of is that the old and new
> structures have exactly the same overlapping structure. i.e.
> extension must always be done by appending new varibles, they can't
> be put in the middle of the structure.
> 
> This way applications being rebuild will pick up the new definition
> automatically when the system asserts that it is suppored, whilst
> existing binaries will always still be supported by the kernel.
> 
> If the application wants/needs to support all possible kernels, then
> if XFS_IOC_FSGEOMETRY is not supported, call XFS_IOC_FSGEOMETRY_V4,
> and if that fails (only on really old irix!) or you only need
> something in that original subset, call XFS_IOC_FSGEOMETRY_V1 which
> will always succeed....
> 
> > Should we will need to depart from this struct definition and we might
> > as well do it for the initial release of the syscall rather than later on, e.g.:
> > 
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -148,6 +148,17 @@ struct fsxattr {
> >         unsigned char   fsx_pad[8];
> >  };
> > 
> > +/*
> > + * Variable size structure for file_[sg]et_attr().
> > + */
> > +struct fsx_fileattr {
> > +       __u32           fsx_xflags;     /* xflags field value (get/set) */
> > +       __u32           fsx_extsize;    /* extsize field value (get/set)*/
> > +       __u32           fsx_nextents;   /* nextents field value (get)   */
> > +       __u32           fsx_projid;     /* project identifier (get/set) */
> > +       __u32           fsx_cowextsize; /* CoW extsize field value (get/set)*/
> > +};
> > +
> > +#define FSXATTR_SIZE_VER0 20
> > +#define FSXATTR_SIZE_LATEST FSXATTR_SIZE_VER0
> 
> If all the structures overlap the same, all that is needed in the
> code is to define the structure size that should be copied in and
> parsed. i.e:
> 
> 	case FSXATTR..._V1:
> 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v1));
> 	case FSXATTR..._V2:
> 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr_v2));
> 	case FSXATTR...:
> 		return ioctl_fsxattr...(args, sizeof(fsx_fileattr));
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

So, looks like there's at least two solutions to this concern.
Considering also that we have a bit of space in fsxattr,
'fsx_pad[8]', I think it's fine to stick with the current fsxattr
for now.

-- 
- Andrey

