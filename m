Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s97DJ1x9020747
 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2014 09:19:01 -0400
Message-ID: <5433E840.8060605@tresys.com>
Date: Tue, 7 Oct 2014 09:18:56 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: SELinux Userspace Release: 20140826-rc4
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The fourth release candidate for the next release of SELinux Userspace
[1] is now available. The tarballs have been built and can be downloaded
from the Releases wiki page [2]. Changes since rc2 include:

- fixes to pp2cil to fix bugs with roles, filecon, and some conditionals
- updates to CIL to properly handle disabling of optionals
- improve support for building with different versions of python
- updates/bug fixes to remove warnings when using hardened gcc flags
- fix compilation failure in mcstrans
- man page updates

As with the previous rc, action after installing the release candidate
is required to migrate the policy store from /etc/selinux to
/var/lib/selinux. Detailed information about this process can be found
on the Policy Store Migration wiki page [3].

Note that changes to checkpolicy have been made as part of rc4, and so
it is now included in the release candidate.

Also, note that although git tags for rc3 were created, rc3 was never
officially released and was never made available, hence the skipping
from rc2 to rc4.

Please give this a test and let us know if you find any problems.

Thanks,
- Steve

[1] https://github.com/SELinuxProject/selinux
[2] https://github.com/SELinuxProject/selinux/wiki/Releases
[3] https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration
