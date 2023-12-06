Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlUNG9h9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6311A2
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 06:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701872540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLB0xakptmZK/paEeR6NK/S0tuH0grZlEHMYROWR5jg=;
	b=YlUNG9h9kGk6pogeVSCdV5GK1P/yN3qxrOn716bF3GjKSZW5pDbzEtg6c/1K84uPOYtuV5
	KLez/HLXjcDyO3nIo43b2QxuB+q0ZzVq9/FQqIm0M8wnOSu4Ajez95frB2kKSakMCalWks
	qL6FnSVoIHNWtXTwK5nwTwDqiCLHtOU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-AmutKD6NM4mkPPROGIV8yg-1; Wed, 06 Dec 2023 09:22:18 -0500
X-MC-Unique: AmutKD6NM4mkPPROGIV8yg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c6bd30ee89so856384a12.0
        for <selinux@vger.kernel.org>; Wed, 06 Dec 2023 06:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872538; x=1702477338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLB0xakptmZK/paEeR6NK/S0tuH0grZlEHMYROWR5jg=;
        b=mJ4ZqRu3VN3bPPVi5KC3eaHQ7ucXCmyDcIks5dD+ZAHoj1T4R5Vy7/FC01Kdnex1eY
         7bD0NszZuVGxy3tT8iuZzLkMS6tlI88BYsmbEjqz7ooKPc78BLCnWebIjfxWlKDlcv/3
         MxLvc1l+fW4/9QiY5r+7YnYPl3WoQSWS8thbyeZ2orAiJv4B9r0WB4ILiaHKPM4/yA1j
         szuNQZ9sn/wYBZuMCzbvUxezeu7hnP5QOHHEvl2iRE/WJAUcWMFqhY2JQqEdgiRS3A1r
         5NEr6eojQQlFHdyQ0iJvdj8kypOpZRy0aHg0lJDQC1IfsPcKfnk1+lW2mS8jWdXDbgy0
         M8lg==
X-Gm-Message-State: AOJu0YyB215XZoYC36ZoSxVcsveGLifFJJhB1gRc+9e93EyGC95o5hq4
	biglkzAy5s6xHT8cflQzoCmtvdTdg2giM8uOh8gmKgxRyLJNcfaO0Z8JWugFrdyXuAVLFV8jDwm
	b9AGF1/qWTBClENm9gL8aCwYjQqoIw3cW8A==
X-Received: by 2002:a17:90b:3d86:b0:286:6cc1:781d with SMTP id pq6-20020a17090b3d8600b002866cc1781dmr860865pjb.96.1701872537753;
        Wed, 06 Dec 2023 06:22:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKKfSjsOWVtPWTod+zg2CvvPowf53VSChdD7/z222jTPryWrvyHr1oecWgSe35Jxv4C03V1qXtJKXvufCz8Ks=
X-Received: by 2002:a17:90b:3d86:b0:286:6cc1:781d with SMTP id
 pq6-20020a17090b3d8600b002866cc1781dmr860850pjb.96.1701872537481; Wed, 06 Dec
 2023 06:22:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728050043.59880-1-wangkefeng.wang@huawei.com>
 <20230728050043.59880-4-wangkefeng.wang@huawei.com> <CAEjxPJ5ZuBGVDah0f3g0-7t2v1uSXTmp_cTT3g_MSP3J9QtoeA@mail.gmail.com>
 <CAHC9VhR_Tzbs=fE+D6VrP1boe7O_uHPu9yd7kfVppnB2vtPLOA@mail.gmail.com>
 <CAEjxPJ6iFRZUetSvMgZvq_327U_JZ_w9s=gFccKgJhfCt8bqNg@mail.gmail.com> <CAHC9VhRB1uVVWFUgnMZ1iwCD_A0mEX2Xhn79qTxuNKTzisWULg@mail.gmail.com>
In-Reply-To: <CAHC9VhRB1uVVWFUgnMZ1iwCD_A0mEX2Xhn79qTxuNKTzisWULg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 6 Dec 2023 15:22:06 +0100
Message-ID: <CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxqJaeuhbFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	David Hildenbrand <david@redhat.com>, peterz@infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Restoring part of the Cc list to include more relevant lists &
people... If you are lost, the original email is here:
https://lore.kernel.org/selinux/20230728050043.59880-4-wangkefeng.wang@huaw=
ei.com/)

On Tue, Aug 1, 2023 at 1:08=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Mon, Jul 31, 2023 at 4:02=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Mon, Jul 31, 2023 at 12:19=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > On Mon, Jul 31, 2023 at 10:26=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > I believe this patch yields a semantic change in the SELinux exeche=
ap
> > > > permission check. That said, I think the change is for the better.
> > >
> > > Agreed.  I'm also in favor of using a helper which is maintained by
> > > the VM folks over open coded logic in the SELinux code.
> >
> > Yes, only caveat is in theory it could trigger new execheap denials
> > under existing policies.
> > Trying to construct an example based on the
> > selinux-testsuite/tests/mmap/mprot_heap.c example but coming up empty
> > so far on something that both works and yields different results
> > before and after this patch.
>
> My gut feeling is that this will not be an issue, but I could very
> well be wrong.  If it becomes a significant issue we can revert the
> SELinux portion of the patch.
>
> Of course, if you have any luck demonstrating this with reasonable
> code, that would be good input too.

So, it turns out this does affect actual code. Thus far, we know about
gcl [1] and wine [2]. The gcl case is easy to reproduce (just install
gcl on Fedora and run gcl without arguments), so I was able to dig a
bit deeper.

gcl has the following relevant memory mappings as captured by gdb:
Start Addr           End Addr       Size     Offset  Perms  objfile
  0x413000           0xf75000   0xb62000   0x3fa000  rw-p
/usr/lib/gcl-2.6.14/unixport/saved_ansi_gcl
  0xf75000           0xf79000     0x4000        0x0  rwxp   [heap]

It tries to call mprotect(0x883000, 7282688,
PROT_READ|PROT_WRITE|PROT_EXEC), i.e. it tries to make the region
0x883000 - 0xf75000 executable. Before this patch it was allowed,
whereas now it triggers an execheap SELinux denial. But this seems
wrong - the affected region is merely adjacent to the [heap] region,
it does not actually overlap with it. So even if we accept that the
correct semantics is to catch any region that overlaps with the heap
(before only subregions of the heap were subject to the execheap
check), this corner case doesn't seem to be handled correctly by the
new check (and the same bug seems to have been in fs/proc/task_mmu.c
before commit 11250fd12eb8 ("mm: factor out VMA stack and heap
checks")).

I didn't analyze the wine case ([2]), but it may be the same situation.

Unless I'm mistaken, those <=3D & >=3D in should in fact be just < & >.
And the expression in vma_is_initial_stack() is also suspicious (but
I'm not going to make any assumption on what is the intended semantics
there...)

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2252391
[2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2247299

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

