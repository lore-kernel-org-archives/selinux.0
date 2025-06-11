Received: from smtpcmd03117.aruba.it (smtpcmd03117.aruba.it [62.149.158.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71AB1DE2A8
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671194; cv=none; b=fGn6yScdidU4SxZU2+Qwp3BEtqcHAnbgpK3xs9o8OHvz2dIvqGmJULrmj/jqzk7tN7LDzXmDIe68zBXNn8D99kiZy6HUpVB8OV2xEoAhmqaTq5qUgtnOoVfebzKaIkb51O+vXbxUp8JwOp995Rt4OjE2Y4PiLS8splPrvxNTch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671194; c=relaxed/simple;
	bh=3NG9xZyX4Us5Lia6BFFjx1Mcigy79RkWKCgJSxqYksM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=mzqrWIx4Jz8HgGUKbFWvbGxXnOADy1Xt42MHMydBev9xxW+t8lHwqDCFehacFUoRyuFAvPb2Q1Dn6q4B6PDIXxWxjLF4Lhbrkp49COlUBJ2r3In3amVAyb9SlEPmDx4x6RGI9Cou3uqvhuq7g8Jxrpc+p5lLtoQ+FMhPFvIdVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=RQsn1qpV; arc=none smtp.client-ip=62.149.158.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="RQsn1qpV"
Received: from [192.168.43.2] ([109.54.117.111])
	by Aruba SMTP with ESMTPSA
	id PRM1uMY3SmHkSPRM1uB5j3; Wed, 11 Jun 2025 21:43:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1749671002; bh=3NG9xZyX4Us5Lia6BFFjx1Mcigy79RkWKCgJSxqYksM=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=RQsn1qpVqz3/erVavZIUBw6s2GKtvPTFW+N4zjpWnK+FTSmGLfspnLYr6tTtugn9C
	 XTmD6mFHY82p+7u+T9zp7tPnEQhKZU1Y9pTK6rIQaFhc7qdtf9fqD/BRRw9goRAnck
	 DR1W2y4B2mSTxPhUfrt8Pz8OV9+MYyU46DH+CuOYJs6mF9yliW4oP6bZx2WAxY7A5G
	 j2MIBsVLAvFYo97uV7E+Vv+ChyN73dFsI30yG6cDtTL/ZZlCqs22/xHM82ckQ1Q8v3
	 pde7CMS7Gk1lriAmGiT+pp+drD4gQ9TiVs9adBsMMp+/CMKEZ2YcrNUJ5ic+WaH2xZ
	 iZL9Fjzhvfmdg==
Message-ID: <1749671000.6186.18.camel@trentalancia.com>
Subject: Re: [PATCH v2] selinux: change security_compute_sid to return the
 ssid or tsid on match
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com
Date: Wed, 11 Jun 2025 21:43:20 +0200
In-Reply-To: <CAEjxPJ58ZSqhYaXr+fOLwbN=bBb7+WGRQf59vv9c-UWDBnyZMQ@mail.gmail.com>
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
	 <1749647531.6091.5.camel@trentalancia.com>
	 <CAHC9VhTjwOcwzKdiq5m=QyWo8=-a6E-2bW4gKJoDtij7kEmxeA@mail.gmail.com>
	 <1749670408.6186.15.camel@trentalancia.com>
	 <CAEjxPJ58ZSqhYaXr+fOLwbN=bBb7+WGRQf59vv9c-UWDBnyZMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHO5H0ozIsxaO8uN5V0xTNv8K6bBKcYkaU6ELKn5y+sbTq1lfEQMHQzrvL+QcZVAGj9VAqx3xOD/GHytfk7RlrvhKQUwVsxgu+kw7yS6E07idXnnt1yx
 Z+SEFIJ5APxWe3UTAeRZ+TaLOgHUew9QP3fgC0DG0jS72bO+mrg4Us6sHIX7zJFqczCzDDG4ktybcLKYYMVZVcZzLRihlJNkFQ/ePSfLWl0g/iLrmxKaMNOF
 pb7HY8CSSju0WU0bZ0KxvyIhiNKDrtSjNUhffdfvjsZJzUSXfZIkg/0J6akJu8gPrxPLO8wKE60QzvZy4I179A==

Ok then, as long as it passes the testsuite it should be sufficiently
tested for most purposes, I suppose.

You can add the Tested-by line, if you like...

Thanks,

Guido

On Wed, 11/06/2025 at 15.37 -0400, Stephen Smalley wrote:
> On Wed, Jun 11, 2025 at 3:33 PM Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > 
> > I have very little time to look at the underlying problem and, as
> > already explained, I have only tested that it solves dracut-ng
> > issue
> > 377.
> > 
> > This change has widened the scope considerably compared to the
> > other
> > proposed patch, I cannot so easily certify that it does not
> > introduce
> > regressions or problems in other scenarios.
> > 
> > The main point is that the offending code in ae254858ce07 is only
> > executed when the policy has not been loaded yet (and it sets the
> > SID
> > to SECINITSID_INIT).
> > 
> > On the other hand, when the policy is not loaded
> > security_compute_sid()
> > is reduced to:
> > 
> > switch (orig_tclass) {
> >                 case SECCLASS_PROCESS: /* kernel value */
> >                         *out_sid = ssid;
> >                         break;
> >                 goto out;
> > return rc;
> > 
> > In other words, when the policy has not been loaded yet (which is
> > when
> > the problem is introduced), the code in this change is not reached
> > and
> > security_compute_sid() simply returns ssid (when called with
> > SECCLASS_PROCESS). So, the mechanism of action of this change on
> > the
> > problem appears to be indirect in some way.
> > 
> > Moreover, security_compute_sid() is called by several other
> > functions
> > rather than simply by security_transition_sid(), so without proper
> > extensive testing in multiple use cases (read multiple code paths)
> > it's
> > very difficult to say the change is fully tested...
> > 
> > I would recommend more extensive testing.
> 
> It passes the selinux-testsuite without any problems, FWIW.
> 
> > 
> > Guido
> > 
> > On Wed, 11/06/2025 at 12.27 -0400, Paul Moore wrote:
> > > On Wed, Jun 11, 2025 at 9:12 AM Guido Trentalancia
> > > <guido@trentalancia.com> wrote:
> > > > 
> > > > Hello,
> > > > 
> > > > I have just tested Stephen's patch and it solves the problem as
> > > > an
> > > > alternative to the dracut patch and other patches posted here
> > > > along
> > > > with the issue description:
> > > > 
> > > > https://github.com/dracut-ng/dracut-ng/issues/377
> > > > 
> > > > Please note that I have only tested the success of the boot
> > > > process
> > > > with sysvinit and not other aspects of the system
> > > > functionality,
> > > > other
> > > > init daemons or regressions that might be caused as a result of
> > > > applying this patch.
> > > 
> > > Understood, thanks for the testing you've done.
> > > 
> > > Would you be okay if I added your "Tested-by:" tag to the patch?
> > > 
> > > > On Tue, 10/06/2025 at 15.48 -0400, Stephen Smalley wrote:
> > > > > If the end result of a security_compute_sid() computation
> > > > > matches
> > > > > the
> > > > > ssid or tsid, return that SID rather than looking it up
> > > > > again.
> > > > > This
> > > > > avoids the problem of multiple initial SIDs that map to the
> > > > > same
> > > > > context.
> > > > > 
> > > > > Reported-by: Guido Trentalancia <guido@trentalancia.com>
> > > > > Fixes: ae254858ce07 ("selinux: introduce an initial SID for
> > > > > early
> > > > > boot processes")
> > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.co
> > > > > m>
> > > > > ---
> > > > > v2 fixes a compiler error.
> > > > > 
> > > > >  security/selinux/ss/services.c | 16 +++++++++++-----
> > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/security/selinux/ss/services.c
> > > > > b/security/selinux/ss/services.c
> > > > > index 7becf3808818..d185754c2786 100644
> > > > > --- a/security/selinux/ss/services.c
> > > > > +++ b/security/selinux/ss/services.c
> > > > > @@ -1909,11 +1909,17 @@ static int security_compute_sid(u32
> > > > > ssid,
> > > > >                       goto out_unlock;
> > > > >       }
> > > > >       /* Obtain the sid for the context. */
> > > > > -     rc = sidtab_context_to_sid(sidtab, &newcontext,
> > > > > out_sid);
> > > > > -     if (rc == -ESTALE) {
> > > > > -             rcu_read_unlock();
> > > > > -             context_destroy(&newcontext);
> > > > > -             goto retry;
> > > > > +     if (context_equal(scontext, &newcontext))
> > > > > +             *out_sid = ssid;
> > > > > +     else if (context_equal(tcontext, &newcontext))
> > > > > +             *out_sid = tsid;
> > > > > +     else {
> > > > > +             rc = sidtab_context_to_sid(sidtab, &newcontext,
> > > > > out_sid);
> > > > > +             if (rc == -ESTALE) {
> > > > > +                     rcu_read_unlock();
> > > > > +                     context_destroy(&newcontext);
> > > > > +                     goto retry;
> > > > > +             }
> > > > >       }
> > > > >  out_unlock:
> > > > >       rcu_read_unlock();
> > > 
> > > 
