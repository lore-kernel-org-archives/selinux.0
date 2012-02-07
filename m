Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "C.J. Adams-Collier" <cjac@colliertech.org>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <20120207200224.GB18478@colliertech.org>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
	 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636826.2162.60.camel@moss-pluto>
	 <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
	 <20120207200224.GB18478@colliertech.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 15:08:25 -0500
Message-ID: <1328645305.2162.105.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-02-07 at 12:02 -0800, C.J. Adams-Collier wrote:
> ~/selinux/semodule_-l_20120207T110759.log:
> apache	2.3.0	
> dbus	1.15.0	
> devicekit	1.1.0	
> dmidecode	1.4.0	
> exim	1.5.0	
> ftp	1.13.0	
> git	1.0	
> gpg	2.4.0	
> lda	1.9.0	
> lvm	1.13.0	
> netutils	1.11.0	
> openvpn	1.10.0	
> ptchown	1.1.0	
> pythonsupport	0.0.1	
> remotelogin	1.7.0	
> rpc	1.13.0	
> rpcbind	1.5.0	
> rsync	1.11.0	
> ssh	2.2.0	
> sudo	1.8.0	
> tcpd	1.4.0	
> telnet	1.10.0	
> tzdata	1.4.0	
> unconfined	3.3.0

So no xserver module, unless it happens to be part of your base module.
seinfo -txserver_t


> ~/selinux/sestatus_-v_20120207T110759.log:
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 26
> Policy from config file:        default
> 
> Process contexts:
> Current context:                unconfined_u:system_r:insmod_t:SystemLow-SystemHigh
> Init context:                   system_u:system_r:kernel_t:SystemLow
> /usr/sbin/sshd                  system_u:system_r:kernel_t:SystemLow
> 
> File contexts:
> Controlling term:               unconfined_u:object_r:tty_device_t:SystemLow
> /etc/passwd                     unconfined_u:object_r:user_home_t:SystemLow
> /etc/shadow                     unconfined_u:object_r:user_home_t:SystemLow
> /bin/bash                       unconfined_u:object_r:user_home_t:SystemLow
> /bin/login                      unconfined_u:object_r:user_home_t:SystemLow
> /bin/sh                         unconfined_u:object_r:user_home_t:SystemLow -> unconfined_u:object_r:user_home_t:SystemLow
> /sbin/agetty                    unconfined_u:object_r:user_home_t:SystemLow
> /sbin/init                      unconfined_u:object_r:user_home_t:SystemLow
> /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:SystemLow
> /lib/ld-linux.so.2              unconfined_u:object_r:user_home_t:SystemLow -> unconfined_u:object_r:user_home_t:SystemLow

So everything except for /usr/sbin/sshd has the wrong file context, and
all of your processes are still running in the kernel's domain.

I think you need a new policy, and then you need to relabel your
filesystems.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
