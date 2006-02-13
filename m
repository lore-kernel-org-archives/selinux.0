Message-Id: <200602131712.k1DHBuNq002624@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Jason Tang'" <jtang@tresys.com>
Subject: RE: [PATCH 1/3] libsepol - fix aliased sensitivities
Date: Mon, 13 Feb 2006 12:11:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1139847600.14253.60.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > > sensitivities in libsepol.  This first patch fixes a double free in
> > > sens_destroy().
> >
> > No, the correct solution is to avoid the aliasing in the checkpolicy
> > code.  That is what we have been doing for other similar cases;
> > policydb_read in libsepol and the kernel doesn't do any such aliasing,
> > and neither should checkpolicy.
> 
> So I think the patch below should solve the problem for checkpolicy,
> while leaving libsepol's behavior unmodified and consistent with the
> kernel's behavior (i.e. no pointer aliasing).  Look sane?

If an aliased sensitivity is never used in a level definition there will
still be problems since the hashtab_map() is being done over levels in
define_level().  So we are still able to produce a segfault in that case.  

Kevin Carr
Tresys Technology
410.290.1411 x137



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
