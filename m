Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i56Aj0rT028958
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 06:45:00 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i56Aiu22009468
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 06:44:57 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 6 Jun 2004 10:44:58 -0000
Date: Sun, 6 Jun 2004 10:42:20 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: patches to debian 1.12 policy (including new "discover" policy)
Message-ID: <20040606104220.GD9675@lkcl.net>
References: <20040605125014.GW3856@lkcl.net> <200406061907.59966.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406061907.59966.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 06, 2004 at 07:07:59PM +1000, Russell Coker wrote:
> On Sat, 5 Jun 2004 22:50, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > however, there's definitely a need for a policy for the
> > discover package.
> 
> How does discover differ from the "kudzu" program in Fedora?  They appear to 
> do very similar things, maybe the kudzu policy will do the job?

 discover is much more passive than kudzu.

 discover-modprobe is used to load kernel modules, and that's about
 the end of its active capabilities.

 the discover program simply "reads" information from the kernel
 and tells you the pretty names.

 it can then be used by other programs such as x-configuration
 programs to find out the name of video card in use, etc.

 i believe that hotplug uses it.


 kudzu is quite a pain: i did investigate using it on debian but
 it has so many hard-coded redhat-specificisms in it that i gave
 up and raised a wish-list bug request about it.

 it would actually be very good if kudzu could be rewritten in
 two ways:

 1) it used discover (or libdiscover if nothing else).

 2) it called out to scripts rather than to hard-coded programs.

 but anyway.

 yes, basically, discover is primarily passive whilst kudzu is 
 most definitely active.

 therefore, discover doesn't need half of the things that kudzu
 does.


> > main comments / things out of this patch:
> >
> > -  for cupsys-bsd compatability in debian.
> >
> > -  Allow hotplug to copy /etc/network/ifstate.hotplug to ifstate
> 
> file_type_auto_trans(hotplug_t, etc_t, etc_runtime_t, file)
> 
> The above rule should do it.
 
 ha, cool.

> > -  allow kdm's kde_greet and krootimage to access /var/lib/defoma.
> >
> > -  ssh-agent must be granted sigchild to xdm_t in order for kdm to
> >    be able to spawn a kde user session (!!)
> >
> > there are other things in here which i have been playing
> > with: in my desperate attempts to get a kde user session
> > started, i even created something to allow access to /etc/qt3
> > and i notice that somehow, (in unmodified vanilla debian
> > 1.12 policy!) permission is granted to kdm to _create_
> > /etc/qt3/.qtrc.lock, but that user sessions are not then
> > allowed to create file locks on it.
> >
> >
> > the difference between that one and this one is that 1) i don't
> > understand how i am supposed to correctly grant fd { use }
> > in a sufficiently generic way to cope with discover being run
> > by sysadm_r to newrole_t, sysadm_t and getty ttys.  i don't get it.
> 
> allow discover_t privfd:fd use;

 ace!  v. helpful.  a new incantation i can now plug into my
 brain in other circumstances :)

> > i install cupsys-bsd because openoffice.org needs that for compatibility
> > printing (lpd).  therefore i needed to add a thingy to inetd.te to allow
> > cupsd to run its compatibility-mode lpd thing.
> 
> It appears that you haven't put in enough policy to allow cups to be run from 
> inetd, so allowing the port bind isn't going to do much good.

 :)  oops.

> > lots of weird stuff, here.  x server isn't granted permission to access
> > /tmp/.font-unix (?).  kde_greet and krootimage need to access defoma.
> 
> +allow hwclock_t file_t:dir { search };
> +allow ldconfig_t lib_t:file { getattr read };
> +allow ldconfig_t usr_t:file { read };
> +allow ldconfig_t usr_t:lnk_file { read unlink };
> 
> Those are not desired.

 oh.   i think i understand about the ldconfig_t ones.  i don't
 grok the hwclock_t one, though.

> +allow system_chkpwd_t sshd_t:tcp_socket { read write };
> +allow system_chkpwd_t sshd_t:unix_stream_socket { read write };
> 
> When Debian's pam has the same features as that in Fedora those won't happen.

 :)

 *sigh*.

> +# allow kdm's kde_greet and krootimage to access /var/lib/defoma.
> +allow xdm_t readable_t:dir { getattr read search };
> +allow xdm_t readable_t:file { getattr read };
> 
> I've changed my policy to have the defoma directory labelled as fonts_t.

 great.


> What is /tmp/.fonts-unix?  What creates it?
 
 mmmm.... xfs i think.

> Maybe /etc/qt3 should be labelled as xdm_rw_etc_t?

 i'm not so sure.

 it's ... well - piss-poor practice to allow writing to /etc on
 non-configuration stuff.

 these are _lock_ files that are being created there!

 but hey, given that somehow, xdm manages to create these lock
 files, and then in a user-context, kde programs attempt to
 also create them, i'm inclined to say that if you think it would
 help, yes, /etc/qt3 should be writeable.

 
> +/etc/network/ifstate.hotplug   --      system_u:object_r:etc_runtime_t
> I've changed this rule and also moved it to dpkg.fc as it's Debian specific.

 ooooo.  okay :)

> 
> PS  I've just uploaded a new policy package to Debian with these changes.  If 
> you want to look at the kudzu policy then note that I've removed it from the 
> Debian package (it currently doesn't work in Debian) so you'll have to see 
> the source of the policy package.

 had a quick look: yes it does _way_ more than discover possibly needs.

 the reason why discover.te is big is because i deliberately split out
 discover from discover-modprobe.

 /sbin/discover-modprobe is only run from /etc/init.d/discover (and it then
 runs /bin/discover) whilst /bin/discover can be run from other
 locations.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
