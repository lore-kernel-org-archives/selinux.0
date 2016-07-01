Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u618rVm7007232
 for <selinux@tycho.nsa.gov>; Fri, 1 Jul 2016 04:53:31 -0400
Received: from localhost (LFbn-1-6691-76.w90-120.abo.wanadoo.fr
 [90.120.129.76])
 by mail.free-electrons.com (Postfix) with ESMTPSA id 2E62C17DA
 for <selinux@tycho.nsa.gov>; Fri,  1 Jul 2016 10:53:29 +0200 (CEST)
Date: Fri, 1 Jul 2016 10:53:28 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: selinux@tycho.nsa.gov
Subject: [BUG libselinux] Use nftw() instead of fts()
Message-ID: <20160701105328.6faa126f@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

The recent versions of libselinux use the fts() function in
src/selinux_restorecon.c. This function is BSD-only, and therefore not
available in the musl C library, and only available optionally in the
uClibc C library.

Would it be possible to use instead the POSIX-compliant nftw()
function, which provides the same functionality?

In addition, using fts() is problematic, as on glibc versions <= 2.22,
it is incompatible with large file support.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
