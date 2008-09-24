Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8O1NO0E022221
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 21:23:24 -0400
Received: from etbe.coker.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8O1MPAY023457
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 01:22:26 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by etbe.coker.com.au (Postfix) with ESMTP id 80A5B1813A
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 11:23:17 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 12FBC22188
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 11:23:16 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: apol bugs
Date: Wed, 24 Sep 2008 11:23:14 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809241123.15779.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a couple of Debian bug reports I just filed about apol:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=499968
setools: needs a script to run apol with the current list of modules

When apol is run on the installed policy (such as
/etc/selinux/*/policy/policy.*) then it misses out on a lot of symbolic
information (such as the types that are in attributes) and thus makes it
impossible to determine the reason why some access is permitted.

To solve this I suggest having a script such as the following:

#!/bin/bash -e

. /etc/selinux/config
if [ "$1" = "-s" ]; then
  shift
  SELINUXTYPE=$2
  shift
fi
cd /etc/selinux/$SELINUXTYPE/modules/active
exec apol base.pp modules/*.pp $*

Of course any user could figure this out on their own, but having a
script to do it for them saves effort for everyone (even I had to ask
the mailing list for advice on this issue).



http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=499967
setools: Could not open policy error is not specific

I ran apol with a list of 30 modules and received a message in a dialog box
titled "Open Policy" which said:
"The selected file does not appear to be a valid SELinux Policy.

Could not open policy"

That does not tell me which of the 30 files had a problem.  The dialog
in question should name the file that it had a problem with to save me
the effort of a binary search.

As well as giving the name of the file, the type of error (non-existent file, 
EPERM, etc) should be displayed to the user.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
