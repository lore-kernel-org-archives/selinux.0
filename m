Subject: Re: make install fails if any users are in local.users
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1110864047.30167.8.camel@cobra.ivg2.net>
References: <1110672353.29153.2.camel@cobra.ivg2.net>
	 <4235BE2F.8020009@redhat.com> <1110821742.16850.14.camel@cobra.ivg2.net>
	 <42360347.1030105@redhat.com>  <1110838214.19525.1.camel@cobra.ivg2.net>
	 <1110864047.30167.8.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 08:30:58 -0500
Message-Id: <1110893458.25947.10.camel@moss-spartans.epoch.ncsc.mil>
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

Yes, this makes sense.  I'll look into modifying setfiles to call
sepol_genusers() as well.

> Also, sepol_genusers is undocumented, and the -c option of setfiles
> is also not documented in the man pages.

Yes, I can fix this as well.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
