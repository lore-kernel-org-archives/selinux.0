Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9DKUErT023458
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 16:30:14 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9DKUDhD013080
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 20:30:14 GMT
Subject: Re: More SELinux fixes.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200410132043.35891.russell@coker.com.au>
References: <4165B9AA.8090803@redhat.com>
	 <200410101736.25763.russell@coker.com.au> <416C288E.1010001@redhat.com>
	 <200410132043.35891.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1097699336.28227.29.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 13 Oct 2004 16:28:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged udev patch.

There were a few lines from Dan's patch that are not in Russell's
patch.  I am not sure if they are needed.  They are in CVS for now.
allow udev_t mnt_t:dir { search };
allow udev_t { sysctl_dev_t sysctl_modprobe_t sysctl_kernel_t
sysctl_hotplug_t }:file { getattr read };

On Wed, 2004-10-13 at 06:43, Russell Coker wrote:
> On Wed, 13 Oct 2004 04:55, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > >dontaudit mount_t reserved_port_type:{tcp_socket udp_socket} name_bind;
> > >
> > >Why remove all the rules of that form?  Has something equivalent been
> > > added to a macro?
> >
> > This is now defined in can_ypbind, but I guess for mount_t it should
> > remain.  Some of these
> > rules were proliferating because of yp.  If the app uses portmap, it
> > will need this rule otherwise it
> > can rely in the rule in can_ypbind.
> 
> Yes, I think that mount does some port access in the case of NFS mounts.
> 
> > >Also put it inside ifdef(`sendmail.te', only sendmail.te uses
> > > mqueue_spool_t, so we should move the type declaration into sendmail.te.
> > >
> > >-file_type_auto_trans(snmpd_t, { usr_t var_t }, snmpd_var_lib_t, file)
> > >+file_type_auto_trans(snmpd_t, usr_t, snmpd_var_lib_t, file)
> > >+file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, file)
> > >
> > >What is the point of this change?
> >
> > I thought combining these caused problems.  I saw some avc messages with
> > snmpd trying to write to var_t, which
> > I thought might have been caused by a macro expansion problem.  When I
> > changed to the above, the problem
> > went away, could have been a red herring.
> 
> It's a red herring, please revert it.
> 
> > >+allow udev_t dev_fs:{ chr_file blk_file } { relabelfrom relabelto };
> > >
> > >The above is redundant, the below line covers it.
> > >
> > >allow udev_t { device_t device_type }:{ chr_file blk_file } { relabelfrom
> > >relabelto create_file_perms };
> >
> > I think the problem came in because these files are not covered by the
> > above command
> > type sysadm_tty_device_t, file_type, sysadmfile, ttyfile, dev_fs;
> > type user_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type,
> > dev_fs;
> > type staff_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type,
> > dev_fs;
> >
> > If you stop and restart udev, you get lots of AVC's from these.
> 
> I've attached a patch to deal with this.  udev_t needs privowner if it's to 
> work after being restarted.  Also it's not desirable for terminals with 
> active sessions to be relabeled, so I've put in a dontaudit rule for that.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
