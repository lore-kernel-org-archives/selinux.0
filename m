From: Alan Rouse <alan.rouse@ericsson.com>
To: "Justin P. mattock" <justinmattock@gmail.com>,
        Dominick Grift
	<domg472@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        "'selinux@tycho.nsa.gov'"
	<selinux@tycho.nsa.gov>
Date: Wed, 17 Feb 2010 11:34:03 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
In-Reply-To: <4B7B97D4.7020005@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Renaming didn't work for me in the image we've been discussing...  However, after building another clean OpenSuse 11.2 image, installing the previously mentioned list of packages, and editing the grub menu.lst for selinux, I created a symlink named "targeted" to the refpolicy-standard directory, and it now boots into the desktop nicely (using the version of policy in the OpenSuse 11.2 repository.)  Sestatus shows selinux active and in permissive mode.  There are no AVC messages in /var/log/audit/audit.log.   Audit2allow -al gives 

allow kernel_t file_t:file execmod;
allow kernel_t self:process { execstack execmem };

I don't understand why those are suggested since there are no AVC messages... But this looks far better than before!

Thanks Justin.  Now we just need to find out where it's hard coded to "targeted" and get that fixed...

-----Original Message-----
From: Justin P. mattock [mailto:justinmattock@gmail.com] 
Sent: Wednesday, February 17, 2010 2:17 AM
To: Dominick Grift
Cc: Alan Rouse; Stephen Smalley; 'selinux@tycho.nsa.gov'
Subject: Re: SELinux Policy in OpenSUSE 11.2

o.k. I think I thought too much on the subject (I need to stop building systems from scratch i.g. all I can think of is/are switches to enable).

Anyways I figured out the problem seems easier than I had expected:

with a fresh build of suse 11.2, then
under yast adding the correct SELinux
apps/libs, then adjusting grub(in the control center thing).

reboot

you hit a broken gdm dbus thing.

under /var/log/gdm/:5-greeter.log

there is an error message with dbus:

Failed to start message bus: Failed to open
"/etc/selinux/targeted/contexts/dbus_contexts": No such file or directory EOF in dbus-launch reading address from dbus daemon.

so after reading that then looking at /etc/selinux/refpolicy-standard I decided to just cp -R refpolicy-standard targeted(reboot) and voila the system boots gdm starts, life is good with suse (I guess there not the darkside after all!!).

as for the real problem I'm guessing whatever is telling dbus-launch to look for /etc/selinux/targeted is the problem.

Alan does just a simple renaming of refpolicy to targeted at least get you up and running(if not use suses policy, and rename it to targeted, until I can find what dbus launch script is calling for that policy name).

Justin P. Mattock



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
