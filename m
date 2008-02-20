Subject: Re: How would I go about figuring out if two SELinux MLS Levels
	intersect?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1203528302.9902.226.camel@moss-spartans.epoch.ncsc.mil>
References: <47BB5488.1070008@redhat.com>
	 <1203528302.9902.226.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 20 Feb 2008 12:28:09 -0500
Message-Id: <1203528489.9902.230.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-20 at 12:25 -0500, Stephen Smalley wrote:
> On Tue, 2008-02-19 at 17:13 -0500, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > s2:c0-s2:c0.c10 and s2:c9.c10
> > 
> > 
> > IE How do I do the arbitration/dominance math in Code?
> 
> (cc'ing the list)
> 
> You can model it as a permission check between the two contexts, and
> then write a MLS constraint in policy that requires dominance or
> whatever relationship you want.  Then it is just an avc_has_perm call.
> Same thing that we did for permission check in the pam_selinux code to
> verify that the user's level is within his range.  Or what we talked
> about for applying a permission check in mcstransd to see if the
> requestor is allowed to translate the context.  Not sure that ever got
> implemented in mcstransd though?

Also, just to note:  the MLS dominance logic already exists within
libsepol and within the kernel security server.  We just have to expose
it via an interface.  One way to do that is to express it as a
permission check, where we already have an interface.  Another way would
be to introduce a new interface specifically for that purpose.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
