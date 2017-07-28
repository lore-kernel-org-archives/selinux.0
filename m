Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6SJgi0m016803
 for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2017 15:42:44 -0400
Message-ID: <1501271255.2125.1.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Fri, 28 Jul 2017 15:47:35 -0400
In-Reply-To: <1500394496.18445.10.camel@tycho.nsa.gov>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1498237648.2063.4.camel@tycho.nsa.gov>
 <1498845208.16913.17.camel@tycho.nsa.gov>
 <1500394496.18445.10.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: ANN: SELinux userspace 2.7-rc6 release candidate
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A sixth release candidate for the SELinux userspace is now available
at:
https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

Changes from the -rc5 release:

Dan Cashman (1):
      libsepol: cil: enable cpp compilation of cil.h.

Petr Lautrbach (4):
      sepolicy: Fix minor typo in 'transition -s' test
      sepolicy: Fix syntax errors in 'manpage -w'
      sepolicy: Make manpage and transition faster
      sepolicy: File labels used to be sorted in a man page

Stephen Smalley (2):
      libsepol: Define nnp_nosuid_transition policy capability
      Update VERSION files for 2.7-rc6

Tom Cherry (1):
      libselinux: fix thread safety issues with lookup_common()
