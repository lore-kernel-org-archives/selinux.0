Message-Id: <200212162125.QAA00730@moss-shockers.ncsc.mil>
Date: Mon, 16 Dec 2002 16:25:26 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Domain transition
To: SELinux@tycho.nsa.gov, rmayo@caci.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 1)    What is "domain transition"?  I've configured my system such that it
> doesn't happen, but I'm wondering if it's the best way to go.

Read the Configuring the SELinux Policy report, available in the
distribution (selinux/doc/policy) or from the NSA SELinux web site.
You might also want to read a background paper on Type Enforcement (TE).

A domain is a security attribute associated with a process.  Processes with the 
same domain have the same set of permissions to the same set of objects. A 
domain transition occurs when a process changes its domain, conventionally by 
executing a program with a particular entrypoint type.  Domain transitions 
provide a controlled mechanism for changes in permissions, whether to gain 
permissions, shed permissions, or switch to a completely orthogonal set of 
permissions.  I doubt that you really configured away domain transitions. If you 
did, you might as well not use SELinux.

> 2)    Is there a text file on my system with the list of user roles or is
> that information stored some other way?

In the source distribution's selinux tree, the policy/users file specifies the 
set of roles authorized for each user.  Obtaining the full set of defined roles
is not entirely straightforward because role declarations are now distributed
among the domain .te files.  Roles for user processes are typically defined
in policy/domains/user.te or policy/domains/admin.te.  You may want to look at 
the Tresys policy tools as a way of more easily viewing the policy or managing 
users.

In an installed form, the policy sources are typically placed into 
/etc/security/selinux/src/policy.

> 3)    Can I configure the operating system NOT to ask for a user role on
> login?  I would much prefer to have user role determined BY the login.

The user will be limited to the roles authorized for that user in
policy/users.  If you authorize the user for multiple roles, then he
can choose one of those roles at login time or subsequently via newrole.
What's the point of limiting the user to a single role at login time if he can 
change it subsequently via newrole?  Of course, you could limit login
to transition to a single user domain if you want to force all users to
initially login with a certain role/domain.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
