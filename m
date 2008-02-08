Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m189W7UQ016425
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 04:32:07 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m189W7Fm014839
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 09:32:07 GMT
Received: by py-out-1112.google.com with SMTP id a78so4384119pyh.32
        for <selinux@tycho.nsa.gov>; Fri, 08 Feb 2008 01:32:06 -0800 (PST)
Message-ID: <150846cc0802080132u1db27b24yf94ed52bbc56c33d@mail.gmail.com>
Date: Fri, 8 Feb 2008 04:32:06 -0500
From: "Caleb Case" <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Subject: SELinux Support for Ubuntu Hardy
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux Support for Ubuntu Hardy

*** WARNING: EXPERIMENTAL! TESTING/DEVELOPMENT ONLY! ***

Hey everybody!

We've been really busy getting SELinux support ready for Hardy and it is now
possible to boot into an SELinux enabled Hardy using the packages that are
available in the Ubuntu-Hardened PPA on launchpad.

Hardy is currently in alpha with releases available here:

https://wiki.ubuntu.com/HardyHeron

At the time of this email the server distro boots in enforcing (which isn't to
say that everything works perfectly), but the desktop distro does not.
We're hoping to have this working in the near future.

Any feedback you have would be greatly appreciated :o}

More information is available on the Hardy SELinux wiki:

https://wiki.ubuntu.com/HardySELinux

Installing SELinux in Hardy:

 1. Update /etc/apt/sources.list by appending the following:

    deb http://ppa.launchpad.net/ubuntu-hardened/ubuntu hardy main
    deb-src http://ppa.launchpad.net/ubuntu-hardened/ubuntu hardy main

 2. Update repo:
    > apt-get update

 3. Install updated packages:
    > apt-get upgrade

    * These packages have SELinux support patches:
      * libpam0g [1]
      * openssh-server [2]
      * grub [3]
      * login [4]

 4. Install selinux:
    > apt-get install selinux

    * These packages will be removed:
      * apparmor
      * apparmor-utils

 5. Reboot

SELinux Support for Hardy Package Sources:

https://code.launchpad.net/~calebcase/+junk/selinux-support

[1] PAM was using a deprecated method of handling login contexts
<https://bugs.launchpad.net/ubuntu/+source/pam/+bug/187822>. The updated package
fixes this problem by backporting changes in upstream.

[2] OpenSSH Server autoconf scripts were failing to detect the libselinux
functions getseuserbyname and get_default_context_with_level
<https://bugs.launchpad.net/ubuntu/+source/openssh/+bug/188136>. The updated
package fixes the configure bug by correctly setting LIBS before calling
AC_CHECK_FUNCS.

[3] Grub's update-grub lacks a trigger (and update-grub cannot be called
directly due to nested debconf issues)
<https://bugs.launchpad.net/ubuntu/+source/grub/+bug/189173>. In order to
seamlessly switch between AppArmor and SELinux we need to reconfigure the
menu.lst's defoptions.

[4] Login's PAM configuration had pam_selinux off by default. The updated
package turns on.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
