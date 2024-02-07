Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12A1127B41
	for <selinux@vger.kernel.org>; Wed,  7 Feb 2024 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337508; cv=none; b=FvOVnnTcLLiuqesaTGCeMnbMZsgGD1hTqJv6ac/CMp2kIag1agR+NL8GqytZ7SeU38urCRtX0MUEFoK5vkAVo2lCxt035fu8iNP5ZbBHu1V5PD5xP0LNSSaKNoSvNI0BulAqJrZxjuxWxNuj4Mq3dQUOWO63qm/kHOGNGq1SbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337508; c=relaxed/simple;
	bh=vFnk6DQ8EIJEAZ/DRRBigdf0kxotx3XgDLJZVdGyWlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taEio2EdWsd3AZmc/usljEuGYyzUIhYctzihSXdtwbR2qokba5Fl7GoG72ddvyZIrXDj1Evr0k/rMNzN5NqyT8uO9r3CvDzPoUMrX+P6BXVDgp0iOYDLWQTi0vzBNvxK+bFtb4/pcrfFYnccgndd7lbhOPhzw58M8ewa7unukwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaleEkjV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaleEkjV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33b436dbdcfso832232f8f.0
        for <selinux@vger.kernel.org>; Wed, 07 Feb 2024 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707337505; x=1707942305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAp9QYmAagl4q8JstQaVuR+UzMqpGvUOafiaUGshjJs=;
        b=PaleEkjVXxGy63Ac5y+TKCmm1XTs6lU90cBz6EKTDiixC8bMAajNTFdbP/uBiFLuc6
         1fSeICo9XL6/4DsMG4oQVTviu5Z0givtNpXrtGaHkiFSiZbyjVRMRXGOBPgvivHeyDry
         ziZXUHPTDftXbxAnkw/t+AjODhrGARwGNeKk8TSgZ0KMio+yab3vVm4hZqIbM8ZVGeaB
         8zPQ8ky9N5JqVnCvn93JVm9rgJN3Sc/cKV1qRJmIdfIkFPTnC4oBv4U97xf9nr9GrrkH
         fKJWSRdGossRtu9mvcWPzPlMnBVBocf/U0xZrotiMOJFShN+yRVOztwXAbsW/kDKMHjN
         I3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707337505; x=1707942305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAp9QYmAagl4q8JstQaVuR+UzMqpGvUOafiaUGshjJs=;
        b=B9OV9TE3zkujZQhsOj2edywYfgQqmObcGXKi/iA1Cg+9/XHODs0rAZ21/Qgb5vHml9
         RTR7K2RpF1Cr6+3H/gYEBJ17GUKVyACQtsK8P6DtPNHlVh3nImCXOi05hhFsHtk68O5q
         pA3enToeJ4NNji7iyvDzWFKblUIGPta23Ymr/+chDOMc+2/HlvC1t3f+M4JIixoq//S/
         5/6UJPP/lqNie8hWzewmogUxJGaYC1qsXOu68XsKNd+VPC6EksWUtOQ1zDsdnmJHh3bb
         J7Z+n2m+wBcvhbFDnlz1BZR3EJBhi4Rdw5IK6Yk/AEsd9Svg+ibDzdRDfC9T6dWnO9uH
         fJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEKPI3O1ogjpZSrybavu2GI3565tK4kVj98EJJYU0/vTvTx4kqvLvOh6JvEeMbnH57r1Ev4RfUuoS0eGtyGO7cu40I3KEyDg==
X-Gm-Message-State: AOJu0YzXeNmUsuTxSwWnoMNQVQDrx89k6si2u6rQ21NNF4fdhNcTitOY
	KoYGzEL2O6uppVikYPrA6tCJlv3Q/2kxuIOvP5Mufao8y1QfNLRNJ0omLpqsPP6wbIGHDXSbyvZ
	zGS2sE4r+8sMmsGb9Z7jUX5/WskqhpU0qY2GK
X-Google-Smtp-Source: AGHT+IGQqWin6xslOwihUtxiZ2GFaThvfVui+rAPsrOr+dtRa0BkT869a3jIv2EUBTyktcfXEleTmaU5Z1oYmEKy778=
X-Received: by 2002:adf:ff91:0:b0:33b:2177:2228 with SMTP id
 j17-20020adfff91000000b0033b21772228mr4665957wrr.59.1707337504834; Wed, 07
 Feb 2024 12:25:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com> <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
 <20240130034627.4aupq27mksswisqg@revolver> <Zbi5bZWI3JkktAMh@kernel.org>
 <20240130172831.hv5z7a7bhh4enoye@revolver> <CA+EESO7W=yz1DyNsuDRd-KJiaOg51QWEQ_MfpHxEL99ZeLS=AA@mail.gmail.com>
 <Zb9mgL8XHBZpEVe7@kernel.org> <CA+EESO7RNn0aQhLxY+NDddNNNT6586qX08=rphU1-XmyoP5mZQ@mail.gmail.com>
 <ZcOhW8NR9XWhVnKS@kernel.org>
In-Reply-To: <ZcOhW8NR9XWhVnKS@kernel.org>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 7 Feb 2024 12:24:52 -0800
Message-ID: <CA+EESO6V9HiPtFpG7-cjvadj_BcKzGvi4GSdJBXD_zTM+EQu5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
To: Mike Rapoport <rppt@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 7:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Mon, Feb 05, 2024 at 12:53:33PM -0800, Lokesh Gidra wrote:
> > On Sun, Feb 4, 2024 at 2:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org> =
wrote:
> > >
> > > > 3) Based on [1] I see how mmap_changing helps in eliminating duplic=
ate
> > > > work (background copy) by uffd monitor, but didn't get if there is =
a
> > > > correctness aspect too that I'm missing? I concur with Amit's point=
 in
> > > > [1] that getting -EEXIST when setting up the pte will avoid memory
> > > > corruption, no?
> > >
> > > In the fork case without mmap_changing the child process may be get d=
ata or
> > > zeroes depending on the race for mmap_lock between the fork and
> > > uffdio_copy and -EEXIST is not enough for monitor to detect what was =
the
> > > ordering between fork and uffdio_copy.
> >
> > This is extremely helpful. IIUC, there is a window after mmap_lock
> > (write-mode) is released and before the uffd monitor thread is
> > notified of fork. In that window, the monitor doesn't know that fork
> > has already happened. So, without mmap_changing it would have done
> > background copy only in the parent, thereby causing data inconsistency
> > between parent and child processes.
>
> Yes.
>
> > It seems to me that the correctness argument for mmap_changing is
> > there in case of FORK event and REMAP when mremap is called with
> > MREMAP_DONTUNMAP. In all other cases its only benefit is by avoiding
> > unnecessary background copies, right?
>
> Yes, I think you are right, but it's possible I've forgot some nasty race
> that will need mmap_changing for other events.
>
> > > > > > > > > > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_a=
rea_struct *vma,
> > > > > > > > > >               return true;
> > > > > > > > > >
> > > > > > > > > >       userfaultfd_ctx_get(ctx);
> > > > > > > > > > +     down_write(&ctx->map_changing_lock);
> > > > > > > > > >       atomic_inc(&ctx->mmap_changing);
> > > > > > > > > > +     up_write(&ctx->map_changing_lock);
> > > > > > > > > >       mmap_read_unlock(mm);
> > > > > > > > > >
> > > > > > > > > >       msg_init(&ewq.msg);
> > > > > > >
> > > > > > > If this happens in read mode, then why are you waiting for th=
e readers
> > > > > > > to leave?  Can't you just increment the atomic?  It's fine ha=
ppening in
> > > > > > > read mode today, so it should be fine with this new rwsem.
> > > > > >
> > > > > > It's been a while and the details are blurred now, but if I rem=
ember
> > > > > > correctly, having this in read mode forced non-cooperative uffd=
 monitor to
> > > > > > be single threaded. If a monitor runs, say uffdio_copy, and in =
parallel a
> > > > > > thread in the monitored process does MADV_DONTNEED, the latter =
will wait
> > > > > > for userfaultfd_remove notification to be processed in the moni=
tor and drop
> > > > > > the VMA contents only afterwards. If a non-cooperative monitor =
would
> > > > > > process notification in parallel with uffdio ops, MADV_DONTNEED=
 could
> > > > > > continue and race with uffdio_copy, so read mode wouldn't be en=
ough.
> > > > > >
> > > > >
> > > > > Right now this function won't stop to wait for readers to exit th=
e
> > > > > critical section, but with this change there will be a pause (sin=
ce the
> > > > > down_write() will need to wait for the readers with the read lock=
).  So
> > > > > this is adding a delay in this call path that isn't necessary (?)=
 nor
> > > > > existed before.  If you have non-cooperative uffd monitors, then =
you
> > > > > will have to wait for them to finish to mark the uffd as being re=
moved,
> > > > > where as before it was a fire & forget, this is now a wait to tel=
l.
> > > > >
> > > > I think a lot will be clearer once we get a response to my question=
s
> > > > above. IMHO not only this write-lock is needed here, we need to fix
> > > > userfaultfd_remove() by splitting it into userfaultfd_remove_prep()
> > > > and userfaultfd_remove_complete() (like all other non-cooperative
> > > > operations) as well. This patch enables us to do that as we remove
> > > > mmap_changing's dependency on mmap_lock for synchronization.
> > >
> > > The write-lock is not a requirement here for correctness and I don't =
see
> > > why we would need userfaultfd_remove_prep().
> > >
> > > As I've said earlier, having a write-lock here will let CRIU to run
> > > background copy in parallel with processing of uffd events, but I don=
't
> > > feel strongly about doing it.
> > >
> > Got it. Anyways, such a change needn't be part of this patch, so I'm
> > going to keep it unchanged.
>
> You mean with a read lock?

No, I think write lock is good as it enables parallel background copy.
Also because it brings consistency in blocking userfaultfd operations.

I meant encapsulating remove operations within
userfaultfd_remove_prep() and userfaultfd_remove_complete(). I
couldn't figure out any need for that.


>
> --
> Sincerely yours,
> Mike.
