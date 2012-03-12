Subject: Re: [PATCH] libselinux init functions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xin Ouyang <xinpascal@gmail.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <1331562280.20879.19.camel@moss-pluto>
References: 
	 <CANvtKVZJ7EU3N8M=NMROtmyTKs+VUCZyMT9uJtNmraK7rz-fAA@mail.gmail.com>
	 <1331561492.20879.15.camel@moss-pluto>
	 <1331562280.20879.19.camel@moss-pluto>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Mar 2012 10:32:18 -0400
Message-ID: <1331562738.20879.21.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-03-12 at 10:24 -0400, Stephen Smalley wrote:
> On Mon, 2012-03-12 at 10:11 -0400, Stephen Smalley wrote:
> > On Mon, 2012-03-12 at 18:17 +0800, Xin Ouyang wrote:
> > > Hi all,
> > > 
> > > I am working on the newest release of SELinux userspace packages and
> > > sysvinit, and find there are a defect for init function of libselinux.
> > >   * libselinux-2.1.9
> > >   * sysvinit-2.88dsf
> > > 
> > > AFAIK, while sysvinit is configured with SELinux, /sbin/init would be
> > > linked to libselinux. So before /sbin/init running, init_selinuxmnt()
> > > would be called.
> > > 
> > > // libselinux-2.1.9/src/init.c
> > > 
> > > static void init_lib(void) __attribute__ ((constructor));
> > > static void init_lib(void)
> > > {
> > >         selinux_page_size = sysconf(_SC_PAGE_SIZE);
> > >         init_selinuxmnt();
> > > }
> > > 
> > > As called before /sbin/init, init_selinuxmnt() is called before any
> > > other userspace process.
> > > At this time, procfs(/proc) and selinuxfs(/sys/fs/selinux or /selinux)
> > > have not been mounted, because kernel do not mount them.
> > > 
> > > So, after init_lib() -> init_selinuxmnt(), global variable
> > > "selinux_mnt" is still null.
> > > 
> > > /sbin/init would call is_selinux_enabled() to check whether selinux
> > > enabled. Because "selinux_mnt" is null, is_selinux_enabled() always
> > > return 0.
> > 
> > /sbin/init isn't supposed to call is_selinux_enabled() before calling
> > selinux_init_load_policy(), as is_selinux_enabled() will always return 0
> > if policy has not yet been loaded.  That has always been true.  Sounds
> > like you have an incorrect selinux patch for your sysvinit.
> > 
> > selinux_init_load_policy() internally tests whether SELinux is enabled
> > in the kernel (by trying to mount selinuxfs) and will correctly return
> > -1 with *enforce set to 0 so that the caller knows to proceed despite
> > the failure to load.
> > 
> > Certainly the Debian sysvinit did it correctly in the past, as did the
> > Fedora sysvinit (back when Fedora used sysvinit).
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=580272

This seems to be fixed already in the upstream sysvinit,
http://svn.savannah.nongnu.org/viewvc/sysvinit/trunk/src/init.c?root=sysvinit&r1=72&r2=90

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
