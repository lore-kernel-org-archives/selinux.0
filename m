Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9K7ICqi032468
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 03:18:12 -0400
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9K7GnYY021277
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 07:16:50 GMT
Message-ID: <48FC30AD.5040802@redhat.com>
Date: Mon, 20 Oct 2008 17:18:05 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, Eric Paris <eparis@parisplace.org>
Subject: user guide drafts: "Managing Users"
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The following are drafts for the "Managing Users" sections. Any comments 
and corrections are appreciated.

Thanks.

Managing Users

A number of confined SELinux users are available in Fedora 10. Each 
Linux user is mapped to an SELinux user via SELinux policy, allowing 
Linux users to inherit the restrictions on SELinux users, such as 
(depending on the user) not being able to: run the X Window System, use 
networking, run setuid applications unless SELinux policy permits it, or 
run the su and sudo commands to become the Linux root user. Refer to 
Section 4.3, “Confined and Unconfined Users” for further information 
about confined users in Fedora 10.

Linux and SELinux User Mappings

As the Linux root user, run the /usr/sbin/semanage login -l command to 
view the mapping between Linux users and SELinux users:

[example output]

In Fedora 10, Linux users are mapped to the SELinux __default__ login by 
default (which is mapped to the SELinux unconfined_u user). When a Linux 
user is created using the /usr/sbin/useradd command, if no options are 
specified, they are mapped to the SELinux unconfined_u user. The 
following defines the default-mapping:

__default__               unconfined_u              s0-s0:c0.c1023


Mapping new Linux Users to SELinux Users: useradd

Linux users mapped to the SELinux unconfined_u user run in the 
unconfined_t domain. This is seen by running the id -Z command while 
logged-in as a Linux users mapped to unconfined_u:

$ id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

When Linux users run in the unconfined_t domain, SELinux policy rules 
are applied, but policy rules exist that allow Linux users running in 
the unconfined_t domain almost all access. If unconfined Linux users 
execute an application that SELinux policy defines can transition from 
the unconfined_t domain to its own confined domain, unconfined Linux 
users are still subject to the restrictions of that confined domain. The 
security benefit of this is that, even though a Linux user is running 
unconfined, they can not override the SELinux policy for a confined 
application, just because they (the user) are unconfined.

When creating Linux users with /usr/sbin/useradd, use the -Z 
SELinux-user option to specify which SELinux user they are mapped to.

# A later section will show how to change the default mapping from 
unconfined_u.

The following example creates a new Linux user, xguestuser, and maps 
that user to the SELinux xguest_u user. Linux users mapped to the 
SELinux xguest_u user run in the xguest_t domain. In this domain, Linux 
users are unable to run setuid applications unless SELinux policy 
permits it (such as passwd), can not run su or sudo, preventing them 
from becoming the Linux root user with these commands, and, the only 
network access allowed is the Firefox application connecting to web pages.

1. As the Linux root, run the /usr/sbin/useradd -Z xguest_u xguestuser 
command to create a new Linux user named xguestuser, that is mapped to 
the SELinux xguest_u user.

2. As the Linux root user, run the /usr/sbin/semanage login -l command 
to view the mapping between the Linux xguestuser user and xguest_u:

[example output]

3. As the Linux root user, run the passwd xguestuser command to assign a 
password to the Linux xguestuser user:

[example passwd command and output]

4. Log out of your current session, and log in as the Linux xguestuser 
user. When you log in, pam_selinux maps the Linux user to an SELinux 
user (in this case, xguest_u), and sets up the resulting SELinux 
context. The Linux user's shell is then launched with this SELinux 
context. To view the SELinux context for a Linux user, run the id -Z 
command:

[xguestuser@localhost ~]$ id -Z
xguest_u:xguest_r:xguest_t:s0

5. Log out of the Linux xguestuser's session, and log back in with your 
account. If you do not want the Linux xguestuser user, as the Linux root 
user, run the /usr/sbin/userdel -r xguestuser command to remove it, 
along with its home directory.

The next section, "Mapping Existing Linux Users to SELinux Users: 
semanage login", is incomplete. It demonstrates using "semanage login -a 
-s" on an Linux user mapped to unconfined_u.

I was also going to include how to change the default mapping to 
unconfined_u.

Cheers.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
