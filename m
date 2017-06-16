Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5GGoo7B016607
 for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2017 12:50:50 -0400
Message-ID: <1497632109.7898.5.camel@tycho.nsa.gov>
Subject: ANN: SELinux userspace 2.7-rc2 release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Fri, 16 Jun 2017 12:55:09 -0400
In-Reply-To: <1497028696.26846.9.camel@tycho.nsa.gov>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A second release candidate for the SELinux userspace is now available
at:
https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

Changes from the -rc1 release:

James Carter (2):
      libsepol: Fix neverallow bug when checking conditional policy
      libsepol/cil: Fix bugs when writing policy.conf rules

Nicolas Iooss (1):
      libsepol: destroy the expanded level when
mls_semantic_level_expand() fails

Richard Haines (2):
      libsepol/cil: ibendportcon fails to resolve in CIL policy
      secilc: Update test policy and documentation for Infiniband

Stephen Smalley (1):
      Update VERSION files for 2.7-rc2 release.

Vit Mojzis (1):
      policycoreutils/fixfiles: do not dereference link files in tmp
