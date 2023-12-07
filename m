Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVMTDtVB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941E3D57
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 00:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701938251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql1Ghzu6pTeMcHMjS2o9I9cOZlV0c5FGtb0DiNg5B/Y=;
	b=HVMTDtVBre8z5TA7oMqH5oTBKY1nB/b+ob7gDm3p4rWFFfW8yuwD3yfMZSXkBWpbjsqsSS
	bKXNV+/t674LKP+hA1iz2Ux26wuiW4/quBECNw9r4gHff+73FHr8XRmp7xWovuoNn2p2en
	Ukt+FSlkkAnnDJNR+1YV5GTdcjU/yXQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-jsQD4Y0tOdeTPTwWQVqujA-1; Thu, 07 Dec 2023 03:37:26 -0500
X-MC-Unique: jsQD4Y0tOdeTPTwWQVqujA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28649b11e86so709645a91.0
        for <selinux@vger.kernel.org>; Thu, 07 Dec 2023 00:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701938244; x=1702543044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql1Ghzu6pTeMcHMjS2o9I9cOZlV0c5FGtb0DiNg5B/Y=;
        b=bG3HR/LZSCkX6ROVHR0ZpeRDgg0NdulPpkHYectF9XsAu6Gt7ytZbzNAe7OZ1Gxjkr
         9DfN0JsnwylmoZhqRoPPiqqIKidyaMsziW1TR48bSoYHn6nLIXNNJwq4fFEI5GipSY3V
         /gilJwBjee99Uo+EPzL7q2Wkf+6cdfrKDT7u5d5YofTKDjMjylgLAy0S8jTbxZ0fy42d
         DofcZ3GiF2PuFLmVPmFrLs5LfrmFNCiG2x6+mND4v+HJjF7Dqad/ei6PNHbJMZUVCpF2
         0Ku4++vj5kawJzbbh75gNWfcU9KZWUJILcawWu4DK7UOl/Cs/rXzpBSaCPjmDcDLiuFG
         WTrw==
X-Gm-Message-State: AOJu0YywzcAzMR5xSzQkdYJIrFkaXI5spgh2m0f6RnbGzjKO7HvVjA3D
	1ILf8rlcao9WTLxMoEbO238o6lb6d895zV5jYw1Ds2UBhcEPtqQq6V70zhG4Z0DjWeI060lb+R1
	aj1vrwkApQuUQsd0vCLGwehHwZpVKorjkdQ==
X-Received: by 2002:a17:90b:4a8f:b0:286:b6bf:e6d5 with SMTP id lp15-20020a17090b4a8f00b00286b6bfe6d5mr1779186pjb.14.1701938244493;
        Thu, 07 Dec 2023 00:37:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGstCK0Dkasup6i8nnE06yQpc/uNh0Tu7+7VEU7OCd1DWWkXX6Dq53Ha8GjO7pxz/6aqAHli0YdroCP7JK/3sI=
X-Received: by 2002:a17:90b:4a8f:b0:286:b6bf:e6d5 with SMTP id
 lp15-20020a17090b4a8f00b00286b6bfe6d5mr1779174pjb.14.1701938244171; Thu, 07
 Dec 2023 00:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
 <20230728050043.59880-4-wangkefeng.wang@huawei.com> <CAEjxPJ5ZuBGVDah0f3g0-7t2v1uSXTmp_cTT3g_MSP3J9QtoeA@mail.gmail.com>
 <CAHC9VhR_Tzbs=fE+D6VrP1boe7O_uHPu9yd7kfVppnB2vtPLOA@mail.gmail.com>
 <CAEjxPJ6iFRZUetSvMgZvq_327U_JZ_w9s=gFccKgJhfCt8bqNg@mail.gmail.com>
 <CAHC9VhRB1uVVWFUgnMZ1iwCD_A0mEX2Xhn79qTxuNKTzisWULg@mail.gmail.com>
 <CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxqJaeuhbFw@mail.gmail.com>
 <CAHC9VhSzrYOUAkM5-smu0rAZ7gWwPvR+TARWN9ojfaVACtYRew@mail.gmail.com> <79f6131f-7d69-408d-917a-f0ca6fccc5b2@huawei.com>
In-Reply-To: <79f6131f-7d69-408d-917a-f0ca6fccc5b2@huawei.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 7 Dec 2023 09:37:13 +0100
Message-ID: <CAFqZXNvsRT9BRex9e8QK3xUP8u22uExObQQgWGR=bVtCEzC2ag@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	SElinux list <selinux@vger.kernel.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>, peterz@infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 5:50=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei.=
com> wrote:
>
>
>
> On 2023/12/7 4:47, Paul Moore wrote:
> > On Wed, Dec 6, 2023 at 9:22=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat=
.com> wrote:
> >>
> >> (Restoring part of the Cc list to include more relevant lists &
> >> people... If you are lost, the original email is here:
> >> https://lore.kernel.org/selinux/20230728050043.59880-4-wangkefeng.wang=
@huawei.com/)
> >>
> >> On Tue, Aug 1, 2023 at 1:08=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> >>> On Mon, Jul 31, 2023 at 4:02=E2=80=AFPM Stephen Smalley
> >>> <stephen.smalley.work@gmail.com> wrote:
> >>>> On Mon, Jul 31, 2023 at 12:19=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> >>>>>
> >>>>> On Mon, Jul 31, 2023 at 10:26=E2=80=AFAM Stephen Smalley
> >>>>> <stephen.smalley.work@gmail.com> wrote:
> >>>>>> I believe this patch yields a semantic change in the SELinux exech=
eap
> >>>>>> permission check. That said, I think the change is for the better.
> >>>>>
> >>>>> Agreed.  I'm also in favor of using a helper which is maintained by
> >>>>> the VM folks over open coded logic in the SELinux code.
> >>>>
> >>>> Yes, only caveat is in theory it could trigger new execheap denials
> >>>> under existing policies.
> >>>> Trying to construct an example based on the
> >>>> selinux-testsuite/tests/mmap/mprot_heap.c example but coming up empt=
y
> >>>> so far on something that both works and yields different results
> >>>> before and after this patch.
> >>>
> >>> My gut feeling is that this will not be an issue, but I could very
> >>> well be wrong.  If it becomes a significant issue we can revert the
> >>> SELinux portion of the patch.
> >>>
> >>> Of course, if you have any luck demonstrating this with reasonable
> >>> code, that would be good input too.
> >>
> >> So, it turns out this does affect actual code. Thus far, we know about
> >> gcl [1] and wine [2]. The gcl case is easy to reproduce (just install
> >> gcl on Fedora and run gcl without arguments), so I was able to dig a
> >> bit deeper.
> >>
> >> gcl has the following relevant memory mappings as captured by gdb:
> >> Start Addr           End Addr       Size     Offset  Perms  objfile
> >>    0x413000           0xf75000   0xb62000   0x3fa000  rw-p
> >> /usr/lib/gcl-2.6.14/unixport/saved_ansi_gcl
> >>    0xf75000           0xf79000     0x4000        0x0  rwxp   [heap]
> >>
> >> It tries to call mprotect(0x883000, 7282688,
> >> PROT_READ|PROT_WRITE|PROT_EXEC), i.e. it tries to make the region
> >> 0x883000 - 0xf75000 executable. Before this patch it was allowed,
> >> whereas now it triggers an execheap SELinux denial. But this seems
> >> wrong - the affected region is merely adjacent to the [heap] region,
> >> it does not actually overlap with it. So even if we accept that the
> >> correct semantics is to catch any region that overlaps with the heap
> >> (before only subregions of the heap were subject to the execheap
> >> check), this corner case doesn't seem to be handled correctly by the
> >> new check (and the same bug seems to have been in fs/proc/task_mmu.c
> >> before commit 11250fd12eb8 ("mm: factor out VMA stack and heap
> >> checks")).
>
> Yes, the heap check exists for a long time,
>
>                           [start_brk        brk]
> case1:                     [vm_start,vm_end]
> case2:             [vm_start,vm_end]
> case3:                               [vm_start,vm_end]
> case4:         [vm_start,                      vm_end]
>
> case5:   [vm_start,vm_end]
> case6:                                          [vm_start,vm_end]
>
> old check:
> vma->vm_start >=3D vma->vm_mm->start_brk && vma->vm_end <=3D vma->vm_mm->=
brk
>
> Only include case1=EF=BC=8C vma range must be within heap
>
> new check:
> vma->vm_start <=3D vma->vm_mm->brk && vma->vm_end >=3D vma->vm_mm->start_=
brk
>
> Include case1~case6, but case5(vm_end=3Dstart_brk) and case6(vm_start=3Db=
rk)
> are the corner cases, gcl issue matchs the case5.
>
> >>
> >> I didn't analyze the wine case ([2]), but it may be the same situation=
.
> >>
> >> Unless I'm mistaken, those <=3D & >=3D in should in fact be just < & >=
.
>
> I support this change.
>   vma->vm_start < vma->vm_mm->brk && vma->vm_end > vma->vm_mm->start_brk
>
> >> And the expression in vma_is_initial_stack() is also suspicious (but
> >> I'm not going to make any assumption on what is the intended semantics
> >> there...)
> >>
> >> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2252391
> >> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2247299
>
> Could you quickly verify after the above change?

Yes, changing the operators as suggested fixes the gcl case.

BTW, the vma_is_*() helpers introduced by your patch also have wrong
indentation - the "return" lines are indented by 7 spaces instead of a
tab. If you are going to submit a fixing patch you might want to fix
that, too.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

