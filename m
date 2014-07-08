Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s68J54k9027981
 for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2014 15:05:04 -0400
Message-ID: <53BC40CE.4040206@tresys.com>
Date: Tue, 8 Jul 2014 15:04:46 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: <selinux@tycho.nsa.gov>
Subject: ANN: SETools 4 open-sourced
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tresys has open-sourced SETools 4, available on GitHub:

https://github.com/TresysTechnology/setools

The current development state is alpha; this is a reimplementation of
SETools using Python.  Only CLI tools have been implemented so far, but
the GUI tools will eventually return.  Presently, the code uses SETools
3's libqpol library (with SWIG wrapper) to provide the low-level access
to the binary policy file.  Going forward, we'd like to propose an
upstream library which would provide a low-level policy query interface;
this could be useful for other tools such as dispol and sepolicy-analyze
(from the seandroid repo).

The focus of the effort thus far has been:
* Implement core functionality
* Implement unit testing

There are functional versions (with varying completeness) of the
following tools:
* sedta (a new CLI tool for domain transition analysis)
* seinfo
* seinfoflow (a new CLI tool for information flow analysis)
* sesearch

To use SETools 4, the following packages are required:
* Python 2.7
* sepolgen
* NetworkX
* SETools 3 libraries w/Python wrappers (git version)

To install SETools or run the unit tests, the Python setuptools package
is also required.

The TODO list is still lengthy, but here are a few major areas that need
attention:
* complete the Python policy representation classes (e.g. users,
constraints, etc.)
* comprehensive component queries (role query, user query, class query,
etc.)
* full permission map handling (e.g. find permissions in policy that are
unmapped, save to file)

If you are interested in contributing, GitHub's pull request feature is
strongly preferred for submitting patches, but patches can also be sent
to this mail list.  Please include unit tests.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
