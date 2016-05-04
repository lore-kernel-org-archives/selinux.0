From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: ANN: SETools 4.0.0
To: "SELinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>, refpolicy
 <refpolicy@oss.tresys.com>
Message-ID: <9184a310-f2bf-3b52-f5ed-1784d95a462b@tresys.com>
Date: Wed, 4 May 2016 10:08:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tresys is pleased to announce the release of SETools 4.0.0:

https://github.com/TresysTechnology/setools/releases/tag/4.0.0

SETools has been reimplemented in Python. The following tools were
reimplemented:

* apol
* sediff
* seinfo
* sesearch

The following tools were added:

* sedta (command line domain transition analysis)
* seinfoflow (command line information flow analysis)

For an overview of the user interface changes since SETools 3.x, see the
related wiki page
<https://github.com/TresysTechnology/setools/wiki/Changes-Since-SETools-v3>.

This release requires libsepol-2.5, which is unfortunately not available
yet on some distributions.


Warning: If you use this to replace SETools 3.x on your system, it will
break the couple of tools from sepolgen/policycoreutils that depend on
SETools (e.g. sepolicy) since libqpol/libapol C libraries and their
corresponding Python wrappers are no longer provided.


The major changes since the 4.0.0-beta release are:

* Completed apol
* Implemented v30 policy support (xperm rules; initial contribution from
Richard Haines)
* Implemented Xen policy support (initial contribution from Richard Haines)
* Added man pages


If you would like to help, planned features and bugs are listed in
SETools' GitHub issue tracker:

https://github.com/TresysTechnology/setools/issues


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
