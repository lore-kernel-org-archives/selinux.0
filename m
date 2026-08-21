Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5733749FE
	for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324909; cv=pass; b=tN8qQ/LK+Ez5DGY76TdD4cfisNzx9ph6ENXjeed3cy100mQOTTfRLEr4wrD+9j8gsCHi90oYeYo3UmXJtG1bfjf0WwQbJ+PYSeZtdkppnEN+J81oHGbXAd8g4a7s3t+f+5QFHJXHmsZ2W32/fGCgs7P+Rk/wTVTqDC1+GQhBiRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324909; c=relaxed/simple;
	bh=xsvH04/zWmLu6VaMQp0d91tlrFx34Z/3JARQ444mLbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgART1/AVsw10MxgHRD7rs8ei7L/o17Baj669UYA5p2viBQg5WdYbJJqouJynW2bFUjbS2f6dU/jXb211HDjC1cL1r0c5UQ0Ug34oyt/7tomVeEGT3W7TXXXg/2tjrD1JgR6GoU3tKLslreq+A/uYJQhX55nM5bch3I+8L502DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jn3llhVh; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jn3llhVh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cede6375caso104145ad.0
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2026 08:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787324908; cv=none;
        d=google.com; s=arc-20260327;
        b=CrSpW+Q8mqg7dWVtwChCofZ9za28h5A2XZqTosIKQbmFA46AQs9SVHg2JgebjdImH8
         9lO88t7UQDD3ZYprCBt1R9TK/um345l2lFlcRovFStrwbN6HdS9OoHA/5Hn+B8ar7WcJ
         BD/ahw5r3AQv3RLVhUax67pkQ9BfvULjmCvO2lPWA+nBKhn6/2y5Wmp1pG+UQ+pj4vNr
         m/qg6S1I+IgGs9X0UKdR0nIodrrhiZ3SXRcbM2Gw5RRU9xvJ/aHemhRsuHXpD5XkGnWF
         oIo/Ugj5kY8zCo28cUpwrQHeUrSQe41oIlD1KhZ2KGmvu03E17JNfjXtcC+2+o3Hr8v7
         Z52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        fh=vDA3sOnTQdAMkyVGHb6rRZWB1KPI3PNw0omB3dW7y4E=;
        b=chPVkN5n06kOwWfzp9w5LfO3BD8945dbUl5r6dVrAQd+1wxZWhsXNt4BEsA5qhFr1D
         5pKyhjKMaetn0b4jzViOi2H995N5EN/A1ndBO/H8BRWUPmucm9yUwtK/iaCappoLkv0/
         H4Zl1jBqCBIV9tV8fssqklWF1wiSI32ppwyzvnnL4HqPC6bMoJA8zKIkj1WmzjoSNvEQ
         4+iltYoMh9XdhxIgDBnkrXy4H7QRm59SC+YyKqLyxCFWIibh2jsPXuRVcmm/LomaCRVb
         OHOlb68b0v06xJNWxnUKdRhJZ5zd/cXJMrkJWhkLVOZgQ+2BLjvVV0Syvm2THQTkOMyP
         W/bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787324908; x=1787929708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        b=jn3llhVh7gBIXYmlyYrL8WSFwdMj2FeaOqUzMm20N/uwus8nxn2nTiYrr6Spo3Ic/r
         yzdUP0CyskkQJFgBlJqkaeF1d01HU4FExNId432GoipNMKJNfFOEUYefVGSR/Arz7L2F
         /xUoyd7soP5MoKCvjKTAR/giwPjkduRJ/9eFnMdyAd/kqf12n7J3VybR8YidXE2HSCsL
         vGMS4sZfe/9FAI2ndBJGlu/2U9EJxDFF7tuqyHEB0M1EWRgDIg9OYneCHklHZeX2zyCT
         91PVWLA3W5cMBuaIKZc3siKwJJySuVjtrdDJ9VfQkJJQIqwEFDyU10WXNwEdFfg0TS0G
         PSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324908; x=1787929708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        b=TTrN6qodJrDb8EgXVHs0W/+GF0GTuSkrjDumkCS8z/nathsWji25tMTp2uO0pfP+yZ
         Izd+3SyUnpJEWXO+/rp5FKk0OhJJhdnGnnmBPRrFd8JZnK0fhprJqrfeJfOdJKW2Nu5r
         UcUFKZs6fujQciqATVT6P4k3OR7tqpbwUT++qSMqoZfhFRJSQQuXMl3+tKSlUXfQ/GYX
         C4L7782b2Fw12XcwUqy4F0EKLSrs3CPDo0DSztgZHIToVnug/3UZI/4A4eVc192PA/Dr
         vQQJrHhEAprUxSzIQymCbbpixTx1M++p/OuwPt4KqkZeURZwXY8G89pgu+SdLqFqfHfK
         iukw==
X-Forwarded-Encrypted: i=1; AHgh+RramrVbaYay0cYdcOp+zg/oS9/JB7n0oiUYvyAfuJPVgDDS54cuDJU/Nsw+LPxCrEaB2JVSjrD9@vger.kernel.org
X-Gm-Message-State: AFuF++ne0nn2gwJGD2QXv9Lh4H45/dIZFjbcLfGyc/rOCEZyMkQFk0kx
	w6lV4AT64+b09l/v6N+Z14d9KMPete8N7N2p+7AobQ9PnGhoJaN/FAzG429RSqb4kCm8j5aXOcc
	v5YFF/odAYc3xya1alpVd79TC6BrEcLk+UO7mWU3C
X-Gm-Gg: AR+sD10kZqvFKEgESQLVVNC5qIuTLIZE3kQcbiLOgasltIn3e5BbzRv81dx7wTEIEdB
	/hTFBRoGIb9cjNecXAMar6ewm94yT0VGCRsQMX7gyqPOoD6Y34I1fks5w1dnfJpmwCRP5I9V18I
	xEkhYUZdpVBTJz4MC44J9R1yiCUnPf+jqrC8XFOJqk66NlNFTCoXxFXX46nqoI+9HCdLqifSpYy
	8v4o5FnOyu0bAoGsaa5nW5nwp7ZGxE/WyWXgjwmwGmyY6Lin+hhmBMrvME07BrvmNN8DA5JCwnz
	4Z8SNI5JT8t9zdq8GyR6gzkv4cZ38un/pii42iL0L+EnIwYQlHgb2oU6LkShgnID6+qJ266bm3I
	iIdloK4MzBMvpM9g8nFuwm5J1QEFg
X-Received: by 2002:a17:903:94d:b0:2d6:3c22:994e with SMTP id
 d9443c01a7336-2d650da6ed0mr6702055ad.11.1787324907361; Fri, 21 Aug 2026
 08:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
 <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com> <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 21 Aug 2026 17:07:49 +0200
X-Gm-Features: AcwNN1UOD9xZwijeRgcDq5q20lqu4OjcbnnkogdrF0uco3EOG75h8KaWFgvrdww
Message-ID: <CAG48ez2q6rCbVVWxE55RpuTotmMrNGYfj6+56EXWhXFSrgJXQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 3:52=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Aug 20, 2026 at 11:23=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > >
> > > > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a pro=
cess can
> > > > only create anonymous executable memory via /proc/self/mem if it ha=
s one
> > > > of:
> > > >
> > > >  - EXECMEM (like for other methods of creating anonymous executable=
 pages)
> > > >  - PTRACE (like when using /proc/$pid/mem of another process)
> > >
> > > Allowing it if _either_ permission is allowed is unusual in SELinux
> > > and seems prone to errors.
> > > Is there a reason to not just require PTRACE always?
> >
> > Hmm, that might work.
> >
> > My two concerns about that approach are:
> >
> > 1. This is an operation where a process acts on itself, while PTRACE
> > is normally for acting on another process. It feels to me like those
> > are different types of privilege.
> > 2. I feel like blocking this operation even for a process with EXECMEM
> > privilege increases the risk of breaking existing configurations.
> >
> > I think if we want to gate it on PTRACE, we might need to put this
> > behind a policy capability and let policy authors figure this out?
> > But I'm no expert on how new security hooks are normally added, or
> > what SELinux policies outside Android look like, so if you think it
> > would be fine to just check for PTRACE, I'd be happy to go with that.
>
> I don't think a new policy capability is necessary here. Is there any leg=
itimate
> user of this capability that wouldn't already have ptrace permission?

I do not know of one.
I was thinking that it is theoretically possible that some program out
there uses /proc/self/mem to patch its own code (similarly to how the
Linux kernel has Static Keys) or to inspect its own execute-only,
non-readable code (which I think would also require FOLL_FORCE); but
I'm not aware of any concrete cases that do that.

So I guess if nobody else has an opinion on this, I'll change this to
only check for PTRACE as you suggested.
