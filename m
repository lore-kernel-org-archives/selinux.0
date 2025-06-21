Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB821624E1
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750524919; cv=none; b=TxgIjI+QyGHefekSD5CepAklUtdZhF/o5Rm8Rx6XwW93CW7SS7MyQwG96IfEFURm58N0mDUCiu+sT+UMlsiBR1Hws/vJr7tMf/4TmyBU2GAugRcUbrO0nTnNeeItXA71Od6UK5SfftjiOyx0U0EvowzyUA58iQbSGF5BIm5mxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750524919; c=relaxed/simple;
	bh=K07gyY0bzfx+8wEB67rNS3idUiEiox9c+fqZAFnr/Uw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=KZDfnQAQidXdxrHdC+0tf202YL2xsnALEXV6+Wgg7DA29nyV2XxUyai/xHlstrzXm9npGVNO/4Vv55JPcbrKRdLIigCZUm9vMDuuMzheyqoqfOfk3QGoDY3CF3iVfTLrMA4p/wRssSHiX+aa2U3K3alceru+SWllBFa3uGzwd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=QOiK3z6C; arc=none smtp.client-ip=62.149.158.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="QOiK3z6C"
Received: from [192.168.43.2] ([109.54.112.128])
	by Aruba SMTP with ESMTPSA
	id T1RmuboPYNbHHT1RmuIsOG; Sat, 21 Jun 2025 18:52:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1750524726; bh=K07gyY0bzfx+8wEB67rNS3idUiEiox9c+fqZAFnr/Uw=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=QOiK3z6CEC7hqVRvptIBdPC1ck/L9SJ9mrvVptq9IkV6aWaba0skeu0FPDckX+hiF
	 SFio8OzKqAD9S6mK+3Nlyoh9lBji1qYKQ60uVouPMDnHb8X4BTo+o8eHkDDFKsB5d7
	 bDB7sRLz+cvYmRjY36PQuFFzC0E55BE7gXYkOHswByzSoSya1gRhyIE1azrkmMSgJ6
	 t/xmG+GaKXpXatCO2XxK0K+XeGp904uMIs/WKnrisRwQhBm/KYec4vP84rGop++HHm
	 0sWdMUMymWAt61iKNsNHB8FT0Muf1hjtNb3s6WtbggcCicnro1Ee399M3T0dSUu4LS
	 scwkfSJ0x29VA==
Message-ID: <1750524725.6235.9.camel@trentalancia.com>
Subject: [PATCH 1/2] selinux: prevent potential comparison mismatches when
 computing the SID (was [PATCH v2] selinux: change security_compute_sid to
 return the ssid or tsid on match)
From: Guido Trentalancia <guido@trentalancia.com>
To: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Date: Sat, 21 Jun 2025 18:52:05 +0200
In-Reply-To: <CAHC9VhTFww3khVjjd1Tci6Qx+MnM+v9_u7vANWNqE0vwTW=Ftw@mail.gmail.com>
References: <20250610194826.80606-2-stephen.smalley.work@gmail.com>
	 <1749647531.6091.5.camel@trentalancia.com>
	 <CAHC9VhTjwOcwzKdiq5m=QyWo8=-a6E-2bW4gKJoDtij7kEmxeA@mail.gmail.com>
	 <1749670408.6186.15.camel@trentalancia.com>
	 <CAEjxPJ58ZSqhYaXr+fOLwbN=bBb7+WGRQf59vv9c-UWDBnyZMQ@mail.gmail.com>
	 <1749671000.6186.18.camel@trentalancia.com>
	 <CAHC9VhTFww3khVjjd1Tci6Qx+MnM+v9_u7vANWNqE0vwTW=Ftw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHQZCYwLB3lAuUpU0sa2a9Cz5zS2GApa7fV6mJpQ9ZlVto7EcjuqDoNEZDEAROe+2ya1ZZKiLFQNneFhf+mOES0QVkQUQxBbgc+87X+LAl1/grh/axE7
 Fze3Y3j/TrFzq2+fCTvOwMiWpRjM8uPjEDTiaE/5iwOGOruDxirTg1EhKgSGXCo4aauFmv1M2hUetMlnzPMeWlZRCk5ib3qr4DjN6q7dv6SNtXj5utPp9Yyp

Yes Paul, I found more time to look at it and it should be merged into
stable.

However, I thought the following two patches might help giving the
whole updated security_compute_sid() function more stability.

I have not fully tested them through the testsuite, so this is open to
discussion and more extensive testing...

The context computed internally by security_compute_sid()
is now used to compute the output SID directly by context
comparison (fix for ae254858ce07).

In order to prevent potential comparison mismatches between
the source and target contexts, the role that is computed
internally is determined more accurately by applying the
same criteria that is used for the user and for the type
of the internally computed context in the case of sockets
and process class.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 security/selinux/ss/services.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/security/selinux/ss/services.c	2025-06-21 14:50:05.168301991 +0200
+++ b/security/selinux/ss/services.c	2025-06-21 14:53:21.196300795 +0200
@@ -1826,10 +1826,13 @@ retry:
 	} else if (cladatum && cladatum->default_role == DEFAULT_TARGET) {
 		newcontext.role = tcontext->role;
 	} else {
-		if ((tclass == policydb->process_class) || sock)
+		if ((tclass == policydb->process_class) || sock) {
+			/* Use the role of process. */
 			newcontext.role = scontext->role;
-		else
-			newcontext.role = OBJECT_R_VAL;
+		} else {
+			/* Use the role of the related object. */
+			newcontext.role = tcontext->role;
+		}
 	}
 
 	/* Set the type.

On Wed, 18/06/2025 at 17.56 -0400, Paul Moore wrote:
> On Wed, Jun 11, 2025 at 3:43 PM Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > 
> > Ok then, as long as it passes the testsuite it should be
> > sufficiently
> > tested for most purposes, I suppose.
> > 
> > You can add the Tested-by line, if you like...
> 
> Thanks Guido.
> 
> I'm thinking this might be a good candidate for stable, what do
> others think?
> 
> > On Wed, 11/06/2025 at 15.37 -0400, Stephen Smalley wrote:
> > > On Wed, Jun 11, 2025 at 3:33 PM Guido Trentalancia
> > > <guido@trentalancia.com> wrote:
> > > > 
> > > > I have very little time to look at the underlying problem and,
> > > > as
> > > > already explained, I have only tested that it solves dracut-ng
> > > > issue
> > > > 377.
> > > > 
> > > > This change has widened the scope considerably compared to the
> > > > other
> > > > proposed patch, I cannot so easily certify that it does not
> > > > introduce
> > > > regressions or problems in other scenarios.
> > > > 
> > > > The main point is that the offending code in ae254858ce07 is
> > > > only
> > > > executed when the policy has not been loaded yet (and it sets
> > > > the
> > > > SID
> > > > to SECINITSID_INIT).
> > > > 
> > > > On the other hand, when the policy is not loaded
> > > > security_compute_sid()
> > > > is reduced to:
> > > > 
> > > > switch (orig_tclass) {
> > > >                 case SECCLASS_PROCESS: /* kernel value */
> > > >                         *out_sid = ssid;
> > > >                         break;
> > > >                 goto out;
> > > > return rc;
> > > > 
> > > > In other words, when the policy has not been loaded yet (which
> > > > is
> > > > when
> > > > the problem is introduced), the code in this change is not
> > > > reached
> > > > and
> > > > security_compute_sid() simply returns ssid (when called with
> > > > SECCLASS_PROCESS). So, the mechanism of action of this change
> > > > on
> > > > the
> > > > problem appears to be indirect in some way.
> > > > 
> > > > Moreover, security_compute_sid() is called by several other
> > > > functions
> > > > rather than simply by security_transition_sid(), so without
> > > > proper
> > > > extensive testing in multiple use cases (read multiple code
> > > > paths)
> > > > it's
> > > > very difficult to say the change is fully tested...
> > > > 
> > > > I would recommend more extensive testing.
> > > 
> > > It passes the selinux-testsuite without any problems, FWIW.
> > > 
> > > > 
> > > > Guido
> > > > 
> > > > On Wed, 11/06/2025 at 12.27 -0400, Paul Moore wrote:
> > > > > On Wed, Jun 11, 2025 at 9:12 AM Guido Trentalancia
> > > > > <guido@trentalancia.com> wrote:
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > > I have just tested Stephen's patch and it solves the
> > > > > > problem as
> > > > > > an
> > > > > > alternative to the dracut patch and other patches posted
> > > > > > here
> > > > > > along
> > > > > > with the issue description:
> > > > > > 
> > > > > > https://github.com/dracut-ng/dracut-ng/issues/377
> > > > > > 
> > > > > > Please note that I have only tested the success of the boot
> > > > > > process
> > > > > > with sysvinit and not other aspects of the system
> > > > > > functionality,
> > > > > > other
> > > > > > init daemons or regressions that might be caused as a
> > > > > > result of
> > > > > > applying this patch.
> > > > > 
> > > > > Understood, thanks for the testing you've done.
> > > > > 
> > > > > Would you be okay if I added your "Tested-by:" tag to the
> > > > > patch?
> > > > > 
> > > > > > On Tue, 10/06/2025 at 15.48 -0400, Stephen Smalley wrote:
> > > > > > > If the end result of a security_compute_sid() computation
> > > > > > > matches
> > > > > > > the
> > > > > > > ssid or tsid, return that SID rather than looking it up
> > > > > > > again.
> > > > > > > This
> > > > > > > avoids the problem of multiple initial SIDs that map to
> > > > > > > the
> > > > > > > same
> > > > > > > context.
> > > > > > > 
> > > > > > > Reported-by: Guido Trentalancia <guido@trentalancia.com>
> > > > > > > Fixes: ae254858ce07 ("selinux: introduce an initial SID
> > > > > > > for
> > > > > > > early
> > > > > > > boot processes")
> > > > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmai
> > > > > > > l.co
> > > > > > > m>
> > > > > > > ---
> > > > > > > v2 fixes a compiler error.
> > > > > > > 
> > > > > > >  security/selinux/ss/services.c | 16 +++++++++++-----
> > > > > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/security/selinux/ss/services.c
> > > > > > > b/security/selinux/ss/services.c
> > > > > > > index 7becf3808818..d185754c2786 100644
> > > > > > > --- a/security/selinux/ss/services.c
> > > > > > > +++ b/security/selinux/ss/services.c
> > > > > > > @@ -1909,11 +1909,17 @@ static int
> > > > > > > security_compute_sid(u32
> > > > > > > ssid,
> > > > > > >                       goto out_unlock;
> > > > > > >       }
> > > > > > >       /* Obtain the sid for the context. */
> > > > > > > -     rc = sidtab_context_to_sid(sidtab, &newcontext,
> > > > > > > out_sid);
> > > > > > > -     if (rc == -ESTALE) {
> > > > > > > -             rcu_read_unlock();
> > > > > > > -             context_destroy(&newcontext);
> > > > > > > -             goto retry;
> > > > > > > +     if (context_equal(scontext, &newcontext))
> > > > > > > +             *out_sid = ssid;
> > > > > > > +     else if (context_equal(tcontext, &newcontext))
> > > > > > > +             *out_sid = tsid;
> > > > > > > +     else {
> > > > > > > +             rc = sidtab_context_to_sid(sidtab,
> > > > > > > &newcontext,
> > > > > > > out_sid);
> > > > > > > +             if (rc == -ESTALE) {
> > > > > > > +                     rcu_read_unlock();
> > > > > > > +                     context_destroy(&newcontext);
> > > > > > > +                     goto retry;
> > > > > > > +             }
> > > > > > >       }
> > > > > > >  out_unlock:
> > > > > > >       rcu_read_unlock();
> > > > > 
> > > > > 
> 
> 
> 
