Subject: Announcement: setools version 1.1
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1071786946.16624.37.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 18 Dec 2003 17:35:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tresys setools version 1.1 is now available. Source, rpms, and a patch
for the latest NSA release are available from our website:

http://www.tresys.com/selinux/

Additionally, the SELinux cvs repository on sourceforge has been
updated. This release includes many enhancements and additions
including:

- A new application called seaudit for policy debugging. Seaudit allows
you to view audit messages from SELinux, search and sort those messages,
and query a policy for rules related to those messages. This is the
initial release of this tool and we are considering additional
functionality for a future release, including realtime monitoring of
audit messages.

- New command line tools called seinfo and sesearch. Seinfo is a command
line tool for looking at an SE Linux policy and viewing various
component elements and statistics. Sesearch is a command line tool to
search the TE rules.

- Enhanced transitive information flow analysis in Apol. The transitive
information flow analysis in apol has been significantly enhanced to
allow the filtering of object classes, object class permissions, and
intermediate types in queries, finding additional information flows
between types, and a removal of potential false positives.

- Analysis queries in Apol can now be saved for use later. This is
particularly useful for the complex transitive information flow queries.

- Significant enhancement to the internal structure of the libraries. In
particular, dependencies with X11 are now removed from all of the
command line tools. This will allow for the installation of a limited
set of the tools on servers without X11.

- A large number of minor enhancements and bug fixes.

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
