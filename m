Subject: Re: No such file or directory:
 '/etc/selinux/targeted/contexts/files/file_contexts.homedirs'
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Denis BUCHER <dbucherml@hsolutions.ch>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <4B841220.3090007@hsolutions.ch>
References: <4B83FED0.208@hsolutions.ch>
	 <1266942546.871.26.camel@moss-pluto.epoch.ncsc.mil>
	 <4B841220.3090007@hsolutions.ch>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Feb 2010 13:05:27 -0500
Message-Id: <1266948327.871.31.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-02-23 at 18:36 +0100, Denis BUCHER wrote:
> Dear Stephen, Dear Daniel,
> 
> Le 23.02.2010 17:29, Stephen Smalley a écrit :
> >> # usermod -d<path>  <user>
> >>
> >> /usr/sbin/genhomedircon: [Errno 2] No such file or directory:
> >> '/etc/selinux/targeted/contexts/files/file_contexts.homedirs'
> >> usermod: warning: unable to relabel the homedir (...)
> >>
> >> But homedir was changed anyway...
> >>
> >> Just to let you know... (?)
> >
> > If you are using Fedora, then this would be best directed to
> > selinux@lists.fedoraproject.org (formerly
> > fedora-selinux-list@redhat.com).
> 
> Yes, in fact the error came only once and the change was commited 
> anyway, therefore it's more by curiosity than a real problem, but I 
> think it's always better to be sure ;-)
> 
> > It would help to identify your distribution, shadow-utils version,
> > SELinux status (sestatus), etc.
> 
> I am using CentOS (for the first time, choice of our provider).
> CentOS 5.4
> 
> # uname -a
> Linux (server) 2.6.18-164.el5 #1 SMP Thu Sep 3 03:28:30 EDT 2009 x86_64 
> x86_64 x86_64 GNU/Linux
> 
> Installed Packages
> Name       : shadow-utils
> Arch       : x86_64
> Epoch      : 2
> Version    : 4.0.17
> Release    : 14.el5
> 
> # sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          disabled
> Policy version:                 21
> Policy from config file:        targeted

That looks very odd - you have SELinux status:  enabled but Mode from
config file:  disabled?  Did you just modify /etc/selinux/config after
booting?

> Le 23.02.2010 18:16, Daniel J Walsh a écrit :
>  > Do you have SELinux enabled? Does the entire path exists?
>  > /etc/selinux/targeted/contexts/files
> 
> # find /etc/selinux/targeted/contexts/
> /etc/selinux/targeted/contexts/
> /etc/selinux/targeted/contexts/netfilter_contexts
> 
> Sorry I know it looks strange but I am customising the server as 
> installed by the provider and in the past I never used SELinux...
> 
> Thanks a lot for your help :-) (And hope it will help others some day 
> too...)

Looks like you don't have a policy installed?
rpm -q selinux-policy-targeted

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
