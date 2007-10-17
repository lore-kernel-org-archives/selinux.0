Subject: Re: concept of a permissive domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Brett Lentz <blentz@cardomain.com>,
        Stefan Schulze Frielinghaus <stefan@seekline.net>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1192475354.2910.14.camel@localhost.localdomain>
References: <C3357D99.2F091%csellers@tresys.com>
	 <4710CA44.1040300@redhat.com> <1192356878.3376.3.camel@vogon>
	 <47135FCE.5000403@redhat.com>  <1192467177.28762.7.camel@blentz>
	 <1192467538.29203.52.camel@moss-spartans.epoch.ncsc.mil>
	 <4713B257.9020409@redhat.com>
	 <1192473631.29203.56.camel@moss-spartans.epoch.ncsc.mil>
	 <1192475354.2910.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 15:47:34 -0400
Message-Id: <1192650454.20908.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-15 at 15:09 -0400, Eric Paris wrote:
> On Mon, 2007-10-15 at 14:40 -0400, Stephen Smalley wrote:
> > On Mon, 2007-10-15 at 14:32 -0400, Daniel J Walsh wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > Stephen Smalley wrote:
> > > > On Mon, 2007-10-15 at 09:52 -0700, Brett Lentz wrote:
> > > >> On Mon, 2007-10-15 at 08:40 -0400, Daniel J Walsh wrote:
> > > >>>>> - From the user point of view we could change the setenforce command
> > > >>>>>
> > > >>>>> setenforce 0
> > > >>>>> setenforce httpd_t 0
> > > >>>>>
> > > >>>>> getenforce 0
> > > >>>>> getenforce httpd_t 0
> > > >>>>>
> > > >>>>> Then we could replace both to do something in semanage to rebuild and
> > > >>>>> reload policy.
> > > >>>> But that would mean e.g. consider apache that you would have to
> > > >>>> setenforce for every domain type?
> > > >>>>
> > > >>>> apache_t
> > > >>>> apache_helper_t
> > > >>>> apache_php_t
> > > >>>> httpd_rotatelogs_t
> > > >>>> httpd_suexec_t
> > > >>>> ...
> > > >>>>
> > > >>>> There wouldn't be a setenforce for a whole module, right?
> > > >>>>
> > > >>>> 	Stefan
> > > >>>>
> > > >>> Yes although it is doubtful you would have all of those running at the
> > > >>> same time.  (httpd_t and httpd_helper_t).
> > > >>>
> > > >>>
> > > >>> -----BEGIN PGP SIGNATURE-----
> > > >>> Version: GnuPG v1.4.7 (GNU/Linux)
> > > >>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> > > >>>
> > > >>> iD8DBQFHE1/NrlYvE4MpobMRAuiiAKDgSEfnJHsFI9R1nmvvPx6PrhuQ9QCeIQHh
> > > >>> p4+2X7ixDbvoxSyMjrReLCE=
> > > >>> =6X1D
> > > >>> -----END PGP SIGNATURE-----
> > > >>
> > > >> As an SELinux user, it makes the most sense to me for this capability to
> > > >> be accessible on a per-module basis rather than per-domain.
> > > >>
> > > >> I would much rather set the httpd module as a whole to permissive rather
> > > >> than fiddle around trying to A) set all of httpd's domains to permissive
> > > >> and B) requiring a fairly significant amount of knowledge of the
> > > >> security policy to know which domains may require this intervention.
> > > >>
> > > >> I think that per-domain permissive is probably useful for certain kinds
> > > >> of policy development, but per-module permissive would be significantly
> > > >> more useful for the work that I'm currently doing with SELinux.
> > > > 
> > > > So this suggests that the userland/policy approach is the better way to
> > > > go than the kernel mechanism approach, as the former would provide the
> > > > flexibility to turn on "permissive" behavior for all domains defined by
> > > > a module more easily than the latter.  unconfined + auditallow, along
> > > > with corresponding enhancements to audit2allow to select on avc granted.
> > > > And possibly some way to enable/disable log-once behavior for avc
> > > > grantings.
> > > > 
> > > I would rather give them globing capability, something like
> > > 
> > > setenforce -t http*=0
> > > 
> > > 
> > > We do not separate everything out as per module and I think it is most
> > > likely only a certain domain is causing the problem, that the user or
> > > policy writer would be concerned with.
> > > 
> > > Steven, I don't see where you make the leap to this suggests a userland
> > > approach versus the kernel.
> > > 
> > > for i in `sesearch --allow | grep transition | awk '{ print $2}' | sort
> > > - -u | grep http`; do setenforce $i 0; done
> > > 
> > > setenforce in this example is either going to have to create a loadable
> > > policy module with all the allow and auditallow rules for the domain and
> > > load it, or a single newcommand to tell the kernel this domain is in
> > > permissive mode.
> > > 
> > > Either way I don't care.  I just need it soon.
> > 
> > Userland/policy approach is more flexible (per-domain, per-module,
> > matches domain prefix, ...) and lets you switch multiple domains
> > atomically between permissive and enforcing mode.  Kernel approach is
> > more limiting and either requires separate commit node like booleans or
> > won't support atomic transaction.
> 
> Or the 'some userspace some kernel' approach that I originally
> suggested.  setenforce httpd* 0 could walk all of policy, set the
> type_datum->primary flag appropiately on everything that matched and
> then when that new policy was loaded the permissive changes would be
> atomic.  Although using primary isn't exactly backwards compatible
> either.  It would, however, put all the intelligence in
> userspace/policy, generates denials instead of allows, solves the audit
> log spam problem and stuff like that.

Fine, let's proceed that way then.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
