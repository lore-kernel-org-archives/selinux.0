Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747E1F8755
	for <selinux@vger.kernel.org>; Mon,  7 Jul 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891227; cv=none; b=fD81dKXxJF84somULFP3lS8JFzg47vcRX8P6n9bpeyDbNuM7Ie7lamaV64ZcLKAKAXh81O6R46HDMbXE1Mr3yfNbw5L1w8UHIB4nOIxrhbhLTATT95VcjmkKMC1wVdwFTeohHD1bBq5TWGc22qIuCtRSBaGATBe/DnmLV3Lpx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891227; c=relaxed/simple;
	bh=N6aIrao9mvKWLRzYYG6kmQNDgyAReKkf4PPJ58kKg+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovwRE1WGkonIVN2xMim/tfiYEE71X/o7coy3+DTWkoBGZ+t/bcO3pIDmJNWeONxhWK0EkE0YzRo/bepK+mGY5Ij4Z3E4YJCyX/0CszR3WxU/UUBRM4YSxIjoKmzDu3Pa+12aFdAqW9PZdlDpAKKGsXVPgrnecwrKiZicZ94vBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWdqClbn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWdqClbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751891225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHTeRzC+GAtalyuC61VSTswPDreUYA10fT25p2FdvD8=;
	b=VWdqClbnL5DTDavf/VC57iQRyvqmO2pg5i3vlePnJpc9nApNQqLQh10DW4t+IVA/voyP/A
	yzzWSuHMgADlmqb+8MEsC2abMSWAZ60RvOmLpTQ3hUzIwWpOhrXDpCaViwV8SLxNvgmTOC
	7Ox+UeoxL87V3z1NImCDxWlSgSmv7O8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-_-vPRSkjMgCHsj08ZDgjYg-1; Mon, 07 Jul 2025 08:27:03 -0400
X-MC-Unique: _-vPRSkjMgCHsj08ZDgjYg-1
X-Mimecast-MFC-AGG-ID: _-vPRSkjMgCHsj08ZDgjYg_1751891223
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae0cd07eeb2so267204566b.3
        for <selinux@vger.kernel.org>; Mon, 07 Jul 2025 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751891222; x=1752496022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHTeRzC+GAtalyuC61VSTswPDreUYA10fT25p2FdvD8=;
        b=GWhm58Y2kzudJXhbF9kjGQlKJ9sR7r1su5sV0Q6//RAEHSXL0DsR8R2ON8NEdfEHka
         peONUyHEM5qbU16mnK3DzXI4a5IHRe04whhpjcp3z9ziPs9qu+ZEe0hBzFS+7NUIWdbv
         ZcaoaPo+Tk3u6ZEcf4ybXNXtLlYA1e6NUcoq8qLpxqWajch2vUfKOfNXCim1afxCRhI5
         jvRqXgRYdNq/ncCDCTead3lDQDAPy9JVfzbKwXvKS5TkET4c3tlhoaED/RUvOD3d5z/T
         Co3THo/IpnFKvM+OxEDrNEQvN53ng3xHVfXziA5gx6W82do+9iphj8124X/M9HswnJIW
         +ePA==
X-Forwarded-Encrypted: i=1; AJvYcCWCK3MereqcAnCx/yuvie0uri6x2NmI2JYg8QA/nZ5mx3L0PCzTeRZj/AVJs80hpO4zn0lfCRzI@vger.kernel.org
X-Gm-Message-State: AOJu0YznxXUX0G15M1qnRxTwtx6DR2mFpRpUhILr5GpAk38E+JYMqrls
	/O9TsKliGXw+PyZ+p2hwp0lYRz6zOom4LczsCcfUcWO3pQJRunrHk4VAMRwfZKq987U3991j9LO
	6Mo59QvloLJRzcAibC+/CeFEbzOW4zcKU1L57H0Em9mKLOKScsr0Y9tw2ww==
X-Gm-Gg: ASbGncteW0xJAJUhSDXYh/FNWR1K9N8JfFHRrKeuFeRauzvRUWha+4/ZSjyYF0A04sI
	AvgASjJxvK9fn6qJHyLTOd4TtK6yoIRLTnShq1rlWP9AZMq4Ut237CeCkuVadTl3w/gL1NViR6g
	E3Z8sWqdKw/w7jGiVPdoAtez+E5FzNhWrFlpsLdn7jOXs2mX4Mtx846N034IrN3i5LatJlD9R/A
	e24T/Ul8E2JHRWb10NRUrtK7U3pU30h2URErf1lwiRnW1yKsXXmkhU4JmMcbcpd8rkDPvI7HjL/
	/D18s2aFK86LB1VAfqiQoEoEgutq0C4ainOnGsG1JA==
X-Received: by 2002:a17:907:1b1c:b0:ae0:d903:2bc1 with SMTP id a640c23a62f3a-ae3fbe32085mr1269373366b.49.1751891222545;
        Mon, 07 Jul 2025 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+xNnEev9UxKSf7lcc6f2ZhivCo6t8UkYaBDX83sSiieaUIILsbAVwreWk30jTRbKc3uqazw==
X-Received: by 2002:a17:907:1b1c:b0:ae0:d903:2bc1 with SMTP id a640c23a62f3a-ae3fbe32085mr1269369466b.49.1751891222070;
        Mon, 07 Jul 2025 05:27:02 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d9263sm700724366b.32.2025.07.07.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 05:27:01 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:27:00 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <rckjqvax4ciazuasmpiiflk6qgwnkfrcamw6xae4mvtofo3yxk@jj25of6o5ye2>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250701-quittung-garnieren-ceaf58dcb762@brauner>
 <uzx3pdg2hz44n7qej5rlxejdmb25jny6tbv43as7dos4dit5nv@fyyvminolae6>
 <20250707-alben-kaffee-da62c14bb5c3@brauner>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-alben-kaffee-da62c14bb5c3@brauner>

On 2025-07-07 14:19:25, Christian Brauner wrote:
> On Mon, Jul 07, 2025 at 02:05:10PM +0200, Andrey Albershteyn wrote:
> > On 2025-07-01 14:29:42, Christian Brauner wrote:
> > > On Mon, Jun 30, 2025 at 06:20:10PM +0200, Andrey Albershteyn wrote:
> > > > This patchset introduced two new syscalls file_getattr() and
> > > > file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> > > > except they use *at() semantics. Therefore, there's no need to open the
> > > > file to get a fd.
> > > > 
> > > > These syscalls allow userspace to set filesystem inode attributes on
> > > > special files. One of the usage examples is XFS quota projects.
> > > > 
> > > > XFS has project quotas which could be attached to a directory. All
> > > > new inodes in these directories inherit project ID set on parent
> > > > directory.
> > > > 
> > > > The project is created from userspace by opening and calling
> > > > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > > > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > > > with empty project ID. Those inodes then are not shown in the quota
> > > > accounting but still exist in the directory. This is not critical but in
> > > > the case when special files are created in the directory with already
> > > > existing project quota, these new inodes inherit extended attributes.
> > > > This creates a mix of special files with and without attributes.
> > > > Moreover, special files with attributes don't have a possibility to
> > > > become clear or change the attributes. This, in turn, prevents userspace
> > > > from re-creating quota project on these existing files.
> > > 
> > > Only small nits I'm going to comment on that I can fix myself.
> > > Otherwise looks great.
> > > 
> > 
> > Hi Christian,
> > 
> > Let me know if you would like a new revision with all the comments
> > included (and your patch on file_kattr rename) or you good with
> > applying them while commit
> 
> It's all been in -next for a few days already. :)
> 

Oh sorry, missed that, thanks!

-- 
- Andrey

