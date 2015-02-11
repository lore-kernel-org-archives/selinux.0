Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1BFn0Uq019070
 for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2015 10:49:01 -0500
Message-ID: <54DB79D3.8@tresys.com>
Date: Wed, 11 Feb 2015 10:48:35 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
To: SELinux List <selinux@tycho.nsa.gov>
Subject: ANN: SETools 4.0.0-alpha2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tresys has released SETools 4.0.0-alpha2:

https://github.com/TresysTechnology/setools/releases/tag/4.0.0-alpha2

In this release, SETools has been updated to support Python 3 (tested
with 3.3 and 3.4) and includes travis-ci testing[1].  Many features are
complete or nearly complete (full list at the end of the email) and
available for use via the CLI tools.  The GUI tools have not yet been
started.

Warning: If you replace the SETools 3.x on your system, it will break
the couple of tools from sepolgen/policycoreutils that depend on SETools
(e.g. sepolicy) since libqpol/libapol C libraries and their
corresponding SWIG wrappers are no longer provided.

If you are interested in contributing, GitHub's pull request feature is
preferred for submitting patches.  Please include unit tests.

SETools requires the following development packages for building:
  Python 2.7 or 3.3+
  setuptools
  gcc
  bison
  flex
  libselinux
  libsepol 2.4+
  libbz2
  SWIG 2.0.12+ or 3.0+

To run SETools, the following packages are required:
  Python 2.7 or 3.3+
  NetworkX 1.8+
  setuptools
  libselinux
  libsepol 2.4+
  libbz2

Completed (and nearly completed) features:
* TE rule query
* RBAC rule query
* MLS rule query (range_transition; except for range criteria)
* Type query
* Role query
* User query (except level/range criteria)
* Object class query
* Common query
* Boolean query
* Policy capability query
* All context queries (portcon, genfscon, etc, except range criteria)
* Information flow analysis
* Domain transition analysis

[1] https://travis-ci.org/TresysTechnology/setools

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
