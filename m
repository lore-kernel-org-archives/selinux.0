Message-Id: <200406021932.i52JWCSf003064@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Fedora SELinux support list for users & developers.'" <fedora-selinux-list@redhat.com>
Cc: <selinux-dev@tresys.com>
Subject: [ANNOUNCE] Setools version 1.4 released
Date: Wed, 2 Jun 2004 15:32:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tresys Setools version 1.4 has been released. It is available from the
SELinux sourceforge cvs repository and the Tresys webpage:

http://www.tresys.com/selinux/

This release includes several new features including:

- Support for binary policies in addition to source policies in libapol.
This allows almost all of the tools, including Apol, Seaudit, sesearch, and
seinfo, to work with a binary policy. This is especially important as more
SELinux systems are deployed without a full policy source tree.

- GUI updates to Apol and Seaudit to correctly support binary policies.

- Seaudit, sesearch, and seinfo will now load a binary policy by default if
no source policy is found.

- Numerous bug fixes and policy updates for Seuser allowing it to run
correctly under Fedora Core 2.

- The installation of policy and labeling of files has been removed from the
'make install' target in order to support systems with policies that are
significantly different from the default NSA policy. The new target 'make
install-policy' will install the Setools policy files and label the
applications and configuration files.

- Seinfo now supports conditional policies.

- The results tabs in Apol can now be renamed by the user to make them
easier to distinguish when many tabs are open simultaneously.


Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
