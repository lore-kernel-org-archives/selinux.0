Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LozqL9Kh"
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1750E135
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 12:47:24 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-db537948ea0so247954276.2
        for <selinux@vger.kernel.org>; Wed, 06 Dec 2023 12:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701895643; x=1702500443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03m9Q/bw886YTDz9qjzlgtiRQh+DJJBl0Kee3WcgMyc=;
        b=LozqL9Kh65xdtbv89FdR2sNKRTQMib41XW/yHcBgTz0M/YYbEloDBGqUYxJh23oG3b
         ed0dBbX/afj/nCYV4JSyhsCzRCqoF5WxBYcNDby8VTCq/rgOsPsq3NZfiA2V4Fu+uigX
         Y4ZFCxY6/KpotInE2ZP6YUJQiLEZ3IZ9Qi7K4oQLDykzW5mC1dTwnTv1AfUFzjKI+zfv
         VorT02rtBgf1Zt7hXDMhZ3uiwttKOzx1z/NzxliEdSZO0tsStct/m9KnYKnRgfzJkmIu
         vZNv41O1xGueqA7uldJrI1KNi+JOrzSqkvGeE7+Pg9HySBD6jKsD4X5EwXN02JkOyH3U
         7YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701895643; x=1702500443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03m9Q/bw886YTDz9qjzlgtiRQh+DJJBl0Kee3WcgMyc=;
        b=gVd2b82cJMGwWhGZ0BWyatDfHZ0wfg7p9AYqJ5eAcoc6mGR2ZeqcAYL5IBVDa0o55c
         sJkITidJiEJedW83FR3mvFByO3kuo0bpQ3eZrmrFLh7FGIWqHVcOnhRgai2IpTbW3rhX
         HMZMtMXG3LB3qkZP4VJhqTq5OHhnyKW+EQ0nUSmhq6OopMMEMsweKNtCKxZcTiu51WN8
         FlCsfuNbgpk+8+d3tmnOBNVS2cOqP/TRw5idwGyRN5oIllo9A7kw55Z12et1ddc98cY1
         DSqlgoZ1NY7/tvq9Mn8Lf9iuKViDyBYGoPtPdyUI8nfwwZ0GhOAnFkFq92qm5IjZCBg+
         1yzg==
X-Gm-Message-State: AOJu0Yzx6dEWDq2d2feQ9ZABr/A6l1Bs6QYGN/RZ0CqKUiEMxVBNSRvN
	ww5+mpB0qr9dnukO7qmBeNXdyJElpxpYyNZpyvJ6
X-Google-Smtp-Source: AGHT+IELdineb8nV+rdBDWW20nkuyyqa6PVAuAq/4Di/FEXsDjy4VsrK+EqH8adItqywpLZ8SrW2ODMTgaG4l5FXB2o=
X-Received: by 2002:a25:1657:0:b0:db7:dacf:59fe with SMTP id
 84-20020a251657000000b00db7dacf59femr1189834ybw.114.1701895643131; Wed, 06
 Dec 2023 12:47:23 -0800 (PST)
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
 <CAHC9VhRB1uVVWFUgnMZ1iwCD_A0mEX2Xhn79qTxuNKTzisWULg@mail.gmail.com> <CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxqJaeuhbFw@mail.gmail.com>
In-Reply-To: <CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxqJaeuhbFw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Dec 2023 15:47:12 -0500
Message-ID: <CAHC9VhSzrYOUAkM5-smu0rAZ7gWwPvR+TARWN9ojfaVACtYRew@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	David Hildenbrand <david@redhat.com>, peterz@infradead.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 9:22=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> (Restoring part of the Cc list to include more relevant lists &
> people... If you are lost, the original email is here:
> https://lore.kernel.org/selinux/20230728050043.59880-4-wangkefeng.wang@hu=
awei.com/)
>
> On Tue, Aug 1, 2023 at 1:08=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Mon, Jul 31, 2023 at 4:02=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Mon, Jul 31, 2023 at 12:19=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > >
> > > > On Mon, Jul 31, 2023 at 10:26=E2=80=AFAM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > I believe this patch yields a semantic change in the SELinux exec=
heap
> > > > > permission check. That said, I think the change is for the better=
.
> > > >
> > > > Agreed.  I'm also in favor of using a helper which is maintained by
> > > > the VM folks over open coded logic in the SELinux code.
> > >
> > > Yes, only caveat is in theory it could trigger new execheap denials
> > > under existing policies.
> > > Trying to construct an example based on the
> > > selinux-testsuite/tests/mmap/mprot_heap.c example but coming up empty
> > > so far on something that both works and yields different results
> > > before and after this patch.
> >
> > My gut feeling is that this will not be an issue, but I could very
> > well be wrong.  If it becomes a significant issue we can revert the
> > SELinux portion of the patch.
> >
> > Of course, if you have any luck demonstrating this with reasonable
> > code, that would be good input too.
>
> So, it turns out this does affect actual code. Thus far, we know about
> gcl [1] and wine [2]. The gcl case is easy to reproduce (just install
> gcl on Fedora and run gcl without arguments), so I was able to dig a
> bit deeper.
>
> gcl has the following relevant memory mappings as captured by gdb:
> Start Addr           End Addr       Size     Offset  Perms  objfile
>   0x413000           0xf75000   0xb62000   0x3fa000  rw-p
> /usr/lib/gcl-2.6.14/unixport/saved_ansi_gcl
>   0xf75000           0xf79000     0x4000        0x0  rwxp   [heap]
>
> It tries to call mprotect(0x883000, 7282688,
> PROT_READ|PROT_WRITE|PROT_EXEC), i.e. it tries to make the region
> 0x883000 - 0xf75000 executable. Before this patch it was allowed,
> whereas now it triggers an execheap SELinux denial. But this seems
> wrong - the affected region is merely adjacent to the [heap] region,
> it does not actually overlap with it. So even if we accept that the
> correct semantics is to catch any region that overlaps with the heap
> (before only subregions of the heap were subject to the execheap
> check), this corner case doesn't seem to be handled correctly by the
> new check (and the same bug seems to have been in fs/proc/task_mmu.c
> before commit 11250fd12eb8 ("mm: factor out VMA stack and heap
> checks")).
>
> I didn't analyze the wine case ([2]), but it may be the same situation.
>
> Unless I'm mistaken, those <=3D & >=3D in should in fact be just < & >.
> And the expression in vma_is_initial_stack() is also suspicious (but
> I'm not going to make any assumption on what is the intended semantics
> there...)
>
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D2252391
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D2247299

Thanks Ondrej.

I'm hoping the mm folks will comment on this as it looks like this is
an issue with the helper functions, but just in case I'm going to prep
a revert for just the SELinux changes.  If we don't hear anything in
the next couple of days I'll send the revert up to Linus with the idea
that we can eventually shift back to the helpers when this is sorted.

--=20
paul-moore.com
