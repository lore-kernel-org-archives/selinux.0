From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: ANN: SETools 4.0.1
To: "SELinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>, refpolicy
 <refpolicy@oss.tresys.com>
Message-ID: <3e8df2a5-67f3-a8b0-1139-1d87ed2b60c1@tresys.com>
Date: Tue, 17 May 2016 13:52:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tresys is pleased to announce the release of SETools 4.0.1:

https://github.com/TresysTechnology/setools/releases/tag/4.0.1

This is primarily a bugfix release.  Changes since 4.0.0:

Library:
* Fixed a compile error on 32bit systems.
* Changed domain transition analysis output to use lists instead
  of generators.  This fixes a display problem in apol's DTA browser.

Apol:
* Replaced icons with stock Qt icons to remove license issues
  for some distributions.

Sesearch:
* Changed xperm options to bring in line with sediff, e.g. --allowx
  changed to --allowxperm.  Python's argument parser will still detect
  --allowx as an abbreviation of --allowxperm, so compatibility is
  preserved.

This release requires libsepol-2.5, which is unfortunately not available
yet on some distributions.

Warning: If you use this to replace SETools 3.x on your system, it will
break the couple of tools from sepolgen/policycoreutils that depend on
SETools (e.g. sepolicy) since libqpol/libapol C libraries and their
corresponding Python wrappers are no longer provided.

If you would like to help, planned features and bugs are listed in
SETools' GitHub issue tracker:

https://github.com/TresysTechnology/setools/issues

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
