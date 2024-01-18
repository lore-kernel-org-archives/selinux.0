Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B02E825
	for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609157; cv=none; b=hs40Hur7Yh3TwD9JthVm6C7kA8ndOWjv6wBgvn5QaU4U4Ur9S7lKW/olu0NlGvZNbLHJeexaGlHrg+xI01WslRIePvmyW+vD0La3Dhv1wYkgmX/glNVCXxzWkAha7mjbZxie1PY48HrIAVOOSYwpOWVBx5Jr+Dzho1bQQMDPexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609157; c=relaxed/simple;
	bh=v8jaVRDYL6d9CflRcJz4H3Wl91FyfPxIEG1bU41ZqCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWWmvWaVacBG/ccyp8+s85frCO8HxyvKpabiZB4zpMzzHUFC+1xPmKohf+6gf2avs6kcEzUVtvtFwBUyue/h+TfMHO6h4S5RLBkR595vN9IiX5WwH8qUa9+lGTeTQXsyGYcS1PUjHb3lLQBiNchVh2Ed6g0d28/9+M2hEf9tPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c/zjvlDO; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c/zjvlDO"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc21ad8266fso68067276.1
        for <selinux@vger.kernel.org>; Thu, 18 Jan 2024 12:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705609154; x=1706213954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n2iA8Bk4lDRA45XMjNZB70cr+rxiFTNPienz2rn7AE=;
        b=c/zjvlDOhlTIBOMni+7K1q1PijrThbgInNmBYEElCgUurgrQ3MoLoIsT8jLHbJ24cm
         5vjTh/ti4kmi6yifcpFeMyYUXCFsVo1BD0GGSyEy4T/8ANZNvRi40MasSTrkWDF3jvjq
         QbF1rqqGHUCT9QdRcsdJfu7eB5//s4HRhxTN8msXXPVWMtQeuPd6gjeB0CA/xJDbJI4m
         pSnSHpzvdYey9M4ctgzS2VJp41m80FtkuxYueXMLIT0YE3I1xkvU2xXJsIXAPSRg3knI
         4dQmFwjZu9VA2SL5JOyhueWdC11ncwA2B0y0mIE1pzKIBU986ovMfL+GRnnyVXwaC4pD
         lpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705609154; x=1706213954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n2iA8Bk4lDRA45XMjNZB70cr+rxiFTNPienz2rn7AE=;
        b=sdBnyN/c5AbBoLNJgP6pAnovJQHrKbjTXLSZNsY+Wo+WN1ADW+4NdiYZ0Ky1TXqji6
         CczSDJ6CA5d0vFssp6XjETkCPt1R8K0g1Lv538SI3UlyItLSskTHtLX+FwTZY3JPx7+E
         LK95pGgz0JOi5V8zOh6TXAP2ipiQRpkQjHqyucJMHwByoAwp37Wn2iAmG8LeEbyc9y6H
         hsffVKgM8RYlJ2sZC8VtSJlezMWOm158XbaJ/D23HIVklmyvuk1kWL+Yr+aFZvKGsbi0
         n3EFOxyNg+f0ruRT6AYVAOcT986M8YW2FWFm259G/UJqSGop73eR6xiC39eFENmFUvQk
         OJUw==
X-Gm-Message-State: AOJu0YxUL+Kp00aed40AxO60puAIxjG2hO3apPPdungmpLu2+39oHQs7
	3muIoKP9uRDjndsYuEBb3F6pg1J5OhEobyKVkW5txDck7iMyL8f39+z+Pu5jVBo7KEXJSjuwnLK
	izEbx8jSQdPCcPzdNcERYYRu10H3Cbq7HmoD52nEBwBf1+uM=
X-Google-Smtp-Source: AGHT+IFaDtU8KEZYa0LqEDqqYbcKjhNdDxWFdEA5YSmx8sr4CpxTup3+ZcogWnECXI9CdJXafpFRZEBPR1WYDuLie3E=
X-Received: by 2002:a25:ad68:0:b0:dc2:466a:23bd with SMTP id
 l40-20020a25ad68000000b00dc2466a23bdmr1279512ybe.54.1705609153847; Thu, 18
 Jan 2024 12:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALbthtcf4m5vPK7xLZhzk8W_7ETkNPeR3bnaM06BtzuQy8w-jQ@mail.gmail.com>
 <CAEjxPJ7ZB3PtVjvJf9u-C7JGNpGv53O9TGu7o5EadMHy2hHE5w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7ZB3PtVjvJf9u-C7JGNpGv53O9TGu7o5EadMHy2hHE5w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Jan 2024 15:19:03 -0500
Message-ID: <CAHC9VhTpG=x-9Mm5b6xKtYoAswhtWA43FJqrwRHYbr3XwSPYeg@mail.gmail.com>
Subject: Re: Race in security/selinux/hooks.c on isec->sclass and isec->sid usage
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Gabriel Ryan <gabe@cs.columbia.edu>, omosnace@redhat.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:02=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jan 18, 2024 at 11:26=E2=80=AFAM Gabriel Ryan <gabe@cs.columbia.e=
du> wrote:
> >
> > We found a race in selinux for kernel v6.6 using a prototype race
> > testing tool based on modified KCSAN we are developing. We are
> > reporting the race because it appears to be a potential bug. The race
> > occurs on isec->sclass and isec->sid, which are set in
> >
> > security/selinux/hooks.c:3329-3330 selinux_inode_post_setxattr
> >
> >         isec->sclass =3D inode_mode_to_security_class(inode->i_mode);
> >         isec->sid =3D newsid;
> >
> > Where isec->lock is held when isec->sclass and isec->sid are set above
> > but not held when they are read in the following 3 locations:
> >
> > security/selinux/hooks.c:1671 inode_has_perm
> > security/selinux/hooks.c:3125 selinux_inode_permission
> > security/selinux/hooks.c:3690 ioctl_has_perm
> >
> >
> > This seems like it could lead to undefined behavior if multiple
> > threads are reading the isec struct and updating it concurrently,
> > (e.g., reading an old isec->sid value but new isec->sclass value).
> >
> > In some other cases in security/selinux/hooks.c, isec->lock is held
> > when isec->sclass and isec->sid are accessed, such as in
> > security/selinux/hooks.c:4942-4945 selinux_socket_accept. Therefore,
> > extending the isec->lock to cover when sclass and sid are read from
> > the isec struct in these three locations might be a suitable fix.
>
> isec->sclass should only really need to be set once when isec is first
> initialized after mode format bits have been set.
> Not sure why it is getting assigned again in post_setxattr.

There is similar odd behavior in selinux_inode_setsecurity().  Looking
at the other places in hooks.c where we are setting isec->sclass, I'm
wondering if this is a copy-n-paste from one of the other places that
does have a need for it.  The pattern of "lock, set the sclass and
SID, mark the inode as initialized, unlock"  occurs in at least three
places that I can see in a quick search.

> In general, handling of isec->sid needs an overall cleanup but putting
> that within isec->lock would be a big hammer.

Yes, that would be an absolute last resort.

I agree that our approach towards inode_security_struct in general
could use some attention, I would encourage anyone who is interested
in cleaning things up to do so.

> Proper use of READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release
> may suffice.

My guess is that READ_ONCE()/WRITE_ONCE() should be sufficient as I
don't believe we are overly concerned about strict synchronization
between cpus, but I will admit that I'm far from an expert on memory
ordering issues.  If someone believes another approach is needed
please do speak up.

--=20
paul-moore.com
