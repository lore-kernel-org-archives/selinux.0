Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6IGAi0e021845
 for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2017 12:10:44 -0400
Message-ID: <1500394496.18445.10.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Tue, 18 Jul 2017 12:14:56 -0400
In-Reply-To: <1498845208.16913.17.camel@tycho.nsa.gov>
References: <1497028696.26846.9.camel@tycho.nsa.gov>
 <1498237648.2063.4.camel@tycho.nsa.gov>
 <1498845208.16913.17.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: ANN: SELinux userspace 2.7-rc5 release candidate
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A fifth release candidate for the SELinux userspace is now available
at:
https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

Changes from the -rc4 release:

Stephen Smalley (4):
      open_init_pty: Do not make stdin and stdout non-blocking
      Revert "open_init_pty: Do not make stdin and stdout non-blocking"
      open_init_pty: restore stdin/stdout to blocking upon exit
      Update VERSION files for 2.7-rc5
