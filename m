Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FF6FBF
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670604; cv=none; b=cEFMhccKXDgsmDvd7rfSydwHuANryc0GtCxisUzDYsOgm5ZPd5Wp/Nfezbis1TdtXo3XFdKt8uqnkIu33b6m7kS1MziPTguXNY4nSFt4DL46q/jR5YTIN8d2HqnIt0Kue3/LdvO7BD8o3I3QJDgE4F2uDOgXUJfCuNP16qeJqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670604; c=relaxed/simple;
	bh=dVE24NE1uA5NF/Cn8soO6fKoZvkiA0BQHNcV+tLb7x8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=p7T0Ycyd7TKbrRlNL8Kp3J9FBmdYz71LtYSJB8jzn0beVx2+++Xnad6DvGkvy3A9ratzPJu1tIPJWuFsWrzKW75v1OU1ngLkonlMWWPUjNzy+DRrpIWuvuw3xE0+GYj1A1VOuZ55QhywVS7TCAlMe8IRfhyJrOoGyM8NqJM5+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=RPqpyO/z; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="RPqpyO/z"
Received: from [192.168.43.2] ([109.54.119.20])
	by Aruba SMTP with ESMTPSA
	id PRCSu1SnAWAxHPRCTugYpI; Wed, 11 Jun 2025 21:33:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1749670410; bh=dVE24NE1uA5NF/Cn8soO6fKoZvkiA0BQHNcV+tLb7x8=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=RPqpyO/zAYDkMl8WmGXT9f1g9Q7dHMObWa7rv9JfI0/0+7+d0xRPLdIitFVH4AIoU
	 zkD2wdSloz9VW04bPbh1ungvZsBPgnsNplmhSPaw5lVcIoKsHvjk7TJjdBiUzwf4lg
	 o+j1WfHS6bMHIlgJK7+B4YJmr0vD5PltRclqecHR8ZJOeHmbM4SlGsLNhepcKIShAx
	 d8Ld9XCJ3uoYBTtRn0ABQfs/sKyCvMBWacFp6feUdMtb6Hz5pVJIseKuqP4D8PDBJg
	 J2+2FGg+sH9tSINKDyUwlGlBjfJy1QiR5hQo2JR+5fsoLES4fyp4pZ56N/HaA5rXKV
	 cB8GdIwQgGtwA==
Message-ID: <1749670408.6186.15.camel@trentalancia.com>
Subject: Re: [PATCH v2] selinux: change security_compute_sid to return the
 ssid or tsid on match
From: Guido Trentalancia <guido@trentalancia.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 selinux@vger.kernel.org,  omosnace@redhat.com
Date: Wed, 11 Jun 2025 21:33:28 +0200
In-Reply-To: <CAHC9VhTjwOcwzKdiq5m=QyWo8=-a6E-2bW4gKJoDtij7kEmxeA@mail.gmail.com>
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
	 <1749647531.6091.5.camel@trentalancia.com>
	 <CAHC9VhTjwOcwzKdiq5m=QyWo8=-a6E-2bW4gKJoDtij7kEmxeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfE78RZxHF7aWv25je5q0yQQ+HHzYV9MjocDbcYnjtw1V9PdWGR6Nkt2kjzASJct5cjZ5ly5kUCX4EaxjcZdk8M3gf6919BpVyRIbPSJKoywRH2C1fueE
 hVmmx+b1clvRKEDBmiIrk+2qu0SVeCOzR3PrJQVgutjFpun0h570oZkt0+78bnlQInTPAiM541lNRbTqrsujXv/lICeIt14Gl9o3FsaTFxJpXL7JIK9PKbsJ
 cHemhHy3J0mQweGjo6lIBIjWqitylxQqirvaMtUEd1IWNRD+5s7gK84I/yBr2a0Pu98VD2/oNhM0i8qTkU5lbA==

I have very little time to look at the underlying problem and, as
already explained, I have only tested that it solves dracut-ng issue
377.

This change has widened the scope considerably compared to the other
proposed patch, I cannot so easily certify that it does not introduce
regressions or problems in other scenarios.

The main point is that the offending code in ae254858ce07 is only
executed when the policy has not been loaded yet (and it sets the SID
to SECINITSID_INIT).

On the other hand, when the policy is not loaded security_compute_sid()
is reduced to:

switch (orig_tclass) {
                case SECCLASS_PROCESS: /* kernel value */
                        *out_sid = ssid;
                        break;
                goto out;
return rc;

In other words, when the policy has not been loaded yet (which is when
the problem is introduced), the code in this change is not reached and
security_compute_sid() simply returns ssid (when called with
SECCLASS_PROCESS). So, the mechanism of action of this change on the
problem appears to be indirect in some way.

Moreover, security_compute_sid() is called by several other functions
rather than simply by security_transition_sid(), so without proper
extensive testing in multiple use cases (read multiple code paths) it's
very difficult to say the change is fully tested...

I would recommend more extensive testing.

Guido

On Wed, 11/06/2025 at 12.27 -0400, Paul Moore wrote:
> On Wed, Jun 11, 2025 at 9:12 AM Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > 
> > Hello,
> > 
> > I have just tested Stephen's patch and it solves the problem as an
> > alternative to the dracut patch and other patches posted here along
> > with the issue description:
> > 
> > https://github.com/dracut-ng/dracut-ng/issues/377
> > 
> > Please note that I have only tested the success of the boot process
> > with sysvinit and not other aspects of the system functionality,
> > other
> > init daemons or regressions that might be caused as a result of
> > applying this patch.
> 
> Understood, thanks for the testing you've done.
> 
> Would you be okay if I added your "Tested-by:" tag to the patch?
> 
> > On Tue, 10/06/2025 at 15.48 -0400, Stephen Smalley wrote:
> > > If the end result of a security_compute_sid() computation matches
> > > the
> > > ssid or tsid, return that SID rather than looking it up again.
> > > This
> > > avoids the problem of multiple initial SIDs that map to the same
> > > context.
> > > 
> > > Reported-by: Guido Trentalancia <guido@trentalancia.com>
> > > Fixes: ae254858ce07 ("selinux: introduce an initial SID for early
> > > boot processes")
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > v2 fixes a compiler error.
> > > 
> > >  security/selinux/ss/services.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/security/selinux/ss/services.c
> > > b/security/selinux/ss/services.c
> > > index 7becf3808818..d185754c2786 100644
> > > --- a/security/selinux/ss/services.c
> > > +++ b/security/selinux/ss/services.c
> > > @@ -1909,11 +1909,17 @@ static int security_compute_sid(u32 ssid,
> > >                       goto out_unlock;
> > >       }
> > >       /* Obtain the sid for the context. */
> > > -     rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
> > > -     if (rc == -ESTALE) {
> > > -             rcu_read_unlock();
> > > -             context_destroy(&newcontext);
> > > -             goto retry;
> > > +     if (context_equal(scontext, &newcontext))
> > > +             *out_sid = ssid;
> > > +     else if (context_equal(tcontext, &newcontext))
> > > +             *out_sid = tsid;
> > > +     else {
> > > +             rc = sidtab_context_to_sid(sidtab, &newcontext,
> > > out_sid);
> > > +             if (rc == -ESTALE) {
> > > +                     rcu_read_unlock();
> > > +                     context_destroy(&newcontext);
> > > +                     goto retry;
> > > +             }
> > >       }
> > >  out_unlock:
> > >       rcu_read_unlock();
> 
> 
