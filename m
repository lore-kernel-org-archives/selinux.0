Subject: RE: [PATCH 1/3] libsepol - fix aliased sensitivities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Jason Tang'" <jtang@tresys.com>
In-Reply-To: <200602131712.k1DHBuNq002624@gotham.columbia.tresys.com>
References: <200602131712.k1DHBuNq002624@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 12:25:03 -0500
Message-Id: <1139851503.14253.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-13 at 12:11 -0500, Kevin Carr wrote:
> > > > sensitivities in libsepol.  This first patch fixes a double free in
> > > > sens_destroy().
> > >
> > > No, the correct solution is to avoid the aliasing in the checkpolicy
> > > code.  That is what we have been doing for other similar cases;
> > > policydb_read in libsepol and the kernel doesn't do any such aliasing,
> > > and neither should checkpolicy.
> > 
> > So I think the patch below should solve the problem for checkpolicy,
> > while leaving libsepol's behavior unmodified and consistent with the
> > kernel's behavior (i.e. no pointer aliasing).  Look sane?
> 
> If an aliased sensitivity is never used in a level definition there will
> still be problems since the hashtab_map() is being done over levels in
> define_level().  So we are still able to produce a segfault in that case.  

Failure to define a level for each sensitivity would be a bug in the
policy; checkpolicy should likely check for that case and treat it as a
fatal error.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
