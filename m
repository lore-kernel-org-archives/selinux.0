Subject: [ANN] SETools 3.3.7 Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 12 May 2010 08:04:04 -0400
Message-ID: <1273665844.738.3.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of SETools is now available on the Tresys OSS site, from
http://oss.tresys.com/projects/setools.  

A summary of the changes in SETools 3.3.7:

* Wrapped new policy db components so we can build against
  new and old SELinux userspace.

* Switch to a non-modal advanced filtering window.

* Rebase module loading code on upstream userspace.

* Automatically detect base module instead of asking
  user to identify the base.

* Support for bzipped policy packages (.pp) found in
  Fedora 12 and later.

* Fix seinfo to correctly handle cases where there are
  no nodecon statements in the policy.

* Fixes error conditions that prevent apol from exiting.  If
  window/tab was already destroyed on exit
  then apol threw an error and refused to exit.

* Add support for displaying constraints to seinfo.

* Add constraint CUnit tests.

* Ensure architecture independent parts of python SWIG wrapper
  get installed into the same directory as the architecture
  dependent parts.

* Fix seaudit/libseaudit headers.

* Fix error message when Tk cannot be loaded by apol.  Make it
  clear that it is Tk, not an SETools library that cannot be loaded.

* Fix error in Apol which would disable new and updated search
  buttons in rule search.

* Fix seaudit-report to correctly handle -c and --config
  options.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
