Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l18IKksk015343
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 13:20:46 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l18ILsgM013838
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 18:21:54 GMT
Subject: ANN: SETools Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: fedora-selinux-list@redhat.com
Content-Type: text/plain
Date: Thu, 08 Feb 2007 18:21:55 +0000
Message-Id: <1170958915.31164.45.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of SETools is now available on the Tresys OSS site, from
http://oss.tresys.com.  The primary change in this release is the
addition of support for loading sets of policy modules in all of the
tools.  This enables analysis of the policy with nearly all of the
information available from the original source policy, such as original
attribute names.  The complete change log for this release follows.

SETools 3.1:

SETools:

  * All tools that open a policy now support loadable policy modules.
    Command line tools expect the first module to be a base module
    followed optionally by any other modules.  Graphical tools have
    a new open policy dialog to select a base module and any number of
    additional modules.

  * Release of RPM packages that are compatible with Fedora Core 5 and
    6.  The spec and support files are in packages/rpm.

libapol:

  * New class apol_policy_path_t to represent a base policy and any
    number of modules.  Use this whenever referring to the file or
    files constituting a policy.
  
libqpol:

  * Policy features such as attribute names or MLS can now be queried
    individally via qpol_policy_has_capability() rather than inferred
    by policy type and version.

  * New class qpol_module_t to represent a particular policy module
    prior to it being linked into a base policy (qpol_policy_t).

libseaudit:

  * Rewrite of library to have proper namespaces.  libseaudit is now
    fully documented and suitable for third-party users.

seaudit:

  * Rewrite to use new libseaudit.

  * Numerous tweaks to the interface to be more user friendly.

seaudit-report:

  * Rewrite to use new libseaudit.

sediffx:

  * Numerous tweaks to the interface to be more user friendly.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
