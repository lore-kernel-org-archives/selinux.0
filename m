From: Alan Rouse <alan.rouse@ericsson.com>
To: "Justin P. mattock" <justinmattock@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Thu, 18 Feb 2010 16:53:55 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A780AEE@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>
 <4B7DB3B4.2070409@gmail.com>
In-Reply-To: <4B7DB3B4.2070409@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Justin, could you share what you did to reach that state?  Your last email yesterday left me with the impression that you were rebuilding some tools from source...  What tools, what versions?  What booleans did you disable?

-----Original Message-----
From: Justin P. mattock [mailto:justinmattock@gmail.com] 
Sent: Thursday, February 18, 2010 4:40 PM
To: Alan Rouse
Cc: Stephen Smalley; Dominick Grift; 'selinux@tycho.nsa.gov'
Subject: Re: SELinux Policy in OpenSUSE 11.2

alright... policy is up and running
in full enforcement mode:

SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
Mode from config file:          error (Permission denied)
Policy version:                 24
Policy from config file:        targeted

Process contexts:
Current context:                name:user_r:user_t
Init context:                   unknown (Permission denied)

File contexts:
Controlling term:               name:object_r:user_devpts_t
/etc/passwd                     system_u:object_r:etc_t
/bin/bash                       system_u:object_r:shell_exec_t
/bin/login                      system_u:object_r:login_exec_t
/bin/sh                         system_u:object_r:bin_t ->
system_u:object_r:shell_exec_t
/sbin/agetty                    system_u:object_r:getty_exec_t
/sbin/mingetty                  system_u:object_r:getty_exec_t
/lib/libc.so.6                  system_u:object_r:lib_t ->
system_u:object_r:lib_t
/lib/ld-linux.so.2              system_u:object_r:lib_t ->
system_u:object_r:ld_so_t



I tried to enable poly-instantiation support(pam_namespace), but need to look more into that because I never really set it up with gdm.

Anyways I'm able to boot up, able to
use firefox and evolution. as for anything else I'm sure just need to define the allow rules.


Now the only real area of interest is
the dbus message pointing to targeted.

I'm guessing dbus was built with a hard wire, if so this would require rebuilding dbus, or using anther rpm package built correctly.
(if possible without breaking the system dependencies).

but then again it could be just a boolean.
In any case main thing is full enforcement works gdm works, nice system I'd have to say.



Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
