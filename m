Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70431BF58;
	Fri, 28 Mar 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168237; cv=none; b=fu0IriQEEFoBNhdSonvzhWBMMG78+BH68q+AVjIkW0iNQlKJ+HxYjNSLtrM9BaDuJsg+C1g/AJkDMKnvRSZELkD5L3FFmuZUofVVSKiwKOSaIhgLzNxSLef9XRyW2LPe22DjQGuaAw6nt8gQAJFa2cnbeCQVSCduFY7SWAMrPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168237; c=relaxed/simple;
	bh=Uet+GWywARYyeWIlgLQc7OwrGzmNpxl5Bvi7E5q5jYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8cUJ6B64iIAeBpG6hoFanqU1vqc/JNC9B//GOQ8fE3bTllZjIVRZYgFGg9ZSg/WCB5yi9TJCNpZZrByGfLJe7VyP0F4cSMc/6VL2/z3BbogK97hBci2hSX9R7Whq2u7cc64Eeh4N/J3vx3IuuXFx7kyaFiEfQQrcE1+r+mIfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEDgoQTy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEDgoQTy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227aaa82fafso44685445ad.2;
        Fri, 28 Mar 2025 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743168235; x=1743773035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du9IDYa2GZWYJvMRihP6sOOgpgAOuTK/qdvMUJfxb6g=;
        b=LEDgoQTyuY8dDD+PnKqtYgBmWXFweJLjZr2Tzsope3LoBvt40miDucsUceCaVBRLq8
         ri6dO8SD4YkX0km1CTU+QY9OkRfYPCpOcxv3wB/rsoC7qsGxFke6rmwZZq3r/FANMM67
         sHC4KhKxz7zWWBgQasd26jzSbyLUTPXMycO1dOrilhXYEoRMYIod7ZE7K08ccj7QPvPG
         zUIwjmkiL4M7RF3vWp53ZojO7Qy4KFtdcjO6u7oARnkck2sAOemMXCNxDRcLixZhRoxp
         iml/XyQk/O5o0EfNjuk+esIpszaYCr9GURZhrpR7Fo/COG44ZoLvuGIUu4S0KAXuihVh
         mHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743168235; x=1743773035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du9IDYa2GZWYJvMRihP6sOOgpgAOuTK/qdvMUJfxb6g=;
        b=VG2axgjIr/+BPlIAyEY7KuT3EBxKqJ20yTByvagLV8bSwUnCIkjlY3SZHqKnPgqrY6
         k7SGYX38r55tium1yV4lI9BF8z0dJv6yFqbq9FfVd1Dikgq+ddWg1QFNuDMMA3jTBKlk
         EX2TpSEkkTKNfTt+MqACjWBU5ZflkdGQAM+Tzv0lj4f7fLXrdNWvkScD06NGIzYIh1hx
         PeKaiUuPE1gGRlBv/MZQhD7Dpq12s4zNIPI4cwP3mQCFVyKyr21R+aNfugiWF3i4L6iE
         PO2+v3srx927n42BVN+AyrRfkXqEx+msKFNh1k4lzdTUG+hx8QM8DL8feFHcl6ik4Bnn
         jCiA==
X-Forwarded-Encrypted: i=1; AJvYcCUu5NUTfHgLINNcX0R+Cv3zffnzEu/rdrAJOcChJcvqsO1uUv91eD2T2wchujhAYz+6ksG1gfbQig==@vger.kernel.org, AJvYcCWxNVpc/o8mP1WVj5R8whACzlXulR6Ii1bZfXBVudvnS/bn73Pc+5U8BL0KEgcoY5Pp/TK0oimaReQE3ic=@vger.kernel.org, AJvYcCXT2VhY6MAbRjqu+eUABd/fFga+mDb2XfzhHAzBZl3Fw04+BKWDGvhdJ/yiMl/HQo0q+gZ2Z3T2Ur/Xie9F605eEG6nSnCn@vger.kernel.org
X-Gm-Message-State: AOJu0YwgW+iVWqd4XeFzThL4NATMct1BKi2juWJF6OCa9AkldtDvZU69
	nf5RvoMwaR3a/7okbXodR0rGXZCQ8j57H6B3mcojxyx42cHngf9nnzJHjgziNzlqKrDZPWDpjRZ
	dOdqqrzLB2OMR/ZkpdkS3vXrIHiQ=
X-Gm-Gg: ASbGncsCu0e44onj6J8JT1dtpX8SzAKl57CkNc4vFyVrxyawuaTPlIrlOEyg9iPOU/R
	Sfx6Q8uLBkd6iCz28AZo4JtTXKSufZ9IrZ3eJ6iuWqVogfv/xN9S4tIy0aVSv97WIMWnWudl2cX
	mgekj+z1/VwHu79CSV359a9XiJ4A==
X-Google-Smtp-Source: AGHT+IHcGRrPX/M3XDaaLNv7mbE5m9pOG6+pPTmOreVs+NnQWoCGw2RLImoptzxi0Yb+fBy+gu/gNN1sazZYNceJFIs=
X-Received: by 2002:a05:6a00:848:b0:736:ab48:3823 with SMTP id
 d2e1a72fcca58-73960e0fb47mr9856883b3a.1.1743168234705; Fri, 28 Mar 2025
 06:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
 <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
 <CAEjxPJ6XnBmbzH44YVQxxv8WOyPN7N81fpj7OYonEOTB=rn6wg@mail.gmail.com>
 <CAHk-=wguzgJu4p_khuEXKHmh-6abSN7xLJdCTuyVEfjsopY7iQ@mail.gmail.com>
 <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com>
 <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com> <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com>
In-Reply-To: <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 28 Mar 2025 09:23:43 -0400
X-Gm-Features: AQ5f1JquBOHTXcz9ItopeaYBw31lCTQkjJWo5__13HnLiHPGNaajByJOsHyuu34
Message-ID: <CAEjxPJ4Np-_LeSQOPxRQggZjWxpJRhZm++XuEwNbMyUkZCvYjw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 3:40=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 27 Mar 2025 at 12:16, Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Where could/would we cache that information so that it was accessible
> > directly by the VFS layer?
>
> So the VFS layer already does this for various other things. For this
> case, the natural thing to do would be to add another IOP_xyzzy flag
> in inode->i_opflags.
>
> That's how we already say things like "this inode has no
> filesystem-specific i_op->permission function" (IOP_FASTPERM), so that
> we don't even have to follow the "inode->i_op->permission" pointer
> chain to see a NULL pointer.
>
> Yes, the VFS layer is *heavily* optimized like that. It literally does
> that IOP_FASTPERM to avoid chasing two pointers - not even the call,
> just the "don't even bother to follow pointers to see if it's NULL".
> See do_inode_permission().
>
> And we have 16 bits in that inode->i_opflags, and currently only use 7
> of those bits. Adding one bit for a IOP_NO_SECURITY_LOOKUP kind of
> logic (feel free to rename that - just throwing a random name out as a
> suggestion) would be a complete no-brainer.
>
> NOTE! The rule for the i_opflags accesses is that *reading* them is
> done with no locking at all, but changing them takes the inode
> spinlock (and we should technically probably use WRITE_ONCE() and
> READ_ONCE(), but we don't).
>
> And notice that the "no locking at all for reading" means that if you
> *change* the bit - even though that involves locking - there may be
> concurrent lookups in process that won't see the change, and would go
> on as if the lookup still does not need any security layer call. No
> serialization to readers at all (although you could wait for an RCU
> period after changing if you really need to, and only use the bit in
> the RCU lookup).
>
> That should be perfectly fine - I really don't think serialization is
> even needed. If somebody is changing the policy rules, any file
> lookups *concurrent* to that change might not see the new rules, but
> that's the same as if it happened before the change.
>
> I just wanted to point out that the serialization is unbalanced: the
> spinlock for changing the flag is literally just to make sure that two
> bits being changed at the same time don't stomp on each other (because
> it's a 16-bit non-atomic field, and we didn't want to use a "unsigned
> long" and atomic bitops because the cache layout of the inode is also
> a big issue).
>
> And you can take the IOP_FASTPERM thing as an example of how to do
> this: it is left clear initially, and what happens is that during the
> permission lookup, if it *isn't* set, we'll follow those
> inode->i_io->permission pointers, and notice that we should set it:
>
>         if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
>                 if (likely(inode->i_op->permission))
>                         return inode->i_op->permission(idmap, inode, mask=
);
>
>                 /* This gets set once for the inode lifetime */
>                 spin_lock(&inode->i_lock);
>                 inode->i_opflags |=3D IOP_FASTPERM;
>                 spin_unlock(&inode->i_lock);
>         }
>
> and I think the security layer could take a very similar approach: not
> setting that IOP_NO_SECURITY_LOOKUP initially, but *when* a
> security_inode_permission() call is made with just MAY_NOT_BLOCK |
> MAY_LOOKUP, and the security layer notices that "this inode has no
> reason to care", it could set the bit so that *next* time around the
> VFS layer won't bother to call into security_inode_permission()
> unnecessarily.
>
> Does that clarify?

Yes, thank you. I think it would be easy enough to make that change to
selinux_inode_permission() and to clear that inode flag on file
relabels (e.g. in selinux_inode_post_setxattr() and
inode_invalidate_secctx()). Not as sure about handling policy reloads
/ boolean changes at runtime without also caching the policy sequence
number in the inode too so that can be compared. Further, I'm unclear
on how to implement this in a manner that works with the LSM stacking
support, since some other module might disagree about whether we can
skip these lookups. Normally I'd just add an extra boolean or flag
argument to the underlying ->inode_permission() hook so each module
can indicate its decision and
security/security.c:security_inode_permission() could compose the
result, but I guess that would require switching
security_inode_permission() from using call_int_hook() to manually
doing the lsm_for_each_hook() loop itself which may have an adverse
impact on those calls in general.
