Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4RILugA014242
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2005 14:21:56 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4RIGKPP016788
	for <selinux@tycho.nsa.gov>; Fri, 27 May 2005 18:16:21 GMT
Subject: [RFC] Module language syntax
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: selinux-dev@tresys.com
Content-Type: text/plain
Date: Fri, 27 May 2005 14:17:33 -0400
Message-Id: <1117217853.9785.22.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Late last year we announced a prototype of the SELinux loadable policy
modules (previously called binary policy modules). That prototype
included several language changes to enable features like optional
policy blocks and modules dependency information. Only after starting to
write policy with these language extensions did it become apparent that
there were some shortcomings. For those who have never seen the module
language here is an example of the new syntax:

module foo 1.0;

require {
	type user_t, user_home_dir_t;
	class file { read write };
}
allow user_t user_home_dir_t : file { read write };

optional {
	require {
		type user_home_ssh_t;
	}
	allow user_t user_home_ssh_t : file { read };
} 


With this syntax macros can add their dependencies at the same time
they add the rules, and the same macros can be used in the global
scope as well as inside optionals.

The modules separate the development environment from the production
environment. Ideally the modules are compiled in a development
environment, tested and then sent to the production environment for
installation. The production environment then does not need a build
environment such as make, m4 and so on. The module tools will allow
these modules to be "linked in" to the current policy. It's at this link
time that both the modules dependencies and the optional dependencies
are determined and optionals with fulfilled dependencies are enabled.

All optionals are considered discrete entities with their own sets of
dependencies. The existence of these dependencies is checked at module
link time.

optionals my also have an else branch:

optional {
	require {
		type a, b, c;
	}
	allow {a c} b : file read;
} else {
	#no require for else
	allow foo bar : file read;
}

the else branch will not have a require block, and will use the modules
global scope.

The scoping rules are the same as the initial module work, the global
scope consists of symbols either declared outside of optionals and
symbols in require blocks outside of optionals. Each optional now has
it's own scope which is not shared with any other optional, this
consists of symbols declared inside that block and symbols in the
require blocks inside that optional.

For additional information on Loadable policy modules and the language
syntax please visit

http://sepolicy-server.sourceforge.net/index.php?page=modules
http://sepolicy-server.sourceforge.net/index.php?page=module-overview

More pages will be added shortly.

We believe this syntax is much more friendly to policy writers and would
like any comments or suggestions about the syntax. If this syntax seems
reasonable to everyone we should have a patch to implement it shortly.
Thank you


Joshua Brindle
Tresys Technology


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
