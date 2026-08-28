Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D96D3E316D
	for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787951459; cv=pass; b=ZhIVvFYCYXTHcJNs9+XxEl+m6cqFni7DXQzmdt41z18/rWtuCJxOWekrKeqFlQArvL99DKT5g05EhefxbFiB/97XPFGVy9mBIvfCbQTSqRiSFgYTTwFgTGQ3jVB71gQ5cCv8LECF0bFxi2f9NITuwmPmXhd0FqRaOxZYx91uGeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787951459; c=relaxed/simple;
	bh=mtCf7Axavx4JuRDXMpzt5yIYvFz1DJFkcnTltfwKTRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5piH0G3DZha774e8PIZr+LUFjtCQQ8ETJo9fzH9pj88BPNonXJrOjjSb1vUzMGq5dTb5tNVBrFArJwzMZ6XKO4VzyJ9V+iC7G4bymrlTb3aUGqYI3qs3nW+fvzN6d8U9CojrnKnFbHaSphQfG+2gIhBkKDh+XHcQHRJRjnBuKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NZNj2bX6; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NZNj2bX6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6f55a7089so13658725ad.3
        for <selinux@vger.kernel.org>; Fri, 28 Aug 2026 14:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787951454; cv=none;
        d=google.com; s=arc-20260327;
        b=DmmGOU0G7qIkPkSjNbt6nUuri0zdGFHAEudgz5bqRLiwGjATWy4wlJ3AxO5oJer7XO
         +HQm9MO+Yq/+DlReSiw6kplIp1sANxgBnrj+YcDsGo10T8ryxTfsUTxdFJFmN9t5HRjO
         c+SKiOIvcdkkf6i2C7wOQH+Hbe0n0aeRRaQCSKT52Ka4+AhY++6YOQYuNOik5DqWpmLP
         ZLQ0r231H/1TuPTCLu2uvr6I1P9rJFTSzuFV20JdcnkXzH8z2ux0GVeNxjIi+51JBT9h
         1lP/nzCcYA3RzbrT8gyXZox13DJZ2u4UXTjdjQlgAGQuwrdpnXVO0BJICkWOPo5Higoe
         5k/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tScSPJONssrRk2WXz6/33ewRDUw0skQt8yglR8/KZoI=;
        fh=TTZ/p6Blbw7pJNXqVPAWGwwWp9j6SQ+0FYmdtuYrLLI=;
        b=S+m0tA2A7OUdcbvyULPRB4z8CZyWRd2Dc3PadA+Sn3S3dkhNHdocZbbVh20Ki07c9/
         lnrCrBQu7oAO298RpT0enK8ZmXUpH7yIqsBZvx8u+uXCyBhBzzUFCcKIMctN7aJhm4An
         o5ivjuTUu3O+aTcP50bDnWWqjh3xCibLurJlHG8SIJqSG6Zxu2aeowlAU5C22MovmNp0
         7oerVHupDF/J3Vg2YNynHI+0oxfxPL2KNSljykiH831aAqKp29f2VDAnOlg5HV+IuZii
         IN2DFz+SIudCim61p45ZwAxe2APlsx60jI9Qw3lXaSAIJjmcxtfGo/uB7nSYZRRBBlae
         yJNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787951454; x=1788556254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tScSPJONssrRk2WXz6/33ewRDUw0skQt8yglR8/KZoI=;
        b=NZNj2bX6xbKkjBScY8ghAre5fofb9cbsSoh+5RuNYI6yIIoTaMKNOa6qDa6644Op2F
         QUCmKx0EaBdbau5hqBLcmYyiyaNZvbR5SV/bpw97WqPuPbc0OKsSoho6dQMZpG6w8BdO
         Hfd9ptINnaKOciZkS25LPGo0ww8FLE5OGxoC5+IMkphaovKKrsXKq8n/9XGuykyzYnPs
         TmA5M36fUYnN/S6KoTp7hgAwrHj9I1Pt1z4TLs+i7rmCowJnhHktBsbJllX4n19etVx8
         /V1XG5K3R/FypX9MSe2rqlj5agtfCOz/XodCuWUY1YLOD3i6CyjfiILNgzfnVfjXXFO2
         kFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787951454; x=1788556254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tScSPJONssrRk2WXz6/33ewRDUw0skQt8yglR8/KZoI=;
        b=YZ+Uj4BBHWbP/maWsqIDmJC0l0iJeNRVYlpj7cLvKWtjrgN6hGZigZ5Mbt1P4gegJh
         U6B7k3C0U/q2+AvSfx3Xf1xe4hv3be/jk7TcDExXl/3SJ/Ys+ZcAve1BjA5FqfgE2Bmp
         yCbQFQCmV6XVKEoqWUi2hw/DUOWvaydr679qMFS/jkEAT1D+zN+whJbw/vEhqtJxPnoI
         M+deFs4q0k++8p+YC/rAUHDmeLM7UXeS5axetde5vBtlZVAd21nBBD0PgOewF1VboDD6
         wunNatbIafOO63+FcVAWy7Q/JM3OzmvLIhKykcwOQ2ZaVtbJ6zRSTUz21nXHWcMA1a4l
         yWLA==
X-Forwarded-Encrypted: i=1; AKwUvBwzdi+YEPB93+Cjk7PtPxgO3YogrvSIaNABIIdesckQgmINMM/iZLchR/A6gIpwhn2BJP2W8Hh1@vger.kernel.org
X-Gm-Message-State: AFuF++lL9ITMKul14aZ7lv3RWbd8CZerj9i0nDFyv3ooUQmsXLjwVKHN
	JfposRttHZkKl2PycwvoE472viNiT4E7Bk9flmPJfX3JG5YTrW806kohgEKp40Hoha/AjXoN/lA
	LuT0FaBVzNkmwIADQOb1xB2V4bWnpszD+ZJFzrkPP
X-Gm-Gg: AYBFou3Oy+dDMxwtiE26b1QVZ3GBpBgNrerVKVSn1H9TMlVWc/uD3KK0tEouez5xSJW
	QjDQufpgIvdjK+dolizDq9xejx7jjnq1Gqn0eyJbsmu4KCREl4f+WQebKAIyFhp6x9rxkWNJa/x
	8N89kF90+D3oGD91j+KBQWzHmWswJLba2bQTwQW2RfbVxaRkC+2kQqAuluriJLx69oLuXd7D/rh
	F6+y4HCA1dy9qAwu37poVcwZ8pgY+81AJJ/TkrYMmIlJuhc/8gEhN3/XZ7ryQ/IAbUGldYT1DqN
	E/FxwtQAiQeRUhOuKE/jJKJGrZ+161EJPb74Ewg2UPFH0SIMHoIhkGk=
X-Received: by 2002:a17:903:b83:b0:2d8:d4d0:792e with SMTP id
 d9443c01a7336-2d8d4d079b2mr38565945ad.18.1787951453839; Fri, 28 Aug 2026
 14:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
 <82929c994076d95f99560ecc67f6cfce@paul-moore.com> <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
 <CAG48ez2jgJHewZYK1SVccJmBa=bjoMW80SPNcbgW2XCtZaWhjg@mail.gmail.com>
In-Reply-To: <CAG48ez2jgJHewZYK1SVccJmBa=bjoMW80SPNcbgW2XCtZaWhjg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Aug 2026 17:10:42 -0400
X-Gm-Features: AcwNN1WNKsySMz2VwH2iqet3Ed_WMqL6Q3m5wfbte2R22sYcRFQ3wDSSX0w0dFo
Message-ID: <CAHC9VhSHMmJn4bkRUodAnrVGTb57qZx3tL26g91jD_ocQCNLeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Jann Horn <jannh@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:21=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> On Fri, Aug 28, 2026 at 3:03=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> > On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > > Beyond that, we really try to avoid making LSM hook calls conditional=
.  It
> > > can limit what an LSM can enforce, it tends to be a bit more fragile,=
 and
> > > it adds some unnecessary work in the case where CONFIG_SECURITY is
> > > disabled.  I would suggest passing 'opened_by_owner' flag as a second
> > > parameter to the LSM hook and calling the hook unconditionally in the
> > > default switch case as a replacement for the 'return true;' statement=
.  I
> > > understand it may seem a bit odd, but we try to make the LSM interfac=
e as
> > > generic as possible with respect to different models and this is one =
way
> >
> > I guess I can do that, but then the question becomes, what other modes
> > of using the LSM hook that don't currently exist in the kernel should
> > I be supporting with this? I can make this a parameter, but any LSM
> > policy that actually uses the parameter in a different way would
> > probably be buggy/inconsistent, unless other new LSM hooks are added.
> >
> > If your intent is to make the hook work for any /proc/$pid/mem access,
> > including when the caller is ptrace-attached, then I guess I have to
> > move around the security hook call in proc_mem_foll_force() a little
> > bit. I guess I'll do that in v3, though I really don't like trying to
> > come up with a reasonable in-kernel API contract for a scenario that
> > currently has zero users.
>
> I started thinking about how to implement this, and an annoying aspect
> about this is:
>
> Currently, I only have to look at the credentials of the opener of the
> file - that is both the subject and object of the access. But if I
> want to provide a hook that works for any /proc/$pid/mem access, and
> want the hook to know what the object of the access is, and do it
> race-free, then I would need to grab the creds of the target task in
> mm_access(), bubble them up into proc_mem_open() and mem_open() (which
> will require touching all the callers of mm_access() and
> proc_mem_open()), store them into mem_private there, then let
> proc_mem_foll_force() extract the creds from there. All that would be
> unused code.
>
> Do you think I should just not provide credentials for the target, and
> document "if opened_by_owner is true, the subject credentials are also
> the object credentials; if opened_by_owner is false, you don't get to
> know what the object is"?

From my perspective there are good reasons for not making the LSM hook
conditional (see previous emails), but I will happily admit that we
don't have any (?) good reasons for attempting to generalize this hook
beyond what it is at this point in time.  I would suggest documenting
the limitations when opened_by_owner is false and leave it at that; if
someone wants to implement something that requires more
hooks/parameters we can always revisit this.

--=20
paul-moore.com
