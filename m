Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8N6G97h002178
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 02:16:09 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8N6G9uA014802
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 06:16:09 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m8N6G4df008906
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 02:16:04 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8N6G3pp024863
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 02:16:04 -0400
Received: from mmcallis.csb (dhcp-0-230.bne.redhat.com [10.64.0.230])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id m8N6G1xD013778
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 02:16:02 -0400
Message-ID: <48D889A0.1010604@redhat.com>
Date: Tue, 23 Sep 2008 16:16:00 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user guide drafts: "Working with SELinux" sections
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Apologies if I sent this twice.

The following is a draft of the "Installing and Upgrading SELinux 
Packages", "Main Configuration File", and "Enabling and Disabling 
SELinux" sections. Any comments and corrections are appreciated.

Thanks.

Working with SELinux

The following sections [fill in when finished]

Installing and Upgrading SELinux Packages

In Fedora 10, the SELinux packages are installed by default unless they 
are manually excluded during installation. The following is a brief 
description of the main packages:

* policycoreutils: provides utilities, such as semanage, restorecon, and 
load_policy, for operating and managing SELinux.

* selinux-policy: provides the SELinux Reference Policy. The SELinux 
Reference Policy is a complete SELinux policy, and is used as a basis 
for other policies, such as the SELinux targeted policy. Refer to the 
Tresys Technology SELinux Reference Policy[1] page for further 
information. The selinux-policy-devel package provides development 
tools, such as /usr/share/selinux/devel/policygentool and 
/usr/share/selinux/devel/policyhelp, as well as example policy files. 
This package has been merged into the the selinux-policy package.

* selinux-policy-[policy]: provides SELinux policies. For targeted 
policy, install selinux-policy-targeted. For MLS, install 
selinux-policy-mls. The strict policy was merged in Fedora 9, allowing 
confined and unconfined users to co-exist on the same system.

* setroubleshoot-server: translates denial messages, produced when 
access is denied by SELinux, into detailed descriptions that are viewed 
with sealert (which is provided by this package).

* setroubleshoot: a graphical user interface for viewing denials that 
are translated by setroubleshoot-server.

* mcstrans: translates levels, such as s0-s0:c0.c1023, to an easier to 
read form, such as SystemLow-SystemHigh. This package is not installed 
by default.

To install packages in Fedora 10, as the Linux root user, run the yum 
install package-name command. For example, to install the mcstrans 
package, run the yum install mcstrans command.

To upgrade all installed packages in Fedora 10, as the Linux root user, 
run the yum update command. To update individual packages, run the yum 
update package-name command. For example, to only upgrade the mcstrans 
package, run the yum update mcstrans command.

Refer to Managing Software with yum[2] for information about using yum 
to manage packages.

Main Configuration File

The /etc/selinux/config file is the main SELinux configuration file. It 
controls the SELinux mode and the SELinux policy to use:

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
SELINUXTYPE=targeted

SELINUX=enforcing: The SELINUX option sets the mode SELinux runs in. 
SELinux has three modes: enforcing, permissive, and disabled. When using 
enforcing mode, SELinux denies access based on SELinux policy rules, and 
denial messages are logged. When using permissive mode, SELinux policy 
is not enforced, but denials are logged for actions that would have been 
denied if running in enforcing mode. When using disabled mode, SELinux 
is disabled (the SELinux module is not registered with the Linux 
kernel), and only DAC rules are used. For example, to configure SELinux 
to use permissive mode, configure SELINUX=permissive in 
/etc/selinux/config, and reboot your system.

SELINUXTYPE=targeted: The SELINUXTYPE option sets the SELinux policy to 
use. Targeted policy is the default policy used. Only change this option 
if you want to use the MLS policy. To use the MLS policy, install the 
selinux-policy-mls package; configure SELINUXTYPE=mls in 
/etc/selinux/config; and reboot your system.

# are there any other configuration files that should be mentioned?

Enabling and Disabling SELinux

Use the getenforce or sestatus commands to check the status of SELinux. 
The getenforce command returns Enforcing, Permissive, or Disabled. The 
getenforce command returns Enforcing when SELinux is enabled (SELinux 
policy rules are enforced):

$ getenforce
Enforcing

The getenforce command returns Permissive when SELinux is enabled, but 
SELinux policy rules are not enforced, and only DAC rules are used. The 
getenforce command returns Disabled if SELinux is disabled.

The sestatus command returns the SELinux status and the SELinux policy 
being used:

$ sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
Mode from config file:          enforcing
Policy version:                 23
Policy from config file:        targeted

SELinux status: enabled is returned when SELinux is enabled. Current 
mode: enforcing is returned when SELinux is running in enforcing mode. 
Policy from config file: targeted is returned when the SELinux targeted 
policy is used.

Enabling SELinux

On systems with SELinux disabled, the SELINUX=disabled option is 
configured in /etc/selinux/config:

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
SELINUXTYPE=targeted

Also, the getenforce command returns Disabled:

$ getenforce
Disabled

To enable SELinux:

1. Use the rpm -qa | grep selinux, rpm -q policycoreutils, and rpm -qa | 
grep setroubleshoot commands to confirm that the SELinux packages are 
installed. The following packages must be installed: 
selinux-policy-targeted, selinux-policy, libselinux, libselinux-python, 
libselinux-utils, policycoreutils, setroubleshoot-server, 
setroubleshoot-plugins. If these packages are not installed, as the 
Linux root user, install them via the yum install package-name command. 
The following packages are optional: policycoreutils-gui, 
setroubleshoot, selinux-policy-devel, and mcstrans.

# is there a better way to see if these packages are installed?

2. Before SELinux is enabled, each file on the file system must be 
labeled with an SELinux context. Before this happens, confined domains 
may be denied access, preventing your system from booting correctly. To 
prevent this, configure SELINUX=permissive in /etc/selinux/config:

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=permissive
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
SELINUXTYPE=targeted

3. As the Linux root user, run the reboot command to restart the system. 
During the next boot, the file system is labeled. During this process, 
all files are labeled with an SELinux context:

*** Warning -- SELinux targeted policy relabel is required.
*** Relabeling could take a very long time, depending on file
*** system size and speed of hard drives.
****

Each * character on the bottom line represents 1000 files that have been 
labeled. In the above example, four * characters represent 4000 files 
have been labeled. The time it takes to label all files depends upon the 
number of files on the system, and the speed of the hard disk drives. On 
modern systems, this process can take as little as 10 minutes.

4. In permissive mode, SELinux policy is not enforced, but denials are 
still logged for actions that would have been denied if running in 
enforcing mode. Before changing to enforcing mode, as the Linux root 
user, run the grep "SELinux is preventing" /var/log/messages command to 
confirm that SELinux did not deny actions during the last boot. If 
SELinux did not deny actions during the last boot, this command does not 
return any output.

# should users run something like "> /var/log/messages" before rebooting?

# are there common denials that should be listed here for boot problems?

5. If there were no denial messages in /var/log/messages, configure 
SELINUX=enforcing in /etc/selinux/config:

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
SELINUXTYPE=targeted

6. Reboot your system. After reboot, confirm that the getenforce command 
returns Enforcing:

$ getenforce
Enforcing

7. As the Linux root user, run the semanage login -l command to confirm 
that the mapping between SELinux and Linux users is correct. The output 
should be as follows:

Login Name                SELinux User              MLS/MCS Range

__default__               unconfined_u              s0-s0:c0.c1023
root                      unconfined_u              s0-s0:c0.c1023
system_u                  system_u                  s0-s0:c0.c1023

If this is not the case, run the following commands as the Linux root 
user to fix the user mappings:

# semanage user -a -S targeted -P user -R "unconfined_r system_r" -r 
s0-s0:c0.c1023 unconfined_u
# semanage login -m -S targeted  -s "unconfined_u" -r s0-s0:c0.c1023 
__default__
# semanage login -m -S targeted  -s "unconfined_u" -r s0-s0:c0.c1023 root
# semanage user -a -S targeted  -P user -R guest_r guest_u
# semanage user -a -S targeted  -P user -R xguest_r xguest_u

It is safe to ignore the SELinux-user SELinux user is already defined 
warnings if they occur, where SELinux-user can be unconfined_u, guest_u, 
or xguest_u.

Disabling SELinux

To disable SELinux, configure SELINUX=disabled in /etc/selinux/config:

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
SELINUXTYPE=targeted

Reboot your system. After reboot, confirm that the getenforce command 
returns Disabled:

$ getenforce
Disabled

[1] http://oss.tresys.com/projects/refpolicy
[2] http://docs.fedoraproject.org/yum/en/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
