Subject: Announce: SELinux conditional policy extensions
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1072133247.3032.22.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Mon, 22 Dec 2003 17:47:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the conditional policy extensions to SELinux is
available from our website:

http://www.tresys.com/selinux/index.html

The conditional policy extensions to SELinux allow runtime modification
of the security policy without having to load a new policy. Using
boolean variables and expressions, it is possible to define sections of
policy that are conditionally applied. Please see the website for more
information.

This release includes modifications to the linux kernel, checkpolicy,
and libselinux and allows the creation and loading of conditional
policies. We have done internal testing, but this release is not ready
for production use. In particular, the selinuxfs modifications are new
and have had only minimal testing.

There are several known deficiencies with this release that we will
address:

- The selinuxfs additions need review, cleanup, and testing.
- Fine-grained labeling of selinuxfs has not been implemented yet.
- The policy has not yet been modified to take advantage of the new
language features.

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
