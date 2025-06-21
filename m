Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B14207A
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750525279; cv=none; b=G1Bhsh5qWZAIV1ReFYsPZJUAr6wiD6JDI/Jbg9+T6ihg7YITcwZc7R4r56x8P/6MgbDOTCVOex1vThCH/8zGiDIoN8+sWg3M+XZajxnm3XdG95ac2/BuJ1Qbi5nONhNPzkcBIH2dPEGtB+TgwCG5wlg9pdMTLjQskMXDzNQHvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750525279; c=relaxed/simple;
	bh=JXVaNDf6SKSSYzkWaqfbzmmsUuAu04juoMTbGtVTdPQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=tpbs8PNjIR1ich9xAv2p4WOJL36pNsU9+mVvCDrCm+BIy54jOE7mqeyIOB2vjrvIjlBnkbZHWnaHS5b5AK2F0UmZGmuXewzVWX4l/5wUreOdc/4WH4FO3KJ1WDVbds62in/a/Vpau2m5n6dr2onELhYBaTJiB4JKO5VPiEyFcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=b7Mn62e1; arc=none smtp.client-ip=62.149.158.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="b7Mn62e1"
Received: from [192.168.43.2] ([109.54.112.128])
	by Aruba SMTP with ESMTPSA
	id T1XZu4sRS2QPuT1XZuDcN1; Sat, 21 Jun 2025 18:58:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1750525085; bh=JXVaNDf6SKSSYzkWaqfbzmmsUuAu04juoMTbGtVTdPQ=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=b7Mn62e1v9dRKoq+JyAS4rk+YD0EZ0+P8GAdZBfCA7bTsjJZtcnnVthU5N02HvDR0
	 klAMAl9x8q+JUM43sApNyj3B3TuRAYXSXasHAe6nlI4EK51oTZ3eUqYQMA1yGQqjoN
	 A/gyraY6CPFrZTmB/zIVdVZkI+KkEZIMUVsBJNgF6sSLdrSho81sGE0mXm/fqFmscs
	 Gl1gVyi36UUCrdxGFshZhLDKs5YVi5XdfVcadatXgKTctfGPeiuB66Li0DnNjmEVCL
	 CLTv0+QyJXbZpVJq3lxJrUUeuG8qjopMIe6QxoEO5o6caK92V3tZYkmUPyZ5OBdGRa
	 X3fZUg0T6tJng==
Message-ID: <1750525084.6235.11.camel@trentalancia.com>
Subject: [PATCH 2/2] selinux: when computing the SID before policy load take
 into account the socket class case (was [PATCH v2] selinux: change
 security_compute_sid to return the ssid or tsid on match)
From: Guido Trentalancia <guido@trentalancia.com>
To: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Date: Sat, 21 Jun 2025 18:58:04 +0200
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
X-CMAE-Envelope: MS4xfGOPgm30JdB5YSuG7N0qByOBfyNdP4TwBj/8Gri0TGcfgW9PMshBmKI2N8M8p//wR1YQrLF7pNd3iYLjFyP1YRE9c48kZq4geac9tmYe2bCVCSKXk5Nk
 Ei/NbrwBGgWVWVN5HGinwgTNO36PVObyWCw9d1/Itha+8ccySX0ajo9ZQB5vKslavuSO+mw+dwcEtLhGssu+m0qEVpp7FXa45gW+6Ts1DRzVqHouucKo86B3

When computing the SID before the policy is loaded,
take into account not only the case of the process
class, but also the case of sockets classes.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 security/selinux/ss/services.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/security/selinux/ss/services.c	2025-06-21 14:50:05.168301991 +0200
+++ b/security/selinux/ss/services.c	2025-06-21 15:12:52.656293645 +0200
@@ -1750,6 +1750,12 @@ static int security_compute_sid(u32 ssid
 	bool sock;
 
 	if (!selinux_initialized()) {
+		sock = security_is_socket_class(orig_tclass);
+		if (sock) {
+			*out_sid = ssid;
+			goto out;
+		}
+
 		switch (orig_tclass) {
 		case SECCLASS_PROCESS: /* kernel value */
 			*out_sid = ssid;

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
