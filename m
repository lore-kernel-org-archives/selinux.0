To: SELinux@tycho.nsa.gov
Subject: Announce: Slat 1.1.0 with policy deconditionalizer
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 20 Feb 2004 06:21:18 -0500
In-Reply-To: <000c01c3f265$9139f860$020d010a@columbia.tresys.com>
Message-ID: <ogty8qyxahd.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Slat version 1.1.0 has been committed into the nsa module of the
selinux project on SourceForge.  This version reimplements some old
fixes that somehow were left out of the repository at NSA, and
provides a new program called poldecond.

The poldecond program accepts policy configuration files that use the
conditional policy extension.  The program extracts the
conditional-less policy defined by using the default value for each
boolean in the input.  For example, suppose ping.te contains the
following boolean declaration:

  bool user_ping false;

The command

  $ poldecond ping.te ping_false.te

will produce a te file with user_ping = true branches elided.

The value for the first boolean declaration overrides all others, so
one can derive other policies by adding boolean declarations with
different defaults at the beginning of the input.  For example, to
produce a te file with user_ping = false branches elided, use the
command:

  $ echo 'bool user_ping true;' | cat - ping.te | poldecond - ping_true.te

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
