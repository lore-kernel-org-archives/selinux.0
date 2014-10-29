Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9TFZ5FF031047
 for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2014 11:35:07 -0400
Message-ID: <5451090B.2080107@tresys.com>
Date: Wed, 29 Oct 2014 11:34:35 -0400
From: Steve Lawrence <slawrence@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: SELinux List <selinux@tycho.nsa.gov>
Subject: SELinux Userspace Release: 20140826-rc5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The fifth release candidate for the next release of SELinux Userspace
[1] is now available. The tarballs have been built and can be downloaded
from the Releases wiki page [2]. Changes since rc4 include:

- fixes to libsemanage build system to allow specifying different LIBDIR
and SHLIBDIR directories
- fixes to libselinux and libsepol build system to not assume SHLIBDIR
is ../../ relative to LIBDIR (e.g. now allows LIBIDR == SHLIBDIR)

As with the previous rc, action after installing the release candidate
is required to migrate the policy store from /etc/selinux to
/var/lib/selinux if it has not already been migrated. Detailed
information about this process can be found on the Policy Store
Migration wiki page [3].

Please give this a test and let us know if you find any problems.

Thanks,
- Steve

[1] https://github.com/SELinuxProject/selinux
[2] https://github.com/SELinuxProject/selinux/wiki/Releases
[3] https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration
