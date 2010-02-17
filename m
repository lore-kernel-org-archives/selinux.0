Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "Justin P. mattock" <justinmattock@gmail.com>,
        Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Wed, 17 Feb 2010 13:58:01 -0500
Message-Id: <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-17 at 13:34 -0500, Alan Rouse wrote:
> Here's some info about the system now (booting successfully to desktop with selinux enabled)
> 
> /etc/selinux/config:
> SELINUX=permissive
> SELINUXTYPE=refpolicy-standard
> 
> /etc/dbus-1/system.conf contains:
> <include if_selinux_enabled="yes" selinux_root_relative="yes">contexts/dbus_contexts</include>
> 
> var/log/messages does not have any AVC messages in it.
> 
> sestatus -v:
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 24
> Policy from config file:        refpolicy-standard
> 
> Process contexts:
> Current context:                system_u:system_r:kernel_t
> Init context:                   system_u:system_r:kernel_t
> /sbin/mingetty                  system_u:system_r:kernel_t
> 
> File contexts:
> Controlling term:               system_u:object_r:devpts_t
> /etc/passwd                     system_u:object_r:file_t
> /etc/shadow                     system_u:object_r:file_t
> /bin/bash                       system_u:object_r:file_t
> /bin/login                      system_u:object_r:file_t
> /bin/sh                         system_u:object_r:file_t -> system_u:object_r:file_t
> /sbin/agetty                    system_u:object_r:file_t
> /sbin/init                      system_u:object_r:file_t
> /sbin/mingetty                  system_u:object_r:file_t
> /usr/sbin/sshd                  system_u:object_r:file_t
> /lib/libc.so.6                  system_u:object_r:file_t -> system_u:object_r:file_t
> /lib/ld-linux.so.2              system_u:object_r:file_t -> system_u:object_r:file_t

Ok, so all of your processes are still running in kernel_t, and all of
your files are labeled file_t.  You need to label your filesystems and
reboot.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
