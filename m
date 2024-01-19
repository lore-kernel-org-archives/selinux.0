Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAFD54780
	for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679031; cv=none; b=bF1indYSGoyKUbpUWySnyK6ODRBBZrkVK7XUGrOMS73XNfu3FSV9GuUHgLRoF1/Dxc6dvf0rght22KSKBO1swjDjlHypB81E5YdUmUDBHU+bgyRAmvjKZAf3dnajjArSyn1eqrWuiEIJurCnjF7W435373rb5t8Jv8DmZiAZJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679031; c=relaxed/simple;
	bh=PU8nXLhozoYam/WFYylHsc3J2wJDVzjyCAuJyErvDuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tlk2Jk8AV78fca6am17gyfQT5IvRs0HbnbjQGUYshCZUYn1ORrjdt49MeYpfs9D6iO4zQF54uo5ymCWGVTalrLvBy1YCH/yd8kNM6bF0hTrWZOHPzimFj8ICpf8cZBx7WQjBpCZapgJX4uVCt64HBW4OxcjCVZHHedWCQ7xrLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivyVU42k; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivyVU42k"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso680349a12.3
        for <selinux@vger.kernel.org>; Fri, 19 Jan 2024 07:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705679029; x=1706283829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFzC0ekDKChVVtSTYn3lUoL099Z6MyLmhimbwezUNTg=;
        b=ivyVU42kbuxRtjYfwiTOeMqJpeSmJ5LxNd6tOsFbDUi23ZdaWzXeRVgyvjnvv5eAuk
         jyHMww2ZzMFnx6w5/VkbmDRlZj1D0LeLVuwr9JwgHFkBeG4AEsAjtfC6q7Dw21m9+K1z
         0SqBg1gmQ5J299viyHqAwABTEyT1/cc+ON0K1Qj+ixYMjPdLbIwc7Sa1aPg3WVYuhOZg
         Vv1LKJnd/hHS8+j0eMCDBZKlI4ggrIRyd63KdO4LFCDU1uyXr7nE0bo2DsszqZeMx/A9
         37Fe8iLIohK9xfaij0SGbA/hTiWkTQe0tDgGqqvdLqh7D4dSAwZW0G5D8CW2gp73LowA
         vxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679029; x=1706283829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFzC0ekDKChVVtSTYn3lUoL099Z6MyLmhimbwezUNTg=;
        b=PZp44be+hWSVXMpdsN1Q6DT1xjdTXfAPPtjy4jpKyGBXXXCEoWDPWTLkhlo6DGuT3K
         gGnTEXqsJS/82/yVC5DzwrIpchQzUmu7b75nlO/tWGEgRbFUMAyzkz+g3Nv59s7hH//R
         f5XXwf2MCJEUrLfk1bVp94HYe5I/L8hn1fuZlzCZiOZGQ5wmJIKhGc5x6Nn4fCsUxq58
         frlDwE/it2XL397H7v/aAXA5N9eUkdZSy0nFGb/u65jDVpn7j6lvmzz1MyKazawVnqrf
         MXpvCxBwFCIuCKLoczc9HH/E/Tq6E71Zr5Eq3Q6JDEP60119syaOmHU4WZLfLRA+06bv
         IDCw==
X-Gm-Message-State: AOJu0Yx3fhRsKm3X03Xuh4Gpqc6SMa7MuBsTM2QjICFhjDiWAsUl7l+o
	SYIGS2XqmWzTp/O7YMri37BFkQ8N8u+zR24Rb7WLiadaZ41qnAIREPirKQwSph00H5ZltshfGtG
	AA0Py7QON10FchhWl5LPWdHKI/jY=
X-Google-Smtp-Source: AGHT+IEPx8uRsig0Q52LYifhYMz3CLkBi6VAxmTPmmf8RgbHnGxMQAzVkgnWsOoQbrzWgyWyqBh04QzwQUTl+bLenqc=
X-Received: by 2002:a17:90a:db50:b0:28f:fd7b:42b8 with SMTP id
 u16-20020a17090adb5000b0028ffd7b42b8mr2116666pjx.76.1705679029389; Fri, 19
 Jan 2024 07:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALbthtcf4m5vPK7xLZhzk8W_7ETkNPeR3bnaM06BtzuQy8w-jQ@mail.gmail.com>
 <CAEjxPJ7ZB3PtVjvJf9u-C7JGNpGv53O9TGu7o5EadMHy2hHE5w@mail.gmail.com>
 <CAHC9VhTpG=x-9Mm5b6xKtYoAswhtWA43FJqrwRHYbr3XwSPYeg@mail.gmail.com>
 <CAEjxPJ4LOY5C3sd-oM8L_8fKC5QhrreBN7=GXR1uyYv_hphNVQ@mail.gmail.com> <CAHC9VhSnbU_0WEFVrgm2rakNg3aeCs2OE1of0BavgOTmJWwnAQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSnbU_0WEFVrgm2rakNg3aeCs2OE1of0BavgOTmJWwnAQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 19 Jan 2024 10:43:38 -0500
Message-ID: <CAEjxPJ5aFRC86k9vFE-TWO=3TQZxD+scaWo9F-cgRUoAnbK2Zg@mail.gmail.com>
Subject: Re: Race in security/selinux/hooks.c on isec->sclass and isec->sid usage
To: Paul Moore <paul@paul-moore.com>
Cc: Gabriel Ryan <gabe@cs.columbia.edu>, omosnace@redhat.com, selinux@vger.kernel.org, 
	dpquiql@davequigley.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 4:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Jan 18, 2024 at 3:47=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Jan 18, 2024 at 3:19=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Thu, Jan 18, 2024 at 12:02=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Jan 18, 2024 at 11:26=E2=80=AFAM Gabriel Ryan <gabe@cs.colu=
mbia.edu> wrote:
> > > > >
> > > > > We found a race in selinux for kernel v6.6 using a prototype race
> > > > > testing tool based on modified KCSAN we are developing. We are
> > > > > reporting the race because it appears to be a potential bug. The =
race
> > > > > occurs on isec->sclass and isec->sid, which are set in
> > > > >
> > > > > security/selinux/hooks.c:3329-3330 selinux_inode_post_setxattr
> > > > >
> > > > >         isec->sclass =3D inode_mode_to_security_class(inode->i_mo=
de);
> > > > >         isec->sid =3D newsid;
> > > > >
> > > > > Where isec->lock is held when isec->sclass and isec->sid are set =
above
> > > > > but not held when they are read in the following 3 locations:
> > > > >
> > > > > security/selinux/hooks.c:1671 inode_has_perm
> > > > > security/selinux/hooks.c:3125 selinux_inode_permission
> > > > > security/selinux/hooks.c:3690 ioctl_has_perm
> > > > >
> > > > >
> > > > > This seems like it could lead to undefined behavior if multiple
> > > > > threads are reading the isec struct and updating it concurrently,
> > > > > (e.g., reading an old isec->sid value but new isec->sclass value)=
.
> > > > >
> > > > > In some other cases in security/selinux/hooks.c, isec->lock is he=
ld
> > > > > when isec->sclass and isec->sid are accessed, such as in
> > > > > security/selinux/hooks.c:4942-4945 selinux_socket_accept. Therefo=
re,
> > > > > extending the isec->lock to cover when sclass and sid are read fr=
om
> > > > > the isec struct in these three locations might be a suitable fix.
> > > >
> > > > isec->sclass should only really need to be set once when isec is fi=
rst
> > > > initialized after mode format bits have been set.
> > > > Not sure why it is getting assigned again in post_setxattr.
> > >
> > > There is similar odd behavior in selinux_inode_setsecurity().  Lookin=
g
> > > at the other places in hooks.c where we are setting isec->sclass, I'm
> > > wondering if this is a copy-n-paste from one of the other places that
> > > does have a need for it.  The pattern of "lock, set the sclass and
> > > SID, mark the inode as initialized, unlock"  occurs in at least three
> > > places that I can see in a quick search.
> >
> > git blame indicates that the setting of isec->sclass was added to
> > inode_post_setxattr() and inode_setsecurity() by commit
> > aa9c2669626ca7e5e5ba ("NFS: Client implementation of Labeled-NFS").
> > Not sure why - do NFS inodes get initialized in some manner that skips
> > the usual setting?
>
> I don't know, but I wouldn't be surprised, we've definitely had to do
> some NFS-specific things over the years.
>
> > It's fine to set it in inode_doinit_with_dentry() when initializing
> > the inode security blob for existing inodes and in
> > selinux_inode_init_security() for newly created ones - no other thread
> > can be reading it at that point.
>
> Yes, when I said "odd behavior" I was trying to get at the original
> discussion that it doesn't make much sense there, regardless of the
> safety.  I can potentially see a need for it as-is in
> inode_doinit_with_dentry() but I haven't chased down all the call
> chains as that would take a while, and like you say, it should be
> safe.
>
> > selinux_task_to_inode() is a special case for /proc inodes.
>
> Yes, I believe that needs to stay.
>
> > selinux_socket_post_create() and
> > selinux_socket_accept() should set it before the socket can be
> > accessed by userspace or via an incoming packet.
>
> Agreed. (it looks okay there as-is)

Arguably setting it in post_setxattr and _setsecurity is a bug because
it would replace a socket security class with a file security class on
a socket inode if one performed a fsetxattr() on a socket. We don't
really support that anyway since there is no way to propagate it down
to the sock.

Tempting to remove from both and run the NFS tests (tools/nfs.sh) to
check for regressions.
