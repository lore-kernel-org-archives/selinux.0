Subject: Re: [PATCH] refpolicy: kernel_filesystem changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <1186504631.18881.29.camel@gorn>
References: <200708022003.l72K3hC5029678@redsox.boston.devel.redhat.com>
	 <1186504631.18881.29.camel@gorn>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 12:45:00 -0400
Message-Id: <1186505100.26457.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-07 at 12:37 -0400, Christopher J. PeBenito wrote:
> On Thu, 2007-08-02 at 16:03 -0400, dwalsh@redhat.com wrote:
> > anon_inodefs file system
> 
> > +type anon_inodefs_t;
> > +fs_type(anon_inodefs_t)
> > +files_mountpoint(anon_inodefs_t)
> > +genfscon anon_inodefs / gen_context(system_u:object_r:anon_inodefs_t,s0)
> 
> Does this not work as task sid?

No, the pseudo fs creates a single inode that is shared by all users,
only differentiated by their open file (fd) objects.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
