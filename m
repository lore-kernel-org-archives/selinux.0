Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E404339867
	for <selinux@vger.kernel.org>; Fri, 16 Jan 2026 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576348; cv=pass; b=V+Ja5SoKxN9MGtR4fODh6BDob3q8Xh2PU2o0F9PltGW+RcJb8vq1IYjn7OjFU8BA0ig5GC70Hrx5LgxP2RUwdXpPglgSFUGpWAmWuqzyNRZonZz8p/TLfzZcqVtZGLXa0PwnIQfdyff+E/PvHu1dJrxoIroCrRt8r9fW1bfapu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576348; c=relaxed/simple;
	bh=9vln8gaRs5qJ3oXXcTmiFrnk7rvMYngpnEkAX8Y+i5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7UeyzRbfyB7vz3OM/TL62XkTPvqIIpuoTId4yUZen9nrMQeMLM3D4AMhCfm0/vk2jARl3k90X+3auLuTPwX5tdLoUqtKJr2mD6U2fYSQjhFUDfVZ7i4uVQcWlS++lBpILsteJFAEWsjlpO/uiAqs0kxMl5y8S7NQDdUUBM/aQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqYczKjI; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqYczKjI"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81db1530173so1043043b3a.1
        for <selinux@vger.kernel.org>; Fri, 16 Jan 2026 07:12:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768576347; cv=none;
        d=google.com; s=arc-20240605;
        b=DMLyv19VUG+hR7PIuZiIYRtKjQqiV7bUH8Z9yB7YsPMjWAQZrsGwdmvmQArpayCzJC
         XVPC+8otF8PO8KxaSsInwgoktUiCO6n/p3ypEfYCdc9QIBj0rP5pFubX/t4CM2jLdiG2
         lFHUWhIVFEfYmrAeoMvO2XgzaqWGxRC55Z50cfHTzh0nZlHh2O2A3wVPREh19lKFN94I
         uSEQsc7OAuUMaMPIL3eZRTNkTQ9ZApCj5L2Iob0LcyHxmDXGtM9O94UwL9qaTCHhasWE
         7VoTXhZqCPC5zCLbJzbfVSOuD5/tNBTCiIsjROSBXgUuJjyqj+XNXIQPC35ac/X3Ep3L
         mLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IbhrDfWmc2usel276H4U2qBqDhmP9OS8zfzjwN7f72A=;
        fh=YAjuhxhJXV6mNTnSnl6khCTYnP+36slvvyCkgiNgHN4=;
        b=JJMrxtbHBED3UzUxb2iHEHAFHdBhnzJStVmypZpkIdCMLk3pSwQjcx7FQRFh9C0FOF
         lF0gC9J5+T/uRaeEdKkwX6bKqqxP5h7t2NF/SQ1BfqLgDei5b88hjXnsvlL93dgFDxQN
         I8HXMuO5ofIFpro3G8MT1bF+H4FJqMPl+6fy6MoSsA3Wa1uezE40mwCZyOz3TmnEbrOr
         41RN8jlPK/Z0IgyiHpdOBdOSx4MCG9ujDBRrw75omDwSHiscL3E2iCVS8twyYC+5yYiK
         LiDZ98n2EXsh4Z2q0HXbzrwxdHyhrWFYSDp/Kny/8ESTgIkLmla4u8rYzaHhInMK2ADh
         gdkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768576347; x=1769181147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbhrDfWmc2usel276H4U2qBqDhmP9OS8zfzjwN7f72A=;
        b=eqYczKjIfO+gnHVZmAhLmSjZJ/iuD2bSGYzsBYwzfJ6k4AKMwLvOCip7Ow9tIjjg2h
         uHsB3dv87tXalB3X8Vr3s/8yDc4l6M8pBfexDVMtD3cAqBIHG0/XwrUG/+pDQopgtBi+
         ieAvZc7MJDJGzA4g60B1Ia/jZEsrGDFDPIlfYrAGE+al+GSXdIamZl3oo4LJny/JXsNU
         y29c0AdHuH8o9TW/blfXnA+PUi1GDUWoDmfSGLdsn58hWHlM7aLd6hK5unzcBA5qtqIn
         UZ/odxh+gruz7ttSLboRBfggx9kfacpLdUCou129PJcJLyvoYtq7nVoufn6mnSu+BxhL
         FAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768576347; x=1769181147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IbhrDfWmc2usel276H4U2qBqDhmP9OS8zfzjwN7f72A=;
        b=XTj5MVXZKnhT1MiYzuj89P9hXy3YpM3tql12AXqkJE+Z0IxS2yyGludY4TzAwCWWg6
         V9pK0xsW4R+YO+CInUl2b+7EcRbIIljXc4R+6HrhmO7XWHhQsQNtOq1U1/vZJffm1Wjz
         RIeyGIvnUA6K7zweJYG4Zg4ZPZrFiu5UuZBwovJmqMrJ5M7DsGMYhre2GClliQnrbrbL
         EdB4rW7+w2IG0p/oQqQh9JyOWVkaL9KzgObmbxrSs7szRbLsfkIdXO10gVvxh4Vkb5cO
         tzquRxEnoV27Q9dCmSHpggjoU/SBurhNF5bZrjs11UYD0uA/aHC5hOsmW/oI13WLd2Ba
         TyCA==
X-Forwarded-Encrypted: i=1; AJvYcCX+EM2qhxBKFSCkVe0ig5zGNCCKEsgoQ7JyRmzVZRuKuRX4o7CeB3OjEH0LCHk04FPTWfsCKlwO@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyeCKhAiQjA10d56a4eVBqcyDi8bahheBZik1c+2aHb0vyTZU
	NmBb8g4MNjMtv5Yzba70leTCeV67M9jAd6UcFacbsQsXTS4siwWUVFlPV1ZGW8aBuLcwXt+npan
	orXoA1+nKNymWGhL9WY+QBr2q7EM1jEs=
X-Gm-Gg: AY/fxX6Qn12wvd7ZlYqrYPcNkJTg2RYVlyWc9vfjhfeAm5N9gabkTX32ypu2oI9aSvK
	NUy7PVz7w00dN5suhYCNsNuW7KMGigF1TOkjnSbf2rAEh3b4oRAQY5vvNVb2eJUihR4XQuRVrOu
	jO34XO5ti42LyJn72gB5oUOeuAYRgGWiO646ZPhLWRbCB/vIhglNDAIKEVn8ZJ2OT1BZs7AdMmZ
	jlNWImtMNggxjmRdH0zFbT8Gj571tsNhyhF3AWg3n2wdsZTwnUgVg6mlmQ5636goNWIkiI=
X-Received: by 2002:a05:6a21:3985:b0:38d:f745:4d63 with SMTP id
 adf61e73a8af0-38dfe799eb8mr3883643637.63.1768576346580; Fri, 16 Jan 2026
 07:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWlLs1o5gk7k5osk@1wt.eu> <CAJ2a_DeFC5Z2VKXoDDkKmhcB8cft_ZtU1UtriPX292q4GRyh-A@mail.gmail.com>
In-Reply-To: <CAJ2a_DeFC5Z2VKXoDDkKmhcB8cft_ZtU1UtriPX292q4GRyh-A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Jan 2026 10:12:15 -0500
X-Gm-Features: AZwV_QiUqSbpm2RKSwTje7QRJGBBViKIiKQQ4CCl0vns2r6wGqUSicM_y7Pz-JE
Message-ID: <CAEjxPJ4ct1tWUs14C7Hdj=xZBK08qJ4XMfqZ_SAAq2=icMXm5w@mail.gmail.com>
Subject: Re: Suspected off-by-one in context_struct_to_string()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Willy Tarreau <w@1wt.eu>, Paul Moore <paul@paul-moore.com>, security@kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 3:16=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 15 Jan 2026 at 21:20, Willy Tarreau <w@1wt.eu> wrote:
> >
> > Hello,
> >
> > we've received a suspected vulnerability report on the kernel security
> > list, that was clearly generated by AI and really not clear at all on
> > the root causes nor impacts. We first dismissed it and it kept coming
> > back a few times. I'm not pasting it because it's more confusing than
> > interesting, though I can pass it to the maintainers if desired. I'm
> > also purposely *not* CCing the reporter, as the address changed a few
> > times, and once you respond you receive a new copy of the same report.
> > Clearly this bot deserves a bit more tuning.
> >
> > The report claimed that the call to mls_compute_context_len() didn't
> > properly reflect the size needed by mls_sid_to_context() due to an
> > off-by-one that would result in the trailing zero being written too far=
.
> > Initially we thought that was wrong since there are +1 everywhere in
> > all lengths calculation in the function. But revisiting it today made
> > us realize that this indeed seems to be true: the +1 that are everywher=
e
> > are in fact due to the surrounding delimiters, and the first one that
> > appeared to be the one accounting for the trailing zero was in fact
> > for the starting colon.
> >
> > In context_struct_to_string(), we have this:
> >
> >         *scontext_len +=3D strlen(sym_name(p, SYM_USERS, context->user =
- 1)) + 1;
> >         *scontext_len +=3D strlen(sym_name(p, SYM_ROLES, context->role =
- 1)) + 1;
> >         *scontext_len +=3D strlen(sym_name(p, SYM_TYPES, context->type =
- 1)) + 1;
>
> I think this +1 from the type name length covers the trailing NUL
> byte, since mls_compute_context_len() and mls_sid_to_context() cover
> the one byte space for the separating colon between type and optional
> MLS component.

That is correct. The MLS portion is conditional on whether MLS is
enabled; hence, the +1 for the type length computation includes the
terminating NUL,
and then the mls_compute_context_len() starts at 1 for the leading ":"
if MLS is enabled. The code could admittedly be clearer but I don't
believe this is a bug.

>
> >         *scontext_len +=3D mls_compute_context_len(p, context);
> >
> > *scontext_len is initialized to zero, is increased by the length of eac=
h
> > appended string + delimiter, and used as-is in kmalloc() a few lines la=
ter:
> >
> >         scontextp =3D kmalloc(*scontext_len, GFP_ATOMIC);
> >
> > then filled by sprintf() then mls_sid_to_context():
> >
> >         scontextp +=3D sprintf(scontextp, "%s:%s:%s",
> >                 sym_name(p, SYM_USERS, context->user - 1),
> >                 sym_name(p, SYM_ROLES, context->role - 1),
> >                 sym_name(p, SYM_TYPES, context->type - 1));
> >
> >         mls_sid_to_context(p, context, &scontextp);
> >
> > And finally the trailing zero is appended:
> >
> >         *scontextp =3D 0;
> >
> > Thus unless I'm missing something, that trailing zero is indeed written
> > past the end of the allocated area. The impact looks fairly limited
> > though given that root is required to reach that code.
> >
> > Given the semantics of *scontext_len that claims to contain the string
> > length, my feeling is that we should add one to the kmalloc() call:
> >
> > -       scontextp =3D kmalloc(*scontext_len, GFP_ATOMIC);
> > +       scontextp =3D kmalloc(*scontext_len + 1, GFP_ATOMIC);
> >
> > I must confess we got confused a bit when trying to follow this code,
> > because the called functions do not indicate the expected output format
> > nor whether or not the trailing zero is counted, so it's easy to think
> > that a +1 stands for the trailing zero instead of an unclear delimiter.
> > Also, it looks like the sole purpose of mls_compute_context_len() is
> > to compute the length that will be needed to store the result of
> > mls_sid_to_context(), and results in an almost copy-paste of one into
> > the other, making it harder to check if they match (we had to read
> > them due to the report pointing at that first one for being wrong, whic=
h
> > is not the case depending on what we consider as a string length). I
> > think that instead a change consisting in calling mls_sid_to_context()
> > with a NULL destination buffer to avoid emitting bytes, and making it
> > return the length could make the whole design more robust by doing a
> > first call to compute the length and a second one to perform the copy.
> >
> > Let us know if you need more info, if all of this is wrong, if you want
> > a copy of the original report or even the reporter's address if you wan=
t
> > to attempt to communicate with them (we don't even know if there's a
> > human or only a bot there).
> >
> > Thanks,
> > Willy
> >
