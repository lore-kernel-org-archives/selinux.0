Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB4JGAAJ013801
 for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2014 14:16:11 -0500
Message-ID: <5480B2DB.6010408@tresys.com>
Date: Thu, 4 Dec 2014 14:15:39 -0500
From: Steve Lawrence <slawrence@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: SELinux List <selinux@tycho.nsa.gov>
Subject: ANN: SELinux Userspace Release: 20140826-rc7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The seventh release candidate for the next release of SELinux Userspace
[1] is now available. The tarballs have been built and can be downloaded
from the Releases wiki page [2]. Changes since rc6 [3] include:

- correct roletype statements in pp2cil compiler, so that all
roles/types are properly associated
- add python3 support to the semanage store migration script
- report all neverallow violations
- fix expand logic to prevent segmentation fault for policy versions
older than 24
- close hll file descriptors to prevent leaking, which caused avc denials
- update mcstrans systemd unit file to create /var/run/setrans directory
- set correct selinux labels in the semanage store migration script
- multiple fixes to CIL, including refactoring, proper association of
object_r with users, blockabstract resolution errors, and potential
memory leaks

As with the previous rc, action after installing the release candidate
is required to migrate the policy store from /etc/selinux to
/var/lib/selinux if it has not already been migrated. Detailed
information about this process can be found on the Policy Store
Migration wiki page [4].

Because the pp2cil compiler has been updated, any cached CIL
modules should be rebuilt. This can be done with the
--ignore-module-cache semodule option.

Additionally, the latest reference policy release [5] includes updated
policy to properly label the new policy store in /var/lib/selinux.

Please give this a test and let us know if you find any problems.

Thanks,
- Steve

[1] https://github.com/SELinuxProject/selinux
[2] https://github.com/SELinuxProject/selinux/wiki/Releases
[3] http://marc.info/?l=selinux&m=141580047500746&w=2
[4] https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration
[5] http://oss.tresys.com/pipermail/refpolicy/2014-December/007527.html
