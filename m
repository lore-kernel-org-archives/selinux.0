Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oA3K700Z021178
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2010 16:07:00 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id oA3K6xSi007943
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2010 20:07:00 GMT
Date: Wed, 03 Nov 2010 16:06:49 -0400
Subject: CIL feature: macro
From: Chad Sellers <csellers@tresys.com>
To: SELinux <selinux@tycho.nsa.gov>
Message-ID: <C8F73919.BB240%csellers@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Macro is a new policy statement found in CIL. The simplest way to explain it
is that it is like a Reference Policy interface or template, but part of the
actual policy language. So, a policy author can create a bit of policy in a
macro, which can later be called from somewhere else with typed parameters.

Macros will most often be declared within a block (a block is a namespaced
logical grouping of policy which is discussed more at
http://userspace.selinuxproject.org/trac/wiki/CilDesign#Namespaces ). They
can be used as a safe way to access the symbols (types, etc.) within that
block.

Macros allow declarations, and can consequently be used the same way
Reference Policy templates can be used. Macros do not provide any mechanism
for string munging, though the use of namespaces largely negates the need
for this. For instance, rather than calling the ssh_role_template()
interface with a prefix of staff (as you'd do in Reference Policy), one
would merely call the ssh.role_template() CIL macro from within the staff
block. This would expand into new types like ssh_agent_t being created in
the staff namespace, which would result in the type name staff.ssh_agent_t.

Because macros are part of the language, this means a module is no longer
dependent on the macro implementation not changing. If you write a policy on
one machine, but then install it on a machine with a different policy, the
module will use the macro implementation from the target system, not the
development system.

Also, because macros have a structured format understood by they language,
they can have useful error messages when things go wrong. This should make
debugging policies much simpler than today.

We've been talking about putting interfaces in the language for some time,
and we believe this is the best way to do it. Any feedback is much
appreciated.

Thanks,
Chad Sellers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
