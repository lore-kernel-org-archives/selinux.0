Subject: Re: make install fails if any users are in local.users
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   Colin Walters <walters@redhat.com>
In-Reply-To: <1110864047.30167.8.camel@cobra.ivg2.net>
References: <1110672353.29153.2.camel@cobra.ivg2.net>
	 <4235BE2F.8020009@redhat.com> <1110821742.16850.14.camel@cobra.ivg2.net>
	 <42360347.1030105@redhat.com>  <1110838214.19525.1.camel@cobra.ivg2.net>
	 <1110864047.30167.8.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 08:20:08 -0500
Message-Id: <1110979208.4802.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-15 at 00:20 -0500, Ivan Gyurdiev wrote:
> > > genhomedircon reads your local.users file and creates the 
> > > file_contexts.homedirs from it.  If
> > > you don't have a user phantom in local.users then file_contexts.homedirs 
> > > will cause load_policy to fail.
> 
> It seems to me that the problem is that setfiles -c, calls
> sepol_set_policydb_from_file, which loads the policy, does
> not call sepol_genusers, and as a result fails when it sees 
> the homedir contexts. 

Actually, I'm not certain what the desired behavior for setfiles -c
should be in this case.  That option was introduced by Colin so that
contexts from the file contexts configuration could be checked against a
binary policy to ensure that any errors (e.g. undefined types) would be
caught upon policy build rather than not showing up until runtime usage
of file_contexts (e.g. by rpm, setfiles/restorecon, udev, etc).  Since
that time, the file_contexts.local and file_contexts.homedir support was
introduced to allow local customization of file contexts and users
without requiring policy sources.  One question is whether setfiles -c
should only validate the base file_contexts configuration (which no
longer contains the home directory entries at all).  If so, then we need
to provide an interface to set which files are processed by
matchpathcon_init(3). This seems appropriate to me, but would mean that
e.g. a bug in genhomedircon that yields a corrupted
file_contexts.homedir won't be noticed at policy build time.
file_contexts.local definitely doesn't seem appropriate for validation
upon policy build, as it is purely for local customizations.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
