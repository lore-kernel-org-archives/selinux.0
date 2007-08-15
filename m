Subject: Question concerning building policy modules
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 14:50:04 -0400
Message-Id: <1187203804.26375.69.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why isn't the Makefile and other information needed to build a module
separately in the appropriate /usr/share/selinux/<policy name>
directory?  This seems like the logical place for that information.  The
(not very well documented) "install-headers" make target in the
refpolicy Makefile does this.

Instead, the information to build a module for Fedora is in
the /usr/share/selinux/devel directory.  This directory would seem to be
independent of the policy type, even though it is only for building
Fedora policies.  This seems confusing.  The devel directory should have
stuff that all policies need or could use.

Wouldn't it make sense that if I wanted to build a module for the
current policy, I would use the Makefile in devel which would look
at /etc/selinux/config and include the Makefile for the current policy,
but if I wanted to compile for a particular policy, I would just use the
Makefile in its /usr/share directory?

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
