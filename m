Subject: RE: [RFC] Ability to allow undefined permissions and classes -v2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Chad Sellers <csellers@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <1171568673.18488.25.camel@localhost.localdomain>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015888BA220@exchange.columbia.tresys.com>
	 <1171564421.32574.36.camel@moss-spartans.epoch.ncsc.mil>
	 <1171565182.32574.50.camel@moss-spartans.epoch.ncsc.mil>
	 <1171566336.18488.22.camel@localhost.localdomain>
	 <1171567664.32574.70.camel@moss-spartans.epoch.ncsc.mil>
	 <1171568673.18488.25.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 14:49:51 -0500
Message-Id: <1171568991.32574.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 14:44 -0500, Eric Paris wrote:
> On Thu, 2007-02-15 at 14:27 -0500, Stephen Smalley wrote:
> > On Thu, 2007-02-15 at 14:05 -0500, Eric Paris wrote:
> 
> >   
> > > Basically, should I walk the policy and find out everything it knows
> > > nothing about or should I continue to just walk the kernel headers and
> > > and only allow 'unknown' things that aren't quite the same between the
> > > kernel headers and the policy?
> > 
> > I'd stay with using the kernel headers as the basis.  And I think you'll
> > want to disable this allow_unknown behavior when called from selinuxfs,
> > so create a separate security_compute_av_user() function to be called by
> > selinuxfs, and pass a flag down to the internal helper.
> > 
> 
> Sounds good, will do.  I'll admit though i'm surprised the selinuxfs
> access interface uses security_compute_av rather than
> avc_has_perm_noaudit.  Out of curiosity what is the reason for not
> wanting to cache those decisions?

It doesn't make any sense to cache them in the kernel, as 1) you have
already paid the cost of calling the kernel, and 2) the kernel itself
won't use them so you are polluting its cache.  They are cached by the
userspace AVC in libselinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
