Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E93C279B
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476108; cv=pass; b=PbjMq2Hi4hAnAazbgzSopMRgq19V/GdM5RwNQA8jNeb47IIiWC3e5ZsANQU5hVkwjQyQ6Fk9/yTHHHj1qBlmWW3JygtEmuIvNu/ARpzZBwHckmkb7OSBOdybI+zMjXj+d1sC/wydq38hrri7FWLPT1U9l0WtlIdd/phyOr+E2/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476108; c=relaxed/simple;
	bh=He54cgTLgqkFyHWqJe50PtA5ZnxIzuEm3hOTydN12uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZrQ14nGk39Xa0s2T6wpKbYcd2DbA3jVtbaDTiKY9TZrfDyUx+WygTZzCuAODG7VhLD/XGwF6+SSFwK/cT1B7UpQGGMy2ETzMsq2XR16cqkPnn60LFbifafqKCW8GfArElwLdnOW4R6SJhr/MHXFw5rd7X+ZSFe6WVjMkd1+QR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiErBplQ; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiErBplQ"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-4693691fde7so148258fac.3
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 05:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476105; cv=none;
        d=google.com; s=arc-20260327;
        b=qRARkPLA4DyOFf01zGNyysso1b0hamDjrgdMiCYyrDeSazwBpSOvkV9P1WTii7ryP1
         RgAaq27ZdeGoMrGGczkq+VRrfN1Z/mCfvo+lFhsxU1TNasiUMlTZF4QbBHYWTsBtorGp
         TjACznWP8gx6eUgIRPgDaVjNYS6WzeVEP/OBNWoCNJGlEj8Duq++3Nirew0+BASSUEDx
         J2FWAGjjPP7UV6VWUUn08w+aN3C1brytvOyEf+Ez9v4Xc7jAO3XCgfATz0TS7ov27Unu
         o6N+xEm0EnRaa8fKcyDw5Gyf+Lz6EzKpJm1VhzdjeweLr9NVRw9wkB4WKJ2F4MDJnuxo
         +tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+OJ35cUa1X8ziXMvL2Wy+FHSIwiFsEwIuS4sxo488pQ=;
        fh=09wTTs468RLOGZvYknrwEwy4FkKGkG4RXXpns0EUDYs=;
        b=skVjOVpNswZu8LmYe9khlnj3ndPQd/CUdHLtiNByeYsX5Je2jdJMgaw/41gD881lzK
         QBZuRf36PKsJn3vKmYZ6uTmDu3Dha1VkVquSuVUY3xQaArYN7mnug2+GPqnwf6t+fy1p
         UpYUjvSJbgNKHn2nnHaf+ABzbA52FMoGpG445J7weqcECIhF+ZlHdptnTMfwt97bcCnT
         j7YRqRr+l5CJzL51WST0zfB/Dlw21Gm0obhY2cF2oyk4gV8KSZ+GdsiLdSVBhn59my8c
         r1izOIzLLJiCFyp4KAlaGICKTa0Ec87xJ5npFPI7uetrXcxZEV4ges+InK9EK9kT7jc2
         Azbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476105; x=1790080905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+OJ35cUa1X8ziXMvL2Wy+FHSIwiFsEwIuS4sxo488pQ=;
        b=JiErBplQeT/bRepddsX6CkrrXOBUxz+patIpoQTj/MibvoL6wY+snzA2NFEB/2iFku
         Ao6HHKAwaZH7R9Ah3ysVYw/XgYHk4iY8ykYaCOGIXir5X04w6IDPUTLehTbo6lBQ18yV
         /3btHLPOQ9ayHCRJEjfT58HWBqKsJvRSbb1KnHRpYJpBKsrIEIgPzUWGQzytAr1tD0dW
         w+hHuQszyqZuUL2GUYz5Ngr8S9ELJiFKfX7z8P0WtyhN671yUNw14WZMmEugumDxXQXP
         2GxnSuUylicKYytk86dLJsaR28HzbvncYk1WEFiLz3YU5JXJ47nCIbEDgDH6G9Zzw/z1
         xdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476105; x=1790080905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+OJ35cUa1X8ziXMvL2Wy+FHSIwiFsEwIuS4sxo488pQ=;
        b=ZMQY5uNVq0eogzouVHm8SBhyaIloKNmw24aU21823RQ/GQVgfxdSFiEouY22EiW7cF
         WtnZfoRUIWasyjGHKGHPqfFsHjsVbrxsQCb8087zjjjzk/vzy3rBcRYNnynyl+SjzCGA
         7KSkECmiFZIDx6ZqrZcNCIAuZUHq/+9cQlMnnBSEkVzsuGYHVrCbZpVQjO8AG3m4cMpR
         eZaS54TBTtMh2n2ZYPQHE3c1R9DEfqzC6Kds4UM5A6STHUpWvUlX05wKZ2svRUN6VWV6
         z3n+XxLT9QEqgQicNAQWvC6tP5V7tK9FvcYPpZbvJyn4WXfxuipIU5BXr4qsmCrSKBkk
         JsMw==
X-Gm-Message-State: AFuF++lFZs7J/QaXOl73s6pEbtD1qLYJ8ePuFnWM79ZXcXGaWLpZ9eJ8
	SoQ4c3psgbiHkF/UFdCX95jf3MHylTE0Rsgfe5tNBYAb2QLM6YXYQT/QHpCCDTkXEzD6kEVtls8
	uSNKeBc4aLNeWcv8gm7s730drp9qtrAE=
X-Gm-Gg: AYBFou1vew4gnjzDLn3DfnBaAxOYXlLAHY/mlTDKUIp91aU/F8BrTL2opLWXoQGgHMg
	sUGjPmfV1my1vGuwgL58Drbn4SqNsPVytdKnosbxdSgPjTnSAsah2VpFOBDhQRuvfFxQfBZNnDI
	iGFDpTEM+inlCRDVxw7ADASxlOx6RyZceVfUi5PRCMLeJ1qOO0SX8ei1ilRQDHwoWguYOCGpnXJ
	u3GpVBUXn4E0SNQsKEEriGlA/VM/lLB3IXZvKz15ELXv6i6vWa8WJx4+TGmfEDGqrIr8XsAMV0K
	4gtSCFyspW7wPmj80h6wPDvbMeItNPsDBQJPMJ3QbTDSp9K1Hh46BrdzWLOkw9Ry2Q==
X-Received: by 2002:a05:6820:906:b0:6c0:c954:e534 with SMTP id
 006d021491bc7-6c738db61c8mr481645eaf.38.1789476104190; Tue, 15 Sep 2026
 05:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com> <CAHC9VhS-TiBkOZWR7xgCrPnpxozjzM+y5vpgbPU9=R_C3Ta2WQ@mail.gmail.com>
In-Reply-To: <CAHC9VhS-TiBkOZWR7xgCrPnpxozjzM+y5vpgbPU9=R_C3Ta2WQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 15 Sep 2026 08:41:31 -0400
X-Gm-Features: AcwNN1VUjukzO97fF4XHpasDDcMDUHTX0ooEZae-il7LNB4U2Ajt5LLY6En3IeU
Message-ID: <CAEjxPJ6oAKu61Y3NeOJuFSqwSGd+XTwipTx2LSwwBSLJTf9Fyw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnacek@gmail.com, ljs@kernel.org, 
	jannh@google.com, jack@suse.cz, cgzones@googlemail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 5:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Sep 11, 2026 at 12:38=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The selinuxfs "status" and "policy" files are read-only interfaces
> > that are also mmap'd by userspace. They are created 0444 by
> > simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> > O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
> >
> > Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> > tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> > above are rejected at the VFS layer without ever reaching the file
> > operations. Since a writable file can no longer exist, do_mmap() clear
> > VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> > sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> > MAP_PRIVATE writable mappings become permitted (they were previously
> > -EPERM) and CoW harmlessly to a private page, matching how
> > sel_mmap_policy() has always treated the private case.
> >
> > The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> > reason; leave dropping it to the pending "selinux: reject writable
> > opens of policy file, drop mmap shared/write check" patch so that the
> > patches do not conflict.
> >
> > Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> > cc: ljs@kernel.org
> > cc: jannh@google.com
> > cc: jack@suse.cz
> > cc: cgzones@googlemail.com
> > cc: brauner@kernel.org
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > v3 implements Jan's suggestion to mark the inodes immutable rather than
> > implementing open-time checks.
> >
> >  security/selinux/selinuxfs.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
>
> I'm mildly concerned about marking these files as immutable when
> neither of them is actually immutable.  Yes, userspace shouldn't be
> able to write to either, but the contents of these files *do* change.
> While it doesn't look S_IMMUTABLE should currently pose any real
> problems, I do worry about the future and an innocent looking VFS
> change causing problems with one of these files because it was assumed
> the contents of a S_IMMUTABLE file wouldn't change.
>
> Unless someone can promise me that would never happen, I think I would
> prefer the !FMODE_WRITE approach taken in v2.

In that case, we would still need to separately address truncate(2) in
some manner, which requires something like cgzones' earlier patch. Up
to you but the immutable flag seems cleaner to me and I don't think
the concern above is likely to be a real issue.
