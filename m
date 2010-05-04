Subject: Re: I am trying to build an MLS livecd.
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@redhat.com>
In-Reply-To: <1273005563.15368.21.camel@localhost>
References: <4BE04C8A.7070907@redhat.com>
	 <1272991523.30175.142.camel@moss-pluto.epoch.ncsc.mil>
	 <4BE064F2.3060505@redhat.com>
	 <1272998789.30175.170.camel@moss-pluto.epoch.ncsc.mil>
	 <4BE06DED.4070801@redhat.com>
	 <1273001899.30175.190.camel@moss-pluto.epoch.ncsc.mil>
	 <1273005563.15368.21.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 May 2010 16:46:13 -0400
Message-ID: <1273005973.15368.24.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-05-04 at 16:39 -0400, Eric Paris wrote:
> On Tue, 2010-05-04 at 15:38 -0400, Stephen Smalley wrote:
> > On Tue, 2010-05-04 at 14:56 -0400, Daniel J Walsh wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > On 05/04/2010 02:46 PM, Stephen Smalley wrote:
> > > > On Tue, 2010-05-04 at 14:18 -0400, Daniel J Walsh wrote:
> > > >> -----BEGIN PGP SIGNED MESSAGE-----
> > > >> Hash: SHA1
> > > >>
> > > >> On 05/04/2010 12:45 PM, Stephen Smalley wrote:
> > > >>> On Tue, 2010-05-04 at 12:34 -0400, Daniel J Walsh wrote:
> > > >>>> -----BEGIN PGP SIGNED MESSAGE-----
> > > >>>> Hash: SHA1
> > > >>>>
> > > >>>> But for some reason.  Setfiles is not writing the correct labels to the
> > > >>>> livecd, iff the label includes a range with a level not supported on the
> > > >>>> host machine.
> > > >>>>
> > > >>>> grep s15 /tmp/mls.log
> > > >>>> sbin/setfiles:  /home matched by
> > > >>>> system_u:object_r:home_root_t:s0-s15:c0.c1023
> > > >>>> /sbin/setfiles:  /home/liveadmin matched by
> > > >>>> staff_u:object_r:user_home_dir_t:s0-s15:c0.c1023
> > > >>>> /sbin/setfiles:  /home/liveuser matched by
> > > >>>> privuser_u:object_r:user_home_dir_t:s0-s15:c0.c1023
> > > >>>>
> > > >>>> When I boot the livecd these are all labeled as
> > > >>>> unconfined_u:object_r:TYPE:s0.
> > > >>>>
> > > >>>> Any idea why this would happen?
> > > >>>>
> > > >>>> Of course these labels are invalid, so the MLS livecd is broken.
> > > >>>
> > > >>> Does the same problem occur if the type is undefined in the host policy?
> > > >>> IOW, is this a problem with undefined contexts in general or specific to
> > > >>> the MLS field?
> > > >>>
> > > >>> What output do you get if you run setfiles with -vv?
> > > >>>
> > > >>> Could mcstransd be incorrectly mapping the range to s0?
> > > >>>
> > > >>
> > > >>
> > > >> I attached the actuall output.  Problem is it takes 1/2 hour to get back
> > > >> to this state.
> > > >>
> > > >> mcstransd would not be running in the environment.  livecd has a hacked
> > > >> out environment that thinks it is running SELinux in enforcing mode.
> > > >>
> > > >> /selinux is a big hack and does nothing.
> > > > 
> > > > BTW, can you or Eric describe exactly what that "hacked out environment"
> > > > looks like and how the fake /selinux is set up?
> > > > 
> > > > It seems like we could make setfiles more directly support this kind of
> > > > thing (via a new option) so that we don't need that fake environment at
> > > > all.  It already uses its own SELINUX_CB_VALIDATE callback function, so
> > > > we can easily turn off the canonicalization of contexts when it is being
> > > > used on a foreign policy.
> > > > 
> > > 
> > > I think most of the hacking is to allow tools like selinux-policy to
> > > work correctly, without screwing up the hosts environment.
> > > 
> > > I have patches coming to fix semanage which expects booleans to exist
> > > even if you have a different store.
> > > 
> > > I think all the changes are in
> > > /usr/lib/python2.6/site-packages/imgcreate/creator.py
> > 
> > I did the following:
> > # mkdir -p /altroot/proc /altroot/selinux /altroot/home/sds
> > # for d in /etc /lib64 /sbin /bin
> > do
> > cp -a $d /altroot/$d
> > done
> > # mount -t proc none /altroot/proc
> > # runcon -t livecd_t -- runcon -t setfiles_mac_t -- chroot /altroot setfiles -vv /etc/selinux/mls/contexts/files/file_contexts /home
> > setfiles reset /home context unconfined_u:object_r:default_t:s0->system_u:object_r:home_root_t:s0-s15:c0.c1023
> > setfiles reset /home/sds context unconfined_u:object_r:default_t:s0->user_u:object_r:user_home_dir_t:s0-s15:c0.c1023
> > 
> > And I can see it on disk via:
> > # runcon -t livecd_t -- runcon -t setfiles_mac_t -- getfattr -n security.selinux /altroot/home/sds
> > getfattr: Removing leading '/' from absolute path names
> > # file: altroot/home/sds
> > security.selinux="user_u:object_r:user_home_dir_t:s0-s15:c0.c1023
> > 
> > Note that both getting and setting has to be done from setfiles_mac_t or
> > we'll fail the mac_admin check (unless permissive).
> > 
> > dmesg shows:
> > SELinux:  Context system_u:object_r:auditd_etc_t:s15:c0.c1023 is not valid (left unmapped).
> > SELinux:  Context system_u:object_r:selinux_config_t:s15:c0.c1023 is not valid (left unmapped).
> > SELinux:  Context system_u:object_r:wm_exec_t:s0 is not valid (left unmapped).
> > SELinux:  Context system_u:object_r:home_root_t:s0-s15:c0.c1023 is not valid (left unmapped).
> > SELinux:  Context user_u:object_r:user_home_dir_t:s0-s15:c0.c1023 is not valid (left unmapped).
> > 
> > In other words, the kernel functionality for setting and getting unknown
> > contexts seems to be working fine, and setfiles operates correctly.  As
> > to how livecd is messing things up, I have no idea.
> 
> So I built the livecd, eventually mounted the root filesystem (what a
> pain, it is 3 layers deep) and checked it out:
> 
> # getfattr -d -n security.selinux home/*
> # file: home/liveadmin
> security.selinux="system_u:object_r:unlabeled_t:s0
> 
> # file: home/liveuser
> security.selinux="system_u:object_r:unlabeled_t:s0
> 
> 
> *********************  And if we look what the disk actually says....
> 
> 
> # runcon -t livecd_t -- runcon -t setfiles_mac_t -- getfattr -n
> security.selinux home/*
> # file: home/liveadmin
> security.selinux="staff_u:object_r:user_home_dir_t:s0-s15:c0.c1023
> 
> # file: home/liveuser
> security.selinux="privuser_u:object_r:user_home_dir_t:s0-s15:c0.c1023

Just to make sure I am REALLY looking at what the disk says I looked at
it with debugfs and sure enough:

debugfs:  stat /home/liveuser
Inode: 49519   Type: directory    Mode:  0700   Flags: 0x0
.....
Extended attributes stored in inode body: 
  selinux = "privuser_u:object_r:user_home_dir_t:s0-s15:c0.c1023\000" (52)


debugfs:  stat /home/liveadmin
Inode: 49523   Type: directory    Mode:  0700   Flags: 0x0
....
Extended attributes stored in inode body: 
  selinux = "staff_u:object_r:user_home_dir_t:s0-s15:c0.c1023\000" (49)

So whatever the problem, it must be coming on the first boot rather than
when it is created (or you are not using an up2date f13 to create
things.....)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
