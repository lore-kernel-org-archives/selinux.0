Subject: Setools 1.0.1 released
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1067890582.1269.32.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Mon, 03 Nov 2003 15:16:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have just released version 1.0.1 of setools. This is a minor update
that fixes some bugs and synchronizes with the changes in the NSA and
RedHat packages of setools. The most important update is to the seuser
policy to make it compile correctly with the latest official SELinux
policy. Source and binaries are available from our website:

http://www.tresys.com/selinux/

I have also attached a patch for the last NSA release of SELinux and
updated the sourceforge cvs repository.

The next release, sometime in early December, will include improved
information flow analysis, the ability to save and load complex queries
in apol, the removal of Tcl/TK and X dependencies from the command-line
tools, and a log file analysis tool that leverages libapol to help a
policy developer or system administrator understand the audit message
from SELinux.

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
