Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBBLsH2L004963
 for <selinux@tycho.nsa.gov>; Sun, 11 Dec 2016 16:54:17 -0500
To: SELinux <selinux@tycho.nsa.gov>, refpolicy <refpolicy@oss.tresys.com>
From: Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.1.0-rc
Message-ID: <f356a481-95e9-f242-c1c8-03cf9ae3cc82@ieee.org>
Date: Sun, 11 Dec 2016 16:54:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm pleased to announce the SETools 4.1.0-rc release, available here:

https://github.com/TresysTechnology/setools/releases/tag/4.1.0-rc

This release primarily focused on adding features to apol, but has 
several library enhancements. There is also one important bugfix in sediff.

Changes since 4.0.1:

   Library:
   * Implemented support for alternate install prefixes.
   * Implemented support for building setools with a locally-built
     libsepol.
   * Fixed an sediff bug with unioning rules after expansion.
   * Improved sediff memory usage.
   * Patch from Nicolas Iooss to make more stable output in TE rule
     permission lists.
   * Replaced string representations (e.g. rule types) with enumerations.
     Requires the enum34 (not enum) Python package if using Python < 3.4.

   Apol:
   * Implemented context menu option for exporting the information flow
     and domain transition analysis tree browser views.
   * Implemented CSV export of table results.
   * Implemented (clipboard) copy from table results.
   * Added missing "clear" button in object class query.
   * Implemented save/load settings for tabs.
   * Implemented save/load workspace (save all tabs settings).
   * Fixed include/exclude type dialog to keep its place when
     adding or removing types from an analysis.
   * Implemented filter on include/exclude type dialog to filter
     the lists by attribute.


Warning: If you use the 2.5 SELinux userspace toolchain and use this to 
replace SETools 3.x on your system, it will break the couple of tools 
from sepolgen/policycoreutils that depend on SETools (e.g. sepolicy) 
since libqpol/libapol C libraries and their corresponding Python 
wrappers are no longer provided. The >=2.6 SELinux userspace toolchain 
has updated its support to setools4, and does not have this problem.

-- 
Chris PeBenito
