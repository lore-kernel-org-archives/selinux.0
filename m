Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5698BrT028672
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 05:08:11 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5698522008468
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 05:08:06 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: patches to debian 1.12 policy (including new "discover" policy)
Date: Sun, 6 Jun 2004 19:07:59 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040605125014.GW3856@lkcl.net>
In-Reply-To: <20040605125014.GW3856@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406061907.59966.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 5 Jun 2004 22:50, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> however, there's definitely a need for a policy for the
> discover package.

How does discover differ from the "kudzu" program in Fedora?  They appear to 
do very similar things, maybe the kudzu policy will do the job?

> main comments / things out of this patch:
>
> -  for cupsys-bsd compatability in debian.
>
> -  Allow hotplug to copy /etc/network/ifstate.hotplug to ifstate

file_type_auto_trans(hotplug_t, etc_t, etc_runtime_t, file)

The above rule should do it.

> -  allow kdm's kde_greet and krootimage to access /var/lib/defoma.
>
> -  ssh-agent must be granted sigchild to xdm_t in order for kdm to
>    be able to spawn a kde user session (!!)
>
> there are other things in here which i have been playing
> with: in my desperate attempts to get a kde user session
> started, i even created something to allow access to /etc/qt3
> and i notice that somehow, (in unmodified vanilla debian
> 1.12 policy!) permission is granted to kdm to _create_
> /etc/qt3/.qtrc.lock, but that user sessions are not then
> allowed to create file locks on it.
>
>
> the difference between that one and this one is that 1) i don't
> understand how i am supposed to correctly grant fd { use }
> in a sufficiently generic way to cope with discover being run
> by sysadm_r to newrole_t, sysadm_t and getty ttys.  i don't get it.

allow discover_t privfd:fd use;

> i install cupsys-bsd because openoffice.org needs that for compatibility
> printing (lpd).  therefore i needed to add a thingy to inetd.te to allow
> cupsd to run its compatibility-mode lpd thing.

It appears that you haven't put in enough policy to allow cups to be run from 
inetd, so allowing the port bind isn't going to do much good.

> lots of weird stuff, here.  x server isn't granted permission to access
> /tmp/.font-unix (?).  kde_greet and krootimage need to access defoma.

+allow hwclock_t file_t:dir { search };
+allow ldconfig_t lib_t:file { getattr read };
+allow ldconfig_t usr_t:file { read };
+allow ldconfig_t usr_t:lnk_file { read unlink };

Those are not desired.

+allow system_chkpwd_t sshd_t:tcp_socket { read write };
+allow system_chkpwd_t sshd_t:unix_stream_socket { read write };

When Debian's pam has the same features as that in Fedora those won't happen.

+# allow kdm's kde_greet and krootimage to access /var/lib/defoma.
+allow xdm_t readable_t:dir { getattr read search };
+allow xdm_t readable_t:file { getattr read };

I've changed my policy to have the defoma directory labelled as fonts_t.

What is /tmp/.fonts-unix?  What creates it?

Maybe /etc/qt3 should be labelled as xdm_rw_etc_t?

+/etc/network/ifstate.hotplug   --      system_u:object_r:etc_runtime_t
I've changed this rule and also moved it to dpkg.fc as it's Debian specific.


PS  I've just uploaded a new policy package to Debian with these changes.  If 
you want to look at the kudzu policy then note that I've removed it from the 
Debian package (it currently doesn't work in Debian) so you'll have to see 
the source of the policy package.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
