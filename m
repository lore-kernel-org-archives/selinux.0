Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9TJhm1P015841
 for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2014 15:43:49 -0400
Message-ID: <5451435A.50809@tresys.com>
Date: Wed, 29 Oct 2014 15:43:22 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: SELinux List <selinux@tycho.nsa.gov>
Subject: ANN: SETools 4.0.0-alpha1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tresys has released SETools 4.0.0-alpha1:

https://github.com/TresysTechnology/setools/releases/tag/4.0.0-alpha1

The dependence on SETools 3 has been removed.  It is tested on Python
2.7, but development will likely be transitioning to Python 3.3, as the
barriers blocking 3.3 have been addressed.

While this is still alpha code, the existing code is fairly well tested,
with 73% coverage from unit tests[1].  The core CLI tools, with the
exception of seinfo, are nearly complete.  The GUI tools have not been
started yet.

Warning: If you replace the SETools 3.x on your system, it will break
the couple of tools from sepolgen/policycoreutils that depend on SETools
(e.g. sepolicy) since the API has changed.

If you are interested in contributing, GitHub's pull request feature is
preferred for submitting patches.  Please include unit tests.

To use SETools 4, the following packages are required:
* Python 2.7
* NetworkX
* setuptools
* libselinux
* libsepol
* libbz2

To build SETools 4, the following packages are required:
* Python 2.7
* setuptools
* libselinux
* libsepol
* libbz2
* gcc
* SWIG (tested on 2.0)
* bison
* flex

[1] as reported by coverage.py, for the Python portion of SETools

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
