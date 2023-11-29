Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYYrQKwt"
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F290F95
	for <selinux@vger.kernel.org>; Wed, 29 Nov 2023 09:39:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a00191363c1so4930866b.0
        for <selinux@vger.kernel.org>; Wed, 29 Nov 2023 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701279580; x=1701884380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QrDY6hyusI8w2s6EsttX/n0doa4Jibr8USlk7Ud0co=;
        b=BYYrQKwtJv2MeD5rQy+54oAlYlCZBY2puTo2Z/FUmbc5qQax8HdgLRj4U+RSfR26Dn
         D455VX64sxaxsqeFyRltEZIpW6pR6wOEUUQeGnF2RD/kEP63mS5Y/qBi01f1tDRD3cAO
         CJcyv1KSVF2tFQBFFmqUwNAfd5MZl6q9UHHWzv/dTzrLZWqIu4uN1NVVRqZq2LyYv7Fa
         WQrOtuPr5h5JpkEDgmCVY1A14SdO3w2WfgSfo6N3xS03GiXC+0mK5MR4xcUUBa9Ftj4p
         CU3/HVKgvrcVaaESqardo0yF+hElOuYVlupug8xeERhrZLS8f+r5L0B+KTrbx0dKpUIq
         73Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701279580; x=1701884380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QrDY6hyusI8w2s6EsttX/n0doa4Jibr8USlk7Ud0co=;
        b=Imbfqf54WtxLBCJA1KLmGBf2fBh5Gw7hNuEtD9ricuq5Ik6dgkLvRdoso4o/eVMPYe
         MbBV2PlsqqG1KlUPMjNI/sH2tI0efRoaT/j/iv9oP29VLjAF/8by0Fn/G54Z4RgqI1Wr
         psB1Yz1hGpP+4F6Qeu0UI693YSX72prVcxdFfxk54zlENp/n+SkaTEireMljIT0YzxWK
         +ca2wNJlrmExob4PlBoLRtxVKdx+k5pZxVj08x3W9EcuelGYnJtGbl2Sqy0Y6pRWcse+
         e1fo0YFaH1L3pzrHlp1GWN4vC91aID8I1sYJLFzH/7E4CN03ShsJch16U+q72JYi82le
         fZDQ==
X-Gm-Message-State: AOJu0YwLDlSV7kLK4B4ck0H2gk/13YybI9LJGSQs4u8+AvXesW18lsGL
	0kwKlF5eiw1K8RJs+WTKG1Yv7q4wzB5t5+37JUE=
X-Google-Smtp-Source: AGHT+IGQJHKOikw5by9dro+9ZjY2Q+Gi+QeYAT3iMkio3uF4k7/Nsxa/5c8qpHEJJlj2OA0ehmQbnaUzpWZBHZRZ/HY=
X-Received: by 2002:a17:906:e19:b0:a00:8b77:f621 with SMTP id
 l25-20020a1709060e1900b00a008b77f621mr15700654eji.22.1701279580155; Wed, 29
 Nov 2023 09:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103172953.24667-3-jsatterfield.linux@gmail.com>
 <d419ff729567246c50cf52b885e76903.paul@paul-moore.com> <CALMFcesyueiXg_8Z=LVhKjy7eYnE=3vJS0daTEC7+Z5GKxa4Cg@mail.gmail.com>
 <CAHC9VhR6xJmFGqBUyr7QkC3vOArL2e6iysL7P-9SV1Pv=1TYVA@mail.gmail.com>
In-Reply-To: <CAHC9VhR6xJmFGqBUyr7QkC3vOArL2e6iysL7P-9SV1Pv=1TYVA@mail.gmail.com>
From: Jacob Satterfield <jsatterfield.linux@gmail.com>
Date: Wed, 29 Nov 2023 17:39:30 +0000
Message-ID: <CALMFcevvDfOe7eLf=KZFpHCaUpOe0=isW5AOSrbRrPMt8a2QxA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] selinux: fix conditional avtab slot hint
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 6:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Nov 22, 2023 at 12:35=E2=80=AFPM Jacob Satterfield
> <jsatterfield.linux@gmail.com> wrote:
> > On Mon, Nov 20, 2023 at 8:29=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > I'm a concerned about all the work we have to do just to count the
> > > conditional rules.  Other than not working with existing binary
> > > policies, have you looked at bumping the policy version and introduci=
ng
> > > a binary format change that would include the number of conditional
> > > rules?
> >
> > Thanks for raising the issue. I had considered adding the total size
> > of the conditional table to the binary policy, but I wasn't sure if it
> > would be substantive enough to warrant bumping the policy version.
>
> I appreciate the thoughtfulness, but the version field in the policy
> is 32-bits and we are currently up to policy format v33 so we've still
> got a few version numbers to play with :)
>

Sounds good, I will implement the policy version bump.

> > As
> > you point out, the counting work will be needed for existing binary
> > policies making this patch necessary for the default case, but if you
> > are concerned about the performance penalty this patch brings (which
> > is less than the gain provided by the avtab array patch), then there
> > are two threads to possibly be worked on.
>
> To be clear, I'm not thinking about supporting this for existing
> policies, just the new policy format; the existing policy versions
> would behave as they do now ... although if we do the array conversion
> we will likely need to do some type of realloc()/retry or something, I
> dunno, I'll leave that to you to brainstorm ;)
>

I still believe the performance gained by converting to arrays
outweighs the cost of supporting older versions. See the discussion
below.

> > One is to rework this patch to include more invasive changes to count
> > rules without actually reading and destroying nodes thus saving cycles
> > but requiring more lines of code. Because policy parsing is not
> > handled separately from the construction of the policydb structure
> > (they are deeply intertwined), I was reluctant to add more complexity
> > just to have a parse-only code path. Would you prefer speed or simpler
> > logic for older policies?
>
> That's the problem we have right now.  We have to do a lot of work
> (allocations, etc.) that we throw away in the case where we are
> counting, not to mention that bolting on the count-only functionality
> is kinda hacky/ugly (not your fault, that is just the way the code is
> right now).  As you mention, the alternative is to significantly
> rework how we parse/load the policy, and that isn't a very exciting
> prospect as far as I'm concerned.
>
> I'm not sure if moving over to flex array is a win, I suspect that
> whatever we gain in memory savings we lose in not having direct
> access.  I dunno, maybe it wouldn't be too bad.
>

Unless I misunderstand, I believe I addressed your concerns from v1
over using indices vs direct access to the arrays. From v2 --> v5, the
array conversion patch only changes how avtab_node elements are
allocated, access is the same as it is now.

> I'm open to ideas here ... I'm looking for something that would
> support the improvements for a new policy with an explicit count,
> while still falling back to something that works "reasonably well" in
> the current case where we have to guess.  In this case "reasonably
> well" means no worse than current in terms of performance and memory
> use while not over complicating the code.
>

For existing policies, I have given this a bit of thought and did some
performance testing. There are memory vs. runtime tradeoffs to
consider between counting the rules (like v5 does) and doing a realloc
(like v1 does). I'm of the opinion that the counting approach is
better overall, but I'll (r)enumerate the tradeoffs here for the
benefit of discussion.

For the realloc approach, a decent chunk of memory (currently 256 KB)
is wasted over-allocating the hash table slots because of the estimate
derived from the regular rules table. Extra memory for avtab_nodes are
allocated (either from overestimation or the dynamic growth factor)
during parsing, sometimes up to 1 MB, requiring a final realloc to
remove them. The growth factor chosen could have additional runtime
implications with regard to multiple reallocs. Regardless, this
approach has runtime costs and memory lost to overestimating the
hashtable slots needed (which in this case, can't be recovered except
through a rehashing of the whole table). 86 lines of code are added,
but it is fairly clean code.

The counting approach incurs a runtime penalty processing the
conditional rules twice. Memory is wasted constructing the struct
cond_node lists and corresponding struct cond_av_list elements twice,
but nowhere close to 1 MB. 23 lines of code are added, but it is as
you said hacky/ugly. The runtime penalty could be further optimized at
the cost of parsing code complexity and additional lines of code as
discussed earlier.

Some performance numbers from Fedora 38 running "perf stat -r 1000 -d
load_policy" (realloc is the v5 array conversion + v1 realloc
patches):

dev:       0.261174 seconds time elapsed ( +- 0.31% ) baseline
v5:         0.233972 seconds time elapsed ( +- 0.31% ) -10%
realloc:  0.226636 seconds time elapsed ( +- 0.34% ) -13.3%

Therefore, to your criteria stated above, both approaches are
empirically no worse than current in terms of performance or memory
used after load. But I believe the current counting approach is the
most reasonable given the lines of code added and the least amount of
memory used during parsing. For what it's worth, I have been
interested in designing a set of patches that would ultimately
refactor policy parsing from policy loading and would, as a side
effect, enable a simpler and more optimized counting approach for
older policies. If this is something you would entertain (even if it's
not exciting), then I will consider it for a future patch.

If you agree, I will introduce the policy version bump in the next
spin and also submit a patch to sepol. Otherwise, I can go back to the
drawing board.

Thanks for reviewing as always!






> --
> paul-moore.com
