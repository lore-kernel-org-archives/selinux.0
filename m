Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C01EB36
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670645; cv=none; b=a2L3Qoh0Xk9RVKkh59yQK4QXfbuyDDZFqDjUvKEKBl+1NbNeWrAyCvgjPXt1FqfdAl6Y5L76z+U8fwy5xg/ZOLF8GpbSZ0gBbm9f5tQXWEC8pXKcqOe+DvVuu0wOp9KoeVSivk55vkQf5XLoiplKUsfth/Ak3gp91NEhz1HOcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670645; c=relaxed/simple;
	bh=JVV5xatlKLNzdFFE6ITqnG0/mvutYgDORUM59LfWl54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsTG6k+4HuJQouTNS6fm0lMJPnGFrAHDB3Ymm1wUTM0rzjqQsCZfPWhSgopuQUNLKbGB+rkxq8mJoMyRPipByCyC9q0vHXljdK5XgqjtNJmyChRYbqZHxFpCm3OD8rpl96qaIQpFv9yZmI43JGZwfv6tG3Q679KEs1opjbP9SEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHrL8K1H; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHrL8K1H"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so245133a91.3
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749670643; x=1750275443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DjrXf/q0xqGwF8YgL9RyPnisBc7fP3hRJYf2WrTuZE=;
        b=lHrL8K1H/NMhO7+OhoJePrR756lHRMS7kc0rLw4qMlozCcr8rUHuttQnMsBDLBLIxz
         wdosdn7MwR60EuwNKk8SazAzwJP08mEl0p22ZyR/rfsvhYAXfiFiGczpjdUu6AcxPGZq
         W5ApyWRt3PNhKUUoWsRXTY81BKpHjouj6iX2XcAY/KYKGEUCHGmOMAYRpTjSim31ktOt
         6Xghqg36nCaXxVBq8zn9vBTmuJZAVIZTOzBH3mPEOMnAgQsM+NqeAV9Lm7oDt7qcsKb4
         xBGmrDBMbMHtlYqJcx6Z5X+6xgdDERnd2Zn1hNDEYGorI6+zRfNNqnHLR00gVAEMtYsm
         L77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749670643; x=1750275443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DjrXf/q0xqGwF8YgL9RyPnisBc7fP3hRJYf2WrTuZE=;
        b=CGA+7dJKOsxQsFJeqvPs/OK76r6EjXxUV1p7fIAa+z8a/bUaMncpKEnKw7i4oDNIAH
         ExEpxxbbYvAgbvpC0oKLYFDJpENIwoObkWweF1OHReZ4ekVt28Wyg1mFzw9mZA9JsFbr
         7+GlaY4ve7H18Y+Qri6CtZh9eTuEa9BHYst5EOugnIDiVOduiqKx147EoobLO4G1aR7v
         KvQX1SqLWYDQ8tjCHsL0CydzPvtJCNasIcIgdlSYpFXwhNms4MLYK/0NsNE/cPrOshng
         ci9vi9m+WoHJzZuy9a5MOZbnY7x1vG9JUaLHThljOMgk/WmdjstvW0iERQ9VhNY09VSO
         GtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5sjL75tSHz2QgRh0FW4EVyhzBrW4foTXqXN9gO9cDo7bbhehWm62BaoAjpYKJXas0vetJ531V@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNSiZShDoPRLzTtKWx+TepDMocXBjtaiIkAQmXMyza1MrKgA/
	Q32vT4A5l8mKkMrhoPvNQ6QJvBBU9v2IO9vo/P53s85mrzu7ffyKHp/PZJ24C72OBoMKtlABnOr
	8G4qWtvdJiIPZadhmGwrseuqsYJFTu7s=
X-Gm-Gg: ASbGncsDmphj4pVQZqilXHjjGduAR7r2kFyb7swXL48repwekmAYw15Z6rJQc3I3/MV
	VWHAkqQ80xRglpQLYWl+v/2KP9puSmmEdAKV039u96jYMnP+3LSgGWx5d6zKFBdwWBF2p9CHDJ+
	yvN73rfhK0zb0xndlfvvRDmf4U8CtPZAfvf1Yn4frit6m0IBBzutoAgw==
X-Google-Smtp-Source: AGHT+IEAYCXCigr4DRPKGkSg/N2IT//FeWsRWbDdaRWZ6bn74H7QRKSlQKAarlcHYJgknfzpty9n25xkyOTBn8SBKLY=
X-Received: by 2002:a17:90b:264c:b0:311:a314:c2dc with SMTP id
 98e67ed59e1d1-313bfb677bcmr1071112a91.14.1749670643110; Wed, 11 Jun 2025
 12:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
 <1749647531.6091.5.camel@trentalancia.com> <CAHC9VhTjwOcwzKdiq5m=QyWo8=-a6E-2bW4gKJoDtij7kEmxeA@mail.gmail.com>
 <1749670408.6186.15.camel@trentalancia.com>
In-Reply-To: <1749670408.6186.15.camel@trentalancia.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Jun 2025 15:37:12 -0400
X-Gm-Features: AX0GCFvsvromBWbMwJ7xEiDhGlh4PJlpAX7dTxeZanmr6o4JXdFFxb2YOyu7AiE
Message-ID: <CAEjxPJ58ZSqhYaXr+fOLwbN=bBb7+WGRQf59vv9c-UWDBnyZMQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: change security_compute_sid to return the
 ssid or tsid on match
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:33=E2=80=AFPM Guido Trentalancia
<guido@trentalancia.com> wrote:
>
> I have very little time to look at the underlying problem and, as
> already explained, I have only tested that it solves dracut-ng issue
> 377.
>
> This change has widened the scope considerably compared to the other
> proposed patch, I cannot so easily certify that it does not introduce
> regressions or problems in other scenarios.
>
> The main point is that the offending code in ae254858ce07 is only
> executed when the policy has not been loaded yet (and it sets the SID
> to SECINITSID_INIT).
>
> On the other hand, when the policy is not loaded security_compute_sid()
> is reduced to:
>
> switch (orig_tclass) {
>                 case SECCLASS_PROCESS: /* kernel value */
>                         *out_sid =3D ssid;
>                         break;
>                 goto out;
> return rc;
>
> In other words, when the policy has not been loaded yet (which is when
> the problem is introduced), the code in this change is not reached and
> security_compute_sid() simply returns ssid (when called with
> SECCLASS_PROCESS). So, the mechanism of action of this change on the
> problem appears to be indirect in some way.
>
> Moreover, security_compute_sid() is called by several other functions
> rather than simply by security_transition_sid(), so without proper
> extensive testing in multiple use cases (read multiple code paths) it's
> very difficult to say the change is fully tested...
>
> I would recommend more extensive testing.

It passes the selinux-testsuite without any problems, FWIW.

>
> Guido
>
> On Wed, 11/06/2025 at 12.27 -0400, Paul Moore wrote:
> > On Wed, Jun 11, 2025 at 9:12=E2=80=AFAM Guido Trentalancia
> > <guido@trentalancia.com> wrote:
> > >
> > > Hello,
> > >
> > > I have just tested Stephen's patch and it solves the problem as an
> > > alternative to the dracut patch and other patches posted here along
> > > with the issue description:
> > >
> > > https://github.com/dracut-ng/dracut-ng/issues/377
> > >
> > > Please note that I have only tested the success of the boot process
> > > with sysvinit and not other aspects of the system functionality,
> > > other
> > > init daemons or regressions that might be caused as a result of
> > > applying this patch.
> >
> > Understood, thanks for the testing you've done.
> >
> > Would you be okay if I added your "Tested-by:" tag to the patch?
> >
> > > On Tue, 10/06/2025 at 15.48 -0400, Stephen Smalley wrote:
> > > > If the end result of a security_compute_sid() computation matches
> > > > the
> > > > ssid or tsid, return that SID rather than looking it up again.
> > > > This
> > > > avoids the problem of multiple initial SIDs that map to the same
> > > > context.
> > > >
> > > > Reported-by: Guido Trentalancia <guido@trentalancia.com>
> > > > Fixes: ae254858ce07 ("selinux: introduce an initial SID for early
> > > > boot processes")
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > > v2 fixes a compiler error.
> > > >
> > > >  security/selinux/ss/services.c | 16 +++++++++++-----
> > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/security/selinux/ss/services.c
> > > > b/security/selinux/ss/services.c
> > > > index 7becf3808818..d185754c2786 100644
> > > > --- a/security/selinux/ss/services.c
> > > > +++ b/security/selinux/ss/services.c
> > > > @@ -1909,11 +1909,17 @@ static int security_compute_sid(u32 ssid,
> > > >                       goto out_unlock;
> > > >       }
> > > >       /* Obtain the sid for the context. */
> > > > -     rc =3D sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> > > > -     if (rc =3D=3D -ESTALE) {
> > > > -             rcu_read_unlock();
> > > > -             context_destroy(&newcontext);
> > > > -             goto retry;
> > > > +     if (context_equal(scontext, &newcontext))
> > > > +             *out_sid =3D ssid;
> > > > +     else if (context_equal(tcontext, &newcontext))
> > > > +             *out_sid =3D tsid;
> > > > +     else {
> > > > +             rc =3D sidtab_context_to_sid(sidtab, &newcontext,
> > > > out_sid);
> > > > +             if (rc =3D=3D -ESTALE) {
> > > > +                     rcu_read_unlock();
> > > > +                     context_destroy(&newcontext);
> > > > +                     goto retry;
> > > > +             }
> > > >       }
> > > >  out_unlock:
> > > >       rcu_read_unlock();
> >
> >
