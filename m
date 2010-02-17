From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Justin P. mattock" <justinmattock@gmail.com>,
        Dominick Grift
	<domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Wed, 17 Feb 2010 13:34:03 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's some info about the system now (booting successfully to desktop with selinux enabled)

/etc/selinux/config:
SELINUX=permissive
SELINUXTYPE=refpolicy-standard

/etc/dbus-1/system.conf contains:
<include if_selinux_enabled="yes" selinux_root_relative="yes">contexts/dbus_contexts</include>

var/log/messages does not have any AVC messages in it.

sestatus -v:
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 24
Policy from config file:        refpolicy-standard

Process contexts:
Current context:                system_u:system_r:kernel_t
Init context:                   system_u:system_r:kernel_t
/sbin/mingetty                  system_u:system_r:kernel_t

File contexts:
Controlling term:               system_u:object_r:devpts_t
/etc/passwd                     system_u:object_r:file_t
/etc/shadow                     system_u:object_r:file_t
/bin/bash                       system_u:object_r:file_t
/bin/login                      system_u:object_r:file_t
/bin/sh                         system_u:object_r:file_t -> system_u:object_r:file_t
/sbin/agetty                    system_u:object_r:file_t
/sbin/init                      system_u:object_r:file_t
/sbin/mingetty                  system_u:object_r:file_t
/usr/sbin/sshd                  system_u:object_r:file_t
/lib/libc.so.6                  system_u:object_r:file_t -> system_u:object_r:file_t
/lib/ld-linux.so.2              system_u:object_r:file_t -> system_u:object_r:file_t

pstree -Z:
init(`system_u:system_r:kernel_t')
 |-acpid(`system_u:system_r:kernel_t')
 |-auditd(`system_u:system_r:kernel_t')
 |  |-audispd(`system_u:system_r:kernel_t')
 |  |  `-{audispd}(`system_u:system_r:kernel_t')
 |  `-{auditd}(`system_u:system_r:kernel_t')
 |-avahi-daemon(`system_u:system_r:kernel_t')
 |-bash(`system_u:system_r:kernel_t')
 |  `-tomboy(`system_u:system_r:kernel_t')
 |     |-{tomboy}(`system_u:system_r:kernel_t')
 |     `-{tomboy}(`system_u:system_r:kernel_t')
 |-bonobo-activati(`system_u:system_r:kernel_t')
 |  `-{bonobo-activati}(`system_u:system_r:kernel_t')
 |-console-kit-dae(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  |-{console-kit-dae}(`system_u:system_r:kernel_t')
 |  `-{console-kit-dae}(`system_u:system_r:kernel_t')
 |-cron(`system_u:system_r:kernel_t')
 |-cupsd(`system_u:system_r:kernel_t')
 |-dbus-daemon(`system_u:system_r:kernel_t')
 |  `-{dbus-daemon}(`system_u:system_r:kernel_t')
 |-dbus-daemon(`system_u:system_r:kernel_t')
 |  `-{dbus-daemon}(`system_u:system_r:kernel_t')
 |-dbus-daemon(`system_u:system_r:kernel_t')
 |  `-{dbus-daemon}(`system_u:system_r:kernel_t')
 |-dbus-launch(`system_u:system_r:kernel_t')
 |-dbus-launch(`system_u:system_r:kernel_t')
 |-dbus-launch(`system_u:system_r:kernel_t')
 |-devkit-disks-da(`system_u:system_r:kernel_t')
 |  `-devkit-disks-da(`system_u:system_r:kernel_t')
 |-devkit-power-da(`system_u:system_r:kernel_t')
 |-dhcpcd(`system_u:system_r:kernel_t')
 |-gconfd-2(`system_u:system_r:kernel_t')
 |-gconfd-2(`system_u:system_r:kernel_t')
 |-gdm(`system_u:system_r:kernel_t')
 |  `-gdm-simple-slav(`system_u:system_r:kernel_t')
 |     |-Xorg(`system_u:system_r:kernel_t')
 |     `-gdm-session-wor(`system_u:system_r:kernel_t')
 |        `-gnome-session(`system_u:system_r:kernel_t')
 |           |-bluetooth-apple(`system_u:system_r:kernel_t')
 |           |-gnome-do(`system_u:system_r:kernel_t')
 |           |  `-gnome-do(`system_u:system_r:kernel_t')
 |           |     |-{gnome-do}(`system_u:system_r:kernel_t')
 |           |     |-{gnome-do}(`system_u:system_r:kernel_t')
 |           |     `-{gnome-do}(`system_u:system_r:kernel_t')
 |           |-gnome-panel(`system_u:system_r:kernel_t')
 |           |-gnome-power-man(`system_u:system_r:kernel_t')
 |           |-gnome-volume-co(`system_u:system_r:kernel_t')
 |           |-gpk-update-icon(`system_u:system_r:kernel_t')
 |           |-metacity(`system_u:system_r:kernel_t')
 |           |-nautilus(`system_u:system_r:kernel_t')
 |           |-nm-applet(`system_u:system_r:kernel_t')
 |           |-polkit-gnome-au(`system_u:system_r:kernel_t')
 |           |-python(`system_u:system_r:kernel_t')
 |           |-ssh-agent(`system_u:system_r:kernel_t')
 |           `-{gnome-session}(`system_u:system_r:kernel_t')
 |-gnome-keyring-d(`system_u:system_r:kernel_t')
 |  |-{gnome-keyring-d}(`system_u:system_r:kernel_t')
 |  `-{gnome-keyring-d}(`system_u:system_r:kernel_t')
 |-gnome-screensav(`system_u:system_r:kernel_t')
 |-gnome-settings-(`system_u:system_r:kernel_t')
 |  `-{gnome-settings-}(`system_u:system_r:kernel_t')
 |-gnome-terminal(`system_u:system_r:kernel_t')
 |  |-bash(`system_u:system_r:kernel_t')
 |  |  `-su(`system_u:system_r:kernel_t')
 |  |     `-bash(`system_u:system_r:kernel_t')
 |  |        `-pstree(`system_u:system_r:kernel_t')
 |  |-gnome-pty-helpe(`system_u:system_r:kernel_t')
 |  `-{gnome-terminal}(`system_u:system_r:kernel_t')
 |-gvfs-fuse-daemo(`system_u:system_r:kernel_t')
 |  |-{gvfs-fuse-daemo}(`system_u:system_r:kernel_t')
 |  |-{gvfs-fuse-daemo}(`system_u:system_r:kernel_t')
 |  `-{gvfs-fuse-daemo}(`system_u:system_r:kernel_t')
 |-gvfs-gdu-volume(`system_u:system_r:kernel_t')
 |-gvfs-gphoto2-vo(`system_u:system_r:kernel_t')
 |-gvfsd(`system_u:system_r:kernel_t')
 |-gvfsd-burn(`system_u:system_r:kernel_t')
 |-gvfsd-trash(`system_u:system_r:kernel_t')
 |-hald(`system_u:system_r:kernel_t')
 |  `-hald-runner(`system_u:system_r:kernel_t')
 |     |-hald-addon-acpi(`system_u:system_r:kernel_t')
 |     |-hald-addon-inpu(`system_u:system_r:kernel_t')
 |     |-hald-addon-stor(`system_u:system_r:kernel_t')
 |     `-hald-addon-stor(`system_u:system_r:kernel_t')
 |-main-menu(`system_u:system_r:kernel_t')
 |-master(`system_u:system_r:kernel_t')
 |  |-pickup(`system_u:system_r:kernel_t')
 |  `-qmgr(`system_u:system_r:kernel_t')
 |-mingetty(`system_u:system_r:kernel_t')
 |-mingetty(`system_u:system_r:kernel_t')
 |-mingetty(`system_u:system_r:kernel_t')
 |-mingetty(`system_u:system_r:kernel_t')
 |-mingetty(`system_u:system_r:kernel_t')
 |-mingetty(`system_u:system_r:kernel_t')
 |-nm-system-setti(`system_u:system_r:kernel_t')
 |-notification-da(`system_u:system_r:kernel_t')
 |-nscd(`system_u:system_r:kernel_t')
 |-polkitd(`system_u:system_r:kernel_t')
 |-pulseaudio(`system_u:system_r:kernel_t')
 |  |-gconf-helper(`system_u:system_r:kernel_t')
 |  `-{pulseaudio}(`system_u:system_r:kernel_t')
 |-pulseaudio(`system_u:system_r:kernel_t')
 |  |-gconf-helper(`system_u:system_r:kernel_t')
 |  `-{pulseaudio}(`system_u:system_r:kernel_t')
 |-rpcbind(`system_u:system_r:kernel_t')
 |-rsyslogd(`system_u:system_r:kernel_t')
 |  |-{rsyslogd}(`system_u:system_r:kernel_t')
 |  |-{rsyslogd}(`system_u:system_r:kernel_t')
 |  |-{rsyslogd}(`system_u:system_r:kernel_t')
 |  `-{rsyslogd}(`system_u:system_r:kernel_t')
 |-rtkit-daemon(`system_u:system_r:kernel_t')
 |  |-{rtkit-daemon}(`system_u:system_r:kernel_t')
 |  `-{rtkit-daemon}(`system_u:system_r:kernel_t')
 |-seahorse-agent(`system_u:system_r:kernel_t')
 |-seahorse-daemon(`system_u:system_r:kernel_t')
 |-startpar(`system_u:system_r:kernel_t')
 |-startpar(`system_u:system_r:kernel_t')
 |-udevd(`system_u:system_r:kernel_t')
 |  |-udevd(`system_u:system_r:kernel_t')
 |  `-udevd(`system_u:system_r:kernel_t')
 |-vmtoolsd(`system_u:system_r:kernel_t')
 `-vmware-user(`system_u:system_r:kernel_t')

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Wednesday, February 17, 2010 11:58 AM
To: Alan Rouse
Cc: Justin P. mattock; Dominick Grift; 'selinux@tycho.nsa.gov'
Subject: RE: SELinux Policy in OpenSUSE 11.2

On Wed, 2010-02-17 at 11:34 -0500, Alan Rouse wrote:
> Renaming didn't work for me in the image we've been discussing...  However, after building another clean OpenSuse 11.2 image, installing the previously mentioned list of packages, and editing the grub menu.lst for selinux, I created a symlink named "targeted" to the refpolicy-standard directory, and it now boots into the desktop nicely (using the version of policy in the OpenSuse 11.2 repository.)  Sestatus shows selinux active and in permissive mode.  There are no AVC messages in /var/log/audit/audit.log.   Audit2allow -al gives 
> 
> allow kernel_t file_t:file execmod;
> allow kernel_t self:process { execstack execmem };
> 
> I don't understand why those are suggested since there are no AVC messages... But this looks far better than before!
> 
> Thanks Justin.  Now we just need to find out where it's hard coded to "targeted" and get that fixed...

libselinux will default to "targeted" if there is no SELINUXTYPE= definition in /etc/selinux/config.

Or your /etc/dbus-1/system.conf might have a hardcoded path to it rather than using selinux_root_relative="yes".  Or the version of dbus shipped in OpenSUSE 11.2 might not support that (I don't know).

Check /var/log/messages as well for avc messages; if you aren't running auditd or before auditd starts, the avc messages will go to /var/log/messages or wherever syslog is configured to report kern.warn.

What does sestatus -v and pstree -Z show now?

--
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
