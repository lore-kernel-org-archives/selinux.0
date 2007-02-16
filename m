Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: Eric Paris <eparis@parisplace.org>, SELinux@tycho.nsa.gov
In-Reply-To: <1171628178.7911.5.camel@desk.netwosix.org>
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
	 <1171576059.5239.13.camel@desk.netwosix.org>
	 <1171628178.7911.5.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Fri, 16 Feb 2007 10:13:03 -0500
Message-Id: <1171638783.32574.164.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-02-16 at 13:16 +0100, Vincenzo Ciaglia wrote:
> Il giorno gio, 15/02/2007 alle 22.47 +0100, Vincenzo Ciaglia ha
> scritto: 
> > # newrole -r sysadm_r
> > Authenticating root.
> > newrole: incorrect password for root
> > #
> 
> Regarding to this problem i thought was a PAM problem.

Yes, IIRC, typically this indicates that your pam_unix doesn't fall back
cleanly to the chkpwd helper when it cannot directly read /etc/shadow,
and just fails.  The original pam_unix logic was to only perform such a
fallback if the caller was not uid 0, but that had to be changed for
selinux since even a uid 0 process might not be allowed to directly
read /etc/shadow under selinux.

>  So i re-build the
> package with all the latest fedora's patch and i have created this,
> ready to "./configure --with-selinux":
> http://www.netwosix.org/selinux/Linux-PAM-selinux-0.99.6.2.tar.gz
> 
> Here the patch applied and pre-build in that package:
> http://www.netwosix.org/selinux/pam-0.99.2.1-selinux-nofail.patch
> http://www.netwosix.org/selinux/pam-0.99.6.2-selinux-drop-multiple.patch
> http://www.netwosix.org/selinux/pam-0.99.6.2-selinux-keycreate.patch
> http://www.netwosix.org/selinux/pam-0.99.6.2-selinux-select-context.patch
> http://www.netwosix.org/selinux/pam-0.99.6.2-selinux-use-current-range.patch
> 
> Moreover i adjusted some configurations in /etc/pam.d to try to do the
> trick. Here they are: http://www.netwosix.org/selinux/pam-seconf.tar.gz
> Here the /etc/security ones:
> http://www.netwosix.org/selinux/security-etc.tar.gz
> And here my /lib/security/ :
> http://www.netwosix.org/selinux/securitypam-selinux.tar.gz
> 
> Everything is ok but when i reboot i get this:
> 
> [vciaglia@desk ~]$  ssh -l root 192.168.0.4
> root@192.168.0.4's password: 
> # id -Z
> root:sysadm_r:sysadm_t
> # newrole -r sysadm_r        
> Authenticating root.
> newrole: incorrect password for root
> # useradd -m test
> useradd: PAM authentication failed
> # 
> 
> Is it still a PAM problem or i have some misconfigurations ?

Likely an issue with your pam, but I haven't looked at your packages
yet.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
