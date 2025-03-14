Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB135893
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915747; cv=none; b=g+ibdLDZtTqTwjrcMpFFI5+B8Ltz/NiT35Y1ketPL1i/T09Q7LFwvY3S1qQOftlAHw/NnwnyCTC7z16SQ/BKl9695HsZ8/9gc/JEWvTd0STvzg0Rs2ENi6T4N271GO2igwZyDSBKNf/GLl1icL3t5Qw05CkD6selCbcbzPBU9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915747; c=relaxed/simple;
	bh=X3iUNC2W7CqTwo25rU762CJ50V9BUX84A2chKkBkXIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRf2vMdb20Tx97QhiezWEQrGZEa6Em8Ijg+TjP1+zhGUyh8K1bb+/2GAnNlHg6JzdgSjXDQ8AA1b7ZYgsy+RF/ZRuExZOQfN18Y5q7ohFmd772l5+ojp72ZHp73o8L9oZ+ZvFUjr2I1E7ENqG3XikX9zsrbpY3eH/pDm4ReI2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L7G91dQn; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L7G91dQn"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso1360100276.3
        for <selinux@vger.kernel.org>; Thu, 13 Mar 2025 18:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741915744; x=1742520544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ES0wXessMMgqNwSiif0rlYAGpc7YP1QvwA1ts5IWAs=;
        b=L7G91dQnQDp62jON5T5/YaMkHIMonIY8uPtBTsCTXmwcBz3Ra20xw0rIybModsmiYM
         5QFtVFZw7GZB7jrHKV8ziYwMcMx0ea+J0qOl9bUXgKJf2NzKnD4ok+Yl6A5bmqRFPVYY
         OAUl5CHTSUqUCNO2mM/TFroejkiZYQ5GTgURjvn+HqW53bynz10X23pwTAV6g3+0XM+z
         YPsTmi6nHQQc+4Ax461I/eiellYKxphyp7H+rCzxv5iQGMoXulK7z/MlYdq0XJb/hzC4
         cx2fzQATDu3X8uzVRP3oJJ6YbummtYvVrztuVbHB9hN6cws7A4LRaJLwGHMAVt5s2WOG
         RCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741915744; x=1742520544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ES0wXessMMgqNwSiif0rlYAGpc7YP1QvwA1ts5IWAs=;
        b=sTsz+59Mr0yvloOOTJrR14fArg4lylkTTVSh4wcJW75XhFQD4CmHZz7PqnqRKtfmNl
         OH9OIwN7wdKWi227AhVVBUI2KmVAT0agftLlVmMrQ45gywNxqccgggAqjIGGTLjTeUgH
         k187XJSm0C6zqqgJowi7zxczlsU1Cc9SFlTNfYGg6UwiqFy0vt71xFoqBulDkfoMRKby
         0r/hbq/W/oqaS9pMnsIhmIc3cLwh4IAR1AqfbFlp2Sw2Smls6Rp4Er3PnZHznWnpz07L
         SHXA19nfL8IvEOfEm0LHjb9ebwsWOHuQ66DZ+V80loyaTM5Lm6EwUR0SmUp48bNLy1e6
         jWDg==
X-Forwarded-Encrypted: i=1; AJvYcCUeqUhvDbWPIj26whYWINCW8XoIxaEDxFGkM7KgidKhktrGYbeK+ZA5ngYobvDjTkSN0i7VPz2I@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzaw4LZIKKLKin9OvJYa5gGGocNcf7ShsGCvQJrMfp5O7fFUm
	zNHXl8N85/kXkCO6k3el+5j7CpuEpPHWIFCjE8zPxXhEhIhs4Vub+UNTqgc9jXimur/A34NuWJm
	oVOIXYWAyoMg2Yys/VdovLZIsRULqyPcCcKJC
X-Gm-Gg: ASbGncu/pE/QPst3NboyKxHqRf9uFroSapyAcPkxosqwdqQxRUwTTb5N42kt1iIWE9v
	nnsMwF6Emh1iDcMTRjhSFd+QTtMQJ6OuwDZPjal3xiSzWPh8IV+4e/7AEdbX6ORLvITJZb1VK7f
	S+RglZEFu6CI4t+lCAIerG+LzhEQ==
X-Google-Smtp-Source: AGHT+IHD2TiU6XQ9tRFKuzzp3FmVek4PiqtcVodzoMshBpH8NjFlYdg8BZn1Vv4kyVm787txJ/ZZdGY4pPNsB4MucI4=
X-Received: by 2002:a05:6902:15c7:b0:e5b:3b7a:fca7 with SMTP id
 3f1490d57ef6-e63f65b4672mr1039551276.39.1741915744021; Thu, 13 Mar 2025
 18:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312212148.274205-1-ryan.lee@canonical.com>
 <20250312212148.274205-2-ryan.lee@canonical.com> <20250312213714.GT2023217@ZenIV>
 <20250313-dompteur-dachten-bb695fcbebf1@brauner>
In-Reply-To: <20250313-dompteur-dachten-bb695fcbebf1@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Mar 2025 21:28:53 -0400
X-Gm-Features: AQ5f1Jo3Xy-0BZ6a7vddrckfIRl2pXF8wj3ycyI4FjDAH-FopUDoNWqpGjlm6MY
Message-ID: <CAHC9VhScqcF12XYdqMSsLg55=nux6mjEGfxCpZHEzv-bGyP7Ew@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] fs: invoke LSM file_open hook in do_dentry_open
 for O_PATH fds as well
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Ryan Lee <ryan.lee@canonical.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 4:50=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Mar 12, 2025 at 09:37:14PM +0000, Al Viro wrote:
> > On Wed, Mar 12, 2025 at 02:21:41PM -0700, Ryan Lee wrote:
> > > Currently, opening O_PATH file descriptors completely bypasses the LS=
M
> > > infrastructure. Invoking the LSM file_open hook for O_PATH fds will
> > > be necessary for e.g. mediating the fsmount() syscall.
>
> LSM mediation for the mount api should be done by adding appropriate
> hooks to the new mount api.
>
> > >
> > > Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
> > > ---
> > >  fs/open.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 30bfcddd505d..0f8542bf6cd4 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -921,8 +921,13 @@ static int do_dentry_open(struct file *f,
> > >     if (unlikely(f->f_flags & O_PATH)) {
> > >             f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > >             file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> > >             f->f_op =3D &empty_fops;
> > > -           return 0;
> > > +           /*
> > > +            * do_o_path in fs/namei.c unconditionally invokes path_p=
ut
> > > +            * after this function returns, so don't path_put the pat=
h
> > > +            * upon LSM rejection of O_PATH opening
> > > +            */
> > > +           return security_file_open(f);
> >
> > Unconditional path_put() in do_o_path() has nothing to do with that -
> > what gets dropped there is the reference acquired there; the reference
> > acquired (and not dropped) here is the one that went into ->f_path.
> > Since you are leaving FMODE_OPENED set, you will have __fput() drop
> > that reference.
> >
> > Basically, you are simulating behaviour on the O_DIRECT open of
> > something that does not support O_DIRECT - return an error, with
> > ->f_path and FMODE_OPENED left in place.
> >
> > Said that, what I do not understand is the point of that exercise -
> > why does LSM need to veto anything for those and why is security_file_o=
pen()
>
> I really think this is misguided. This should be done via proper hooks
> into apis that use O_PATH file descriptors for specific purposes but not
> for the generic open() path.

I agree that this patchset is at best incomplete, we don't add LSM
hooks without at least one in-tree LSM demonstrating a need for it,
and we don't see any of the LSMs actually making use of this new hook
placement in this patchset.  In the future Ryan, please ensure that
the patchset actually does "something" visible, e.g. new
functionality, bug fixes, etc.  I understand part of your intent was
to spark some discussion around O_PATH files, but without some initial
code to do something meaningful, it's hard to have any real discussion
that doesn't get lost in some rathole or tangent.

Beyond that, I can only speculate on Ryan's intent here, but based on
some off-list discussions, it's possible Ryan is (re)using the
security_file_open() hook in the O_PATH case not necessarily to gate
the creation of an O_PATH file, but rather to capture some of the
context when the O_PATH file is created.  However, if that was the
case I would think Ryan should be able to do that using the
security_file_alloc() hook, although we would need to pass the file
flags to that hook if Ryan wanted to do any special handling around
O_PATH.  Regardless, it's just guessing at this point and I've got
enough things asking for attention that I can't spend any more time on
this patchset simply guessing ...

--=20
paul-moore.com
