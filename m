Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFF134751
	for <selinux@vger.kernel.org>; Tue,  6 Feb 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707236813; cv=none; b=cMWkkvwqVmLsVtb9HL/Zy6XSL16bPb0o9VcMiNNNWfEq8ePkjl80DY+cs5WpGcI2TlIRzz5yKYtZEz7JUmggLP0MaJl2dkW9ad4f4S4wATNucV4jkR61EnJmdUruqDEivOdHUV9601PumiOKS8GEqccSTPqAkFdWFsilnwzRaac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707236813; c=relaxed/simple;
	bh=udcJME1WFwtZ8qNKbeG7WotKfoR1aTEcRmjEug/Md1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ywuv6Eqdi3ws2uB40kSjiXjSTiMQFW8t5mYPxMlPwhASNG7IjvaWWJFPp5BCVAo4iM4odyv3PzSXk1aAL9JFb5kbkxpkxCaOI+KIQnBebIVGpmTiXv8qWr2ra4nm1UxT9rdRdUOZZB9Ubec/SWMK/fOLEQlU5m5OYaRRR5ScJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wu5w7Hsp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wu5w7Hsp"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b4b0a3bddso233089f8f.2
        for <selinux@vger.kernel.org>; Tue, 06 Feb 2024 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707236809; x=1707841609; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKcGartFfaDNzaw0oNAzfboMjdH4dZ1SThMOYPfs59E=;
        b=Wu5w7HspkXm7lNfIXyWqH0zPiKvw+tBcS5wQ5r6dfBrJhduF6nwj76KATYq1dLX7Nn
         JBI20OSG8o7o7waAI51KIoa/VFf9N3U+j+NHdWcwANEuyaFH5wjgHHShE5BjnZHPojq5
         GzInZtY/utVLSDfxX9k6EwqHFGJlEcRkXDcSPro94oKrQVRn3hhPAzkEVYLPHA8UCEId
         WsqZV9oidmSql93LRNxJTwklNh5fP5QiNYXC+nmqEnOqZ96QgnhbnR4SamCj1/rILaru
         vzGK5+evYxYtipU9ZaARV2oHDTfcoyzD7g/PL/QS9l4PbTSrhncXplIn0/M/O6v2pgJq
         E1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707236809; x=1707841609;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKcGartFfaDNzaw0oNAzfboMjdH4dZ1SThMOYPfs59E=;
        b=UHAbOWWMMd2JZtoc0bD25J5wWDoW35ObbJUrM67rkyQpnqsVAXZxne4XgaiRjHkij3
         +vdjC13kelZpfNcVNsKTUzedbsCJ1j+jM3SqgpUGAhItU5p5G49rNiRBl7Elkb1jJK65
         VZolIV2GzF58jU4lB6xSxOzlAURl44lgUQp5G50RbMb3oF9cc27mTt6obC++EMOK0anf
         5DBKiYEaRaDeJjhl+6mw+wencJMMBxQdk5gxwUcEUu77g84fCA8UZnqziKOEZlKXsnKF
         9GOzN5XlSHVgGE4x3oGwpq6uMShwyl22t++/lTf5PGuG/bw9ZBm5oqER0O4u8akWDeGe
         tFtg==
X-Gm-Message-State: AOJu0YzMuo9qIo5bPcnHHEZGO3yayTOJO/1Pywe3tPuFJEb8TebhRuoc
	FeeOvX9Rv9YDsmYc1JlJ751W/l4Jo5sa9va4dXZIttsKXWVIr6U+1QCy+IMlAhsA1wHLlWW2AAI
	prHs0WwscK/e4DCoi23VAtIJ/B21nsphXsfBE
X-Google-Smtp-Source: AGHT+IH89GUBiASlkHU1t/vbfYCWBR4/w2Ue/VOkFZNVrEQU2R/i0VQYZk26ng6YoRY9yOTsCfq4LDgm9PGa95ZnLvE=
X-Received: by 2002:a5d:6d87:0:b0:33b:48ef:22ed with SMTP id
 l7-20020a5d6d87000000b0033b48ef22edmr1605036wrs.35.1707236809234; Tue, 06 Feb
 2024 08:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129203626.uq5tdic4z5qua5qy@revolver> <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver> <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
 <20240131214104.rgw3x5vuap43xubi@revolver> <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
 <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com>
 <20240205220022.a4qy7xlv6jpcsnh7@revolver> <CA+EESO6iXDAkH0hRcJf70aqASKG1eHWq2rJvLHafCtx-1pGAhw@mail.gmail.com>
 <20240206143506.6zsj2gktu754gvl6@revolver>
In-Reply-To: <20240206143506.6zsj2gktu754gvl6@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 6 Feb 2024 08:26:36 -0800
Message-ID: <CA+EESO5H_f-APVpg1wgJEHjcMd4ogRUX33j8n=_nz4uTQW78uA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:35=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240205 17:24]:
> > On Mon, Feb 5, 2024 at 2:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * Lokesh Gidra <lokeshgidra@google.com> [240205 16:55]:
> > > ...
> > >
> > > > > > > We can take care of anon_vma as well here right? I can take a=
 bool
> > > > > > > parameter ('prepare_anon' or something) and then:
> > > > > > >
> > > > > > >            if (vma) {
> > > > > > >                     if (prepare_anon && vma_is_anonymous(vma)=
) &&
> > > > > > > !anon_vma_prepare(vma)) {
> > > > > > >                                       vma =3D ERR_PTR(-ENOMEM=
);
> > > > > > >                                       goto out_unlock;
> > > > > > >                    }
> > > > > > > >                 vma_aquire_read_lock(vma);
> > > > > > >            }
> > > > > > > out_unlock:
> > > > > > > >         mmap_read_unlock(mm);
> > > > > > > >         return vma;
> > > > > > > > }
> > > > > >
> > > > > > Do you need this?  I didn't think this was happening in the cod=
e as
> > > > > > written?  If you need it I would suggest making it happen alway=
s and
> > > > > > ditch the flag until a user needs this variant, but document wh=
at's
> > > > > > going on in here or even have a better name.
> > > > >
> > > > > I think yes, you do need this. I can see calls to anon_vma_prepar=
e()
> > > > > under mmap_read_lock() protection in both mfill_atomic_hugetlb() =
and
> > > > > in mfill_atomic(). This means, just like in the pagefault path, w=
e
> > > > > modify vma->anon_vma under mmap_read_lock protection which guaran=
tees
> > > > > that adjacent VMAs won't change. This is important because
> > > > > __anon_vma_prepare() uses find_mergeable_anon_vma() that needs th=
e
> > > > > neighboring VMAs to be stable. Per-VMA lock guarantees stability =
of
> > > > > the VMA we locked but not of its neighbors, therefore holding per=
-VMA
> > > > > lock while calling anon_vma_prepare() is not enough. The solution
> > > > > Lokesh suggests would call anon_vma_prepare() under mmap_read_loc=
k and
> > > > > therefore would avoid the issue.
> > > > >
> > >
> > > ...
> > >
> > > > anon_vma_prepare() is also called in validate_move_areas() via move=
_pages().
> > >
> > > Probably worth doing it unconditionally and have a comment as to why =
it
> > > is necessary.
> > >
> > The src_vma (in case of move_pages()) doesn't need to have it.
> >
> > The only reason I'm not inclined to make it unconditional is what if
> > some future user of lock_vma() doesn't need it for their purpose? Why
> > allocate anon_vma in that case.
>
> Because there isn't a user and it'll add a flag that's a constant.  If
> there is a need for the flag later then it can be added at that time.
> Maybe there will never be a user and we've just complicated the code for
> no reason.  Don't implement features that aren't necessary, especially
> if there is no intent to use them.
>

I'm not too attached to the idea of keeping it conditional. But I have
already sent v3 which currently does it conditionally. Please take a
look at it. Along with any other comments/changes that I get, I'll
also make it unconditional in v4, if you say so.
> >
> > > Does this avoid your locking workaround?
> >
> > Not sure which workaround you are referring to. I am almost done
> > implementing your suggestion. Very soon will share the next version of
> > the patch-set.
>
> The locking dance with the flags indicating if it's per-vma lock or
> mmap_lock.
>
That dance was not because of anon_vma. It's just that I hadn't
realized that we can do it the way you suggested :) I really liked
your suggestion and is implemented in v3. PTAL.
