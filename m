Subject: Re: In the midst of doing a conversion of audit2why to python
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4784FA66.8010806@redhat.com>
References: <4783CE58.40008@redhat.com>
	 <1199822878.9393.170.camel@moss-spartans.epoch.ncsc.mil>
	 <4784FA66.8010806@redhat.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 13:02:50 -0500
Message-Id: <1199901770.9393.274.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-09 at 11:46 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Tue, 2008-01-08 at 14:26 -0500, Daniel J Walsh wrote:
> > I want to make this code available to audit2why/audit2allow,
> > setroubleshoot and potentially system-config-selinux.
> > 
> > I have two questions,
> > 
> > 
> > Is there a way for audit2why to figure out whether an AVC would be
> > dontaudited by the current policy?
> > 
> >> The avd returned by sepol_compute_av_reason() includes all of the access
> >> vectors.  avd.auditdeny is the set of permissions that would be audited
> >> if denied, i.e. the complement of the dontaudit rules. Something like if
> >> (~avd.auditdeny & av) then printf("would be dontaudit'd");
> > 
> > If we add audit2why python bindings should I put it in libselinux?
> > sepolgen?
> > 
> > 
> > Attached .h file describes functions and constants.
> > 
> >> I'm not sure what you are doing - auditwhy presently is a program that
> >> links in the static libsepol, since the libsepol interfaces being used
> >> by it are not provided by the shared libsepol (as they aren't properly
> >> encapsulated).
> > 
> What is the field 	sepol_access_vector_t decided;
> used for?

It indicates what permissions were computed/decided by the security
server.  It is always guaranteed to at least contain all of the
'requested' permissions passed into the compute_av call, but not
necessarily any others.  For your purposes, it shouldn't matter.  It is
there to support certain kinds of dynamic policies, not presently in use
by our existing security server.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
