Subject: Re: libselinux does not work properly in upstart/initrd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1204223131.31790.161.camel@moss-spartans.epoch.ncsc.mil>
References: <47C6F067.5050209@redhat.com>
	 <1204223131.31790.161.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 13:49:12 -0500
Message-Id: <1204224552.31790.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-28 at 13:25 -0500, Stephen Smalley wrote:
> On Thu, 2008-02-28 at 12:33 -0500, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > https://bugzilla.redhat.com/show_bug.cgi?id=434793
> > 
> > The way the upstart initrd works is to run nash with a builtin
> > loadpolicy.  The problem is nash starts before the /sysmount files
> > system is mounted, so libselinux does not have an /etc/selinux/config to
> > read.  It defaults to targeted.  So when nash finally executes
> > loadpolicy (selinux_init_load_policy) it has the wrong config.
> > Switching to any other type of policy will fail and
> > selinux_init_load_policy will look for targeted.
> > 
> > I changed this function to reload the config, to fix this problem.
> > 
> > I think I did all the hidden stuff correctly.  I don't think we want to
> > expose these functions.
> 
> To make a function hidden, just mark it with hidden.
> hidden_def and hidden_proto are about creating a private definition
> within the library for intra-library calls that do not cause a
> relocation, not about hiding the definition altogether.
> 
> Concerns about this patch:
> - it isn't thread safe,
> - it only "fixes" the load policy case, not any other libselinux
> function call.
> 
> As an alternative, maybe we should revive Steve Grubb's lazy init patch
> for libselinux?  That won't reload each time, but will defer the initial
> reading until you first invoke a libselinux function.  The last version
> of the patch that I saw is attached.

Note that Steve's patch (and yours) only addressed
init_selinux_config(), not the other constructor - init_lib().

So, for example, if selinuxfs isn't already mounted at startup, then
we'd have a similar problem with selinux_mnt not getting defined.

Same approach could be applied to init_lib(), although it would require
inserting the guards appropriately.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
