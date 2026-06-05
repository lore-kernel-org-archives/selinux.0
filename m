Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6A416D10
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676748; cv=pass; b=S6hTXX8Uz8lPqh5nVQxWI6FB0nPhZ687nNO7t1lLD4XWFCNUqp8+V6pyayl1Ok2u1udzT6GF13HFc35VijimRW1fxI95f+bK1FxJzIdlpaMXGVmYClzFEWQ2d5JuCoWLMujZiD/M3wbAfiFu8h+P9p7vUM2b8q5vhINAURd/rZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676748; c=relaxed/simple;
	bh=i7mqJoagJA+aP5BGepjm0pjxju0PqVhqtz/w85ygsK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwo8zzKovcKAyn3z0DLJRtuTPCBMBtOiF0piMaty2WGG6g/gGkLLAFgX0iswrxXSrunegnGxz7coYNix5O1AV8qMLU1iPk8/450PAXRJWZb/dNifuZiGxokKwBsgVjBzcsl+ox6kvyyAo5TcLNjID2A21ol4VnAnUb6nUKq71G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seOhwdzw; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seOhwdzw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0bd02d97eso24709985ad.2
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676745; cv=none;
        d=google.com; s=arc-20240605;
        b=K8ex85D0nPH9nunFs9v07Yn97LDAf3RwlYSDQM1/9aV6PGCJ1m2uNCgP6vcssLlQTb
         sbdJQ98diFOyIg2y2x17+3SXPyJcaO00tSlWN1msyeTWFSORqH1Yut6l0uIBd3UzR5lG
         yCr8QPML3fOc2WS6YpAUb/PqlxBGdHCWHegawYdeJBMH9KkqWaSugewYy/2L1UEnJFRe
         bmcxUSxGZ2H1svtCK4motsn4/WbNgkGnQvaJOMOUjCVr32WWKjRYvRav2l0O+yS551I0
         SDcpY/tSfFOzGPTGGkzieacuv/unROaDPo0WwbITc8CJA/mTTtZJwCUa2ySu+1JnmOeJ
         EY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yfsWLKJrYABsFIGSxY4DsK37CfU8DGYCC/UcdsUaQTQ=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=XKkec9bRcJnOl0w+1aIZzDNrQIqa0p3qUn/o7cKTzpEvbQa+QqdJG//KAtxjkNxsUg
         niBWr4pOy0s6PzDonqbEWyyWiSU8ojmEt86qzuznhipSSzcyVDa+xzqJ4cjbEhVXgjQ2
         dfiAGuHYXLdtg60QPAn6KFRxk9vlAwn/ByPlaER1vATIDrD7Z7O6KrehsqPQCVJBq4m7
         MO1Zl8rK89y8pWqnq5mA9S29LMpfQj9m0TxoGI+79RHXefyK1lvSraBjL4xDNGMDKOfC
         cLJ62eODG3NvukVBykZ4IOcOGP0Zsy4Qk8azIfQ/V44BXQOaNI9uOpOLqDNXDVnyKNOG
         hOAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676745; x=1781281545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfsWLKJrYABsFIGSxY4DsK37CfU8DGYCC/UcdsUaQTQ=;
        b=seOhwdzwzAnJBEZKWaro+LbdkCUc5rwvGn2NBJuuy2+H7G6gmNg3gVpnfJ9+BHZ/Nk
         Yem2WFyBtalyZYIYijGQ9m42VW1JrNaI+Ev6tpzit2VGnwnaK+oIVKGzfYncUAGVW35A
         6aq/OCbf6p3Ju0Kq+XffRXnvOypoqXT8qNC57g5SlcMzQObBlwsVPiJlz0uspaKuX4NF
         +g++fKjVczmxXFMjl065OTrSHSASfmlaTL8u1RgFGj9l7uhEUH/Vt+Kyhoog5o4ETbtO
         OTymJcsU6iPFCEC1xUr5V+K0DyMPIOKg45szI/6wn3rXmqYaaqz5B+2nJU2UzJ09goyK
         mo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676745; x=1781281545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yfsWLKJrYABsFIGSxY4DsK37CfU8DGYCC/UcdsUaQTQ=;
        b=myehGjMj2ytBMApPPYN3dKi2MPFNL+OMWy5B/P/BZhh7O1xnH6gRGZOhieXLQRDZcd
         CxOYzDd2TOel51Qgkh287ulzSRPEhiKpXwvLq9iTclU7czJLL2QIpPqTf9a7nSLHF+5B
         81XBcj1GVSQ0BLalgEojBdy1qFuFV+gAsJWLCNAcu5TTMOtny5XCepFShXgr2nAtZZSc
         DrDh+i9vXnZaTyiWgvsD7nftkDC+RTYqYUIR23zIJcBjCz+csnxKh6sR848AHuzSYPr4
         gYUzp9rUORZlDJNN6SMYeeT64lrsO1ptQyBWji/Pp1Zo/HFqWBNQBadH+AcoMpRzA3Vr
         nsAQ==
X-Gm-Message-State: AOJu0Yw//bOL0MowlX/EvxGT+uRNItAohgCNC6roFb483OnbwIaYG8nX
	IHPkgZw8QhZfndzsB+ctLK8hJIP6z+Gz30FgmSLyF87zap4blWgdxQtRhA5fj/j5q9ZlzkIiF4v
	azrvqN+/Cb6R7Z5+mplMGiKliAPxeZm8=
X-Gm-Gg: Acq92OEcry+OvlVQrxNgaPT/fqS2BxKUbaLxemfwSegnmeyLzSxj57aMlmVr2fW5fY/
	NQDWusI+K9rZjndFo3YpMGXKfoKAqKc2cg2bqiYwYHcFymDfsD5aznsFiwouW6oXCfaXNB5g9x5
	EwOHTNtr9pGkbWyytarzR5Rg4a7GKCFXSesSb3hmsDT48hl+vbo6kwfhO83AzngF42dHQqaRh+I
	4SMertIhb6CS3ngMdgRmzvkkRHKXp4MH2574nGpy1L/3m9svTQcySUMtRecAi6cmPasigkTV/sS
	eHsTVtWxJ1X0WVADgg==
X-Received: by 2002:a17:902:e78c:b0:2bc:f1ef:2e65 with SMTP id
 d9443c01a7336-2c1e8332865mr46746485ad.17.1780676744880; Fri, 05 Jun 2026
 09:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604172002.263518-1-stephen.smalley.work@gmail.com> <CAP+JOzRixd0WnraxwU5YXcp8ndzZwD6X99QBQ7w6Y7ZHf_v9BA@mail.gmail.com>
In-Reply-To: <CAP+JOzRixd0WnraxwU5YXcp8ndzZwD6X99QBQ7w6Y7ZHf_v9BA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:25:33 -0400
X-Gm-Features: AVHnY4Ji7e0Oy1kTep1WpZHq3ifrb0ZfxxxcjDqAERfAEg15KEFlUvtO6q-mxYY
Message-ID: <CAEjxPJ5Yhv+bY2zAM+ddwaA-DCug-keBFfiM+hSY1M+9nZqPOA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: audit2why: clear static variables on init failure
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:33=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 1:20=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Clear the boollist and avc after freeing them to avoid potential UAF
> > on a subsequent call.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  libselinux/src/audit2why.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> > index 4e3fdc1c..2275ffbd 100644
> > --- a/libselinux/src/audit2why.c
> > +++ b/libselinux/src/audit2why.c
> > @@ -275,14 +275,15 @@ static int __policy_init(const char *init_path)
> >         return 0;
> >
> >  err:
> > -       if (boollist)
> > -               free(boollist);
> > +       free(boollist);
> > +       boollist =3D NULL;
> >         if (avc) {
> >                 if (avc->handle)
> >                         sepol_handle_destroy(avc->handle);
> >                 if (avc->policydb)
> >                         sepol_policydb_free(avc->policydb);
> >                 free(avc);
> > +               avc =3D NULL;
> >         }
> >         if (pf)
> >                 sepol_policy_file_free(pf);
> > --
> > 2.54.0
> >
