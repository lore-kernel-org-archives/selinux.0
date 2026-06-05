Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBBE416D10
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676769; cv=pass; b=SLG21vM6IATmXKNRTqL5FupPJB9ZEJlTtVewRtit9m28b3V7I8tD0lu6Oo5FINsM6lpAyuNaoUD7sFhmQaDNyZsB0Cfjn3nTUjbbu5knW/0ktKv7CoFKz33h/T0C5WMeo4DBYhZFuigrbLCH8lUQDenbz4L6WxJP5TfBCQ/bsQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676769; c=relaxed/simple;
	bh=Wr6CItxcIvhbwoCPDPpKbjG0fuMXpP0sDSS7fYE2ZdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRuYqrV1TJODeqZjpOqxxdqPKpmdFjy8OIQ8BpyUXJ+R9h7ydDstx9m5cIb0rY/R0b5S+AjiYPfBlChWuYYqXYb9Sacd9bn+9/M7KdakSG2+q0i8icEqJyacCvfBOxf6hkCAZJsscnrNhsYNVPmaChCuL7tJTJdcvWcbFMufFbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLwr3bdA; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLwr3bdA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85a2ca7bf7so907351a12.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676768; cv=none;
        d=google.com; s=arc-20240605;
        b=YYKPIli7HqCjs8nJPA4NtV9/AQhnIAs9gyG/IUSnr2LewGEabw1IqkU7tVgkn53L/p
         XlO6DW+yMRydJ3EhiSoAvKKaGYMxV2t6F82xcLWIMNiiWGxAnn7qbHo4+zyX+0VXt2Hd
         lb2GNBkzQEz0/N3d7NlEwOvwFPXGzjVMoFHTPg8M+708lR3H7kyXAMkvA9bx2llagIbT
         FTokqym20IG7MV32VnlxU9mKeH8R2s/QWyeBmExzutzb/vz0tsstu9da0vBLt9J1Cl93
         XnHimu73QjnUpsFqrEFTBU0aqY66nEsFKbbNNh9aDX2mD1wrIOhin1RLMTo+oedDuBk5
         dS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K7sr4X5Z+gKMkb5el7+KMUKiBzXBXewlzuhiH1YnJk8=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=He6nFt5EVbCCJGbv5rHDUPrhZSaQ8+mr3d7EsdcFgjNdFkZk7UDr49nTQnNIK0xPvN
         OYglhbxdqkbEAGsoC6YqjcaCmJG51SAXwSkf+oxF2c8RWqIz6npjurqaBN7DBi/xJZlf
         G8SNhwM05DpJafoe22sDntQRY9iTweA0ULx3q41aRyr4WOfW0u/0U14RDgnIIjAu+btI
         RhD3Sn8iv/7YP20E5b1ZkNz2cJagp5ff5VRtf6Xstn/ti4M39bis+UQFN6KyOUDti/Yk
         QXBZhNxTLLiyCsHvhrTFXJnSbm2iTCTwErkoYT6+0hPhqu+HaLnbCErf9s6rona6FAke
         6Rvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676768; x=1781281568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7sr4X5Z+gKMkb5el7+KMUKiBzXBXewlzuhiH1YnJk8=;
        b=eLwr3bdA7tFW9D9AvMrXdqR8owlgTpP5ZwrSfxG+hZESxzRJVbKrlPzK08HA71wxQB
         Q0aOrHNzV0NQz7ejerchTWgEjNyuRfdkv6IHUibMsJfMnJXVcx/PuyLgFZv6nxgfpPIT
         sNxELJ2vU6xkkS3qG/ZBjvV0G8FYKUMHC6y/ME4lBk3l985/CN/WcGuMSrpM0tXHrCzU
         4zT6yPK8FOvJv/9UmsA4uTx+qsqFh7yqjRGQ278572oW2uN1AnTjMvzAqJYhApdGGyO8
         Cz4IMAl54jNYjIgoEfMTtPupg98E+NYNEBkm3fYbV93RbkQ8yF3zlym+HPPS55JtF5xs
         EFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676768; x=1781281568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7sr4X5Z+gKMkb5el7+KMUKiBzXBXewlzuhiH1YnJk8=;
        b=IBH10Zzk7tpbOicWWiZ/e1Y4NRPL5eCfEPx47t0R3u0j/lBJTB4jZknc9CHeUdOYt6
         +TcbgyGB5nwsQlrCIJnhET2PI7RZ+C206kLjyhinFV5g0RpDgAJm6phXS7kXIGp0DyaA
         HYBwF9OXNqUFpHCo+ePp/AfiEfNs4BdQ85XzRcLRdqJNr5cyVbwC3kI93hlgmY2qLRbF
         oFfMNGWZt+R66Cw+nNeNjNILYFORyzLZUgGS4Jy1UjvFffi53kOoYwcP15lrjM7RfWIa
         k9hCwhSRHyq5QdjWCILBAPXqQPwroAliowqtsCv0NIbFfv3mCoORdVacQFJhm7P/gRdn
         TvOA==
X-Gm-Message-State: AOJu0YxCX6cqeaRgSYyOrwFIoI3b4PfVDImaB6Eq9Edbfap9uk1e5bz2
	egvDIYrWxJNkSDVTXGV6ZvNAdZ9wYr19OKU4g1PllERMukdwwCYIHni8Kh/ZOX+0DddFCjcbldo
	5c/7/O/bpeAWo5dEHnWxJSAXY8g7ogtQ=
X-Gm-Gg: Acq92OHnmNzYIOc6fpiLqzsFnzADuNdj9kiXlrLULaK+8oz0rkIOXfQA1vnAeFnf8BS
	JJOjInNjG4kPkTi+nfM68A2b7YRMGbQc0LLcvDadTGRo0u6qh+Pn9T6ikfycoBiCLgMme/qkPwA
	7+efNrsOoz/jFeDtfeC3vOehdOzAQ9SHQconYqWxSo1Lkynxzh5R0dyT+D/cCW+8c8RIbniAzsq
	tDyuvrdzv9L7SE8y7UVIVANSb3lZZoa8FL1cPuf73hhKPr1TJduPtx5+emHWoWObmfc7dMM/21y
	DTPn0JFC79PDLkf69g==
X-Received: by 2002:a05:6a20:d043:b0:3b4:84c5:45d0 with SMTP id
 adf61e73a8af0-3b4ccf35b24mr5355439637.27.1780676767694; Fri, 05 Jun 2026
 09:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604172213.263551-1-stephen.smalley.work@gmail.com> <CAP+JOzSJKtQc49Q9nxG8BpUWrDSMcDPgEWsuO_=KFunCpmwL2w@mail.gmail.com>
In-Reply-To: <CAP+JOzSJKtQc49Q9nxG8BpUWrDSMcDPgEWsuO_=KFunCpmwL2w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:25:56 -0400
X-Gm-Features: AVHnY4LbKyInKk0MmCxMThNhlGkQj1CvF06ZWgniAqs8AUWKjf4jnhY-ABwzJ6U
Message-ID: <CAEjxPJ4vNwuNVVccruvRyBWTh4Vz6s_k_ODNdFHoURDbmE6xJQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: genhomdircon: handle NULL bsearch() in get_users()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:40=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 1:22=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > bsearch() can return NULL if the seusers SELinux user is not found in
> > the policy user list. add_user() and get_group_users() can already
> > handle a NULL user parameter using fallback logic so we just need
> > to fix it in get_users().
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libsemanage/src/genhomedircon.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomed=
ircon.c
> > index d953b75f..68382b95 100644
> > --- a/libsemanage/src/genhomedircon.c
> > +++ b/libsemanage/src/genhomedircon.c
> > @@ -1276,9 +1276,11 @@ static genhomedircon_user_entry_t *get_users(gen=
homedircon_settings_t *s,
> >
> >                 /* %groupname syntax */
> >                 if (name[0] =3D=3D '%') {
> > -                       retval =3D get_group_users(s, &head, *u, seunam=
e, name);
> > +                       retval =3D get_group_users(s, &head, u ? *u : N=
ULL,
> > +                                                seuname, name);
> >                 } else {
> > -                       retval =3D add_user(s, &head, *u, name, seuname=
, name);
> > +                       retval =3D add_user(s, &head, u ? *u : NULL, na=
me,
> > +                                         seuname, name);
> >                 }
> >
> >                 if (retval !=3D 0) {
> > --
> > 2.54.0
> >
