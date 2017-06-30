Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5UHmw0a026680
 for <selinux@tycho.nsa.gov>; Fri, 30 Jun 2017 13:48:58 -0400
Message-ID: <1498845208.16913.17.camel@tycho.nsa.gov>
Subject: ANN: SELinux userspace 2.7-rc4 release candidate
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Fri, 30 Jun 2017 13:53:28 -0400
In-Reply-To: <1498237648.2063.4.camel@tycho.nsa.gov>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1498237648.2063.4.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A fourth (and hopefully final) release candidate for the SELinux
userspace is now available at:
https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.
Barring any significant further changes, a final 2.7 release is likely
the week of July 10th.

Changes from the -rc3 release:

Laurent Bigonville (1):
      Fix consistency of PYTHONLIBDIR variable across modules

Nicolas Iooss (3):
      Travis-CI: update the list of Ruby's and Python's versions
      libsepol/tests: override CPPFLAGS too
      Travis-CI: test defining CFLAGS, LDFLAGS, etc. on make command
line

Stephen Smalley (2):
      libselinux,libsemanage: fix RUBYLIBS definition
      Update VERSION files for 2.7-rc4 release.
