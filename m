Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57433BF2EA
	for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502085; cv=none; b=c/xcC8Z0Ib7EuE4MBU1yU6yH0HHKbklj1gD1U5tcGJa01wg4QVijSlypsTxCjC0jrkSVjsI7KYXGNOuV5fm9SNMOYBxAnZr15UtCcFlN6gMMEWpMjdUlE/a4d7hLBIpYVfAFuXGuugGjLaUSdl9j+ARnqL/GcGUT0AgnzZPYmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502085; c=relaxed/simple;
	bh=X3zm1G3j28OtFgHoRXR1gMU8To0GFtHybypt7WZDJlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9LmoTrzWnSLflM5THAPopG8INF4IGK4krjxhuhTtGYIcnFrws8bCdeYADwn7JnpI8Y3e/TyUik9B6AlQm73N8grqDXlF2dzItzRFPnLjhnyoz5WL2/QbbB5npnlKmtVFAAFqj84eybawKfIRxsuPPcIicFaRbxIWyeZ9bzZzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fJHjMkl0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fJHjMkl0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso733151a91.0
        for <selinux@vger.kernel.org>; Thu, 15 Jan 2026 10:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768502083; x=1769106883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CMiyfQ47w4/5UuwPpcEMF9phnQIQc2APKvheZxBQJ4=;
        b=fJHjMkl0jfgCFlAMrTmNti7uvakBHJrDErAV6v7poTQSrJAXKTFQvYJyx5AFX73lTK
         RLFufsah6R8b55Hj8goH6EzHFXq2eKKpJjbuXPQAxVghCV/Nm3AQwTcKMAfEow6ntaxI
         eyDCBBS8r+FQbnFW9Dxj03o6SVMMrAwoMS3RqHFFTHvGb7/vhEbnVGkoNl/jedHimovl
         6lbvr+D46Nh08wwC62Ns3tApz4qKFMOeirMrHGTXgO4o/ZfQjtsbVuM2TynyyIvqTn25
         mk1pHLYgXlsIp5/PL0KFOMSIwXsF5PQm+4gMr1aQOs1gIjK5b1f5Nt7BtExUdFZ3foEx
         tSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768502083; x=1769106883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/CMiyfQ47w4/5UuwPpcEMF9phnQIQc2APKvheZxBQJ4=;
        b=MX+ef9sAihTMs6his0oT4XZwtizOPvFuWz4qSHMX/MCtRWxOLUZt1X2PrLnuhmOj48
         2iqmQSbkI0afYuvG1pw1v5MckE/rBPqgKpfUBudBI0jpLr1hSFlWgsxNkA42xQpk6srL
         nHJxjjIyK3wcA4PfVQv/BsOl81moiL/Aw36dVcA3K4W/x5WY/irHdblTxV/0jAfKGLX+
         yeiP8QNiyWrWOhkf0/PguzD+m/bPLFQ09dg4heXubZsBl3odK7Y0OL7Ak3UOZY5e0pMa
         b51W0Ev8Ed918Iwmqdg64uMmDOw7UNRP+IdB77FaT+ceYj+Jykxac9VDQyhWi2VMJIUE
         tvGg==
X-Gm-Message-State: AOJu0Yw+yWmwN6Z0QeMeT08XFbHl4pepBChQHiXa/saY3D64F3Q8trge
	q79811iPKDTHQq8e4+EEnzSCHly55UqSa1CA47pomoQBGbO2S8hw22CZ1J7Hku3P4N2nmL15RgJ
	G6tMGdW4ZC+BmSzXhmSfxKdYVSpT1WcPM2A64l3w5
X-Gm-Gg: AY/fxX4oSN1fVdiXPjnIpeMWCcf329WYrLrwxiXmVTWTpxi/bV1teKocN4n16eKD/Mf
	RmFsrrch2XL8kQfjT9uPT1Ep8Z2dxRfctgONor3Gd8H5QWx8PUqWdydhTq3K/tnETYQrqEE6CE5
	skKE4veCkfl1F0Q+CbUDJpww5cJ7b1BXM3Kq/RotdRS2yBYoCsTsrTq9mfjzYZ39DT/HShMZHcl
	oZx1VdUWhOv/b3yddC0YqmwgZiAtUjK+bRGXlG4sPCIPtlSa7G92t/Sy6fxMMplY24XieY=
X-Received: by 2002:a17:90a:be07:b0:343:3898:e7c9 with SMTP id
 98e67ed59e1d1-352677ed610mr2551911a91.2.1768502082802; Thu, 15 Jan 2026
 10:34:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105174020.887724-1-lautrbach@redhat.com> <CAHC9VhRaKE2fuXik5xxaw5i1f9QgveFj0_FgzMVyRCHebueZGQ@mail.gmail.com>
 <87h5sxvd52.fsf@redhat.com> <CAHC9VhQmYLMqFzytgauijn_C6TXksBVsptEdNb2ZcyKFT8fsCg@mail.gmail.com>
 <87cy3kv5w2.fsf@redhat.com> <CAHC9VhTcEFHNJcTSbvWFU4gKpAUBg-8cLAfushX8CrhnT41SbQ@mail.gmail.com>
 <873448ujz1.fsf@redhat.com> <CAHC9VhSBGr=6izQCmWwOcg85S3G02aDMgSrQ-bGEf-sR9RYtVg@mail.gmail.com>
 <87pl7b1f0n.fsf@redhat.com> <CAHC9VhQHrnkMO0JMtDyEnsmgMJisSU5bs76bzLYXGirc8uDYmA@mail.gmail.com>
 <87jyxi24jd.fsf@redhat.com> <CAHC9VhS=LNhFxHjxdeiCD2nThXPeCUibcos5wNTqox4uvVO5ug@mail.gmail.com>
In-Reply-To: <CAHC9VhS=LNhFxHjxdeiCD2nThXPeCUibcos5wNTqox4uvVO5ug@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Jan 2026 13:34:30 -0500
X-Gm-Features: AZwV_QimP5BRXjrPJQNGrPDZLZNywLgT3uFk_sO5AjJ-Pn0Kt29qYcS97bc6sNA
Message-ID: <CAHC9VhSeoyDPyK=Ph6_ksTwW3YrCaoHSztfPDnEGAxSsCYNPLw@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add lautrbach@redhat.com gpg fingerprint
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 1:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Jan 15, 2026 at 12:02=E2=80=AFPM Petr Lautrbach <lautrbach@redhat=
.com> wrote:
> > Paul Moore <paul@paul-moore.com> writes:
> >
> > > On Thu, Jan 15, 2026 at 3:01=E2=80=AFAM Petr Lautrbach <lautrbach@red=
hat.com> wrote:
> > >>
> > >> "68D2 1823 342A 1368 3AEB  3E4E FB4C 685B 5DC1 C13E" is not a subkey=
.
> > >
> > > Okay, in this case you need to get this new key signed by other
> > > individuals trusted by the SELinux community before we can consider
> > > including it in the SECURITY.md file.
> > >
> >
> > My idea was:
> >
> > Before this patch my address was there without gpg fingerprint. It mean=
s
> > that I could be contacted directly via un-encrypted email.
>
> Yes.  However, I believe there are usually different levels of trust
> associated with plaintext and encrypted email.
>
> > The key I used in this patch was already used for SELinux userspace
> > release ...
>
> I think the understanding was that release signing would be done by
> individuals with a GPG key signed by others in the SELinux community
> to help establish trust.  However, as you pointed out I don't think we
> documented that requirement or enforced it properly, we should do so
> in the future.
>
> > ... public key is available at 2 different locations connected to
> > me - github (I'm part of SELinux organization) and
> > plautrba.fedorapeople.org (I'm a packager for 15+ years) and it's also
> > used in Fedora [1] and RHEL [2] - only Red Hat employees can push there=
 and it
> > was me who pushed [3]. That being said I expected that the key is
> > already trusted due to all the records.
>
> While that demonstrates some level of trust between that user/key and
> those organizations (GH, Fedora, IBM/RH), it doesn't establish a level
> of trust between that user/key and the SELinux community.

... and I should say that I have no reason to believe you are not the
Good Petr who is a valued member of the SELinux community, but there
are rumors of an Evil Petr and I just want to make sure we do the
right thing from a community perspective ;)

Apologies for what may seem like excessive pedantry on this.

--=20
paul-moore.com
