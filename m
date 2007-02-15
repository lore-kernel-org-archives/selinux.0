Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: vin@netwosix.org, SELinux@tycho.nsa.gov
In-Reply-To: <1171572980.18488.30.camel@localhost.localdomain>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
	 <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1171569528.4569.9.camel@desk.netwosix.org>
	 <1171569824.32574.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1171571029.4569.18.camel@desk.netwosix.org>
	 <1171571692.32574.119.camel@moss-spartans.epoch.ncsc.mil>
	 <1171572168.5239.0.camel@desk.netwosix.org>
	 <1171572980.18488.30.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 15:59:20 -0500
Message-Id: <1171573160.32574.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 15:56 -0500, Eric Paris wrote:
> On Thu, 2007-02-15 at 21:42 +0100, Vincenzo Ciaglia wrote:
> > Il giorno gio, 15/02/2007 alle 15.34 -0500, Stephen Smalley ha scritto:
> > 
> > > Targeted policy doesn't support user roles; it only confines specific
> > > programs, primarily focused on system services.  Strict policy is what
> > > you want if you need user roles.  In the future, we hope to reduce the
> > > divergence between them so that you can have a targeted system with some
> > > limited user roles.
> > 
> > Of course Netwosix will use "strict" policies. So i'm going to start
> > working on it.
> > 
> > I'll keep you updated.
> > 
> > Thank you,
> > 
> Taking a look at your post at netwosix.org I think you should know that
> you most likely still have some serious filesystem labeling problems.
> 
> Yours:
> # ls -Z
> drwxr-xr-x  root root system_u:object_r:file_t         bin
> drwxr-xr-x  root root system_u:object_r:file_t         boot
> drwxr-xr-x  root root system_u:object_r:file_t         cdrom
> drwxr-xr-x  root root system_u:object_r:tmpfs_t        dev
> 
> Mine:
> #ls -Z
> drwxr-xr-x  root root system_u:object_r:bin_t          bin
> drwxr-xr-x  root root system_u:object_r:boot_t         boot
> drwxr-xr-x  root root system_u:object_r:device_t       dev
> 
> Maybe someone else can chime in with the best way to try this again
> since it doesn't look to me like the make relabel really got everything
> you needed (and I have no idea if you rc.sysinit is patched to pay
> attention to /.autorelabel)

Don't know about the /bin and /boot issues, but for /dev, I'd suggest
checking that your udev is built with selinux support enabled.  And also
you should do a restorecon -R /dev from rc.sysinit or similar, as there
will be some nodes created before selinux policy gets loaded.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
