Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4AFIvNG020065
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 11:18:57 -0400
To: SELinux <selinux@tycho.nsa.gov>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <921a3a88-e10d-40dc-fde5-7ef12f775e32@tycho.nsa.gov>
Date: Thu, 10 May 2018 11:20:01 -0400
MIME-Version: 1.0
In-Reply-To: <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: ANN: SELinux userspace 2.8-rc3 release candidate
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A 2.8-rc3 release candidate for the SELinux userspace is now available at:
https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

A draft of the release notes is available from the Releases page, as
is the full git log output and git shortlog output since the 2.7
release.  If there are further items we should mention or if something
should be amended in the release notes, let us know.
 
Thanks to all the contributors to this release candidate!
 
A shortlog of changes since the 2.8-rc2 release candidate is below.

Stephen Smalley (7):
      libsepol: remove unused function and type
      libselinux: fix build warning in save_booleans()
      libselinux: avcstat: fix build warning
      libselinux: audit2why: fix build warnings
      libsemanage: prevent string overflow on final paths
      libsepol: cil: prevent stack buffer overflow in cil_expr_to_string
      Update VERSION files to 2.8-rc3

Vit Mojzis (1):
      python/semanage/seobject.py: Fix undefined store check
