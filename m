Subject: Re: libsemanage.semanage_install_active: error during semodule -n
	-v -b base.pp -s refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: SELinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Caleb Case <ccase@tresys.com>
In-Reply-To: <48515E78.40400@windriver.com>
References: <4851361E.3030305@windriver.com>
	 <1213288802.17842.195.camel@moss-spartans.epoch.ncsc.mil>
	 <48515E78.40400@windriver.com>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 13:55:29 -0400
Message-Id: <1213293329.17842.246.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-06-12 at 13:35 -0400, Vikram Ambrose wrote:
> Stephen Smalley wrote:
> > On Thu, 2008-06-12 at 10:43 -0400, Vikram Ambrose wrote:
> >   
> >> During the "make load" procedure with refpolicy, the semodule command 
> >> fails, so I tried it manually and I see this error.
> >>
> >> root@ubuntu:/home/vikram/refpolicy-ac# semodule -b 
> >> /usr/share/selinux/refpolicy/base.pp -s refpolicy -v -n
> >> Attempting to install base module '/usr/share/selinux/refpolicy/base.pp':
> >> Ok: return value of 0.
> >> Committing changes:
> >> libsemanage.semanage_install_active: setfiles returned error code 1. (No 
> >> such file or directory).
> >>     
> >
> > whereis setfiles
> >
> >   
> setfiles and the rest of the SELinux "toolchain" was all built from svn 
> and placed into /hone/testing/root
> root's environment has PATH that contains /home/testing/root/bin
> as well as LD_LIBRARY_PATH to /home/testing/root/lib
> 
> Does libsemanage have a hard coded path to setfiles?

Yes, although it can be overridden via /etc/selinux/semanage.conf.
Add something like:
[setfiles]
path = /path/to/setfiles
[end]

Or you could run semodule in a chroot environment if you've set one up.

> 
> > What versions are you using?  Is this with the packages included in
> > Hardy Heron?
> >
> >   
> svn from yesterday.

I see.  Are you aware that Ubuntu 8.04 has SELinux support (apt-get
install selinux)?  Although you may still want to build a custom policy,
as their initial default policy was minimal.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
