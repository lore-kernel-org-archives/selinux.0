Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBFId3BT020983
 for <selinux@tycho.nsa.gov>; Tue, 15 Dec 2015 13:39:03 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: ANN: SETools 4.0.0-alpha3
To: SELinux List <selinux@tycho.nsa.gov>
Message-ID: <56705E1D.5000607@tresys.com>
Date: Tue, 15 Dec 2015 13:38:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tresys has released SETools 4.0.0-alpha3:

https://github.com/TresysTechnology/setools/releases/tag/4.0.0-alpha3

In this release, the analysis library is largely completed, except for
sediff functions. PyQt5 was chosen for the GUI library for SETools; apol
has been started and a few rule searches and analyses have been added.
The design of apol shifted towards a simpler, single-level tab design,
so different types of analyses can be seen alongside each other.

Warning: If you replace the SETools 3.x on your system, it will break
the couple of tools from sepolgen/policycoreutils that depend on SETools
(e.g. sepolicy) since libqpol/libapol C libraries and their
corresponding SWIG wrappers are no longer provided.



-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
