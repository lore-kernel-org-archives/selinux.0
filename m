Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEF305E28
	for <selinux@vger.kernel.org>; Mon, 21 Sep 2026 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958010; cv=pass; b=ETgpYn3qnV1x4V5JpAXcJWhGmAWKCTzG5URO/i04lmgcIyFDxDxHkzN1jOcsKKU5eJXBDDGQpOCXDA3CkKUPMmPEdyCURq2/V+ObqVVD326tf3BtW5kHv1Q0EoadwaAGfFYuZTibJVYBLUjGi3B7XxT0YG3Qa8XHMnF+Vp9jjDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958010; c=relaxed/simple;
	bh=J3vCu+pHHGK9T6Xt/sz+9R2/9vPugUzaNwdrlkLd5oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJpFhuH14LHNntnx0lY0Ci+OBoomafEfb8HPyzTc5ICL25phYaB5qt0azyRMWOJqRJSk6IgiTS9JQ5By/ocF4fMCx3KK7bJFcxSTUM8n2/7r+s2jK95HDMcwl01uUWGUCwAv3Uj84ywitrSauEOWXHOF8vzKfjE+/7RdLx+87uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MvLA8liI; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MvLA8liI"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso2005009a12.2
        for <selinux@vger.kernel.org>; Sun, 20 Sep 2026 19:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789958008; cv=none;
        d=google.com; s=arc-20260327;
        b=Z/Gn87UsTgnBjemPQ0HJPCxr7ntGzwdDqNuWwuPmUobHsQ7ks3UJFujrScLkQPeoLB
         7sfUd5BCn3lI4Cg572zdQFlzAD0K8fU5tQx8wgD49qihdb0xDiKKidWGYDJrYgmXjeN1
         pAP4AmJJIb0S5/8sSjH83w3ZcIc8zBQbEQwVgfuUIbvxrctyI9ws0LbJOS/0kmftIdWR
         abHGTZIDSQ6eleSgES4eUTW2hEARni2om1t2NCGypfNySIrSupGJmSgWki9HHTJLcxGD
         WIsKqROdJry9C+4utmVlaRX/URJEn/9XDEkaZuGzR9WsilTAi9GiKeByzYQC3WIrCcam
         e2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        fh=yq7gb+C8uWBzrt5Bb9POrrfgTZT8NdKLyIXbi1WfH7o=;
        b=biEc7+YO3cNxJSMivGwIugIJ2g3y1Ee+TS3SuowkalH+blHan3NtrEFglKEQ/gqpyP
         b38S6H4oEXV76hRp/rBhYd+b/TOkr+kHxWBYJv6MSEchFu3X4ylHUu+KAirOWP964iN8
         Fv04vMg4u0j/GcOAFegHZIDauhGwcuqwAsUEcdcqUwn9MxJ7EIPrYS1Ofz6+j1JgXJ9C
         UWvIvbJMVnyNP1La0xf8ek/ys8g3tzCRYwgZBv/I3CpmHs1iL1n/AuAwTKrwfXnx20Zz
         JFSmdSHJTyxYtEw6NIXwjTmWHrRrPgbxVvrrrT3B++a2i258YEOHIQC7aTOv7fW2fJ7d
         6x5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789958008; x=1790562808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        b=MvLA8liIOnCDsY9Xgef7LSuV1d83UKiqFKIyA4l9PoHjlXoL8slmr9X0xPA2AsbiIg
         FdUrbPWbSBKM0Vtfxhe50Xz7TSLrPY7Y1z6u6qWuqk87gjTAGpX0mDiAZlq5NVyU4Gj4
         SaEjHBukdPbBkYqXeN2omfZjk4lUiutogvXMwukW09N0y5r8C4T8wDCbI8ClAopxmKKS
         Gz5B8G9ohVad0DF9X83p0oCcad0zErKxtgG5OlbPYVXELHSrGwOkYdSylXTTec2ucdqZ
         NLrcqUGJLpRSKQkg4hpB1uSef69+geJVbI1E7yQpbSEWwGaPWEe8rF27QkkZfz+VtBJl
         yAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958008; x=1790562808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0CX9NjM39oZwYo/+39OeXBXc2j3TkyIq6Vet5QN2Aw=;
        b=RvsBGgs/H2AshTFDXzQKB0XcQgh0lPi8WApFNKX68aOvTcV2IwGS48ng6UY2Kt4hIM
         xULzsIjbwqagCTg6CV8bTzYpbo6/iDmPWe/MnZA6j3bagv3giD2kvClNYieTiLlQkPye
         s5cIznCOMinh0I5LMkaaL1Lb4BZ2YCjBWL8NTUGmnc2g38pzWe07TTac0Fy4iEYTaNf0
         nkoGToB6XMNn6Et1XGnJlTuG2oWlxawKoDWVKdDMMaI2h1o5qkEiAoBeCvh/T3cHf+F2
         fTqHoTKxD++kYOJZGY+IfRTMit3lOjXKlCwYgwfzCa/tUR6k7keGVXnECcCtFWyYgnjM
         aoyA==
X-Forwarded-Encrypted: i=1; AKwUvBzDas0bavvTYctAPI1HoeNRQ3xH/i6jKzE0P+3eVikvmqjawLZE7G4lBFYSKtp0mZDraEvWA4+F@vger.kernel.org
X-Gm-Message-State: AFuF++nYKQb/hc8OmOBUO4uS3E7XG1f2VSWyrYr2XjapgbrccGOJ0xKx
	EAHvXQYEiM7KXARgWOR1goehdCra5UTPDwqK28KsRK7ivCB5miD2PZ5pDfY+aHICeO3M4PH4uC7
	pEHJYZ83IIbgRd8ZQ4ga1R+S1WT5m6t2TsYN8yLyV
X-Gm-Gg: AYBFou2ayUVCMZrBskQt4cAKVLV14hubtYQGRbcvRkwPXjpJWKs7oYHntPnxXTGFbkY
	bAWFevXel9A2V2G4lvlrT02pVia5+v8CUyPW2S9HDnYkZhTa1pxaQclHqk0b4ZBy/2+y5j1STFq
	JifvusdVqlS4gevT58P5MBQBgAiGHU3xgzmk2lqvzpEe+8Qx3uRjOO0V6dIU9tTTkj9UDN3NY54
	YotYz63KxC2KvIFi18TaSK8dmk2yTtR/X5XUQ111qQKrGxJN+mLaX6ZRqkzuM0FpmCv8loSYiR/
	cUiC79XdRaJF2PsY3/MPUQypqpU77ZocDaTsSPrm6i7JXiOouKcbf4Pec3LMO16O/86ORd+o5HH
	EjgMu26wC
X-Received: by 2002:a05:6a20:394a:b0:3dd:a196:53a5 with SMTP id
 adf61e73a8af0-3dda19654e2mr9716786637.71.1789958008327; Sun, 20 Sep 2026
 19:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
 <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com> <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
In-Reply-To: <20260916-begossen-tischbein-abgemacht-e7dada3d1e56@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 20 Sep 2026 22:33:15 -0400
X-Gm-Features: AcwNN1XJfic_AjA2ynJbPwX0hNkODxVU2hbKAKXrt_cjhAGvAIE6GT_12dvWT8I
Message-ID: <CAHC9VhRDpR+o9ThzajboAW4mpQWG7Yy0FemuowviyQXYvji7Qw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 5:01=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Mon, Sep 14, 2026 at 01:05:39PM -0400, Paul Moore wrote:
> > On Thu, Sep 10, 2026 at 3:48=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Mon, 07 Sep 2026 23:00:15 +0200, Jann Horn wrote:
> > > > proc,security,selinux: let SELinux block FOLL_FORCE for /proc/self/=
mem
> > > >
> > > > The goal of this series is to let SELinux prevent the use of FOLL_F=
ORCE
> > > > when a process writes into /proc/self/mem and the system is configu=
red
> > > > with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, =
and
> > > > is still used by current Android devices).
> > > >
> > > > [...]
> > >
> > > Let's move this on a shared branch that both the vfs tree and the lsm
> > > tree pull. That's the standard way of handling dependencies between t=
wo
> > > subsystems that want to route code that touches both of them. Branch =
is
> > > stable.
> >
> > For some reason (/me looks at gmail) your email never hit my inbox, I
> > only noticed it now while reviewing Jann's patchset.
>
> Oh weird?
>
> > Christian, can you explain why you merged LSM code that I haven't
> > ACK'd?  We've talked about this in the past and I think I've been
> > fairly clear about it; I wouldn't merge VFS code without an
> > ACK/Reviewed-by/etc. from you or Al, I've been expecting the same
> > consideration from you.
> >
> > While I don't have a problem with a topic branch for this, can you
> > also explain why this topic branch should live in the VFS tree?  There
> > are more changes under security/ than fs/, and unless I've misread
> > Jann's cover letter, this entire patchset is focused around enabling
> > LSM/SELinux controls and not necessarily anything really new from a
> > VFS perspective.
>
> See the reply on the bpf thread. I think this just a misunderstanding. I
> was under the impression that with minor tweaks v2 was already acked by
> lsm people.
>
> In general, if a subsystems hooks into the vfs layer and filesystems
> that are directly maintained by the vfs layer then the vfs tree provides
> the shared branch. This is not at all specific to security. It's just
> more pronounced for notify or security because hooks are accepted
> layering violations that place constraints on how vfs code itself is
> organized.
>
> I think this is just a misunderstanding that would've been easy to
> clarify without the kerfuffle.

I'll follow up in the other thread, but I will just say here that had
this been the first time there had been an issue like this, it would
have likely been different.  However, from my perspective this was
continuing a pattern of behavior I had previously talked with you
about changing, and as a result I was much more annoyed having to
revisit the same process issues.

--=20
paul-moore.com
