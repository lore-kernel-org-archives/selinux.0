Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QOmQaiWA"
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54FCC9
	for <selinux@vger.kernel.org>; Wed,  6 Dec 2023 16:11:41 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-dbc1efbe93aso445113276.0
        for <selinux@vger.kernel.org>; Wed, 06 Dec 2023 16:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701907901; x=1702512701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbfRU1+yLu4A1Kul4dCxNfwM27z2XrB9BXp6SUSUXQk=;
        b=QOmQaiWAiDgQSPd5wa7D7g2R8uPOo6eGCLHu4uLFShSgrv14EW4rSA1957iEBz88hG
         nzJvY0Z2kXlaMOtuos5fY3TpbK81IABzbPUXA205SzuBq/y2626jTFsFci18CFrGvOZx
         0Y3/zVYWhd+7M2LPRUTulgwEPFD/SHQD3IIcDKlGrWdnH3u7lyGVq1IQel+CgpKe31/x
         3FNZx27v7liFqX0ajGeQEn0KwsUc/hYfmBAwxG2WtrlXNzHvPw3Q9KhxnVYqXT0/ZOdn
         H1LeuTM4mJzpE+oK7LOY4V8kdBe8ytcyhpTfbWCUJOU97Nz4knZ3J2dG0oElGwXy6xCW
         cztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907901; x=1702512701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbfRU1+yLu4A1Kul4dCxNfwM27z2XrB9BXp6SUSUXQk=;
        b=w+ygq5TPD+eHi5hrqbVEth3iT0ILrOy3DEuhMz86tvaSu8dMwz/zxVhJX6LI+Xdehd
         1j3uzK6S5mvvw+ZJ8X913QFXS5fYp6nA73h2BbPvxxRwcKWMId6u6R00LpoGIlzWyahC
         9r2BOLpcgcgbD+nVfwq7XzU+qG/SrUWMSwMrCN8IJUcsHguQ5B1fMpeK06Dfhn0lU+c/
         kGI64j2qbu04C83iL5GiPtyhcvRK69aefpzRc2DRKo4ZFzqJ3YXdb+SSr4mUVPfejela
         /P07mIDdJY7dBGxwYsL4zXrnH9Db08R2A4Gu7sx9o/0OhEixOJAPThh4M4sWdwbX0EcY
         6sNw==
X-Gm-Message-State: AOJu0Yw+MbCvg5t2xaa3pa8vzjuympWHWfKIDRGhfQYffg8ib2u8DDPM
	t9NtxrPjtmabNwM5xh7/A5spCvi8LbJtcgVxua2J
X-Google-Smtp-Source: AGHT+IG6mQW8LTDasi58s7zwPuEANdzgyJQM1xTGFA26qPWe2TpDqOWjPL3b4Fhd3VUPqS5F9Y0mTJKBxhRLe3f8QG8=
X-Received: by 2002:a25:ae0f:0:b0:db9:7d9f:b4d9 with SMTP id
 a15-20020a25ae0f000000b00db97d9fb4d9mr1632354ybj.0.1701907900797; Wed, 06 Dec
 2023 16:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103172953.24667-3-jsatterfield.linux@gmail.com>
 <d419ff729567246c50cf52b885e76903.paul@paul-moore.com> <CALMFcesyueiXg_8Z=LVhKjy7eYnE=3vJS0daTEC7+Z5GKxa4Cg@mail.gmail.com>
 <CAHC9VhR6xJmFGqBUyr7QkC3vOArL2e6iysL7P-9SV1Pv=1TYVA@mail.gmail.com> <CALMFcevvDfOe7eLf=KZFpHCaUpOe0=isW5AOSrbRrPMt8a2QxA@mail.gmail.com>
In-Reply-To: <CALMFcevvDfOe7eLf=KZFpHCaUpOe0=isW5AOSrbRrPMt8a2QxA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Dec 2023 19:11:29 -0500
Message-ID: <CAHC9VhQ0u6KbasQtq+5sw+60xchYxf+TVwtE7YehhE0JCuBHKA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] selinux: fix conditional avtab slot hint
To: Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc: selinux@vger.kernel.org, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 12:39=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> On Wed, Nov 22, 2023 at 6:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Wed, Nov 22, 2023 at 12:35=E2=80=AFPM Jacob Satterfield
> > <jsatterfield.linux@gmail.com> wrote:
> > > On Mon, Nov 20, 2023 at 8:29=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > I'm a concerned about all the work we have to do just to count the
> > > > conditional rules.  Other than not working with existing binary
> > > > policies, have you looked at bumping the policy version and introdu=
cing
> > > > a binary format change that would include the number of conditional
> > > > rules?
> > >
> > > Thanks for raising the issue. I had considered adding the total size
> > > of the conditional table to the binary policy, but I wasn't sure if i=
t
> > > would be substantive enough to warrant bumping the policy version.
> >
> > I appreciate the thoughtfulness, but the version field in the policy
> > is 32-bits and we are currently up to policy format v33 so we've still
> > got a few version numbers to play with :)
>
> Sounds good, I will implement the policy version bump.
>
> > > As
> > > you point out, the counting work will be needed for existing binary
> > > policies making this patch necessary for the default case, but if you
> > > are concerned about the performance penalty this patch brings (which
> > > is less than the gain provided by the avtab array patch), then there
> > > are two threads to possibly be worked on.
> >
> > To be clear, I'm not thinking about supporting this for existing
> > policies, just the new policy format; the existing policy versions
> > would behave as they do now ... although if we do the array conversion
> > we will likely need to do some type of realloc()/retry or something, I
> > dunno, I'll leave that to you to brainstorm ;)
>
> I still believe the performance gained by converting to arrays
> outweighs the cost of supporting older versions. See the discussion
> below.

Annoying as it may be at times, we have an obligation to continue to
support older policy versions in the kernel.  We can't break
existing/old userspace applications or SELinux policies, period.

This doesn't mean that we have to ensure that every performance
improvement applies to the existing/old userspace; if we have an
improvement that only applies on newer policy versions, that's okay,
we just need to make sure we don't significantly penalize the existing
policies in use today.

> > > One is to rework this patch to include more invasive changes to count
> > > rules without actually reading and destroying nodes thus saving cycle=
s
> > > but requiring more lines of code. Because policy parsing is not
> > > handled separately from the construction of the policydb structure
> > > (they are deeply intertwined), I was reluctant to add more complexity
> > > just to have a parse-only code path. Would you prefer speed or simple=
r
> > > logic for older policies?
> >
> > That's the problem we have right now.  We have to do a lot of work
> > (allocations, etc.) that we throw away in the case where we are
> > counting, not to mention that bolting on the count-only functionality
> > is kinda hacky/ugly (not your fault, that is just the way the code is
> > right now).  As you mention, the alternative is to significantly
> > rework how we parse/load the policy, and that isn't a very exciting
> > prospect as far as I'm concerned.
> >
> > I'm not sure if moving over to flex array is a win, I suspect that
> > whatever we gain in memory savings we lose in not having direct
> > access.  I dunno, maybe it wouldn't be too bad.
>
> Unless I misunderstand, I believe I addressed your concerns from v1
> over using indices vs direct access to the arrays. From v2 --> v5, the
> array conversion patch only changes how avtab_node elements are
> allocated, access is the same as it is now.

I probably wasn't as clear as I should have been, I'm sorry about
that.  My comment about flex arrays was in reference to a dynamic
array mechanism in the kernel known as "flex arrays", my thinking was
that we could use flex arrays to manage the size of the conditional
rules arrays with just a single pass.  While flex arrays were dynamic
and resizable, there was an obvious limitation in that direct access,
similar to conventional fixed arrays, wasn't always possible.
However, while looking up a pointer to the flex array documentation to
share in this email I now realize that flex arrays were removed from
the kernel some time ago and are no longer available ... oof :/

Looking around quickly, I see we now have xarrays, which are also
resizable, but I have zero experience with them and they may be a bit
too heavyweight for what we need.

There is also kvrealloc(), but that doesn't seem to be especially
clever, using the traditional alloc-n-copy based approach.  Who knows,
maybe that is okay since we would only be doing this on policy loads,
which should hopefully be relatively infrequent.

> > I'm open to ideas here ... I'm looking for something that would
> > support the improvements for a new policy with an explicit count,
> > while still falling back to something that works "reasonably well" in
> > the current case where we have to guess.  In this case "reasonably
> > well" means no worse than current in terms of performance and memory
> > use while not over complicating the code.
>
> For existing policies, I have given this a bit of thought and did some
> performance testing. There are memory vs. runtime tradeoffs to
> consider between counting the rules (like v5 does) and doing a realloc
> (like v1 does). I'm of the opinion that the counting approach is
> better overall, but I'll (r)enumerate the tradeoffs here for the
> benefit of discussion.

Thanks, I have to jump around enough that a refresher is always welcome :)

> For the realloc approach, a decent chunk of memory (currently 256 KB)
> is wasted over-allocating the hash table slots because of the estimate
> derived from the regular rules table. Extra memory for avtab_nodes are
> allocated (either from overestimation or the dynamic growth factor)
> during parsing, sometimes up to 1 MB, requiring a final realloc to
> remove them. The growth factor chosen could have additional runtime
> implications with regard to multiple reallocs. Regardless, this
> approach has runtime costs and memory lost to overestimating the
> hashtable slots needed (which in this case, can't be recovered except
> through a rehashing of the whole table). 86 lines of code are added,
> but it is fairly clean code.

I went back and looked at the v1 patches very quickly, I didn't want
to spend too much time there as there were a number of changes,
unrelated to the array/alloc code, that meant this early patchset
wasn't very applicable to our discussion.  However, one thing did jump
out as I was looking for the realloc code: you might want to consider
rewriting avtab_change_nodes_size() to use kvrealloc().  The change
should be trivial and it is SELinux specific code; the only drawback
is that the "shrink" operation is effectively a no-op.

I'm okay if we need to "waste" a reasonably small amount of memory due
to dynamic reallocs; we just need to be smart about balancing the
incremental size increases with the desire to moderate the number of
times we call kvrealloc().

> The counting approach incurs a runtime penalty processing the
> conditional rules twice. Memory is wasted constructing the struct
> cond_node lists and corresponding struct cond_av_list elements twice,
> but nowhere close to 1 MB. 23 lines of code are added, but it is as
> you said hacky/ugly. The runtime penalty could be further optimized at
> the cost of parsing code complexity and additional lines of code as
> discussed earlier.

I can't bring myself to merge something that takes the two-pass
approach to counting, I have this gut feeling that it is something we
are going to regret in the future.  I'm sorry.  It isn't the number of
lines of code that concern me, it's how the code is put together and
architected.  A kvrealloc() based approach is simply going to be
cleaner than a two-pass, alloc-free-alloc approach.  The kvrealloc()
solution may not be optimal in terms of memory allocated(), and policy
loads might be a bit slower due to mm issues, but it is *much* easier
to look at the code and convince yourself (and others, including
future you) that it is correct ... which is worth a *lot* in my mind.

> Some performance numbers from Fedora 38 running "perf stat -r 1000 -d
> load_policy" (realloc is the v5 array conversion + v1 realloc
> patches):
>
> dev:       0.261174 seconds time elapsed ( +- 0.31% ) baseline
> v5:         0.233972 seconds time elapsed ( +- 0.31% ) -10%
> realloc:  0.226636 seconds time elapsed ( +- 0.34% ) -13.3%
>
> Therefore, to your criteria stated above, both approaches are
> empirically no worse than current in terms of performance or memory
> used after load.

Sweet, so even the realloc approach is faster on policy load?  Awesome :)

> But I believe the current counting approach is the
> most reasonable given the lines of code added and the least amount of
> memory used during parsing.

I've tried, perhaps poorly, to explain why the two-pass approach isn't
appealing from my perspective.

> For what it's worth, I have been
> interested in designing a set of patches that would ultimately
> refactor policy parsing from policy loading and would, as a side
> effect, enable a simpler and more optimized counting approach for
> older policies. If this is something you would entertain (even if it's
> not exciting), then I will consider it for a future patch.

Possibly.  Let's get past this first and then you can explain a bit
more about what you had in mind ;)

> If you agree, I will introduce the policy version bump in the next
> spin and also submit a patch to sepol. Otherwise, I can go back to the
> drawing board.

I think I would like to see two things, either in one patchset or two,
that's up to you:

* A kvrealloc/xa based approach that works with existing policy
versions and offers improvements over what we have now in terms or
either performance or memory usage while not regressing in both.

* A new binary policy version that adds an explicit count that can be
used to properly allocate the necessary internal policy structs up
front and avoid reallocation.

Does that make sense and sound reasonable to you?

> Thanks for reviewing as always!

Thanks for your continued patience and enthusiasm :)

--=20
paul-moore.com
