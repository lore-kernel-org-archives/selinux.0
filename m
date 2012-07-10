Message-ID: <1341938716.16964.61.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Anon_inodefs denials in SEAndroid with genlock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Palarz Thomas-DCJ738 <tom.palarz@motorolasolutions.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 10 Jul 2012 12:45:16 -0400
In-Reply-To: <1341937629.16964.57.camel@moss-pluto.epoch.ncsc.mil>
References: 
	<535CAAB8CFB77F45B4140FC615F0F21E1D2AD9EC@CH1PRD0410MB381.namprd04.prod.outlook.com>
	 <1341937629.16964.57.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-LQH8vP7YIp3BspuYxwsr"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-LQH8vP7YIp3BspuYxwsr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-07-10 at 12:27 -0400, Stephen Smalley wrote:
> On Tue, 2012-07-10 at 16:17 +0000, Palarz Thomas-DCJ738 wrote:
> > I've been working with trying SEAndroid on a Qualcomm dev board that
> > uses the genlock driver as part of it's integration with
> > SurfaceFlinger and have seen some denials that I'm having a hard time
> > tracking down what is going on.
> > 
> > The anon_inode is showing as unlabeled. Do I need to add some sort of
> > transition rule?
> > 
> > Initially, the anon_inodefs was showing as not supporting XATTRs in
> > the SELinux init output, but I've gotten past that and added a
> > genfscon (I used inotify as an example).
> > 
> <snip>
> > I add the following policy statements to at least allow me to move
> > forward for the time being, but still get the denials.
> > 
> > allow trusted_app genlock_device:chr_file write;
> > allow trusted_app unlabeled:file write;
> > 
> > I've verified that the above lines do make it into the policy.conf in
> > the sepolicy_intermediates build output.
> > 
> > I made the SEAndroid changes to the Qualcomm based on seandroid-4.0.3
> > and have double-checked the work. The kernel defconfig was rather
> > different and I did have to add EXT4_FS_SECURITY=y.
> > 
> > Any help?
> 
> In modern kernel versions, linux/fs/anon_inodes.c:anon_inode_mkinode()
> sets the S_PRIVATE flag in inode->i_flags, thereby disabling all
> permission checking on it as there can be only one.  So I'm guessing you
> are using an old kernel?  Your TE allow rules don't work because the
> denial is occurring due to the MLS constraints - you are violating the
> no-write-down restriction when a process with a category set tries to
> write to a file with none.

Ah, actually, that's a bug in our binder security hooks.  Patch attached
for seandroid-omap-panda-3.0.

-- 
Stephen Smalley
National Security Agency

--=-LQH8vP7YIp3BspuYxwsr
Content-Disposition: attachment;
	filename="0001-Do-not-apply-permission-checks-to-private-files.patch"
Content-Type: text/x-patch;
	name="0001-Do-not-apply-permission-checks-to-private-files.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit


--=-LQH8vP7YIp3BspuYxwsr--
