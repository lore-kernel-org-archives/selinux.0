Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8JRLIi007634
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 14:27:21 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8JPiTx011098
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 19:25:44 GMT
Subject: Re: patch: general cleanup
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041208185901.GA5119@jmh.mhn.de>
References: <20041206233528.GD3678@jmh.mhn.de>
	 <20041206234358.GG3678@jmh.mhn.de>
	 <1102529738.30962.13.camel@moss-lions.epoch.ncsc.mil>
	 <20041208185901.GA5119@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1102534195.30962.16.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Dec 2004 14:29:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

I am not sure how I missed the role rule in mount_macros.te.  Oh well.

On Wed, 2004-12-08 at 13:59, Thomas Bleher wrote:
> * James Carter <jwcart2@epoch.ncsc.mil> [2004-12-08 19:13]:
> > On Mon, 2004-12-06 at 18:43, Thomas Bleher wrote:
> > > * Thomas Bleher <bleher@informatik.uni-muenchen.de> [2004-12-07 00:35]:
> > > > Remove some duplicated permissions and attributes.
> > > > 
> > > > Adds a few permissions:
> > > > * initrc can setattr xconsole_device_t
> > > > * mount can read device_t:lnk_file and read xdm_t:fifo_file
> > > 
> > > Oops, forgot to attach patch.
> > > Here it is.
> > > 
> > > Thomas
> > 
> > > --- orig/macros/program/sudo_macros.te
> > > +++ mod/macros/program/sudo_macros.te
> > > @@ -31,7 +31,6 @@
> > >  rw_dir_create_file($1_sudo_t, $1_tmp_t)
> > >  rw_dir_create_file($1_sudo_t, $1_home_t)
> > >  domain_auto_trans($1_t, sudo_exec_t, $1_sudo_t)
> > > -r_dir_file($1_sudo_t, selinux_config_t)
> > >  ')
> > 
> > This doesn't look like a duplicate rule to me.
> 
> OK, I should probably comment my changes a little better.
> sudo_domain() includes newrole_domain() which allows
> r_dir_file($1_t, selinux_config_t)
> 
> > 
> > >  # arch-tag: 67418b54-b56c-44d7-841c-5c895e795cd8
> > > --- orig/macros/user_macros.te
> > > +++ mod/macros/user_macros.te
> > > @@ -221,22 +222,22 @@
> > >  #  Allow users to mount file systems like floppies and cdrom
> > >  #
> > >  mount_domain($1, $1_mount, `, fs_domain')
> > > -role $1_r types $1_mount_t;
> > >  r_dir_file($1_t, mnt_t)
> > > +allow $1_mount_t device_t:lnk_file read;
> > >  allow $1_mount_t removable_device_t:blk_file read;
> > >  allow $1_mount_t iso9660_t:filesystem relabelfrom;
> > >  allow $1_mount_t removable_t:filesystem { mount relabelto };
> > >  allow $1_mount_t removable_t:dir mounton;
> > >  ifdef(`xdm.te', `
> > >  allow $1_mount_t xdm_t:fd use;
> > > -allow $1_mount_t xdm_t:fifo_file write;
> > > +allow $1_mount_t xdm_t:fifo_file { read write };
> > >  ')
> > >  ')
> > 
> > Same with the role $1_r types $1_mount_t rule.  I see similar role rules
> > elsewhere for system_r and sysadm_r, but not for user_r and staff_r.
> 
> It's in macros/program/mount_macros.te, line 30.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
