Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748817A309
	for <selinux@vger.kernel.org>; Fri, 28 Mar 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743179837; cv=none; b=TihKkb+Ery7RV5ylfAKLascbRpcmq7lvKWpo9/dsfvuX2kp/C3CgXraWXGUHuy6wtLf+qJh7GiCSudhl/+WWZpW0usxlPt6fRytgNBs2cBcfLy1HoJnsRtNkxKCfpRnAgGPwudOf//oiH6kSPtr9/IJnL1wmQWOSmJ2FEsQ4Hng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743179837; c=relaxed/simple;
	bh=ULl5UK3oFQ9q/cNxlRCfD7aZE+LrB+LLXHDwmSrUIFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJbKiEcmcHa3xy3+pb3IDz+ycoKWChCo8o7rYlOetMGQNUYUuxKj4YilbpiQppGLpvgAJDYf8O+zMyteT585d9DnQRzSo6D1LDcB7W+JulHyT4+uUMSLdkQndLrbPSk8aJKwlBbr643dNkAYDHkDEhW1mruN/2bgrIp/WKgVrZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TMjd4RGt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TMjd4RGt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso357867166b.1
        for <selinux@vger.kernel.org>; Fri, 28 Mar 2025 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743179833; x=1743784633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXVkC5ZKzdf5MGzGMM5XBmod+0oYx5WgsNgrWhdrxzo=;
        b=TMjd4RGtwwS0vLaSfUvnbo8p3rbZ8ezbs0oGtl+dKn4QvqauSQcqboWhki2uhvqRhk
         GIQhOflVQchTklwbtpEr3oXeIfyaMzQ1GKKH9ehjCInc5DxDMnYm53HrR7JFnkxQ+tpB
         4+yLoPnCYy5FP/u5/kWbAubAAYoh+JDTDZRlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743179833; x=1743784633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXVkC5ZKzdf5MGzGMM5XBmod+0oYx5WgsNgrWhdrxzo=;
        b=aBSEYeOJyXz9k0TX01mssE8n+lZfGrCMjQL/TPtkEdWhsn77WQ1eKGgsH/6tqA2yoq
         Em0W77PN1aF7UKNgIri9BnsrD6y3JFYJfHedRJINZ4eBP7BFnTxFdresgb/50nob7FYh
         B6utetCzgBJTK+dHtRmzYSFUV9EXW5uu+pzwtdrSshGelk6zpO98YP2kLM5NxxCWDmai
         fi+BQR/KMgREJp5fiWZTEYOI/AyA7nvLDbXV4SCFZTFGXKau/VRtZgrgJZ9KKYFh+hG2
         CxaI20XENcMCsjbHz78Ars3O5deA2/lnPyIEWMGcW4UppeqWVpswqQ8xe2cXWrLYuuA8
         /XSg==
X-Forwarded-Encrypted: i=1; AJvYcCX28JR7WS1fnSCMvzTyiMLG60tL+vqOSVMkBAAFNJDpAg1YCxcm3fl4iYmk+9ZawJmioGKKK3o1@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxHBKFlpXrfyBLF7drg8o5DqXGlQQKYuv5UODlDSIVKY/Jzyw
	WnHKNldMI6Y6aBXoyGJuV5q4lM4FTS2dsJomPu8Ivdlts2iSCV3BmV/13EjFvvMWVpMSB+wtujx
	sCI8=
X-Gm-Gg: ASbGncurCiJS2gJSoMusCJrGABnBSosTdjeTFw3YFyCbyVZ+OfT15IKDHPpAqVfyWFZ
	E9u+loftwWZXDKTXbgnyxg4IpdOCFOpRB0zs5/2i8toa2ukXJH/ntzUfMfdC00z9OtMN3M6xXHm
	Yye1TXRMgOrDG5PR5NRcgnyopBLH3NznXxxcu9aS6gfzQq05cCu3m0yp6npb/9NdItHdaMSpXlt
	R796G3kJ5h4WVonGbHfHIKijHntZJDZo9UDT5crHtZUT1FLDlNdn642xwcqd4aQVNIcxR7G+pzf
	ssvYS4LgWzRY+YCrF5ao7yD9PkXzZlpWQV/YdPRgzGsyLTCcb1nQIIh6EhLbejv6Qm0PufKsVzi
	RGCbztBt6FcN0vTcqfbVkp39oRAMAnA==
X-Google-Smtp-Source: AGHT+IE0zFCQQ73V8KjianvXRjD/lRp4nGrdR+8zNCTniYVLzs+pE12ptIjLWDzk9vNal7epCJ7Vlg==
X-Received: by 2002:a17:907:1c22:b0:ac2:fd70:dda3 with SMTP id a640c23a62f3a-ac6fb100878mr674722566b.35.1743179832846;
        Fri, 28 Mar 2025 09:37:12 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922b975sm189052366b.18.2025.03.28.09.37.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 09:37:11 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso357861166b.1
        for <selinux@vger.kernel.org>; Fri, 28 Mar 2025 09:37:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPclBHhzL1I0f+LVkXcjXCceqr25Nr+xrdCNo3cQOcRHmAPfzPGNy8GB4QpppcSGAYLiva7Z4S@vger.kernel.org
X-Received: by 2002:a17:906:f5a4:b0:ac2:a089:f47c with SMTP id
 a640c23a62f3a-ac6fb14f400mr900112466b.55.1743179831124; Fri, 28 Mar 2025
 09:37:11 -0700 (PDT)
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
 <CAEjxPJ4fzoONpiy3z8QOZ55w35=WfWQ+hiTg24LMEHPpnaC87Q@mail.gmail.com>
 <CAHk-=wjbSRL7LM7CvckB+goQdUokMa_6G-iirdbtxrFSFe3mfA@mail.gmail.com> <CAEjxPJ4Np-_LeSQOPxRQggZjWxpJRhZm++XuEwNbMyUkZCvYjw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4Np-_LeSQOPxRQggZjWxpJRhZm++XuEwNbMyUkZCvYjw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Mar 2025 09:36:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoXr5GCHZsarzUKELLMAtcw0Qpmz_i+nenCVtBY1iBig@mail.gmail.com>
X-Gm-Features: AQ5f1JqbOiFjnRTugzf_SGU5_AiyByHDa4dcIekBVrd5UWSkoiVxUwvn-Twr2CY
Message-ID: <CAHk-=whoXr5GCHZsarzUKELLMAtcw0Qpmz_i+nenCVtBY1iBig@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Mar 2025 at 06:23, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Yes, thank you. I think it would be easy enough to make that change to
> selinux_inode_permission() and to clear that inode flag on file
> relabels (e.g. in selinux_inode_post_setxattr() and
> inode_invalidate_secctx()).

So the thing that *really* made me go "I don't know how to do this in
the security layer" is not so much the relabeling - that should be
easy to handle by just clearing the bit, as you say.

And I wasn't even so much worried about policy changes that would
globally change meaning of existing labels:

> Not as sure about handling policy reloads
> / boolean changes at runtime without also caching the policy sequence
> number in the inode too so that can be compared.

Yeah, a sequence number seems like an obvious solution, even if it
might be a bit awkward to find a place to store it that doesn't
pollute the cache. The reason it would be _so_ nice to not call the
security hooks at all in this path is that I think we otherwise can do
all the inode security lookups by just looking at the very beginning
of the inode (that's why we do that IOP_FASTPERM thing - just to avoid
touching other cachelines). But if it avoids the
security_inode_permission() call, it would definitely be a win even
with a cache miss.

> Further, I'm unclear
> on how to implement this in a manner that works with the LSM stacking
> support,

So *this* was what made me go "I don't know how to to this AT ALL",
along with the fact that the rule for the bit would have to be that it
would be true for *all* execution contexts.

IOW, it's a very different thing from the usual security hook calls,
in that instead of saying "is this access ok for the current context",
the bit setting would have to say "this lookup is ok for _all_ calling
contexts for this inode for _all_ of the nested security things".

The sequence number approach should take care of any races, so that
part isn't a huge problem: just set the inode sequence number early,
before doing any of the checks. And then only set the bit at the end
if every stacked security layer says "yeah, this inode doesn't have
extra lookup rules as far as I'm concerned". So if any of the rules
changed in the meantime, the sequence number means that the bit won't
take effect. So that part should be fine.

But the "this inode doesn't have extra lookup rules" part is what
needs low-level knowledge about how all the security models work. And
it really would have to be true in all contexts - ie across different
namespaces etc.

(Note the "extra" part: the VFS layer deals with all the *normal* Unix
rules, including ACL, of course. So it's literally just about "are
there security hook rules that then limit things _beyond_ those
standard permission rules")

It might be worth noting that this call site is special for the VFS
anyway: it *looks* like a normal security hook, but "may_lookup()" is
literally *only* used for directories, and *only* used for "can I do
name lookup in this".

So if it helps the security layers, that case could be made into its
own specialized hook entirely, even if it would require basically
duplicating up "inode_permission()" that is currently used for both
the lookup case and for "generic" inode permission checking.

For example, I do know that SElinux turns the VFS layer permission
mask (it things like "MAY_EXEC") into its own masks that are different
for files and for directories (so MAY_EXEC becomes DIR__SEARCH for
SElinux for directories, but FILE__EXECUTE for when doing 'execve()'
on a file).

And so that's an example of something we could short-circuit here,
because *all* we care about is that DIR__SEARCH thing, and we know
that statically.

But I know selinux better than any other of the security models, so I
don't know what *any* of the others do (and honestly, the selinux code
I don't know that well - I've looked at it a lot, but I've really only
ever looked at it in the "I'm looking at profiles, is there anything
obvious I can do about this" sense).

                 Linus
