Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5921D58F
	for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104431; cv=none; b=tNQEVQue0f5P4o8uL01p5Ln/o+ZDj8dYfI4LHu+YHCfJeMYh89PoK+ErfEQhCHUnRIvI4mxT/pMm63nD7mmf3oIEHt/cBNcJhMBYtNtzkSIxDfX+9diNduthXpgBPFjXTxCBdpVbx3TymrX/vZEwRhnYtroSbtyK9EZ7jPt6mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104431; c=relaxed/simple;
	bh=Am6MfhmhhKahON+wcT6CJkFPn4eNFrNyfxwl40UWhHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJO0V50GkNAUJgp/CPbMAvwYr5HdyJBpQ/CQW37+Sl6PSDKwm1hiMS59b4ogF7jKzyejggRwrTgauSu/B+/FwEVOZDdjKsJmrjDYK/jkAy+Wgm7IBmWuOqRvr2ZBpJ4j9HAqFO2+TH/UPrbu/X+Nny77oZxKlqwgAT6OkohG7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T90HRIns; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T90HRIns"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac29fd22163so243595166b.3
        for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743104427; x=1743709227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JEq/0HpybPrPkftoA0ZBHzqv4jivtz6CrXQUZogyrs=;
        b=T90HRInsQS0OK8MZrmYTQjIXtw7B5RJCo3tWDPvbIl7rcqLazG+zCtXkMZrdaLZi67
         Con/ATOCTkO27H6ajxNcAxbkiNAC4wXXaR9GLQn44QnPhiN5BqZW08OBQrN8mMXCUCtV
         7rfOBBAcdFen1xBXzbxhqPSsEaLJEqwSotXNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104427; x=1743709227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JEq/0HpybPrPkftoA0ZBHzqv4jivtz6CrXQUZogyrs=;
        b=Q38V/c51bniZwvj81HP1GM4w0QVlR6MRhm5GcmK/cVxWEBAY82N8YV6E10a5H4uYOd
         KOyLe6Lk9T/AldmLxKOzp6BRf7eiv42rLSbFL5dh9jgmjX8Z5WT4kFZRUU61kMDdnURv
         hOPJDy6g0ZTuvw0tY3yeYBuE69qunXDev2Iw9/rbnN9WWElNWpfhQJJcDhwEcVGew9FA
         Gvw/o4BNURGh9Z7o6JZ4JMcAUFAbgTV7oYS35aNZenhKEJr0U8fV/zQRRRADoM0OLcsf
         HAB7TtZCtL3XZdsIhrR3M2FpsaK/Jrw6YsNbHMYAYVL4bo/dB3lLQxWrM00phQ1WI1Hs
         qTsg==
X-Forwarded-Encrypted: i=1; AJvYcCWDiEXNVRIKsKyyYYARI4TJZ4kM+rID+NGE50fqlsN7hehNJ7dmCcYaLgA8Qi1Nw4gUdSjkiT2S@vger.kernel.org
X-Gm-Message-State: AOJu0Yysh5aR7hF5pXBbymE3pOvOMf67FhMRoMZpuDeTpF2a6hWlglhe
	4orJMLWoAepGgTzd4VGdqN0Zx7lVZFl71ZA2ZnI+YyXCai+CVMyFFJZnGmOjEMlYhDKaG4akF17
	xmFk=
X-Gm-Gg: ASbGncs6hgA9etvMmgUmTxAWGOvW5IQ36ngsyaPM2a9oxecLjhlKD4WxFokEtFvsj8T
	PeE7QR1Xt79Bq3Ajnnwrit4Bd+mi2R4u3xTJV8AMf0F900V5C0kpv7jAfBJVNKKbGfaPjMMc5Rs
	jV0ecr7t5Y34bhT+Qc4fGicr4Cg3bTHwVuVa89xlttP+rRvkK3XHaRQQ45vKjEg8YXUHZlHtm/9
	TmKDiJuEo5qKKLGa2g2zyb/oj7umiJ9hticUG4IkstQO66H9IF4ShPtQc4fl/KveCTbUrBnZQCb
	sxp9c7eH7+0PLopfZ40i4dYVzIOK0Nte0d6r9RVrwC9M5lHNDVdjHUt0SUDcIqMf0fuNyblyf10
	cRjBlo7ucW17sTcvH/cc=
X-Google-Smtp-Source: AGHT+IFYAxN//d5gk3o3zzTfKkMX/6W4fb105aom2x8TS2nia2SCSrEe35Ik60CvWH6JVqYqmvzytQ==
X-Received: by 2002:a17:907:2d9f:b0:ac6:d9fa:46c8 with SMTP id a640c23a62f3a-ac6fb100915mr503482966b.39.1743104427391;
        Thu, 27 Mar 2025 12:40:27 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7192ea03esm42558366b.84.2025.03.27.12.40.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 12:40:26 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso213241066b.1
        for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 12:40:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMZQYXw6xB9IT1ghh7Nm/1ylc5j9NeTfDerGATDva1aptPhp+pZxCU+DOEQvEto2fN3h7a+DEF@vger.kernel.org
X-Received: by 2002:a17:906:794a:b0:ac2:dfcf:3e09 with SMTP id
 a640c23a62f3a-ac6fb100848mr518877966b.43.1743104426218; Thu, 27 Mar 2025
 12:40:26 -0700 (PDT)
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
 <CAHk-=wh4H3j3TYWn6KSgznUsOXz8vfHMOfTNmFvjGr=hwULWsw@mail.gmail.com> <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Mar 2025 12:40:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com>
X-Gm-Features: AQ5f1JpsgpsoU5qvy0FXDgptv2LfsiQnXe2KM7mTv3DMgNv1TpFR9zIlmzjZ8ug
Message-ID: <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 12:16, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Where could/would we cache that information so that it was accessible
> directly by the VFS layer?

So the VFS layer already does this for various other things. For this
case, the natural thing to do would be to add another IOP_xyzzy flag
in inode->i_opflags.

That's how we already say things like "this inode has no
filesystem-specific i_op->permission function" (IOP_FASTPERM), so that
we don't even have to follow the "inode->i_op->permission" pointer
chain to see a NULL pointer.

Yes, the VFS layer is *heavily* optimized like that. It literally does
that IOP_FASTPERM to avoid chasing two pointers - not even the call,
just the "don't even bother to follow pointers to see if it's NULL".
See do_inode_permission().

And we have 16 bits in that inode->i_opflags, and currently only use 7
of those bits. Adding one bit for a IOP_NO_SECURITY_LOOKUP kind of
logic (feel free to rename that - just throwing a random name out as a
suggestion) would be a complete no-brainer.

NOTE! The rule for the i_opflags accesses is that *reading* them is
done with no locking at all, but changing them takes the inode
spinlock (and we should technically probably use WRITE_ONCE() and
READ_ONCE(), but we don't).

And notice that the "no locking at all for reading" means that if you
*change* the bit - even though that involves locking - there may be
concurrent lookups in process that won't see the change, and would go
on as if the lookup still does not need any security layer call. No
serialization to readers at all (although you could wait for an RCU
period after changing if you really need to, and only use the bit in
the RCU lookup).

That should be perfectly fine - I really don't think serialization is
even needed. If somebody is changing the policy rules, any file
lookups *concurrent* to that change might not see the new rules, but
that's the same as if it happened before the change.

I just wanted to point out that the serialization is unbalanced: the
spinlock for changing the flag is literally just to make sure that two
bits being changed at the same time don't stomp on each other (because
it's a 16-bit non-atomic field, and we didn't want to use a "unsigned
long" and atomic bitops because the cache layout of the inode is also
a big issue).

And you can take the IOP_FASTPERM thing as an example of how to do
this: it is left clear initially, and what happens is that during the
permission lookup, if it *isn't* set, we'll follow those
inode->i_io->permission pointers, and notice that we should set it:

        if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
                if (likely(inode->i_op->permission))
                        return inode->i_op->permission(idmap, inode, mask);

                /* This gets set once for the inode lifetime */
                spin_lock(&inode->i_lock);
                inode->i_opflags |= IOP_FASTPERM;
                spin_unlock(&inode->i_lock);
        }

and I think the security layer could take a very similar approach: not
setting that IOP_NO_SECURITY_LOOKUP initially, but *when* a
security_inode_permission() call is made with just MAY_NOT_BLOCK |
MAY_LOOKUP, and the security layer notices that "this inode has no
reason to care", it could set the bit so that *next* time around the
VFS layer won't bother to call into security_inode_permission()
unnecessarily.

Does that clarify?

             Linus
