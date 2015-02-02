Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t12G0OEN025127
 for <selinux@tycho.nsa.gov>; Mon, 2 Feb 2015 11:00:24 -0500
Message-ID: <54CF9F03.8040604@tresys.com>
Date: Mon, 2 Feb 2015 11:00:03 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: ANN: SELinux Userspace Release: 20150202
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We are pleased to announce SELinux Userspace release 20150202. Tarballs
are available on the Releases wiki page [1]. For git users, it has been
tagged as 20150202. This release includes numerous bug fixes,
performance updates, and new features, including CIL [2] and High Level
Language [3] support. Please see the change logs for a detailed list of
updates.

One change worth pointing out is a change of location of the SELinux
module store, which now defaults to /var/lib/selinux/. Updating to this
release requires migrating the old policy store to this new location
before policy can be managed with tools like semanage and semodule.
Detailed information about the migration process is available on the
Policy Store Migration wiki page [4].

Thanks to all those that have submitted patches,

- Steve

[1] https://github.com/SELinuxProject/selinux/wiki/Releases
[2] https://github.com/SELinuxProject/cil/wiki
[3]
https://github.com/SELinuxProject/selinux/wiki/High-Level-Language-Infrastructure
[4] https://github.com/SELinuxProject/selinux/wiki/Policy-Store-Migration
