Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8TGJJUS026392
 for <selinux@tycho.nsa.gov>; Sat, 29 Sep 2018 12:19:19 -0400
Received: by mail-qt1-f178.google.com with SMTP id c56-v6so4989331qtd.11
 for <selinux@tycho.nsa.gov>; Sat, 29 Sep 2018 09:19:15 -0700 (PDT)
From: Chris PeBenito <pebenito@ieee.org>
To: SELinux <selinux@tycho.nsa.gov>, refpolicy <refpolicy@oss.tresys.com>
Message-ID: <1124dbc3-5e33-eb3a-e70d-388a72fe3a9f@ieee.org>
Date: Sat, 29 Sep 2018 12:19:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: ANN: SETools 4.2.0-rc
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

An SETools 4.2.0 release candidate is now available:

https://github.com/SELinuxProject/setools/releases/tag/4.2.0-rc

Changes since v4.2.0-beta:

* Fixed performance regressions.

* Made further memory usage improvements.

* Fixed build issues with clean target and runtime_library_dirs.

* Revised package structure to make policyrep a module of the setools 
package.

* Symbol names are now available as the name attribute (e.g. 
Boolean.name, Type.name, etc.)

* Fixed some apol layouts to increase the size of text fields.

* Move constraint expression to its own class.

* Made Conditional.evaluate() more useful and added BaseTERule.enabled() 
method to determine if a rule is enabled.


Changes since v4.1.1:

* Replaced the Python/SWIG/static-linked-libsepol policyrep module with 
a Cython implementation. This will have performance and memory-usage 
improvements and breaks the static linking to libsepol.

* Significant memory usage reduction in sediff (approximately 60%, 
depending on the policies).

* Added support for SCTP portcons

* Updated permission maps

This release of SETools has changed dependencies since 4.1.1. See 
README.md for more details.

-- 
Chris PeBenito
