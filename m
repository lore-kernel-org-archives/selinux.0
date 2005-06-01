Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j51Ij7gA017119
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2005 14:45:07 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j51Id13e003540
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2005 18:39:01 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with SMTP id j51Id2619403
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2005 14:39:02 -0400
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id DF37FBF7D
	for <selinux@tycho.nsa.gov>; Wed,  1 Jun 2005 14:39:01 -0400 (EDT)
Received: from MAILHUB1 (mailhub1.mitre.org [129.83.20.31])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id j51Id1I19375
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2005 14:39:01 -0400
To: selinux@tycho.nsa.gov
Subject: Polgen 1.1 is now available
From: bsniffen@mitre.org (Brian T. Sniffen)
Date: Wed, 01 Jun 2005 14:38:54 -0400
Message-ID: <d28hdghq5vl.fsf@jon-strange.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Version 1.1 of Polgen, MITRE's tool suite for automated recognition
of software design patterns and generation of SE Linux type enforcement
policy, is now available at

    http://www.mitre.org/tech/selinux/


The new release offers:

* An improved GUI, with better intelligence about which questions 
  not to ask.

* "No GUI" mode, for batch use.

* Separation of concerns: the pattern recognizers are entirely
  distinct from the policy applied when a pattern is detected.

* New "Daemon" pattern, as well as improvements to Single Process
  Mediator and Executable.


Polgen is a suite of tools which assist in generating SE Linux
policy based on dynamic analysis of information flow.  It includes:

* SE Linux-aware strace.  Now it's possible to see exactly what a
  program's doing, with more detail than AVC logs typically show.

* FD Tracker, a tool for reducing strace output to simple lists of file
  descriptors used for read- or write-like information flow.  This
  typically reduces strace output by two orders of magnitude: over 5
  MB of strace output is cooked down to only 50 KB of easily analyzed
  data.

* Spar, a pattern analysis tool.  Spar presents a GUI wizard-style
  interface.  It looks for patterns in Tracker output, identifying
  eighteen common arrangements of system calls.  Spar's wizard
  interface gives the user control: the ability to correct falsely
  recognized patterns and to guide generation of new types.  Patterns
  suggested by the program can be accepted for policy generation or
  rejected.  New types can be automatically created by Spar, and
  populated with resources.

  Spar produces .te and .fc files which can be incorporated directly
  into your existing policy---though as with any automated output,
  they should be reviewed by humans before production use.

Download Polgen today from <http://www.mitre.org/tech/selinux/>.

Polgen is available under the GNU General Public License,
version 2 or later.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
