Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "Justin P. mattock" <justinmattock@gmail.com>,
        Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Wed, 17 Feb 2010 11:58:15 -0500
Message-Id: <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-17 at 11:34 -0500, Alan Rouse wrote:
> Renaming didn't work for me in the image we've been discussing...  However, after building another clean OpenSuse 11.2 image, installing the previously mentioned list of packages, and editing the grub menu.lst for selinux, I created a symlink named "targeted" to the refpolicy-standard directory, and it now boots into the desktop nicely (using the version of policy in the OpenSuse 11.2 repository.)  Sestatus shows selinux active and in permissive mode.  There are no AVC messages in /var/log/audit/audit.log.   Audit2allow -al gives 
> 
> allow kernel_t file_t:file execmod;
> allow kernel_t self:process { execstack execmem };
> 
> I don't understand why those are suggested since there are no AVC messages... But this looks far better than before!
> 
> Thanks Justin.  Now we just need to find out where it's hard coded to "targeted" and get that fixed...

libselinux will default to "targeted" if there is no SELINUXTYPE=
definition in /etc/selinux/config.

Or your /etc/dbus-1/system.conf might have a hardcoded path to it rather
than using selinux_root_relative="yes".  Or the version of dbus shipped
in OpenSUSE 11.2 might not support that (I don't know).

Check /var/log/messages as well for avc messages; if you aren't running
auditd or before auditd starts, the avc messages will go
to /var/log/messages or wherever syslog is configured to report
kern.warn.

What does sestatus -v and pstree -Z show now?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
