Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sACDoVP3020198
 for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2014 08:50:32 -0500
Message-ID: <5463658D.7050702@tresys.com>
Date: Wed, 12 Nov 2014 08:50:05 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: SELinux Userspace Release: 20140826-rc6
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The sixth release candidate for the next release of SELinux Userspace
[1] is now available. The tarballs have been built and can be downloaded
from the Releases wiki page [2]. Changes since rc5 include:

- updates to pp2cil compiler to mimic 'requires' in CIL, fixing a bug
that prevented a small set of optional blocks from being correctly
disabled [4]
- updates to pp2cil compiler to correctly scope type aliases, fixing a
bug that causes errors if a type alias referenced a type in a disabled
optional block [5]

As with the previous rc, action after installing the release candidate
is required to migrate the policy store from /etc/selinux to
/var/lib/selinux if it has not already been migrated. Detailed
information about this process can be found on the Policy Store
Migration wiki page [3].

Also, because the pp2cil compiler has been updated, any cached CIL
modules must be rebuilt. This can be done with the --ignore-module-cache
semodule option.

Please give this a test and let us know if you find any problems.

Thanks,
- Steve

[1] https://github.com/SELinuxProject/selinux
[2] https://github.com/SELinuxProject/selinux/wiki/Releases
[3] https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration
[4] http://marc.info/?l=selinux&m=141537621807753&w=2
[5] http://marc.info/?l=selinux&m=141537664108369&w=2
